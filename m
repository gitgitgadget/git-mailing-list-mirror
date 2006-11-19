X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Add an option to href() to return full URL
Date: Sun, 19 Nov 2006 15:05:21 +0100
Message-ID: <11639451221153-git-send-email-jnareb@gmail.com>
References: <200611171236.19030.jnareb@gmail.com>
NNTP-Posting-Date: Sun, 19 Nov 2006 14:04:16 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WNTScWAy+D87EcgJ+BDp8Cus8C5IupLAAsA9P5Q6yQ8kK/2BoLhBYKy04W/BXpNyFRRDiqMomqjsOuZx201X2/l9E/sSJiiTkUTUL74zP6lKK9hheafycPcqMiS08SrxpfsUdQgxmLvvEb9995+axez/BkMT/6W9Xwq9Z8qqUBU=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <200611171236.19030.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31831>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlnHH-0001hd-Fn for gcvg-git@gmane.org; Sun, 19 Nov
 2006 15:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756680AbWKSOEB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 09:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbWKSOEB
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 09:04:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27233 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1756677AbWKSOEB
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 09:04:01 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1015784ugc for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 06:03:59 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr5504814ugi.1163945039319; Sun, 19
 Nov 2006 06:03:59 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 e1sm6914716ugf.2006.11.19.06.03.58; Sun, 19 Nov 2006 06:03:59 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAJE5OMo016916; Sun, 19 Nov 2006 15:05:24 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAJE5NYe016915; Sun, 19 Nov 2006 15:05:23 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

href subroutine by default generates absolute URL (generated using
CGI::url(-absolute=>1), and saved in $my_uri) using $my_uri as base;
add an option to generate full URL using $my_url as base.

New feature usage: href(..., -full=>1)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5875ba0..8739501 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -459,7 +459,8 @@ exit;
 
 sub href(%) {
 	my %params = @_;
-	my $href = $my_uri;
+	# default is to use -absolute url() i.e. $my_uri
+	my $href = $params{-full} ? $my_url : $my_uri;
 
 	# XXX: Warning: If you touch this, check the search form for updating,
 	# too.
-- 
1.4.3.4
