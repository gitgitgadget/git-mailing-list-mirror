From: Paul Jackson <pj@sgi.com>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 21:36:32 -0700
Organization: SGI
Message-ID: <20050417213632.1f099ff9.pj@sgi.com>
References: <20050416132231.GJ2551@abridgegame.org>
	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
	<20050417121712.GA22772@abridgegame.org>
	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
	<20050417195600.6894e576.pj@sgi.com>
	<Pine.LNX.4.58.0504172005450.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: droundy@abridgegame.org, git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Mon Apr 18 06:34:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNNy0-00019H-0i
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 06:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDREiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 00:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVDREiV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 00:38:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33744 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261651AbVDREiP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 00:38:15 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I6GxWZ031809;
	Sun, 17 Apr 2005 23:17:09 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I4ablU15585576;
	Sun, 17 Apr 2005 21:36:40 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504172005450.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Not until all the data structures are really really stable.

Fine by me to wait, though perhaps not for the same reason, and perhaps
not as long.

A libgit.so can deal with data structure changes just as well as a set
of command line utilities.  So long as everything funnels through one
place, you can change by changing that one place.

However I am  willing to agree that its not libgit time yet, for two
reasons:

 1) everyone who has two clues on the subject is too busy and
    too productive on more pressing git issues, and

 2) in addition to internal data structures being not yet stable,
    I suspect that the operations (git commands, options and
    behaviour) are also not stable.

The first step of a good libgit is not coding to the internal data
structures, but rather designing the interface (the operations,
arguments, data types, and behaviour).

So, until people have time, and the interface ops are settled down, its
too early to design libgit.  Or at least too early to publish a design
and seek concensus.  If I had the time the first thing I'd be doing
right now would be designing libgit on the side, anticipating the day
when it was time to publish a draft and engage the community discussion
that leads to an adequate concensus.

===

By the way, a good libgit design, in my view, would isolate the data
structures written to files below .git from the data structures
presented at the library API, to some extent.  Changes in the file
structures must be handled without disrupting the library API.

If a libgit API didn't isolate the library caller from details of the
structures in files below .git, then yes you'd want really really stable
data structures, impossibly stable in fact.  That way leads to hacks and
workarounds in the future, because the data structures are never
perfectly stable.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
