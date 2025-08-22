Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88331A9F90
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876065; cv=none; b=tXksmMlN4EjzQd/uoBJNE9xUSWXijZk3lHH2Z6tJ1iiPO1ISXmiuJ/OYLWO5G0eOwVhNIsAUzZV99OtMiac/pLjdj6evOIPjvCeIUFIXqi6q74ZN68kwQKhCfkFVvzVANVo895dvuv0x9fJ9c/2QeOrR97O6YGoeXvOC9RnDuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876065; c=relaxed/simple;
	bh=ZwGjw3Zd8ojTY1kef0l9cjKO2YOvLokMq24J0oM84+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOmD+A+VpSX6xk0xGL2kfUXI2u6SBLtdlvztap2oCKJCQoo8+XPEdJEvD3CQbqSpMCCn/DEvjWJS0Q5rO/hPW/dDOcWdzwOGf08TjRQg7GWm2AKEnscEHNS7ewy3JuvBWqPUVXkx2r1vPkMjOOeKCNSoZq+Ru3U9l+LqFJaSc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=I/cR2mV4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=izXNvhWd; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="I/cR2mV4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="izXNvhWd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AECF8EC083C;
	Fri, 22 Aug 2025 11:21:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 22 Aug 2025 11:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1755876061; x=1755962461; bh=ga
	PBiE8M9et8JuqOyd9p5gTqxa6eFzKfiyGiECkey/U=; b=I/cR2mV4ahno8RYyZe
	/IUSj4tP760j2ZdDigkVZNWZxGX2OqN1AR7KDjv9PcHesmWte0SvgJctdHNNUuj8
	/7ArnI9eHAzc03EsRk9DCS4IPOg4yD5vn4wYoFuSRwlcpvTDoaOk5zBFMiRizRO/
	jM0VHZmH6QyIQmvDLEb3zaY/mX9JH/OVWWCUrneUpq2GA0X2zBYinXc3ebv/kfbu
	bLuMGcb4EcPD7HpIDC19W2Jj1YQRDFLKcc/R6jPxO4j+qNCd6kJ47yjpFM6OmIFh
	CvMFlzlVTXVwTgfbZ9pO94sONpdB2CwbSnnuXFJKHNaBXjwUPUTFHd/bsotSVNTq
	eAoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755876061; x=1755962461; bh=gaPBiE8M9et8JuqOyd9p5gTqxa6e
	FzKfiyGiECkey/U=; b=izXNvhWd1E7JueQMa6CJUaW00Kb+M+nNUlyzUp9FctFW
	NSl291Sg1ggKz2TB6jWH/SXuAF+ap0hZK8WgEX6qz/hZXz+xvI7xjBDdJruTL2WT
	xTc/8z4l73/ryrI0n9BtxqJq4B3DhwxyRIPyN8fHe6J/FQLvlrVfeBfE0iQuYgsL
	V3X0Wuy1Dvte4+PUS+ccU8wzExPotYy+mjVBEXmHFvo21MJhcco/GWdDuEtUJBP4
	BP3OkxL2e8i1+ZNU++i3nJ4mPpgUHsDN5N7yNKYIvA6SyGcf5P9V/9UGu0zC0ziz
	tA6B2DmOL4kvsRZxHEZ25C0A3lsejhEMb3XLqdnLdQ==
X-ME-Sender: <xms:3YqoaMKpPhvQgX_BCGTVDK_9aypUUVUelWAded3i0b1olg30T3dRv5E>
    <xme:3YqoaMWJU9U7RIUhjRXkLiIgjGD0UfOq9BvNlHH9z6ff93jvTGUeTHRWhIKFHkZkd
    20iJqvB-PHNdkBocA>
X-ME-Received: <xmr:3YqoaOjvzuFAKntFO8ZNqVrUOTdgNRGayCaFqu-1g1PY8ZEAdrrXSXFmjXQunxFK2gn-ZJdrvo4Z7s-WfnlRTK3NMwZfD4z1XGx4B8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegff
    eujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:3YqoaH8TTVTRWmF0wvhPyUjHO1AcV1Z9SR1TvV16hEU8tZvE2ffczQ>
    <xmx:3YqoaIBSAd1_id2umVecjatow6ALLlFu6rOMLicxXGpBMo9v84pDEg>
    <xmx:3YqoaELTQzM7pnRasRcMoQyQzPmBtHJKGE-YOucJlvapqPjjAA5Rxw>
    <xmx:3YqoaLk2WHKoKo7CdarJA16mfSetHOFP7eWvUA7fnLdNDTIq-Ip_OA>
    <xmx:3YqoaGuuIeonx8qW4FiEZtBpwvBEpPqsonCH4QLvxhN5KwkDNEc6k2wO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 11:21:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: interpret-trailers: close all pairs of single quotes
Date: Fri, 22 Aug 2025 17:20:35 +0200
Message-ID: <4eac944102a846695a9f61ead39a5a86361a0532.1755875970.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Demo:
    
        $ html2text <git-interpret-trailers.html | grep "'"
        This means that the trimmed <key> and <value> will be separated by ': ' (one
              $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --
              trailer 'sign: Bob <bob@example.com>' <msg.txt
              $ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>'
              $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --
              trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-
            * Configure a sign trailer with a command to automatically add a 'Signed-
              off-by: ' with the author information only if there is no 'Signed-off-by:
              ' already, and show how it works:
              $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git
              config user.email)>"'
              $ sed -e 's/ Z$/ /' temp.txt > commit_template.txt
    
    And on ‘master’:
    
        $ html2text <git-interpret-trailers.html  |grep "'"
        This means that the trimmed <key> and <value> will be separated by ': ' (one
              exists. Upon encountering '--no-if-exists, clear the effect of any
              previous use of '--if-exists, such that the relevant configuration
              missing. Upon encountering '--no-if-missing, clear the effect of any
              previous use of '--if-missing, such that the relevant configuration
              $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --
              trailer 'sign: Bob <bob@example.com>' <msg.txt
              $ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>'
              $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --
              trailer 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-
            * Configure a sign trailer with a command to automatically add a 'Signed-
              off-by: ' with the author information only if there is no 'Signed-off-by:
              ' already, and show how it works:
              $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git
              config user.email)>"'
              $ sed -e 's/ Z$/ /' temp.txt > commit_template.txt

 Documentation/git-interpret-trailers.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 82c8780d932..fd335fe772a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -142,8 +142,8 @@ OPTIONS
 	provided with '--if-exists' overrides the `trailer.ifExists` and any
 	applicable `trailer.<keyAlias>.ifExists` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists, clear the
-	effect of any previous use of '--if-exists, such that the relevant configuration
+	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-exists', clear the
+	effect of any previous use of '--if-exists', such that the relevant configuration
 	variables are no longer overridden. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
@@ -154,8 +154,8 @@ OPTIONS
 	provided with '--if-missing' overrides the `trailer.ifMissing` and any
 	applicable `trailer.<keyAlias>.ifMissing` configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing,
-	clear the effect of any previous use of '--if-missing, such that the relevant
+	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-missing',
+	clear the effect of any previous use of '--if-missing', such that the relevant
 	configuration variables are no longer overridden. Possible actions are `doNothing`
 	or `add`.
 

base-commit: 954d33a9757fcfab723a824116902f1eb16e05f7
-- 
2.50.1

