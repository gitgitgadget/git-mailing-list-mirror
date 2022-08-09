Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C83BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 23:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiHIXxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHIXxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 19:53:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118E7FE79
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 16:53:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ha11so13185691pjb.2
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tDKfvTPBBevBZePsh6iE0dRT72vXwGuLHRcw5mr6vSI=;
        b=QOnY3sHZmwb116MocnvUJmfQHJY99mJ3rsch1KH36ek4xG+PwQMEm9KBVrrPk5gcIk
         VMT7BumzoKMlhTLDEknmS8P95Qw/zkmip0tIWwLTwi8a+CKWKbamJ/ZGbQr2M7fyNsh1
         rm3LG0923oG19+aFln5jAgO5+3hmpkotn79UQl/pNjvsd+2vdrU+kgYV1nipUc+Z6t+/
         0IlWzIp+Vxq3FpQRhDqIB2ExnkBUNH7QweK281KdaqDs2iGQ3iMaH0mK7UqO+fTCDfhW
         9d6+Wj6bFQlVDK4YTbONmINo4mZ0xoLY67gW8EBjkE7MXhou42Cyu6SKhxHvN+f/q9dy
         NCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tDKfvTPBBevBZePsh6iE0dRT72vXwGuLHRcw5mr6vSI=;
        b=em4Bx35gowEgKVO3oALCfLCMeVRzf4RIj9hHzEPAZ3ED8jl0m8ynUyT591WU6PpDt1
         txcDAT4+O0z0J/c0D+Mnexgj+oA4MrKtNL1O/847M/2fL9vMuPFX9pskeCuxOBxqAsmO
         5b3Uml/1dl+LHV/tnn0jQ2bNfzwfjOzoxfwOtjm4s+ciYW5yFH4s0q/TDK6lzFMqck4G
         eei4cBctnbY5OT2TePAqAwws/rzCOseTD+cS0hJ4gAJnEzs1/AmXZe09SfT6Vo3A5zNC
         MvAMuo/tLTzYm3tZzU9LCZKiCvuts9+mNpKJXc/Kt18yu9cbx0NMov7gp9Rh9aOzJx59
         ICTw==
X-Gm-Message-State: ACgBeo3vAOpN6KUlFKzrhZac6AcMnXqlZmqC+EK78VKBks/mTFA5odkt
        6gEGEt1VTZCk6z0IRxMDGshcfpBPNgGn
X-Google-Smtp-Source: AA6agR7xoltuLo4MlCM55XxlB43zzxNfr4OWuKP3bRjrOvYpKKX5pWH+lrU5oAuMn07992qV7higiw==
X-Received: by 2002:a17:902:7e43:b0:170:cc72:5176 with SMTP id a3-20020a1709027e4300b00170cc725176mr8713268pln.1.1660089198912;
        Tue, 09 Aug 2022 16:53:18 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b28-20020aa78edc000000b0052d78e73e6asm443724pfr.184.2022.08.09.16.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 16:53:18 -0700 (PDT)
Message-ID: <a45f5693-7186-2953-6620-3f1359a12238@github.com>
Date:   Tue, 9 Aug 2022 16:53:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/10] builtin/bugreport.c: create '--diagnose' option
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <d81e7c10997e9e8dc211d241019fbafa6b25fb04.1659577543.git.gitgitgadget@gmail.com>
 <3dc402e1-1f27-8a24-544d-d90d403a7da0@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <3dc402e1-1f27-8a24-544d-d90d403a7da0@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 8/3/2022 9:45 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
> 
>> +--diagnose[=(basic|all)]::
>> +	Create a zip archive of information about the repository including logs
> 
> logs? I think the reflogs are not included unless "all" is specified. Perhaps
> we can unify this description with the beginning of git-diagnose.txt:
> 
>   Collects detailed information about the user's machine, Git client, and
>   repository state and packages that information into a zip archive.
> 
> resulting in
> 
> 	Create a zip archive containing information about the user's machine,
> 	Git client, and repository state.
> 

[...]

>> +	and certain statistics describing the data shape of the repository. The
>> +	archive is written to the same output directory as the bug report and is
>> +	named 'git-diagnostics-<formatted suffix>'.
>> ++
>> +By default, `--diagnose` (equivalent to `--diagnose=basic`) will collect only
>> +statistics and summarized data about the repository and filesystem. Specifying
>> +`--diagnose=all` will create an archive with the same contents generated by `git
>> +diagnose --all`; this archive will be much larger, and will contain potentially
>> +sensitive information about the repository. See linkgit:git-diagnose[1] for more
>> +details on the contents of the diagnostic archive.
> 
> Perhaps here (and git-diagnose.txt) should be really explicit about sharing the
> "all" mode output only with trusted parties. Let the user decide what level of
> trust is necessary depending on their situation (we don't need to say "open source
> repos are fine to share" or something).

Both of these documentation suggestions make sense to me; I'll update
accordingly in V3.

> 
>> +enum diagnose_mode {
>> +	DIAGNOSE_NONE,
>> +	DIAGNOSE_BASIC,
>> +	DIAGNOSE_ALL
>> +};
> 
> This enum makes me think that it might be nice to use this in diagnose.h
> along with an array that pairs strings with the enum. We could unify the
> options by having 'git diagnose --mode=(basic|all)' which could be
> extended in the future with another mode that might be in between the two.
> 
> It may also be a waste of time to set up that infrastructure without it
> actually mattering in the future, but I thought I'd mention it as an
> alternative, in case that inspires you.

Your suggestion is more extensible than the boolean "include_everything" I'm
using right now in 'create_diagnostics_archive()'. I'll incorporate it into
my next re-roll, thanks!

> 
>>  static void get_system_info(struct strbuf *sys_info)
>>  {
>> @@ -91,6 +97,23 @@ static void get_header(struct strbuf *buf, const char *title)
>>  	strbuf_addf(buf, "\n\n[%s]\n", title);
>>  }
>>  
>> +static int option_parse_diagnose(const struct option *opt,
>> +				 const char *arg, int unset)
>> +{
>> +	enum diagnose_mode *diagnose = opt->value;
>> +
>> +	BUG_ON_OPT_NEG(unset);
>> +
>> +	if (!arg || !strcmp(arg, "basic"))
>> +		*diagnose = DIAGNOSE_BASIC;
>> +	else if (!strcmp(arg, "all"))
>> +		*diagnose = DIAGNOSE_ALL;
> 
> Should we allow "none" to reset the value to DIAGNOSE_NONE?

As far as I can tell, while some builtins have options that  match the
default behavior of the command (e.g., '--no-autosquash' in 'git rebase'),
those options typically exist to override a config setting (e.g.,
'rebase.autosquash'). No config exists for 'bugreport --diagnose' (and I
don't think it would make sense to add one), so '--diagnose=none' would only
be used to override another '--diagnose' specification in the same
command/alias (e.g., 'git bugreport --diagnose=basic --diagnose=none'). 

That use case seems unlikely, but if there's precedent or use cases I'm not
accounting for, I'm happy to add the option.

> 
>> +	else
>> +		die(_("diagnose mode must be either 'basic' or 'all'"));
> 
> I wondered initially if this should be a usage() call instead. But we have
> plenty of examples of using die() to report an issue with a single option
> or a combination of options.

After looking at other 'OPT_CALLBACK_F' examples (e.g., the 'diff_opt_stat'
options in 'diff.c'), I think this should at least change to 'return
error(<something>)' to get a more appropriate return code (129):

	else
		return error(_("invalid --%s mode '%s'"), opt->long_name, arg);

I also looked into using 'usage_msg_opt()' to print both an error message
and the usage string, but doing so would require making the 'bugreport'
options structure & variables static so they're accessible by
'option_parse_diagnose()'. If you think it would be valuable to include that
information, I'll add an extra refactoring patch to include it.

> 
>>  	const struct option bugreport_options[] = {
>> +		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("(basic|all)"),
>> +			       N_("create an additional zip archive of detailed diagnostics"),
>> +			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, option_parse_diagnose),
> 
> The biggest reason for this to be an OPT_CALLBACK_F is because of the
> '--diagnose' option (without '='), so an OPT_STRING would not be
> appropriate here.
> 
>> @@ -119,6 +147,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>>  					    option_output ? option_output : "");
>>  	strbuf_addstr(&report_path, prefixed_filename);
>>  	strbuf_complete(&report_path, '/');
>> +	output_path_len = report_path.len;
> 
> Perhaps this should be renamed to output_dir_len, since we know this is
> a directory that will contain all of the output files.

Agreed, 'path' is a bit ambiguous and 'dir' more clearly refers to the
directory containing the output files. 

> 
>> +	/* Prepare diagnostics, if requested */
>> +	if (diagnose != DIAGNOSE_NONE) {
>> +		struct strbuf zip_path = STRBUF_INIT;
>> +		strbuf_add(&zip_path, report_path.buf, output_path_len);
>> +		strbuf_addstr(&zip_path, "git-diagnostics-");
>> +		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
>> +		strbuf_addstr(&zip_path, ".zip");
>> +
>> +		if (create_diagnostics_archive(&zip_path, diagnose == DIAGNOSE_ALL))
> 
> (Just pausing to say this could be create_diagnostics_archive(&zip_path, diagnose)
> if we use the enum inside diagnose.c.
> 
> Thanks,
> -Stolee

