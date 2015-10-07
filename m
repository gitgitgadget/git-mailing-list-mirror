From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] pretty: add format specifiers for short and raw date formats
Date: Wed,  7 Oct 2015 18:28:25 +0200
Message-ID: <1444235305-8718-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 18:28:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjra8-0004rp-OR
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbbJGQ2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2015 12:28:41 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56620 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557AbbJGQ2k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 12:28:40 -0400
Received: from x590c2e2b.dyn.telefonica.de ([89.12.46.43] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZjrZy-0000EY-BW; Wed, 07 Oct 2015 18:28:35 +0200
X-Mailer: git-send-email 2.6.1.134.ge857153
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1444235315.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279182>

Other date formats already have their format specifiers and so should
these, so they will be available in pretty format aliases as well.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/pretty-formats.txt | 4 ++++
 pretty.c                         | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 671cebd95c..ce62c70659 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -120,6 +120,8 @@ The placeholders are:
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601-like format
 - '%aI': author date, strict ISO 8601 format
+- '%as': author date, short format
+- '%aR': author date, raw format
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -132,6 +134,8 @@ The placeholders are:
 - '%ct': committer date, UNIX timestamp
 - '%ci': committer date, ISO 8601-like format
 - '%cI': committer date, strict ISO 8601 format
+- '%cs': committer date, short format
+- '%cR': committer date, raw format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%D': ref names without the " (", ")" wrapping.
 - '%e': encoding
diff --git a/pretty.c b/pretty.c
index 151c2ae312..e3ea2c03b0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -723,6 +723,12 @@ static size_t format_person_part(struct strbuf *sb=
, char part,
 	case 'I':	/* date, ISO 8601 strict */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(ISO8601_STRICT)));
 		return placeholder_len;
+	case 's':	/* date, short */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(SHORT)));
+		return placeholder_len;
+	case 'R':	/* date, raw */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_MODE(RAW)));
+		return placeholder_len;
 	}
=20
 skip:
--=20
2.6.1.134.ge857153
