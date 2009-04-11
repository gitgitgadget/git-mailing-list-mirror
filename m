From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 14:43:14 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111441240.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
 <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain> <20090411205044.GA21673@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 23:51:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsl6u-0003Fh-2r
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 23:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759238AbZDKVtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbZDKVtf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 17:49:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58268 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758192AbZDKVtf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 17:49:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BLhFuM025851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 14:43:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BLhEm6028545;
	Sat, 11 Apr 2009 14:43:14 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090411205044.GA21673@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116354>



On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
> >=20
> > And I think I can see why. The new code actually does a _better_ jo=
b of=20
> > the resulting list being in "recency" order, whereas the old code u=
sed to=20
> > output the root trees all together. Now they're spread out accordin=
g to=20
> > how soon they are reached.
>=20
> Hm, I don't think that was the case. When iterating over the commits,
> process_tree was called with commit->tree, and that added the root tr=
ee
> to the objects array as well as walking it to add all referenced obje=
cts.

Oh, you're right. We actually ended up walking the trees at that point,=
=20
so recency should be the same.=20

Hmm. Where does the difference in ordering come from, then?=20

			Linus
