From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] simplified the chain if() statements of
 install_branch_config() function in branch.c
Date: Tue, 11 Mar 2014 04:06:15 -0400
Message-ID: <CAPig+cSfZZUNfcqJTEabqw_SVJwx0qgDK+qbpYZrEoPvJwT-ig@mail.gmail.com>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
	<CAPig+cRAqEQ8320Gq2Njoioq5UU=d+W+hzF+YZAZ7Po9XjMq0g@mail.gmail.com>
	<loom.20140311T072612-596@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 09:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNHi0-00023A-G0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 09:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaCKIGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 04:06:19 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:35134 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbaCKIGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 04:06:16 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so48290yhn.40
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=b3wIga/UpM92sp47WneeB32F3kvHwUEXykiGFGJ8Nrs=;
        b=Xu+iIrpogL96zcnccKjuHR2LpUmMrkf8vthKAiBc/7sF4tHFIgUoxksdyOyVL2HYCD
         lStw84O1JZ4RgVuW3bFHb0NEGb0pzJn/psUT1WBSyH26seQ02w1r/VQqJH3Stu/rGw3n
         NRpQpdW52Zo5xuhlj5mXHzn0V8T4PuENpkgvf/0SrWmASH5wJk+I3pfDvnurvjFq4VJ/
         tWMao15MpnPbcFlXhTrrahmGuWraGuTAvIlPLhI42ysalwz00GDu1PtN6IWpG/y0HCtv
         TAOtbfH3HbJCIlXecvlI7kvzhUO1m/B1rv1SvkQMVxte3CKVUW7fZbHjVQlYFuM+1nt6
         Z8ew==
X-Received: by 10.236.86.180 with SMTP id w40mr676358yhe.116.1394525175782;
 Tue, 11 Mar 2014 01:06:15 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 11 Mar 2014 01:06:15 -0700 (PDT)
In-Reply-To: <loom.20140311T072612-596@post.gmane.org>
X-Google-Sender-Auth: paBFbvYlLf-mB2hTfUsT3f-n0k4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243847>

On Tue, Mar 11, 2014 at 2:30 AM, Nemina Amarasinghe <neminaa@gmail.com> wrote:
> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>>
>> On Mon, Mar 10, 2014 at 3:58 AM, Nemina Amarasinghe <neminaa <at>
> gmail.com> wrote:
>> > Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>> >
>> > Sorry for the first patch. Something went wrong. This is the correct one
>>
>> In addition to the tautological issue pointed out by Matthieu, please
>> note that this version of the patch is not the correct one. It won't
>> apply to the git code. At a guess, it appears that this patch is
>> against some other modification you made to the git code before this
>> change, or perhaps you committed it incorrectly. In any event, when
>> you resubmit, please be sure that the new version can be applied to
>> commit.c as it exists in git.git itself.
>>
>
> Thank you very much for your comments Eric. I will resubmit the patch.
>
> Just a quick question
>
> in this code
>
> if (flag & BRANCH_CONFIG_VERBOSE) {
>         if (remote_is_branch && origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote branch %s from %s by
> rebasing.") :
>                   _("Branch %s set up to track remote branch %s from %s."),
>                   local, shortname, origin);
>         else if (remote_is_branch && !origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track local branch %s by rebasing.") :
>                   _("Branch %s set up to track local branch %s."),
>                   local, shortname);
>         else if (!remote_is_branch && origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                   _("Branch %s set up to track remote ref %s."),
>                   local, remote);
>         else if (!remote_is_branch && !origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                   _("Branch %s set up to track remote ref %s."),
>                   local, remote);
>         else
>             die("BUG: impossible combination of %d and %p",
>                 remote_is_branch, origin);
>     }

This code does not exist in git.git. Somehow, the code you are
consulting has incorrectly substituted 'remote' for 'local' in the
strings of the (!remote_is_branch && !origin) case. Whether this is
due to a local modification you made or some some other reason, it is
leading you astray in your proposed changes and breaking your patches
so that they cannot be applied to git.git.

Probably easiest at this point would be for you to start from scratch
by making a new clone of git.git and examining branch.c as it actually
exists in the 'master' branch.

> These "local" and "remote" variables are independent from the "origin" right?
> So, If that the case couldn't we just use the bellow function
>
>
> else if (!remote_is_branch)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                   _("Branch %s set up to track remote ref %s."),
>                   local, remote);
>
> instead of
>
> else if (!remote_is_branch && origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                   _("Branch %s set up to track remote ref %s."),
>                   local, remote);
>         else if (!remote_is_branch && !origin)
>             printf_ln(rebasing ?
>                   _("Branch %s set up to track remote ref %s by rebasing.") :
>                   _("Branch %s set up to track remote ref %s."),
>                   local, remote);
>
> Thanks
> Nemina
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
