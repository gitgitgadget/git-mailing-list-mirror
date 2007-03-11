From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/8] Teach run_command how to setup a stdin pipe
Date: Sat, 10 Mar 2007 20:45:33 -0500
Message-ID: <20070311014533.GA10343@spearce.org>
References: <20070310082808.GE4133@spearce.org> <Pine.LNX.4.63.0703101753440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 02:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQD89-0002R9-Lc
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 02:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbXCKBpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 20:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbXCKBpk
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 20:45:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXCKBpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 20:45:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQD7k-0005yc-Vg; Sat, 10 Mar 2007 20:45:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B8FFB20FBAE; Sat, 10 Mar 2007 20:45:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703101753440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41892>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 10 Mar 2007, Shawn O. Pearce wrote:
> 
> > Sometimes callers trying to use run_command to execute a child process 
> > will want to setup a pipe or file descriptor to redirect into the 
> > child's stdin.
> > 
> > This idea is completely stolen from builtin-bundle's fork_with_pipe, 
> > written by Johannes Schindelin.  All credit (and blame) should lie with 
> > Dscho.  ;-)
> 
> ;-)
> 
> Thank you for starting this thread. I think it makes a lot of sense in the 
> face of the MinGW port. (I am not interested in the hook stuff personally, 
> so I'll not comment on that.)

I'd like to see run_command learn how to also redirect stdout,
then replace fork_with_pipe in builtin-bundle with run_command.
We should be able to also improve some of our other more direct
uses of fork to use run_command at that point too.

I don't know squat about MinGW, so I don't know if having the
run_command abstraction really helps there or not, but I know we
tried to make it with the good intentions of being able to use it
to wrap that asinine CreateProcess() thing that Win32 has...

-- 
Shawn.
