From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Make git-reset delete empty directories
Date: Fri, 17 Feb 2006 11:01:12 -0500
Message-ID: <20060217160112.GB26362@spearce.org>
References: <20060217072616.GA15358@spearce.org> <7v7j7u8koz.fsf@assigned-by-dhcp.cox.net> <20060217151654.GA26362@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 17:01:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA82w-0006m6-7E
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 17:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBQQBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 11:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWBQQBR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 11:01:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:21961 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932386AbWBQQBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 11:01:16 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FA82f-0005J1-G6; Fri, 17 Feb 2006 11:01:09 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id CB89020FBA0; Fri, 17 Feb 2006 11:01:12 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060217151654.GA26362@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16357>

Shawn Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > I thought I said it would be a few-liner, but it appears I did
> > not send that message.

Actually its only a one line change if you accept Perl as Perl,
but not everyone likes having their loops do nothing in the loop
body whilest the condition does all of the work.

---
diff --git a/git-reset.sh b/git-reset.sh
index fe53fc8..e6471c0 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -88,6 +88,7 @@ case "$reset_type" in
                                # it is ok if this fails -- it may already
                                # have been culled by checkout-index.
                                unlink $_;
+                               1 while (s,/[^/]*$,, && rmdir $_);
                        }
                }
        ' $tmp-exists
