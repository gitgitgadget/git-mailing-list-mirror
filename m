Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A151C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiHETfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHETf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 15:35:28 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BBB9FEA
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 12:35:27 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10ea30a098bso3968425fac.8
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JvZO9F1YzcudAKeVzzHms628hwmsCYkyI7A2a0Ze744=;
        b=Ph6EGQ5+ePTPFgnQUQ/Ptwc9udizPzefTavkuhoepMkSWqUspHyU/klbXK68f0xEEF
         FpJWLDhZVd5yT09cE/Dd3BaSgtC1LRq59Hp7Cxw1nMLOXOaeYJ+ncW2YAJ/RvJbANmUy
         dRQtkfroQJ+5bNWIbYvkxBD2fHDfgEnWE/+fm7zetAHj8NtV/VNv47YgN7inudiuu/h0
         CIEsUI64ISjQqbfLI/tQHOhRLt5APYOb+iIkZiViv1mHp1UL4Vkf/JK7aDBzlOdcteq4
         tjkRqr+qUvkPUIcXQ1EqVlyw4hi4fn8zLGeNZ37UyyLC8HhLACKTXAmaVPxg+AuoqMfY
         2SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JvZO9F1YzcudAKeVzzHms628hwmsCYkyI7A2a0Ze744=;
        b=xWtpjfJH+8ITRQl+PxlUDvjY2oVci80PDzo57GFmmOEqoXb0dAKJf9Xm1b45TKqiA2
         5hLokYNzyR6mVTHkMN6EbHbPjyoiiIAFXDgHhnQaH5YROMkY8hy/NZ/C6feIOU120Vsa
         OpXJ05t2mdkqViApMKG/ZUGP8Oqcum2yLTyIYnkpomed4E2NX06M8k9uEd9Z817mT697
         tsJthYdec4DIlpKwuCNEwHEyqFC8Lp+zqsugFjt4kmo2vN68uAgv29RjCUab/Mkiydw9
         j/WPr9H15O101Q6ESolNxlIgxV3mDC0s3XIxwu2wLAaIGuxHTtHOnQLaCEVYZBBGiRZi
         rHcw==
X-Gm-Message-State: ACgBeo22FsFN+73aYtu7bxSSVUfOotgvqNoIKE7wPkeshX+UYO/1HjC8
        VWJ9pnk9hn/ssaNVpl7OJxPi
X-Google-Smtp-Source: AA6agR6476Bpfege2YZkeOYF6nG+80ldKkB7Hd2i+ev/aEvkkIcKP6eIzWqjoMIim5LJDUB9bkTiBA==
X-Received: by 2002:a05:6870:c6a4:b0:10e:585c:ba1a with SMTP id cv36-20020a056870c6a400b0010e585cba1amr3783561oab.41.1659728126411;
        Fri, 05 Aug 2022 12:35:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id v21-20020a0568301bd500b0061c7e5d270bsm870059ota.48.2022.08.05.12.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:35:26 -0700 (PDT)
Message-ID: <3dc402e1-1f27-8a24-544d-d90d403a7da0@github.com>
Date:   Fri, 5 Aug 2022 15:35:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

> +--diagnose[=(basic|all)]::
> +	Create a zip archive of information about the repository including logs

logs? I think the reflogs are not included unless "all" is specified. Perhaps
we can unify this description with the beginning of git-diagnose.txt:

  Collects detailed information about the user's machine, Git client, and
  repository state and packages that information into a zip archive.

resulting in

	Create a zip archive containing information about the user's machine,
	Git client, and repository state.

> +	and certain statistics describing the data shape of the repository. The
> +	archive is written to the same output directory as the bug report and is
> +	named 'git-diagnostics-<formatted suffix>'.
> ++
> +By default, `--diagnose` (equivalent to `--diagnose=basic`) will collect only
> +statistics and summarized data about the repository and filesystem. Specifying
> +`--diagnose=all` will create an archive with the same contents generated by `git
> +diagnose --all`; this archive will be much larger, and will contain potentially
> +sensitive information about the repository. See linkgit:git-diagnose[1] for more
> +details on the contents of the diagnostic archive.

Perhaps here (and git-diagnose.txt) should be really explicit about sharing the
"all" mode output only with trusted parties. Let the user decide what level of
trust is necessary depending on their situation (we don't need to say "open source
repos are fine to share" or something).

> +enum diagnose_mode {
> +	DIAGNOSE_NONE,
> +	DIAGNOSE_BASIC,
> +	DIAGNOSE_ALL
> +};

This enum makes me think that it might be nice to use this in diagnose.h
along with an array that pairs strings with the enum. We could unify the
options by having 'git diagnose --mode=(basic|all)' which could be
extended in the future with another mode that might be in between the two.

It may also be a waste of time to set up that infrastructure without it
actually mattering in the future, but I thought I'd mention it as an
alternative, in case that inspires you.

>  static void get_system_info(struct strbuf *sys_info)
>  {
> @@ -91,6 +97,23 @@ static void get_header(struct strbuf *buf, const char *title)
>  	strbuf_addf(buf, "\n\n[%s]\n", title);
>  }
>  
> +static int option_parse_diagnose(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	enum diagnose_mode *diagnose = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (!arg || !strcmp(arg, "basic"))
> +		*diagnose = DIAGNOSE_BASIC;
> +	else if (!strcmp(arg, "all"))
> +		*diagnose = DIAGNOSE_ALL;

Should we allow "none" to reset the value to DIAGNOSE_NONE?

> +	else
> +		die(_("diagnose mode must be either 'basic' or 'all'"));

I wondered initially if this should be a usage() call instead. But we have
plenty of examples of using die() to report an issue with a single option
or a combination of options.

>  	const struct option bugreport_options[] = {
> +		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("(basic|all)"),
> +			       N_("create an additional zip archive of detailed diagnostics"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, option_parse_diagnose),

The biggest reason for this to be an OPT_CALLBACK_F is because of the
'--diagnose' option (without '='), so an OPT_STRING would not be
appropriate here.

> @@ -119,6 +147,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  					    option_output ? option_output : "");
>  	strbuf_addstr(&report_path, prefixed_filename);
>  	strbuf_complete(&report_path, '/');
> +	output_path_len = report_path.len;

Perhaps this should be renamed to output_dir_len, since we know this is
a directory that will contain all of the output files.

> +	/* Prepare diagnostics, if requested */
> +	if (diagnose != DIAGNOSE_NONE) {
> +		struct strbuf zip_path = STRBUF_INIT;
> +		strbuf_add(&zip_path, report_path.buf, output_path_len);
> +		strbuf_addstr(&zip_path, "git-diagnostics-");
> +		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
> +		strbuf_addstr(&zip_path, ".zip");
> +
> +		if (create_diagnostics_archive(&zip_path, diagnose == DIAGNOSE_ALL))

(Just pausing to say this could be create_diagnostics_archive(&zip_path, diagnose)
if we use the enum inside diagnose.c.

Thanks,
-Stolee
