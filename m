From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] -D <depth> option to recurse into merged branches
Date: Sun, 13 Nov 2005 18:01:34 -0800
Message-ID: <20051114020134.GC10998@mail.yhbt.net>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle> <20051112092721.GC16218@Muzzle> <20051112092920.GD16218@Muzzle> <20051112093045.GE16218@Muzzle> <20051112093208.GF16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 03:02:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbTf9-0005PD-Pn
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 03:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKNCBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 21:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKNCBh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 21:01:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47513 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1750758AbVKNCBg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 21:01:36 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id EDCFD2DC03B; Sun, 13 Nov 2005 18:01:34 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <20051112093208.GF16218@Muzzle>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11762>

One small fix on top of this one:

Don't check for parents if the only revision we have is a base-0
and @psets is empty.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-archimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 8a7e18ff0884cae74a1127d5c96577a85acca3f4
5f2896558284724bcc87eb64daa0933b544ec20d
diff --git a/git-archimport.perl b/git-archimport.perl
index a0ea016..b624ba6 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -186,7 +186,7 @@ sub do_abrowse {
 
         if (%ps && !exists $psets{ $ps{id} }) {
             my %temp = %ps;         # break references
-            if ($psets[$#psets]{branch} eq $ps{branch}) {
+            if (@psets && $psets[$#psets]{branch} eq $ps{branch}) {
                 $temp{parent_id} = $psets[$#psets]{id};
             }
             push (@psets, \%temp);  
---
0.99.9.GIT
