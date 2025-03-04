Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D21FCFCE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124497; cv=none; b=s0lVt4M9Q8am1nRNMKO5PxdhoD6R+Nko/atYxr10AZbdIlA19aYX4xmLzNvD9QMg5nWqExlWOT6cgRVTtR0BPldy901BQPdYH5/Fdak0CfKImfOqbwr2ce817IU1Ebn9eJLRSCtgadu1dy25fkFLY1k6BiPBDyx0PhAg+JZKylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124497; c=relaxed/simple;
	bh=6h9nvnEMXKSW46Ek8o/HvO4v0usOw0UoFPm83zD5Zqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jp72HMNOGU9LD9qW7LsBSnXi0ccte9WcoDnnTiGa1rIJBm+fPHzz1ndrdEh4abdCS4tmWHOdL6vDgqSPcaLqGb5eEI315tbue197sqsjelf1PZRgQE/TQgeeOyar7qO41mHxDwBmL6hlkXHJUOh0accLquRQs5A6soRRU5DdKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7bfttVq; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7bfttVq"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e46ebe19489so4448512276.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 13:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741124495; x=1741729295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJcd9MrI+l2xqYbsbcbVhjJMv8bkCh7uwKaFDc8R92s=;
        b=l7bfttVqKgFzfdlzW4lBiMFN18Kdv7MliSw9Ws3QIj6F4/urAFil3xZEV8gJF/PGoa
         dDFQOQRealZQtcDk8wLTVYNdvEW2WEwme60nB0sBMRM838niR8kUwqT3gtBXd4JiHoSN
         HcYQOQlat/Izsp6gfivuW0P7hbVAf6/fZXmt3ErsZ5m32mdAvh9kPxXYyUf86J/yoL7e
         jiaEFplv582vqwItHhWAU5VttKO6RyTJBA9tvV87oK/Mv2mmqOEESZWWDcDxpqTwK1rx
         rs0R9L5hvtlaWOlQtDjNuZlILoWGCi9aXbRgp3wx+OdpOVDE4lD2OO9CXO2fbQ3qK8/O
         wWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741124495; x=1741729295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJcd9MrI+l2xqYbsbcbVhjJMv8bkCh7uwKaFDc8R92s=;
        b=UkeN1vHd+lBDARKTjpaQ4Oyrx7STiWsb4WE8e8jdCnF/NMwQT8RDQIb9v+wZaE/sha
         MYm8C5bj33gYLg+kBkUSYiRH1JsUMKVOLY2JszKS6kzxhHKWKUY310basRO7J5ko5Usb
         5tZs+xvqdjHZn/Im++EpW0+CIIBFg705Ooi4Xdd92qhO7hlOh0pjhllczhlHZPXmu3K7
         PPAsEr5LEyNgZABhWOrY9DsP6g9H4SYCeFBXUs13DhY1c9a317GCj3BLwewBbUU3U3iO
         XDJ4SPoPHCt4krx9bG31cOluDtHpKVmWLzfQXckEwDlkwM9YBOGyPV1A10Jxp1vzQIwr
         aZKw==
X-Gm-Message-State: AOJu0YziKzuGI2Etn3KXaRJrrIJw3L69v0KD4Ld2hPJXlqUag7DlMb8T
	X7uv7cvXuqPQlKc5bp3nOpZvajNhpIRnV5uUZIryitr+eE4RYJGsD6aOLN1kEcnaBBjkZi1NKNs
	4+bJMMDbmDf3RHSoOTohAFMrZZw/qyhGJ2UQ=
X-Gm-Gg: ASbGncuDjTsFRr4aaoesqsvu+uvavwu58CyT8Re8rYBYxGteKNDTYpRYWdcus7L61GQ
	o/8XIRWwOBjZMJKt0FeJ28YthCg+MftsFFktBmCVFMBMpE6kftPh1/0FnWI5gX3DBgZGm9mITyp
	aYzV6WUN7A6emwzCplDMqm8fk+sw==
X-Google-Smtp-Source: AGHT+IFxcbicyo+SfoqhIBn3uABuHuk1eazBLYl0N9VX/i69SI4Gntrokr4UZHNcVYDLcNFQOBp95iTV7AEWaC+VWl8=
X-Received: by 2002:a05:6902:288e:b0:e5b:1389:bbd4 with SMTP id
 3f1490d57ef6-e611e1fa530mr1338669276.17.1741124494877; Tue, 04 Mar 2025
 13:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com> <pull.1852.v2.git.1739801702034.gitgitgadget@gmail.com>
In-Reply-To: <pull.1852.v2.git.1739801702034.gitgitgadget@gmail.com>
From: Chris Howlett <chowlett09@gmail.com>
Date: Tue, 4 Mar 2025 21:41:23 +0000
X-Gm-Features: AQ5f1Jp0OvSjW7MbXQoFbCp3dmI4xDG5ja4FQnvSJe3hY5IYjQQbnHt4Bv6n_HI
Message-ID: <CAJVagJm36-Z8CtdDFgFXgQfmqGCD7i2rufoErGUc_ou2094How@mail.gmail.com>
Subject: Re: [PREVIEW v2] help: add prompt-yes setting for autocorrect
To: Chris Howlett via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"

I've not seen any interaction with this patch since I posted it a
couple of weeks ago. Has it slipped under the radar, or is there no
interest in the change?

Thanks!
Chris.

On Mon, 17 Feb 2025 at 14:15, Chris Howlett via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Chris Howlett <chowlett09@gmail.com>
>
> The help.autocorrect functionality is really useful, saving frustration
> when a dev fat-fingers a command, and git has a pretty good idea what
> was originally intended. The config settings are a nice selection, with
> "prompt" asking the user to confirm that they want to run the assumed
> command.
>
> However, with "prompt", the choice defaults to "No" - that is, hitting
> return will _not_ run the command. For me at least, if git is confident
> it knows which command I wanted, it's usually right, and the golden path
> would be to run the command.
>
> Therefore this patch adds "prompt-yes" as a counterpart config setting
> for help.autocorrect, which does the same as "prompt", but defaults to
> "Yes" - hitting return will run the assumed command.
>
> I have not added any tests because the test suite doesn't have any tests
> (that I could find) for the "prompt" behaviour - I'm assuming this is
> because it's hard/impossible to simulate the interactive terminal prompt
>
> Signed-off-by: Chris Howlett <chowlett09@gmail.com>
> ---
>     Add prompt-yes config setting for help.autocorrect
>
>     Changes since v1:
>
>      * PR rebased against master and fixed up, to account for e21bf2c and
>        e4542d8
>
>     ------------------------------------------------------------------------
>
>     This is my first patch request to git - please do let me know if I
>     should be doing something differently!
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1852%2Fasilano%2Fautocorrect-allow-prompt-default-yes-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1852/asilano/autocorrect-allow-prompt-default-yes-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1852
>
> Range-diff vs v1:
>
>  1:  b87c772089e ! 1:  cade4f1719e help: add prompt-yes setting for autocorrect
>      @@ Commit message
>
>           Signed-off-by: Chris Howlett <chowlett09@gmail.com>
>
>      - ## Documentation/config/help.txt ##
>      -@@ Documentation/config/help.txt: help.autoCorrect::
>      + ## Documentation/config/help.adoc ##
>      +@@ Documentation/config/help.adoc: immediately.
>        deciseconds (0.1 sec).
>      -   - "immediate": run the suggested command immediately.
>      +   - "never": don't run or show any suggested command.
>          - "prompt": show the suggestion and prompt for confirmation to run
>       -the command.
>       +the command. The default choice at the prompt is "No"
>       +  - "prompt-yes": show the suggestion and prompt for confirmation to run
>       +the command. The default choice at the prompt is "Yes"
>      -   - "never": don't run or show any suggested command.
>
>        help.htmlPath::
>      +  Specify the path where the HTML documentation resides. File system paths
>
>        ## help.c ##
>       @@ help.c: struct help_unknown_cmd_config {
>         struct cmdnames aliases;
>        };
>
>      -+#define AUTOCORRECT_PROMPT_YES (-4)
>      ++#define AUTOCORRECT_PROMPT_YES (-5)
>      + #define AUTOCORRECT_SHOW (-4)
>        #define AUTOCORRECT_PROMPT (-3)
>        #define AUTOCORRECT_NEVER (-2)
>      - #define AUTOCORRECT_IMMEDIATELY (-1)
>      -@@ help.c: static int git_unknown_cmd_config(const char *var, const char *value,
>      -                  cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
>      -          } else if (!strcmp(value, "prompt")) {
>      -                  cfg->autocorrect = AUTOCORRECT_PROMPT;
>      -+         } else if (!strcmp(value, "prompt-yes")) {
>      -+                 cfg->autocorrect = AUTOCORRECT_PROMPT_YES;
>      -          } else {
>      -                  int v = git_config_int(var, value, ctx->kvi);
>      -                  cfg->autocorrect = (v < 0)
>      +@@ help.c: static int parse_autocorrect(const char *value)
>      +
>      +  if (!strcmp(value, "prompt"))
>      +          return AUTOCORRECT_PROMPT;
>      ++ if (!strcmp(value, "prompt-yes"))
>      ++         return AUTOCORRECT_PROMPT_YES;
>      +  if (!strcmp(value, "never"))
>      +          return AUTOCORRECT_NEVER;
>      +  if (!strcmp(value, "immediate"))
>       @@ help.c: char *help_unknown_cmd(const char *cmd)
>         if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
>                 cfg.autocorrect = AUTOCORRECT_NEVER;
>
>
>  Documentation/config/help.adoc |  4 +++-
>  help.c                         | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/help.adoc b/Documentation/config/help.adoc
> index b369589cec9..69b13b119f1 100644
> --- a/Documentation/config/help.adoc
> +++ b/Documentation/config/help.adoc
> @@ -18,7 +18,9 @@ immediately.
>  deciseconds (0.1 sec).
>          - "never": don't run or show any suggested command.
>          - "prompt": show the suggestion and prompt for confirmation to run
> -the command.
> +the command. The default choice at the prompt is "No"
> +        - "prompt-yes": show the suggestion and prompt for confirmation to run
> +the command. The default choice at the prompt is "Yes"
>
>  help.htmlPath::
>         Specify the path where the HTML documentation resides. File system paths
> diff --git a/help.c b/help.c
> index 8d91afe851d..2a25882af02 100644
> --- a/help.c
> +++ b/help.c
> @@ -552,6 +552,7 @@ struct help_unknown_cmd_config {
>         struct cmdnames aliases;
>  };
>
> +#define AUTOCORRECT_PROMPT_YES (-5)
>  #define AUTOCORRECT_SHOW (-4)
>  #define AUTOCORRECT_PROMPT (-3)
>  #define AUTOCORRECT_NEVER (-2)
> @@ -570,6 +571,8 @@ static int parse_autocorrect(const char *value)
>
>         if (!strcmp(value, "prompt"))
>                 return AUTOCORRECT_PROMPT;
> +       if (!strcmp(value, "prompt-yes"))
> +               return AUTOCORRECT_PROMPT_YES;
>         if (!strcmp(value, "never"))
>                 return AUTOCORRECT_NEVER;
>         if (!strcmp(value, "immediate"))
> @@ -650,6 +653,9 @@ char *help_unknown_cmd(const char *cmd)
>         if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
>                 cfg.autocorrect = AUTOCORRECT_NEVER;
>
> +       if ((cfg.autocorrect == AUTOCORRECT_PROMPT_YES) && (!isatty(0) || !isatty(2)))
> +               cfg.autocorrect = AUTOCORRECT_IMMEDIATELY;
> +
>         if (cfg.autocorrect == AUTOCORRECT_NEVER) {
>                 fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
>                 exit(1);
> @@ -738,6 +744,15 @@ char *help_unknown_cmd(const char *cmd)
>                         if (!(starts_with(answer, "y") ||
>                               starts_with(answer, "Y")))
>                                 exit(1);
> +               } else if (cfg.autocorrect == AUTOCORRECT_PROMPT_YES) {
> +                       char *answer;
> +                       struct strbuf msg = STRBUF_INIT;
> +                       strbuf_addf(&msg, _("Run '%s' instead [Y/n]? "), assumed);
> +                       answer = git_prompt(msg.buf, PROMPT_ECHO);
> +                       strbuf_release(&msg);
> +                       if (starts_with(answer, "n") ||
> +                             starts_with(answer, "N"))
> +                               exit(1);
>                 } else {
>                         fprintf_ln(stderr,
>                                    _("Continuing in %0.1f seconds, "
>
> base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
> --
> gitgitgadget
