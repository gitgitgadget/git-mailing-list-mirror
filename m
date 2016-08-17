Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0A91FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbcHQTJa (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 15:09:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752435AbcHQTJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 15:09:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BB2A36A5F;
	Wed, 17 Aug 2016 15:09:28 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kjf0JnZCbC7wcV3w3TLReMIIwaA=; b=mIgLiE
	1WgIELIxs/cnmvLAkFSAb2NVbKoW3ooxt2evHSYI0WrznxUx7IgqhE3+H7fCBOTz
	4e2pxs8DeAZdC6BqitD3ctHnAvHakgVZbkp6WYUtQ9gcTMERfl+KLjw/ShMNm9fM
	LLrxL/Cw74vFzo/OBPoScgw2qCqRbFBfK7icg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYSlgJEAiC8Uz6Vau5cDr7Y1eoVhdZg1
	wQuDgLxShEv/JmUKvcYHvB7ymBbOk2To0/3pbO4q2+luICZ+PqoN1kLBkYwhG5M6
	5Jk9RwveGL5tDOgS8udW1Ha5vSYaAx36XRmp8AQYOPPJ+Q32GNeTDeXchuJvKZ3q
	zBgSlRy4mAI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73E0936A5E;
	Wed, 17 Aug 2016 15:09:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B857236A5D;
	Wed, 17 Aug 2016 15:09:27 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v2 1/3] diff-highlight: add some tests.
References: <20160817153124.7770-1-henderson.bj@gmail.com>
	<20160810085635.GA1672@starla>
	<20160817153124.7770-2-henderson.bj@gmail.com>
Date:	Wed, 17 Aug 2016 12:09:25 -0700
In-Reply-To: <20160817153124.7770-2-henderson.bj@gmail.com> (Brian Henderson's
	message of "Wed, 17 Aug 2016 08:31:22 -0700")
Message-ID: <xmqqziob8b6i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E5ABA72-64AE-11E6-AD87-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> writes:

> Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
> ---
>  contrib/diff-highlight/Makefile                  |  5 ++
>  contrib/diff-highlight/t/Makefile                | 22 ++++++++
>  contrib/diff-highlight/t/t9400-diff-highlight.sh | 62 +++++++++++++++++++++
>  contrib/diff-highlight/t/test-diff-highlight.sh  | 69 ++++++++++++++++++++++++
>  4 files changed, 158 insertions(+)
>  create mode 100644 contrib/diff-highlight/Makefile
>  create mode 100644 contrib/diff-highlight/t/Makefile
>  create mode 100755 contrib/diff-highlight/t/t9400-diff-highlight.sh
>  create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

I am not sure test-diff-highlight.sh should be there; the function
definitions would still be useful but move them to the beginning of
t9400-diff-highlight.sh perhaps?

> diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
> new file mode 100644
> index 0000000..b866259
> --- /dev/null
> +++ b/contrib/diff-highlight/Makefile
> @@ -0,0 +1,5 @@
> +# nothing to build
> +all:;

Drop ';'.

> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> new file mode 100755
> index 0000000..8eff178
> --- /dev/null
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -0,0 +1,62 @@
> +#!/bin/sh
> +
> +test_description='Test diff-highlight'
> +
> +. ./test-diff-highlight.sh
> +. "$TEST_DIRECTORY"/test-lib.sh
> +
> +# PERL is required, but assumed to be present, although not necessarily modern
> +# some tests require 5.8
> +test_expect_success PERL 'name' 'true'

If the platform lacks PERL prerequisite, this will simply be
skipped, and if the platform has it, it will always succeed.

I am not sure what you are trying to achieve by having this line
here.

> +test_expect_success 'diff-highlight does not highlight whole line' '
> +	dh_test \
> +		"aaa\nbbb\nccc\n" \
> +		"aaa\n000\nccc\n"
> +'

Hmm, does this express the desired outcome, or just document the
current (possibly broken--I dunno) behaviour?  The same question for
the next one.

> +test_expect_success 'diff-highlight does not highlight mismatched hunk size' '
> +	dh_test \
> +		"aaa\nbbb\n" \
> +		"aaa\nb0b\nccc\n"
> +'

> +dh_test() {

Style: "dh_test () {"

The other functions in this file share the same.

> +	dh_diff_test "$@" &&
> +	dh_commit_test "$@"
> +}
> +
> +dh_diff_test() {
> +	a="$1" b="$2"
> +
> +	printf "$a" >file
> +	git add file
> +
> +	printf "$b" >file
> +	git diff file >diff.raw
> +
> +	if test $# -eq 3
> +	then
> +		# remove last newline
> +		head -n5 diff.raw | test_chomp_eof >diff.exp

A reader can see "remove last newline" by seeing test_chomp_eof and
what it does without a comment, but it is totally unclear why you
need to remove.  The comment that says what it does without saying
why it does it is useless.

> +		printf "$3" >>diff.exp
> +	else
> +		cat diff.raw >diff.exp
> +	fi
> +
> +	<diff.raw "$DIFF_HIGHLIGHT" >diff.act &&

Even though this is technically kosher, I do not see a merit of
deviating from the common practice of starting a line with the
command, i.e.

	"$DIFF_HIGHLIGHT" <diff.raw >diff.actual

would be much easier to read.

> +	test -s diff.act &&

Why?  If you always have the expected output that you are going to
compare with, wouldn't that sufficient to do that test without this?
Besides, having "test -s" means that you can never make sure that a
certain pair of input does not show any changes.  Perhaps drop it?

> +	diff diff.exp diff.act

Use test_cmp unless there is a strong reason why you shouldn't?

> +}
> +
> +dh_commit_test() {
> +	a="$1" b="$2"
> +
> +	printf "$a" >file
> +	git add file
> +	git commit -m"Add a file" >/dev/null

Avoid sticking a short-option to its argument, i.e.

    git commit -m "Add a file"

> +
> +	printf "$b" >file
> +	git commit -am"Update a file" >/dev/null

Likewise.

    git commit -a -m "Update a file"

The remainder of the file invites the same set of questions and
comments you see for dh_diff_test() above, so I won't repeat them.

Thanks.
