From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git performance
Date: Fri, 24 Oct 2008 16:10:09 -0700
Message-ID: <490255D1.8060804@pcharlan.com>
References: <000801c93483$2fdad340$8f9079c0$@com> <20081022203624.GA4585@coredump.intra.peff.net> <000901c93490$e0c40ed0$a24c2c70$@com> <49017F8F.3000908@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 01:11:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVoj-0007qW-OO
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 01:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbYJXXKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 19:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYJXXKP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 19:10:15 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:51821 "EHLO
	swarthymail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757642AbYJXXKM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 19:10:12 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a6.g.dreamhost.com (Postfix) with ESMTP id 39BAE1063D7;
	Fri, 24 Oct 2008 16:10:10 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <49017F8F.3000908@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99082>

Pete Harlan wrote:
> Edward Ned Harvey wrote:
>>> Yes, it does stat all the files. How many files are you talking about,
>>> and what platform?  From a warm cache on Linux, the 23,000 files kernel
>>> repo takes about a tenth of a second to stat all files for me (and this
>> I'm talking about 40-50,000 files, on multi-user production linux,
>> which means the cache is never warm, except when I'm benchmarking.
>> Specifically RHEL 4 with the files on NFS mount.  Cold cache "svn
>> st" takes ~10 mins.  Warm cache 20-30 sec.  Surprisingly to me,
> 
> I did some tests with a repo with ~32k files, and git was slightly
> slower than svn with a cold cache (10.2s vs 8.4s), and around twice as
> fast with a warm cache (.5s vs 1s).
> 
> Git 1.6.0.2, svn 1.4.6. Cache made cold with
> "echo 1 >/proc/sys/vm/drop_caches".  Timings best of 5 runs.

After redoing this test with "echo 3 >/proc/sys/vm/drop_caches" (which
also discards metadata, as pointed out by Linus), the cold-cache
timings are:

	svn 12.65 seconds
	git 10.3  seconds

So no Earth-shattering difference, but now git is somewhat quicker
than Subversion at everything I tested.

--Pete
