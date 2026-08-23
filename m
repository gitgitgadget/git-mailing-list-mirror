Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099D1EFFA1
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484860; cv=none; b=F6GlHCTMXuSRr6jKSTQ64yYSYc++fP8w5wm824JnT8FSTmOlmZBAlu3l+ALptNj4K2o+nQCoE9E0WDrT/h04UltqNDijt1zb0gftPJIINYQHrSMTevS7pvw+pgD8VMczHVgB1duQIWDISUZMTg7Z75Fq1IgVppgw62mYl0xZwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484860; c=relaxed/simple;
	bh=Nwxv4cD1HhPp4+URC2TsW9VOGHKT2qToaxr6eDVBy9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9ydulAd7IcUmdzEiktgnBz/RVtpAY5GQ8zKN2w1x+UiPRZd6dI3DSruqqd4G/k1CGWZ3TPxudDho7OhxStix7A7GtFDOGCSRwNMCd4wGBr/Gfqsl6LvUr54YIZNOcl3aYLZyiBBpZ+KKpsjzjAbsWDPPiaIIcV93FeGmwdcaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SeDVkyM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQwjzstt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SeDVkyM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQwjzstt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1820CEC00EF;
	Sun, 23 Aug 2026 07:34:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 23 Aug 2026 07:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787484858; x=
	1787571258; bh=EQ4F/13caS8yHyupDp8gH6iFrlKerPBxZnWZHo80fjE=; b=S
	eDVkyM6sM6A2m2ja7ozwes4XjQPzls/rWcxx6Quy479UMNOnzKfHWLHCNXrBnz/Y
	/4ujCfjtUd8W3sSg1tKTg5xy40xQLsPP3OLdPDkXFcNdGbi6qfhlF/WhWbUOIOpv
	Se/kThD1bdUL51IkP+4xS8tivaigZ6PgpvAcs8MX2SICXcNbF14A5bUHq/Fwxrfv
	kcGmqwkvqDKw4rD/0uzeTE/5dnBJE68sZvZtIbHmevyzLBwW8ea2JglTD+6OrkbP
	NjGVHwQwEaZ4xEO1VqF745PwT45gT0SuN0L/j18qeVplIsTYvksvZ/eGInrtm/MA
	N+Gv0hfVJhVX6uDKn65pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787484858; x=1787571258; bh=E
	Q4F/13caS8yHyupDp8gH6iFrlKerPBxZnWZHo80fjE=; b=PQwjzstt7OAohW6PO
	B+RWF6gXL8u30o5wR8/lU9dTS7GkrMbs3DMbxEJ+b/KaF+0GQF1t0mshHBkMQu6X
	1vDUbZYyS9IH44uMTpYUazikceK002h15XI3dE3q/l3AS2tHPFExPW3hxylGkvRE
	PFpYWAqaP2CDLn2EiqHE4zCM6K6GWascgjp/qt+mPERl4nFpZ6elQpv/rKAMDm+M
	uApl9paeWoP3RM2mtR8A9/b/Mp+8JH1EoZAF9d3osnbz51DRwqC9R+o1WZ4HepjQ
	yE2otVLhwxtM0NgMXcQQ73Egsu132mxBAv97pMQW9cMu/RNnQBUsQupL0ckVLoBM
	nOpiA==
X-ME-Sender: <xms:udqKamlUkaG3q1MKyNpMgK49_gK2CxsaNexPgG8mDatdoJ-qHhHCdcM>
    <xme:udqKak0Hsp6CBYb7eH4esBs34u_NehV5TiQ9sQUQqGfrlwFZ6MZCBy2Mh_lXDIaDR
    GF6khBUt-I0O5G-DYjaeo90cNJq4tewmC6FTR7dnUcC1LM8p5G3d6o>
X-ME-Received: <xmr:udqKappXQnM0B4nTawKed4dBihgw0trV8gs97crPQk2G1ZBQwAE4nkPXQGb7D18_tlyU_6xQTlvEFs_rNUzk8sI1UY6Xnd_sMWqlibWS0S8Hl7IgoPIIxTc>
X-ME-Proxy-Cause: dmFkZTEZ/Y3wcm9DXbHNIA2Tk4G/sErvxd1p+UCEXCuH80uGnv3Kfre02IRdrWcgqkYjBV
    ox/9muZnRBPTEWx6eYWtClpySy28wLnm52WVAOQ2hr3YOwRSZEYNDfKnhB2cKPX1w1uxFF
    q9TMdX9ZeHnGAnsGPWyVaECWzkSCVJ+cVYQc3/gmwvJRvYMolI+VwhgHlK4atUTudLoWYI
    DU3Gqz8RFjmOlYqQJcNzia5AGTUW7VLhfiRB8brCY62HoOugSD7X7kv9T2R4TtGYcXgQd3
    +1HTYLBGAY4jBiQfjykdmRPru/yf5VfhaYQ1wsfcvCxMr33VdHz4s90lxwxn1UPWvqu+ez
    v5i/KiU5tfkFuB7vXg8/7eDm5d5GXjrb1pNJ99zcqTIZNBjwZPbK6dHbhT3WjUIncTrefh
    gRHOR6Nld97w7SdLau1kdTAk/mZy8qShNa94LY5ilQ5FJOW6Zkw4PJwEX8Q08jA1+IYZez
    PukegWyo25Bm1CU1wFC9quG6dw03OTnoSfqABK0lRbsVutfI+nVYG1ayJ3yZSDubnrLrEw
    X1rR9wF+9kRNOoL5IHl9PGYTztHOmqOorHEVbtSCxcEx29y0C9DUnCV5GXvJyD5wCY5YZi
    SWNkqnDYqRz8H3suJPHjxN0p88t0HDQqIu1Xd+85Qn9Yn/rRBqBL/OaBG70g
X-ME-Proxy: <xmx:udqKape2C9W47ZaPkPCiuB_ZUxAJUjx_pMed5qHkcHX5lTAuZdPkFQ>
    <xmx:udqKagqefS5aKFnCzGlLPrUlDNEOveDDWey-kWNJXDeDoXNg6g60OA>
    <xmx:udqKaiGUR1PLyHXi3G1M00yrS5X7u0obiHxEWhqHYDD70LpvtbDEgA>
    <xmx:udqKaovL5ni2CxPGMNaNv0zA4dm-D6wZnW7zI3MMXe40mNG8SnLORg>
    <xmx:utqKagShtX7BA9ihjOCRw6wRm8Ge-u0MOkAQQUw2HWz-iZPzxUuPYg38>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 07:34:16 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 4/4] doc: datamodel: link to the glossary
Date: Sun, 23 Aug 2026 13:32:49 +0200
Message-ID: <V2_datam_to_glossary.c24@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We linked from the glossary to the data model page in the last commit.
It can also be useful to link the other way for readers who might want
to reference more terminology.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v1:
    But: maybe the See Also link is enough here?
    
    > a comprehensive terminology reference
    
    This is descriptive or aspirational. Either works.

 Documentation/gitdatamodel.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index dcfdff0346f..d588630e633 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -24,6 +24,8 @@ Git's core operations use 4 kinds of data:
 3. <<index,The index>>, also known as the staging area
 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
 
+See linkgit:gitglossary[7] for a comprehensive terminology reference.
+
 [[objects]]
 OBJECTS
 -------
@@ -300,6 +302,10 @@ $ git reflog main --date=iso --no-decorate
 4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
 ----
 
+SEE ALSO
+--------
+linkgit:gitglossary[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.55.0.13.g85d2d65e389

