From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 15:27:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
 <20070827004153.GN1219@pasky.or.cz> <alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
 <mj+md-20070827.195605.14967.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, skimo@liacs.nl, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Martin Mares <mj@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPn49-0001zE-DD
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 00:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373AbXH0W1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757598AbXH0W1t
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:27:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54794 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756373AbXH0W1r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 18:27:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RMR8tc007799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 15:27:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7RMR814031784;
	Mon, 27 Aug 2007 15:27:08 -0700
In-Reply-To: <mj+md-20070827.195605.14967.albireo@ucw.cz>
X-Spam-Status: No, hits=-2.751 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.29__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56894>



On Mon, 27 Aug 2007, Martin Mares wrote:
> 
> What does `ssh://what.the.hell.org/some/file' per se mean?

So what does "http://what.the.hell.org/some/file" mean?

Does it mean that you have to start a web browser? Should we make that be

	git+http://what.the.hell.org/some/file

to make it clear that we're doing "git work" over the "http" protocol?

Pretty obviously not.

> SSH is a protocol, but rather in the sense similar to TLS, not to HTTP.

What does *that* mean? A protocol is a protocol. Your argument that 
protocols are "different" is pointless. Some protocols are usable for git, 
others aren't. OF COURSE different protocols are different. They are 
different in different ways.

Git uses URL's to say how to access something, which includes a protocol, 
an optional host, and a location within the host. It's quite obvious what 
they mean, and it's *also* obvious that the meaning is git-specific. 

Here's what it boils down to:

 - do you think it is sensible to write

	git clone git+file:///some/directory
	git clone git+http://host/directory
	git clone git+rsync://host/directory

   when cloning from the local filesystem, over http, or over rsync 
   respectively? The first one, btw, actually uses the "git protocol". The 
   two others do not, but since a user shouldn't care, it would be really 
   stupid to try to make some internal implementation detail show up in 
   the URL scheme.

 - if you really think that the above is sensible, then explain why.

 - if you think that is TOTALLY IDIOTIC, then explain why "ssh://" is so 
   magically special that it would somehow make sense to say "git+" for 
   it?

As to your TLS example: if we were to do "git over TLS", it would make 
perfect sense to use either "tls://" (although "gits://" might be more 
natural, not because tls is wrong, but because people have gotten used to 
"https://") if we were to have a "secure git" port. Or maybe we'd use the 
same port number that we already have assigned for git, and just add some 
"use TLS to authenticate/encrypt", and use "tls://" for that. It makes 
perfect sense.

In short: you should just ask yourself: what is the most natural thing for 
a *user* to type to "git clone". And no, the "git+" prefix never makes 
sense.

			Linus
