From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org and GIT tree rebuilding
Date: Sun, 26 Jun 2005 15:34:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506261528020.19755@ppc970.osdl.org>
References: <20050624.212009.92584730.davem@davemloft.net>
 <Pine.LNX.4.58.0506242257450.11175@ppc970.osdl.org>
 <Pine.LNX.4.58.0506260905200.19755@ppc970.osdl.org> <200506261652.59373.mason@suse.com>
 <Pine.LNX.4.58.0506261359370.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 27 00:25:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmfZJ-0003Z3-I4
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 00:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVFZWcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 18:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFZWcZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 18:32:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbVFZWcT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 18:32:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5QMW9jA022984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Jun 2005 15:32:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5QMW7Rj023748;
	Sun, 26 Jun 2005 15:32:08 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.4.58.0506261359370.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 26 Jun 2005, Linus Torvalds wrote:
> 
> (You can also sort by filename, if you want to try. I don't track
> filenames at all there and it's actually non-trivial to do, so that would
> require some new and pretty nasty code, but it's possible in _theory_ at
> least.)

Heh. It's actually very easy if you don't take the "name" too seriously, 
and you just pick some random one, namely the first one that was used to 
reach the entry.

Then, you might sort the objects on a hash based on the name, and get 
tons of cheap deltas close-by.

It is _uglee_, but hey, it's a heuristic, and it happens to work pretty 
well. It brought the kernel pack down to 59M even with just a small window 
of 10.

Thanks to Davide for making me think about this hack, although he talked 
about something much more proper (and harder) than this quick and 
ugly heuristic ;)

The main change is that "git-rev-list --objects" has been changed to show
the name the object was reached through.

			Linus
