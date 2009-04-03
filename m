From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Fri, 3 Apr 2009 08:45:13 -0400
Message-ID: <20090403124512.GB21153@coredump.intra.peff.net>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org> <49D542FA.3070304@gmail.com> <alpine.DEB.1.00.0904030107320.10279@pacific.mpi-cbg.de> <49D54799.9010607@gmail.com> <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 14:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpinW-0003h8-67
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 14:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbZDCMp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 08:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbZDCMp3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 08:45:29 -0400
Received: from peff.net ([208.65.91.99]:50700 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754394AbZDCMp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 08:45:29 -0400
Received: (qmail 31520 invoked by uid 107); 3 Apr 2009 12:45:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 08:45:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 08:45:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904030447480.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115528>

On Fri, Apr 03, 2009 at 04:52:46AM +0200, Johannes Schindelin wrote:

> In case it was not clear yet: if I have to chose between following a 
> standard and reality that just took over, I will _always_ choose the 
> latter.

The problem with "reality" here is that it is not 100% case-insensitive
(and I'm not sure we have anything resembling actual data), and worse,
that the person using git and the person whose reality is case-sensitive
are _different_ people. So you could be breaking email addresses and
have no idea, because the case-sensitivity is implemented on some random
contributor's mail server.

That being said, this is actually restoring behavior broken only about 6
weeks ago (and looks like it was broken in 1.6.2, but no other release).
So I am inclined to say this patch should be applied regardless of
standards and reality if only because it is making git's behavior
consistent across versions. And it looks like Junio has already applied
it.

Now what git _should_ do is another question. Mailmap has been
lower-casing addresses since 5496523 (shortlog: handle email addresses
case-insensitively, 2006-11-19), and I don't think we've had a single
complaint or bug report. Which implies that either reality _is_
primarily case-sensitive, or that people are not actually feeding
mailmap'd addresses to mail servers. So if there is an issue, it is
certainly not pressing, and while I can see and support a concerned
somebody making a patch to address it, I am not that somebody.

Such a patch would have to take into account the very real use case
Dscho is handling, but also address some other real use case (like
cutting and pasting from shortlog output into a MUA).  I assume the
lower-casing is primarily used for aggregating similar addresses; we can
do better to _preserve_ case while matching insensitively (and if there
are multiple cases, then we pick one arbitrarily -- presumably that
address _is_ case insensitive if it was used both ways).

Doing my best to turn a flame war into an actual discussion of merit,

-Peff
