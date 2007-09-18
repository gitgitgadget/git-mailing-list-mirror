From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: [PATCH] Prevent using bold text in entire gui for some fonts sometimes
Date: Wed, 19 Sep 2007 00:33:34 +0200
Message-ID: <981e6de60709181533o24ef0e45w7925070b5e78ef56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXldV-0005UC-P7
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbXIRWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbXIRWdg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:33:36 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:15215 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbXIRWdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:33:35 -0400
Received: by rv-out-0910.google.com with SMTP id k20so12020rvb
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ZKeuHIQYs6QaQ27m+SacuZS9LqqlBPBJfjfbS0J2rfo=;
        b=tfmEV50p5bf2zeORXdToj8uM0RKcd2zo3GHlcE1A5Eerq0YWD+z7KG/eVN1A21VxzmcKH+06gd8W7ig4ZcUw7+Z3qsWAKg9DCHEx06fxpQyEmakuH4aBycylk5Z65EWcsKjsZ27J85/s4NRtxf/qPWqVA/FoFJQuhTlxklAsAI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i07dVvs9JiP5Y3/aj8mq1SaHeUVWSjQ6zXCjMrOHg+95zPcDFMxNZiF3VkHZeJvjOaiCIjRHslt5eD2Lg/VJoRj48AwfZf6wyTaMyJ3J1mipP/Au28VtHedoY1i6F0k122UoMCq25IxKLL+qRBDQSj6vxJ15xLfbdYfOM9lq9YE=
Received: by 10.114.125.2 with SMTP id x2mr354123wac.1190154814400;
        Tue, 18 Sep 2007 15:33:34 -0700 (PDT)
Received: by 10.114.124.16 with HTTP; Tue, 18 Sep 2007 15:33:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58644>

---

When I first saw git-gui on windows, I noticed it wasn't using ugly
bold fonts for it's entire gui like it was in linux. I came up with
the following patch to fix this there.

And it worked, trange thing was, even git-gui without this patch
applied was using normal fonts now. The patch didn't seem to make any
difference for me anymore. So I chalked this up to weirdness of my
system.

Yesterday though a saw that a friends git-gui was showing the same
problem with the entire gui being in bold text. And this patch fixed
it.

So its a bit weird that this patch seemed to have 'permanent' effects
for me, even after it was reverted.... but on the other hand it's
really trivial.

 git-gui/git-gui.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index f789e91..28d7c21 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1648,7 +1648,7 @@ proc apply_config {} {
 		set font [lindex $option 1]
 		if {[catch {
 			foreach {cn cv} $repo_config(gui.$name) {
-				font configure $font $cn $cv
+				font configure $font $cn $cv -weight normal
 			}
 			} err]} {
 			error_popup "Invalid font specified in gui.$name:\n\n$err"
-- 
1.5.3.1.21.g997f2-dirty
