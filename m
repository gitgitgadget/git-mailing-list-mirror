From: Andrew Morton <akpm@osdl.org>
Subject: the war on trailing whitespace
Date: Sat, 25 Feb 2006 17:40:47 -0800
Message-ID: <20060225174047.0e9a6d29.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 02:41:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDAus-0008NJ-8X
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 02:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWBZBlj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 20:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBZBlj
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 20:41:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750799AbWBZBli (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2006 20:41:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1Q1fYDZ018724
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Feb 2006 17:41:35 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1Q1fY1f025586;
	Sat, 25 Feb 2006 17:41:34 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16765>


It's invariably pointless to add lines which have trailing whitespace. 
Nobody cares much, but my scripts spam me when it happens, so I've become
obsessive.    Looking at Dave Miller's current net devel tree:

bix:/usr/src/25> grep '^+.*[    ]$' patches/git-net.patch | wc -l
    170

Note that this is purely _added_ trailing whitespace.  I'm not proposing
that the revision control system should care about pre-existing trailing
whitespace.

I got the quilt guys to generate warnings when patches add trailing
whitespace, and to provide the tools to strip it.  And I believe Larry made
similar changes to bk.

I realise that we cannot do this when doing git fetches, but when importing
patches and mboxes, git ought to whine loudly about input which matches the
above regexp, and it should offer an option to tidy it up.  Perhaps by
default.

Of course, this means that the person who sent the patch will find that his
as-yet-unsent patches don't apply to the upstream tree any more.  Well,
that's tough luck - perhaps it'll motivate him to stop adding trailing
whitespace.  The patches will still apply with `patch -l'.

Thanks for listening ;)
