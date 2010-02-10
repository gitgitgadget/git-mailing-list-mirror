From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git-svn taking a long time
Date: Wed, 10 Feb 2010 08:59:37 -0800
Message-ID: <6D721095-7A04-4097-8D86-1A2B915182DF@apple.com>
References: <87hbppp8k7.fsf@krank.kagedal.org>
Mime-Version: 1.0 (Apple Message framework v1133)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfFum-0001tK-5K
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 17:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334Ab0BJQ7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 11:59:43 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:60546 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab0BJQ7m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 11:59:42 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 08E158B272FD;
	Wed, 10 Feb 2010 08:59:42 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-2b-4b72e5faf030
Received: from [17.151.83.73] (Unknown_Domain [17.151.83.73])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay11.apple.com (Apple SCV relay) with SMTP id 47.3F.04140.CF5E27B4; Wed, 10 Feb 2010 08:59:41 -0800 (PST)
In-Reply-To: <87hbppp8k7.fsf@krank.kagedal.org>
X-Mailer: Apple Mail (2.1133)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139517>

Give 1.7.0-rc2 a try.  It includes commit 8bff7c5383ed833bd1df9c8d85c00=
a27af3e5b02, which attempts to persistently cache a lot of the processi=
ng that git-svn has to do on subversion's merge tickets, which has impr=
oved my fetch times significantly. =20

Note 1: git did not support subversion merge tickets before git-1.6.6, =
so there would be no slowdown if you use prior versions.

Note 2: you shouldn't need to clone your subversion repository from scr=
atch.  git will create the caches the first time you fetch after upgrad=
ing (so the first fetch will be slow), and it will continue to use and =
update the caches thereafter.

-Andrew

On Feb 10, 2010, at 4:41 AM, David K=E5gedal wrote:

> I compiled the perl bindings from subversion 1.6.x, and git git versi=
on
> 1.7.0.rc0.52.g64ba.
>=20
> I have imported a largish svn repo using "git svn fetch", which takes
> quite a long time (at least a day).
>=20
> But my problems is that if I rerun "git svn fetch" again right after
> fetching, it will chew for hours before figuring out there are just a
> few new revisions to import. And the same if I try again.
>=20
> I have another import from the same repo (on another machine, using
> slightly different versions of stuff) that doesn't have this problem.
>=20
> So, does anyone have any suggestions for what could be done about thi=
s?
>=20
> This is what the entry i .git/config looks like (url edited to protec=
t
> the innocent)
>=20
> [svn-remote "svn"]
>        url =3D svn://svn.server
>        branches =3D foo/branches/*:refs/remotes/svn/*
>        tags =3D foo/tags/*:refs/remotes/svn/tags/*
>=20
> --=20
> David K=E5gedal
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
