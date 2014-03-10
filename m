From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] status: allow NULL fmt for status_printf/status_vprintf_ln
Date: Mon, 10 Mar 2014 16:13:44 -0400
Message-ID: <CAPig+cTzVO1kJCM0zTiDza+Na4PHeLpAr1dvqsXxfbmpy-egHA@mail.gmail.com>
References: <1394479647-22361-1-git-send-email-benoit.pierre@gmail.com>
	<1394479647-22361-2-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6a5-0007V2-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbaCJUNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:13:45 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:52181 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbaCJUNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:13:45 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so4633194yha.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vucKE+Qz7aRePneuaKtboOUKxsG6ykmeD4FU4iystMg=;
        b=jfOxsRYDFExLvQLv0Ee/m05ZtAU6FR9Ego4z54a9W08t8k4ec/Ny3WsaLgRHmlk/dC
         6aDHCaR3yuesk1990Nqj1fYTyuwKKfAzUTKpJBj/kPUF/kHWGiwe+MKsc9YAGwQTTa5I
         ji9+CtW/hTK/26a8eNr0CgyeJOI6GMse9W1uoyGE0VyWhsWTt03jP8BhfPP9/hG/d/s9
         MSGof6okUnYBwW/ehdtz8EFUq5XQnqYNemWkti5M7l1BpdS7/rbd2VPDyITHa01BuA1c
         BVy/Z8rswN7H+wpUf4SA3CNmBPppeavMfHhPbGs7kD2qGy4H7+NlXayetYwLEtBRXqbE
         k5kQ==
X-Received: by 10.236.123.38 with SMTP id u26mr14938431yhh.93.1394482424481;
 Mon, 10 Mar 2014 13:13:44 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 13:13:44 -0700 (PDT)
In-Reply-To: <1394479647-22361-2-git-send-email-benoit.pierre@gmail.com>
X-Google-Sender-Auth: IGmc7UMYvfoYmuOvvWcBa4Q-J2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243807>

On Mon, Mar 10, 2014 at 3:27 PM, Benoit Pierre <benoit.pierre@gmail.com> wrote:
> Useful for calling status_printf only to change/reset the color (and
> output an additional '\n' with status_vprintf_ln).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
>  wt-status.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 4e55810..17f63a4 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -49,7 +49,8 @@ static void status_vprintf(struct wt_status *s, int at_bol, const char *color,
>         struct strbuf linebuf = STRBUF_INIT;
>         const char *line, *eol;
>
> -       strbuf_vaddf(&sb, fmt, ap);
> +       if (NULL != fmt)

In this codebase,

    if (fmt)

would be more idiomatic.

> +           strbuf_vaddf(&sb, fmt, ap);
>         if (!sb.len) {
>                 if (s->display_comment_prefix) {
>                         strbuf_addch(&sb, comment_line_char);
> --
> 1.9.0
