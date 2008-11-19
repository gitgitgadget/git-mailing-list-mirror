From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix handle leak in sha1_file/unpack_objects if there were damaged object data
Date: Wed, 19 Nov 2008 12:14:05 +0100
Message-ID: <81b0412b0811190314k92a0acbn3ea820cce2a7a40b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34613_11966437.1227093245655"
To: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 19 12:15:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2l1o-0002XU-9h
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYKSLOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 06:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYKSLOI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 06:14:08 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:4881 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbYKSLOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 06:14:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1704949wah.21
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=3HHqvAD+WEkA9NGT2btad95VM1NxEWnWeQeB2SpkMYc=;
        b=LGSnQB/LmcbjkrkGeoI3I0upRJmyc4UVtCcvv3zTvzTD59pLBJtvpNLCpaKmmeWoAF
         Cn0u9icqX/WsopBDrjnEn1bHZrvsQpoGM//x7VPTkjKbxLX4bi1lKCiPoDrbchjG7X1A
         Qr51EzVMilNjXgFmuBxZck8DqFpYa4+tcq07s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=xL+jIzfOgoIRsT6jnX4NmfcQdBzo/cpum2EsZ4cw7708dtUwx9bGXerWyy4+joBfjv
         b7PWIVFDqyIFvMACbriMAIJlcgyu4afvvrqLemS9ZAn4qSesgsvmJm/Tg5ByGWLMzukk
         y2CPXUDpx8E7SXM43v+HxkMKbPxWk1jBOt1DM=
Received: by 10.114.124.12 with SMTP id w12mr590317wac.131.1227093245674;
        Wed, 19 Nov 2008 03:14:05 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 03:14:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101323>

------=_Part_34613_11966437.1227093245655
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In the case of bad packed object CRC, unuse_pack wasn't called after
check_pack_crc which calls use_pack.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_34613_11966437.1227093245655
Content-Type: text/x-diff;
 name=0002-Fix-handle-leak-in-sha1_file-unpack_objects-if-there.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fnpvlnqi0
Content-Disposition: attachment;
 filename=0002-Fix-handle-leak-in-sha1_file-unpack_objects-if-there.patch

RnJvbSAzYjRjMTNkZGVlYmU0YmM1NGEzZjlhYjliZDI2OTA5Y2M1ZTFlZmYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDE5IE5vdiAyMDA4IDExOjE3OjEzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGhh
bmRsZSBsZWFrIGluIHNoYTFfZmlsZS91bnBhY2tfb2JqZWN0cyBpZiB0aGVyZSB3ZXJlIGRhbWFn
ZWQgb2JqZWN0IGRhdGEKCkluIHRoZSBjYXNlIG9mIGJhZCBwYWNrZWQgb2JqZWN0IENSQywgdW51
c2VfcGFjayB3YXNuJ3QgY2FsbGVkIGFmdGVyCmNoZWNrX3BhY2tfY3JjIHdoaWNoIGNhbGxzIHVz
ZV9wYWNrLgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4K
LS0tCiBzaGExX2ZpbGUuYyB8ICAgIDEgKwogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2hhMV9maWxlLmMgYi9zaGExX2ZpbGUu
YwppbmRleCA3NWE3NDhhLi4wMTA2ZTJjIDEwMDY0NAotLS0gYS9zaGExX2ZpbGUuYworKysgYi9z
aGExX2ZpbGUuYwpAQCAtMTc0OSw2ICsxNzQ5LDcgQEAgdm9pZCAqdW5wYWNrX2VudHJ5KHN0cnVj
dCBwYWNrZWRfZ2l0ICpwLCBvZmZfdCBvYmpfb2Zmc2V0LAogCQkJZXJyb3IoImJhZCBwYWNrZWQg
b2JqZWN0IENSQyBmb3IgJXMiLAogCQkJICAgICAgc2hhMV90b19oZXgoc2hhMSkpOwogCQkJbWFy
a19iYWRfcGFja2VkX29iamVjdChwLCBzaGExKTsKKwkJCXVudXNlX3BhY2soJndfY3Vycyk7CiAJ
CQlyZXR1cm4gTlVMTDsKIAkJfQogCX0KLS0gCjEuNi4wLjQuNjQ0LmdiNjE5YQoK
------=_Part_34613_11966437.1227093245655--
