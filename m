From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 08:50:01 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4feP-0004Vq-Dc
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004AbXLRQuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757980AbXLRQuO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:50:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35021 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757942AbXLRQuM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 11:50:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIGo1aG024502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 08:50:02 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIGo1uY012064;
	Tue, 18 Dec 2007 08:50:01 -0800
In-Reply-To: <4767EE6D.5070509@obry.net>
X-Spam-Status: No, hits=-4.713 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68778>



On Tue, 18 Dec 2007, Pascal Obry wrote:

> Johannes Sixt a =C3=A9crit :
> > that we need another diff option for it. Ok, on my keyboard 0 is ty=
ped
> > with the right hand, and 1 with the left hand, but... ??
>=20
> Because you just did not read my follow-up message :)
>=20
> I need this has I do not have the way to change the server applying t=
he
> patch. So nothing wrong with my hands or fingers :)

Well, we'd also need something like that for doing recursive diffs of=20
submodules (since then we'd want to do the internal diff with the=20
submodule name appended to the prefix), so I do think this whole=20
"--prefix" makes sense.=20

But I obviously think the version by Dscho is better (exactly because i=
t's=20
*not* enough to just clear the name prefix entirely), although I think=20
that one is broken too - using ':' to separate the prefixes is *not*=20
acceptable, since ':' is very possibly part of the prefix.

So I think you'd need separate arguments for the from/to prefixes, and =
not=20
try to shoehorn it into one argument. With possibly some simple form to=
=20
say "no prefix". So maybe something like

  --src-prefix=3D<string>		// default "a/"
  --dst-prefix=3D<string>		// default "b/"
  --no-prefix			// shorthand for --src-prefix=3D"" --dst-prefix=3D""

would work for everybody?

		Linus
