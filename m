From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 15:35:28 -0700
Message-ID: <05976673-8F8A-41FE-81C3-606CAA45BC52@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801200201.GS12427@google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLQS-00042W-Pz
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 00:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbaHAWfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 18:35:45 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:60823
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756106AbaHAWfo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 18:35:44 -0400
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id ZYlY1o0040SCNGk5BabjWX; Fri, 01 Aug 2014 22:35:43 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id Zabh1o00K2ztT3H3Vabi9W; Fri, 01 Aug 2014 22:35:43 +0000
In-Reply-To: <20140801200201.GS12427@google.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406932543;
	bh=e7kYkUm8QkRY64xAppZqqbPEXRVfIATK9tjNYRk6BKs=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=IKX/X1zT0cr9Hda9XrEF+H/IIhy97/7mZd0Yh40zcvY2XH88jF6YEnldeIKm3o2/7
	 TFpYY3LZXLr9DiuPe7ZAhNRUXPH+I9sBHaQKCHIp621QZDkcQNbGaz5gGtJ9EBSP7w
	 Y4h9ZNfivJnIi0WRPchqOhMCwfRn3p2dzfc68ALpFFHxpLBfQA0DyQyIrQ3qBQ9+X/
	 ontd4b/Sxoh4znDICP2t/TGDg8Gzz+Oq0Kh1svxnxus3f+IJ8OUJeVZsJ13zRnWeKg
	 EfWKKbYC65zE7IoAJIUXX3w0dXuBPLLqdW8d1N0b7vm54XneoJWTAqflUgJsQjN+pb
	 iFyNbuC6FZysA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254677>

On Aug 1, 2014, at 1:02 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>=20
> Do you mean that "git merge" should be aware of what changes you have
> already cherry-picked?

Yes, it amounts to that.

> It isn't, and that's deliberate

Deliberate bugs are still bugs.  In time, users will either wear you do=
wn until you fix it, or they will move on to other systems that work be=
tter.

> ("git merge" is designed to be simple as possible, though no more sim=
ple than that).

I sketched a solution that retains a simple git merge=85

> This way, if on a side branch someone makes a change that would confl=
ict with "master" and
> then backs it out, then the branch can still merge cleanly.

Yeah, my solution doesn=92t impinge upon that working nicely.  In it, I=
 make cherry use scratch branches to record meta information so that th=
e existing git merge just works.  git cherry is free to do the same.  H=
aving a git cherry that fully interoperates with git merge, is a featur=
e.

> Even in those workflows, it's possible to have conflicts due to

> genuinely conflicting changes, even with no cherry-pick involved.  I
> find the '[merge] conflictstyle =3D diff3' setting (see git-config(1)=
)
> and git-rerere(1) to be helpful in making that less painful.

I think those two should be the default, but it is easy enough to turn =
them on that it doesn=92t matter much.  In my environment, I have both =
on.