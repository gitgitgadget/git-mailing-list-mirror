From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/24] t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
Date: Tue,  7 Dec 2010 00:10:46 +0100
Message-ID: <1291677069-6559-2-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkLX-0003Tv-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab0LFXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:19:47 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:58044 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0LFXTq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:19:46 -0500
Received: by ewy10 with SMTP id 10so7585290ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sSQa0o+4Ncjg66FRV/bRs++KNzCNGtuWKfHbYcfY4iA=;
        b=LXPAtvsO3pYwKc7s+7epUwsuYIgPJ6DhDZ/gJc5L5xb61eh6vmN/sb2gbbztXm51uT
         qWvijh+CSe3Fjo9KNeCkFk2FQTxD+apZrAx980xFOZ9DqofvheZFqD97Xn5c2mBnkdzT
         YdCiK/KMCaIql0tcXz9k/9CU7zHCG+5V+G+RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HTqxze3kiIjZQcuWGsbwAZ8ZluhVwjRpOXajXGPnNdDICxxINIc7x+GrMYqiZGo2rl
         95uj1hscFBG30qe8SPF1BdWOeUJcEQIpWoN00mBKV3Z2c7oh8xfR0L+rfUlrj6HolrBW
         AdkNWoyaCbh+Uu0tX/FhqGHpPm6br+edOeSns=
Received: by 10.213.28.66 with SMTP id l2mr107811ebc.71.1291677101202;
        Mon, 06 Dec 2010 15:11:41 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.11.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:11:40 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163055>

This way we can use it in test scripts written in other languages
(e.g. in Perl), and not rely on "$TEST_DIRECTORY/.."

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is not strictly required, but if we modified t/gitweb-lib.sh to
use GIT_BUILD_DIR, we would want to do the same in the test scripts
for caching interface etc. included in this series.

This patch is the same as in previous version of this series.  It has
no equivalent in "Gitweb caching v7" by J.H.; it was not needed there
because that series doesn't have separate "unit" tests for individual
components of gitweb output caching.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 48fa516..c077fa4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -552,9 +552,9 @@ test_external () {
 		# Announce the script to reduce confusion about the
 		# test output that follows.
 		say_color "" "# run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
+		# Export TEST_DIRECTORY, GIT_BUILD_DIR, TRASH_DIRECTORY and GIT_TEST_LONG
 		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
+		export TEST_DIRECTORY GIT_BUILD_DIR TRASH_DIRECTORY GIT_TEST_LONG
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
-- 
1.7.3
