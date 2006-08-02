From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 7/10] Fix header breakage due to redefining PATH_MAX.
Date: Wed, 2 Aug 2006 02:03:41 +0100
Message-ID: <00ba01c6b5cf$7e9b4300$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00BB_01C6B5D7.E05FAB00"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858z-00071U-FW
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWHBBDW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWHBBDW
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:22 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:54537 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750908AbWHBBDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:21 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858p-000C1I-IO
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:20 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24625>

This is a multi-part message in MIME format.

------=_NextPart_000_00BB_01C6B5D7.E05FAB00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The header builtin.h was, incorrectly, redefining PATH_MAX which
causes a header order dependency in builtin-write-tree.c.  The fix
is to simply include <limits.h> directly to obtain the correct
definition of PATH_MAX.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
Note that on Linux 2.2.14, PATH_MAX is define to be 4095.
(Solaris, Mac OSX, *BSD define it as 1024)

 builtin.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin.h b/builtin.h
index f12d5e6..7bfff11 100644
--- a/builtin.h
+++ b/builtin.h
@@ -2,10 +2,7 @@ #ifndef BUILTIN_H
 #define BUILTIN_H
 
 #include <stdio.h>
-
-#ifndef PATH_MAX
-# define PATH_MAX 4096
-#endif
+#include <limits.h>
 
 extern const char git_version_string[];
 
-- 
1.4.1

------=_NextPart_000_00BB_01C6B5D7.E05FAB00
Content-Type: text/plain;
	name="P0007.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0007.TXT"

RnJvbSAxNDMyNDk5MmZmM2E5YjQzYzNhYzljODY5ZWY0MGNmNTllZWFjMjQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDE3OjAwOjQwICswMTAwClN1YmplY3Q6
IFtQQVRDSCA3LzEwXSBGaXggaGVhZGVyIGJyZWFrYWdlIGR1ZSB0byByZWRlZmluaW5nIFBBVEhf
TUFYLgoKVGhlIGhlYWRlciBidWlsdGluLmggd2FzLCBpbmNvcnJlY3RseSwgcmVkZWZpbmluZyBQ
QVRIX01BWCB3aGljaApjYXVzZXMgYSBoZWFkZXIgb3JkZXIgZGVwZW5kZW5jeSBpbiBidWlsdGlu
LXdyaXRlLXRyZWUuYy4gIFRoZSBmaXgKaXMgdG8gc2ltcGx5IGluY2x1ZGUgPGxpbWl0cy5oPiBk
aXJlY3RseSB0byBvYnRhaW4gdGhlIGNvcnJlY3QKZGVmaW5pdGlvbiBvZiBQQVRIX01BWC4KClNp
Z25lZC1vZmYtYnk6IFJhbXNheSBBbGxhbiBKb25lcyA8cmFtc2F5QHJhbXNheTEuZGVtb24uY28u
dWs+Ci0tLQogYnVpbHRpbi5oIHwgICAgNSArLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi5oIGIvYnVpbHRp
bi5oCmluZGV4IGYxMmQ1ZTYuLjdiZmZmMTEgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4uaAorKysgYi9i
dWlsdGluLmgKQEAgLTIsMTAgKzIsNyBAQCAjaWZuZGVmIEJVSUxUSU5fSAogI2RlZmluZSBCVUlM
VElOX0gKIAogI2luY2x1ZGUgPHN0ZGlvLmg+Ci0KLSNpZm5kZWYgUEFUSF9NQVgKLSMgZGVmaW5l
IFBBVEhfTUFYIDQwOTYKLSNlbmRpZgorI2luY2x1ZGUgPGxpbWl0cy5oPgogCiBleHRlcm4gY29u
c3QgY2hhciBnaXRfdmVyc2lvbl9zdHJpbmdbXTsKIAotLSAKMS40LjEKCg==

------=_NextPart_000_00BB_01C6B5D7.E05FAB00--
