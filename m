From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 09:35:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190921360.5594@intel-tinevez-2-302>
References: <1250509342.2885.13.camel@cf-48> <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302> <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48> <alpine.LFD.2.00.0908181246470.6044@xanadu.home> <m3fxbpneqe.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0908181537360.6044@xanadu.home> <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de> <alpine.LFD.2.00.0908181936130.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-174642320-1250667321=:5594"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 09:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdfhh-0006Q8-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 09:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbZHSHfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 03:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbZHSHfV
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 03:35:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:59795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751146AbZHSHfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 03:35:20 -0400
Received: (qmail invoked by alias); 19 Aug 2009 07:35:21 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 19 Aug 2009 09:35:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19X3JArLBNXCJrjNiO8ZfWrgN8FbQnvRNUaCE6Iyn
	KhGb1ZVmwUC0G2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.LFD.2.00.0908181936130.6044@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126512>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-174642320-1250667321=:5594
Content-Type: TEXT/PLAIN; charset=VISCII
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 18 Aug 2009, Nicolas Pitre wrote:

> On Wed, 19 Aug 2009, Johannes Schindelin wrote:
> 
> > But seriously, I miss a very important idea in this discussion: we 
> > control the Git source code.  So we _can_ add a upload_pack feature 
> > that a client can ask for after the first failed attempt.
> 
> Indeed.  So what do you think about my proposal?  It was included in my 
> first reply to this thread.

Did you not talk about an extension of the archive protocol?  That's not 
what I meant.  The archive protocol can be disabled for completely 
different reasons than to prevent restartable clones.

But you brought up an important point: shallow repositories.

Now, the problem, of course, is that if you cannot even get a single ref 
(shallow'ed to depth 0 -- which reminds me: I think I promised to fix 
that, but I did not do that yet) due to intermittent network failures, you 
are borked, as you said.

But here comes an idea: together with Nguy­n's sparse series, it is 
conceivable that we support a shallow & narrow clone via the upload-pack 
protocol (also making mithro happy).  The problem with narrow clones was 
not the pack generation side, that is done by a rev-list that can be 
limited to certain paths.  The problem was that we end up with missing 
tree objects.  However, if we can make a sparse checkout, we can avoid 
the problem.

Note: this is not well thought-through, but just a brainstorm-like answer 
to your ideas.

Ciao,
Dscho "who should shut up now and get some work done instead ;-)"

--8323329-174642320-1250667321=:5594--
