From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 09:37:50 +0100
Message-ID: <512B22DE.9070603@viscovery.net>
References: <201302090052.22053.thom311@gmail.com> <7vsj56xsg5.fsf@alter.siamese.dyndns.org> <7vobfuxrns.fsf@alter.siamese.dyndns.org> <20130209002710.GA5570@sigill.intra.peff.net> <7vfw16xqvj.fsf@alter.siamese.dyndns.org> <7va9rexqii.fsf@alter.siamese.dyndns.org> <20130211191607.GA21269@sigill.intra.peff.net> <7v621ymxfv.fsf@alter.siamese.dyndns.org> <20130211205958.GA32740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9tZj-0004Fv-Ne
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 09:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167Ab3BYIhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 03:37:55 -0500
Received: from so.liwest.at ([212.33.55.24]:50191 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754959Ab3BYIhy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 03:37:54 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1U9tZH-00072x-Im; Mon, 25 Feb 2013 09:37:51 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C26631660F;
	Mon, 25 Feb 2013 09:37:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20130211205958.GA32740@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217049>

From: Johannes Sixt <j6t@kdbg.org>

iconv on Windows does not know the encoding name "utf8", and does not
re-encode log messages when this name is given. Request "UTF-8" encoding.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I'm not sure whether I'm right to say that "UTF-8" is the correct
 spelling. Anyway, 'iconv -l' on my old Linux box lists "UTF8", but on
 Windows it does not.

 A more correct fix would probably be to use is_encoding_utf8() in more
 places, but it's outside my time budget look after it.

 -- Hannes

 t/t4210-log-i18n.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 52a7472..b1956e2 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -15,7 +15,7 @@ test_expect_success 'create commits in different encodings' '
 	t${utf8_e}st
 	EOF
 	git add msg &&
-	git -c i18n.commitencoding=utf8 commit -F msg &&
+	git -c i18n.commitencoding=UTF-8 commit -F msg &&
 	cat >msg <<-EOF &&
 	latin1
 
@@ -30,7 +30,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
 	latin1
 	utf8
 	EOF
-	git log --encoding=utf8 --format=%s --grep=$utf8_e >actual &&
+	git log --encoding=UTF-8 --format=%s --grep=$utf8_e >actual &&
 	test_cmp expect actual
 '
 
@@ -45,7 +45,7 @@ test_expect_success 'log --grep searches in log output encoding (latin1)' '
 
 test_expect_success 'log --grep does not find non-reencoded values (utf8)' '
 	>expect &&
-	git log --encoding=utf8 --format=%s --grep=$latin1_e >actual &&
+	git log --encoding=UTF-8 --format=%s --grep=$latin1_e >actual &&
 	test_cmp expect actual
 '
 
-- 
"Atomic objects are neither active nor radioactive." --
Programming Languages -- C++, Final Committee Draft (Doc.N3092)
