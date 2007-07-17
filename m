From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 15:34:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707171532070.27353@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
 <20070717212103.11950.10363.julian@quantumfyre.co.uk> <20070717214011.GU19073@lavos.net>
 <20070717214510.GV19073@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 00:36:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAveI-0000TS-3m
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 00:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759298AbXGQWgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 18:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758322AbXGQWgA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 18:36:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42983 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754845AbXGQWf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 18:35:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HMYgEp031636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2007 15:34:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6HMYaAV010285;
	Tue, 17 Jul 2007 15:34:37 -0700
In-Reply-To: <20070717214510.GV19073@lavos.net>
X-Spam-Status: No, hits=-4.665 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52806>



On Tue, 17 Jul 2007, Brian Downing wrote:
> 
> D'oh, now I know why.  I'm trying git to keep my home directory config
> stuff versioned, so GIT-VERSION-GEN, failing to find a .git directory
> in my tar export, digs down and finds my home directory one instead.

Ok, that's definitely a git misfeature.

I think we could probably add a check something like:

 - once we have found a .git directory by walking up the tree, the 
   directory we actually came _from_ should then be tracked by that git 
   directory.

but I wonder how to do that properly (we would probably need to load the 
index, which we generally don't want to do).

		Linus
