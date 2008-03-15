From: Szeder =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Fix recent 'unpack_trees()'-related changes breaking 'git stash'
Date: Sat, 15 Mar 2008 12:31:54 +0100
Message-ID: <20080315113154.GA10921@elysium.homelinux.org>
References: <20080315014133.GB32265@neumann> <alpine.LFD.1.00.0803142023490.3557@woody.linux-foundation.org> <alpine.LFD.1.00.0803142133160.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 12:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaUdU-0004T3-IP
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 12:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbYCOLcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Mar 2008 07:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYCOLcF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 07:32:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:58959 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbYCOLcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Mar 2008 07:32:04 -0400
Received: from elysium (p5B132066.dip0.t-ipconnect.de [91.19.32.102])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1JaUcF0naO-0003lG; Sat, 15 Mar 2008 12:32:00 +0100
Received: by elysium (Postfix, from userid 1000)
	id 7B708124147; Sat, 15 Mar 2008 12:31:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803142133160.3557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Provags-ID: V01U2FsdGVkX19n8AKUO/Md67DIeg8v7J1wAFuyy0+jhXd1KnT
 0kjVwYVhXGUFV1UXOVTee49V7vDMfWfY5GrGiZRGWet99+GPSE
 bWT+TYquGdO+cwxgu1Xzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77322>

On Fri, Mar 14, 2008 at 09:40:02PM -0700, Linus Torvalds wrote:
> So it might be better to make that thing be just
>=20
> >  	memset(&o->result, 0, sizeof(o->result));
> > +	if (o->src_index)
> > +		o->result.timestamp =3D o->src_index->timestamp;
> >  	o->merge_size =3D len;
>=20
> instead of checking both src_index *and* dst_index. The source index =
is=20
> all that matters anyway. Even if 'o->result' isn't used in the end, w=
ho=20
> cares? We can still give it the right timestamp.
>=20
> And no, this really isn't likely to matter, but let's pick the simple=
r=20
> version if it doesn't matter.
I have applied the above patch and run both my stripped-down testcase
and t3903-stash.sh a couple thousand times without a single failure.


Best,
G=E1bor
