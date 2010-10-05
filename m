From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: large files and low memory
Date: Wed, 6 Oct 2010 00:51:50 +0200
Message-ID: <20101005225150.GA27633@nibiru.local>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com> <20101005005003.GA2768@nibiru.local> <alpine.LFD.2.00.1010051504530.3107@xanadu.home>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 00:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3GRT-00034E-Av
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab0JEW47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 18:56:59 -0400
Received: from caprica.metux.de ([82.165.128.25]:35914 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758039Ab0JEW46 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 18:56:58 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o95Mw1jb010782
	for <git@vger.kernel.org>; Wed, 6 Oct 2010 00:58:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o95Mw1gr010771
	for git@vger.kernel.org; Wed, 6 Oct 2010 00:58:01 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o95MpoiK002776
	for git@vger.kernel.org; Wed, 6 Oct 2010 00:51:50 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010051504530.3107@xanadu.home>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158258>

* Nicolas Pitre <nico@fluxnic.net> wrote:

> > > The mmap() isn't the problem.  Its the allocation of a buffer that is
> > > larger than the file in order to hold the result of deflating the file
> > > before it gets written to disk.  
> > > When the file is bigger than physical memory, the kernel has to
> > > page in parts of the file as well as swap in and out parts of
> > > that allocated buffer to hold the deflated file.
> > 
> > What are the access pattern of these memory areas ?
> 
> Perfectly linear.

In this case, I wonder why my machine goes into thrashing so easily
(P3 w/ 256MB ram). Seems the mmu/paging code doesnt recognize that
the previously-used pages can be kicked-off quickly ;-o
Perhaps I should talk to the kernel folks.

> > Perhaps madvise() could help ?
> 
> Perhaps.

hmm, so we should try it ;-p
where'd be the right place to add it ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
