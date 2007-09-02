From: Johan Herland <johan@herland.net>
Subject: Re: Buffer overflows
Date: Sun, 02 Sep 2007 15:42:30 +0200
Message-ID: <200709021542.31100.johan@herland.net>
References: <1188502009.29782.874.camel@hurina>
 <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
 <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Timo Sirainen <tss@iki.fi>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 15:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRpj8-0005HD-J5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 15:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXIBNmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 09:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbXIBNmw
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 09:42:52 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54884 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467AbXIBNmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 09:42:51 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JNQ00A03U35LW00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 02 Sep 2007 15:42:41 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JNQ00IUQU2VN650@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 02 Sep 2007 15:42:31 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JNQ004PKU2VP590@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 02 Sep 2007 15:42:31 +0200 (CEST)
In-reply-to: <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57325>

On Friday 31 August 2007, Junio C Hamano wrote:
> It is well and widely understood idiom to use strlcpy to a
> fixed-sized buffer and checking the resulting length to make
> sure the result would not have overflowed (and if it would have,
> issue an error and die).  I would not have anything against a
> set of patches to follow such a pattern.
> 
> But a patch to add a non-standard API that nobody else uses,
> without any patch to show the changes to a few places that could
> use the API to demonstrate that the use of API vastly cleans the
> code up and makes it infinitely harder to make mistakes?
> 
> The API needs to justify itself to convince the people who needs
> to learn and adjust to that the benefit far outweighes deviation
> from better known patterns, and I do not see that happening in
> Timo's patch.

So in general, git people seem to be saying that:

1. Yes, we agree that the C string library suX0rs badly.

2. There are more than 0 string manipulation bugs (e.g. buffer overflows) in 
git. The number may be small or large, but I have yet to see anyone claim 
it's _zero_.

3. Timo's patches (in their current form) are not the way to go, because of 
non-standard API, implementation problems, whatever...

So why does the discussion end there? Lukas proposed an interesting 
alternative in "The Better String Library" ( 
http://bstring.sourceforge.net/ ). Why has there been lots of bashing on 
Timo's efforts, but no critique of bstring? I'd be very keen to know what 
the git developers think of it. AFAICS, it seems to fulfill at least _some_ 
of the problems people find in Timo's patches. Specifically, it claims:

- High performance (better than the C string library)
- Simple usage

I'd also say it's probably more widely used than Timo's patches.


If the only response to Timo's highlighting of string manipulation problems 
in git, is for us to flame his patches and leave it at that, then I have no 
choice but to agree with him in that security does not seem to matter to 
us.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
