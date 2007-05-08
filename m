From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk and git-gui, was Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 08:33:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705080830380.3974@woody.linux-foundation.org>
References: <57600.59393.qm@web38909.mail.mud.yahoo.com>
 <17983.63329.314321.305860@cargo.ozlabs.ibm.com> <20070508041939.GK11311@spearce.org>
 <Pine.LNX.4.64.0705081311550.4167@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>,
	Karl Hasselstr?m <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwX-0000Iz-Mk
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934744AbXEHPpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966965AbXEHPpe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:45:34 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:43132 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968264AbXEHPdd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 11:33:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l48FXBba023532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 May 2007 08:33:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l48FX9a8026723;
	Tue, 8 May 2007 08:33:10 -0700
In-Reply-To: <Pine.LNX.4.64.0705081311550.4167@racer.site>
X-Spam-Status: No, hits=-2.987 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46592>



On Tue, 8 May 2007, Johannes Schindelin wrote:
> 
> It might be a much better idea to write something a la git-fetch--tool, 
> which is a helper in C (thus very fast and memory efficient), outputting 
> easily parseable data. 

Well, we actually do have that. "git log" (or "git-rev-list") really does 
all the heavy lifting. The reason you can do things like "gitk --merge" is 
not because gitk itself has _any_ idea about anything, but because it just 
passes the arguments down to git-rev-list (and hopefully soon git log), 
which really does all the complex stuff.

But gitk still ends up having a big memory footpring, simply because if 
you get the data for a few hundred thousand commits (with commit messages 
etc), and have to keep track of the relationships between them, you are 
going to easily use hundreds of megs of memory.

		Linus
