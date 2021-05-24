Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE6C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1971F613AD
	for <git@archiver.kernel.org>; Mon, 24 May 2021 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEXNPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhEXNPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 09:15:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE2C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 06:13:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so28541819wrr.2
        for <git@vger.kernel.org>; Mon, 24 May 2021 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+OOUyNOQUIEuAaxCYYqC4n93EkAvhh64RSzYX1eSFwE=;
        b=lOL8ptdZ7r9CUgVonelssMey9GGF9gju5S6LtGek/gnV6Yv1qQ6UU95BJKnhyg/5gd
         0GXfbBQ65XZlkXmRIqLOrHVE6FX0xbwnboIlqf41/BzCMshxbv1IJ2JkUN5j7pWQCHAN
         c1iM7qNDjYw6UiZ9c6EjAg8OBUf74rJvmn01hKYn0tq37rASJpfure8o2Z9sqApPiH1w
         +O4biqHL7obbMqOke2ALYKnmLB4CrknVpib+01IZNCGZRj7ZX5+CCrYsuTpbiXZ2YMdt
         q/pM1rJWQRsp+TDl3aPQiDGCw8gMdYyOGCEppeaCTQZCCBHVy0gIKTiP3dT7has15OWu
         2mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+OOUyNOQUIEuAaxCYYqC4n93EkAvhh64RSzYX1eSFwE=;
        b=phRdkw/5BEGbK3NZZ/yhaomZzBXF2fzi7R/fPhgGilmFrgUkugzK9aCa7VkMTnLGoL
         E1SAZvqB4XR76WKfCC6D5qaRrc+pzxrGcveNAx03n6uQR1cZrGBtqBnxKDKKT5VMBWmc
         NDK/Kz82Um88yi/ZfMO4X6zTnT79o2LISb26DiX8rba03To9bBJW62VLFH8c25ZsKeP3
         9ro/fMEKlvK0SJ3CSrg5dw+hdvs3h1fa7YOLJEjnF827To0rtDvQWN7+o/qPDAsabbww
         3/BHcWySZIsQELhYIsbEPKRNQBrtPmOj7lReQInpwLcKksa7IUS1bzH4qmPXzBFX7mHB
         cSKA==
X-Gm-Message-State: AOAM531jBnmdPPZudL70r/zl6v1cBoGbDMa/O6yUCwywVPnFdmki97Jn
        +B5PRPdpviApuvVJVUdmmUEPqRmMa7s=
X-Google-Smtp-Source: ABdhPJzVjwfsmhuys0g5vpf8BH2r4ia5CIAgFrFLTq1QCca8el8d4s5NUvlMa4hADjqstSQGnI8a1g==
X-Received: by 2002:a5d:444c:: with SMTP id x12mr7456437wrr.161.1621862034689;
        Mon, 24 May 2021 06:13:54 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id q186sm7774709wme.20.2021.05.24.06.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:13:54 -0700 (PDT)
Subject: Re: [PATCH v6] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7644ac29-2a65-e186-ff40-630dd500e160@gmail.com>
Date:   Mon, 24 May 2021 14:13:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210523054454.1188757-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/2021 06:44, Felipe Contreras wrote:
> We already colorize tools traditionally not colorized by default, like
> diff and grep. Let's do the same for man.
> 
> Our man pages don't contain many useful colors (just blue links),
> moreover, many people have groff SGR disabled, so they don't see any
> colors with man pages.
> 
> We can set LESS_TERMCAP variables to render bold and underlined text
> with colors in the pager; a common trick[1].
> 
> Bold is rendered as red, underlined as blue, and standout (prompt and
> highlighted search) as inverse cyan.
> 
> Obviously this only works when the less pager is used.
> 
> If the user already has LESS_TERMCAP variables set in his/her
> environment, those are respected and nothing changes.
> 
> A new color configuration is added: `color.man` for the people that want
> to turn this feature off, otherwise `color.ui` is respected.
> Additionally, if color.pager is not enabled, this is disregarded.
> 
> Normally check_auto_color() would check the value of `color.pager`, but
> in this particular case it's not git the one executing the pager, but
> man. Therefore we need to check pager_use_color ourselves.
> 
> Also--unlike other color.* configurations--color.man=always does not
> make any sense here; `git help` is always run for a tty (it would be very
> strange for a user to do `git help $page > output`, but in fact, that
> works anyway, we don't even need to check if stdout is a tty, but just
> to be consistent we do). So it's simply a boolean in our case.
> 
> So, in order for this change to have any effect:
> 
>   1. The user must use less
>   2. Not have the same LESS_TERMCAP variables set
>   3. Have color.ui enabled
>   4. Not have color.pager disabled
>   5. Not have color.man disabled
>   7. Not have git with stdout directed to a file
> 
> Fortunately the vast majority of our users meet all of the above, and
> anybody who doesn't would not be affected negatively (plus very likely
> comprises a very tiny minority).
> 
> [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
> 
> Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Phillip Wood <phillip.wood123@gmail.com>

This footer seems to have got broken between v5 and v6 - were you 
intending to delete it (which is fine by me) as my comments were about 
the approach of the last patch?

I'm still not convinced that git should be messing with the appearance 
of man pages but I don't think we're ever going to agree on that.

Best Wishes

Phillip

> Comments-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> 
> I returned back to the LESS_TERMCAP variables because -D options only
> exists for non-dos systems since 2021.
> 
> I tested this with a version of less that is 10 years old, and everything
> works as expected.
> 
> Also, I noticed less already chooses nice colors for standout with
> --use-color, and the prompt color is cyan, which is the fist one
> visible, so I changed standout to cyan.
> 
> Range-diff against v5:
> 1:  64c93d501f ! 1:  3a3e2837ad help: colorize man pages
>      @@ Commit message
>           moreover, many people have groff SGR disabled, so they don't see any
>           colors with man pages.
>       
>      -    We can set the LESS variable to render bold, underlined, and standout
>      -    text with colors in the less pager.
>      +    We can set LESS_TERMCAP variables to render bold and underlined text
>      +    with colors in the pager; a common trick[1].
>       
>           Bold is rendered as red, underlined as blue, and standout (prompt and
>      -    highlighted search) as inverse magenta.
>      +    highlighted search) as inverse cyan.
>       
>           Obviously this only works when the less pager is used.
>       
>      -    If the user has already set the LESS variable in his/her environment,
>      -    that is respected, and nothing changes. The same if any LESS_TERMCAP_*
>      -    variables are set.
>      +    If the user already has LESS_TERMCAP variables set in his/her
>      +    environment, those are respected and nothing changes.
>       
>           A new color configuration is added: `color.man` for the people that want
>           to turn this feature off, otherwise `color.ui` is respected.
>      @@ Commit message
>           So, in order for this change to have any effect:
>       
>            1. The user must use less
>      -     2. Not have the LESS variable set
>      +     2. Not have the same LESS_TERMCAP variables set
>            3. Have color.ui enabled
>            4. Not have color.pager disabled
>            5. Not have color.man disabled
>      @@ Commit message
>           anybody who doesn't would not be affected negatively (plus very likely
>           comprises a very tiny minority).
>       
>      +    [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>      +
>           Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>           Phillip Wood <phillip.wood123@gmail.com>
>           Comments-by: Jeff King <peff@peff.net>
>      @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
>       +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
>       +		return;
>       +
>      -+	/* User already has configured less colors */
>      -+	if (getenv("LESS_TERMCAP_md") ||
>      -+		getenv("LESS_TERMCAP_us") ||
>      -+		getenv("LESS_TERMCAP_so")) {
>      -+		return;
>      -+	}
>      -+
>       +	/* Disable groff colors */
>       +	setenv("GROFF_NO_SGR", "1", 0);
>       +
>      -+	/* Add red to bold, blue to underline, and magenta to standout */
>      -+	/* No visual information is lost */
>      -+	setenv("LESS", "Dd+r$Du+b$Ds+m", 0);
>      ++	/* Bold */
>      ++	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
>      ++	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
>      ++
>      ++	/* Underline */
>      ++	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
>      ++	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
>      ++
>      ++	/* Standout */
>      ++	setenv("LESS_TERMCAP_so", GIT_COLOR_CYAN GIT_COLOR_REVERSE, 0);
>      ++	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
>       +}
>       +
>        static void exec_man_man(const char *path, const char *page)
>      @@ builtin/help.c: static int git_help_config(const char *var, const char *value, v
>        }
>        
>        static struct cmdnames main_cmds, other_cmds;
>      +
>      + ## color.h ##
>      +@@ color.h: struct strbuf;
>      + #define GIT_COLOR_FAINT		"\033[2m"
>      + #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
>      + #define GIT_COLOR_REVERSE	"\033[7m"
>      ++#define GIT_COLOR_UNDERLINE	"\033[4m"
>      +
>      + /* A special value meaning "no color selected" */
>      + #define GIT_COLOR_NIL "NIL"
> 
>   Documentation/config/color.txt |  5 +++++
>   builtin/help.c                 | 32 +++++++++++++++++++++++++++++++-
>   color.h                        |  1 +
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index d5daacb13a..11278b7f72 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -126,6 +126,11 @@ color.interactive.<slot>::
>   	or `error`, for four distinct types of normal output from
>   	interactive commands.
>   
> +color.man::
> +	This flag can be used to disable the automatic colorizaton of man
> +	pages when using the less pager. It's activated only when color.ui
> +	allows it, and also when color.pager is on. (`true` by default).
> +
>   color.pager::
>   	A boolean to enable/disable colored output when the pager is in
>   	use (default is true).
> diff --git a/builtin/help.c b/builtin/help.c
> index bb339f0fc8..b6331afc2e 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -11,6 +11,7 @@
>   #include "config-list.h"
>   #include "help.h"
>   #include "alias.h"
> +#include "color.h"
>   
>   #ifndef DEFAULT_HELP_FORMAT
>   #define DEFAULT_HELP_FORMAT "man"
> @@ -43,6 +44,7 @@ static int verbose = 1;
>   static unsigned int colopts;
>   static enum help_format help_format = HELP_FORMAT_NONE;
>   static int exclude_guides;
> +static int man_color = 1;
>   static struct option builtin_help_options[] = {
>   	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>   	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
> @@ -253,10 +255,33 @@ static void exec_man_konqueror(const char *path, const char *page)
>   	}
>   }
>   
> +static void colorize_man(void)
> +{
> +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
> +		return;
> +
> +	/* Disable groff colors */
> +	setenv("GROFF_NO_SGR", "1", 0);
> +
> +	/* Bold */
> +	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
> +	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
> +
> +	/* Underline */
> +	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
> +	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
> +
> +	/* Standout */
> +	setenv("LESS_TERMCAP_so", GIT_COLOR_CYAN GIT_COLOR_REVERSE, 0);
> +	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
> +}
> +
>   static void exec_man_man(const char *path, const char *page)
>   {
>   	if (!path)
>   		path = "man";
> +
> +	colorize_man();
>   	execlp(path, "man", page, (char *)NULL);
>   	warning_errno(_("failed to exec '%s'"), path);
>   }
> @@ -264,6 +289,7 @@ static void exec_man_man(const char *path, const char *page)
>   static void exec_man_cmd(const char *cmd, const char *page)
>   {
>   	struct strbuf shell_cmd = STRBUF_INIT;
> +	colorize_man();
>   	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
>   	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
>   	warning(_("failed to exec '%s'"), cmd);
> @@ -371,8 +397,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
>   	}
>   	if (starts_with(var, "man."))
>   		return add_man_viewer_info(var, value);
> +	if (!strcmp(var, "color.man")) {
> +		man_color = git_config_bool(var, value);
> +		return 0;
> +	}
>   
> -	return git_default_config(var, value, cb);
> +	return git_color_default_config(var, value, cb);
>   }
>   
>   static struct cmdnames main_cmds, other_cmds;
> diff --git a/color.h b/color.h
> index 98894d6a17..d012add4e8 100644
> --- a/color.h
> +++ b/color.h
> @@ -51,6 +51,7 @@ struct strbuf;
>   #define GIT_COLOR_FAINT		"\033[2m"
>   #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
>   #define GIT_COLOR_REVERSE	"\033[7m"
> +#define GIT_COLOR_UNDERLINE	"\033[4m"
>   
>   /* A special value meaning "no color selected" */
>   #define GIT_COLOR_NIL "NIL"
> 

