From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Use long for timezone in pretty.c:show_ident_date()
Date: Fri, 7 Mar 2014 14:29:42 -0500
Message-ID: <CAPig+cSAGEmtKziqE49MxuQOsBdbbbVtLcsYVd+Uoptg2Ucr8A@mail.gmail.com>
References: <1394218076-70398-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 20:29:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM0Sw-0006T7-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 20:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbaCGT3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 14:29:44 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:57365 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbaCGT3n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 14:29:43 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so11832285ykr.9
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 11:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Vqa8pbcFl4om6fpsz907hKktxJgU7Insmkek/VeMzBg=;
        b=Y6G09Wn9T8etfz5J4X8N1stGSGFleiRWL9+8hKjnarqYSD0OyUOBjVg9TMjUKglmu7
         84e0x64Ppxtr6h9DaP9p2kBgYp48u85z0kDbPa6xH+k84uKjP407y4GcT/6ca0kKJ6hA
         zqWZffoLAJywp5T9U4EHiJvgHFs1janSzd7K0pHaGVO6IQKQwVO2IXR/lbQnVaXPhP/C
         syXgzC7ompQPeQlqzIoPYVr1vmonnLZxUx3lpzF3c+4wjrYIneywcFreTv+UFdqjTdlT
         l/e3iuvGHHVttgPcNAA8R5qerdwX1bBKPPysWoNrpBht1bDB2UZwWMMfWksgJFZ6acTm
         tRQA==
X-Received: by 10.236.222.231 with SMTP id t97mr3273323yhp.125.1394220582125;
 Fri, 07 Mar 2014 11:29:42 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Fri, 7 Mar 2014 11:29:42 -0800 (PST)
In-Reply-To: <1394218076-70398-1-git-send-email-brian@gernhardtsoftware.com>
X-Google-Sender-Auth: aN9_M-YFBm8DfYQNMRmoMJLHZKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243625>

On Fri, Mar 7, 2014 at 1:47 PM, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> The value is parsed with strtol and compared against LONG_MIN and
> LONG_MAX, which doesn't make much sense for an int.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>

Thanks. Find a more complete fix here [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243582/focus=243617

> ---
>  pretty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pretty.c b/pretty.c
> index 3b811ed..29ebc4f 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -397,7 +397,7 @@ static const char *show_ident_date(const struct ident_split *ident,
>                                    enum date_mode mode)
>  {
>         unsigned long date = 0;
> -       int tz = 0;
> +       long tz = 0;
>
>         if (ident->date_begin && ident->date_end)
>                 date = strtoul(ident->date_begin, NULL, 10);
> --
> 1.9.0.281.gfc51f0a.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
