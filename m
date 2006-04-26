From: Matt McCutchen <hashproduct@verizon.net>
Subject: Proposal: git-based dependency tracking build system
Date: Tue, 25 Apr 2006 20:13:42 -0400
Message-ID: <1146010422.2075.15.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 26 02:13:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYXfA-0000dx-I6
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 02:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDZANp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDZANp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 20:13:45 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:17725 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932158AbWDZANp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 20:13:45 -0400
Received: from [192.168.1.5] ([151.200.111.183])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IYA00620ZAWWQT5@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 25 Apr 2006 19:13:45 -0500 (CDT)
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19180>

Dear git people,

I have been thinking for some time about how to write a foolproof
general-use build system that automatically tracks dependencies.  (Make
+ depcomp is decent as long as source files aren't added/removed or
generated often.  Cons is good but not general-purpose.)  I know there's
been some work on tracing the compiler to see which files it actually
opens.  Another possibility is to layer a FUSE filesystem over the build
tree and note which files in the virtual filesystem are opened; this has
the advantage of missing most of the boring files (e.g. shared libraries
that make up the compiler).

So I was thinking, why not write a build system that uses git's
excellent hash-based object storage support to store the files in the
virtual build tree?  Hashing the files makes it easy to notice when a
file is rewritten with the same contents, meaning files that depend on
it don't actually have to be rebuilt.  I also envision the build system
automatically marking generated files as git-ignored.

Thoughts?

-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/
