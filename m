From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [Resend Trivial PATCH] For the sake of correctness, fix file descriptor leak.
Date: Sun, 25 Nov 2007 19:37:05 -0200
Message-ID: <b8bf37780711251337q41e02304q8fd2654b1e83201@mail.gmail.com>
References: <b8bf37780711211659v4fbd5936t29d0a0a2ff84f4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33512_32345849.1196026625870"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPAU-0001NQ-Mt
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035AbXKYVhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756997AbXKYVhL
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:37:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:9780 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881AbXKYVhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:37:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so808251ugc
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=Nf8llOSMXltmyszoQpQxQs9fFLuwFb4Johh6QV7NO2Y=;
        b=eVj3E2nsaAE4+znduZBq+ibWaeJwNJQ0IGARX6ATR3x2xW40KJvGl1gn+Dx09WZjQPLdGKq92MoPxkz1SfoCptV36uaBe41I0gqKjFYEZ73M1NXJz0F5OXKk4gvGL1vieJIw2Qxf3M+7TFvMNGCW4gNmvZY+aEFZzHvIi28oCDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pxoLY6Vf6m2E9CdGu5Af4z6Obbxo/YkMrSoiX7cma5UrGXgfY9TNjqss+U4IOgkMOoIJGGMlK6V8NUJnrsH9hs4gJw4aU/Y/3u0fq2tDQzEqZb9I/LyFCNykTrTvfabxK9emOM0rummNLvoSUDYfVvMPNuBiCdDL8/lFJ9DlbHY=
Received: by 10.78.176.20 with SMTP id y20mr2119091hue.1196026625876;
        Sun, 25 Nov 2007 13:37:05 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Sun, 25 Nov 2007 13:37:05 -0800 (PST)
In-Reply-To: <b8bf37780711211659v4fbd5936t29d0a0a2ff84f4b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66007>

------=_Part_33512_32345849.1196026625870
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksIGFsbCEKCiAgICBQbHVnIGEgZmlsZSBkZXNjcmlwdG9yIGxlYWsuCgpGcm9tIDlmYmEzNDZh
Y2E3NDcwNjMzZWU0Njg0ODAxMzA1MTI0ODQ5Mzg5NmMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAx
CkZyb206IEFuZHJlIEdvZGRhcmQgUm9zYSA8YW5kcmUuZ29kZGFyZEBnbWFpbC5jb20+CkRhdGU6
IFR1ZSwgMjcgTm92IDIwMDcgMTA6MTY6MjIgLTAyMDAKU3ViamVjdDogW1BBVENIXSBGb3IgdGhl
IHNha2Ugb2YgY29ycmVjdG5lc3MsIGZpeCBmaWxlIGRlc2NyaXB0b3IgbGVhay4KClNpZ25lZC1v
ZmYtYnk6IEFuZHJlIEdvZGRhcmQgUm9zYSA8YW5kcmUuZ29kZGFyZEBnbWFpbC5jb20+Ci0tLQog
YnVpbHRpbi1yZXJlcmUuYyB8ICAgIDQgKysrLQogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1yZXJlcmUuYyBiL2J1
aWx0aW4tcmVyZXJlLmMKaW5kZXggNzQ0OTMyMy4uMzE3NjZiZSAxMDA2NDQKLS0tIGEvYnVpbHRp
bi1yZXJlcmUuYworKysgYi9idWlsdGluLXJlcmVyZS5jCkBAIC0yNzUsOCArMjc1LDEwIEBAIHN0
YXRpYyBpbnQgY29weV9maWxlKGNvbnN0IGNoYXIgKnNyYywgY29uc3QgY2hhciAqZGVzdCkKCiAg
ICAgICAgaWYgKCEoaW4gPSBmb3BlbihzcmMsICJyIikpKQogICAgICAgICAgICAgICAgcmV0dXJu
IGVycm9yKCJDb3VsZCBub3Qgb3BlbiAlcyIsIHNyYyk7Ci0gICAgICAgaWYgKCEob3V0ID0gZm9w
ZW4oZGVzdCwgInciKSkpCisgICAgICAgaWYgKCEob3V0ID0gZm9wZW4oZGVzdCwgInciKSkpIHsK
KyAgICAgICAgICAgICAgIGZjbG9zZShpbik7CiAgICAgICAgICAgICAgICByZXR1cm4gZXJyb3Io
IkNvdWxkIG5vdCBvcGVuICVzIiwgZGVzdCk7CisgICAgICAgfQogICAgICAgIHdoaWxlICgoY291
bnQgPSBmcmVhZChidWZmZXIsIDEsIHNpemVvZihidWZmZXIpLCBpbikpKQogICAgICAgICAgICAg
ICAgZndyaXRlKGJ1ZmZlciwgMSwgY291bnQsIG91dCk7CiAgICAgICAgZmNsb3NlKGluKTsKLS0K
MS41LjMuNi44NjEuZ2Q3OTQtZGlydHkKCgoKLS0gCltdcywKQW5kcsOpIEdvZGRhcmQK
------=_Part_33512_32345849.1196026625870
Content-Type: text/x-patch;
 name=0002-For-the-sake-of-correctness-fix-file-descriptor-le.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9akopii0
Content-Disposition: attachment;
 filename=0002-For-the-sake-of-correctness-fix-file-descriptor-le.patch

RnJvbSA5ZmJhMzQ2YWNhNzQ3MDYzM2VlNDY4NDgwMTMwNTEyNDg0OTM4OTZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjE2OjIyIC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gRm9yIHRoZSBzYWtlIG9mIGNvcnJlY3RuZXNzLCBmaXggZmlsZSBkZXNjcmlwdG9yIGxl
YWsuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgotLS0KIGJ1aWx0aW4tcmVyZXJlLmMgfCAgICA0ICsrKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4t
cmVyZXJlLmMgYi9idWlsdGluLXJlcmVyZS5jCmluZGV4IDc0NDkzMjMuLjMxNzY2YmUgMTAwNjQ0
Ci0tLSBhL2J1aWx0aW4tcmVyZXJlLmMKKysrIGIvYnVpbHRpbi1yZXJlcmUuYwpAQCAtMjc1LDgg
KzI3NSwxMCBAQCBzdGF0aWMgaW50IGNvcHlfZmlsZShjb25zdCBjaGFyICpzcmMsIGNvbnN0IGNo
YXIgKmRlc3QpCiAKIAlpZiAoIShpbiA9IGZvcGVuKHNyYywgInIiKSkpCiAJCXJldHVybiBlcnJv
cigiQ291bGQgbm90IG9wZW4gJXMiLCBzcmMpOwotCWlmICghKG91dCA9IGZvcGVuKGRlc3QsICJ3
IikpKQorCWlmICghKG91dCA9IGZvcGVuKGRlc3QsICJ3IikpKSB7CisJCWZjbG9zZShpbik7CiAJ
CXJldHVybiBlcnJvcigiQ291bGQgbm90IG9wZW4gJXMiLCBkZXN0KTsKKwl9CiAJd2hpbGUgKChj
b3VudCA9IGZyZWFkKGJ1ZmZlciwgMSwgc2l6ZW9mKGJ1ZmZlciksIGluKSkpCiAJCWZ3cml0ZShi
dWZmZXIsIDEsIGNvdW50LCBvdXQpOwogCWZjbG9zZShpbik7Ci0tIAoxLjUuMy42Ljg2MS5nZDc5
NC1kaXJ0eQoK
------=_Part_33512_32345849.1196026625870--
