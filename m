Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269B31F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 09:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbfJRJEw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 05:04:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54596 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbfJRJEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 05:04:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so5326176wmp.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqeq2CWa0SJYauDuM8/THNqluRbaG9h5jrG2vWYK0IQ=;
        b=ifmObITNnX9toSTtSL1rHCQ+Odf8D9mTY3So1y18joF06SEJcEjNJ4bdlw3GI3Yo3N
         UVd9laartKJvQwhbBrIpCfQ/4ErTpkivd0s9F0+vw9GSmyrRVDq8rCvRq5E/j2ljTTDx
         yPBAWJ6BdSwaqqoDHCW22p69TSzL5rLXCi+KGnRjV2Xh0RJgOqBafkWaRyaL/pSH1bk+
         Veh7KIu9Bqr/U52c49DwpwxkANN2CD2VHMTNORHr4ODzm9MEyUH3BDAMuKIK2Ksgv7Wx
         WyNhtm2kJtENzgZdZ87vbPV2Zev2DHzfJdkPBnOiDdVfHkvB/BPJdT6mHfDtJ9aKLRzy
         nCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oqeq2CWa0SJYauDuM8/THNqluRbaG9h5jrG2vWYK0IQ=;
        b=je1RjXQSLkpwilE9qcyw85X34qCWuHLbtrKCp8BVg9G1DZHhpj0H5vkzlZcoNEctbO
         2pZRQtb0VN1bSY/aNRmY+B528BsUMK8P/Lyl497ikBoxsTUBcEe1s6Gb4KIWpObRhk/c
         bev3lAFaq3IKqo89QlQwPhF4hpklN+wrvwjZjfIyvZT2HZs5nSvyvrtIf5wtg7KNa8kt
         87p4EbPSeufcZ1EKiNyf6QGvVPl4RHuuSGqHIxqiHoGUOpCNSGrfhF9bSFBGnNlqn9y6
         yrNS9D5x2tHSdNgrptWJ8tf6K4pIEqi83MHUPAA6A7RBRvyKVGg5GPkEdD6MFOT1X7hI
         /g5A==
X-Gm-Message-State: APjAAAVHS4KGF39RphSAY2y869Y6aQukLBFApRRT4hk6YA5cvsZoYEr6
        LOkHotzsa1UbV1q8fLoSCaw=
X-Google-Smtp-Source: APXvYqxsAdQylMDVBiXhdiJe88PxXK1+LU5E5hvuNSolfpyY49eLw2aYaWYLyC0EDvqdT+4bs9ECDA==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr6589348wmj.169.1571389489424;
        Fri, 18 Oct 2019 02:04:49 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.gmail.com with ESMTPSA id q124sm8927437wma.5.2019.10.18.02.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:04:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/7] autostash: extract read_one() from rebase
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <bbd46ad8d27ab547c8efa6b55c1777becbab7302.1571246693.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <49b1ed2e-b1b9-b593-2657-e59f61925e20@gmail.com>
Date:   Fri, 18 Oct 2019 10:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bbd46ad8d27ab547c8efa6b55c1777becbab7302.1571246693.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 16/10/2019 18:26, Denton Liu wrote:
> Begin the process of lib-ifying the autostash code. In a future commit,
> this will be used to implement `--autostash` in other builtins.
> 
> This patch is best viewed with `--color-moved` and
> `--color-moved-ws=allow-indentation-change`.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   autostash.c      | 12 ++++++++++++
>   autostash.h      |  9 +++++++++
>   builtin/rebase.c | 10 +---------
>   3 files changed, 22 insertions(+), 9 deletions(-)
>   create mode 100644 autostash.c
>   create mode 100644 autostash.h
> 
> diff --git a/autostash.c b/autostash.c
> new file mode 100644
> index 0000000000..a6898e0fda
> --- /dev/null
> +++ b/autostash.c
> @@ -0,0 +1,12 @@
> +#include "git-compat-util.h"
> +#include "autostash.h"
> +#include "gettext.h"
> +#include "strbuf.h"
> +
> +int read_one(const char *path, struct strbuf *buf)
> +{
> +	if (strbuf_read_file(buf, path, 0) < 0)
> +		return error_errno(_("could not read '%s'"), path);
> +	strbuf_trim_trailing_newline(buf);
> +	return 0;
> +}

This looks like it's doing a similar job to read_oneliner() in 
sequencer.c, is it possible to make that public and use it instead? 
(There may be a difference if the file is missing but that function 
already takes a flag so it could probably be modified easily enough.)

Best Wishes

Phillip


> diff --git a/autostash.h b/autostash.h
> new file mode 100644
> index 0000000000..4a8f504f12
> --- /dev/null
> +++ b/autostash.h
> @@ -0,0 +1,9 @@
> +#ifndef AUTOSTASH_H
> +#define AUTOSTASH_H
> +
> +#include "strbuf.h"
> +
> +/* Read one file, then strip line endings */
> +int read_one(const char *path, struct strbuf *buf);
> +
> +#endif
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4a20582e72..9fd7de6b2f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -27,6 +27,7 @@
>   #include "branch.h"
>   #include "sequencer.h"
>   #include "rebase-interactive.h"
> +#include "autostash.h"
>   
>   static char const * const builtin_rebase_usage[] = {
>   	N_("git rebase [-i] [options] [--exec <cmd>] "
> @@ -561,15 +562,6 @@ static const char *state_dir_path(const char *filename, struct rebase_options *o
>   	return path.buf;
>   }
>   
> -/* Read one file, then strip line endings */
> -static int read_one(const char *path, struct strbuf *buf)
> -{
> -	if (strbuf_read_file(buf, path, 0) < 0)
> -		return error_errno(_("could not read '%s'"), path);
> -	strbuf_trim_trailing_newline(buf);
> -	return 0;
> -}
> -
>   /* Initialize the rebase options from the state directory. */
>   static int read_basic_state(struct rebase_options *opts)
>   {
> 
