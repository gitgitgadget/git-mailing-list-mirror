From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Replacing a Remote Branch
Date: Fri, 23 Jul 2010 22:48:48 +0200
Message-ID: <201007232248.49520.trast@student.ethz.ch>
References: <4C49F83B.4060903@cybersprocket.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <Eric@cybersprocket.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 22:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcPB0-00068W-5T
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 22:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758337Ab0GWUsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 16:48:55 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:4118 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757570Ab0GWUsy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 16:48:54 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 23 Jul
 2010 22:48:52 +0200
Received: from thomas.localnet (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 23 Jul
 2010 22:48:52 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <4C49F83B.4060903@cybersprocket.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151572>

Eric James Michael Ritz wrote:
>   2. I realized I need to perform some =E2=80=98destructive=E2=80=99 =
action like
>   =E2=80=98rebase -i=E2=80=99 or amend the last commit to fix a typo =
in the message.
>=20
>   3. Then I want to push the changed branch as a replacement.
[...]
>     $ git push origin :foo && git push origin foo
>=20
> to replace `foo`.  But is there a shorter way to do this?  I thought
> that writing something like
>=20
>     $ git push origin +foo:foo
>=20
> may have the intended effect, but I still get a rejection due to a
> non-fast-forward, so I am likely misunderstanding the purpose of `+`.

Since + overrides the non-ff check, this means that the remote side
has receive.denyNonFastForwards (see man git-config) enabled (or a
hook to the same effect).  Deleting and pushing the new branch merely
defeats this refusal because it is no longer a branch *update*.

You should probably check why and by who receive.denyNonFastForwards
was set.  Git itself sets it if you use 'git init --shared', so that
may be one reason.

Note that non-ff updates are generally a bad thing for everyone who
has work based on the affected branch.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
