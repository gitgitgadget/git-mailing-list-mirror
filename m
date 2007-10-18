From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-blame shouldn't crash if run in an unmerged tree
Date: Thu, 18 Oct 2007 15:38:23 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710181529490.26902@woody.linux-foundation.org>
References: <20071018063407.GA28861@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iie1X-0007gH-MN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbXJRWjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753901AbXJRWjM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:39:12 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46767 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757354AbXJRWjK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 18:39:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMcPmJ014026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2007 15:38:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMcNHO002119;
	Thu, 18 Oct 2007 15:38:24 -0700
In-Reply-To: <20071018063407.GA28861@spearce.org>
X-Spam-Status: No, hits=-4.716 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61566>



On Thu, 18 Oct 2007, Shawn O. Pearce wrote:
>
> I'm applying this patch to my maint tree tonight as it does resolve
> the issue for now.  What surprised me was the file that we were
> crashing out on wasn't even the file we wanted to get the blame
> data for.  :-\

Please feel free to add a Signed-off-by: there. I guess I didn't add it in 
the original email, because I wasn't sure if I'd have the energy to see if 
I could just remove the clearing of "ce_mode". I never did.

That whole "ce->ce_mode = 0" thing is really hacky, and we use it for two 
totally different things ("git read-tree" uses it for "delete this entry", 
and reading the index uses it when you ask for only merged entries). Bad 
form, and not very logical.

		Linus
