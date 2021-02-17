Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984DC433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3573A64E58
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhBQXCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:02:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52110 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQXCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:02:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA8CCB1B09;
        Wed, 17 Feb 2021 18:01:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CaKRKE43Wumlg+LAl6gjh1BMv7I=; b=BF6B1d
        rNsVifvx5YaWfmyIer/g51oC5YbqzxnIc6xqa9Q0p25Ec1FRaFsPg4wE+F4pBHsO
        t5JbuSJrjzjAXQOdTjnz3PdI9DCR/I+C6yD4GhFIpQ7hLTttb6r45RaRIUk9uNCK
        dC+EB8ZrNiX+PybgnTSwr08G83iNRSpavCQbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SXQwLmiXxiRUqJ3vjfpyIZvcmPrZROZ2
        i2VYex4xUwfRRO5cI3TH7dXgMCTjUeCN1lSjUP9HX1mIzPUnXP4ThpVEk6zwEHrN
        M+w2YKFoMnDSWJYnGoIAWs493xquOf859jYkVnjCBwBOZWFqK7BzEUjyKzXyk8qE
        AEDiSlbc7aI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0A5FB1B08;
        Wed, 17 Feb 2021 18:01:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AA7BB1B07;
        Wed, 17 Feb 2021 18:01:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
References: <cover.1613593946.git.matheus.bernardino@usp.br>
        <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
Date:   Wed, 17 Feb 2021 15:01:41 -0800
In-Reply-To: <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 17 Feb 2021 18:02:26 -0300")
Message-ID: <xmqqpn0yi9ii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19715AAC-7174-11EB-9418-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> We already have a couple tests for `add` with SKIP_WORKTREE entries in
> t7012, but these only cover the most basic scenarios. As we will be
> changing how `add` deals with sparse paths in the subsequent commits,
> let's move these two tests to their own file and add more test cases
> for different `add` options and situations. This also demonstrates two
> options that don't currently respect SKIP_WORKTREE entries: `--chmod`
> and `--renormalize`.

Nice.  It makes sense to describe what we want first, like this step..

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t3705-add-sparse-checkout.sh   | 92 ++++++++++++++++++++++++++++++++
>  t/t7012-skip-worktree-writing.sh | 19 -------
>  2 files changed, 92 insertions(+), 19 deletions(-)
>  create mode 100755 t/t3705-add-sparse-checkout.sh
>
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> new file mode 100755
> index 0000000000..5530e796b5
> --- /dev/null
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -0,0 +1,92 @@
> +#!/bin/sh
> +
> +test_description='git add in sparse checked out working trees'
> +
> +. ./test-lib.sh
> +
> +SPARSE_ENTRY_BLOB=""
> +
> +# Optionally take a string for the entry's contents
> +setup_sparse_entry()
> +{

Style.

	setup_sparse_entry () {

on a single line.

> +	if test -f sparse_entry
> +	then
> +		rm sparse_entry
> +	fi &&
> +	git update-index --force-remove sparse_entry &&

Why not an unconditional removal on the working tree side?

	rm -f sparse_entry &&
	git update-index --force-remove sparse_entry &&

Are there cases where we may have sparse_entry directory here?

> +
> +	if test "$#" -eq 1

No need to quote $# (we know it is a number).

> +	then
> +		printf "$1" >sparse_entry

Make sure the test writers know that they are passing a string that
will be interpreted as a printf format.  Review the comment before
the function and adjust it appropriately ("a string" is not what you
want to tell them).

> +	else
> +		printf "" >sparse_entry

Just

		>sparse_entry

is sufficient, no?

> +	fi &&
> +	git add sparse_entry &&
> +	git update-index --skip-worktree sparse_entry &&
> +	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
> +}
> +
> +test_sparse_entry_unchanged() {

Style.

	test_sparse_entry_unchanged () {

> +	echo "100644 $SPARSE_ENTRY_BLOB 0	sparse_entry" >expected &&
> +	git ls-files --stage sparse_entry >actual &&
> +	test_cmp expected actual

OK.  So the expected pattern is to first "setup", do stuff that
shouldn't affect the sparse entry in the index, and then call this
to make sure?

> +}

> +test_expect_success "git add does not remove SKIP_WORKTREE entries" '

We use the term SKIP_WORKTREE and SPARSE interchangeably here.  I
wonder if it is easier to understand if we stick to one e.g. by
saying "... does not remove 'sparse' entries" instead?  I dunno.

> +	setup_sparse_entry &&
> +	rm sparse_entry &&
> +	git add sparse_entry &&
> +	test_sparse_entry_unchanged

Wow.  OK.  Makes a reader wonder what should happen when the two
operations are replaced with "git rm sparse_entry"; let's read on.

> +'
> +
> +test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
> +	setup_sparse_entry &&
> +	rm sparse_entry &&
> +	git add -A &&
> +	test_sparse_entry_unchanged
> +'

OK.  As there is nothing other than sparse_entry in the working tree
or in the index, the above two should be equivalent.

I wonder what should happen if the "add -A" gets replaced with "add .";
it should behave the same way, I think.  Is it worth testing that
case as well, or is it redundant?

> +for opt in "" -f -u --ignore-removal
> +do
> +	if test -n "$opt"
> +	then
> +		opt=" $opt"
> +	fi

The above is cumulative, and as a consequence, "git add -u <path>"
is not tested, but "git add -f -u <path>" is.  Intended?  How was
the order of the options listed in "for opt in ..." chosen?

> +	test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
> +		setup_sparse_entry &&
> +		echo modified >sparse_entry &&
> +		git add $opt sparse_entry &&
> +		test_sparse_entry_unchanged
> +	'
> +done
> +
> +test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
> +	setup_sparse_entry &&
> +	test-tool chmtime -60 sparse_entry &&
> +	git add --refresh sparse_entry &&
> +
> +	# We must unset the SKIP_WORKTREE bit, otherwise
> +	# git diff-files would skip examining the file
> +	git update-index --no-skip-worktree sparse_entry &&
> +
> +	echo sparse_entry >expected &&
> +	git diff-files --name-only sparse_entry >actual &&
> +	test_cmp actual expected

Hmph, I am not sure what we are testing at this point.  One way to
make the final diff-files step show sparse_entry would be for "git
add --refresh" to be a no-op, in which case, the cached stat
information in the index would be different in mtime from the path
in the working tree.  But "update-index --no-skip-worktree" may be
buggy and further change or invalidate the cached stat information
to cause diff-files to report that the path may be different.

> +'
> +
> +test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
> +	setup_sparse_entry &&
> +	git add --chmod=+x sparse_entry &&
> +	test_sparse_entry_unchanged

Hmph.  Should we also check if sparse_entry in the filesystem also
is not made executable, not just the entry in the index?

> +'
> +
> +test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
> +	test_config core.autocrlf false &&
> +	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
> +	echo "sparse_entry text=auto" >.gitattributes &&
> +	git add --renormalize sparse_entry &&
> +	test_sparse_entry_unchanged

Makes sense.

What should "git diff sparse_entry" say at this point, I have to
wonder?

> +'
> +
> +test_done

Thanks.
