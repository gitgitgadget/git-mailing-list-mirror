From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Sun, 21 Sep 2008 22:57:39 +0200
Message-ID: <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW15-0002jI-64
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYIUU5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYIUU5h
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19993 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYIUU5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:37 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1260968ugf.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kiCoYupzZDRPhhsIZ19xAMQSM2V2TVr+ZLB3mgNwFD4=;
        b=NoUrp30dx3j4sT+N9BlntIRSm/Ddx65ksP8Z8VQzsDetLr6s1EdzhEzkuBeqWBo3Bz
         HlT4xcj8dHl6Nz4ZL7cRFIwNNruLnrC32OGKE3SbHQuO/c8hMaTxkn7PvT7OclG/EVA1
         mrgQRrYPNNmPQd0ztZ83zqo9ij3qnv82c4dR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BgbM0zzQnXSYOcDsvNv0eh7KsFlujPxM8pChL02mD/yaisGmDV598kef6MEdYbWpOw
         VqkfLWZmsdTEy03OfR1/d6o6/haHA+eqeeN8pI1Acy84bvZZ+aJvDsNwbPjf+oV1LcnU
         TTPDfR0n43Rljjl0TnR7vZlAV9fu+7VGfz/DA=
Received: by 10.210.51.18 with SMTP id y18mr3795203eby.160.1222030654204;
        Sun, 21 Sep 2008 13:57:34 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 20sm6456318eyk.4.2008.09.21.13.57.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:33 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96436>

When using path info, make filenames start with a / (right after the :
that separates them from the hash base). This minimal change allows
relative navigation to work properly when viewing HTML files.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e783d12..18da484 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -664,7 +664,7 @@ sub href (%) {
 		if (defined $params{'hash_base'}) {
 			$href .= "/".esc_url($params{'hash_base'});
 			if (defined $params{'file_name'}) {
-				$href .= ":".esc_url($params{'file_name'});
+				$href .= ":/".esc_url($params{'file_name'});
 				delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
 				delete $params{'file_name'};
 			} else {
-- 
1.5.6.5
