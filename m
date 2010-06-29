From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 1/2] Add a string_list_foreach macro
Date: Tue, 29 Jun 2010 10:35:15 +0200
Message-ID: <AANLkTilj7MiqiCmptDw0PLM5QqKZOOSZnSsxMlELS_5_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174bed84d08e72048a271d43
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 10:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTWHy-0001AR-Un
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 10:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab0F2IfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 04:35:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35749 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab0F2IfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 04:35:17 -0400
Received: by ewy23 with SMTP id 23so287622ewy.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=tmNvFzxkUPdxAB7fNm+MQRGlTFrBpACTS1/x9nk7GY8=;
        b=sQ0VHyVaVx3739Nutgz5RvnUqKZQDIrgMs15eJD1m5+k1TkeGvjMjkhJS1/XIheMVb
         ObpmvCrzrWNRy8akaPf6APvZqmObyfScubyxCmk8PtyJ4z8k4c6qTmnpammLlsJsLxPN
         AV8EQGjuaNZG1bMEgU6p7//fvH1TE/eUN0srY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=vZfh9LCS7i7Uud03X+zNi47Qg/uE2/EoLxlKzZonlthYe7h239udDlILHvLqCiA8zT
         7eOVQN4O0pbJ++ti99UnR40AvYki70vhAFufGZf7vi3rLIXtzj6CRIht3T61Tj/ffVSC
         zguZNKXzwRQDUamz4T6DdoX6PwdjWjEmZUJ+U=
Received: by 10.213.22.201 with SMTP id o9mr1587397ebb.89.1277800515407; Tue, 
	29 Jun 2010 01:35:15 -0700 (PDT)
Received: by 10.213.105.148 with HTTP; Tue, 29 Jun 2010 01:35:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149894>

--0015174bed84d08e72048a271d43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is more lightweight than for_each_string_list function with
callback function and a cookie argument.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

On Tue, Jun 29, 2010 at 10:33, Alex Riesen <raa.lkml@gmail.com> wrote:
> BTW, now that I took a look at it... The iteration over string_list
> items looks a little overengineered. At least from the point of
> view of the existing users of the feature. Wouldn't a simple loop
> be just as simple to use (if not simplier) and faster (no uninlineable
> function calls and argument preparation and passing needed)?
>
> #define string_list_foreach(item,list) \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (item =3D (list)->items; item < (list)->it=
ems + (list)->nr; ++item)
>

 string-list.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/string-list.h b/string-list.h
index 63b69c8..188d087 100644
--- a/string-list.h
+++ b/string-list.h
@@ -24,6 +24,8 @@ void string_list_clear_func(struct string_list
*list, string_list_clear_func_t c
 typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 int for_each_string_list(string_list_each_func_t,
 			 struct string_list *list, void *cb_data);
+#define string_list_foreach(item,list) \
+	for (item =3D (list)->items; item < (list)->items + (list)->nr; ++item)

 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *str=
ing);
--=20
1.7.1.622.g408a98

--0015174bed84d08e72048a271d43
Content-Type: application/octet-stream; 
	name="0001-Add-a-string_list_foreach-macro.diff"
Content-Disposition: attachment; 
	filename="0001-Add-a-string_list_foreach-macro.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gb0hfhnh0

RnJvbSBiMmU3ZDJkY2UwY2I4YTZiNTBhZjViYTA0ZWRlZGZiMzQyNjQzYTkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDI5IEp1biAyMDEwIDEwOjAyOjQ0ICswMjAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIEFk
ZCBhIHN0cmluZ19saXN0X2ZvcmVhY2ggbWFjcm8KClRoaXMgaXMgbW9yZSBsaWdodHdlaWdodCB0
aGFuIGZvcl9lYWNoX3N0cmluZ19saXN0IGZ1bmN0aW9uIHdpdGgKY2FsbGJhY2sgZnVuY3Rpb24g
YW5kIGEgY29va2llIGFyZ3VtZW50LgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5s
a21sQGdtYWlsLmNvbT4KLS0tCiBzdHJpbmctbGlzdC5oIHwgICAgMiArKwogMSBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3RyaW5n
LWxpc3QuaCBiL3N0cmluZy1saXN0LmgKaW5kZXggNjNiNjljOC4uMTg4ZDA4NyAxMDA2NDQKLS0t
IGEvc3RyaW5nLWxpc3QuaAorKysgYi9zdHJpbmctbGlzdC5oCkBAIC0yNCw2ICsyNCw4IEBAIHZv
aWQgc3RyaW5nX2xpc3RfY2xlYXJfZnVuYyhzdHJ1Y3Qgc3RyaW5nX2xpc3QgKmxpc3QsIHN0cmlu
Z19saXN0X2NsZWFyX2Z1bmNfdCBjCiB0eXBlZGVmIGludCAoKnN0cmluZ19saXN0X2VhY2hfZnVu
Y190KShzdHJ1Y3Qgc3RyaW5nX2xpc3RfaXRlbSAqLCB2b2lkICopOwogaW50IGZvcl9lYWNoX3N0
cmluZ19saXN0KHN0cmluZ19saXN0X2VhY2hfZnVuY190LAogCQkJIHN0cnVjdCBzdHJpbmdfbGlz
dCAqbGlzdCwgdm9pZCAqY2JfZGF0YSk7CisjZGVmaW5lIHN0cmluZ19saXN0X2ZvcmVhY2goaXRl
bSxsaXN0KSBcCisJZm9yIChpdGVtID0gKGxpc3QpLT5pdGVtczsgaXRlbSA8IChsaXN0KS0+aXRl
bXMgKyAobGlzdCktPm5yOyArK2l0ZW0pCiAKIC8qIFVzZSB0aGVzZSBmdW5jdGlvbnMgb25seSBv
biBzb3J0ZWQgbGlzdHM6ICovCiBpbnQgc3RyaW5nX2xpc3RfaGFzX3N0cmluZyhjb25zdCBzdHJ1
Y3Qgc3RyaW5nX2xpc3QgKmxpc3QsIGNvbnN0IGNoYXIgKnN0cmluZyk7Ci0tIAoxLjcuMS42MjIu
ZzQwOGE5OAoK
--0015174bed84d08e72048a271d43--
