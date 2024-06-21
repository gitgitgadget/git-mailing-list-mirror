Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52DF74416
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966010; cv=none; b=i+5UdAt8qPdFnYYvVjB6MZKGFN9yblmZxWI+ZeRjj0LXhRwX6me5iEU185+BBAvL2g9XnlmT4A/6w19fUGklBIUAsai603QOl8u6VdBVmw3XvuYuPbAT4aMfh0iYeOO22s5hqTRJO9kqLh/z5WgCq17LhESz2stDRbGzltT6afI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966010; c=relaxed/simple;
	bh=BLr1rsZiS3CCeOxsU+GqXDl5DBUks3z4MG16551c8GA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R5VedqSVnUtTI+w8cZRnL/Vo1qmwpyqUZB4w2GQVEWe8kA8I+G6zavQ/tSGrBkpI/9znFcxnCa2lQnPXi8hC4fMg6mSDnMvvGY37Outh9EyW+cpYhPAX7vpO7BZiQqCFHAC0q+XRMNtRNsAGIQIMmKtCa+VKigVUIL5PkKKIWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXx+tDNt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXx+tDNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718966007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=VP6+dBRNnFCxSPZ/ezzI7uSy8oE/54PEeL+yPj/Uyvc=;
	b=aXx+tDNt/RGi6WS5ORJmaOKMmaU8yhpGZpXSwuD3Og+0IGrENJSHuqaJZZyADYERHPIMBg
	2o9CAWUBGO267b9O+aR3tVBhbVvSZS8jyIuGfAXjCRUYasQ5DRFYmMzwY/yyK3184qThss
	iXRnJgf7Ccd237NJC2S66ocddguv/2E=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-EtgIm3TxNBmvDre8YDGDlg-1; Fri, 21 Jun 2024 06:33:25 -0400
X-MC-Unique: EtgIm3TxNBmvDre8YDGDlg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4ef2da0987cso789265e0c.1
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 03:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966005; x=1719570805;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VP6+dBRNnFCxSPZ/ezzI7uSy8oE/54PEeL+yPj/Uyvc=;
        b=gX+l5LtB9FtL8UbZUimroBTcsemIOB+T3tEmLyCqwphYFejluwxKxwVF7NG1FD2l5n
         WZhk65XoTgGLKpTC0/khHoGHC0X+H2AOJFrmsEQdj/5KYWch85pXCt3rOXpv2CDAeaVq
         uUOkx8vWIRKSaqj+bix1lGu1lkdP245DV2OIIiK1j1NJEr9i1IDlZHXTcR6/CUNqXZIT
         m7PADzwZP7xRoeu9EVkSZrjWqxGsCaeIfNuPxtmAt3iTxzJqYWJ8r9khM33JOX4zrhi1
         96OzzGx+M7eXk6yH5T8awqC3FBtDy3LGNm/cu1ovQPv8+YiE3VgZbYM/r9gFLbVOb2uY
         lPQg==
X-Gm-Message-State: AOJu0YxHbP7tHVsNTyk5KyCZ4NFLdV+eta1MAQmX8m2ydVlATRUgv6um
	0slwv/wJC2BpgwRojhmBMbN7IbRCCMXzcT2204gZaIsFqYA3jXvUhuygI2kpr3oqPWWEZbKqM8L
	914C897ai+zOaYoi82lMDQEuLgY5da5vQhBLRGyUqBtcmVK0DfxAhpVAPvoWrYxQ9aVIni1I5aw
	YpBnNPwkr0ZBVCk8xtzQO5knye17wXVqluC2NUWw==
X-Received: by 2002:ac5:c746:0:b0:4ef:27dc:7a9 with SMTP id 71dfb90a1353d-4ef27dc165emr7021375e0c.0.1718966005107;
        Fri, 21 Jun 2024 03:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEroOFucFxJp5S4kPpu8S5zxwmPtlXQb6SZEkyfNe4xQpunSje9XX9jDpGw1TwL2Q1kDmZ1Psgj/1sqnwwH3ys=
X-Received: by 2002:ac5:c746:0:b0:4ef:27dc:7a9 with SMTP id
 71dfb90a1353d-4ef27dc165emr7021361e0c.0.1718966004649; Fri, 21 Jun 2024
 03:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Linden <rlinden@redhat.com>
Date: Fri, 21 Jun 2024 12:33:10 +0200
Message-ID: <CAP0H_AEd1jFNB_dO=HRjwEUKzFqnjntss_1wskKU6hE1VmBs+A@mail.gmail.com>
Subject: problem with parsing of patch files for patch-id
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000016c102061b63f645"

--00000000000016c102061b63f645
Content-Type: text/plain; charset="UTF-8"

Hello!

We noticed a problem with the parsing of a patch file for "git
patch-id". I understand that the patch file format is very difficult
and unpredictable and probably it's not even possible to correctly
parse all of them (mostly due to missing restrictions on or escaping
of commit messages).

But in our specific case it can be improved to handle it correctly.

I attached an example patch file. When feeding that to "git patch-id"
(with git version 2.45.2.561.g66ac6e4bcd) the output is:

068a8a30a5b0e55b93fdc16b2a7dcd6886e420f3
1111111111111111111111111111111111111111
818756276fff2c6075da8effe36c65d25e6ed592
dcc59dffa5116bf96618065cd60742cb660224b8
b033e3eca8a60741bb414689ddfe00a0c1a09de5
3333333333333333333333333333333333333333

But it should be:

068a8a30a5b0e55b93fdc16b2a7dcd6886e420f3
1111111111111111111111111111111111111111
818756276fff2c6075da8effe36c65d25e6ed592
2222222222222222222222222222222222222222
b033e3eca8a60741bb414689ddfe00a0c1a09de5
3333333333333333333333333333333333333333

The reason is that the commit message of the second patch contains
commit hashes which are parsed as if they were the commit hash for the
patch, and not just some message.

This patch (also attached) fixes it by only considering commit hashes
in a "From xxxxx..." line:

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 583099cacf..4b8a41bde8 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -86,7 +86,7 @@ static int get_one_patchid(struct object_id
*next_oid, struct object_id *result,
                        continue;
                }

-               if (!get_oid_hex(p, next_oid)) {
+               if (starts_with(p-5, "From ") && !get_oid_hex(p, next_oid)) {
                        found_next = 1;
                        break;
                }

But I'm not sure it is ok in all other cases [which are handled
correctly now, i.e. it only makes it better for cases like ours,
without making it worse for anything else). The unit-tests pass ok but
I didn't check how comprehensive they are.
Can somebody please have a look and tell me what they think about
patch file parsing?

Thanks & all the best,
rob

--00000000000016c102061b63f645
Content-Type: text/x-patch; charset="US-ASCII"; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxoisntl0>
X-Attachment-Id: f_lxoisntl0

RnJvbSAxMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExMTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBybGluZGVuQHJlZGhhdC5jb20KRGF0ZTogV2VkLCAyNCBKYW4g
MjAyNCAxNDo0OToyMSArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMS8zXSBmb28gZm9vCgpSZXNvbHZl
czogYnVnLTEyMwotLS0KIHRlc3QvdW5pdHMvdGVzdHN1aXRlLTA3Lm1haW4tUElELWNoYW5nZS5z
aCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90
ZXN0L3VuaXRzL3Rlc3RzdWl0ZS0wNy5tYWluLVBJRC1jaGFuZ2Uuc2ggYi90ZXN0L3VuaXRzL3Rl
c3RzdWl0ZS0wNy5tYWluLVBJRC1jaGFuZ2Uuc2gKaW5kZXggYmU0NjMxZjEwZC4uYmQ1YTYzYTI3
MiAxMDA3NTUKLS0tIGEvdGVzdC91bml0cy90ZXN0c3VpdGUtMDcubWFpbi1QSUQtY2hhbmdlLnNo
CisrKyBiL3Rlc3QvdW5pdHMvdGVzdHN1aXRlLTA3Lm1haW4tUElELWNoYW5nZS5zaApAQCAtMTUx
LDYgKzE1MSw4IEBAIHN5c3RlbWQtcnVuIC0tdW5pdD10ZXN0LW1haW5waWRzaDMuc2VydmljZSBc
CiAgICAgICAgICAgICAtcCBSdW50aW1lRGlyZWN0b3J5PW1haW5waWRzaDMgXAogICAgICAgICAg
ICAgLXAgUElERmlsZT0vcnVuL21haW5waWRzaDMvcGlkIFwKICAgICAgICAgICAgIC1wIER5bmFt
aWNVc2VyPTEgXAorICAgICAgICAgICAgYCMgTWFrZSBzYW5pdGl6ZXJzIGhhcHB5IHdoZW4gRHlu
YW1pY1VzZXI9MSBwdWxscyBpbiBpbnN0cnVtZW50ZWQgc3lzdGVtZCBOU1MgbW9kdWxlc2AgXAor
ICAgICAgICAgICAgLXAgRW52aXJvbm1lbnRGaWxlPS0vdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbWQt
YXNhbi1lbnYgXAogICAgICAgICAgICAgLXAgVGltZW91dFN0YXJ0U2VjPTJzIFwKICAgICAgICAg
ICAgIC9kZXYvc2htL3Rlc3QtbWFpbnBpZDMuc2ggXAogICAgICYmIHsgZWNobyAndW5leHBlY3Rl
ZCBzdWNjZXNzJzsgZXhpdCAxOyB9CgpGcm9tIDIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IHJsaW5kZW5AcmVkaGF0
LmNvbQpEYXRlOiBXZWQsIDI0IEphbiAyMDI0IDE1OjQ5OjIxICswMTAwClN1YmplY3Q6IFtQQVRD
SCAyLzNdIGJhciBiYXIKCndlIHNob3VsZCBub3QgbWVudGlvbiB0aGVzZSBvdGhlciBjb21taXRz
IGluIG91ciBjb21taXQgbWVzc2FnZSBsaWtlIHRoaXM6CjU1ZDMzN2RlMTk0MDA3Njg1NWMxNjg3
ZmZkNTg4NDk4ZDA2ODcyNGUKZGNjNTlkZmZhNTExNmJmOTY2MTgwNjVjZDYwNzQyY2I2NjAyMjRi
OAoKLS0tCiB0ZXN0L3VuaXRzL3Rlc3RzdWl0ZS0wNy5tYWluLVBJRC1jaGFuZ2Uuc2ggfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdC91bml0
cy90ZXN0c3VpdGUtMDcubWFpbi1QSUQtY2hhbmdlLnNoIGIvdGVzdC91bml0cy90ZXN0c3VpdGUt
MDcubWFpbi1QSUQtY2hhbmdlLnNoCmluZGV4IGJlNDYzMWYxMGQuLmJkNWE2M2EyNzIgMTAwNzU1
Ci0tLSBhL3Rlc3QvdW5pdHMvdGVzdHN1aXRlLTA3Lm1haW4tUElELWNoYW5nZS5zaAorKysgYi90
ZXN0L3VuaXRzL3Rlc3RzdWl0ZS0wNy5tYWluLVBJRC1jaGFuZ2Uuc2gKQEAgLTE1MSw2ICsxNTEs
OCBAQCBzeXN0ZW1kLXJ1biAtLXVuaXQ9dGVzdC1tYWlucGlkc2gzLnNlcnZpY2UgXAogICAgICAg
ICAgICAgLXAgUnVudGltZURpcmVjdG9yeT1tYWlucGlkc2gzIFwKICAgICAgICAgICAgIC1wIFBJ
REZpbGU9L3J1bi9tYWlucGlkc2gzL3BpZCBcCiAgICAgICAgICAgICAtcCBEeW5hbWljVXNlcj0x
IFwKKyAgICAgICAgICAgIGAjIE1ha2Ugc2FuaXRpemVycyBoYXBweSB3aGVuIER5bmFtaWNVc2Vy
PTEgcHVsbHMgaW4gaW5zdHJ1bWVudGVkIHN5c3RlbWQgTlNTIG1vZHVsZXNgIFwKKyAgICAgICAg
ICAgIC1wIEVudmlyb25tZW50RmlsZT0tL3Vzci9zaGFyZS9saWIvc3lzdGVtZC9zeXN0ZW1kLWFz
YW4tZW52IFwKICAgICAgICAgICAgIC1wIFRpbWVvdXRTdGFydFNlYz0ycyBcCiAgICAgICAgICAg
ICAvZGV2L3NobS90ZXN0LW1haW5waWQzLnNoIFwKICAgICAmJiB7IGVjaG8gJ3VuZXhwZWN0ZWQg
c3VjY2Vzcyc7IGV4aXQgMTsgfQoKRnJvbSAzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMz
MzMzMzMzMzMzIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBybGluZGVuQHJlZGhhdC5j
b20KRGF0ZTogV2VkLCAyNCBKYW4gMjAyNCAxNjo0OToyMSArMDEwMApTdWJqZWN0OiBbUEFUQ0gg
My8zXSBiYXogYmF6Cgp0aGF0J3MgaXQKLS0tCiB0ZXN0L3VuaXRzL3Rlc3RzdWl0ZS0wNy5tYWlu
LVBJRC1jaGFuZ2Uuc2ggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGVzdC91bml0cy90ZXN0c3VpdGUtMDcubWFpbi1QSUQtY2hhbmdlLnNoIGIv
dGVzdC91bml0cy90ZXN0c3VpdGUtMDcubWFpbi1QSUQtY2hhbmdlLnNoCmluZGV4IGJlNDYzMWYx
MGQuLmJkNWE2M2EyNzIgMTAwNzU1Ci0tLSBhL3Rlc3QvdW5pdHMvdGVzdHN1aXRlLTA3Lm1haW4t
UElELWNoYW5nZS5zaAorKysgYi90ZXN0L3VuaXRzL3Rlc3RzdWl0ZS0wNy5tYWluLVBJRC1jaGFu
Z2Uuc2gKQEAgLTE1MSw2ICsxNTEsOCBAQCBzeXN0ZW1kLXJ1biAtLXVuaXQ9dGVzdC1tYWlucGlk
c2gzLnNlcnZpY2UgXAogICAgICAgICAgICAgLXAgUnVudGltZURpcmVjdG9yeT1tYWlucGlkc2gz
IFwKICAgICAgICAgICAgIC1wIFBJREZpbGU9L3J1bi9tYWlucGlkc2gzL3BpZCBcCiAgICAgICAg
ICAgICAtcCBEeW5hbWljVXNlcj0xIFwKKyAgICAgICAgICAgIGAjIE1ha2Ugc2FuaXRpemVycyBo
YXBweSB3aGVuIER5bmFtaWNVc2VyPTEgcHVsbHMgaW4gaW5zdHJ1bWVudGVkIHN5c3RlbWQgTlNT
IG1vZHVsZXNgIFwKKyAgICAgICAgICAgIC1wIEVudmlyb25tZW50RmlsZT0tL3Vzci9sb2NhbC9s
aWIvc3lzdGVtZC9zeXN0ZW1kLWFzYW4tZW52IFwKICAgICAgICAgICAgIC1wIFRpbWVvdXRTdGFy
dFNlYz0ycyBcCiAgICAgICAgICAgICAvZGV2L3NobS90ZXN0LW1haW5waWQzLnNoIFwKICAgICAm
JiB7IGVjaG8gJ3VuZXhwZWN0ZWQgc3VjY2Vzcyc7IGV4aXQgMTsgfQo=
--00000000000016c102061b63f645
Content-Type: text/x-patch; charset="US-ASCII"; name="fix.patch"
Content-Disposition: attachment; filename="fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lxoitzci1>
X-Attachment-Id: f_lxoitzci1

ZGlmZiAtLWdpdCBhL2J1aWx0aW4vcGF0Y2gtaWQuYyBiL2J1aWx0aW4vcGF0Y2gtaWQuYwppbmRl
eCA1ODMwOTljYWNmLi40YjhhNDFiZGU4IDEwMDY0NAotLS0gYS9idWlsdGluL3BhdGNoLWlkLmMK
KysrIGIvYnVpbHRpbi9wYXRjaC1pZC5jCkBAIC04Niw3ICs4Niw3IEBAIHN0YXRpYyBpbnQgZ2V0
X29uZV9wYXRjaGlkKHN0cnVjdCBvYmplY3RfaWQgKm5leHRfb2lkLCBzdHJ1Y3Qgb2JqZWN0X2lk
ICpyZXN1bHQsCiAJCQljb250aW51ZTsKIAkJfQogCi0JCWlmICghZ2V0X29pZF9oZXgocCwgbmV4
dF9vaWQpKSB7CisJCWlmIChzdGFydHNfd2l0aChwLTUsICJGcm9tICIpICYmICFnZXRfb2lkX2hl
eChwLCBuZXh0X29pZCkpIHsKIAkJCWZvdW5kX25leHQgPSAxOwogCQkJYnJlYWs7CiAJCX0K
--00000000000016c102061b63f645--

