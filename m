From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 9 Jun 2011 08:50:27 +0200
Message-ID: <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: NAKAMURA Takumi <geek4civic@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUZ5H-0008PO-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 08:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab1FIGvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 02:51:10 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50261 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab1FIGvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 02:51:08 -0400
Received: by qyg14 with SMTP id 14so664719qyg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wbfkbMrpW1Nzpay9ieKeior/viFWrG/iSFTAKNod6m0=;
        b=Cigpe1ZPIfVVDKiDNWZpWQ5aguYOsS/Pvj6LAFFKUEm/EvH6q2/31lSHWSTzQ0ehi1
         0G/EN6C8VFbjxDDHwC/xG3CUopN2aKAlBM9lDhhwU67msGVudw6GD+DnJdLWCsI72h8x
         EYMGkV8Z0h4hrtr6DIj9Wy7GaySWyecw+V7O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=acJMC5mKPQ5KfgUQqbTR4B21xDLLrei1oEpvS/iWis17BdevQw+AtdeJ7kenOyhwd/
         lPjNeYc+raQ3kUKZbRAj8ghzZkTAbsrIvRRZQnw4nnu+rymJaO/yQwYQnRnUL5dw7Mnv
         k+eBhZgoHHOp/TN+ncNKQN+XIR3BiavWNBrsA=
Received: by 10.229.135.12 with SMTP id l12mr270455qct.53.1307602267578; Wed,
 08 Jun 2011 23:51:07 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 23:50:27 -0700 (PDT)
In-Reply-To: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175495>

Heya,

[+shawn, who runs into something similar with Gerrit]

On Thu, Jun 9, 2011 at 05:44, NAKAMURA Takumi <geek4civic@gmail.com> wr=
ote:
> Hello, Git. It is my 1st post here.
>
> I have tried tagging each commit as "refs/tags/rXXXXXX" on git-svn
> repo locally. (over 100k refs/tags.)
> Indeed, it made something extremely slower, even with packed-refs and
> pack objects.
> I gave up, then, to push tags to upstream. (it must be terror) :p
>
> I know it might be crazy in the git way, but it would bring me conven=
iences.
> (eg. git log --oneline --decorate shows me each svn revision)
> I would like to work for Git to live with many tags.
>
> * Issues as far as I have investigated;
>
> =C2=A0- git show --decorate is always slow.
> =C2=A0 =C2=A0in decorate.c, every commits are inspected.
> =C2=A0- git rev-tree --quiet --objects $upstream --not --all spends s=
o much time,
> =C2=A0 =C2=A0even if it is expected to return with 0.
> =C2=A0 =C2=A0As you know, it is used in builtin/fetch.c.
> =C2=A0- git-upload-pack shows "all" refs to me if upstream has too ma=
ny refs.
>
> I would like to work as below if they were valuable.
>
> =C2=A0- Get rid of inspecting commits in packed-refs on decorate stuf=
f.
> =C2=A0- Implement sort-by-hash packed-refs, (not sort-by-name)
> =C2=A0- Implement more effective pruning --not --all on revision.c.
> =C2=A0- Think about enhancement of protocol to transfer many refs mor=
e effectively.
>
> I am happy to consider the issue, thank you.

--=20
Cheers,

Sverre Rabbelier
