Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E189C00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 06:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiHDG7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiHDG7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 02:59:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8D5A16B
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 23:59:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z22so24129020edd.6
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 23:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=pOACiyMjecjp7ny/p6m4XXeMhf30U9eesAcRAp0yIc0=;
        b=CujfGs791davmS7MIq0jHi3dpCQQ5sKBU5aQgjvrqkHbKObAa+ZIPwy1gzB5I+Hhj8
         Evd4N2V8fBOswLEMSsg8yvG3ZlQznyi/jquUS5ZEjLez3EE4wY8ja407OYqsmMaejsAf
         CbxmXN5Owivqqyx0d2iXaUM9+TV3i1gQ6CJ9/yC8KcT3z4ABxu6UQRPeLJjYSFwHtuVU
         tf67MlrjT02PFMIif4i2Chgm6i3SsxYbPXb/7SNhc2BNpV14cEeFAEICh/tpvmdDR2Tu
         N48A23gi2QQ8qEpY8pqb0YKGFk85MD26egAwhy9/+67253/dTBuqe1IciCz5DwAxVdmy
         69uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pOACiyMjecjp7ny/p6m4XXeMhf30U9eesAcRAp0yIc0=;
        b=WMuD544qp/gPCI4wD8iSY/SfR7twoALySKsbthuLrH5SuCHSv3JsY+Cb5gMnKd4H+r
         kJVCarB/tu5re5e4O/tL2C0LyPZvRiVGiE1bJMauSTxSzVXg8Y/0AaZhd7ouNMcDdI2T
         tEDU44ebz4oS+MfcruvClGnZ7QbUe9lrmyCQCnbb2fQk0BKh0hATF/kfWpETFIpXY2kU
         HR3DlytwKgffLc4cDeKYyuaInF5pFM8b9g1XFfIgLA4vS77m3Uk01XeDpW3hY6OGo5Mj
         aF19qzzcc1rO4fNjCc/q4w22mN3jW/kC+co9rAkge35KkMN/l8UVVkTLjC0gvtmVoJRS
         1dbg==
X-Gm-Message-State: ACgBeo38Nvc6cWLV85jFSZszqz9pw32UMA/LLtgHJZPLUtu8b0+vLFDt
        LIvus4gBs8MZ7/Gsnnag1qw=
X-Google-Smtp-Source: AA6agR69GUvSPYW+5b5yHNX3bnGRtN5l9UCs7mgZZAXIBSrVrHpahqn1+xjSBrNc09vERLxqsEsAlQ==
X-Received: by 2002:a05:6402:278d:b0:43d:cf90:c91a with SMTP id b13-20020a056402278d00b0043dcf90c91amr591735ede.186.1659596357197;
        Wed, 03 Aug 2022 23:59:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b00730223dc5c0sm7546291ejo.206.2022.08.03.23.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:59:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUp9-009eZ4-1y;
        Thu, 04 Aug 2022 08:59:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 09/10] scalar-diagnose: use 'git diagnose --all'
Date:   Thu, 04 Aug 2022 08:54:01 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <6834bdcaea838cc49f209efd785bf2bdf09e9c08.1659577543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6834bdcaea838cc49f209efd785bf2bdf09e9c08.1659577543.git.gitgitgadget@gmail.com>
Message-ID: <220804.86r11webp8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Replace implementation of 'scalar diagnose' with an internal invocation of
> 'git diagnose --all'. This simplifies the implementation of 'cmd_diagnose'
> by making it a direct alias of 'git diagnose' and removes some code in
> 'scalar.c' that is duplicated in 'builtin/diagnose.c'. The simplicity of the
> alias also sets up a clean deprecation path for 'scalar diagnose' (in favor
> of 'git diagnose'), if that is desired in the future.
>
> This introduces one minor change to the output of 'scalar diagnose', which
> is that the prefix of the created zip archive is changed from 'scalar_' to
> 'git-diagnostics-'.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  contrib/scalar/scalar.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> index b10955531ce..fe2a0e9decb 100644
> --- a/contrib/scalar/scalar.c
> +++ b/contrib/scalar/scalar.c
> @@ -11,7 +11,6 @@
>  #include "dir.h"
>  #include "packfile.h"
>  #include "help.h"
> -#include "diagnose.h"
>  
>  /*
>   * Remove the deepest subdirectory in the provided path string. Path must not
> @@ -510,34 +509,20 @@ static int cmd_diagnose(int argc, const char **argv)
>  		N_("scalar diagnose [<enlistment>]"),
>  		NULL
>  	};
> -	struct strbuf zip_path = STRBUF_INIT;
> -	time_t now = time(NULL);
> -	struct tm tm;
> +	struct strbuf diagnostics_root = STRBUF_INIT;
>  	int res = 0;
>  
>  	argc = parse_options(argc, argv, NULL, options,
>  			     usage, 0);
>  
> -	setup_enlistment_directory(argc, argv, usage, options, &zip_path);
> -
> -	strbuf_addstr(&zip_path, "/.scalarDiagnostics/scalar_");
> -	strbuf_addftime(&zip_path,
> -			"%Y%m%d_%H%M%S", localtime_r(&now, &tm), 0, 0);
> -	strbuf_addstr(&zip_path, ".zip");
> -	switch (safe_create_leading_directories(zip_path.buf)) {
> -	case SCLD_EXISTS:
> -	case SCLD_OK:
> -		break;
> -	default:
> -		error_errno(_("could not create directory for '%s'"),
> -			    zip_path.buf);
> -		goto diagnose_cleanup;

Just spotting this now, but we had ad error, but we "goto
diagnose_cleanup", but that will use our "res = 0" above.

Is this untested already or in this series (didn't go back to look). But
maybe a moot point, the post-image replacement uses die()..

> -	}
> +	setup_enlistment_directory(argc, argv, usage, options, &diagnostics_root);
> +	strbuf_addstr(&diagnostics_root, "/.scalarDiagnostics");
>  
> -	res = create_diagnostics_archive(&zip_path, 1);
> +	if (run_git("diagnose", "--all", "-s", "%Y%m%d_%H%M%S",
> +		    "-o", diagnostics_root.buf, NULL) < 0)
> +		res = -1;

The code handling here seems really odd, issues:

 * This *can* return -1, if start_command() fails, but that's by far the
   rarer case, usually it would be 0 or >0 (only <0 if we can't start
   the command at all).

 * You should not be returning -1 from cmd_*() in general (we have
   outstanding issues with it, but those should be fixed). It will yield
   an exit code of 255 (but it's not portable)).

 * If you're going to return -1 at all, why override <0 with -1, just
   "res = run_git(...)" instead?

I think all-in-all this should be:

	res = run_git(...);

Then:

>  
> -diagnose_cleanup:
> -	strbuf_release(&zip_path);
> +	strbuf_release(&diagnostics_root);
>  	return res;

	return res < 0 ? -res : res;

Or whatever.
