Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9AC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6A611BD
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 10:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFUKTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFUKTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 06:19:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DDC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 03:17:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so1767828wrn.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T4hQZiwV2wctENYGguMGVq5TDz6YnchW3Y+TScVANtg=;
        b=bG43RSHxf7Jxn1Gb6+HLyhhn92zaJBfFh/D4QI+7JquugWtFdLiH/smqEliO+x4jk9
         M4Ik3SF0ApWFMCsv4SM1nIpgEfOfPDXkndg0N2gPFayrJoVkGiiRJAvnHWXHc7MBaAD7
         lVWs6z87HY1QsNAfDgzaR0DM5Wj3f+dxaVj5ogRyzOhpVrd7qs6/iSAi1/tcVW5KxHbx
         nzDtCdHN4bOtC0K5C2lgjdFKvmdcTeXq1Of4zAw9tr4xqAqFQwAC5i3awOfAKG3dzVUu
         dV8hMF6HwGhFM5W6F8HuGhi8dN0/0ljshLo1sC46m3CJ8gEUH401fPfd4J6Sb2B7Pa+d
         XRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T4hQZiwV2wctENYGguMGVq5TDz6YnchW3Y+TScVANtg=;
        b=rEewy4GIXH0XFhClsiEJOqEz3wGUP4KqTUBm1uEAnbwbzFVK7XHye0fAa/FcsV72i9
         EuGte5RBbvxNa2mxSDblcQudfl9ZwMfW7rEkvLAz86FWByaaowMZUSpKKB3YCHfgayNf
         d7A1Rn8PngEehvGg1zUE+mohplraK4Eus4nMtinS/xnoyI/riA+PTrrUpi+3n47fnJdK
         Vu2Sweg/tDIMiA2fX4w8UJU2nFeCSnfUrGpkbDwmsuMjEvoA9g7YwbfbZVtHIbglc0TC
         xUjLbK+f0qn5deNCkhfi5BVnD4vevWmN4JpGrz22k+y6ZPetVntnPQNtQRjMCVfa1Abu
         eKcw==
X-Gm-Message-State: AOAM530cG2HGfKznradPblZX+6SWRhV3gf1/HmcFtzQhzbJ9wHtKqXjK
        TSon/eTG3kbBLcVoz9cLjus=
X-Google-Smtp-Source: ABdhPJx1lofC8+tuHz18A5kf/qtT/IFZ3vCEGu9Ads2dYjhTEKBtdbRdZ2pdyQNP+DvaEpkvBYQzTQ==
X-Received: by 2002:a5d:58cc:: with SMTP id o12mr27360289wrf.384.1624270635762;
        Mon, 21 Jun 2021 03:17:15 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id z6sm13013004wrh.65.2021.06.21.03.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 03:17:15 -0700 (PDT)
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <351215c0-98a9-dc39-1e19-d3d6dbb4bd56@gmail.com>
Date:   Mon, 21 Jun 2021 11:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/06/2021 09:34, Ævar Arnfjörð Bjarmason wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> We already colorize tools traditionally not colorized by default, like
> diff and grep. Let's do the same for man, but only if `color.man` is
> explicitly set to "true".
> 
> Unlike other `color.*` output this colorization is not enabled by
> `color.ui` being true, the user needs to explicitly set the
> `color.man` variable to `true.
> 
> When it was proposed to treat `color.man` like any other `color.*`
> variable some thought that git opting in coloring for an external
> program such as man(1) was a step too far[1], even if the user invoked
> it via the "git help <topic>" wrapper.
> 
> So let's make this explicitly opt-in for now. As noted in the
> documentation we're leaving ourselves an out to turn this on by
> default in the future, or e.g. putting it under the
> feature.experimental umbrella. We probably won't, but let's not
> promise users that `color.man` will forever be a special-case.
> 
> As for what this actually does the effect of having this enabled is
> that a documentation blurb like (some parts elided with "[...]"):
> 
> 	NAME
> 	----
> 	git-config - Get and set [...]
> 
> 	SYNOPSIS
> 	--------
> 	[...]
> 	'git config' [<file-option>] [...]
> 	[...]
> 	The `--type=<type>` option instructs 'git config' to ensure [...]
> 
> Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
> config" and other '-quoted parts in BLUE UNDERLINE instead of
> UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
> instead of BOLD. The "Standout" setting is then used for the user's
> own search bar (invoked with "/") and prompt. See [2] for more
> examples
> 
> Normally check_auto_color() would check the value of `color.pager`, but
> in this particular case it's not git the one executing the pager, but
> man. Therefore we need to check pager_use_color ourselves.
> 
> We do not need to support `color.man` being set to `always`; The `git
> help` command is always run for a tty (it would be very strange for a
> user to do `git help $page > output`, but in fact, that works anyway,
> we don't even need to check if stdout is a tty, but just to be
> consistent we do). So it's simply a boolean in our case.
> 
> So, in order for this change to have any effect:
> 
>   1. color.man=true must be set in the config
>   2. The user must use less
>   3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
>   4. Have color.ui enabled
>   5. Not have color.pager disabled
>   6. Not have git with stdout directed to a file
> 
> 1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
> 2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Thanks for taking the time to write such a clear and comprehensive 
message, I think making this setting opt in for now makes sense. I've 
left a couple of comments below.

> Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Tue, Jun 08 2021, Junio C Hamano wrote:
> 
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> I've been running with this on my personal git build since May 26th. I
>>> haven't had any issues with it, and I like the new coloring.
>>> ...
>>> I think this is a good example of a change that we're better off just
>>> merging down and then reverting if the wider audience of git users hates
>>> it, rather than trying to come to some perfect consensus here
>>> on-list.
>>
>> My impression was tht we already had a rough consensus here on-list
>> that it may be good to educate users who like this "new coloring"
>> like you do to configure their "less", so that they consistently get
>> the "new coloring" they like whether they are doing "git help git",
>> "man git", or even "man ls", and the approach the posted patch takes
>> will not help (it only affects "git help git" among these).
>>
>> I'd rather not to take it.
> 
> Fair enough, here's a version I think you and others will find
> acceptable then. It allows users like me who like this to explicitly
> opt-in via color.man=true.
> 
> I also took the liberty of making some changes to the commit message
> to reword it for this new behavior, and to show an example of the sort
> of colors that change with this patch.
> 
> The only change to the patch itself is that now color_man is set to 0
> by default, not 1. I also moved its declaration so that it's with the
> one other config variable, insted of with the other command-line
> options to "git help".
> 
> Range-diff against v6:
> 1:  e021ca1da21 ! 1:  a950ef49e28 help: colorize man pages
>      @@ Metadata
>       Author: Felipe Contreras <felipe.contreras@gmail.com>
>       
>        ## Commit message ##
>      -    help: colorize man pages
>      +    help: colorize man pages if man.color=true under less(1)
>       
>           We already colorize tools traditionally not colorized by default, like
>      -    diff and grep. Let's do the same for man.
>      -
>      -    Our man pages don't contain many useful colors (just blue links),
>      -    moreover, many people have groff SGR disabled, so they don't see any
>      -    colors with man pages.
>      -
>      -    We can set LESS_TERMCAP variables to render bold and underlined text
>      -    with colors in the pager; a common trick[1].
>      -
>      -    Bold is rendered as red, underlined as blue, and standout (prompt and
>      -    highlighted search) as inverse cyan.
>      -
>      -    Obviously this only works when the less pager is used.
>      -
>      -    If the user already has LESS_TERMCAP variables set in his/her
>      -    environment, those are respected and nothing changes.
>      -
>      -    A new color configuration is added: `color.man` for the people that want
>      -    to turn this feature off, otherwise `color.ui` is respected.
>      -    Additionally, if color.pager is not enabled, this is disregarded.
>      +    diff and grep. Let's do the same for man, but only if `color.man` is
>      +    explicitly set to "true".
>      +
>      +    Unlike other `color.*` output this colorization is not enabled by
>      +    `color.ui` being true, the user needs to explicitly set the
>      +    `color.man` variable to `true.
>      +
>      +    When it was proposed to treat `color.man` like any other `color.*`
>      +    variable some thought that git opting in coloring for an external
>      +    program such as man(1) was a step too far[1], even if the user invoked
>      +    it via the "git help <topic>" wrapper.
>      +
>      +    So let's make this explicitly opt-in for now. As noted in the
>      +    documentation we're leaving ourselves an out to turn this on by
>      +    default in the future, or e.g. putting it under the
>      +    feature.experimental umbrella. We probably won't, but let's not
>      +    promise users that `color.man` will forever be a special-case.
>      +
>      +    As for what this actually does the effect of having this enabled is
>      +    that a documentation blurb like (some parts elided with "[...]"):
>      +
>      +            NAME
>      +            ----
>      +            git-config - Get and set [...]
>      +
>      +            SYNOPSIS
>      +            --------
>      +            [...]
>      +            'git config' [<file-option>] [...]
>      +            [...]
>      +            The `--type=<type>` option instructs 'git config' to ensure [...]
>      +
>      +    Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
>      +    config" and other '-quoted parts in BLUE UNDERLINE instead of
>      +    UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
>      +    instead of BOLD. The "Standout" setting is then used for the user's
>      +    own search bar (invoked with "/") and prompt. See [2] for more
>      +    examples
>       
>           Normally check_auto_color() would check the value of `color.pager`, but
>           in this particular case it's not git the one executing the pager, but
>           man. Therefore we need to check pager_use_color ourselves.
>       
>      -    Also--unlike other color.* configurations--color.man=always does not
>      -    make any sense here; `git help` is always run for a tty (it would be very
>      -    strange for a user to do `git help $page > output`, but in fact, that
>      -    works anyway, we don't even need to check if stdout is a tty, but just
>      -    to be consistent we do). So it's simply a boolean in our case.
>      +    We do not need to support `color.man` being set to `always`; The `git
>      +    help` command is always run for a tty (it would be very strange for a
>      +    user to do `git help $page > output`, but in fact, that works anyway,
>      +    we don't even need to check if stdout is a tty, but just to be
>      +    consistent we do). So it's simply a boolean in our case.
>       
>           So, in order for this change to have any effect:
>       
>      -     1. The user must use less
>      -     2. Not have the same LESS_TERMCAP variables set
>      -     3. Have color.ui enabled
>      -     4. Not have color.pager disabled
>      -     5. Not have color.man disabled
>      -     7. Not have git with stdout directed to a file
>      -
>      -    Fortunately the vast majority of our users meet all of the above, and
>      -    anybody who doesn't would not be affected negatively (plus very likely
>      -    comprises a very tiny minority).
>      +     1. color.man=true must be set in the config
>      +     2. The user must use less
>      +     3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
>      +     4. Have color.ui enabled
>      +     5. Not have color.pager disabled
>      +     6. Not have git with stdout directed to a file
>       
>      -    [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>      +    1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
>      +    2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
>       
>           Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      -    Phillip Wood <phillip.wood123@gmail.com>
>      -    Comments-by: Jeff King <peff@peff.net>
>           Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>      +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## Documentation/config/color.txt ##
>       @@ Documentation/config/color.txt: color.interactive.<slot>::
>      @@ Documentation/config/color.txt: color.interactive.<slot>::
>        	interactive commands.
>        
>       +color.man::
>      -+	This flag can be used to disable the automatic colorizaton of man
>      -+	pages when using the less pager. It's activated only when color.ui
>      -+	allows it, and also when color.pager is on. (`true` by default).
>      ++	This flag can be used to enable the automatic colorizaton of man
>      ++	pages when using the less pager, `false` by default. When set to
>      ++	`true` it's activated only when `color.ui` allows it, and if
>      ++	`color.pager` enable (which it is by default).
>       +
>        color.pager::
>      - 	A boolean to enable/disable colored output when the pager is in
>      - 	use (default is true).
>      + 	A boolean to specify whether `auto` color modes should colorize
>      + 	output going to the pager. Defaults to true; set this to false
>      +@@ Documentation/config/color.txt: color.ui::
>      + 	output not intended for machine consumption to use color, to
>      + 	`true` or `auto` (this is the default since Git 1.8.4) if you
>      + 	want such output to use color when written to the terminal.
>      +++
>      ++When set to `true` certain other `color.*` variables may still not be
>      ++turned on unless explicitly enabled. Currently this only applies to
>      ++`color.man`, see above. Such opt-in variables may be moved under the
>      ++default `color.ui` umbrella in the future.
>       
>        ## builtin/help.c ##
>       @@
>      @@ builtin/help.c
>        
>        #ifndef DEFAULT_HELP_FORMAT
>        #define DEFAULT_HELP_FORMAT "man"
>      -@@ builtin/help.c: static int verbose = 1;
>      - static unsigned int colopts;
>      - static enum help_format help_format = HELP_FORMAT_NONE;
>      - static int exclude_guides;
>      -+static int man_color = 1;
>      - static struct option builtin_help_options[] = {
>      - 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
>      - 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
>      +@@ builtin/help.c: enum help_format {
>      + 	HELP_FORMAT_WEB
>      + };
>      +
>      ++static int man_color;
>      + static const char *html_path;
>      +
>      + static int show_all = 0;
>       @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *page)
>        	}
>        }
> 
>   Documentation/config/color.txt | 11 +++++++++++
>   builtin/help.c                 | 32 +++++++++++++++++++++++++++++++-
>   color.h                        |  1 +
>   3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index e05d520a867..2f12ae3386d 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -126,6 +126,12 @@ color.interactive.<slot>::
>   	or `error`, for four distinct types of normal output from
>   	interactive commands.
>   
> +color.man::
> +	This flag can be used to enable the automatic colorizaton of man
> +	pages when using the less pager, `false` by default. When set to
> +	`true` it's activated only when `color.ui` allows it, and if
> +	`color.pager` enable (which it is by default).

s/and if `color.pager` enable/and `color.pager` is enabled/?

> +
>   color.pager::
>   	A boolean to specify whether `auto` color modes should colorize
>   	output going to the pager. Defaults to true; set this to false
> @@ -200,3 +206,8 @@ color.ui::
>   	output not intended for machine consumption to use color, to
>   	`true` or `auto` (this is the default since Git 1.8.4) if you
>   	want such output to use color when written to the terminal.
> ++
> +When set to `true` certain other `color.*` variables may still not be
> +turned on unless explicitly enabled. Currently this only applies to
> +`color.man`, see above. Such opt-in variables may be moved under the
> +default `color.ui` umbrella in the future.
> diff --git a/builtin/help.c b/builtin/help.c
> index bb339f0fc80..c607da88d78 100644
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
> @@ -34,6 +35,7 @@ enum help_format {
>   	HELP_FORMAT_WEB
>   };
>   
> +static int man_color;
>   static const char *html_path;
>   
>   static int show_all = 0;
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

We take care not to override the user's preference if these variables 
are set individually, but there is a possible corner case where the user 
sets a subset of these LESS_TERMCAP_* because they like the defaults for 
some of them but not others, in that case we wouldn't want to set any of 
them. Whether this is likely to be a problem in practice or not I'm not 
sure. Version 5 [1] of this patch took care not to override the users 
settings in this case.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/20210522011718.541986-1-felipe.contreras@gmail.com/

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
> index 98894d6a175..d012add4e8a 100644
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

