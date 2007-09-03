From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 00/15] i18n support for git-gui
Date: Mon, 3 Sep 2007 00:49:38 -0400
Message-ID: <20070903044938.GQ18160@spearce.org>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site> <Pine.LNX.4.64.0709021738090.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 03 06:50:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS3tB-0000e7-2K
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 06:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbXICEtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 00:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbXICEtn
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 00:49:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47051 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXICEtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 00:49:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IS3sY-0003Nk-CP; Mon, 03 Sep 2007 00:49:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BDEA220FBAE; Mon,  3 Sep 2007 00:49:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709021738090.28586@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57427>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> sorry for the fsckup with the first two patches; both should be attributed 
> to Christian Stimming.
> 
> For convenience, I also uploaded that patch series (on top of your 
> "git-gui: Initialize Tcl's msgcat library for internationalization" in 
> your "pu" branch) to the "for-shawn" branch in git-gui-i18n.

That was *much* easier than the small patch bomb.  ;-)

I've swallowed this series down and added it to my `master` branch.
I found one bug in the [mc "..."] string definitions and fixed it
(below).  I also applied Michele Ballabio's "remove does in some
UI strings" patch on top.  Those two changes I'm sure will impact
some of the translated strings.  I guess someone needs to run `make
update-po` and ask translators to revise the individual languages?

-->8--
From b86882eda026a0da18472587034250a53e0daf51 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Mon, 3 Sep 2007 00:22:19 -0400
Subject: [PATCH] git-gui: Correct stock message for 'Invalid font specified in %s'

This particular message is talking about a specific option in the
configuration file named "gui.$name".  This option is not localized
so we cannot localize the "gui." that denotes the section the option
$name is found within.  Currently there are no plans to localize the
configuration options for git-gui, but if that were to change in the
future then it would be necessary to localize not only the "gui."
section prefix but also the $name (fontui and fontdiff).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 913ba68..5635eea 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1643,7 +1643,7 @@ proc apply_config {} {
 				font configure $font $cn $cv
 			}
 			} err]} {
-			error_popup [append [mc "Invalid font specified in gui.%s:" $name] "\n\n$err"]
+			error_popup [append [mc "Invalid font specified in %s:" "gui.$name"] "\n\n$err"]
 		}
 		foreach {cn cv} [font configure $font] {
 			font configure ${font}bold $cn $cv
-- 
1.5.3

-- 
Shawn.
