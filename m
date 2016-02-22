From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git.c: simplify striping extension of a file in handle_builtin()
Date: Sun, 21 Feb 2016 19:20:12 -0500
Message-ID: <CAPig+cTiZ17Fb-d+9n_F2PM5+4Q4NAc0xC3xVogwv5+P6aCE9A@mail.gmail.com>
References: <1455978468-14387-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git @ vger . kernel . org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:20:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXeEf-0000TW-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 01:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbcBVAUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 19:20:14 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36401 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbcBVAUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 19:20:13 -0500
Received: by mail-vk0-f49.google.com with SMTP id c3so116089170vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 16:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=poDQtIe1/QJ7kNfkQA3pmb6p26mhWGKe3CPXthAjXbA=;
        b=tdNJTlBMbJ3g6xp0yiGlfhNMPPOkaW6uIDd1U38zaERUD0hAplaHCrpDbkrGLlKwWy
         tOPKR+adD3Iws8Rg3fWjbMuim3YJT/lJmHcPVrnG22HW3hoIY36RiOslXONeA9X/7a0y
         9UX3MrC5tk6+zm29Y89oITvh1c4rjriyrP9gBcR9QRsMUsg4tDf2yMIGP53+feTdGXLb
         cjMdjF7Dmq1C4PQzE6wW0U0wG49rdRS+GmIJDOhBKcOJEW48ajj3pkSo6weq3sgsq94M
         I4HU6F5TA0gisrxqAq6UbupXdApj3E0dh6GIAJEiNX61oiQSGBwj5q1gdLLPxLqo8/1F
         UXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=poDQtIe1/QJ7kNfkQA3pmb6p26mhWGKe3CPXthAjXbA=;
        b=COTNFKdBEbz521QL9v6ats09K8eItde3MJF2UOPjxFATjEFKB/r2VPM29FueANTP5P
         pOo8nVT5MgVDbBMZrpCG/1qjpJ2CfYmIixBIgpBNs7858AUIAVQOV9mVA074TihYZ3sb
         a/wMfI5H4frR3SjtRKEaIr8eUAj3V3Wu9dFRUZeW9dagHmpEdyMm5Co37Rz5F6YbnJTw
         FukdUkT18WAbpsqSEY7+X1nOxtpAAw4zg6IzllxneJwlJejK6RmrX2sg2/BxgX8GQ8Ld
         MSsQLcTa//g31uFcRgp2KNBIfub+Ja0nDlsiKtY65Qa0e/38iO/14rYTJAkyuTxGQt4D
         GuNA==
X-Gm-Message-State: AG10YOQuG8U64pF8nIpItNuljK1N+ExKqm63R/eXfUTHsyBGHfnurYVLQ1ngtoLxRhZGMGUlXK0dswNI3EomNw==
X-Received: by 10.31.182.143 with SMTP id g137mr20572671vkf.45.1456100412851;
 Sun, 21 Feb 2016 16:20:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 16:20:12 -0800 (PST)
In-Reply-To: <1455978468-14387-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: TL-YiXKvrdKaXBSUG-P7rWTGZ3o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286855>

On Sat, Feb 20, 2016 at 9:27 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> git.c: simplify striping extension of a file in handle_builtin()

s/striping/stripping/g

(Note the '/g' above.)

The patch itself looks okay.

> The handle_builtin() starts from striping of command extension if
> STRIP_EXTENSION is enabled. Actually STRIP_EXTENSION does not used
> anywhere else.
>
> This patch introduces strip_extension() helper to strip STRIP_EXTENSION
> extension from argv[0] with the strip_suffix() instead of manually
> striping.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> ---
> diff --git a/git-compat-util.h b/git-compat-util.h
> @@ -333,10 +333,6 @@ extern char *gitdirname(char *);
>  #define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
>  #endif
>
> -#ifndef STRIP_EXTENSION
> -#define STRIP_EXTENSION ""
> -#endif
> -
>  #ifndef has_dos_drive_prefix
>  static inline int git_has_dos_drive_prefix(const char *path)
>  {
> diff --git a/git.c b/git.c
> index 087ad31..6cc0c07 100644
> --- a/git.c
> +++ b/git.c
> @@ -509,21 +509,25 @@ int is_builtin(const char *s)
>         return !!get_builtin(s);
>  }
>
> +#ifdef STRIP_EXTENSION
> +static void strip_extension(const char **argv)
> +{
> +       size_t len;
> +
> +       if (strip_suffix(argv[0], STRIP_EXTENSION, &len))
> +               argv[0] = xmemdupz(argv[0], len);
> +}
> +#else
> +#define strip_extension(cmd)
> +#endif
> +
>  static void handle_builtin(int argc, const char **argv)
>  {
> -       const char *cmd = argv[0];
> -       int i;
> -       static const char ext[] = STRIP_EXTENSION;
> +       const char *cmd;
>         struct cmd_struct *builtin;
>
> -       if (sizeof(ext) > 1) {
> -               i = strlen(argv[0]) - strlen(ext);
> -               if (i > 0 && !strcmp(argv[0] + i, ext)) {
> -                       char *argv0 = xstrdup(argv[0]);
> -                       argv[0] = cmd = argv0;
> -                       argv0[i] = '\0';
> -               }
> -       }
> +       strip_extension(argv);
> +       cmd = argv[0];
>
>         /* Turn "git cmd --help" into "git help cmd" */
>         if (argc > 1 && !strcmp(argv[1], "--help")) {
> --
> 2.5.0
