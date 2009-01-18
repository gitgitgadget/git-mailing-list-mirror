From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] contrib/workdir: create logs/refs and rr-cache in the
	origin repository
Date: Sun, 18 Jan 2009 12:38:30 +0100
Message-ID: <20090118113830.GA1394@chistera.yi.org>
References: <1232208943-31756-1-git-send-email-dato@net.com.org.es> <7vbpu54cxe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 12:39:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOW0U-0001rl-5w
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 12:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765111AbZARLif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 06:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764964AbZARLie
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 06:38:34 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2779
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764345AbZARLid (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 06:38:33 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A62CF801C025;
	Sun, 18 Jan 2009 12:38:31 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LOVz4-0000aG-Ol; Sun, 18 Jan 2009 12:38:30 +0100
Content-Disposition: inline
In-Reply-To: <7vbpu54cxe.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106173>

* Junio C Hamano [Sat, 17 Jan 2009 17:31:57 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > If logs/refs or rr-cache are dangling symlinks in the workdir, and =
reflogs
> > and/or rerere are enabled, commit will die with "fatal: Could not c=
reate
> > directory". (In the case of rr-cache, it will die after having crea=
ted the
> > commit.)

> > This commit just creates logs/refs and rr-cache in the origin repos=
itory if
> > they don't exist already.

> Hmm, is that better than not creating the symlink of the borrowed
> repository does not have them?

I would say so. I'll agree this covers a less common case, because one
normally starts a regular repo, work on it, and at some point realize
you'd like another checkout, and create a workdir. By that point, logs/=
refs
surely should exist in the original repo.

However, I've as of late directly created bare repositories knowing tha=
t
I wanted to work just with workdirs against it. In this case, the logs
for each checkout'ed branch will be stored in the workdirs and not the
repo, so deleting the workdir will make you lose those logs. Which is
bad, since workdirs should always be safe to delete.

As I said, I realized this is a bit of a cornercase, but I think it
would be nice solving in the proposed way. (If you want, I can put a
shorter version of the above rationale in the commit message.)

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
La m=C3=BAsica es de los que la quieren escuchar y de nadie m=C3=A1s.
                -- Andr=C3=A9s Calamaro
