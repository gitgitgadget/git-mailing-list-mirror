From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) && unlink(src) when that is unreliable
Date: Sat, 25 Apr 2009 20:50:10 +0200
Message-ID: <200904252050.10306.j6t@kdbg.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de> <7vbpqkznjs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxmyb-0004kg-Oe
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZDYSuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbZDYSuP
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:50:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34215 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbZDYSuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 14:50:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C66E22C4009;
	Sat, 25 Apr 2009 20:50:10 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8BF424259F;
	Sat, 25 Apr 2009 20:50:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vbpqkznjs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117570>

On Samstag, 25. April 2009, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> > has an unnerving bug: if you link() a file and unlink() it right away,
> > the target of the link() will have the correct size, but consist of NULs.
> >
> > It seems as if the calls are simply not serialized correctly, as
> > single-stepping through the function move_temp_to_file() works
> > flawlessly.
> >
> > As ufsd is "Commertial software" (sic!), I cannot fix it, and have to
> > work around it in Git.
> >
> > At the same time, it seems that this fixes msysGit issues 222 and 229 to
> > assume that Windows cannot handle link() && unlink().
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Acked-by: Johannes Sixt <j6t@kdbg.org>
>
> Hannes, are you ok with this?

Yes. We have been using rename() instead of link() on Windows until recently 
anyway (until link() was implemented, 7be401e06, 2009-01-24). There is no 
regression to be expected from this side.

-- Hannes
