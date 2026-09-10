Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545335C68C
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022759; cv=pass; b=UGDZAmum7pxbDZU4s+gVQ7+X0QpLUs+te9OSvc+7mVFITKSQihsQK34ysoWlXJ6thwpEFFQ2YLX+YTYvdbOt0bl1757jGspM4bga++UYhmdtPwGMo+nHVRTUXpTJItkgjZk5cB5DppURoBOjm2enX3/bOqlW4pAQ2N0RH2YJmGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022759; c=relaxed/simple;
	bh=L8UF+Q5Pzm23YH6h6OhDQiknUqPuF6sFvhwPclhlb/E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YoAp5mtCfF8XGpTP761YvqzKmmmL0U4vO/s+PNl4hZ0SjBSSQuZxgDtY86JigserGrdhhUQtwT8sS2Uiuc126OaiH05HYbTyWZoWHohrxxYYv8h9oZllAsNVDuuiukm8Kln1xm6Gt6qS8QsXMiHEoBA4CkrxmDI/JUYVuXT1Bds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g57liJ97; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g57liJ97"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-671061b015eso2083618d50.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789022757; cv=none;
        d=google.com; s=arc-20260327;
        b=XLhFSNsMFZWG2ehS1lG2+3F02Q0VFn9URKZeyB4HEmpUxv1MWVGM0G0YUnSJwpCbG1
         NLuV5N43kaqqR3VgPb4bEn7IBtVaOT7EURP3ac5LnIXuOXpXTtmri+S5m5J8HK/vB0aq
         clzIQVpTTxYKdZIAXbLKxCaYe7k6h8Duk0KWL3ryfYvO7OXSIuD0t4Q+EwGKSh0ZNxBq
         WoXWdrSzL8VjCY23PBIFfaqZEzkVc7+fLdgIeo2Fi3hbGdEqnSVj1Hh+ecgb8vY/2saq
         LhS3emXQw2YsBHtqljSvPtkqEJUDcBBeUbXyJwt8QTPzqT0diXg9HAODEo3Zg5+/BMNi
         cCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eSuUKyIS6kqFCfeKuFXN5meqkfZmge8bsFE3DKPZbt4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=VFhEbUWLFinFXe/ninwBpxf8+xCXVvN5d5DfJJkMDTw9+tVEQD9VkFk1J+9GFNGouu
         oO0evkBa1mdt3VxQ3BVz3aGFZX1scZMvRv5EhaAFC3OZ9Fan6pBN13sU7WeTZWDH0GwF
         p5MZSPRxojcWH5c72yPwO3O4zbQ2pTeQmT0NeeP4DhPr8jequLDXkFnzUOe6zRjdJYLR
         t8H58j8qjrRTbhaHQVcYbIQLuQ5i2t64/mfpOICnVQQoKhJPjvr9p13H3ctozEu6xbpD
         H4Zb8tONQPaiw25Wu0n+ASW84zQ9iMN+xuucz5is9sE4OLAqhydSmsHhjhVjFipG04nF
         YKpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022757; x=1789627557; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eSuUKyIS6kqFCfeKuFXN5meqkfZmge8bsFE3DKPZbt4=;
        b=g57liJ97MMaC4e67t1LxjPRj/6CunvWbZl4hQ0cC0TexuC+q+/F7ROOJq7ha7waqw/
         2tbUhKWse+4kEP6Ou2wrjrapR9I6kfGZjdvx8jjuYtiYplsaqqpfOTkx7Or1M7Yzl/fL
         JIHT/dZ7hzzp8XTBcM1Z8mcOzrD6PUekzRhJZxqN8KTk6ZRIGi74CXIUwpJPvCuWlYmX
         6i40lhghDx6+1zh4NPYhIK/Cvlmocib2CB4Pq05zFI/FMa3oEjVPYDWYNyK6u+7OJczR
         fotnQmE6TDM3G25+iN+6RfIYqSGo/X4skYSp8zj/4r518FSNCChABww1+LFN8pWl9hy+
         Qwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022757; x=1789627557;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eSuUKyIS6kqFCfeKuFXN5meqkfZmge8bsFE3DKPZbt4=;
        b=GUvgNGL0CIPoKRXTfZt0PSPr9puR0Ih+nVSrZpHD6H0fJ/nrHctTiDilUuu03zQ1Kx
         rs/DapKBq4bYvCJO6iE5fVrxjR92Mqx8UVTopQjhhgoXgpj10Pf3KwXIeR39RoHmplnj
         rfXyWqmVrb48Z9VKhRTYLXazANqvhV0VvDtByhdEwMZpEtbizWJ5fdpB8jrJ9qsRFdgN
         NrLTubYPzD8hbtybD8kwMjYprVwFQqlPxVA1TaCcP5QpEig0RcjSawMa46CZ2oKsyNpY
         dtbeaLVnR4qdDGGNmRruB0toBHYWQpI7u+jtWlTjawqtR8nhthn3aOcVr5iG5cs1NQKg
         Owgw==
X-Gm-Message-State: AFuF++mQOP75tDvHJQdSxCslRGzYKtk9uI903k77jI0wGtgRS/nl8iw4
	FRKJb5IRXZMhIztBMkfRh5qeecTjkihMAE+MC5u2y4jBco+rPZMlsHzCUtnHTfzzYWFe7bpaD+D
	qG/ZTdvT82U6B7um3+iMNnA2/+PqhYrdL1U/e
X-Gm-Gg: AYBFou1FVUO5yOho3CAn0EqHLIAwDGFKTJyNB7mEbLE/UfvFP8o7molegCzSxnsWcxo
	7MJG3ysC6QpvrJahDJARNM2BBid7eBplV+2cV77/0iX1KeseZiNJr8bchbkgKgGmZzDXsvHVF+3
	UOGvMDyi2mr/HhpiqKqprl22HdyZx8QXjvS1OMJvaMV+6HHTL9+Jh/rnkPbj2PGZfLdw4Qz+KcD
	Ovr3B7le4SpirW5Y3iMsFY6ncpMYBUnxx8Y6RZyGYkHypaIVg99UFZcUNwRntIW/BWIsJdjoNbN
	7tsksh7ZOH8MOq0S39JyNjH080VUsdk+LiUsbVlTjS66kzzc3OJSA5clvFfpuZd/7RP8SZti8Ro
	YcsyVQGT8dec+ppTNeb2jyGnPh4jYtTOkfuxD
X-Received: by 2002:a53:c802:0:b0:66f:c1bc:c070 with SMTP id
 956f58d0204a3-66fc1bccbf5mr8288318d50.56.1789022756972; Wed, 09 Sep 2026
 23:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ariel Keselman <skariel@gmail.com>
Date: Wed, 9 Sep 2026 23:45:46 -0700
X-Gm-Features: AcwNN1WAtTV2TNdwPExg1J-jmgPzDTUjNMlfoQHzcMdKzmLJAgteL-T7BuC9qhs
Message-ID: <CAMuXvLD_ZsT8Jnfs_x6yO_aW6hrxQyjnuES_b21cq8a7nD=sKg@mail.gmail.com>
Subject: [PATCH] refs/files: avoid packed-refs lock for root ref deletion
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ece3c0065b1b51ac"

--000000000000ece3c0065b1b51ac
Content-Type: text/plain; charset="UTF-8"

Hi,

Deleting root refs in the files backend unnecessarily locks
packed-refs, even though root refs cannot be packed. This can cause
post-commit cleanup to report an error after a successful commit in a
linked worktree with read-only shared metadata.

The attached patch skips that lock for root-ref deletion and adds
regression tests. All seven new tests fail without the fix and pass
with it; broader ref, worktree, and sequencer tests also pass.

AI assistance was used to generate the patch, tests, and commit message.

Thanks,
Ariel

--000000000000ece3c0065b1b51ac
Content-Type: text/x-patch; charset="US-ASCII"; name="root-ref-packed-lock-review.patch"
Content-Disposition: attachment; 
	filename="root-ref-packed-lock-review.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtv5w3nj0>
X-Attachment-Id: f_mtv5w3nj0

RnJvbSBjNWQxMmU5N2E3ODEyMzk2NTU5MDU1M2ZkZGMwZGQ3OGFmM2UwMDZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBcmllbCBLZXNlbG1hbiA8c2thcmllbEBnbWFpbC5jb20+CkRh
dGU6IFdlZCwgOSBTZXAgMjAyNiAyMjoxNjo1MCAtMDcwMApUbzogZ2l0QHZnZXIua2VybmVsLm9y
ZwpTdWJqZWN0OiBbUEFUQ0hdIHJlZnMvZmlsZXM6IGF2b2lkIHBhY2tlZC1yZWZzIGxvY2sgZm9y
IHJvb3QgcmVmIGRlbGV0aW9uCgpEZWxldGluZyBhIHJvb3QgcmVmIHF1ZXVlcyBhIHBhY2tlZC1y
ZWYgdHJhbnNhY3Rpb24gaW4gdGhlIGZpbGVzCmJhY2tlbmQsIGV2ZW4gdGhvdWdoIHJvb3QgcmVm
cyBjYW5ub3QgYmUgcGFja2VkLiBGb3IgZXhhbXBsZSwgaG9sZGluZwouZ2l0L3BhY2tlZC1yZWZz
LmxvY2sgbWFrZXMgImdpdCB1cGRhdGUtcmVmIC0tbm8tZGVyZWYgLWQgQVVUT19NRVJHRSIKZmFp
bCwgd2hldGhlciBvciBub3QgQVVUT19NRVJHRSBleGlzdHMuCgpUaGlzIGFsc28gYWZmZWN0cyBw
b3N0LWNvbW1pdCBjbGVhbnVwLCB3aGljaCBkZWxldGVzIEFVVE9fTUVSR0UgYWZ0ZXIKdXBkYXRp
bmcgSEVBRC4gSW4gYSBsaW5rZWQgd29ya3RyZWUgd2l0aCByZWFkLW9ubHkgc2hhcmVkIG1ldGFk
YXRhLApjb21taXQgc3VjY2VlZHMgYnV0IGNsZWFudXAgcmVwb3J0cyBhIHBhY2tlZC1yZWZzLmxv
Y2sgZXJyb3IuIERlbGV0aW5nCkNIRVJSWV9QSUNLX0hFQUQgYW5kIFJFVkVSVF9IRUFEIGlzIGFm
ZmVjdGVkIGFzIHdlbGwuCgpTa2lwIHRoZSBwYWNrZWQgdHJhbnNhY3Rpb24gZm9yIHJvb3QtcmVm
IGRlbGV0aW9ucy4gS2VlcCBsb29zZS1yZWYKbG9ja2luZyBhbmQgcGFja2VkLXJlZiBkZWxldGlv
biBmb3Igb3RoZXIgcmVmcyB1bmNoYW5nZWQuCgpUZXN0IGV4aXN0aW5nIGFuZCBhYnNlbnQgcm9v
dCByZWZzIHdpdGggcGFja2VkLXJlZnMubG9jayBoZWxkLiBBbHNvCmNoZWNrIHRoYXQgcm9vdC1y
ZWYgZGVsZXRpb24gbGVhdmVzIHBhY2tlZCByZWZzIGludGFjdCwgYW5kIHRoYXQgYQpwYWNrZWQg
YnJhbmNoIHN0aWxsIHJlcXVpcmVzIHRoZSBsb2NrIGFuZCBjYW4gYmUgZGVsZXRlZCBvbmNlIGl0
IGlzCnJlbGVhc2VkLgoKU2lnbmVkLW9mZi1ieTogQXJpZWwgS2VzZWxtYW4gPHNrYXJpZWxAZ21h
aWwuY29tPgotLS0KQUkgYXNzaXN0YW5jZSB3YXMgdXNlZCB0byBnZW5lcmF0ZSB0aGUgcGF0Y2gs
IHRlc3RzLCBhbmQgY29tbWl0IG1lc3NhZ2UuCgpCYXNlZCBvbiBtYWludCBhdCBlOTAxOWZjYWZl
IChHaXQgMi41NSkuCgpWYWxpZGF0aW9uOgotIEFsbCBzZXZlbiBuZXcgdGVzdHMgZmFpbCB3aXRo
IHBhY2tlZC1yZWZzLmxvY2sgZXJyb3JzIHdpdGhvdXQgdGhlIGZpeC4KLSBXaXRoIHRoZSBmaXgs
IHQwNjAwIGFuZCB0MDYwMSBwYXNzIChvbmUgcGxhdGZvcm0gc2tpcCBpbiB0MDYwMCkuCi0gQnJv
YWRlciByZWYsIHdvcmt0cmVlLCByZWJhc2UsIGNoZXJyeS1waWNrLCBjb21taXQgYW5kIG1lcmdl
IHRlc3RzIHBhc3M6CiAgMTIzIHNjcmlwdHMsIDQwODMgdGVzdHMgb24gdGhlIG1haW50LWJhc2Vk
IHRyZWUuCi0gQWZ0ZXIgbWVyZ2luZyB3aXRoIG1hc3RlciBhdCBiODI0MmIwOTNkLCAxMjggc2Ny
aXB0cyAvIDQxNzggdGVzdHMgYW5kCiAgMjYwIHVuaXQgdGVzdHMgcGFzcy4KCiByZWZzL2ZpbGVz
LWJhY2tlbmQuYyAgICAgICAgfCAgOSArKysrKy0tLQogdC90MDYwMC1yZWZmaWxlcy1iYWNrZW5k
LnNoIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBj
aGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Jl
ZnMvZmlsZXMtYmFja2VuZC5jIGIvcmVmcy9maWxlcy1iYWNrZW5kLmMKaW5kZXggYTRjNzg1ODc4
Ny4uNDE4ODdmMTgwZiAxMDA2NDQKLS0tIGEvcmVmcy9maWxlcy1iYWNrZW5kLmMKKysrIGIvcmVm
cy9maWxlcy1iYWNrZW5kLmMKQEAgLTI5ODEsMTAgKzI5ODEsMTMgQEAgc3RhdGljIGludCBmaWxl
c190cmFuc2FjdGlvbl9wcmVwYXJlKHN0cnVjdCByZWZfc3RvcmUgKnJlZl9zdG9yZSwKIAogCQlp
ZiAodXBkYXRlLT5mbGFncyAmIFJFRl9ERUxFVElORyAmJgogCQkgICAgISh1cGRhdGUtPmZsYWdz
ICYgUkVGX0xPR19PTkxZKSAmJgotCQkgICAgISh1cGRhdGUtPmZsYWdzICYgUkVGX0lTX1BSVU5J
TkcpKSB7CisJCSAgICAhKHVwZGF0ZS0+ZmxhZ3MgJiBSRUZfSVNfUFJVTklORykgJiYKKwkJICAg
ICFpc19yb290X3JlZih1cGRhdGUtPnJlZm5hbWUpKSB7CiAJCQkvKgotCQkJICogVGhpcyByZWZl
cmVuY2UgaGFzIHRvIGJlIGRlbGV0ZWQgZnJvbQotCQkJICogcGFja2VkLXJlZnMgaWYgaXQgZXhp
c3RzIHRoZXJlLgorCQkJICogUm9vdCByZWZzIGNhbm5vdCBiZSBwYWNrZWQuIERvIG5vdCBhY3F1
aXJlIHRoZSBzaGFyZWQKKwkJCSAqIHBhY2tlZC1yZWZzIGxvY2sgd2hlbiBkZWxldGluZyBhIHBl
ci13b3JrdHJlZSByb290IHJlZi4KKwkJCSAqIE90aGVyIHJlZmVyZW5jZXMgaGF2ZSB0byBiZSBk
ZWxldGVkIGZyb20KKwkJCSAqIHBhY2tlZC1yZWZzIGlmIHRoZXkgZXhpc3QgdGhlcmUuCiAJCQkg
Ki8KIAkJCWlmICghcGFja2VkX3RyYW5zYWN0aW9uKSB7CiAJCQkJcGFja2VkX3RyYW5zYWN0aW9u
ID0gcmVmX3N0b3JlX3RyYW5zYWN0aW9uX2JlZ2luKApkaWZmIC0tZ2l0IGEvdC90MDYwMC1yZWZm
aWxlcy1iYWNrZW5kLnNoIGIvdC90MDYwMC1yZWZmaWxlcy1iYWNrZW5kLnNoCmluZGV4IDc0YmZh
MmU5YmEuLmI3ZjMyODc4NDEgMTAwNzU1Ci0tLSBhL3QvdDA2MDAtcmVmZmlsZXMtYmFja2VuZC5z
aAorKysgYi90L3QwNjAwLXJlZmZpbGVzLWJhY2tlbmQuc2gKQEAgLTUxOSw0ICs1MTksNTAgQEAg
dGVzdF9leHBlY3Rfc3VjY2VzcyAnc3ltcmVmIHRyYW5zYWN0aW9uIHN1cHBvcnRzIGZhbHNlIHN5
bWxpbmsgY29uZmlnJyAnCiAJdGVzdF9jbXAgZXhwZWN0IGFjdHVhbAogJwogCitmb3IgcmVmIGlu
IEFVVE9fTUVSR0UgQ0hFUlJZX1BJQ0tfSEVBRCBSRVZFUlRfSEVBRAorZG8KKwlmb3Igc3RhdGUg
aW4gZXhpc3RpbmcgbWlzc2luZworCWRvCisJCXRlc3RfZXhwZWN0X3N1Y2Nlc3MgImRlbGV0aW5n
ICRzdGF0ZSAkcmVmIGRvZXMgbm90IGxvY2sgcGFja2VkLXJlZnMiICcKKwkJCXRlc3Rfd2hlbl9m
aW5pc2hlZCAicm0gLXJmIHJvb3QtcmVmIiAmJgorCQkJZ2l0IGluaXQgcm9vdC1yZWYgJiYKKwkJ
CSgKKwkJCQljZCByb290LXJlZiAmJgorCQkJCXRlc3RfY29tbWl0IGluaXRpYWwgJiYKKwkJCQlp
ZiB0ZXN0ICIkc3RhdGUiID0gZXhpc3RpbmcKKwkJCQl0aGVuCisJCQkJCWdpdCB1cGRhdGUtcmVm
ICIkcmVmIiBIRUFECisJCQkJZmkgJiYKKwkJCQk6ID4uZ2l0L3BhY2tlZC1yZWZzLmxvY2sgJiYK
KwkJCQlnaXQgLWMgY29yZS5wYWNrZWRSZWZzVGltZW91dD0wIHVwZGF0ZS1yZWYgLS1uby1kZXJl
ZiAtZCAiJHJlZiIgJiYKKwkJCQl0ZXN0X3BhdGhfaXNfbWlzc2luZyAiLmdpdC8kcmVmIiAmJgor
CQkJCXRlc3RfcGF0aF9pc19maWxlIC5naXQvcGFja2VkLXJlZnMubG9jaworCQkJKQorCQknCisJ
ZG9uZQorZG9uZQorCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdyb290IHJlZiBkZWxldGlvbiBwcmVz
ZXJ2ZXMgcGFja2VkIHJlZnMgYW5kIHRoZWlyIGxvY2tpbmcnICcKKwl0ZXN0X3doZW5fZmluaXNo
ZWQgInJtIC1yZiByb290LXJlZiIgJiYKKwlnaXQgaW5pdCByb290LXJlZiAmJgorCSgKKwkJY2Qg
cm9vdC1yZWYgJiYKKwkJdGVzdF9jb21taXQgaW5pdGlhbCAmJgorCQlnaXQgdXBkYXRlLXJlZiBy
ZWZzL2hlYWRzL3BhY2tlZC1icmFuY2ggSEVBRCAmJgorCQlnaXQgcGFjay1yZWZzIC0tYWxsICYm
CisJCXRlc3RfcGF0aF9pc19taXNzaW5nIC5naXQvcmVmcy9oZWFkcy9wYWNrZWQtYnJhbmNoICYm
CisJCWNwIC5naXQvcGFja2VkLXJlZnMgZXhwZWN0ICYmCisJCWdpdCB1cGRhdGUtcmVmIEFVVE9f
TUVSR0UgSEVBRCAmJgorCQk6ID4uZ2l0L3BhY2tlZC1yZWZzLmxvY2sgJiYKKwkJZ2l0IC1jIGNv
cmUucGFja2VkUmVmc1RpbWVvdXQ9MCB1cGRhdGUtcmVmIC0tbm8tZGVyZWYgLWQgQVVUT19NRVJH
RSAmJgorCQl0ZXN0X2NtcCBleHBlY3QgLmdpdC9wYWNrZWQtcmVmcyAmJgorCQl0ZXN0X211c3Rf
ZmFpbCBnaXQgLWMgY29yZS5wYWNrZWRSZWZzVGltZW91dD0wIHVwZGF0ZS1yZWYgLWQgcmVmcy9o
ZWFkcy9wYWNrZWQtYnJhbmNoIDI+ZXJyICYmCisJCXRlc3RfZ3JlcCAiVW5hYmxlIHRvIGNyZWF0
ZSAuKnBhY2tlZC1yZWZzLmxvY2siIGVyciAmJgorCQl0ZXN0X2NtcCBleHBlY3QgLmdpdC9wYWNr
ZWQtcmVmcyAmJgorCQlybSAuZ2l0L3BhY2tlZC1yZWZzLmxvY2sgJiYKKwkJZ2l0IHVwZGF0ZS1y
ZWYgLWQgcmVmcy9oZWFkcy9wYWNrZWQtYnJhbmNoICYmCisJCXRlc3RfbXVzdF9mYWlsIGdpdCBy
ZXYtcGFyc2UgLS12ZXJpZnkgcmVmcy9oZWFkcy9wYWNrZWQtYnJhbmNoCisJKQorJworCiB0ZXN0
X2RvbmUKLS0gCjIuNTUuMAoK
--000000000000ece3c0065b1b51ac--
