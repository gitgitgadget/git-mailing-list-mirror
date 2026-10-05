Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142C427F9C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195310; cv=none; b=oJ6aWucWyPmvhnF1ksPR8mK93A0ngo52QQK3EgPZP6qlVQmDwMU5CTltSF+i+2qoTjnEVrKXMdTp0v0byN9Lcpt2oitHgFDQRSwwLKNce81A80NQQzM7kyUOgSPMfSLgQ+Osv1oqFoOcvVN0BtF1CgQK4LDN0E+BjTwF2xxxP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195310; c=relaxed/simple;
	bh=lnlqGYjXOuPtXNNJoR6+3hVuxe9GSiQvkHsp5N/QjM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=grpW+oyzYMf4uSD6gqsW5i37M1U9pyz/zedfdHTZbJ35+hh9xqeTozfFnwLLPnKcyvRLOPEf5NZce8eVy/71ig6Fh/MBjTcuIwSWFJIWWKG7A8Tz/oDdj63JXeuNma8211Rkdjy7oIbBYaYCYq6nkguHDhyip6njBOuqazArwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bo2CZJPj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8VPATaW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bo2CZJPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8VPATaW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C315140011B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 06:15:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 06:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1791195307; x=1791281707; bh=41oAcC0WWS
	newQsiwlj7hX3F9DnVM5fBDa+ghD65CqY=; b=bo2CZJPjwdlwyg6hbIzeLwK0ww
	TpOJaAgsKObeYhnyiuoqI4j3Z0Y0ThJyYvTm9omRDEG7wZWzjMQVvpWZuyhINiEV
	KervJL6pvzPOMVdjEnM8d9uvqbnB6n5pQnceIkv7GnVf76Y1eabDdYc+QHLhrGQW
	qg/o7UcBaSN4UMHOiRZTMSqnmdGfd/np+0iBNt2JLW0rUavt8BlfKOCw7FHWOhqP
	4K/n1y/iuuwoqvtU/Ik2TYt8+M/MmkrXYSop5w0PyikNmH3yC2JnrcowJ6kmq/iL
	5k8tQ2aGOD/7mHgjhNSjNUyb4BMRrLF6IVxl38Rfr19jao9hq2LGtxWd5tMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791195307; x=1791281707; bh=41oAcC0WWSnewQsiwlj7hX3F9DnV
	M5fBDa+ghD65CqY=; b=B8VPATaWYeiJmwYwJA1+aAwE8UcuQBWpJoiRdtHEjFnA
	aKHY3/rXXY510+L2H3beOh3seKyNDPZbfHxW+6Ys2eCSCML2bW7a0zKTKJuzrGon
	PV9f88VHBV6J7p6Giq+0GjVNb3yZfzCSdsmJvdlA9VZH4uUaPrLmnoiK2ym/T4ks
	JAdISJWelvwd/GaScHx0G1uJOMXs8Qc0edzCUfepY5VmkYB4gQNiRAiAqiRqO4ul
	7CiwjjgaDBPM/xZW0OEGGeEtmBj7OqHvTJxpyWER7m8lyOjTa1YOF/Wz4uHISt3o
	Uptr177P9Z9YztfWsSvHFWMjhTKc1V9lPzTa5Ih9cg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791195307; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Gageu3/9OR3dy8OdQ9/C4Apb+qA6YaBfzyDJFL8NPCTQRNw
	+vH5FfZ8nO8u6jQ7bJm1GL0WUiEKjasO7h/DfObUmbufoU7kxH5/lYz7gZMJAv42
	7NEEICPhKf7pXV8M+auo60MkyAHRHyj4xR3jpoD3UFvPkK7iQlWfTZbOcB32OnJI
	xNoS6TLO3B9kQ7gzio8erGnAPRdFzCe+X8z/cnlAdO2Q4yDBNcb+qQVIskW7JyQp
	P7L8pl2osQ0CxMD1r6QrMT/GFZGSTbS0pxf7QHN/MpCMLuT2liYlYkTuYgStVHa1
	t/TKQKF5BWDYDnu53QJWOSLEncntjWCTfxsGw3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:j7Oltyp40D/yoB+sRGpH0fQlPTY8wvnNzd5kULbD3rI=:lnlqGYjXOuPtXNNJoR6+3hVuxe9GSiQvkHsp5N/QjM0=;
X-ME-Sender: <xms:q3jDauAJMl7drFzF7m2ofSaigPSb4StlIfeenYfEiaOAGYNaffDv5w>
    <xme:q3jDaveITRHkBxmrBUizvAumbDmcGK-vitTdJZscVFOMt8Em7wspTYERVv16Z7RfT
    0RJejSMgLN329ktNME1WCxjkuB1S8N077mcvP_sBL7Hqxf4MBAcfn0>
X-ME-Received: <xmr:q3jDanOm5_hK75tf24o_OknSSBX1Tx3kiLkDy3ZTDyjOG3IRrR7WaUiugNusKX3MYKRCPCI>
X-ME-Proxy-Cause: dmFkZTGV6h+JwN73AWDhXfwNKVAodKXx+x4EhGyy6+H77uKY6fLGD9MwKa4IqNEbSC9CKB
    0NW09x/rhIJlpl6TfvCzILQpHuqlpizbhdEIrGVGlDh8kkiq8sp11NaJoVsyWd/E1UgC6H
    KQL1Eehg4+U9A8k7vhfqUEVF1jeEFNmjOxgFtC8zmWqInRSro2igvn3OJy1KRtQQoDraln
    ufmxaIZ/dX3+WirjcBwP3vJ+I/SowKX9REpNjeeVif48zv1ZL5K2CAj5/r0IgcIIjQf5ia
    iUEhBhpTQ6nuwg0xr4U9Zl+wEuLnfgLnP+HQq00qw/zCXWVUnSQWybtVkvayBh94W2qCcV
    z7+CmP1phoZSXR7uZOWSPsLZ9AarP3Ga9NbbVbgVCgncHUy5KDEzNL9o51+LaziwHbgiE4
    b/nLvlYFwwVB6TQRJeQOhYhxB4YC11krd12AKY6Ay1wctlgZ8mE+hcwOaJmu32WiL+/dcp
    M3s0jfVsBzucv5SLIwU+7utNxQCBt692eJWa6xVXMEZSRLqMkptP5hXDiffa2a3ITrHiH+
    uGSL7tJp4OfeRmWtiextUUqExIFMUkeSoSYoV+4ZJsk1ZaXDEZjwUHT3ZGgtgSHQv0gFRp
    ZDJPmCdibkuAm7D0wFl2fHJKhpewNFUoieVxgzK3AqeODzpvKJg7UNdZojow
X-ME-Proxy: <xmx:q3jDah6ypq7k7AEqe3NFQGkF4-hpAokuc1RIbwuKTIdCsoytcKeFFA>
    <xmx:q3jDajLAzflaRNgTgjuCNKyCIRKsqAjgwZZs6tX40Z41icNuiU8ooA>
    <xmx:q3jDajeuCoMLBGuEryGuIESnIRgkhrHG_Pi2BYi2GkuMpeJ8qgLpEA>
    <xmx:q3jDauegxL9VXhTULgANhRdvztso58GVk4uof95xNamxd7KexMRYiQ>
    <xmx:q3jDahDFQ_2aF0dVO2A3nZ7oohWlBs6LylBxwd1R7pGbqY2aizNPe1Pq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 5 Oct 2026 06:15:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48a28cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 5 Oct 2026 10:15:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Oct 2026 12:14:55 +0200
Subject: [PATCH] builtin/repo: rename "references.format" to
 "references.storageFormat"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2UBXqHP+ivhQazaz4VqSToSxf
 zfqy8HBcRsoCZPCudlA6MXKeTFpDw2kR1xGQr6bg3f+2DoXsMyKQiUbBtSaJVozZHnGij1Fn0L
 wp75zYIdiDb9/98v177reJkr1u4R9/wBwuyEbfwAAAA==
X-Change-ID: 20261005-pks-repo-ref-storage-format-9ea2c5528970
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

As part of 2f28db44d5 (Merge branch 'ps/ref-storage-format', 2026-10-01)
we have adapt all sites that used to say "reference format" to instead
say "reference storage format".

One missed spot though was in git-repo(1), where we still print the
"references.format" key. Fix that oversight by renaming the key to
"references.storageFormat".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this is a follow-up on 2f28db44d5 (Merge branch 'ps/ref-storage-format',
2026-10-01), where I missed this one place. I noticed that only today
while working on the object storage format extension.

Thanks!

Patrick
---
 Documentation/git-repo.adoc |  6 +++---
 builtin/repo.c              |  2 +-
 t/t1900-repo-info.sh        | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ed7d80c690..5af454e8ca 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -119,7 +119,7 @@ values that they return:
 `path.gitdir.relative`::
 	The path to the Git repository directory relative to the current working directory.
 
-`references.format`::
+`references.storageFormat`::
 	The reference storage format. The valid values are:
 +
 include::ref-storage-format.adoc[]
@@ -127,10 +127,10 @@ include::ref-storage-format.adoc[]
 EXAMPLES
 --------
 
-* Retrieves the reference format of the current repository:
+* Retrieves the reference storage format of the current repository:
 +
 ------------
-git repo info references.format
+git repo info references.storageFormat
 ------------
 +
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f83f..15267e8d54 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -137,7 +137,7 @@ static const struct repo_info_field repo_info_field[] = {
 	{ "path.commondir.relative", get_path_commondir_relative },
 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
 	{ "path.gitdir.relative", get_path_gitdir_relative },
-	{ "references.format", get_references_format },
+	{ "references.storageFormat", get_references_format },
 };
 
 static int repo_info_field_cmp(const void *va, const void *vb)
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index d115d2d9f9..ee84f33229 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -39,10 +39,10 @@ test_repo_info () {
 }
 
 test_repo_info 'ref format files is retrieved correctly' \
-	'git init --ref-storage-format=files' 'format-files' 'references.format' 'files'
+	'git init --ref-storage-format=files' 'format-files' 'references.storageFormat' 'files'
 
 test_repo_info 'ref format reftable is retrieved correctly' \
-	'git init --ref-storage-format=reftable' 'format-reftable' 'references.format' 'reftable'
+	'git init --ref-storage-format=reftable' 'format-reftable' 'references.storageFormat' 'reftable'
 
 test_repo_info 'bare repository = false is retrieved correctly' \
 	'git init' 'nonbare' 'layout.bare' 'false'
@@ -72,11 +72,11 @@ test_repo_info 'object.format = sha256 is retrieved correctly' \
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-	references.format=files
+	references.storageFormat=files
 	layout.bare=false
 	EOF
 	git init --ref-storage-format=files ordered &&
-	git -C ordered repo info layout.bare references.format layout.bare >actual &&
+	git -C ordered repo info layout.bare references.storageFormat layout.bare >actual &&
 	test_cmp expect actual
 '
 
@@ -87,8 +87,8 @@ test_expect_success 'git-repo-info fails if an invalid key is requested' '
 '
 
 test_expect_success 'git-repo-info outputs data even if there is an invalid field' '
-	echo "references.format=$(test_detect_ref_format)" >expect &&
-	test_must_fail git repo info foo references.format bar >actual &&
+	echo "references.storageFormat=$(test_detect_ref_format)" >expect &&
+	test_must_fail git repo info foo references.storageFormat bar >actual &&
 	test_cmp expect actual
 '
 

---
base-commit: 8103b446517e0c44e67561b9d0ccce56efa60a71
change-id: 20261005-pks-repo-ref-storage-format-9ea2c5528970

