From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] Update Bash completion script to include git log
 --merges option
Date: Sun, 22 Mar 2015 17:24:25 -0400
Message-ID: <CAPig+cTnyKZWAogK_7zyswg4JaPfA_=p_G+wVC4hAZe6t7ogGw@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-5-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 22:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZnMF-0001fJ-6l
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 22:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbbCVVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 17:24:27 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:33159 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbCVVY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 17:24:26 -0400
Received: by yhpt93 with SMTP id t93so60565699yhp.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KsBmH5WAT02tpxBgsUA7ev+DqrhRLomeJqmW6ayC7iw=;
        b=tQxyZiATQlJKDhQ6CL6kT/pvHKLAKjFeBVsVEM89C6b+tybKTop8sltUG0CSSBOtQk
         WIwmPWmsGXLTj/OOsNvDu/BjOd6eqZArcWRJf6SK/mbcGNg+Y/JPUt7S2PdOlHMkxvLu
         /5j3B81SNUPByrE1pbObiDcKnzyxIi6wQJaDgHeEUUiK1gVBjkgguNm0oFelEdUcOO30
         naACtQqYSxVPOmD37KS+uP+B/plQQExV7f3jH66zzUefWfR3IH7kq/h5+8qoWOWeO2yD
         KVtNtNUci5XGbp74LS4DTO8I1ttsqiphOMngfxXSuO20vuQEmQxyG231XlhZ+RpxHw9T
         bTpg==
X-Received: by 10.236.45.106 with SMTP id o70mr93263891yhb.180.1427059465560;
 Sun, 22 Mar 2015 14:24:25 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 14:24:25 -0700 (PDT)
In-Reply-To: <1427048921-28677-5-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: NXsOfIosPQgfhBgYoLRJwLvTWA4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266096>

On Sun, Mar 22, 2015 at 2:28 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> Subject: Update Bash completion script to include git log --merges option

Nice to see a patch covering this oft-overlooked corner of the project.

It's misleading to say that you're updating it to include the --merges
option, which it already knows about. Spell it out explicitly as
--merges=. Also, drop capitalization, mention area you're touching,
followed by colon, followed by short summary:

    completion: teach about git-log --merges= and log.merges

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 731c289..b63bb95 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1406,7 +1406,7 @@ _git_ls_tree ()
>  __git_log_common_options="
>         --not --all
>         --branches --tags --remotes
> -       --first-parent --merges --no-merges
> +       --first-parent --merges --merges= --no-merges
>         --max-count=
>         --max-age= --since= --after=
>         --min-age= --until= --before=
> @@ -1451,6 +1451,10 @@ _git_log ()
>                 __gitcomp "long short" "" "${cur##--decorate=}"
>                 return
>                 ;;
> +    --merges=*)
> +        __gitcomp "show hide only" "" "${cur##--merges=}"
> +        return
> +        ;;
>         --*)
>                 __gitcomp "
>                         $__git_log_common_options
> @@ -1861,6 +1865,10 @@ _git_config ()
>                 __gitcomp "$__git_log_date_formats"
>                 return
>                 ;;
> +       log.merges)
> +               __gitcomp "show hide only"
> +               return
> +               ;;
>         sendemail.aliasesfiletype)
>                 __gitcomp "mutt mailrc pine elm gnus"
>                 return
> @@ -2150,6 +2158,7 @@ _git_config ()
>                 interactive.singlekey
>                 log.date
>                 log.decorate
> +               log.merges
>                 log.showroot
>                 mailmap.file
>                 man.
> --
> 2.3.3.263.g095251d.dirty
