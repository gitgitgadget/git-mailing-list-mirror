From: Deskin Miller <deskinm@gmail.com>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 15:53:10 -0500
Message-ID: <86d4c5e00902271253y50eaef01x8ca837d3a0ed7ef6@mail.gmail.com>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:54:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9jG-0007Zh-1X
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbZB0UxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbZB0UxN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:53:13 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:63547 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbZB0UxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 15:53:12 -0500
Received: by gxk22 with SMTP id 22so3048143gxk.13
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yS8PjNZAeqIiJr7bPj78k2yZODwMqqktk5oAblUuK7Y=;
        b=XPu43J9By2WTckVxmAyeOjb85O7lk9OmF7aeoC8xkgQwOsq7mPipIZoG7hFz6VOl8U
         cEXpqf96S07TNDB124UT7WGPZCz6tpvxJ5MBfBgUnj8/IiQRWF+hiRmwnX5/d/LuGWwf
         9iis0THqurzQfGjTv1qvnX8YplSw7fN/76GXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KcSz3PT1MHMNIz2SVeRPttp/EHxoP3+NBVaUX+yKlTSFTMUepKkBAU/gtx7/oaKK4n
         V0dx00LcxhknrCxxuhoZGUxzLG/JC5mn5sFGxBo1pyyh2yxqGldOnsc6XVxL/NqjE+5O
         a1oslcLtBcGyQtei0hgpZd7hDFljBjCe/nH0w=
Received: by 10.150.11.6 with SMTP id 6mr4647469ybk.190.1235767990308; Fri, 27 
	Feb 2009 12:53:10 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111714>

On Fri, Feb 27, 2009 at 15:37, Nicolas Pitre <nico@cam.org> wrote:
>
> OK... I cannot pretend to be a newbie with git. =C2=A0However it's th=
e first
> time I try git-svn and it looks like a couple basic things aren't rig=
ht.
>
> I initially cloned svn://svn.berlios.de/openocd using "git svn clone =
-s".
> So far so good. =C2=A0Now I'm attempting to update using "git svn fet=
ch" but
> the operation always fails with the following error:
>
> |branch_from: /openocd/branches =3D> /openocd/branches/xscale
> |Found possible branch point:
> |svn://svn.berlios.de/openocd/openocd/branches/xscale =3D>
> |svn://svn.berlios.de/openocd/branches/xscale, 1231
> |Initializing parent: xscale@1231
> |Found branch parent: (xscale) 657522f3f2d1ab8b679fd5b45ce4e9ca1974af=
18
> |Following parent with do_switch
> |Scanning for empty symlinks, this may take a while if you have many =
empty files
> |You may disable this with `git config svn.brokenSymlinkWorkaround fa=
lse'.
> |This may be done in a different terminal without restarting git svn
> |Malformed network data: Malformed network data at /home/nico/libexec=
/git-core/git-svn line 3333

I experience the same error as you do with 1.6.2-rc2.  This error is
occurring in the new broken-symlink-workaround code.  I'm not sure
what is going on and don't have time to examine it closely, but the
function where the error occurs doesn't run if the config
svn.brokenSymlinkWorkaround option is set false; doing so makes the
fetch continue for me.

Any ideas, Eric?

> Thing is... the repository never gets updated and by far. =C2=A0Accor=
ding to
> "git svn info", the fetched revision is 1232, while a separate
> repository using native svn claims to be at revision 1383.
>
> Furthermore, the "git svn info" command produces yet more errors, suc=
h
> as:
>
> |Use of uninitialized value $lc_author in concatenation (.) or string=
 at /home/nico/libexec/git-core/git-svn line 964.
> |Use of uninitialized value $lc_rev in concatenation (.) or string at=
 /home/nico/libexec/git-core/git-svn line 965.
> |Use of uninitialized value $t in gmtime at /home/nico/libexec/git-co=
re/git-svn line 4743.
> |Use of uninitialized value $t in numeric comparison (<=3D>) at /home=
/nico/libexec/git-core/git-svn line 4744.
> |Use of uninitialized value $t in subtraction (-) at /home/nico/libex=
ec/git-core/git-svn line 4745.
> |Use of uninitialized value $t in localtime at /home/nico/libexec/git=
-core/git-svn line 4746.
>
> This is with git from current "next". I cannot spend time to try fixi=
ng
> the issue myself (especially as I'm not familiar at all with the inne=
r
> workings of svn), so my only option at the moment is to give up on
> git-svn altogether. =C2=A0:-(

Oh, don't give up quite yet :)

Deskin Miler
