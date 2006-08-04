From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] Allow config file to specify Signed-off-by identity in format-patch.
Date: Fri, 4 Aug 2006 22:01:30 +0100
Message-ID: <000001c6b809$2919a200$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0001_01C6B811.8ADE0A00"
X-From: git-owner@vger.kernel.org Fri Aug 04 23:02:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96nN-0007Eq-OY
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161444AbWHDVBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161442AbWHDVBW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:01:22 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:39950 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161445AbWHDVBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:01:21 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-36.mail.demon.net with smtp (Exim 4.42)
	id 1G96nH-000M7y-JV
	for git@vger.kernel.org; Fri, 04 Aug 2006 21:01:20 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24840>

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C6B811.8ADE0A00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Unlike git-commit, git-format-patch was not picking up and using the
user.email config variable for the email part of the committer info.
I was forced to use the GIT_COMMITTER_EMAIL environment variable to
override the default <user@localhost.localdomain>. The fix was to
simply move the call to setup_ident() to come before the git_config()
call.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index f9515a8..dcee141 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -243,6 +243,7 @@ int cmd_format_patch(int argc, const cha
 	rev.ignore_merges = 1;
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 
+	setup_ident();
 	git_config(git_format_config);
 	rev.extra_headers = extra_headers;
 
@@ -283,7 +284,6 @@ int cmd_format_patch(int argc, const cha
 			 !strcmp(argv[i], "-s")) {
 			const char *committer;
 			const char *endpos;
-			setup_ident();
 			committer = git_committer_info(1);
 			endpos = strchr(committer, '>');
 			if (!endpos)
-- 
1.4.1

------=_NextPart_000_0001_01C6B811.8ADE0A00
Content-Type: text/plain;
	name="P0013.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0013.TXT"

RnJvbSAyYmMwMWYyY2ViMDQyMTkyODI3ZDA1ZTk0MWNhODFjMWE3ZGMzMGZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBGcmksIDQgQXVnIDIwMDYgMTc6MTg6MTUgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBBbGxvdyBjb25maWcgZmlsZSB0byBzcGVjaWZ5IFNpZ25lZC1vZmYtYnkgaWRlbnRp
dHkgaW4gZm9ybWF0LXBhdGNoLgoKVW5saWtlIGdpdC1jb21taXQsIGdpdC1mb3JtYXQtcGF0Y2gg
d2FzIG5vdCBwaWNraW5nIHVwIGFuZCB1c2luZyB0aGUKdXNlci5lbWFpbCBjb25maWcgdmFyaWFi
bGUgZm9yIHRoZSBlbWFpbCBwYXJ0IG9mIHRoZSBjb21taXR0ZXIgaW5mby4KSSB3YXMgZm9yY2Vk
IHRvIHVzZSB0aGUgR0lUX0NPTU1JVFRFUl9FTUFJTCBlbnZpcm9ubWVudCB2YXJpYWJsZSB0bwpv
dmVycmlkZSB0aGUgZGVmYXVsdCA8dXNlckBsb2NhbGhvc3QubG9jYWxkb21haW4+LiBUaGUgZml4
IHdhcyB0bwpzaW1wbHkgbW92ZSB0aGUgY2FsbCB0byBzZXR1cF9pZGVudCgpIHRvIGNvbWUgYmVm
b3JlIHRoZSBnaXRfY29uZmlnKCkKY2FsbC4KClNpZ25lZC1vZmYtYnk6IFJhbXNheSBBbGxhbiBK
b25lcyA8cmFtc2F5QHJhbXNheTEuZGVtb24uY28udWs+Ci0tLQogYnVpbHRpbi1sb2cuYyB8ICAg
IDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2J1aWx0aW4tbG9nLmMgYi9idWlsdGluLWxvZy5jCmluZGV4IGY5NTE1YTgu
LmRjZWUxNDEgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tbG9nLmMKKysrIGIvYnVpbHRpbi1sb2cuYwpA
QCAtMjQzLDYgKzI0Myw3IEBAIGludCBjbWRfZm9ybWF0X3BhdGNoKGludCBhcmdjLCBjb25zdCBj
aGEKIAlyZXYuaWdub3JlX21lcmdlcyA9IDE7CiAJcmV2LmRpZmZvcHQub3V0cHV0X2Zvcm1hdCA9
IERJRkZfRk9STUFUX1BBVENIOwogCisJc2V0dXBfaWRlbnQoKTsKIAlnaXRfY29uZmlnKGdpdF9m
b3JtYXRfY29uZmlnKTsKIAlyZXYuZXh0cmFfaGVhZGVycyA9IGV4dHJhX2hlYWRlcnM7CiAKQEAg
LTI4Myw3ICsyODQsNiBAQCBpbnQgY21kX2Zvcm1hdF9wYXRjaChpbnQgYXJnYywgY29uc3QgY2hh
CiAJCQkgIXN0cmNtcChhcmd2W2ldLCAiLXMiKSkgewogCQkJY29uc3QgY2hhciAqY29tbWl0dGVy
OwogCQkJY29uc3QgY2hhciAqZW5kcG9zOwotCQkJc2V0dXBfaWRlbnQoKTsKIAkJCWNvbW1pdHRl
ciA9IGdpdF9jb21taXR0ZXJfaW5mbygxKTsKIAkJCWVuZHBvcyA9IHN0cmNocihjb21taXR0ZXIs
ICc+Jyk7CiAJCQlpZiAoIWVuZHBvcykKLS0gCjEuNC4xCgo=

------=_NextPart_000_0001_01C6B811.8ADE0A00--
