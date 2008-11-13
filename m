From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH v2 11/11] gitweb: CSS style and refs mark for detached HEAD
Date: Fri, 14 Nov 2008 00:54:21 +0100
Message-ID: <1226620461-25168-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1226616555-24503-10-git-send-email-giuseppe.bilotta@gmail.com>
 <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 00:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0m22-0000jn-Pb
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 00:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbYKMXyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 18:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYKMXyL
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 18:54:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:53312 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYKMXyA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 18:54:00 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1512463ugf.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1fds4lJlfYXC/2nL/WkO2i12VBP9BFRKHPmYndAUrnI=;
        b=gD/WXR8k76yILLcKqA9SsfucYIvIlhpFFu53CIP/or6jupvnT+faJj052gQDI+xqVH
         ZdtKMnS3uLU/BIuPU9yJmUMPtuPIjpDFltGDxJ2JAGvakXXZKn4UmaSdqA/AbHlqQ3/i
         SHisBcMhbi8UUUvz2jXCqhJvel7w9xTDZMFRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A0Y44eMXTTZGdwFOmy6DwN5UlG3midVIA0TKS9tp4KyaM79s0oaR5wn2eu82hLNSnG
         ZZfjr0SHwzcQlzkicLRzC0V/LRhLfOhSAnY6AhVJmBc6mEzHlMBYGbvkfHzav82QQ3TY
         yhDDEIDvbVu6MWAUqxkXYlHx8n6SKZK4gSDVo=
Received: by 10.67.119.20 with SMTP id w20mr4451082ugm.78.1226620439743;
        Thu, 13 Nov 2008 15:53:59 -0800 (PST)
Received: from localhost ([78.15.2.247])
        by mx.google.com with ESMTPS id e33sm18127ugd.41.2008.11.13.15.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 15:53:59 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1226620461-25168-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100932>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |    5 +++++
 gitweb/gitweb.perl |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 751749f..c0c4540 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -523,6 +523,11 @@ span.refs span.head {
 	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
 }
 
+span.refs span.detached {
+	background-color: #ffaaaa;
+	border-color: #ccffcc #00cc33 #00cc33 #ccffcc;
+}
+
 span.atnight {
 	color: #cc0000;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 256c962..51e133d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2298,7 +2298,7 @@ sub git_get_references {
 	my %refs;
 	if (git_is_head_detached()) {
 		my $hash = git_get_head_hash($project);
-		$refs{$hash} = [ 'HEAD' ];
+		$refs{$hash} = [ 'detached/HEAD' ];
 	}
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
-- 
1.5.6.5
