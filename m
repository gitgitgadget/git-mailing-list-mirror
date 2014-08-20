From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH v3] Allow the user to change the temporary file name for
 mergetool
Date: Wed, 20 Aug 2014 09:24:27 +0200 (CEST)
Message-ID: <1933929003.2352.1408519467593.JavaMail.zimbra@dewire.com>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com> <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com> <53F3B565.5080309@kdbg.org> <xmqqk364unya.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 09:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK0G5-0005AI-D4
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 09:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbaHTHYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2014 03:24:33 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:34631 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHTHYc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 03:24:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id AB180815E0;
	Wed, 20 Aug 2014 09:24:31 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QkheoI-rIqUt; Wed, 20 Aug 2014 09:24:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 1E85E81683;
	Wed, 20 Aug 2014 09:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gHZVn7eYF_As; Wed, 20 Aug 2014 09:24:28 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 09DFC815E0;
	Wed, 20 Aug 2014 09:24:28 +0200 (CEST)
In-Reply-To: <xmqqk364unya.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [188.121.67.51]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF31 (Mac)/8.0.7_GA_6020)
Thread-Topic: Allow the user to change the temporary file name for mergetool
Thread-Index: 7WwjrdD7RuoxMAvPenyzcGeyrTo87Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255556>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Junio C Hamano" <gitster@pobox.com>
> Till: "Johannes Sixt" <j6t@kdbg.org>
> Kopia: "Robin Rosenberg" <robin.rosenberg@dewire.com>, git@vger.kerne=
l.org
> Skickat: onsdag, 20 aug 2014 0:14:21
> =C3=84mne: Re: [PATCH v3] Allow the user to change the temporary file=
 name for mergetool
>=20
> Johannes Sixt <j6t@kdbg.org> writes:
>=20
> > Am 19.08.2014 19:15, schrieb Robin Rosenberg:
> >> Using the original filename suffix for the temporary input files t=
o
> >> the merge tool confuses IDEs like Eclipse. This patch introduces
> >> a configurtion option, mergetool.tmpsuffix, which get appended to
> >> the temporary file name. That way the user can choose to use a
> >> suffix like ".tmp", which does not cause confusion.
> >
> > I have a merge tool that does syntax highlighting based on the file
> > extension. Given this:
> >
> >> +	BACKUP=3D"./$MERGED.BACKUP.$ext$tmpsuffix"
> >> +	LOCAL=3D"./$MERGED.LOCAL.$ext$tmpsuffix"
> >> +	REMOTE=3D"./$MERGED.REMOTE.$ext$tmpsuffix"
> >> +	BASE=3D"./$MERGED.BASE.$ext$tmpsuffix"
> >
> > I guess I lose syntax highlighting if I were to use mergetool.tmpsu=
ffix;
> > but then I don't use Eclipse. Could it be that this is really just =
a
> > band-aid for Eclipse users, not IDEs in general as you are hinting =
in
> > the Documentation of the new variable?
>=20
> The phrase "IDEs like Eclipse" in the proposed log message did not
> tell me (which I think is a good thing) if IDEs that need "band-aid"
> are majority or minority, but I agree that we should not hint that
> IDEs in general would benefit by setting this variable.  A warning
> on the syntax-aware editors may be necessary.

I'm not sure it's necessary since it is not a default. If you use the
setting you are probably well aware of why you use it, and the=20
possible implications.

I have only had the problem with Eclipse, but I imagine any tool that
"owns" a directory and scans it for changes will find these temporary
files and do something unexpected based on the suffix. By setting the
suffix to something insert, like txt, tmp, dat or whatever you prevent
that tool from thinking too much.

In concrete terms, what happens is that Eclipse, in my case, find
temporary filenames with the suffix Foo.REMOTE.java and thinks that
is the one source file for Foo since it contains the source for Foo.

Sure you lose syntax highlighting, that's a trade-off. An alternative
solution would be to put these files somewhere else.

-- robin
