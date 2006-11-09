X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add an option to href() to return full URL
Date: Thu, 9 Nov 2006 19:56:55 +0100
Message-ID: <200611091956.56069.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 18:56:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZKY5LBAwdTzF9tYwW253qwkZpMOTb4fgWV9gPZ+uMMRVW15Liepv7CRFgC83X098rdK61aqmQsGnnEpg/VdbtS7cCc/Vo4OR1FDPAS8JYxyPCygJ8fd+i3MVTI8tAgGI3O6U/h1qYeZmiQeA0PMNrbBwmvPj0lVzA9MIfiCbEw0=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31199>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiF4S-0005Z5-7Z for gcvg-git@gmane.org; Thu, 09 Nov
 2006 19:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754353AbWKIS4M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 13:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754704AbWKIS4M
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 13:56:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:47399 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754353AbWKIS4L
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 13:56:11 -0500
Received: by ug-out-1314.google.com with SMTP id m3so309320ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 10:56:09 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr1886472ugh.1163098569120; Thu, 09
 Nov 2006 10:56:09 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 5sm1142648ugc.2006.11.09.10.56.08; Thu, 09 Nov
 2006 10:56:08 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

href() subroutine by default generates absolute URL (generated using
CGI::url(-absolute=>1), and saved in $my_uri) using $my_uri as base;
add an option to generate full URL using $my_url as base.

New feature usage: href(..., -full=>1)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is in preparation for git_rss cleanup (to use href), and further
per-branch (per-head) RSS feeds.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8313517..f3fe4bf 100755
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
