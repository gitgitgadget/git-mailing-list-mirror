Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446AC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiEWTpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 15:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiEWTpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 15:45:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435721113
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:45:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id 11so11076223qtp.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IpjwwxWdAp/5Yr2ymK4xhncTxQTrSf+UZkwG6ojuQ0I=;
        b=ARmQaS9Nv5979XO6iJUk0JH2K0iFE8kiNzqRLUopjZhkPIf/vWwWJbnpkl61obOJbP
         Vn4xuDqtP9tS6h1WH+HsdOQeRyAWY+lkpgy7LbDCsy7PMx266VkungFhjTSAue3Bpzht
         WzAyXvMpRK/tlF9fW8vu7bamSmAj1piDm2Wh4PxwbKpVMvT4AOnRTuHG1TYEcac9altz
         CXE4bOK4O5/nq5hGnB5Q0dY499EIAMi8tlPpdnAyTG9hOdhlInghYTLJUTHExr531snl
         xxzVLaBWZH7Edhx1+aHjf9dW2XFW5tTT8PVxcpmx1cJvZpfCewHWJMqUB1kxAeMEsq6s
         H6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IpjwwxWdAp/5Yr2ymK4xhncTxQTrSf+UZkwG6ojuQ0I=;
        b=AZWk4r/XPSu9+6ORTYj/ZjmBJ8wNJ+p4YJwwTZLWn0gBm7qLgxy0ECWOTdGZL1Nxad
         TUiTzWYpGf46pYV1VT0hxPs0YQpDKgdqkG7lLiH/hqc8WUQMvViFUvk5no9FcKjtTuIg
         8PX4FAbMRLdn9LWiEnuy4cw9kGZyAhb5h436A6LZblgHKx8h33rG4vCy9rJOnslt/Uqo
         BJxdcLM5tY1Ws4/He0JqjHsg9S4cISp1F8UJgAhNLQttju91ok7oP5DMHhQQ7F+9/BvN
         DakaBu5HC2I0bjy72FlNMOLh7w3Z51fFAiJDBzc4uWy62A/po8DOB2dPSmOeoAPvAmFY
         ztCA==
X-Gm-Message-State: AOAM5325Ba4X0tZNsGE5V9n2+QD0kfyH/HGYKmknEixSsgTHhyKyw1Hk
        XUWQWFMoGi0I4hVy69TzjEcT
X-Google-Smtp-Source: ABdhPJwNjazw0qYOCUFS2U4uCfI035mpc+/MQ4i0DaXKz/KUzL/zfkR29lf9bmTDEQP6GQSB6LIeiA==
X-Received: by 2002:a05:622a:118a:b0:2f9:172b:c72f with SMTP id m10-20020a05622a118a00b002f9172bc72fmr15173119qtk.618.1653335140383;
        Mon, 23 May 2022 12:45:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id u124-20020a379282000000b0069fc13ce254sm4944788qkd.133.2022.05.23.12.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:45:40 -0700 (PDT)
Message-ID: <a28047a1-4db2-1638-8b7e-62fcf0b57983@github.com>
Date:   Mon, 23 May 2022 15:45:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] clean: refector to the interactive part of clean
Content-Language: en-US
To:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
 <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
 <7271a285d18604bd77251d586201d31eba1287da.1653286345.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <7271a285d18604bd77251d586201d31eba1287da.1653286345.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/22 2:12 AM, Nadav Goldstein via GitGitGadget wrote:
> From: Nadav Goldstein <nadav.goldstein96@gmail.com>
> 
> moved the code that responsible for presenting the menu options
> (interactive flag) to be handles by the add-menu lib that was added
> in previous commit.

Please see Documentation/SubmittingPatches, specifically the
"present tense" section [1]. 

[1] https://github.com/git/git/blob/f9b95943b68b6b8ca5a6072f50a08411c6449b55/Documentation/SubmittingPatches#L174-L179

> -static int clean_use_color = -1;
> -static char clean_colors[][COLOR_MAXLEN] = {
> -	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
> -	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
> -	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
> -	[CLEAN_COLOR_PLAIN] = GIT_COLOR_NORMAL,
> -	[CLEAN_COLOR_PROMPT] = GIT_COLOR_BOLD_BLUE,
> -	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
> -};
> -
> -
> -static const char *clean_get_color(enum color_clean ix)
> +static const char *clean_get_color(enum color_clean ix, clean_color_settings *clean_colors, int *clean_use_color)

I'm surprised to see changes to add-menu.c in this patch. I
would expect that add-menu.c was written in its correct form
in the first patch and then this patch could focus entirely
on deleting matching code from builtin/clean.c and calling
the API exposed in add-menu.h.

Perhaps this was just an interactive rebase issue? Fixed up
the wrong commit? That happens to me a lot.

There are also a lot of places that refer to "clean" when
you want this API to be abstracted away from 'git clean'.

> \ No newline at end of file
> diff --git a/add-menu.h b/add-menu.h
> index 52e5ccb1800..64f1cbdab9f 100644
> --- a/add-menu.h
> +++ b/add-menu.h
> @@ -1,3 +1,7 @@
> +#include "color.h"
> +
> +typedef char clean_color_settings[][COLOR_MAXLEN];

This typedef also shouldn't reference 'git clean'.

> +
>  #define MENU_OPTS_SINGLETON		01
>  #define MENU_OPTS_IMMEDIATE		02
>  #define MENU_OPTS_LIST_ONLY		04
> @@ -35,7 +39,7 @@ struct menu_stuff {
>  	void *stuff;
>  };
>  
> -void clean_print_color(enum color_clean ix);
> +void clean_print_color(enum color_clean ix, clean_color_settings *clean_colors, int *clean_use_color);
>  
>  /*
>   * Implement a git-add-interactive compatible UI, which is borrowed
> @@ -48,4 +52,4 @@ void clean_print_color(enum color_clean ix);
>   *   - The array ends with EOF.
>   *   - If user pressed CTRL-D (i.e. EOF), no selection returned.
>   */
> -int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, void (*prompt_help_cmd)(int));
> \ No newline at end of file
> +int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff, clean_color_settings *clean_colors, int *clean_use_color, void (*prompt_help_cmd)(int));

There are a lot of instances where your lines are much too
wide. Documentation/CodingGuidelines has a lot of style
requirements, including trying to stay to an 80-character
width. There are a lot of examples in the codebase that
show how to break a method prototype across multiple lines
with tasteful vertical alignment.

> diff --git a/builtin/clean.c b/builtin/clean.c
> index 5466636e666..ef220869851 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -19,6 +19,7 @@
>  #include "pathspec.h"
>  #include "help.h"
>  #include "prompt.h"
> +#include "add-menu.h"
>  
>  static int force = -1; /* unset */
>  static int interactive;
> @@ -39,14 +40,6 @@ static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
>  static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
>  static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
>  
> -enum color_clean {
> -	CLEAN_COLOR_RESET = 0,
> -	CLEAN_COLOR_PLAIN = 1,
> -	CLEAN_COLOR_PROMPT = 2,
> -	CLEAN_COLOR_HEADER = 3,
> -	CLEAN_COLOR_HELP = 4,
> -	CLEAN_COLOR_ERROR = 5
> -};

This removal doesn't seem valuable. I think this color set
should remain in the builtin, especially because it's being
used further down.

Alternatively, the names can be renamed to "MENU_COLOR_..."
to apply to all commands in the add-menu.h API.

>  static const char *color_interactive_slots[] = {
>  	[CLEAN_COLOR_ERROR]  = "error",
> @@ -58,7 +51,7 @@ static const char *color_interactive_slots[] = {
>  };
>  
>  static int clean_use_color = -1;
> -static char clean_colors[][COLOR_MAXLEN] = {
> +static clean_color_settings clean_colors = {
>  	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
>  	[CLEAN_COLOR_HEADER] = GIT_COLOR_BOLD,
>  	[CLEAN_COLOR_HELP] = GIT_COLOR_BOLD_RED,
> @@ -67,36 +60,8 @@ static char clean_colors[][COLOR_MAXLEN] = {
>  	[CLEAN_COLOR_RESET] = GIT_COLOR_RESET,
>  };
>  
> -#define MENU_OPTS_SINGLETON		01
> -#define MENU_OPTS_IMMEDIATE		02
> -#define MENU_OPTS_LIST_ONLY		04
> -
> -struct menu_opts {
> -	const char *header;
> -	const char *prompt;
> -	int flags;
> -};
> -

Generally, the remainder of this patch is primarily
deletions. Although, we could make it be completely
deletions if the API method names are changed (not to
start with "clean_" and then all these calls are
modified in one go:

>  static void prompt_help_cmd(int singleton)
>  {
> -	clean_print_color(CLEAN_COLOR_HELP);
> +	clean_print_color(CLEAN_COLOR_HELP, &clean_colors, &clean_use_color);

Here, we would have something like "menu_print_color()"
instead. To avoid adding too much deletion noise when
making these important changes, we can add MAYBE_UNUSED
to all of the static methods that become unreachable.

After a patch that does that refactor, a diff that only
deletes lines (does not add any) would be very easy to
verify.

Thanks,
-Stolee
