From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: Test failures in t4034
Date: Sun, 19 Aug 2012 15:50:49 +0100
Message-ID: <5030FD49.6060704@ramsay1.demon.co.uk>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@student.ethz.ch>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:17:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Azz-0008A0-VV
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 21:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab2HSTQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 15:16:33 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:40712 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab2HSTQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 15:16:32 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id B94DEA0C081;
	Sun, 19 Aug 2012 20:16:28 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 11895A0C07F;	Sun, 19 Aug 2012 20:16:28 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sun, 19 Aug 2012 20:16:26 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203730>

Brian Gernhardt wrote:
> I've been getting a couple of test failures and finally had the time to track them down.
> 
> t4034-diff-words fails tests "22 diff driver 'bibtex'" and "26 diff driver 'html'".  Bisecting shows that the file started giving me errors in commit 8d96e72 "t4034: bulk verify builtin word regex sanity", which appears to introduce those tests.  I don't see anything obviously wrong with the tests and I'm not familiar with the diff-words code, so I'm not sure what's wrong.
> 
> I am running on OS X 10.8, with Xcode 4.4.1 (llvm-gcc 4.2.1).

I had the same problem (or at least it *looks* like the same problem) on Linux
last year (May 2011), which turned out to be a bug in the regex routines in an
old version of glibc. 

I don't know OS X at all, so this may not be relevent; does OS X use glibc?
(I didn't think so, but ...)

I sent some patches to the list which may be helpful. I can't get to gmane to
look up a reference, but you need to search for:

    [RFC/PATCH] userdiff.c: Avoid old glibc regex bug causing t4034-*.sh test failures

sent on 3rd May 2011.

Also, in the same thread, a reply to Jonathan Nieder on 7th May contains a
test which checks whether your regex routines suffer this bug.

These patches were not applied since I didn't think this would be a common
problem. I simply set NO_REGEX=1 in my config.mak, since the compat/ regex
routines don't suffer from this problem.

HTH

ATB,
Ramsay Jones
