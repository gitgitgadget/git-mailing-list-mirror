From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 12:57:00 -0700
Message-ID: <45FEEB0C.3080602@midwinter.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home> <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, John Goerzen <jgoerzen@complete.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:57:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTNz3-0000NN-SI
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 20:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbXCST46 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbXCST46
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 15:56:58 -0400
Received: from tater.midwinter.com ([216.32.86.90]:50031 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753044AbXCST45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 15:56:57 -0400
Received: (qmail 8295 invoked from network); 19 Mar 2007 19:56:56 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.129?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 Mar 2007 19:56:56 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.64.0703191145530.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42660>

Linus Torvalds wrote:
> It's much worse than that. I will *guarantee* that renames are missed when 
> they come in as traditional patches, for example. That's a 100% error rate 
> right there, not some "1%" one.
>   

That's an argument that the content-based rename detector is valuable 
and shouldn't be ditched, a sentiment with which I completely agree. It 
is a fabulous piece of work and handles cases that none of git's 
competitors get right, such as patches or tracking upstream 
distributions or tracking renames made by non-git-aware tools.

However, "Should we keep the existing rename detection?" is not the same 
question as, "Should the user be able to tell the system he's renaming 
something?" Or rather, given we already have git mv, "Should the system 
remember that the user has told it he's renaming something?" Right now 
git is throwing away metadata the user is feeding to it, metadata that 
could be used to eliminate the chance of a subsequent failure. As long 
as that metadata is used in *addition* to the existing logic, rather 
than as a *replacement*, the downside seems minimal. You won't have it 
in the case of a patch, granted, but that just means patches will use 
the existing, almost-always-right, rename detection, no harm done.

> So learn to love the bomb. Rename tracking is *wrong*. 
>   

Until someone comes up with a way to make content-based rename detection 
100% foolproof in the face of things like frequent self-references in 
Java or C++ classes, it may be a necessary evil (or at least a 
worthwhile one.)

-Steve
