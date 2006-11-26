X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 26 Nov 2006 02:14:20 +0100
Message-ID: <20061126011420.GI20094MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
 <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061122034056.GB23856@spearce.org>
 <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <20061125065338.GC4528@spearce.org>
 <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org>
 <45689747.3020403@midwinter.com>
 <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 26 Nov 2006 01:14:30 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32313>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go8bC-0000Bg-I3 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 02:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935193AbWKZBOW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935203AbWKZBOW
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 20:14:22 -0500
Received: from smtp15.wxs.nl ([195.121.247.6]:2772 "EHLO smtp15.wxs.nl") by
 vger.kernel.org with ESMTP id S935193AbWKZBOV (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 20:14:21 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0J9B00MCRCRWTO@smtp15.wxs.nl> for
 git@vger.kernel.org; Sun, 26 Nov 2006 02:14:20 +0100 (CET)
Received: (qmail 5029 invoked by uid 500); Sun, 26 Nov 2006 01:14:20 +0000
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

FWIW, here's my view on this issue.

On Sun, Nov 26, 2006 at 12:49:08AM +0100, Yann Dirson wrote:
> Also, I'd rather expect "git-commit -a" outside of any submodule to
> commit everything in the supermodule, triggering submodule commits as an
> intermediate step when needed - just like "git-commit -a" does not
> require to manually specify subdirectories to inclue in the commit.  I'd
> rather expect a special flag to exclude submodules from a commit.

A commit should record the content changes that have been made, not change
any content itself.  Some VCSs change the contents of a file when you
commit them (e.g., keyword substitution).  Git, rightly, doesn't do that.
Likewise, when you commit in the superproject, it should simply record
the changes to the "content" of the subproject and not change it.
And the content of the subproject is a commit, so a commit in the
superproject should not change the content of the subproject by creating
another commit in the subproject.

