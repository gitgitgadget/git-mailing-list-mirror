From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4.py: Don't try to rebase on submit from bare repository
Date: Fri, 19 Feb 2016 09:47:13 +0000
Message-ID: <CAE5ih78G1JczQvUEwzz3TmVPZuKUJVcxwZAsDdNzUbqAyHcqqA@mail.gmail.com>
References: <1455749160-2017-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:47:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhf3-0001N3-Uh
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427371AbcBSJrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 04:47:36 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33144 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427368AbcBSJrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 04:47:20 -0500
Received: by mail-ob0-f171.google.com with SMTP id jq7so102660894obb.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OOtC07sBR0GZ7mbOp7zICvQFGkI9V0+PtML0VjhHGJw=;
        b=PwX1SQ5zKpX672U6xR1OobkaVdPHd8vKA+ByLFUG5tCnDcOPIRwGSN2gb/p/zgg5d7
         1mNw7uR/jpqvS01WVVUwJXWl/VqSeF3R7nOIkjxOJq41l/7BFvvs2ReGaO8a6AvUD9jw
         8DJKoiFCnZhc0hVujVWadbBdD962Crn4xrF/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OOtC07sBR0GZ7mbOp7zICvQFGkI9V0+PtML0VjhHGJw=;
        b=gTfUsPfw2frTTtGlSpLY/Wsrqf0mQqQYR9jvx/tJ2YSO81s4z0LVkmUT7/c2ZpYLAG
         b0VOrgUsdXSnwISwEkDomSWM9NlLz71XDguVcHpaD5fNohYwL5rP/o4AOhwU7fwQ8VgC
         Wy4Jt8luMaNL9/wKPbEMko5Jrd/TfGTXU4QiaoT2caFMqTL1dAqRRSQ8DBo4d589Kgaf
         MDTOuqaFHfBn3HLUjc11EOkJX/7bIBOpNGHfWMMFRzHRvTWzBOsI+gqIWnsKdJVMl+a3
         u2GogJJ+WH9xQmwvEJeAt9Zdq7L33PFqFZ/Ao9eq0SfUHlPcoYuu+SLThdt6UAQCh+7g
         /tFw==
X-Gm-Message-State: AG10YORKYs1yqfFBivlJhNtsBdV3h3SfO71yj6lc9DZqt61DR8wO1fW/2zx1RxoNsz70lZNAJ2SpSphKD1KbRQ==
X-Received: by 10.60.178.70 with SMTP id cw6mr10952379oec.46.1455875233263;
 Fri, 19 Feb 2016 01:47:13 -0800 (PST)
Received: by 10.202.214.18 with HTTP; Fri, 19 Feb 2016 01:47:13 -0800 (PST)
In-Reply-To: <1455749160-2017-1-git-send-email-aidecoe@aidecoe.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286680>

On 17 February 2016 at 22:46, Amadeusz =C5=BBo=C5=82nowski <aidecoe@aid=
ecoe.name> wrote:
> git-p4 can be successfully used from bare repository (which acts as a
> bridge between Perforce repository and pure Git repositories). On sub=
mit
> git-p4 performs unconditional rebase. Do rebase only on non-bare
> repositories.

This looks obviously sensible and good to me, ack.

Thanks!
Luke



> ---
>  git-p4.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c33dece..e00cd02 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
>                  sync.branch =3D self.branch
>              sync.run([])
>
> -            rebase =3D P4Rebase()
> -            rebase.rebase()
> +            if not gitConfigBool("core.bare"):
> +                rebase =3D P4Rebase()
> +                rebase.rebase()
>
>          else:
>              if len(applied) =3D=3D 0:
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
