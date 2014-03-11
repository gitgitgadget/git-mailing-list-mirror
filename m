From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSoC]simplified branch.c:install_branch_config() if() statement
Date: Tue, 11 Mar 2014 04:11:34 -0400
Message-ID: <CAPig+cT2You1WLkyoWbwo84xMQGyyeu6t0HB7tcsnyN+HxiLLQ@mail.gmail.com>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
	<CAPig+cRAqEQ8320Gq2Njoioq5UU=d+W+hzF+YZAZ7Po9XjMq0g@mail.gmail.com>
	<loom.20140311T081018-894@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 09:11:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNHmp-0004sv-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 09:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbaCKILi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 04:11:38 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:47164 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaCKILf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 04:11:35 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so5237411yha.19
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dW/RG1ynxkPW16Ib4J5LSXfWIvAnq4VZ6kJPaeW//cQ=;
        b=BAUOf9RLd+Ce7uw1Cdt+kc557hL18eqSa0moIw8MGUyr/ivPMx6VsUFlCckjbCI28q
         4dEZbzNxAg5M+XH7gBJXNOvZ1EzGkD8ggOf2rSzWJLUYKTem2u/tVS5YqO3QJEOUj1KJ
         1sQxUDZNmWNgwAK51CGUCOJ/teF6YRLDGw0eImOX0ZqwuinIU3/C8IXcGUbQUe4p2Pr4
         7ztb9YFxEJAP9FmK8HJ+EMVMVs/6hC+mQdRQGB248MensVxa3YR2oS+VyoAnQ80BLywj
         /JeYU8aG6t/nlhXUbgPAw9gEFPKJHs1uG4q0b3mPHk88JYui0MYwf15EkV4PdzxwhvZk
         XrQQ==
X-Received: by 10.236.87.6 with SMTP id x6mr33621yhe.149.1394525494755; Tue,
 11 Mar 2014 01:11:34 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 11 Mar 2014 01:11:34 -0700 (PDT)
In-Reply-To: <loom.20140311T081018-894@post.gmane.org>
X-Google-Sender-Auth: YIlf23ab0xhyA2271Plj37XWl0Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243848>

On Tue, Mar 11, 2014 at 3:16 AM, Nemina Amarasinghe <neminaa@gmail.com> wrote:
> Subject: simplified branch.c:install_branch_config() if() statement

Use imperative tone: "simplify ..."

> I hope this is the correct format for  patch. Please comment on this if
> something is wrong.

This commentary is relevant to the email discussion but not to the
commit description, so it should be placed below the "---" line just
under your sign-0ff.

> Signed-off-by:Nemina Amarasinghe <neminaa@gmail.com>
> ---
>  branch.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 0304a7a..fd93603 100644
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
> +               else if (!remote_is_branch)
>                         printf_ln(rebasing ?
>                                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                                   _("Branch %s set up to track remote ref %s."),

The patch itself is broken in a couple ways.

First, it is whitespace-damaged, possibly due to being pasted into
your email client. Using "git send-email" can help avoid this problem.

Second, the code against which this patch was made does not exist in
git.git. You are likely making this change atop some other local
modifications which you already made. Simplest at this point would
probably be for you to make a fresh clone of git.git and start from
scratch by editing branch.c in the 'master' branch.

> --
> 1.9.0.152.g6ab4ae2
