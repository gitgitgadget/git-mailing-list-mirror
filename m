From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix mkpath abuse in dwim_ref/sha1_name.c
Date: Tue, 14 Oct 2008 18:23:49 +0200
Message-ID: <81b0412b0810140923x5cf58bb9x5acd1517a19e9847@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11288_9581461.1224001429805"
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 18:29:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpmhj-0004Kf-Nf
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYJNQXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 12:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYJNQXw
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 12:23:52 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58223 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYJNQXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 12:23:51 -0400
Received: by gxk9 with SMTP id 9so5409207gxk.13
        for <git@vger.kernel.org>; Tue, 14 Oct 2008 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=jfXQBTlz839nYApGFNagCm1w1ctqSh/1zkB7I8Efn0g=;
        b=km1rndrbYay8//IQUusmC+ZhTdoXKdEHwpt5KFuPTiiZdDaFyLIsDQ4/OMCNdudMUk
         hWqNnhzxH7iLRyK5PhN3HakAZ8taGsP/VjJ8YF2tS4mRhYCy9TU6Dt7oN6j/sWf8FoUS
         Ni8XrT+nL2sa0chxaXVcshKwqcW3pN7MZLaz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=njVJ6G42F1TKVo+lAeLUq3Mn/PZH5yCbR5LmXHlne/jEiDqJkvLOOk0+Z4fR700Ga3
         dEwRNtx0wyM3gPuoU5p3/YdfAJYaQsWcjm+haAEUucDANliMnSCzsQmtXJcFs89p9sZG
         IHv9vByEET1PFFe6+aVicuQhmWqWdSBizR3NU=
Received: by 10.100.194.5 with SMTP id r5mr851774anf.11.1224001429840;
        Tue, 14 Oct 2008 09:23:49 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 14 Oct 2008 09:23:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98197>

------=_Part_11288_9581461.1224001429805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise the function sometimes fail to resolve obviously correct refnames,
because the string data pointed to by "ref" argument were reused.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 sha1_name.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Frankly, I'm having hard time trying to justify _any_ use of mkpath.
It is a bug waiting to happen every time is any code between the
call site and assignment but strdup.

------=_Part_11288_9581461.1224001429805
Content-Type: text/x-patch; name=0001-Fix-mkpath-abuse-in-sha1_name.c.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmaqvb1g0
Content-Disposition: attachment;
 filename=0001-Fix-mkpath-abuse-in-sha1_name.c.patch

RnJvbSAwNTJlMTM3ZDRhZDg2ODdkNzhiYjI1NzAzOTBlZDRmNmIxOWY3Y2JhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE0IE9jdCAyMDA4IDE4OjE0OjIwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IG1r
cGF0aCBhYnVzZSBpbiBzaGExX25hbWUuYwoKT3RoZXJ3aXNlIHRoZSBmdW5jdGlvbiBzb21ldGlt
ZXMgZmFpbCB0byByZXNvbHZlIG9idmlvdXNseSBjb3JyZWN0IHJlZm5hbWVzLApiZWNhdXNlIHRo
ZSBzdHJpbmcgZGF0YSBwb2ludGVkIHRvIGJ5ICJyZWYiIGFyZ3VtZW50IHdlcmUgcmV1c2VkLgoK
U2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBzaGEx
X25hbWUuYyB8ICAgIDYgKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zaGExX25hbWUuYyBiL3NoYTFfbmFtZS5jCmlu
ZGV4IDQxYjY4MDkuLmI1YjUzYmYgMTAwNjQ0Ci0tLSBhL3NoYTFfbmFtZS5jCisrKyBiL3NoYTFf
bmFtZS5jCkBAIC0yNDIsNiArMjQyLDcgQEAgaW50IGR3aW1fcmVmKGNvbnN0IGNoYXIgKnN0ciwg
aW50IGxlbiwgdW5zaWduZWQgY2hhciAqc2hhMSwgY2hhciAqKnJlZikKIHsKIAljb25zdCBjaGFy
ICoqcCwgKnI7CiAJaW50IHJlZnNfZm91bmQgPSAwOworCWNoYXIgZnVsbHJlZltQQVRIX01BWF07
CiAKIAkqcmVmID0gTlVMTDsKIAlmb3IgKHAgPSByZWZfcmV2X3BhcnNlX3J1bGVzOyAqcDsgcCsr
KSB7CkBAIC0yNDksNyArMjUwLDggQEAgaW50IGR3aW1fcmVmKGNvbnN0IGNoYXIgKnN0ciwgaW50
IGxlbiwgdW5zaWduZWQgY2hhciAqc2hhMSwgY2hhciAqKnJlZikKIAkJdW5zaWduZWQgY2hhciAq
dGhpc19yZXN1bHQ7CiAKIAkJdGhpc19yZXN1bHQgPSByZWZzX2ZvdW5kID8gc2hhMV9mcm9tX3Jl
ZiA6IHNoYTE7Ci0JCXIgPSByZXNvbHZlX3JlZihta3BhdGgoKnAsIGxlbiwgc3RyKSwgdGhpc19y
ZXN1bHQsIDEsIE5VTEwpOworCQlzbnByaW50ZihmdWxscmVmLCBzaXplb2YoZnVsbHJlZiksICpw
LCBsZW4sIHN0cik7CisJCXIgPSByZXNvbHZlX3JlZihmdWxscmVmLCB0aGlzX3Jlc3VsdCwgMSwg
TlVMTCk7CiAJCWlmIChyKSB7CiAJCQlpZiAoIXJlZnNfZm91bmQrKykKIAkJCQkqcmVmID0geHN0
cmR1cChyKTsKQEAgLTI3Miw3ICsyNzQsNyBAQCBpbnQgZHdpbV9sb2coY29uc3QgY2hhciAqc3Ry
LCBpbnQgbGVuLCB1bnNpZ25lZCBjaGFyICpzaGExLCBjaGFyICoqbG9nKQogCQljaGFyIHBhdGhb
UEFUSF9NQVhdOwogCQljb25zdCBjaGFyICpyZWYsICppdDsKIAotCQlzdHJjcHkocGF0aCwgbWtw
YXRoKCpwLCBsZW4sIHN0cikpOworCQlzbnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICpwLCBs
ZW4sIHN0cik7CiAJCXJlZiA9IHJlc29sdmVfcmVmKHBhdGgsIGhhc2gsIDEsIE5VTEwpOwogCQlp
ZiAoIXJlZikKIAkJCWNvbnRpbnVlOwotLSAKMS42LjAuMi40OTQuZ2IyNWRhCgo=
------=_Part_11288_9581461.1224001429805--
