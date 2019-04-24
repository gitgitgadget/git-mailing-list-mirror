Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D81C1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 07:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfDXHHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 03:07:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65332 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfDXHHX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 03:07:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB90B14090B;
        Wed, 24 Apr 2019 03:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9SeYK/7RFRhxSdRrrRqnNVSg8IE=; b=JJJkjA
        MdLCOus+eujxTZqpZhTOzn1+S0wylNXkGpRmLrHoR5KW1Q7J2Ojj4MFsAZvCrnWu
        y1CMuf7ZSTIWc37XpEgqPud1ZaH9sLmf6lOdJ17t66e9Q+dyNdIwG5RBz9KzrBXV
        Ea14vfNyc9yAAwz0XmLrdMtRgceg2RkXhTQuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XyQkwR71+0OLKVUNxBS/MxKHQrQ2r2vj
        VLf6eECb3tioknrlFECWULyDng2yBFy6aKeYOHHPhg+Ec6oiypR5SOQntSrbytk8
        M+Bc+BmyW8ZFc1KnleI5/UamfHkpG96HAbcRgYjj/EU24eNxpsFcKjY9AgmwyvD/
        vNUJqj7+dsg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2A6B14090A;
        Wed, 24 Apr 2019 03:07:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3188B140907;
        Wed, 24 Apr 2019 03:07:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] t7610: add mergetool --gui tests
References: <cover.1555880168.git.liu.denton@gmail.com>
        <cover.1556009181.git.liu.denton@gmail.com>
        <678f9b11fc7df7d3ee2050388574bcaea86af331.1556009181.git.liu.denton@gmail.com>
Date:   Wed, 24 Apr 2019 16:07:16 +0900
In-Reply-To: <678f9b11fc7df7d3ee2050388574bcaea86af331.1556009181.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 23 Apr 2019 01:53:58 -0700")
Message-ID: <xmqq36m73mqj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9827EFF4-665F-11E9-BAF9-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In 063f2bdbf7 (mergetool: accept -g/--[no-]gui as arguments,
> 2018-10-24), mergetool was taught the --gui option but no tests were
> added to ensure that it was working properly. Add a test to ensure that
> it works.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t7610-mergetool.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index a9fb971615..5f37d7a1ff 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -145,6 +145,28 @@ test_expect_success 'custom mergetool' '
>  	git commit -m "branch1 resolved with mergetool"
>  '
>  
> +test_expect_success 'gui mergetool' '
> +	test_config merge.guitool myguitool &&
> +	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
> +	test_config mergetool.myguitool.trustExitCode true &&
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test$test_count branch1 &&
> +	git submodule update -N &&

> +	test_must_fail git merge master >/dev/null 2>&1 &&
> +	( yes "" | git mergetool --gui both >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool -g file1 file1 ) &&
> +	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&
> +	( yes "d" | git mergetool --gui file11 >/dev/null 2>&1 ) &&
> +	( yes "d" | git mergetool --gui file12 >/dev/null 2>&1 ) &&
> +	( yes "l" | git mergetool --gui submod >/dev/null 2>&1 ) &&

We usually discourage suppressing the output from git commands being
tested like the above via redirection.  This new testlet seems to
mimick the way some of the existing ones are written, but it seems
that not all invocations of mergetool in this file discard the
output.  Is there a particular reason why there are two styles?
If not, I think we would want to standardize on *not* discarding.

Thanks.
