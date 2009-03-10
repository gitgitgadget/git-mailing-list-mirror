From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 15:46:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101545540.14295@intel-tinevez-2-302>
References: <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302> <49B64ADC.2090406@viscovery.net>
 <49B64C3A.50909@viscovery.net> <alpine.DEB.1.00.0903101236480.14295@intel-tinevez-2-302> <49B659B4.5000705@viscovery.net> <alpine.DEB.1.00.0903101343530.14295@intel-tinevez-2-302> <49B6788F.2080609@viscovery.net> <20090310143851.GP11989@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com, Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 15:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3FP-0002S3-JZ
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 15:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbZCJOq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 10:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbZCJOq3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 10:46:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:35590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752592AbZCJOq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 10:46:28 -0400
Received: (qmail invoked by alias); 10 Mar 2009 14:46:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Mar 2009 15:46:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DwTBi1HLDcer9EKm3NZLtoIEvL/yCUtl9Y9+w33
	yPl/F4P23vuRWk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090310143851.GP11989@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112821>

Hi,

On Tue, 10 Mar 2009, Shawn O. Pearce wrote:

> Johannes Sixt <j.sixt@viscovery.net> wrote:
> > But don't you see that are mixing a high-level concept of "terminal" 
> > into the low-level function that you want it to be? In its current 
> > form, recv_sideband() is *not* a low-level utility, it's already at a 
> > high level that knows about the line-oriented nature of band #2. What 
> > you need for GitTorrent is a different function that *only* 
> > demultiplexes the sideband protocol data into different streams 
> > without munging them. That's a totally different function that *maybe* 
> > can share some code with the current recv_sideband().
> 
> ACK.
> 
> The definition of the streams in the current sideband protocol are 
> rather well defined for the one protocol that uses it, 
> fetch-pack/receive-pack:
> 
>   stream #1:  pack data
>   stream #2:  stderr messages, progress, meant for tty
>   stream #3:  oh-sh*t abort message, remote is dead, goodbye!
> 
> The stream number is encoded as a byte.  Anyone trying to reuse the 
> sideband protocol within the fetch-pack/receive-pack protocol to carry 
> *extra* data should use new channel numbers.  We have another 252 
> remaining.  I don't think we're lacking on description space.

Fair enough, the tie-breaker hath spoken.

Ciao,
Dscho
