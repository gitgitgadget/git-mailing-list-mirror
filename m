Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5200FC6FD1C
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 15:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjCZPML (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCZPMK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 11:12:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B515BAD
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 08:12:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o32so3631030wms.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679843526;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTJRZ9LGiCZJnoTWXP2FJaLhqdu8gqdAJnH4LHz6oD8=;
        b=Uo11KRqjt3pR5qzGbzei8TTsECRE0ZoHUOZwqnfrdmLcrNpf6MCC8i/dt12a2zygid
         QnvbJi1ZKbOmy1feHzfbQh9r90vR4Ysqbwm8hHOdxMfJAX4gfaqeNKGEmMjlDtzRqhdB
         y4pIIcFCxLs3t4BmtZwSEwPgb2q7UjFeLF/0aXZ9puIgSwbNmTrpt1PsbKIUkrpMIP4s
         Q/T54qVyf7TM/Zuxks9V/aLj+HCYOoM8e7U7H2Im8osMT+b38SfZ7Zd2ZPDSc0O2rRLI
         RG/TAHzuJk27FX4mi3JKJi0ub4IKXCULRkJQ52ERO2J12aCpl6DigVffyi8xJwyK2X3K
         AAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679843526;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTJRZ9LGiCZJnoTWXP2FJaLhqdu8gqdAJnH4LHz6oD8=;
        b=YlUEx7PDGoVZIqSyy7+j0VkIYmdz/+YlJYYcp4xOj2QuFyJ08SKl3A2igo2DrKr0z4
         fq9NsIfDEiVqpnG2tYuuPurVtlnbHZ4/cLtuQaNlhkz4cVhRSMVMfbKdpy8fbrJrg6z7
         P03a4qDXnpF8Bp5RGS67GxFiJ6L/JoX+mkI+Pm0RstAqurSHdRjMX503zcuEV/qaBqI2
         U28iFZZse81eZwcacc3XDTJ9sUsewdDMP2PZW59NjYigl/m9ZD5nYzioufO+uQ/3BgfH
         0uIsz0CS0NvvKJmDrwitJxQiqxwMjz4CZmwu8VIXi6qcgthNFVQrfCuGjh4WAR8sEsH+
         EeAw==
X-Gm-Message-State: AO0yUKVpDyVPEqxJZrl8QpJpMidaAMV+h43SWdSX1K3gwrZsTqK7ACFp
        rhygI885YvKp+RUMvZ/yxiU=
X-Google-Smtp-Source: AK7set+Q7VfpOUUCjRqzaWu8Pa0x64TWvsJ95hLSa/eZesGkLV8mVRNhPJZDnzFg1ziqNUNUX/MLow==
X-Received: by 2002:a7b:ca59:0:b0:3eb:2da5:e19 with SMTP id m25-20020a7bca59000000b003eb2da50e19mr7098843wml.27.1679843526148;
        Sun, 26 Mar 2023 08:12:06 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003edd2ec9f85sm5932478wmp.6.2023.03.26.08.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 08:12:05 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <19ab92b4-6b83-d788-78f2-43a3ec3ec412@dunelm.org.uk>
Date:   Sun, 26 Mar 2023 16:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 0/3] rebase: document, clean up, and introduce a config
 option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com, felipe.contreras@gmail.com
References: <20230320055955.461138-1-alexhenrie24@gmail.com>
 <20230326030636.2635642-1-alexhenrie24@gmail.com>
In-Reply-To: <20230326030636.2635642-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 26/03/2023 04:06, Alex Henrie wrote:
> This patch series introduces a rebase.rebaseMerges config option to
> accommodate users who would like --rebase-merges to be on by default and
> to facilitate turning on --rebase-merges by default without
> configuration in a future version of Git. It also cleans up and
> documents the behavior of the --rebase-merges command line option to
> avoid confusion about how the config option and the command line option
> interact.
> 
> Changes from v8:
> - Add braces around one-line else clause
> - Remove unnecessary change to error message priority

The range-diff looks good to me. This iteration addresses all of my 
outstanding concerns.

Thanks

Phillip

> Thanks to Phillip, Junio, Johannes and Sergey for your feedback on v8.
> 
> Alex Henrie (3):
>    rebase: add documentation and test for --no-rebase-merges
>    rebase: deprecate --rebase-merges=""
>    rebase: add a config option for --rebase-merges
> 
>   Documentation/config/rebase.txt        | 10 ++++
>   Documentation/git-rebase.txt           | 19 ++++---
>   builtin/rebase.c                       | 70 ++++++++++++++++++++------
>   t/t3422-rebase-incompatible-options.sh | 17 +++++++
>   t/t3430-rebase-merges.sh               | 44 ++++++++++++++++
>   5 files changed, 138 insertions(+), 22 deletions(-)
> 
> Range-diff against v8:
> 1:  09fb7c1b74 = 1:  a22b9d0da2 rebase: add documentation and test for --no-rebase-merges
> 2:  a846716a4a = 2:  112fee4833 rebase: deprecate --rebase-merges=""
> 3:  b12a3610ba ! 3:  868899cd6d rebase: add a config option for --rebase-merges
>      @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
>       +		if (opts->config_rebase_merges < 0) {
>       +			opts->config_rebase_merges = 1;
>       +			parse_rebase_merges_value(opts, value);
>      -+		} else
>      ++		} else {
>       +			opts->rebase_cousins = 0;
>      ++		}
>       +		return 0;
>       +	}
>       +
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        		if (ignore_whitespace)
>        			strvec_push(&options.git_am_opts,
>       @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>      - 				break;
>      -
>      - 		if (i >= 0 || options.type == REBASE_APPLY) {
>      --			if (is_merge(&options))
>      --				die(_("apply options and merge options "
>      --					  "cannot be used together"));
>      --			else if (options.autosquash == -1 && options.config_autosquash == 1)
>      -+			if (options.autosquash == -1 && options.config_autosquash == 1)
>      + 					  "cannot be used together"));
>      + 			else if (options.autosquash == -1 && options.config_autosquash == 1)
>        				die(_("apply options are incompatible with rebase.autoSquash.  Consider adding --no-autosquash"));
>       +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
>       +				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
>        			else if (options.update_refs == -1 && options.config_update_refs == 1)
>        				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
>      -+			else if (is_merge(&options))
>      -+				die(_("apply options and merge options "
>      -+					  "cannot be used together"));
>        			else
>      - 				options.type = REBASE_APPLY;
>      - 		}
>       @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>        	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
>        			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
