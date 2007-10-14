From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 00:14:46 +0200
Message-ID: <20071014221446.GC2776@steel.home>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 00:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhBk0-0004YF-6w
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 00:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461AbXJNWOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 18:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756492AbXJNWOt
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 18:14:49 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33010 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbXJNWOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 18:14:48 -0400
Received: from tigra.home (Fc8e3.f.strato-dslnet.de [195.4.200.227])
	by post.webmailer.de (klopstock mo56) (RZmta 13.4)
	with ESMTP id 5033f1j9ELUH9I ; Mon, 15 Oct 2007 00:14:46 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8B25A277AE;
	Mon, 15 Oct 2007 00:14:46 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 22A6356D22; Mon, 15 Oct 2007 00:14:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710142112540.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2U+g=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60916>

Johannes Schindelin, Sun, Oct 14, 2007 22:14:25 +0200:
> On Sun, 14 Oct 2007, Andreas Ericsson wrote:
> > Johannes Schindelin wrote:
> >
> > > I do not see any reason why libification helps the user experience on 
> > > Windows.
> > 
> > I was under the impression that the windows port suffers from Windows' 
> > lack of a proper fork() and friends and that a proper library would help 
> > solving those problems. Perhaps I was misinformed.
> 
> It suffered.  Until Hannes Sixt did a very fine job which cumulated in the 
> patch series he posted yesterday.  Of course, this work is the reason 
> msysGit is functional.
> 

Re "functional". Have to remind something (besides the fork):

Filesystem:

- no proper VFS (can't do anything with files opened elsewhere, and we
  have not enough error handling and diagnostic output to detect the
  problems)

- no proper filename semantics (case-insensitivity and stupid rules for
  allowed characters in filenames, like ":" in filenames in
  cross-platform projects)

- no acceptable level of performance in filesystem and VFS (readdir,
  stat, open and read/write are annoyingly slow)

- it is the only OS in the world with multi-root (/a/b/c and /a/b/c
  can be not the same, depending on what current "drive" is) and
  multi-cwd, which hasn't had formed itself into a problem yet, but
  surely will

- no real "mmap" (which kills perfomance and complicates code)

Interprocess communication:

- no reliable text environment (I'm programming in the damn thing for
  10 years and I still don't know how to pass an environment variable
  _for_sure_)

- it has only one argument (limited in size) passed to started
  programs, which means that there is no possible way to safely pass
  file and text arguments on command line (more than one, that is)
