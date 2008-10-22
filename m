From: "Edward Ned Harvey" <git@nedharvey.com>
Subject: RE: git performance
Date: Wed, 22 Oct 2008 17:55:14 -0400
Message-ID: <000901c93490$e0c40ed0$a24c2c70$@com>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:56:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kslh6-0007MR-2m
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552AbYJVVza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757565AbYJVVz3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:55:29 -0400
Received: from mail.itekmail.com ([208.86.156.243]:45526 "EHLO
	mail.itekmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbYJVVz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Oct 2008 17:55:28 -0400
X-Spam-Status: No, hits=0.0 required=2.5
	tests=AWL: 0.227,BAYES_00: -1.665,TOTAL_SCORE: -1.438
X-Spam-Level: 
Received: from carmel ([98.110.160.127])
	(authenticated user rahvee@nedharvey.com)
	by mail.itekmail.com
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128 bits))
	for git@vger.kernel.org;
	Wed, 22 Oct 2008 16:55:25 -0500
In-Reply-To: <20081022203624.GA4585@coredump.intra.peff.net>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ack0kNwEd0CByfuaTJCObkQ3jAbMNw==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98917>

> Yes, it does stat all the files. How many files are you talking about,
> and what platform?  From a warm cache on Linux, the 23,000 files kernel
> repo takes about a tenth of a second to stat all files for me (and this
> on a several year-old machine). And of course many operations don't
> require stat'ing at all (like looking at logs, or diffs that don't
> involve the working tree).

No worries.  No solution can meet everyone's needs.

I'm talking about 40-50,000 files, on multi-user production linux, which means the cache is never warm, except when I'm benchmarking.  Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn st" takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me, performance was approx the same for files on local disk versus NFS.  Probably the best solution for us is perforce, we just don't like the pricetag.

Out of curiosity, what are they talking about, when they say "git is fast?"  Just the fact that it's all local disk, or is there more to it than that?  I could see - git would probably outperform perforce for versioning of large files (let's say iso files) to benefit from sustained local disk IO, while perforce would probably outperform anything I can think of, operating on thousands of tiny files, because it will never walk the tree.
