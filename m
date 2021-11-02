Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D842C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F34F60E74
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 10:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKBKUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhKBKUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 06:20:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE13CC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 03:17:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u11so3064018plf.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=djIOObRCvXWMtZMPQMyDEu359RzjbMH6vD8R3erGdkU=;
        b=TDT2WdTlS6IV8k5yyTWTaNLVt9MT3cNWcbs+GkY0DXsBU6T9u47J4FauR4C//X7R9S
         8NqgKfV9WUYwea/U8veCZygFrT+R/bnMJNueRXaEWfe5Y/Ck/Gm2CmMn+iiVQYzpZCx/
         tJD30vXfwbt0KrJspSGAa0DgFWaEGAzHHJC+BFkcLsnT7c5/tjqOrzTBtwBRUfQuxS+9
         BQToSCjL8qkMiTmiN5Yk5vN1uGqiMOkP8p/mMe5zTIYFtYy6N9yBC3lBQZ+0y65ke/ef
         dPGidaTjezduRK0Ek6f6IgFQkAT3d6D75Fq3hRsSgv1smypcSS3OryZpNeq6XtrSBPFd
         p4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=djIOObRCvXWMtZMPQMyDEu359RzjbMH6vD8R3erGdkU=;
        b=KCbivFqKPAMtlIVF08RG3G4lgh64x4GYhJE53UW3XpnWR7cUpZc5+tz4X1bYP0+Pox
         M6tffez/Z7ZhEGinwY12XtvlnJzfZ6KeJvwsuGt/EkAW0+R4lpnY72Il5ZHI71So/A5x
         rqoTOZz27Hq1BQlQjNtIGnm7IMst4r9dqxnuiF2vp7vuCLnZLwsUlUPUGnyxSm4u7r9D
         9v29FLlLbUt+jqbknpRK/Bu9dGo4rwlmjatSNuociS0C2tK5l7u32XO/gM8aKrIZjOki
         HcZYVJIGXUujaEAoIFDHtsa9d/D0pu87q454ekT7DsX8H8TaXCjPSL3WrcMvRyC0s8Hy
         a91w==
X-Gm-Message-State: AOAM532/P86PNDAyrAXY9f1hiJAJMFrHF8kCi7fq6QQX4ZF0s/xi01CG
        vTyOsV1vutn0r9BirnspsOA=
X-Google-Smtp-Source: ABdhPJw1pvLn+DJ//7w+CzcUNEZujJ99w+02inYrhWi4na0D7wbGm/FX7/h1MFmXI5A1tjOcL6MSaw==
X-Received: by 2002:a17:90b:390b:: with SMTP id ob11mr5435617pjb.217.1635848250066;
        Tue, 02 Nov 2021 03:17:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id b15sm13326904pfm.203.2021.11.02.03.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 03:17:29 -0700 (PDT)
Message-ID: <7d9a893e-5dad-bd21-4ef7-6d47303abdc1@gmail.com>
Date:   Tue, 2 Nov 2021 17:17:22 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] i18n: fix typos found during l10n for git 2.34.0
Content-Language: en-US
To:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=c3=adaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
References: <20211031052156.5237-1-worldhello.net@gmail.com>
 <20211101021417.9549-1-worldhello.net@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211101021417.9549-1-worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 15ae406e6b..c23d01de7d 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1486,7 +1486,7 @@ static void rename_tmp_packfile(const char **final_name,
>   		if (!*final_name)
>   			*final_name = odb_pack_name(name, hash, ext);
>   		if (finalize_object_file(curr_name, *final_name))
> -			die(_("unable to rename temporary '*.%s' file to '%s"),
> +			die(_("unable to rename temporary '*.%s' file to '%s'"),
>   			    ext, *final_name);
>   	} else if (make_read_only_if_same) {
>   		chmod(*final_name, 0444);
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 800d8caa67..68d2f29be7 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -775,7 +775,7 @@ static const char *get_default_ssh_signing_key(void)
>   		if (keys[0] && starts_with(keys[0]->buf, "ssh-")) {
>   			default_key = strbuf_detach(keys[0], NULL);
>   		} else {
> -			warning(_("gpg.ssh.defaultKeycommand succeeded but returned no keys: %s %s"),
> +			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
>   				key_stderr.buf, key_stdout.buf);
>   		}
>   

Looks OK.

> diff --git a/ref-filter.c b/ref-filter.c
> index 282cdad103..08a3f839c9 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1037,7 +1037,7 @@ int verify_ref_format(struct ref_format *format)
>   		     format->quote_style == QUOTE_TCL) &&
>   		     used_atom[at].atom_type == ATOM_RAW &&
>   		     used_atom[at].u.raw_data.option == RAW_BARE)
> -			die(_("--format=%.*s cannot be used with"
> +			die(_("--format=%.*s cannot be used with "
>   			      "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
>   		cp = ep + 1;
>   
> 

Why not using \n?

-- 
An old man doll... just what I always wanted! - Clara
