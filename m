From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 14:42:22 -0500
Message-ID: <BirCl2sajPcjvVRXCRm_49PfnXalJDF2v7s7osz-X1yeRkkYOCL6ZQ@cipher.nrlssc.navy.mil>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com> <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 21:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7FBx-0006ZA-QS
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 21:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYFMTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYFMTnQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 15:43:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39616 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYFMTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 15:43:15 -0400
Received: by mail.nrlssc.navy.mil id m5DJgNLq031247; Fri, 13 Jun 2008 14:42:23 -0500
In-Reply-To: <7v3anhuonj.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 13 Jun 2008 19:42:23.0787 (UTC) FILETIME=[9A008FB0:01C8CD8D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84936>

Junio C Hamano wrote:

> To stash is like putting something in /tmp on a system that runs a cron
> job to clean out cruft from there once in a while.  Another analogy is to
> spitting an information out to syslog, so that it is kept until logs are
> rotated.

I like my analogy better. :)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index baa4f55..119117e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -17,7 +17,11 @@ DESCRIPTION
 Use 'git-stash' when you want to record the current state of the
 working directory and the index, but want to go back to a clean
 working directory.  The command saves your local modifications away
-and reverts the working directory to match the `HEAD` commit.
+and reverts the working directory to match the `HEAD` commit. You should
+think of the stash like a garbage can in which you place your temporary
+work and then bring out to the curb. If you are quick to use your stashed
+changes you can get them before garbage collection occurs (it's every
+Tuesday where I live, but git does it every 30 days).
 
 The modifications stashed away by this command can be listed with
 `git-stash list`, inspected with `git-stash show`, and restored
