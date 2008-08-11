From: "Francis Moreau" <francis.moro@gmail.com>
Subject: [PATCH] git-bisect: fix wrong usage of read(1)
Date: Mon, 11 Aug 2008 19:37:46 +0200
Message-ID: <38b2ab8a0808111037p36e7e4b3y438a2539bc447330@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 19:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSbM1-0004K1-V1
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 19:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbYHKRhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbYHKRhr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 13:37:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:22414 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbYHKRhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 13:37:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2356052rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=mSuJACT+h1EYenhBAftvZJrkevMkWbWPeVYtcgitPGk=;
        b=tzhUHd+rCzARwRXmLp1F4lq8rN7LI00JlR71w3vgh14vjBr9SUV4yLOFxrjZXMlzpx
         oqEe1ZP8e6BzUhhT1+BN5Bt1NV9oQ0wiE1BkNjOT+6T1wfReiCysT9v8iJ4ht4PXFbQ4
         +DSh3+cnAaxtKSMIlg+HIuswWA1/cxI3abJjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Ml6nmS6MsCDughRoDhdKu7+VRt8+kic8U87OdUE5PMrei4jH/NYUVHPmDopGI/JHsM
         aQYTEL9Or+LZP7QolNrgGqGq3YMZ1IBRxzHsOT2p3+HZexDKra8+lazP6YnfewRouY4Z
         fYZFJM8AdccN9ThZ8rYJeUxOq3dn2xDQ+agKo=
Received: by 10.141.116.16 with SMTP id t16mr3664316rvm.280.1218476266027;
        Mon, 11 Aug 2008 10:37:46 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Mon, 11 Aug 2008 10:37:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91965>

Signed-off-by:  Francis Moreau <francis.moro@gmail.com>
---
 git-bisect.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 3cac20d..97ac600 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -220,7 +220,8 @@ bisect_next_check() {
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
-			case "$(read yesno)" in [Nn]*) exit 1 ;; esac
+			read yesno
+			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
 		: bisect without good...
 		;;
-- 
1.5.6.GIT
