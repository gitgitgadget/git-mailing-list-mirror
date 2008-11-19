From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 12:13:06 +0100
Message-ID: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34606_27919187.1227093186180"
To: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2l0r-0002Gp-BM
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbYKSLNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYKSLNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:13:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:7570 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbYKSLNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:13:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1704753wah.21
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=OQNVpC6X0JBIWmwxXERE+sPg3WIK9AeQjgmTs95qil4=;
        b=qIZ72UKq/4Zcaxdk1dJguzGbzZA/7RJH/jcNe/lg8FSvoUn2J7Ev6Jh9qPsDp/ToEu
         1I7k9oYlRwOd0msA0memr8qLlqLpRwZXAWWjnjYsUp0syxdVSN/PY5uToNh90eH+rVux
         speWpA+zxvSJtmyKFElM1QQdokJAce8FOrQSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=beBLCoo7/GGisLBwjVhQWqaU9CK/4NIdDbuNuM8C2pVvyo1PMCyDzHBeH0CkKBrKt/
         UTJMIwmKH3tiiJqEY9KyzcDM2etxSTW9/c2AKbpHhaJPmnII8HL5Y/zmuLmzpYPvCQMO
         Dn/boB6SC/tX7WOXjKn6Vqlph9I2GPyyRvHYc=
Received: by 10.114.124.1 with SMTP id w1mr608493wac.13.1227093186186;
        Wed, 19 Nov 2008 03:13:06 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 03:13:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101322>

------=_Part_34606_27919187.1227093186180
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The opened packs seem to stay open forever.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I'm very unsure about the solution, though: it is really horrible code
to debug...

 builtin-pack-objects.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_34606_27919187.1227093186180
Content-Type: text/x-diff;
 name=0001-Fix-handle-leak-in-builtin-pack-objects.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnpvjpxj0
Content-Disposition: attachment;
 filename=0001-Fix-handle-leak-in-builtin-pack-objects.patch

RnJvbSBkMGZiZmQwNWU1YzFmNDFmNTgyODFkODVkNjhjNzA1YzVmMDM2ZTdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDE5IE5vdiAyMDA4IDExOjA0OjQ4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGhh
bmRsZSBsZWFrIGluIGJ1aWx0aW4tcGFjay1vYmplY3RzCgpUaGUgb3BlbmVkIHBhY2tzIHNlZW0g
dG8gc3RheSBvcGVuIGZvcmV2ZXIuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxr
bWxAZ21haWwuY29tPgotLS0KIGJ1aWx0aW4tcGFjay1vYmplY3RzLmMgfCAgICAxICsKIDEgZmls
ZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2J1aWx0aW4tcGFjay1vYmplY3RzLmMgYi9idWlsdGluLXBhY2stb2JqZWN0cy5jCmluZGV4IDY3
ZWVmYTIuLmU2OGU5OTcgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKKysrIGIv
YnVpbHRpbi1wYWNrLW9iamVjdHMuYwpAQCAtNTMyLDYgKzUzMiw3IEBAIHN0YXRpYyB2b2lkIHdy
aXRlX3BhY2tfZmlsZSh2b2lkKQogCiAJCQlpZHhfdG1wX25hbWUgPSB3cml0ZV9pZHhfZmlsZShO
VUxMLCB3cml0dGVuX2xpc3QsCiAJCQkJCQkgICAgICBucl93cml0dGVuLCBzaGExKTsKKwkJCXJl
bGVhc2VfcGFja19tZW1vcnkoLTEsIC0xKTsKIAogCQkJc25wcmludGYodG1wbmFtZSwgc2l6ZW9m
KHRtcG5hbWUpLCAiJXMtJXMucGFjayIsCiAJCQkJIGJhc2VfbmFtZSwgc2hhMV90b19oZXgoc2hh
MSkpOwotLSAKMS42LjAuNC42NDQuZ2I2MTlhCgo=
------=_Part_34606_27919187.1227093186180--
