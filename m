From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Fri, 31 Oct 2008 22:40:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810312236490.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzatdbtk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0810311753080.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vk5bo8y3m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:34:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1dQ-00074A-IX
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYJaVdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYJaVdM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:33:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:41301 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751574AbYJaVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:33:10 -0400
Received: (qmail invoked by alias); 31 Oct 2008 21:33:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 31 Oct 2008 22:33:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tbmFWg82tFkTfPrWc1mgbwEFohOt1yr/Ym9i6rA
	GliQ3RhN3GR7Ab
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vk5bo8y3m.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99646>

Hi,

On Fri, 31 Oct 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 30 Oct 2008, Junio C Hamano wrote:
> >
> >> I wonder if it would help breaking down cmd_log_init() a bit like this.
> >
> > Sorry, I am quite busy (this is the first time I am able to check my 
> > mail since the GitTogether), so I cannot look at that in detail.
> >
> > However, I strongly expect your suggestion not to help: for showing 
> > commits, we _want_ recursive to be the default.  And switching that on 
> > devoids us from being able to DIFF_OPT_TST(.., RECURSIVE) to detect if 
> > the user said '-r' _explicitely_.
> 
> You can turn on recursive unconditionally for the normal "show 
> committish" case, and check for explicit "-r" for "show treeish" that 
> was bolted-on much later, can't you?

No, I can't, because cmd_show() uses setup_revisions() (actually, this 
is called by cmd_log_init()) not only to parse the command line arguments, 
but also the objects to show.

The only way I could imagine this working is to turn _off_ FORMAT_PATCH, 
do the parsing, then check if RECURSIVE was set, then turn _on_ 
FORMAT_PATCH and call diff_setup_done().

But that feels just as awful.

Ciao,
Dscho
