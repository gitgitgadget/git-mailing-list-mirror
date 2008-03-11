From: Marc-Andre Lureau <marcandre.lureau@gmail.com>
Subject: [PATCH] git-svn: find-rev error message when missing arg
Date: Tue, 11 Mar 2008 10:00:45 +0200
Message-ID: <1205222445-8077-1-git-send-email-marcandre.lureau@gmail.com>
References: <20080311051910.GB9389@hand.yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Marc-Andre Lureau <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 09:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYzQI-0003CZ-Hz
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 09:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYCKIAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYCKIAn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 04:00:43 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:30271 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYCKIAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 04:00:43 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2122298fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MRZ9U/0zVTapuCB0cM+LFWss/iFNtfe4nc4JyUvGxNA=;
        b=A9C5xzs32iA2AjQVTUrP1BX87mWsJWl3ZU2pCLaNb1UwVfmCibNkqlt4AkvPBjkVYxISbR9d3YFjGDX5OR44MO5glpLXzd1vv30QdbyHsL1XTpXi2WuOGVR+k9tZMAZJCL1lLHTQSKivQAidVLdGR5BabPHNRbOC4pVynZInsuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YLwJSt6SaEArz2AjZ7AnX38cNXUw4cdJoYFXBG/3JSc0ngjDcCS+/Z5W8my0dQocDZmDxo/HaUxYy24F58Un2W8045y01hztr7tdxKVFSFS50bqeCdA5vNTYRsoTL1wL7V7SpUPraOMk1KE8y7OwB53XJDkgmt7bv4vIaWm009g=
Received: by 10.82.153.5 with SMTP id a5mr15723287bue.5.1205222440663;
        Tue, 11 Mar 2008 01:00:40 -0700 (PDT)
Received: from localhost ( [88.113.0.245])
        by mx.google.com with ESMTPS id b36sm2621900ika.2.2008.03.11.01.00.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Mar 2008 01:00:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.4.482.ga8b1
In-Reply-To: <20080311051910.GB9389@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76810>

Just let the user know that a revision argument is missing instead of
a perl error. This error message mimic the "init" error message, but
could be improved.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1195569..d8b38c9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -522,7 +522,8 @@ sub cmd_dcommit {
 }
 
 sub cmd_find_rev {
-	my $revision_or_hash = shift;
+	my $revision_or_hash = shift or die "SVN or git revision required ",
+	                                    "as a command-line argument\n";
 	my $result;
 	if ($revision_or_hash =~ /^r\d+$/) {
 		my $head = shift;
-- 
1.5.4.4.482.ga8b1
