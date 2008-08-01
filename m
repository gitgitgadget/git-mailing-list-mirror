From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: use_pathinfo filenames start with /
Date: Fri,  1 Aug 2008 22:35:13 +0200
Message-ID: <1217622913-9747-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1217593425-28314-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 22:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1M4-0004ta-Vb
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbYHAUfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbYHAUfA
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:35:00 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:32596 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbYHAUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:34:59 -0400
Received: by qb-out-0506.google.com with SMTP id a16so1169506qbd.17
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nZcFXBfQYKnh0IfNNlUJZq0OAhWGrBn0WkoijRs4QVQ=;
        b=S7JJhBPCQ6O9b3C8AzfP+h784ctibErz8VcTr36ZqVpduJkec4qDbzloEX+WrGY6Yx
         RLmSPm8X/0hUcLcnJWQftDqSch6vwPIR6XDSHeodULqdbv6s+f/Z9GspZKES8FOvj++3
         NrMmNFyQLRrbH/mBXiXbtIkGLhAHMwVZQi2Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ca2uKWGDrZbbEWtP6NWeMmbyVwOWedqfIwYoCo7acouYMXlTMM1melns3lwjYnddP1
         y0ADblD4H3+9LhsCJ0hSHDr+oMCZ4ZxiDy4bdbvsfntg/75VinoMmhzUWFS6d1GTmTdn
         4VQGtSz4I+nZyxIBYBIwo7nd6YObQ00eFuzvI=
Received: by 10.181.27.7 with SMTP id e7mr4218875bkj.2.1217622898511;
        Fri, 01 Aug 2008 13:34:58 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id f31sm1711278fkf.0.2008.08.01.13.34.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 13:34:57 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1217593425-28314-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91093>

When using path info, make filenames start with a / (right after the :
that separates them from the hash base). This minimal change allows
relative navigation to work properly when viewing HTML files.
---

This patch is based on top of my previous patch
  gitweb: action in path with use_pathinfo
(which I sent with the wrong CC: lines)

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 56fbdab..a8c0887 100755
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
1.5.6.3
