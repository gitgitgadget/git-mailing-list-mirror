From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Possible vulnerability to SHA-1 collisions
Date: Sat, 24 Nov 2012 10:09:31 -0800
Message-ID: <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com>
References: <50B0AB9C.2040802@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael Hirshleifer <111mth@caltech.edu>
X-From: git-owner@vger.kernel.org Sat Nov 24 19:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcKBB-0004T9-5H
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 19:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab2KXSJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2012 13:09:53 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33651 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab2KXSJw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Nov 2012 13:09:52 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so2035142qat.19
        for <git@vger.kernel.org>; Sat, 24 Nov 2012 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1QDFvo3Oyu3AvQexbfNIkVjn+OUzt6Okne/p3B/9/6o=;
        b=amEB2VqLiZyrZbUwI3nynxJW+qpM3Imx6lPwXCZAlvD5EkK2GckTuiUZaY1uINk073
         WGYrmKRFP6ir2RMmgy5kh0j3Nh2GivduFUW3SA2mFW5WjYwWKymSi4xuvfe8rAeJRbcU
         +zt8p/JIYZatNkehyPCGgoNF2y5J286oaV2/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=1QDFvo3Oyu3AvQexbfNIkVjn+OUzt6Okne/p3B/9/6o=;
        b=fKFJ5sRGC1DFH66+LMngBprYQ7EyXtNaSut0FTiH1iozi9MzTusmtsXXECN6y71nDb
         dGkHQxxFA/SvJn2plmBQHyAqpcPrrtO1HXTI5AvO1EhHG+PhLOZtWsQKe89LWw6vSshJ
         DOdpFO/kRdnpBfMbm16rCYoOYeNjOp/s8bZrujra0jbFl9TRa3Sh9X1Kk6AbztgJVZm5
         dthXrJgj7fEizUp+JIhmtyhtbiwfuu/gxwTCdQaioybmWAql4AWJ59dINhaZ9VzFZDW9
         eDWjstUmEaEqiWStlxAqKkWJ8pPridZYarc+wTDPMuhUHn6+5PeDAKpsTkRx+ZSewdct
         +McQ==
Received: by 10.224.42.15 with SMTP id q15mr7651163qae.68.1353780591834; Sat,
 24 Nov 2012 10:09:51 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Sat, 24 Nov 2012 10:09:31 -0800 (PST)
In-Reply-To: <50B0AB9C.2040802@caltech.edu>
X-Gm-Message-State: ALoCoQniICtfhBJh9f8XmwJYBGFLF23xvnssjLTluaR8Y6mf2CU6fcsMwTn23CyLLsrY7rgHaFoO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210325>

I don't think there is an issue the way you have tried to describe
this scenario.

On Sat, Nov 24, 2012 at 3:12 AM, Michael Hirshleifer <111mth@caltech.ed=
u> wrote:
> Evil Guy creates 2 files, 1 evil and 1 innocuous, with the same SHA-1
> checksum (including Git header). Mr. Evil creates a local branch with=
 an
> innocuous name like =93test-bugfix=94, and adds a commit containing a=
 reference
> to the evil file. Separately, using a sockpuppet, Evil Guy creates an
> innocuous bugfix (very likely to be accepted) containing the innocuou=
s file,
> and submits it to Good Guy. Before Good Guy can commit the bugfix, Ev=
il Guy
> pushes the evil branch to Github, and then immediately deletes it; or
> equivalently --force pushes any innocuous commit on top of it. (This =
is
> unlikely to arouse suspicion, and he can always say he deleted it bec=
ause it
> didn=92t work.)

Here you assume Evil Guy has write access to the same repository as
Good Guy. Lets assume this is possible, e.g. Evil Guy is actually
impersonating White Hat because he managed to steal White Hat's
credentials through a compromised host. Typically Evil Guy doesn't
have write access to Good Guy's repository, and thus can't introduce
objects into it without Good Guy being the one that creates the
objects.

But lets just keep he assumption that Evil Guy can write to the same
repository as Good Guy, and that he managed to create the bad branch
and delete it, leaving the bad object in an unreachable state for 2
weeks.

> Git keeps unreferenced objects around for a few weeks, so when Good G=
uy
> commits the patch and pushes to Github, an object with an sha1sum tha=
t
> matches the good file will already exist in the main repository. Sinc=
e Git
> keeps the local copy of files when sha1sums match, the main Github
> repository will then contain the evil file associated with Good Guy=92=
s
> commit. Any users cloning from Github will get the evil version. This=
 is an
> exploit.

Typically... Git will fail with an error message when Good Guy pushes.
Good Guy's client will (rightly) believe that the object doesn't exist
on the remote side, after all it is unreachable. So his client will
include it in the pack being transmitted during push. When this pack
arrives on the remote side, the remote will identify it already has an
object named the same as an object coming in the pack. The remote will
do a byte-for-byte compare of both objects. As soon as a single byte
differs, it will abort with an error.

At this point Good Guy can't push to his repository. `git gc
--expire=3Dnow` will fix the repository by removing the unreachable
object, at which point Evil Guy's evil object is gone.

> And Good Guy=92s local repository will contain the good file; he will=
 not
> notice anything amiss unless he nukes his local repository and clones=
 from
> Github again. Even when the compromise is discovered, there will be n=
o
> reason to suspect Evil Guy; the evil file seems to have been committe=
d by
> Good Guy.

See above. Good Guy would have noticed something is amiss because the
object he sent already existed and didn't match.

> Previous discussion about hash collisions in Git seems to conclude th=
at they
> aren=92t a security threat. See
> http://stackoverflow.com/questions/9392365/how-would-git-handle-a-sha=
-1-collision-on-a-blob/9392525#9392525,
> Linus Torvalds arguing that Git=92s security doesn=92t depend on SHA-=
1 collision
> resistance.

This is largely true because there are additional defenses (e.g. the
byte for byte compare on identical objects), and for projects like the
Linux kernel there are many eyes looking at files all of the time.
Anything that is amiss would be announced quickly on LKML and
discussed until the root cause is identified and resolved.
