Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB6C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5C620897
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vgUjQ2Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgJFUuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:50:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51154 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgJFUuN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:50:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C69084B6B;
        Tue,  6 Oct 2020 16:50:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4rreOzYFLoXgupKYawRd04D+G/E=; b=vgUjQ2
        Zck1h1mBdAtLdFa8QA4Kb5PgTKkoqsQvieEVOyG3a28t/6YGbUVPagQdr54XoCVl
        ORiR2mrk0GvrF0ok17p6NLGrEiBqgwofkWYQcJRUwE1buCg+fNthPA77JK/WqYqS
        jqRgrFuN8bnDnVFvqAa6qG6SOIwLStAw6tNqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DWuT0w+hWk9ui2x8gOc7JH3e2fqEhBD0
        jWoDa3WF6EgQsUZqq5XsHtIV8sOkP6iBzjjzBKf3sqV0WP88+7xlGGzOaSzP2C2N
        hJPXfENpjidyp9kDU6JyUqtofqBa1ltVE92E48WlQJ8/+cevpXvXDiDq/U+zTSmK
        UhY2JjaRiNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6227784B6A;
        Tue,  6 Oct 2020 16:50:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA0D184B69;
        Tue,  6 Oct 2020 16:50:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 01/11] t6027: modernise tests
References: <20200901105705.6059-1-alban.gruin@gmail.com>
        <20201005122646.27994-1-alban.gruin@gmail.com>
        <20201005122646.27994-2-alban.gruin@gmail.com>
Date:   Tue, 06 Oct 2020 13:50:09 -0700
In-Reply-To: <20201005122646.27994-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 5 Oct 2020 14:26:36 +0200")
Message-ID: <xmqqwo033wqm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86719B76-0815-11EB-A5CD-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Some tests in t6027 uses a if/then/else to check if a command failed or

s/uses/use/;

> not, but we have the `test_must_fail' function to do it correctly for us
> nowadays.

Makes sense.  The patch text reads good, too.

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  t/t6407-merge-binary.sh | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
> index 4e6c7cb77e..071d3f7343 100755
> --- a/t/t6407-merge-binary.sh
> +++ b/t/t6407-merge-binary.sh
> @@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
>  . ./test-lib.sh
>  
>  test_expect_success setup '
> -
>  	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
>  	git add m &&
>  	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
> @@ -35,33 +34,19 @@ test_expect_success setup '
>  '
>  
>  test_expect_success resolve '
> -
>  	rm -f a* m* &&
>  	git reset --hard anchor &&
> -
> -	if git merge -s resolve master
> -	then
> -		echo Oops, should not have succeeded
> -		false
> -	else
> -		git ls-files -s >current
> -		test_cmp expect current
> -	fi
> +	test_must_fail git merge -s resolve master &&
> +	git ls-files -s >current &&
> +	test_cmp expect current
>  '
>  
>  test_expect_success recursive '
> -
>  	rm -f a* m* &&
>  	git reset --hard anchor &&
> -
> -	if git merge -s recursive master
> -	then
> -		echo Oops, should not have succeeded
> -		false
> -	else
> -		git ls-files -s >current
> -		test_cmp expect current
> -	fi
> +	test_must_fail git merge -s recursive master &&
> +	git ls-files -s >current &&
> +	test_cmp expect current
>  '
>  
>  test_done
