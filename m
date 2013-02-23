From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 00:02:36 +0200
Message-ID: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bdc127236637604d66b778f
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 23:03:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9NBP-0004GP-2r
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 23:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759159Ab3BWWCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 17:02:38 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:39894 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758502Ab3BWWCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 17:02:37 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so787746qca.31
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 14:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=95UzV4Awx8lUdIDQSNlPhl+IZ4Am1N38ZU2iaBzj2Oo=;
        b=ppJT3BZ/CLSMGtlez2b33eCN6bOV+qRp1hdM4PDsAqEDVMCUZf4nYZg2+tVJIYP3mi
         bugi9Cn3eEFiAPsUs9QMIuT+YxyjmSjxEyUd8fasMEAjlWu429+4UWRxo376X85Yv1CW
         KktnGp+yq45cyWOAsNqUJIEdWeQqECNE15QZ8wHMX2gRqE9zSp+UCgs2ghWg4CroDBhl
         isrERPsJUxforEs2tCRZY2CGUodWeXDepZY6ruGxOvENvHEPfucEtnYvxE7pBMX3d7sB
         IJ4BSjdAI0zI3+clOfeSu9ltRHXbo3oZi4Eeo2GC1vA6UPSEtMXLLg4mpMgUqg11LdDp
         sRIw==
X-Received: by 10.49.74.10 with SMTP id p10mr4549570qev.35.1361656956656; Sat,
 23 Feb 2013 14:02:36 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Sat, 23 Feb 2013 14:02:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216920>

--047d7bdc127236637604d66b778f
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Here is a small patch with QNX build improvements:

1) Rename tar.h to tar_git.h. Latest QNX versions have system tar.h
header according to
http://pubs.opengroup.org/onlinepubs/009696699/basedefs/tar.h.html ,
to avoid inclusion of another tar.h, original header was renamed.
2) Rename fnmatch.h to fnmatch_gnu.h and fnmatch.c to fnmatch_gnu.c to
avoid inclusion of system fnmatch.h header in case if -I/usr/include
path is specified before -Icompat/fnmatch. Which is common situation.
3) pager.c - default "less" invocation flags were changed for QNX 6,x
platform, since QNX has incompatible with GNU coreutils version of
"less" utility.
4) config.mak.uname - a) do not override mkdtemp/mkstemps/strcasestr
detection, since newer QNX version could contain such functions. Let
to configure decide what is present in the system. b) getpagesize()
function is existing under QNX, c) QNX has pthread functions in the
libc, so do not define NO_PTHREAD macro.

Thanks in advance!

--047d7bdc127236637604d66b778f
Content-Type: application/octet-stream; name="git-qnx.diff"
Content-Disposition: attachment; filename="git-qnx.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hdjahwgx1

ZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggYmE4ZTI0My4uZjZkZDJlYiAx
MDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTcyNiw3ICs3MjYsNyBAQCBM
SUJfSCArPSBzdHJlYW1pbmcuaAogTElCX0ggKz0gc3RyaW5nLWxpc3QuaAogTElCX0ggKz0gc3Vi
bW9kdWxlLmgKIExJQl9IICs9IHRhZy5oCi1MSUJfSCArPSB0YXIuaAorTElCX0ggKz0gdGFyX2dp
dC5oCiBMSUJfSCArPSB0aHJlYWQtdXRpbHMuaAogTElCX0ggKz0gdHJhbnNwb3J0LmgKIExJQl9I
ICs9IHRyZWUtd2Fsay5oCkBAIC0xMjU2LDEyICsxMjU2LDEyIEBAIGVuZGlmCiBpZmRlZiBOT19G
Tk1BVENICiAJQ09NUEFUX0NGTEFHUyArPSAtSWNvbXBhdC9mbm1hdGNoCiAJQ09NUEFUX0NGTEFH
UyArPSAtRE5PX0ZOTUFUQ0gKLQlDT01QQVRfT0JKUyArPSBjb21wYXQvZm5tYXRjaC9mbm1hdGNo
Lm8KKwlDT01QQVRfT0JKUyArPSBjb21wYXQvZm5tYXRjaC9mbm1hdGNoX2dudS5vCiBlbHNlCiBp
ZmRlZiBOT19GTk1BVENIX0NBU0VGT0xECiAJQ09NUEFUX0NGTEFHUyArPSAtSWNvbXBhdC9mbm1h
dGNoCiAJQ09NUEFUX0NGTEFHUyArPSAtRE5PX0ZOTUFUQ0hfQ0FTRUZPTEQKLQlDT01QQVRfT0JK
UyArPSBjb21wYXQvZm5tYXRjaC9mbm1hdGNoLm8KKwlDT01QQVRfT0JKUyArPSBjb21wYXQvZm5t
YXRjaC9mbm1hdGNoX2dudS5vCiBlbmRpZgogZW5kaWYKIGlmZGVmIFVTRV9XSUxETUFUQ0gKZGlm
ZiAtLWdpdCBhL2FyY2hpdmUtdGFyLmMgYi9hcmNoaXZlLXRhci5jCmluZGV4IDcxOWI2MjkuLjhl
MjQzMzYgMTAwNjQ0Ci0tLSBhL2FyY2hpdmUtdGFyLmMKKysrIGIvYXJjaGl2ZS10YXIuYwpAQCAt
Miw3ICsyLDcgQEAKICAqIENvcHlyaWdodCAoYykgMjAwNSwgMjAwNiBSZW5lIFNjaGFyZmUKICAq
LwogI2luY2x1ZGUgImNhY2hlLmgiCi0jaW5jbHVkZSAidGFyLmgiCisjaW5jbHVkZSAidGFyX2dp
dC5oIgogI2luY2x1ZGUgImFyY2hpdmUuaCIKICNpbmNsdWRlICJzdHJlYW1pbmcuaCIKICNpbmNs
dWRlICJydW4tY29tbWFuZC5oIgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi90YXItdHJlZS5jIGIvYnVp
bHRpbi90YXItdHJlZS5jCmluZGV4IDNmMWU3MDEuLmIwZTQ1NTEgMTAwNjQ0Ci0tLSBhL2J1aWx0
aW4vdGFyLXRyZWUuYworKysgYi9idWlsdGluL3Rhci10cmVlLmMKQEAgLTMsNyArMyw3IEBACiAg
Ki8KICNpbmNsdWRlICJjYWNoZS5oIgogI2luY2x1ZGUgImNvbW1pdC5oIgotI2luY2x1ZGUgInRh
ci5oIgorI2luY2x1ZGUgInRhcl9naXQuaCIKICNpbmNsdWRlICJidWlsdGluLmgiCiAjaW5jbHVk
ZSAicXVvdGUuaCIKIApkaWZmIC0tZ2l0IGEvY29tcGF0L2ZubWF0Y2gvZm5tYXRjaC5jIGIvY29t
cGF0L2ZubWF0Y2gvZm5tYXRjaF9nbnUuYwpzaW1pbGFyaXR5IGluZGV4IDk5JQpyZW5hbWUgZnJv
bSBjb21wYXQvZm5tYXRjaC9mbm1hdGNoLmMKcmVuYW1lIHRvIGNvbXBhdC9mbm1hdGNoL2ZubWF0
Y2hfZ251LmMKaW5kZXggNWVmMDY4NS4uZjlhNWU1YiAxMDA2NDQKLS0tIGEvY29tcGF0L2ZubWF0
Y2gvZm5tYXRjaC5jCisrKyBiL2NvbXBhdC9mbm1hdGNoL2ZubWF0Y2hfZ251LmMKQEAgLTI2LDcg
KzI2LDcgQEAKICNlbmRpZgogCiAjaW5jbHVkZSA8ZXJybm8uaD4KLSNpbmNsdWRlIDxmbm1hdGNo
Lmg+CisjaW5jbHVkZSA8Zm5tYXRjaF9nbnUuaD4KICNpbmNsdWRlIDxjdHlwZS5oPgogCiAjaWYg
SEFWRV9TVFJJTkdfSCB8fCBkZWZpbmVkIF9MSUJDCmRpZmYgLS1naXQgYS9jb21wYXQvZm5tYXRj
aC9mbm1hdGNoLmggYi9jb21wYXQvZm5tYXRjaC9mbm1hdGNoX2dudS5oCnNpbWlsYXJpdHkgaW5k
ZXggMTAwJQpyZW5hbWUgZnJvbSBjb21wYXQvZm5tYXRjaC9mbm1hdGNoLmgKcmVuYW1lIHRvIGNv
bXBhdC9mbm1hdGNoL2ZubWF0Y2hfZ251LmgKZGlmZiAtLWdpdCBhL2NvbmZpZy5tYWsudW5hbWUg
Yi9jb25maWcubWFrLnVuYW1lCmluZGV4IDg3NDNhNmQuLjJkNDJmZmUgMTAwNjQ0Ci0tLSBhL2Nv
bmZpZy5tYWsudW5hbWUKKysrIGIvY29uZmlnLm1hay51bmFtZQpAQCAtNTI3LDE0ICs1MjcsMjEg
QEAgaWZlcSAoJCh1bmFtZV9TKSxRTlgpCiAJSEFWRV9TVFJJTkdTX0ggPSBZZXNQbGVhc2UKIAlO
RUVEU19TT0NLRVQgPSBZZXNQbGVhc2UKIAlOT19GTk1BVENIX0NBU0VGT0xEID0gWWVzUGxlYXNl
Ci0JTk9fR0VUUEFHRVNJWkUgPSBZZXNQbGVhc2UKIAlOT19JQ09OViA9IFllc1BsZWFzZQogCU5P
X01FTU1FTSA9IFllc1BsZWFzZQotCU5PX01LRFRFTVAgPSBZZXNQbGVhc2UKLQlOT19NS1NURU1Q
UyA9IFllc1BsZWFzZQogCU5PX05TRUMgPSBZZXNQbGVhc2UKLQlOT19QVEhSRUFEUyA9IFllc1Bs
ZWFzZQogCU5PX1JfVE9fR0NDX0xJTktFUiA9IFllc1BsZWFzZQotCU5PX1NUUkNBU0VTVFIgPSBZ
ZXNQbGVhc2UKIAlOT19TVFJMQ1BZID0gWWVzUGxlYXNlCisJIyBBbGwgUU5YIDYueCB2ZXJzaW9u
cyBoYXZlIHB0aHJlYWQgZnVuY3Rpb25zIGluIGxpYmMKKwkjIGFuZCBnZXRwYWdlc2l6ZS4gTGVh
dmUgbWtzdGVtcHMvbWtkdGVtcC9zdHJjYXNlc3RyIGZvcgorCSMgYXV0b2RldGVjdGlvbi4KKwlp
ZmVxICgkKHNoZWxsIGV4cHIgIiQodW5hbWVfUikiIDogJzZcLlswLTldXC5bMC05XScpLDUpCisJ
CVBUSFJFQURfTElCUyA9ICIiCisJZWxzZQorCQlOT19QVEhSRUFEUyA9IFllc1BsZWFzZQorCQlO
T19HRVRQQUdFU0laRSA9IFllc1BsZWFzZQorCQlOT19TVFJDQVNFU1RSID0gWWVzUGxlYXNlCisJ
CU5PX01LU1RFTVBTID0gWWVzUGxlYXNlCisJCU5PX01LRFRFTVAgPSBZZXNQbGVhc2UKKwllbmRp
ZgogZW5kaWYKZGlmZiAtLWdpdCBhL2dpdC1jb21wYXQtdXRpbC5oIGIvZ2l0LWNvbXBhdC11dGls
LmgKaW5kZXggYjdlYWFhOS4uZjU5ZDY5NiAxMDA2NDQKLS0tIGEvZ2l0LWNvbXBhdC11dGlsLmgK
KysrIGIvZ2l0LWNvbXBhdC11dGlsLmgKQEAgLTExMyw3ICsxMTMsMTEgQEAKICNpbmNsdWRlIDx0
aW1lLmg+CiAjaW5jbHVkZSA8c2lnbmFsLmg+CiAjaWZuZGVmIFVTRV9XSUxETUFUQ0gKKyNpZiBk
ZWZpbmVkKE5PX0ZOTUFUQ0gpIHx8IGRlZmluZWQoTk9fRk5NQVRDSF9DQVNFRk9MRCkKKyNpbmNs
dWRlIDxmbm1hdGNoX2dudS5oPgorI2Vsc2UKICNpbmNsdWRlIDxmbm1hdGNoLmg+CisjZW5kaWYg
LyogTk9fRk5NQVRDSCAqLwogI2VuZGlmCiAjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8
cmVnZXguaD4KZGlmZiAtLWdpdCBhL3BhZ2VyLmMgYi9wYWdlci5jCmluZGV4IGMxZWNmNjUuLmJl
ZDYyN2EgMTAwNjQ0Ci0tLSBhL3BhZ2VyLmMKKysrIGIvcGFnZXIuYwpAQCAtODEsNyArODEsMTEg
QEAgdm9pZCBzZXR1cF9wYWdlcih2b2lkKQogCXBhZ2VyX3Byb2Nlc3MuYXJndiA9IHBhZ2VyX2Fy
Z3Y7CiAJcGFnZXJfcHJvY2Vzcy5pbiA9IC0xOwogCWlmICghZ2V0ZW52KCJMRVNTIikpIHsKKwkj
aWYgIWRlZmluZWQoX19RTlhOVE9fXykKIAkJc3RhdGljIGNvbnN0IGNoYXIgKmVudltdID0geyAi
TEVTUz1GUlNYIiwgTlVMTCB9OworCSNlbHNlCisJCXN0YXRpYyBjb25zdCBjaGFyICplbnZbXSA9
IHsgIkxFU1M9clMiLCBOVUxMIH07CisJI2VuZGlmIC8qIF9fUU5YTlRPX18gKi8KIAkJcGFnZXJf
cHJvY2Vzcy5lbnYgPSBlbnY7CiAJfQogCWlmIChzdGFydF9jb21tYW5kKCZwYWdlcl9wcm9jZXNz
KSkKZGlmZiAtLWdpdCBhL3Rhci5oIGIvdGFyX2dpdC5oCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpy
ZW5hbWUgZnJvbSB0YXIuaApyZW5hbWUgdG8gdGFyX2dpdC5oCg==
--047d7bdc127236637604d66b778f--
