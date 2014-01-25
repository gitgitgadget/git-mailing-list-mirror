From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Verifiable git archives?
Date: Sat, 25 Jan 2014 13:56:53 -0800
Message-ID: <CALCETrVq_+o44EqvrOJNUfEuDMOtMketa+KrxrZ0tLwVErx7EQ@mail.gmail.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
 <xmqqsiswapav.fsf@gitster.dls.corp.google.com> <52DB1DB4.7080806@alum.mit.edu>
 <xmqqiotdunus.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11339ae4b708ed04f0d28ee3
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 22:57:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7BE9-0004wv-UK
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 22:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbaAYV5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 16:57:17 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:37568 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaAYV5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 16:57:15 -0500
Received: by mail-vc0-f171.google.com with SMTP id le5so2636083vcb.30
        for <git@vger.kernel.org>; Sat, 25 Jan 2014 13:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=C+V2dW85pKdJ4n4AwSoAkg2virJ3YAELMLN1aF6Z5ZI=;
        b=UDx2Du2wputTSkUEEkBM5Z7J0lbM1EAWnYLpJf5qR2ivl4JJ3WmnDlPuGF8zzw94j+
         NO1kgOfMdu2LxqQkApPU+HUxZtHLIl2PTE8kRhc+QVN6KEGBg+5iMfqnUACCnAZXbYCk
         m2PxqU78FBAif3TIovjVNI6sOssm3U16a9PIjLLtguo8Ki9k9h9U7wJjYmVNgLgjxtnM
         YgxN+GHVl1WDLmB9mri7qunhwsZEgqxunSYqMoOTgoJpkFNAHko+Ne/yPEvkS8zuj4vS
         z+gsvOM1qZIXV+Z9HqaYkz+QtJwWTSpTAqq1Q0ljLuQTHpHgDCZZC0jzCqsJd6gDv0Zl
         oVEg==
X-Gm-Message-State: ALoCoQliDAbhF6aQZsFK+64pWzVKc9ApWAdeeZKJ2Fj8pZeW4wXJJfDrcr0Kuvay45NhiuW2bN5j
X-Received: by 10.221.26.10 with SMTP id rk10mr11345537vcb.0.1390687034988;
 Sat, 25 Jan 2014 13:57:14 -0800 (PST)
Received: by 10.58.57.130 with HTTP; Sat, 25 Jan 2014 13:56:53 -0800 (PST)
In-Reply-To: <xmqqiotdunus.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241075>

--001a11339ae4b708ed04f0d28ee3
Content-Type: text/plain; charset=ISO-8859-1

Here's a rather hackish implementation of the write side.  Any
thoughts on the format?  (Obviously the implementation needs work.
For example, it needs to be optional.

Thoughts so far:
 - I want to put the value of "prefix" into an extended header.
 - Should blobs have their sha1 hashes in an extended header?  Pros:
it makes figuring out substitutions easier.  Cons: it adds 512 bytes
per file.
 - I want to support tags as roots.
 - I (or someone) need to write a verifier / verified unpacker.  Does
git accept Python code?

This thing is tested in the sense that GNU tar unpacks its output
without any warnings or other fanfare.

--Andy

--001a11339ae4b708ed04f0d28ee3
Content-Type: text/x-patch; charset=US-ASCII; name="verifiable_archive.patch"
Content-Disposition: attachment; filename="verifiable_archive.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqvf4nkf0

ZGlmZiAtLWdpdCBhL2FyY2hpdmUtdGFyLmMgYi9hcmNoaXZlLXRhci5jCmluZGV4IDcxOWI2Mjku
LmM2YmY3ZTQgMTAwNjQ0Ci0tLSBhL2FyY2hpdmUtdGFyLmMKKysrIGIvYXJjaGl2ZS10YXIuYwpA
QCAtMiw2ICsyLDggQEAKICAqIENvcHlyaWdodCAoYykgMjAwNSwgMjAwNiBSZW5lIFNjaGFyZmUK
ICAqLwogI2luY2x1ZGUgImNhY2hlLmgiCisjaW5jbHVkZSAidHJlZS5oIgorI2luY2x1ZGUgIm9i
amVjdC5oIgogI2luY2x1ZGUgInRhci5oIgogI2luY2x1ZGUgImFyY2hpdmUuaCIKICNpbmNsdWRl
ICJzdHJlYW1pbmcuaCIKQEAgLTIwMCw2ICsyMDIsNzQgQEAgc3RhdGljIGludCB3cml0ZV9leHRl
bmRlZF9oZWFkZXIoc3RydWN0IGFyY2hpdmVyX2FyZ3MgKmFyZ3MsCiAJcmV0dXJuIDA7CiB9CiAK
Ky8qCisgKiBBIEdJVC1TQ00gb2JqZWN0IGhlYWRlciBpcyBhIGdsb2JhbCBleHRlbmRlZCBoZWFk
ZXIgdGhhdCBlbWJlZHMgYSBzaW5nbGUKKyAqIGdpdCBvYmplY3QuICBUaGlzIG9iamVjdCBzZXJ2
ZXMgYSBwdXJwb3NlIGRlc2NyaWJlZCBieSB0aGUgInB1cnBvc2UiCisgKiBmaWVsZC4gIFZhbGlk
IHB1cnBvc2VzIGluY2x1ZGU6CisgKgorICogIC0gInJvb3QiIC0tIGFuIG9iamVjdCB0aGF0LCBi
eSBpdHNlbGYsIGluIGNvbmp1bmN0aW9uIHdpdGggb3RoZXIgcm9vdHMsCisgKiAgICBvciBpbiBj
b25qdW5jdGlvbiB3aXRoIGV4dGVybmFsIGRhdGEsIGlkZW50aWZpZXMgYSByb290IHRvIHVzZSB0
bworICogICAgdmVyaWZ5IHRoaXMgYXJjaGl2ZS4KKyAqICAtICJ2cmZ5IiAtLSBhbiBvYmplY3Qg
dGhhdCBjYW4gYmUgdXNlIHRvIHByb3ZlIHRoYXQgdGhlIGNvbnRlbnRzCisgKiAgICBvZiB0aGlz
IGFyY2hpdmUgYXJlIGFzIGRlc2NyaWJlZC4KKyAqCisgKiBUaGVyZSdzIG9uZSBiYXNpYyBydWxl
IHRvIG9ic2VydmU6IGV2ZXJ5ICJ2cmZ5IiBvYmplY3QgbXVzdCBoYXNoIHRvCisgKiBhIFNIQS0x
IHRoYXQgbWF0Y2hlcyBzb21ldGhpbmcgZGVzY3JpYmVkIGluIGEgInJvb3QiLCBhbm90aGVyICJ2
cmZ5IiBvYmplY3QsCisgKiBvciBzb21ldGhpbmcgdHlwZWQgaW4gYnkgYSB1c2VyIGRlY29kaW5n
IHRoZSBhcmNoaXZlLgorICoKKyAqIChPZiBjb3Vyc2UsIGlmIHlvdSB3YW50IHRoZSBhcmNoaXZl
IHRvIGJlIHVzZWZ1bGx5IHZlcmlmaWFibGUsIGFsbCBvZiB0aGUKKyAqICBub24tR0lULVNDTSBj
b250ZW50cyBzaG91bGQgYWxzbyBiZSBhdHRyaWJ1dGFibGUgdG8gYW4gYXBwcm9wcmlhdGUKKyAq
ICAidnJmeSIgb2JqZWN0LikKKyAqCisgKiBUaGUgZmllbGRzIGFyZToKKyAqICBHSVQtU0NNLm9i
ai5wdXJwb3NlOiB0aGUgcHVycG9zZSBvZiB0aGUgZW1iZWRkZWQgb2JqZWN0CisgKiAgR0lULVND
TS5vYmouc2hhMTogdGhlIHNoYTEgb2YgdGhlIGVtYmVkZGVkIG9iamVjdAorICogIEdJVC1TQ00u
b2JqLnR5cGU6IHRoZSB0eXBlIG9mIHRoZSBlbWJlZGRlZCBvYmplY3QKKyAqICBHSVQtU0NNLm9i
ai5kYXRhOiB0aGUgZGF0YSBpbiB0aGUgZW1iZWRkZWQgb2JqZWN0CisgKgorICogVGhlIGJsb2Nr
IGhlYWRlciBpcyBpbnRlbnRpb25hbGx5IHVuc3BlY2lmaWVkLCBleGNlcHQgdGhhdCBpdCBtdXN0
CisgKiBoYXZlIHR5cGVmbGFnICdnJy4gIChUaGlzIGlzIHRvIGFsbG93IHNvbWUgZmxleGliaWxp
dHkgaW4gdHJ5aW5nIHRvCisgKiBwcmVzZXJ2ZSBjb21wYXRpYmlsaXR5IHdpdGggb2xkIHRhciBp
bXBsZW1lbnRhdGlvbnMuKQorICovCitzdGF0aWMgaW50IHdyaXRlX2dpdHNjbV9vYmpfaGVhZGVy
KHN0cnVjdCBhcmNoaXZlcl9hcmdzICphcmdzLAorCQkJCSAgIGNvbnN0IGNoYXIgKnB1cnBvc2Us
CisJCQkJICAgY29uc3QgdW5zaWduZWQgY2hhciAqc2hhMSkKK3sKKwlzdHJ1Y3Qgc3RyYnVmIGV4
dF9oZWFkZXIgPSBTVFJCVUZfSU5JVDsKKwlzdHJ1Y3QgdXN0YXJfaGVhZGVyIGhlYWRlcjsKKwl1
bnNpZ25lZCBpbnQgbW9kZTsKKwllbnVtIG9iamVjdF90eXBlIHR5cGU7CisJdW5zaWduZWQgbG9u
ZyBzaXplOworCXZvaWQgKmJ1ZmZlcjsKKwljb25zdCBjaGFyICp0eXBlc3RyOworCWludCBlcnIg
PSAwOworCisJc3RyYnVmX2FwcGVuZF9leHRfaGVhZGVyKCZleHRfaGVhZGVyLCAiR0lULVNDTS5v
YmoucHVycG9zZSIsCisJCQkJIHB1cnBvc2UsIHN0cmxlbihwdXJwb3NlKSk7CisJc3RyYnVmX2Fw
cGVuZF9leHRfaGVhZGVyKCZleHRfaGVhZGVyLCAiR0lULVNDTS5vYmouc2hhMSIsCisJCQkJIHNo
YTFfdG9faGV4KHNoYTEpLCA0MCk7CisKKwlidWZmZXIgPSByZWFkX3NoYTFfZmlsZShzaGExLCAm
dHlwZSwgJnNpemUpOworCXR5cGVzdHIgPSB0eXBlbmFtZSh0eXBlKTsKKworCXN0cmJ1Zl9hcHBl
bmRfZXh0X2hlYWRlcigmZXh0X2hlYWRlciwgIkdJVC1TQ00ub2JqLnR5cGUiLAorCQkJCSB0eXBl
c3RyLCBzdHJsZW4odHlwZXN0cikpOworCXN0cmJ1Zl9hcHBlbmRfZXh0X2hlYWRlcigmZXh0X2hl
YWRlciwgIkdJVC1TQ00ub2JqLmRhdGEiLAorCQkJCSBidWZmZXIsIHNpemUpOworCWZyZWUoYnVm
ZmVyKTsKKwlidWZmZXIgPSBOVUxMOworCisJbWVtc2V0KCZoZWFkZXIsIDAsIHNpemVvZihoZWFk
ZXIpKTsKKwkqaGVhZGVyLnR5cGVmbGFnID0gVFlQRUZMQUdfR0xPQkFMX0hFQURFUjsKKwltb2Rl
ID0gMDEwMDY2NjsKKwlzdHJjcHkoaGVhZGVyLm5hbWUsICJwYXhfZ2xvYmFsX2hlYWRlciIpOwor
CXByZXBhcmVfaGVhZGVyKGFyZ3MsICZoZWFkZXIsIG1vZGUsIGV4dF9oZWFkZXIubGVuKTsKKwl3
cml0ZV9ibG9ja2VkKCZoZWFkZXIsIHNpemVvZihoZWFkZXIpKTsKKwl3cml0ZV9ibG9ja2VkKGV4
dF9oZWFkZXIuYnVmLCBleHRfaGVhZGVyLmxlbik7CisJc3RyYnVmX3JlbGVhc2UoJmV4dF9oZWFk
ZXIpOworCXJldHVybiBlcnI7Cit9CisKIHN0YXRpYyBpbnQgd3JpdGVfdGFyX2VudHJ5KHN0cnVj
dCBhcmNoaXZlcl9hcmdzICphcmdzLAogCQkJICAgY29uc3QgdW5zaWduZWQgY2hhciAqc2hhMSwK
IAkJCSAgIGNvbnN0IGNoYXIgKnBhdGgsIHNpemVfdCBwYXRobGVuLApAQCAtMjEyLDYgKzI4Miwx
MCBAQCBzdGF0aWMgaW50IHdyaXRlX3Rhcl9lbnRyeShzdHJ1Y3QgYXJjaGl2ZXJfYXJncyAqYXJn
cywKIAl2b2lkICpidWZmZXI7CiAJaW50IGVyciA9IDA7CiAKKwlpZiAoU19JU0RJUihtb2RlKSkg
eworCQl3cml0ZV9naXRzY21fb2JqX2hlYWRlcihhcmdzLCAidnJmeSIsIHNoYTEpOworCX0KKwog
CW1lbXNldCgmaGVhZGVyLCAwLCBzaXplb2YoaGVhZGVyKSk7CiAKIAlpZiAoU19JU0RJUihtb2Rl
KSB8fCBTX0lTR0lUTElOSyhtb2RlKSkgewpAQCAtMzg0LDggKzQ1OCwxMSBAQCBzdGF0aWMgaW50
IHdyaXRlX3Rhcl9hcmNoaXZlKGNvbnN0IHN0cnVjdCBhcmNoaXZlciAqYXIsCiAKIAlpZiAoYXJn
cy0+Y29tbWl0X3NoYTEpCiAJCWVyciA9IHdyaXRlX2dsb2JhbF9leHRlbmRlZF9oZWFkZXIoYXJn
cyk7Ci0JaWYgKCFlcnIpCisJaWYgKCFlcnIpIHsKKwkJd3JpdGVfZ2l0c2NtX29ial9oZWFkZXIo
YXJncywgInJvb3QiLCBhcmdzLT5jb21taXRfc2hhMSk7CisJCXdyaXRlX2dpdHNjbV9vYmpfaGVh
ZGVyKGFyZ3MsICJ2cmZ5IiwgYXJncy0+dHJlZS0+b2JqZWN0LnNoYTEpOwogCQllcnIgPSB3cml0
ZV9hcmNoaXZlX2VudHJpZXMoYXJncywgd3JpdGVfdGFyX2VudHJ5KTsKKwl9CiAJaWYgKCFlcnIp
CiAJCXdyaXRlX3RyYWlsZXIoKTsKIAlyZXR1cm4gZXJyOwo=
--001a11339ae4b708ed04f0d28ee3--
