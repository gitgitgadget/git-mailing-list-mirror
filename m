From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 00:26:01 +0100
Message-ID: <200801120026.01930.robin.rosenberg@dewire.com>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org> <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:54:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTi1-0003j6-Pu
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbYAKXyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 18:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756868AbYAKXyP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:54:15 -0500
Received: from [83.140.172.130] ([83.140.172.130]:7909 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756751AbYAKXyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:54:14 -0500
X-Greylist: delayed 1683 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2008 18:54:14 EST
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 98A9780267F;
	Sat, 12 Jan 2008 00:26:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sidBBvTqjjo; Sat, 12 Jan 2008 00:26:08 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 12552802643;
	Sat, 12 Jan 2008 00:26:07 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70225>

fredagen den 11 januari 2008 skrev Linus Torvalds:
> I do agree that we could/should do something to help with case-insensitive 
> filesystems.
> 
> I absolutely *detest* those things, and I think that people who design 
> them are total morons - with MS-DOS, you could understand it (people 
> didn't know better), but with OS X?

Could it be some comfort that the other SCM's I know of make a mess of
these cases, regardless of the number of digits in the price tag.

[...]

> Almost all of the code that actually touches the index is in read-cache.c, 
> and it's not like that is a very complex data structure (or a very big 
> file), so adding another key to the sorting probably wouldn't be too 
> horrid. But it's definitely a lot more than just a few lines of code!

Could we just have a lookup table index extension for identifying the 
duplicates (when checking is enabled using core configuration option #3324)? 
That table would keep a mapping from a normalized form (maybe include 
canonical encoding while we're at it) to the actual octet sequence(s) used.

Many operations would translate any supplied form throug the table before
doing the lookup so if we have Foo.h and give FOO.h to git add, it would 
notice and perform add (update index) on Foo.h instead as that is the form we 
alreay know (or refuse yielding an error message; pick your poison). And, 
well you get the picture.

-- robin
