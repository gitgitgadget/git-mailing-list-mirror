From: "Marc-Andre Lureau (elmarco)" <marcandre.lureau@gmail.com>
Subject: [PATCH] git-svn: find-rev error message when missing arg
Date: Tue, 11 Mar 2008 03:52:26 +0200
Message-ID: <1205200346-5537-1-git-send-email-marcandre.lureau@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	"Marc-Andre Lureau (elmarco)" <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 02:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYtg9-0006FL-SX
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 02:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbYCKBwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 21:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYCKBwm
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 21:52:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:40535 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbYCKBw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 21:52:27 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2190545fga.17
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4xL0bstbT9R9jBLgCC1gjmkx6K1kereCVV9RZFlHMq0=;
        b=UDw9tZn0MKkAjflPcatzlG3+4u8Kxqj2iklIVoqIzRgn2+pTyBwKOuLg6jTvt5wUr506EK3PwY29T5EQKok/JSAbYYEp+OjMkKSwtSp8oTx/j8DxVs4mLC/fmPFAKR5fDL5fU94KwA0MdT5qUWObgdH5Ot4uTVyY2rV3/TS+/Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OP9kazqbNueT/jJyNRt7WNPqyVAx1A8qy7YYDaRK4QxhUnL+t6t2ElPRYyl0rsdzjFPhO04wEyyNoLyCZfwAFvLJ10kGIlIwSx6R0seKu7I8F6xT8aHCfZeyca26VyAXWwOuGYARQT4tUWlAKbudg9AT4Yc6aLHKjiEFUY2cLxU=
Received: by 10.82.127.14 with SMTP id z14mr14879826buc.3.1205200341638;
        Mon, 10 Mar 2008 18:52:21 -0700 (PDT)
Received: from localhost ( [88.113.0.245])
        by mx.google.com with ESMTPS id b36sm1884430ika.2.2008.03.10.18.52.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 18:52:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.4.482.ga8b1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76781>

Just let the user know that a revision argument is missing instead of a perl error. This error message mimic the "init" error message, but could be improved.
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1195569..2ee7ca5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -522,7 +522,8 @@ sub cmd_dcommit {
 }
 
 sub cmd_find_rev {
-	my $revision_or_hash = shift;
+	my $revision_or_hash = shift or die "SVN or git revison required ",
+	                                    "as a command-line argument\n";
 	my $result;
 	if ($revision_or_hash =~ /^r\d+$/) {
 		my $head = shift;
-- 
1.5.4.4.482.ga8b1
