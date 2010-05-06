From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 10:15:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org>
References: <4BE141E3.2060904@gmail.com> <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>  <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com> <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wilbert van Dolleweerd <wilbert@arentheym.com>, git@vger.kernel.org
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 19:17:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA4hH-0001lI-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092Ab0EFRRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 13:17:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56894 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753388Ab0EFRRB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 13:17:01 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46HGwro022893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 May 2010 10:16:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46HGvVR003227;
	Thu, 6 May 2010 10:16:58 -0700
In-Reply-To: <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.446 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146485>



On Thu, 6 May 2010, hasen j wrote:
> 
> I don't know all linux editors, but I've yet to see one that can't
> handle CRLF endings.

A _lot_ of UNIX editors will handle CRLF endings, but if you change a 
file, they often write the result back with _mixed_ endings. Some will 
also show the CR as '^M' or some other garbage at the end.

A number of tools will also end up confused, including very fundamental 
things like "grep". Try this:

	echo -e "Hello\015" > f
	grep 'Hello$' f

and notice how the grep does _not_ find the Hello at the end of the line, 
because grep sees another random character there (this might be 
unportable, I could easily imagine some versions of grep finding it).

So I would strongly suggest against CRLF on UNIX. It really doesn't work 
very well, even if some tools will handle it to some limited degree.

In short: having 'core.autocrlf' set will likely make it much more 
pleasant to work across different platforms. 

			Linus
