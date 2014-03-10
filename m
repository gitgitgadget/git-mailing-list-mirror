From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] simplified the chain if() statements of
 install_branch_config() function in branch.c
Date: Mon, 10 Mar 2014 16:46:13 -0400
Message-ID: <CAPig+cRAqEQ8320Gq2Njoioq5UU=d+W+hzF+YZAZ7Po9XjMq0g@mail.gmail.com>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN75d-0005xs-N3
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbaCJUqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:46:16 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:57463 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbaCJUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:46:14 -0400
Received: by mail-yk0-f178.google.com with SMTP id 79so20545103ykr.9
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VraGncLyRYDkZE7Du7BG4NKgAEcY2Lkg15KNc+h5nAA=;
        b=Z3twzzXWM87BA5z4LYlW2Qz8/b/i221swzRTNvU5/l1h5/Swv5vuPx0jFTbvmaS1YF
         FRzjwIhf700vXRwhxPlbRe2urSPbyyT+h6DLL8ByeZMB/6E+kpxxUWo4fLwmC2m3w4Ne
         vwzCdcy9oNNAHXOy/IWHJuJL3QaMgbbqbEeLfowICgKz+wwprT1klHFrAzhk7fN3Gf2e
         peDC69Biq6lGZ8R2Zu0vwJ4OVVAqWa2yHVMZVoPmCmG5x4l0NaCeVKXLXweSpHAN1Lvp
         EHWs4LUxpyEAwIiJEjW3Pb8h/H0+88YKO3i+Y1BFZwuLbTOnAQQG5KCSN9uNJpy8TiJI
         rTVQ==
X-Received: by 10.236.91.144 with SMTP id h16mr4753071yhf.123.1394484373559;
 Mon, 10 Mar 2014 13:46:13 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 10 Mar 2014 13:46:13 -0700 (PDT)
In-Reply-To: <loom.20140310T085652-521@post.gmane.org>
X-Google-Sender-Auth: rsNenBbP4FdtGbF6vxQcRSD3Avc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243814>

On Mon, Mar 10, 2014 at 3:58 AM, Nemina Amarasinghe <neminaa@gmail.com> wrote:
> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>
> Sorry for the first patch. Something went wrong. This is the correct one

In addition to the tautological issue pointed out by Matthieu, please
note that this version of the patch is not the correct one. It won't
apply to the git code. At a guess, it appears that this patch is
against some other modification you made to the git code before this
change, or perhaps you committed it incorrectly. In any event, when
you resubmit, please be sure that the new version can be applied to
commit.c as it exists in git.git itself.

>
> From aebfa60feb643280c89b54e5ab87f9d960cde452 Mon Sep 17 00:00:00 2001
> From: Nemina Amarasinghe <neminaa@gmail.com>
> Date: Mon, 10 Mar 2014 13:02:55 +0530
> Subject: [PATCH] simplified the chain if() statements of
>  install_brach_config() function in branch.c
>
> ---
>  branch.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/branch.c b/branch.c
> index d3b9d49..0304a7a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -87,12 +87,7 @@ void install_branch_config(int flag, const char *local,
> const char *origin, cons
>                                   _("Branch %s set up to track local branch %s by rebasing.") :
>                                   _("Branch %s set up to track local branch %s."),
>                                   local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> +               else if (!remote_is_branch && (origin || !origin))
>                         printf_ln(rebasing ?
>                                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                                   _("Branch %s set up to track remote ref %s."),
> --
> 1.9.0.152.g6ab4ae2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
