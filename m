From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Brown paper bag fix to previous send-email change
Date: Tue, 11 Dec 2007 07:55:16 +0100
Message-ID: <1197356116-12176-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 07:55:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1z1o-0005Qj-6C
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbXLKGzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXLKGzS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:55:18 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:25855 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbXLKGzS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:55:18 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2821.orange.fr (SMTP Server) with ESMTP id ECFD470000A7
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 07:55:16 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2821.orange.fr (SMTP Server) with ESMTP id CA6F27000093;
	Tue, 11 Dec 2007 07:55:16 +0100 (CET)
X-ME-UUID: 20071211065516829.CA6F27000093@mwinf2821.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1z1Q-0003Ak-AA; Tue, 11 Dec 2007 07:55:16 +0100
X-Mailer: git-send-email 1.5.3.7.1161.g14b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67809>

My previous change led to the In-Reply-To header being <> when the given
value was empty. This fixes it.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 I think I have an antispam problem somewhere with this patch, because even
 keeping sending it, it never reached the list. And Junio didn't answer to my
 private message about it, so I guess that was some server being smart with
 the subject line. *sigh*

 PS: sorry Junio if you get this patch multiple time.

 git-send-email.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c0e1dd3..0e8c457 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -369,8 +369,10 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = $_;
 }
 
-$initial_reply_to =~ s/^\s*<?/</;
-$initial_reply_to =~ s/>?\s*$/>/;
+if ($initial_reply_to) {
+	$initial_reply_to =~ s/^\s*<?/</;
+	$initial_reply_to =~ s/>?\s*$/>/;
+}
 
 if (!defined $smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
-- 
1.5.3.7.1161.g14b8
