From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Community Book
Date: Fri, 5 Sep 2008 13:27:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809051317510.3117@nehalem.linux-foundation.org>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 22:29:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbhvo-0003vN-1c
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 22:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbYIEU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 16:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbYIEU2R
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 16:28:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59277 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbYIEU2R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 16:28:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m85KRi33004116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Sep 2008 13:27:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m85KRhcp018903;
	Fri, 5 Sep 2008 13:27:44 -0700
In-Reply-To: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95039>



On Fri, 5 Sep 2008, Scott Chacon wrote:
> 
> http://book.git-scm.com/7_the_packfile.html 

The checksums in the index file "trailers" are all claiming to be 4 bytes, 
and that's wrong - they're full SHA1 sums at 20 bytes each.

The v2 pack-file _also_ has per-object CRC's, and those are indeed just 4 
bytes each, and are correctly listed as such.

The pack-file itself also has a few more things there, it's not just the 
"PACK" string and then the objects. It has two more 32-bit words: a pack 
file version number and the number of entries in the pack-file (all 
network byte order). It also has its own checksum at the end (20-byte SHA1 
again).

But looks good otherwise from a quick look.

		Linus
