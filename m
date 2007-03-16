From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 09:21:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:21:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFBl-00009A-QA
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbXCPQVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbXCPQVy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:21:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:49745 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbXCPQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:21:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GGLYcD028317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 09:21:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GGLTCw016102;
	Fri, 16 Mar 2007 08:21:30 -0800
In-Reply-To: <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.484 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42373>



On Thu, 15 Mar 2007, Davide Libenzi wrote:
>
> Hacked up test case below ...

This one seems to do benchmarking with 8MB buffers if I read it right 
(didn't try).

The normal size for the performance-critical git objects are in the couple 
of *hundred* bytes. Not kilobytes, and not megabytes.

The most performance-critical objects for uncompression are commits and 
trees. At least for the kernel, the average size of a tree object is 678
bytes. And that's ignoring the fact that most of them are then deltified, 
so about 80% of them are likely just a ~60-byte delta.

		Linus
