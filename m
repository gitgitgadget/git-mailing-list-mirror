From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [PATCH] gitk: disable checkout of remote branch
Date: Mon, 22 Jun 2009 09:12:04 +0530
Message-ID: <2e24e5b90906212042l3182b634y2a51efb645e4bcf@mail.gmail.com>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
	 <slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
	 <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
	 <20090622063405.6117@nanako3.lavabit.com>
	 <7vtz29p3qm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 05:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIaQB-0007Fj-9x
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 05:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbZFVDmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZFVDmE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 23:42:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:52415 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZFVDmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 23:42:03 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1741895ywb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4R3bPtEXceW9mQZhyNiY/jKwDUqx6KzqQUrABmh2TTM=;
        b=Xc0n/RTg//m1M7d4sYs8TNeibt6fjK3J2yF6XdO1r2F4e4horxr7VWMnGNP3MMILDM
         A6UFv2aFh2vt/U7WP8MVux/WsY2uP0fySxFMxJ9+50WlWh4kCqd+UWNOX1A/+961Jajo
         7XGsCD6+Jwj3d6IBdzVk/RKSMpA2KYhEMQ9eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WDC6LMjjjvfGa8Ld1IXc+QTTvT02WxUARdhypi6K4EA0UJPUPCwdBkO61XJjs6ntHV
         ECsma5UfoM3B8ixJhD4w0iJZZMAN4cCESL4hrKRfFzfHRHqby6QJkkSFyCyY0wyYdbjZ
         P7RUxk48d1f41L/WXMkAnBH35X7EODsVac74M=
Received: by 10.231.35.65 with SMTP id o1mr1777811ibd.7.1245642124880; Sun, 21 
	Jun 2009 20:42:04 -0700 (PDT)
In-Reply-To: <7vtz29p3qm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122006>

At the command line, this gives you a detailed warning message, but the
GUI currently allows it without any fuss.

Since the GUI is often used by people much less familiar with git, it
seems reasonable to make the GUI more restrictive than the command line,
not less.

This prevents a lot of detached HEAD commits by new users.

Signed-off-by: Sitaram Chamarty <sitaramc@gmail.com>
---

Paul,

I have amended the diff header to fit the gitk repo as opposed to the
git repo.  To summarise the email discussions, the feature that is
being disabled gets you a detached HEAD, but if that were really the
intent we should allow a detached HEAD from any commit, not just a
head commit.  Therefore this particular disablement is useful and
makes the GUI experience safer.

Please accept.  Thanks.

 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..70b6abc 100755
--- a/gitk
+++ b/gitk
@@ -8833,6 +8833,9 @@ proc headmenu {x y id head} {
     set headmenuid $id
     set headmenuhead $head
     set state normal
+    if {[string match "remotes/*" $head]} {
+	set state disabled
+    }
     if {$head eq $mainhead} {
 	set state disabled
     }
-- 
1.6.3.2
