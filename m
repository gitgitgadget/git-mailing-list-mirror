From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Some git performance measurements..
Date: Fri, 30 Nov 2007 07:11:35 +0100
Message-ID: <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711282244190.9605@xanadu.home> <alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711291208060.9605@xanadu.home> <finmvm$da8$1@ger.gmane.org> <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org> <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 07:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixz6c-0003M3-Nl
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 07:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXK3GLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 01:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbXK3GLp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 01:11:45 -0500
Received: from mailer.zib.de ([130.73.108.11]:39042 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbXK3GLo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 01:11:44 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAU6ASax020339;
	Fri, 30 Nov 2007 07:10:29 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83fde.pool.einsundeins.de [77.184.63.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAU6AONA023921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 30 Nov 2007 07:10:28 +0100 (MET)
In-Reply-To: <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66617>


On Nov 30, 2007, at 3:40 AM, Nicolas Pitre wrote:

> On Thu, 29 Nov 2007, Linus Torvalds wrote:
>
>> On Fri, 30 Nov 2007, Jakub Narebski wrote:
>>>
>>> Isn't there a better way to do this sorting? What is needed here is
>>> (stable) _bucket_ sort / _pigeonhole_ sort (or counting sort), which
>>> is O(n); quicksort is perhaps simpler to use, but I'm not sure if
>>> faster in this situation.
>
> That particular sort takes under a second here with the Linux repo.
> Pretty insignificant compared to the time required to repack.


Brian Downing measured horrid performance of qsort on Windows
2000 [1].  qsort seems to show worst case behaviour.

This resulted in a patch replacing Window's qsort implementation
for the mingw port [2].

[1] http://thread.gmane.org/gmane.comp.version-control.msysgit/1084
[2] http://thread.gmane.org/gmane.comp.version-control.msysgit/1086


Avoiding qsort would even be better.  I'm not sure, though,
if the particular qsort call that triggered the current
discussion, is the very same qsort call that Brian was hit by.
I'm only claiming that in general avoiding qsort on Windows
is a good idea.

	Steffen
