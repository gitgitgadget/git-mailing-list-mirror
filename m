From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Thu, 24 Jan 2008 08:56:38 +0100
Message-ID: <20080124075638.GC3193@steel.home>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com> <20080121212015.GB5263@steel.home> <d997e2110801211345x6ee35d48s2038fbd773149110@mail.gmail.com> <20080122072825.GA2971@steel.home> <20080123081942.GM14871@dpotapov.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Desnoyer <mdesnoyer@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHwxT-0003D2-6P
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 08:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYAXH4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 02:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752828AbYAXH4l
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 02:56:41 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:19848 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbYAXH4k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 02:56:40 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKflQ==
Received: from tigra.home (Fab0b.f.strato-dslnet.de [195.4.171.11])
	by post.webmailer.de (klopstock mo7) (RZmta 15.4)
	with ESMTP id 605c35k0O7e5eg ; Thu, 24 Jan 2008 08:56:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5AA1E277AE;
	Thu, 24 Jan 2008 08:56:38 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 3DA1256D25; Thu, 24 Jan 2008 08:56:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080123081942.GM14871@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71598>

Dmitry Potapov, Wed, Jan 23, 2008 09:19:42 +0100:
> On Tue, Jan 22, 2008 at 08:28:25AM +0100, Alex Riesen wrote:
> > 
> > Were these subdirectories containing exclusively tracked files?
> > Or is it Winblows and some process was blocking the deletion?
> 
> The issue is not Windows specific and the problem can be reproduced
> with different versions of Git including the latest from Git master.
> 
> In fact, user B does not have to made any changes, it is enough that
> merge was not fast-forward. In contrast with fast-forward merge, which
> just update the references, the recursive merge requires the working
> directory to perform the merge. Because directories are not trucked,
> there is no way to tell at the end whether an empty directory was
> created by user before or it became empty as result of merge.

Right. I extended Cc a bit, to remind of the problem

> Probably, the problem can be solved by remembering the list of empty
> directories before performing a real merge and then, on success, to
> remove all empty directories that are not in that list.

Probably. It is all in merge-recursive.c
