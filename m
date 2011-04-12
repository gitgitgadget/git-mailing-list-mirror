From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: rebase on remote branch
Date: Tue, 12 Apr 2011 11:50:02 -0700
Message-ID: <BANLkTimGQ60TU5WGEWG8b1OdNKOpnb=eCQ@mail.gmail.com>
References: <6b4c9a4d-075c-4805-8fad-bacecb24e9de@w7g2000pre.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: allstars <allstars.chh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:50:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ifq-0007di-76
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab1DLSup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 14:50:45 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40062 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab1DLSuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 14:50:44 -0400
Received: by ywj3 with SMTP id 3so2654139ywj.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tHS7hDJOALsq27q2aMUPnfCxu0uIfls0BGxr98jGNkI=;
        b=TnQAXVb9fJ2nO1UIwoER2vgv2DrIT+pEJ2irRdzHLdP4g5EXAJu6ny/1Erl/CQXyFA
         ahKxcPSm++AgbyiT7QfqdjKCzQ4O8ZP0vGkAYBcOuKQ4d4InvrEtiPnHNpkluOVNcEzD
         DMDZpXrGqo8P62UHGlzRzAUmhHyGna2QUxD0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZYX9uebxel16N6k3K6f63wIqxwedY8Ls9sgw8LT+nCTtf1AJ6cfvjo0dBvFUiBxDFZ
         QasVvVpumEDNYQYnRhDriD2d1sDc0hug9EJjEnVr238xZSbhOYalYzrn+9injgK+5vJk
         JMgH2v1RusupwcDFiiaXHGsHM2sG+w/G3Jpck=
Received: by 10.236.190.133 with SMTP id e5mr4286111yhn.157.1302634243791;
 Tue, 12 Apr 2011 11:50:43 -0700 (PDT)
Received: by 10.236.102.144 with HTTP; Tue, 12 Apr 2011 11:50:02 -0700 (PDT)
In-Reply-To: <6b4c9a4d-075c-4805-8fad-bacecb24e9de@w7g2000pre.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171411>

>
> or if we use cherry-pick model
>
> 0---0---0---0---*---*---* master
> =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 0---0---*---*---* release
>
> but in this case , how do we do it in script?
> I mean, how do we know we need to start cherry-pick from the 1st '*'
> to the 3rd '*' in master
>
> more precisely , if A to E represents the commit SHA1
>
> 0---0---0---0---A---B---C---D---E master
> =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 0---0---A'---B'---C' release
>
> the 3 cherry-picks A' B' C' on release branch won't have the same SHA=
1
> for A B C in master
> how can we know effectively we need to start cherry-pick from C to E
> on master
>

You can start by using
  git log --cherry-pick ....
which compares commits based on their patch contents, not just the SHA1=
=2E

You can use a moving tag (say APPLIED) to keep track of till what point
on master you have done the necessary cherry-picks, and then something =
like
this may work for you:
  git log --cherry-pick release..master ^APPLIED

Thanks
Antriksh
