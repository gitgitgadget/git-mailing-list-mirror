From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 07/14] gitweb: use CSS to style split head lists.
Date: Fri, 31 Aug 2007 13:18:38 +0200
Message-ID: <11885591201440-git-send-email-giuseppe.bilotta@gmail.com>
References: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 13:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR4YZ-0002fM-Dd
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 13:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757787AbXHaLU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757387AbXHaLU3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 07:20:29 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:32010 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbXHaLU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 07:20:28 -0400
Received: by hu-out-0506.google.com with SMTP id 19so593548hue
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 04:20:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EIIoubMz47Ovxj4NpHcuIbiUnSsj038Ivgz3mD7LeAAhYA1YPOsMGIoCXfPMrlB30C+TAYC8YnZWZLJGS2pzynAJNYE4inrUp+Vko3TcLA1qCBQwePQkbS/CeiUk6w+poMhDvSbhIUOnttKzJpl+7LQzBU67A+NWENsCZ1G/zUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YUCWsNnFH+Bv5UGLEe31rmdrL7m5enaWY/IY7jpVF/LmRht4Q7n9klu6niJzE8EVBQv2ihK3VDpN5oY+WrNv0ojMN6kXt5JswO77fCxa0De2dq4hDQOnA8E4RRPNOhddQ7VZOudr9Px0T+lliFhoP0MH/8UoL409MyXVWdXshuU=
Received: by 10.82.152.16 with SMTP id z16mr3458365bud.1188559226850;
        Fri, 31 Aug 2007 04:20:26 -0700 (PDT)
Received: from localhost ( [84.221.55.162])
        by mx.google.com with ESMTPS id k10sm1274268nfh.2007.08.31.04.20.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 31 Aug 2007 04:20:23 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <cb7bb73a0708301915y47ca4a05nf511889b2bb2eaec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57155>

Introduce a new div class 'subsection' in the CSS and use it to style split head lists.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.css  |   10 ++++++++++
 gitweb/gitweb.perl |    4 +++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 1b88879..c36b20a 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -8,6 +8,16 @@ body {
 	color: #000000;
 }
 
+div.subsection {
+	border: solid #d9d8d1;
+	border-width: 1px;
+	margin: 10px;
+}
+
+.subsection .title {
+	font-size: smaller;
+}
+
 a {
 	color: #0000cc;
 }
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cacb0d7..dc9727e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3665,9 +3665,11 @@ sub git_split_heads_body {
 	} @$headlist;
 
 	foreach $leader (sort(keys %headlists)) {
-		print "<b>$leader</b><br/>\n" unless $leader eq "\000";
+		print "<div class=\"subsection\">\n";
+		git_print_header_div(undef, $leader) unless $leader eq "\000";
 		$list = $headlists{$leader};
 		git_heads_body($list, $head, $from, $to, $extra);
+		print "</div>\n";
 	}
 }
 
-- 
1.5.2.5
