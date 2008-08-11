From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict  
 resolution.
Date: Mon, 11 Aug 2008 17:54:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111748220.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811104006.GH32184@machine.or.cz>
 <alpine.DEB.1.00.0808111328590.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48A0274D.8090504@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Abhijit Menon-Sen <ams@toroid.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZfA-0005RB-1z
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbYHKPtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYHKPtZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:49:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:41436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752157AbYHKPtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:49:24 -0400
Received: (qmail invoked by alias); 11 Aug 2008 15:49:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 11 Aug 2008 17:49:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Fbe0eySYFaSryI4LWJ2+/ME6pVaFOFWh5Fw2PX2
	1wIMVG3Dz3NiwT
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48A0274D.8090504@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91949>

Hi,

On Mon, 11 Aug 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > That would actually be a problem, no?  I am not sure that resolutions 
> > for reverts make sense for cherry-picks, so I am not sure if 
> > resolutions should be recorded for reverts.
> 
> Of course they should.

Are you sure?

> If the reversal is part of a topic branch that you rebase at least once, 
> then you want to have the resolutions recorded, don't you?

That is not the revert we are talking about.  The revert we are talking 
about is a literal "git revert <commit>".  Not a replay of a commit (that 
might have been a revert originally).

I am a little worried that these reverts (being negative changes) could 
interfer with the common operation: positive changes.  Although I haven't 
been able to come up with a scenario where the recorded revert would 
actively be wrong in a subsequent rebase/cherry-pick.

Yes, I see your point that a revert on a topic branch which is then 
rebased would be nice to have its resolution recorded; that will happen 
with the first rebase, though.

However, if my suspicion is true, recording the resolution only with the 
first rebase could make things safer overall, because an occasional 
temporary revert would not affect later cherry-picks in an unintuitive 
way.

Thinking about a good example, or a counterexample,
Dscho
