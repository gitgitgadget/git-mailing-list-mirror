Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED1C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 10:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BED520874
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 10:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi32d9KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461923AbgJWKKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461863AbgJWKKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 06:10:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B76C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 03:10:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t9so1133520wrq.11
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LqQHwbxwvjM+IZ0gntaQSbMAtfFcycs2fHN0tZ8KbUw=;
        b=Pi32d9KV7f7B5uVY/fFbF1cOjAusXVzqaDfZHS5IR2Ar/xsG2iB+NB+J+KpjSNJi2P
         /CZtUCyGL0eEU7xEQT3gujCMYXevcwJHwrZgc9wFXBml5kPMS6Wn5geLX/1HlzehDxUf
         dKqouRmkgI17jWIDD4uUZLjUrjdjBheiANqB6k4ugF2nKZU8Rb09GTQma/uMm7dJus6B
         AHglrPOpRWgXvL1Ff+3QjGoTu/1iu/5cW8WGMj9snfhvDlxciZ+Xaj+ZWD/oV9n7O9or
         X5+MPqR6ezbW7cZTBysX4CCftkrrIttwA/92deXgkuZ8pcX7czmY+R72S8yBVnMqySZx
         Dkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LqQHwbxwvjM+IZ0gntaQSbMAtfFcycs2fHN0tZ8KbUw=;
        b=YVZrVHYfK017+hpdutrBhctdG8AeBVpamIIyzradbjYppLANVvagV+7SJUbObiW8zn
         9upmc7RjBhRIpGTbC4aHv6aLYk6oIUd4DvHVZkRWt7QK+ESqVE+3uITqEK/GBKJYrMc/
         WIVZxV8SRTlo1iYKoe+j1orw8as8MKNKBWonJM0mALD4fjxlxnMOMmcwJ+JL6JHODCW/
         W5kNcxrEq2+AJOUQ6xeJl9BUE4j6Gecmprmw06qGRcVmBkGTeWZXoJJQ2s0k1N4f22oj
         pLr6Yc4MSFIDJrgL+WhZbJzpV+22flX+vcXvX48zU4aAPeYR9yO7zQvGeP/b58GlzAEM
         G7yg==
X-Gm-Message-State: AOAM531NywnjFyVkwLP5psRswL7rqxUSX6to+vzgqEwVwioOsKIGj0k1
        ealtbLP9aZucUfWOUjQyisO1cka8x+k=
X-Google-Smtp-Source: ABdhPJyXQu7DN6tSrJR+nrRhlwxbnm1zWaUzaWH/KpigSXp5i5J5o6GweaM/mAyGI1z07zeVpJ6i2g==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr1816115wrt.109.1603447820060;
        Fri, 23 Oct 2020 03:10:20 -0700 (PDT)
Received: from [192.168.1.201] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.googlemail.com with ESMTPSA id d30sm2422766wrc.19.2020.10.23.03.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 03:10:19 -0700 (PDT)
Subject: Re: [PATCH 1/3] t3436: check --committer-date-is-author-date result
 more carefully
To:     Jeff King <peff@peff.net>, VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070843.GA2913115@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <845a14f1-5ce8-2c2f-a847-6d5d1550ba70@gmail.com>
Date:   Fri, 23 Oct 2020 11:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023070843.GA2913115@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

Thanks for fixing this embarrassing mistake and strengthening the tests, 
the first three patches look fine to me. We don't check the committer 
name and email in t4150-am.sh which we probably should do (the rebase 
tests were based on those) though that can wait as some of the rebase 
tests are testing the am implementation.

Thanks again

Phillip

On 23/10/2020 08:08, Jeff King wrote:
> After running "rebase --committer-date-is-author-date", we confirm that
> the committer date is the same as the author date. However, we don't
> look at any other parts of the committer ident line to make sure we
> didn't screw them up. And indeed, there are a few bugs here. Depending
> on the rebase backend in use, we may accidentally use the author email
> instead of the committer's, or even an empty string.
> 
> Let's teach our test_ctime_is_atime helper to check the committer name
> and email, which reveals several failing tests.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   t/t3436-rebase-more-options.sh | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
> index 996e82787e..6f2f49717b 100755
> --- a/t/t3436-rebase-more-options.sh
> +++ b/t/t3436-rebase-more-options.sh
> @@ -65,31 +65,31 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
>   '
>   
>   test_ctime_is_atime () {
> -	git log $1 --format=%ai >authortime &&
> -	git log $1 --format=%ci >committertime &&
> +	git log $1 --format="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> %ai" >authortime &&
> +	git log $1 --format="%cn <%ce> %ci" >committertime &&
>   	test_cmp authortime committertime
>   }
>   
> -test_expect_success '--committer-date-is-author-date works with apply backend' '
> +test_expect_failure '--committer-date-is-author-date works with apply backend' '
>   	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>   	git rebase --apply --committer-date-is-author-date HEAD^ &&
>   	test_ctime_is_atime -1
>   '
>   
> -test_expect_success '--committer-date-is-author-date works with merge backend' '
> +test_expect_failure '--committer-date-is-author-date works with merge backend' '
>   	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>   	git rebase -m --committer-date-is-author-date HEAD^ &&
>   	test_ctime_is_atime -1
>   '
>   
> -test_expect_success '--committer-date-is-author-date works with rebase -r' '
> +test_expect_failure '--committer-date-is-author-date works with rebase -r' '
>   	git checkout side &&
>   	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>   	git rebase -r --root --committer-date-is-author-date &&
>   	test_ctime_is_atime
>   '
>   
> -test_expect_success '--committer-date-is-author-date works when forking merge' '
> +test_expect_failure '--committer-date-is-author-date works when forking merge' '
>   	git checkout side &&
>   	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>   	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
> @@ -145,7 +145,7 @@ test_expect_success '--reset-author-date works with rebase -r' '
>   	test_atime_is_ignored
>   '
>   
> -test_expect_success '--reset-author-date with --committer-date-is-author-date works' '
> +test_expect_failure '--reset-author-date with --committer-date-is-author-date works' '
>   	test_must_fail git rebase -m --committer-date-is-author-date \
>   		--reset-author-date --onto commit2^^ commit2^ commit3 &&
>   	git checkout --theirs foo &&
> 

