From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 11:22:09 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111119520.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
 <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 20:29:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lshxl-00065c-VM
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 20:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbZDKS2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 14:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZDKS2P
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 14:28:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35351 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751851AbZDKS2O (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 14:28:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BIMAxV013099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 11:22:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BIM9rx008674;
	Sat, 11 Apr 2009 11:22:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116308>



On Sat, 11 Apr 2009, Linus Torvalds wrote:
> On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
>=20
> > And again, the new pack is slightly worse than the old one
> >  (window=3D250, --depth=3D250).
> > Old: 240238406
> > New: 240280452
> >=20
> > But again, it's negligible.
>=20
> Well, it's sad that it's consistently a bit worse, even if we're talk=
ing=20
> just small small fractions of a percent (looks like 0.02% bigger ;).=20

Oh, just wondering: that 0.02% is negligible, but did you use "-f" (or=20
--no-reuse-delta if you're testing with 'git pack-objects') to see that=
=20
it's actually re-computing the deltas?

The 0.02% difference might be just because of differences in pack layou=
t.=20
If you force all deltas to be recomputed, maybe the difference is much=20
bigger?

		Linus
