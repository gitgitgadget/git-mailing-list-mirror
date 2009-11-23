From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: split implications of --all-progress from
 progress activation
Date: Mon, 23 Nov 2009 13:27:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911231323010.2059@xanadu.home>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
 <20091123181206.GD26996@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:39:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdoP-0005mY-3b
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbZKWSio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbZKWSio
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:38:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53054 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbZKWSio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:38:44 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KTK00KUYR9EA860@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Nov 2009 13:27:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091123181206.GD26996@machine.or.cz>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133523>

On Mon, 23 Nov 2009, Petr Baudis wrote:

> On Mon, Nov 23, 2009 at 12:43:50PM -0500, Nicolas Pitre wrote:
> > Currently the --all-progress flag is used to use force progress display 
> > during the writing object phase even if output goes to stdout which is 
> > primarily the case during a push operation.  This has the unfortunate 
> > side effect of forcing progress display even if stderr is not a 
> > terminal.
> > 
> > Let's introduce the --all-progress-implied argument which has the same 
> > intent except for actually forcing the activation of any progress 
> > display.  With this, progress display will be automatically inhibited 
> > whenever stderr is not a terminal, or full progress display will be 
> > included otherwise.  This should let people use 'git push' within a cron 
> > job without filling their logs with useless percentage displays.
> > 
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> 
> Ok, but what is currently the way to force the old behaviour?

If any existing out-of-tree users of pack-objects were using 
--all-progress then nothing has changed for them.

> I believe that should be also part of the commit message.
> 
> Naive deduction fails:
> 
> 	$ git remote update --progress
> 	error: unknown option `progress'

Usage of 'git remote" is about fetching and not pushing, right? My patch 
only affects pushes.  So I don't know what old behavior you're after.


Nicolas
