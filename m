Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C6C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 13:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDKNXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDKNXS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 09:23:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970721BC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:23:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso9344722wmr.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681219396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V/tyZuUoqkVAS3fxC9biSnfoEkfiM5Q9LhTLvy8/xcY=;
        b=kScAdTTjSF7mW3Ol03N1C20Z1TSyY0ip55v0lqnSa7OCK45CjZeT+F1B0iEKZUT0NW
         t+eM5ptOuLFZhtm27rzA86Yl/noUEooRlS+j4JqAcVstwmOLNfK7UeLK1pWXbRqRSI7m
         D4UzcchOByiMJn7Yu/9H0rodWJ03C6/SPwmKGv82JZx623CMFtJxvfVa/Lbr7Ho4R1tc
         0JzeugtX1Ma8Nd4WBuId23zAHfuFr3bDOAuReQB0/a0V3iMxoXPY3aa4yOvKkyo5ql8f
         ePpqwF3uffPlAKwywvB8DX48aodO/8+Wt06cnEM2zh5MWi7BMJIgm1wMNfVVh6qn1jhx
         Li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681219396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/tyZuUoqkVAS3fxC9biSnfoEkfiM5Q9LhTLvy8/xcY=;
        b=fxy0niS080vcFHj4Gz5dKs/1Zozo/ShDb7tSoDA45b2qE/PR1Co4oEqTYHpj1xq2Pr
         ihEMsDUPM6w5mznJPdYZe1LRVGjI69srD8iBzf1xiKnCo6KGcgJv5JuHn9uGGVeaCinO
         IG0jKoJ5suWQyvQmqj364qjtE99NZvhi6fPGHcTY7AhnE25WZvf7OjhD44845nWxw1wZ
         8XMNKtWFUtkBpeOiNk40DIQ8AuA69YVf1doXZk1s08qyGR0lQVOgf7IMzAS5TC6lqEU9
         qwMwaqjbrygtCopAv4NSsjAqRMuRhsW1exRuI1q4vhCphtjzOc+d7m5R81uuBRomuou4
         aeJg==
X-Gm-Message-State: AAQBX9cnKDKAaTOHTZ07XuLnfrdeoCSj2mZDgpDQ19XC2SFvE5MK/kRI
        7Xq1F2dSH86ebrWT7K/s5L4=
X-Google-Smtp-Source: AKy350bivZnvJl7vXHB16geZ0I8f7GDBE30wRu5H8REJHruYr8RXIfmaL5yQ47vao1RJWVAqxLXwQQ==
X-Received: by 2002:a1c:7914:0:b0:3f0:4428:9445 with SMTP id l20-20020a1c7914000000b003f044289445mr6768220wme.14.1681219395817;
        Tue, 11 Apr 2023 06:23:15 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id y16-20020a05600c365000b003ee58e8c971sm16917985wmq.14.2023.04.11.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:23:15 -0700 (PDT)
Message-ID: <79a7c59f-6644-1dad-3b85-fe0ca8beb968@gmail.com>
Date:   Tue, 11 Apr 2023 14:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] send-email: export patch counters in validate environment
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <20230411114723.89029-1-robin@jarry.cc>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230411114723.89029-1-robin@jarry.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin

On 11/04/2023 12:47, Robin Jarry wrote:
> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When one of the patches depends on a previous one, it
> may not be possible to use this hook in a meaningful way. A hook that
> wants to check some property of the whole series needs to know which
> patch is the final one.
> 
> Expose the current and total number of patches to the hook via the
> GIT_SENDEMAIL_PATCH_COUNTER and GIT_SENDEMAIL_PATCH_TOTAL environment
> variables so that both incremental and global validation is possible.
> 
> Sharing any other state between successive invocations of the validate
> hook must be done via external means. For example, by storing it in
> a GIT_DIR/SENDEMAIL_VALIDATE file.
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---
> 
> Notes:
>      Follow up on:
>      https://lore.kernel.org/git/9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com/
>      
>      As suggested by Phillip, this is a less intrusive change which allows
>      validating whole series. Let me know what you think.

This is certainly less intrusive, if it does what you need and is 
efficient enough for your needs then I'd be inclined to go with this 
approach.

>   Documentation/githooks.txt | 10 ++++++++++
>   git-send-email.perl        |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 62908602e7be..55f00e0f6f8c 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -600,6 +600,16 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
>   non-zero status causes `git send-email` to abort before sending any
>   e-mails.
>   
> +The following environment variables are set when executing the hook.
> +
> +`GIT_SENDEMAIL_PATCH_COUNTER`::
> +	A 1-based counter incremented by one for every file.
> +
> +`GIT_SENDEMAIL_PATCH_TOTAL`::
> +	The total number of files.
> +
> +These variables can be used to validate patch series.
> +
>   fsmonitor-watchman
>   ~~~~~~~~~~~~~~~~~~
>   
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 07f2a0cbeaad..e962d5e15983 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -795,10 +795,17 @@ sub is_format_patch_arg {
>   @files = handle_backup_files(@files);
>   
>   if ($validate) {
> +	my $num = 1;
> +	my $num_patches = @files;
>   	foreach my $f (@files) {
>   		unless (-p $f) {
> +			$ENV{GIT_SENDEMAIL_PATCH_COUNTER} = "$num";
> +			$ENV{GIT_SENDEMAIL_PATCH_TOTAL} = "$num_patches";

We only need to set this once outside the loop

>   			validate_patch($f, $target_xfer_encoding);
> +			delete $ENV{GIT_SENDEMAIL_PATCH_COUNTER};
> +			delete $ENV{GIT_SENDEMAIL_PATCH_TOTAL};

Do we really need to clear these? Certainly not in each iteration of the 
loop I would think.

Best Wishes

Phillip
>   		}
> +		$num += 1;
>   	}
>   }
>   

