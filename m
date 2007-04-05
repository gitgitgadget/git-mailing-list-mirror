From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 10/13] update delta handling in write_object() for --pack-limit
Date: Thu, 5 Apr 2007 15:38:22 -0700
Message-ID: <56b7f5510704051538na4393d7k5e51ed2a511cc86e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59091_21658950.1175812702210"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZabW-0008B9-Qk
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767238AbXDEWiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767381AbXDEWiY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:38:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:14236 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767378AbXDEWiX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:38:23 -0400
Received: by nz-out-0506.google.com with SMTP id s1so403332nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:38:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=idRFc/jNyQMtZV6jPRgTzxgFZ6AKJ2SC7BzqJgdfUq/1CttEnnk7EYCHMZbmwhOPDLuXLNT3aT6C+XR2S8d6+GwU020WGn3u66iNcgOL5Y2hoLP9d9Mf6wDqS8YBd7x0lXsB89cUQMms9+SHXvO6N3pnJs/MKk193U7bDXvLxHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=kfO144W/PUIPSz8oUQflvy64ayA5jC4LhgDdhsrSa0/OdS5zAi3K4zYEjtY8g1AR9P5TCMBGZG7iSkeuxv/80A08TrjNgEC8N8F3tCEV4pN9GV7FnmNkiGG9M3MjOAFXnDqmpB/1G7/rlxgLdMz8p2XIQAu8XB+mPTvWJNeR3cs=
Received: by 10.114.137.2 with SMTP id k2mr979778wad.1175812702268;
        Thu, 05 Apr 2007 15:38:22 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:38:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43873>

------=_Part_59091_21658950.1175812702210
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59091_21658950.1175812702210
Content-Type: text/plain; 
	name=0010-update-delta-handling-in-write_object-for-pack-l.patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f05sif9a
Content-Disposition: attachment; filename="0010-update-delta-handling-in-write_object-for-pack-l.patch.txt"

RnJvbSA3ZWU1MDVhY2NhYzE2NzUyNjlkMWZjZmM3YTZlM2JjZjcwNzkyYTJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTQ6MTE6MjEgLTA3MDAKU3ViamVjdDogW1BBVENIIDEw
LzEzXSB1cGRhdGUgZGVsdGEgaGFuZGxpbmcgaW4gd3JpdGVfb2JqZWN0KCkgZm9yIC0tcGFjay1s
aW1pdAoKLS0tCiBidWlsdGluLXBhY2stb2JqZWN0cy5jIHwgICAgNiArKysrKy0KIDEgZmlsZXMg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1
aWx0aW4tcGFjay1vYmplY3RzLmMgYi9idWlsdGluLXBhY2stb2JqZWN0cy5jCmluZGV4IGNjYzJk
MTUuLmEyNDNlZWQgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKKysrIGIvYnVp
bHRpbi1wYWNrLW9iamVjdHMuYwpAQCAtNDE5LDEzICs0MTksMTcgQEAgc3RhdGljIG9mZl90IHdy
aXRlX29iamVjdChzdHJ1Y3Qgc2hhMWZpbGUgKmYsCiAJfQogCiAJaWYgKCF0b19yZXVzZSkgewor
CQlpbnQgdXNhYmxlX2RlbHRhID0JIWVudHJ5LT5kZWx0YSA/IDAgOgorCQkJCQkhb2Zmc2V0X2xp
bWl0ID8gMSA6CisJCQkJCWVudHJ5LT5kZWx0YS0+bm9fd3JpdGUgPyAwIDoKKwkJCQkJZW50cnkt
PmRlbHRhLT5vZmZzZXQgPyAxIDogMDsKIAkJYnVmID0gcmVhZF9zaGExX2ZpbGUoZW50cnktPnNo
YTEsICZ0eXBlLCAmc2l6ZSk7CiAJCWlmICghYnVmKQogCQkJZGllKCJ1bmFibGUgdG8gcmVhZCAl
cyIsIHNoYTFfdG9faGV4KGVudHJ5LT5zaGExKSk7CiAJCWlmIChzaXplICE9IGVudHJ5LT5zaXpl
KQogCQkJZGllKCJvYmplY3QgJXMgc2l6ZSBpbmNvbnNpc3RlbmN5ICglbHUgdnMgJWx1KSIsCiAJ
CQkgICAgc2hhMV90b19oZXgoZW50cnktPnNoYTEpLCBzaXplLCBlbnRyeS0+c2l6ZSk7Ci0JCWlm
IChlbnRyeS0+ZGVsdGEpIHsKKwkJaWYgKHVzYWJsZV9kZWx0YSkgewogCQkJYnVmID0gZGVsdGFf
YWdhaW5zdChidWYsIHNpemUsIGVudHJ5KTsKIAkJCXNpemUgPSBlbnRyeS0+ZGVsdGFfc2l6ZTsK
IAkJCW9ial90eXBlID0gKGFsbG93X29mc19kZWx0YSAmJiBlbnRyeS0+ZGVsdGEtPm9mZnNldCkg
PwotLSAKMS41LjEucmMyLjE4Lmc5Yzg4LWRpcnR5Cgo=
------=_Part_59091_21658950.1175812702210--
