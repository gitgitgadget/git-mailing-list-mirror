Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A216211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbeLFW4H (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:56:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52393 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeLFW4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:56:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so2571604wmb.2
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VsHJLn0wePyepoaHKXicd6Cw7tAtiyWCMxYf00pvcY0=;
        b=qB7oEP4dIr2Vl0uVi6Xxt47iBtSxwab7+9xuKDN4Qqbe9x+4hnBBD6baEKu4/ijx7c
         fV0YCe4vXRHPJk7D65lzCUnQa+vZUEPXBaQfpAgfm/seNlUFNZsMTtlt1/0GTugPcXtI
         t29khZj5mI6EFL0blZdflHIhI46o4i8gYMh0/EBz0dxFH1NAb1zjc+2dcEX0nPtV2U5u
         VmsC/hOxZpVepJtR0UzeLlpa7Oxe9+asnxVFDA9Kd9p4uMb+pM5LuFRk0nxs0lqFbW8G
         hz4XCZg/Bit++FHGSHHQaJCu2dVjVMi5reoZIpCP0GSIRbSqWcTWWQgRFYPEAOYt20la
         26EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VsHJLn0wePyepoaHKXicd6Cw7tAtiyWCMxYf00pvcY0=;
        b=LwYaBjz/T9xnNSUkJU1MnnNpSBARTlLWKrWVlbH0bHo8cxIjLlR9SX3axcmk+LoM+G
         UgbPbBVgOPQ961D9DRn7jUj0T2JQrIjJRfX0uAFijwdDdzXBjRi8KNvvoux16fpBtcyt
         U/yfx/2MFyk0cmKm7Gk83jtAM1RvYRXuHT15/3Iq4ELwh8XGshTRO7LY91x6C5wfuwBU
         kJFtvHMl9mt0upLK9DfaBkpjnasEF8uWVm8AUnvMOeCNNxj84FDbAo/UvNIPgBTeM8em
         ZTpCRve/v6PLzyyRkuEIBP0vCXmGIVS9nUEB5Fj+PziBZgskJtuAT4yrwZ10iRRieZrb
         EV9A==
X-Gm-Message-State: AA+aEWb/MGBlUKdodlIvond0AI+IBGb+5LupG1ZvVnvpzDAZgKoiGjly
        yuHmQovC5W/DxBljgKftj2w=
X-Google-Smtp-Source: AFSGD/VV2Obl17Q9RDWY3bl93LLuaZwjoR/AlfpER4vX7Euf4Z0mLfhjoiClq727P5Q6WfGDDbdFCA==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr184675wms.70.1544136964749;
        Thu, 06 Dec 2018 14:56:04 -0800 (PST)
Received: from szeder.dev (x4dbd2bae.dyn.telefonica.de. [77.189.43.174])
        by smtp.gmail.com with ESMTPSA id w16sm2589295wrp.1.2018.12.06.14.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:56:03 -0800 (PST)
Date:   Thu, 6 Dec 2018 23:56:01 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181206225601.GO30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205103454.GJ30222@szeder.dev>
 <20181205213625.GD19936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205213625.GD19936@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 04:36:26PM -0500, Jeff King wrote:
> The signal interrupts the first wait.

Ah, of course.  I'm ashamed to say that this is not the first time I
forget about that...

> > Bash 4.3 or later are strange: I get back the shell prompt immediately
> > after ctrl-C as well, so it doesn't appear to be waiting for all
> > remaining jobs to finish either, but! I don't get any of the progress
> > output from those jobs to mess up my next command.
> 
> Interesting. My bash 4.4 seems to behave the same as dash. It almost
> sounds like the SIGINT is getting passed to the subshells for you.
> Probably not really worth digging into, though.

The subshell does indeed get SIGINT.  I don't know why that happens,
to my understanding that should not happen.

> In case anybody is playing with this and needed to simulate a stress
> failure, here's what I used:
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index b6566003dd..a370cd9977 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1171,4 +1171,11 @@ test_expect_success 'very long name in the index handled sanely' '
>  	test $len = 4098
>  '
>  
> +test_expect_success 'roll those dice' '
> +	case "$(openssl rand -base64 1)" in
> +	z*)
> +		return 1
> +	esac
> +'

Wasteful :)

  test $(($$ % 42)) -ne 0

