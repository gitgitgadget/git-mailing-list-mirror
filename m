From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Also use unpack_trees() in do_diff_cache()
Date: Sun, 20 Jan 2008 15:58:22 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801201550550.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801200142170.5731@racer.site> <15ECE22B-FCBB-4F12-919B-694E48D48E0D@zib.de> <alpine.LSU.1.00.0801201515060.5731@racer.site> <alpine.LSU.1.00.0801201519320.5731@racer.site> <alpine.LFD.1.00.0801201144300.2957@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801201338140.2957@woody.linux-foundation.org> <alpine.LSU.1.00.0801202331380.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 00:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGk4G-00061h-Mr
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 00:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbYATX6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYATX6l
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 18:58:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53328 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859AbYATX6k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 18:58:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KNwNXc000498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Jan 2008 15:58:24 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0KNwMhx008400;
	Sun, 20 Jan 2008 15:58:22 -0800
In-Reply-To: <alpine.LSU.1.00.0801202331380.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.723 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71203>



On Sun, 20 Jan 2008, Johannes Schindelin wrote:
> 
> Note: "git diff HEAD" as it is now still holds value;

Oh, absolutely.

It's not "git diff HEAD" that is broken.

It's "git diff --cached HEAD" that doesn't work. The "--cached" means that 
it's supposed to diff the index against HEAD, but since it cannot handle 
unmerged entries, instead of getting a diff, you get just a line saying

	* Unmerged path xyzzy

and no diff at all.

That's the thing we should think about improving on (although it's not 
100% clear that a combined diff is the rigth thing either).

Anyway, to make it easier for people to follow along with this, I've put 
my whole series now on kernel.org in a "new-lstat" branch at:

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git new-lstat

(That git repo is a bit odd, it doesn't have any "master" branch at all, 
just that new-lstat one. I didn't want anybody to think that it's 
anything but a temporary git tree for this one series of patches. It 
will clone into an odd kind of repo that only has a "origin/new-lstat" 
remote branch, nothing else).

I'll probably rebase that thing if I keep working on it, but I think it's 
pretty good.

		Linus
