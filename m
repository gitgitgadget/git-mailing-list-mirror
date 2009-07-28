From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 15:11:09 +0200
Message-ID: <200907281511.10010.trast@student.ethz.ch>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> <200907281353.07590.trast@student.ethz.ch> <alpine.DEB.1.00.0907281428220.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVmSo-0003Cd-9U
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZG1NLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbZG1NLU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:11:20 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:17323 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbZG1NLT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:11:19 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 15:11:18 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Jul 2009 15:11:18 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0907281428220.8306@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 28 Jul 2009 13:11:18.0466 (UTC) FILETIME=[E4F23A20:01CA0F84]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124246>

Johannes Schindelin wrote:
> 
> Inspecting reflogs is an interactive task, and I do not think that this 
> justifies the complications you suggested.  I can _easily_ say "git log 
> -g" and then "git show --date=relative <commit>".  Not that I _ever_ 
> needed such a thing.

That's something entirely different.  This series is about the date of
*reflog entries*; the git-show will give you the dates associated with
the *commit*.  The latter act naturally w.r.t. --date and are of no
concern to this discussion (other than not breaking them of course).

The reflog entries, OTOH, show numbers instead in "default" date mode,
leading people to do things like

  git reflog show HEAD@{now}
  git reflog --date=local

to see the reflog with dates instead of numbers.  (AFAICT 'reflog' in
this usage is equivalent to 'log -g --oneline' which is even more
typing, so I'm usually assuming 'reflog'.)

So the discussion on IRC was about making a shorthand like --date that
triggers display of the reflog dates.  This much can be solved by the
DATE_UNSPECIFIED value alone.

I just wasn't happy to leave it at that because that means people who
do set log.date now always get dates instead of numbers in the reflog.

> And what exactly does "--no-date" mean?  Does it not say _exactly_ what 
> "--date=unspecified" would _intuitively_ mean?

Maybe to someone who knows the implementation details.  To a user,
specifying --date=unspecified is probably a contradiction in terms,
and even if not, it does not show the date in some unspecified format
-- it hides it (again, for reflog dates).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
