From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
	returns st_size 0
Date: Mon, 21 Jul 2008 21:43:22 +0200
Message-ID: <20080721194322.GA4013@blimp.local>
References: <20080721173511.GB5387@steel.home> <alpine.DEB.1.00.0807211917440.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:45:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL1JT-00025k-3E
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbYGUTnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbYGUTnx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:43:53 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:10386 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538AbYGUTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:43:52 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4EbVSQ==
Received: from tigra.home (Faa8f.f.strato-dslnet.de [195.4.170.143])
	by post.webmailer.de (klopstock mo57) (RZmta 16.47)
	with ESMTP id w0362bk6LGVJHm ; Mon, 21 Jul 2008 21:43:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 6B572277BD;
	Mon, 21 Jul 2008 21:43:50 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 3DAEF36D17; Mon, 21 Jul 2008 21:43:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807211917440.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89396>

Johannes Schindelin, Mon, Jul 21, 2008 20:20:43 +0200:
> Hi,
> 
> On Mon, 21 Jul 2008, Alex Riesen wrote:
> 
> > For example - Cygwin.
> 
> Please enhance: your oneline is too long, and your commit message body too 
> short.

Well, I'm really not sure. I just found this difference between linux
and cygwin (st_stat is 0 for dirs on cygwin). Than I noticed that the
routine where I made the change explicitely checks for st_size not
being 0. I must admit I can't make much out of comment, and hope this
discussion will help to clear the check up.

> > Can MSys folks please try it? I noticed it when the test
> > t2103-update-index-ignore-missing.sh (the 5th case) started failing.
> 
> Since M$' documentation says "This member does not have a meaning for 
> directories." about the member nFileSizeLow of WIN32_FILE_ATTRIBUTE_DATA 
> which we use to implement a sane "lstat()", I think this bug hits MinGW 
> (not MSys) as well.

Could you, just for completeness, try? I don't have mingw at hand
and SUSv3 (http://www.opengroup.org/onlinepubs/009695399/toc.htm)
does not tells much too. No UNIX system I know about has it 0 for
directories.
