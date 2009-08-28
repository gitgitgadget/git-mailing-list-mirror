From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Fri, 28 Aug 2009 13:56:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908281349270.7434@intel-tinevez-2-302>
References: <1251337437-16947-1-git-send-email-johan@herland.net> <200908280103.06015.johan@herland.net> <alpine.DEB.1.00.0908281048320.7434@intel-tinevez-2-302> <200908281240.13311.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 13:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh043-0002Rf-22
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 13:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbZH1L4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 07:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbZH1L4J
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 07:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750862AbZH1L4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 07:56:08 -0400
Received: (qmail invoked by alias); 28 Aug 2009 11:56:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 28 Aug 2009 13:56:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VQH9fl6kVdGXYRE9SamcQsSUH38JZyqI/npj9MH
	VE7GkX504q6Tzp
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200908281240.13311.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127291>

Hi,

On Fri, 28 Aug 2009, Johan Herland wrote:

> On Friday 28 August 2009, Johannes Schindelin wrote:
>
> > And I can easily imagine a repository that has a daily note generated 
> > by an automatic build, and no other notes.  The date-based fan-out 
> > just wastes our time here, and even hurts performance.
> 
> What about a month-based fanout?

Well, I hoped to convince you that the date-based approach is too rigid.  
You basically cannot adapt the optimal data layout to the available data.

(I like to think of this issue as related to storing deltas: we let Git 
choose relatively freely what to delta against, and do not force a delta 
against the parent commit like others do; I think it is pretty obvious 
that our approach is more powerful.)

So the simplest (yet powerful-enough) way I could imagine is to teach the 
reading part to accept any fan-out (but that fan-out is really only based 
on the object name, nothing else), and to adjust the writing/merging part 
such that it has a maximum bin size (i.e. it starts a new fan-out whenever 
a tree object contains more than a config-specifyable limit).

I was certainly not thinking of something as complicated as Huffman.

Ciao,
Dscho
