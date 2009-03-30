From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Tue, 31 Mar 2009 01:29:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903310128410.10279@pacific.mpi-cbg.de>
References: <20090321154738.GA27249@jeeves.jpl.local> <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de>
 <20090329224803.GD27249@jeeves.jpl.local> <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302> <20090330051118.GA2681@atjola.homenet> <20090330220709.GA68118@macbook.lan>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1049516874-1238455758=:10279"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	=?ISO-8859-15?Q?Magnus_B=E4ck?= <baeck@swipnet.se>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 01:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQub-00028Q-Oz
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 01:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765AbZC3X1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 19:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbZC3X1E
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 19:27:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:39637 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754120AbZC3X1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 19:27:03 -0400
Received: (qmail invoked by alias); 30 Mar 2009 23:26:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 31 Mar 2009 01:26:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bF38SiefbM3lm6Alk2vbfE2GIX6QHIjGbccDLKD
	9raEY//dICpGDS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090330220709.GA68118@macbook.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115200>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1049516874-1238455758=:10279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 31 Mar 2009, Heiko Voigt wrote:

> On Mon, Mar 30, 2009 at 07:11:18AM +0200, Björn Steinbrink wrote:
> > On 2009.03.30 02:52:47 +0200, Johannes Schindelin wrote:
> > > On Mon, 30 Mar 2009, Magnus Bäck wrote:
> > > > On Friday, March 27, 2009 at 03:25 CET, Johannes Schindelin 
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > > > On Thu, 26 Mar 2009, Magnus Bäck wrote:
> > > > > > I'd be very surprised if ZwQueryDirectoryFile() hasn't always 
> > > > > > been around (I just verified ntdll.dll from NT 4.0), so that's 
> > > > > > not a worry. Don't know why MSDN reports it as introduced in 
> > > > > > XP.
> > > > >
> > > > > As the current maintainer of msysGit, I refuse to have something 
> > > > > in the installer I ship that relies on not-at-all guaranteed 
> > > > > interfaces.
> > > > 
> > > > Although I do appreciate the importance of guaranteed interfaces, 
> > > > I am also pragmatic. An incompatible change in ntdll.dll would 
> > > > break vast amounts of programs, including cygwin. There is a lot 
> > > > to be said about Microsoft and their APIs, but I don't think they 
> > > > have a habit of changing ABIs or function semantics for userland 
> > > > libraries that have been around for 15 years.
> > > 
> > > Had you pointed to some document that states that the function has 
> > > been in all NT-based versions, that would have done the trick.
> > 
> > Not official documentation, but at least from some MS guy it seems: 
> > http://www.osronline.com/showThread.cfm?link=73086 (last message).
> > 
> > Apparently, it was in NT3.x, but they document only what's actually 
> > defined in the header.
> 
> How about runtime checking? You could do GetProcAddress(...) and if you 
> don't get it use the old behaviour. I mean if it really is faster why 
> not let Users of recent systems benefit from it.

While my first reaction was negative, I have to admit that thinking about 
it longer, it does seem to make a whole lot of sense.

Thanks,
Dscho

--8323328-1049516874-1238455758=:10279--
