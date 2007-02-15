From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui Error
Date: Thu, 15 Feb 2007 01:38:55 -0500
Message-ID: <20070215063855.GA30643@spearce.org>
References: <20070213065616.GA4195@auto.tuwien.ac.at> <20070213074519.GA32687@spearce.org> <20070213215303.GA26716@auto.tuwien.ac.at> <20070214022200.GB30884@spearce.org> <20070214060041.GA31871@spearce.org> <20070214174635.GA21612@auto.tuwien.ac.at> <20070215024014.GA29865@spearce.org> <20070215060712.GA3761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Thu Feb 15 07:39:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHaGo-00005Z-6w
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 07:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXBOGjD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 01:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbXBOGjC
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 01:39:02 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34811 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbXBOGjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 01:39:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHaGg-000320-73; Thu, 15 Feb 2007 01:38:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8ED2320FBAE; Thu, 15 Feb 2007 01:38:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070215060712.GA3761@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39798>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> This time, the white spaces/tabs should be correct:

Thanks, that applied cleanly.

Except the radio button for Tag isn't selected if you make a
selection from the tag picklist.  This was easily fixed by adding a
trace to the variable, like the trace already setup for the branch
and tracking branch menus:

diff --git a/git-gui.sh b/git-gui.sh
index 1c3de80..9ce5a3b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2018,6 +2018,8 @@ trace add variable create_branch_head write \
 	[list radio_selector create_branch_revtype head]
 trace add variable create_branch_trackinghead write \
 	[list radio_selector create_branch_revtype tracking]
+trace add variable create_branch_tag write \
+	[list radio_selector create_branch_revtype tag]
 
 trace add variable delete_branch_head write \
 	[list radio_selector delete_branch_checktype head]

I applied your patch along with the new trace above, and have pushed
it out as the following:

commit 101e3ae7a6b041aa86505bfd3e8b901f1dc245c3
Author: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date:   Thu Feb 15 01:28:34 2007 -0500

    git-gui: Create new branches from a tag.
    
    I'm missing the possibility to base a new branch on a tag.
    The following adds a tag drop down to the new branch dialog.
    
    Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
