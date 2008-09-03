From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: use_pathinfo filenames start with /
Date: Wed,  3 Sep 2008 11:57:16 +0200
Message-ID: <1220435839-29360-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:58:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kap8P-0000SL-QJ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYICJ5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYICJ5d
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:57:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:13977 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYICJ5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:57:30 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1366057eyi.37
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VR25s6RVhvLfA8C1G7n3v6T9XxOJpEM3hnR5sV2H6bI=;
        b=QwKA+spRAzssAoTdT9hNFi4oPLHBZMlsrIw6INV9MrBOMcOVkTiHIZ2dIB6LV/xuL+
         HPmmDVSXnk4g8KWmIlBjpaV5r+H6+o8HG2fcUjq+PWrBczUcdhgS1xMehrfCM+ekdHOQ
         xo8Xf/58R186eQeK4NPyDloFh4EjxNTRB9ir4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bWQ0jVIilj5ScWkUisKb0ocfIAk1v3gBJWK16K4Qf8KVR+m5oAVwyzEWvPXp/jwaaH
         evLNJ9ZSlo72XndO5pbwsMvA7xDhnhINCnayi/OY0cxjIQXDG21HoyMRysgkzPi4bMSE
         JOnWsIwMLyvF6WtCFO1taiuZQzphBS+H5W2V0=
Received: by 10.210.110.5 with SMTP id i5mr9869922ebc.2.1220435849402;
        Wed, 03 Sep 2008 02:57:29 -0700 (PDT)
Received: from localhost ( [78.15.13.249])
        by mx.google.com with ESMTPS id k10sm7195846nfh.25.2008.09.03.02.57.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 02:57:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1220435839-29360-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94776>

When using path info, make filenames start with a / (right after the :
that separates them from the hash base). This minimal change allows
relative navigation to work properly when viewing HTML files.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 496dce4..9d4952f 100755
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
