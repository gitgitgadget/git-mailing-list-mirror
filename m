Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C98C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C16320758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 19:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbkFF0IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgESTAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESTAb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 15:00:31 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA6C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:00:31 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so775049qkh.2
        for <git@vger.kernel.org>; Tue, 19 May 2020 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GXKXoEL3+HVwK+FcoEHP0n+FnFSAh00ZKFELtn1IYys=;
        b=dbkFF0IHuLs3izASBVo22tJaT8P7Pph7ewOtrs27UDRxThJ00Q0u8/e39VuHHw/4JE
         DxWKvQm7wPedw/slCnY7fSYFf1HUsJcusV8Isf+NBkMG6MrcxJVsFm7WgSsnr2SVw8az
         kbgY9Ha2DZO+M9qA4KGrEYf5z3G+ey8jEy93qB3ijYiuSBEWNBBADVqFrhfpSBsKuaLA
         MFhSH7zgJ00TmbEgn5sEScQmxDlkND4KaxP+nkSTjxEw5nST27pTydeQMXRkpEEDSXFy
         ZhIYfaqDHpIx9dXQjru3obQF/60Abw3BZhKXKv5HcRjt4nOqz5nlhzVWWAbuds9dFLEb
         7x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXKXoEL3+HVwK+FcoEHP0n+FnFSAh00ZKFELtn1IYys=;
        b=ERHUqLcquudsySzStD4r48sdqsY2oUxMsLFPVixY3QCAyJ9xD0ecQgRCIPRgguQDxj
         Z+s1TQ3pFen665k1ppRYOU/NygWDkxiiUm5se2Qvq7UXVjQ6P3hu/Y64v/A8LmHQF2au
         S5hFschlc9yTC108Hluyfgyzn5bUm4Hup1yBEq6zHk0dnL4I0EVaB19LP3a6LFlL/eBh
         ZKTbTaxFsH83rGEwQBYqsfmv9jm3qn1l4/KTnWjFvqF5bgvCyf2quTNsuaojHK8M1goG
         o19tJccgoJqK3zFH3MNbZK5HwRP0xQoBw4WzHezFMGGH0HB/Pti0aaHxyoBfzu/CQeQm
         Gprg==
X-Gm-Message-State: AOAM532Wl0KmzIfT3yU8VbC8qg6NuoodYRDqHUrAjwGnwyVCdYfJObaI
        97hUqyWaudmASrTU7dGVXn07C1rYsYQ=
X-Google-Smtp-Source: ABdhPJxp2o961aSZGGGqBnzwhi0Lz3WQHOMh5HsTk1WG4brG7AMS88cUDnYxG76kChs/ECwaG40WHw==
X-Received: by 2002:a05:620a:21ca:: with SMTP id h10mr944162qka.198.1589914830213;
        Tue, 19 May 2020 12:00:30 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p10sm277122qkm.121.2020.05.19.12.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:00:29 -0700 (PDT)
Subject: Re: [PATCH] t4067: make rename detection test output raw diff
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200519183151.46138-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f15b2d01-2486-57d5-d332-3214ae0609fa@gmail.com>
Date:   Tue, 19 May 2020 15:00:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200519183151.46138-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2020 2:31 PM, Jonathan Tan wrote:
> 95acf11a3d ("diff: restrict when prefetching occurs", 2020-04-07) taught
> diff to prefetch blobs in a more limited set of situations. These
> limited situations include when the output format requires blob data,
> and when inexact rename detection is needed.
> 
> There is an existing test case that tests inexact rename detection, but
> it also uses an output format that requires blob data, resulting in the
> inexact-rename-detection-only code not being tested. Update this test to
> use the raw output format, which does not require blob data.
> 
> Thanks to Derrick Stolee for noticing this lapse in code coverage and
> for doing the preliminary analysis [1].
> 
> [1] https://lore.kernel.org/git/853759d3-97c3-241f-98e1-990883cd204e@gmail.com/
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Stolee. Yes, we were never in a situation where there are any
> missing objects at the point of inexact rename detection (despite having
> a test exactly for this), but this situation is possible, and I've
> updated the test so that we encounter this situation.

Thanks for finding the test bug!

> ---
>  t/t4067-diff-partial-clone.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> index c1ed1c2fc4..ef8e0e9cb0 100755
> --- a/t/t4067-diff-partial-clone.sh
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -125,8 +125,8 @@ test_expect_success 'diff with rename detection batches blobs' '
>  
>  	# Ensure that there is exactly 1 negotiation by checking that there is
>  	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> -	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
> -	grep "similarity index" out &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD >out &&
> +	grep ":100644 100644.*R[0-9][0-9][0-9].*b.*c" out &&

--raw definitely does rename detection and I understand the need
to adjust your grep command here.

Thanks,
-Stolee


