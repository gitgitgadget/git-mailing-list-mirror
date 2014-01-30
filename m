From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Questions on local clone and push back
Date: Thu, 30 Jan 2014 09:13:10 -0500
Message-ID: <B7DBC99A-910F-4BBF-90BB-7F0DBFF5E864@kellerfarm.com>
References: <CACdn6eksz0q1+_JHwF=wKP_ziUFzhB5ij93A3-BEap3kosipFg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Arshavir Grigorian <grigorian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 15:20:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8sTK-0005AA-I4
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 15:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbaA3OTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 09:19:55 -0500
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.56]:41023 "EHLO
	atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752846AbaA3OTy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 09:19:54 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2014 09:19:54 EST
Received: from atl4mhob09.myregisteredsite.com (atl4mhob09.myregisteredsite.com [209.17.115.47])
	by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s0UEDMuh010922
	for <git@vger.kernel.org>; Thu, 30 Jan 2014 09:13:22 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob09.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s0UEDBn5020951
	for <git@vger.kernel.org>; Thu, 30 Jan 2014 09:13:11 -0500
Received: (qmail 12182 invoked by uid 0); 30 Jan 2014 14:13:11 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 30 Jan 2014 14:13:11 -0000
In-Reply-To: <CACdn6eksz0q1+_JHwF=wKP_ziUFzhB5ij93A3-BEap3kosipFg@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241269>

On Jan 30, 2014, at 12:43 AM, Arshavir Grigorian <grigorian@gmail.com> wrote:

> 1) is this a good approach to achieving what I need

If you do not intend to track the parent projects in Git, then yes - that is a good approach.

With that said, I recommend tracking each parent project in its own Git repository, and track the shared code in yet another Git repository, and link them using submodule references.

> 2) I was getting an error when I tied to run "git push" about the branch being checked out and

What's the error when you use the more explicit syntax, `git push <remote> <branch>`?  Depending on configuration, simply `git push` might not have all the information it needs to work.

> 3) how do I selectively push / merge only certain commits back to the "source" repository / branch?

You can't.  When pushing, pulling, or merging, you can only deal with subsections of the commit graph.

With that said, you can rebuild parts of the commit graph using selected commits.  Then, that result can be pushed, pulled, or merged.

In my experience, you want to avoid picking and choosing commits in the shared repository for each parent project.  Maintaining the shared repository is difficult enough.  I advise that you find a way to make your shared code configurable for each project, such that you can have one "master" branch for all, and each project just uses or configures the code differently.  With that said, try to keep your configurations to a minimum (within reason) - in general, the more configurations you have, the more difficult the shared library will be to maintain.

Hope that helps,
 - Andrew
