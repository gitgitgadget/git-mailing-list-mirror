From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH v3] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 13:39:00 +0800
Message-ID: <CAJr59C1hoc6FPrgHLLy8_xBPNEvCkDHurGSETqPM5j51w7zrHg@mail.gmail.com>
References: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Guanglin Xu <mzguanglin@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 06:39:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKLam-0007bD-5L
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 06:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbaCCFjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 00:39:03 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:52435 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbaCCFjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 00:39:01 -0500
Received: by mail-wg0-f49.google.com with SMTP id b13so799478wgh.8
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 21:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=7IsuizCj3A446jmY0p+g5nyce6WP637egv5K3i1XAuc=;
        b=MPhICniVgxGQF2gWocqpqo70a+Y3GJebUpQsN2s2qFTKhJjuVA+w2fb4apT4RaMN0Q
         ke+MmNSHMLtwYFU0cl/NxawQFqRdJYHLOniyuaFV/DFp27zYsqWNViXj/vKyrrE/s0tr
         cvzs+7cw0Y0bIOJh3paZ5yFU4f/im57kTMm/6tZKz6BBtmyx3mhCbbb4/bpK4DwKderz
         ZBHWV1yw5ibSo2Qb1LSK1r44JGHE5wtlBVMGr6wAEtd48xAUxEduVDk0BDZbYM7kzMkM
         c6gSbP8zLXgbzK0Dn3AftIGcZMxMPZ3ZKHVEfveDSINyMQemIEVgHtbxmshdRO9xiR0I
         tEjg==
X-Received: by 10.194.143.40 with SMTP id sb8mr14389191wjb.15.1393825140180;
 Sun, 02 Mar 2014 21:39:00 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sun, 2 Mar 2014 21:39:00 -0800 (PST)
In-Reply-To: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243176>

2014-03-03 10:24 GMT+08:00 Guanglin Xu <mzguanglin@gmail.com>:
> to avoid a magic code of 11.
>
> Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
> Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
> ---
>
> This is an implementation of the idea#2 of GSoC 2014 microproject.
>
>  branch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..3e2551e 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,7 +49,7 @@ static int should_setup_rebase(const char *origin)
>
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -       const char *shortname = remote + 11;
> +       const char *shortname = skip_prefix(remote ,"refs/heads/");
>         int remote_is_branch = starts_with(remote, "refs/heads/");

Or it may be better to keep remote_is_branch, and replace starts_with
with something
you have just fixed.

>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
