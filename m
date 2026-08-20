Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85212397E89
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252174; cv=none; b=XDzdri2HUep80II7VYxRWfmUW5387KL3iafQua0rys0VQ1zN5OoF04fcBUQ9kdKnsbr+S103tv1VIOt3QmUqboz/3w5R6Vy2ICxW55lnnuobdKqsVDtRKcktOAEX4SJLloDJlLR1NdmvAzhe0FVJxYSiCT2neTjLYz5Yb1FwFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252174; c=relaxed/simple;
	bh=Y9S2KrLidr4Ahik0WFnN7RqA4Av670nIixrm5lLRpjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6jM4fXYDPWjslsKa/GZZw96MqsyvOLd2WmOP1nMHIH2eAI1IMH7eDju4GeEZL5Vz0rO1x8K2ithzan2vohzSTxMfOQq+8EXcuz/T3XVpSMkge2pem+n7U/a0ywBNKa+rkaasIvTbqwb1sZyz+4V5zvxNIA7CS8oWYT9OTl09BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MaU+N0HI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQhOouOR; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MaU+N0HI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQhOouOR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D9F1A1D0015B;
	Thu, 20 Aug 2026 14:56:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 20 Aug 2026 14:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787252169;
	 x=1787338569; bh=ya4wd1xmm6oJDn/AcUaYWoW0WfDcSkSCP+SoRxgn7mM=; b=
	MaU+N0HIJjP8spwjJPnXV3tZJ2bXYR1TB/gb3qO88c2oEh/6bwKVgsRb3f+1G8gv
	tNlaWkJDbyravYLNPH6ZuIUf0TOh2CXuHWjkXmyQeWmDRqBN5ERbvfV/kKE2y8AN
	7GywS9ZrGnaJDbj/PjokB37Bt9DY2F+3n77A/NXxvICtj1NcXcYlttrDYgaJ1fgf
	z1oRbUMg6cAJNgKqUKUfgsBI7RJBqIRmEhFeVGhRc0IWWS8rhVbmmxZpgF1AL5vq
	g0E13IbtdW3/oy+ECQY+ZRLTjI08MbotMdvgYNtRaOhaJUJZtCnFmatvVttDyapP
	OKVuemVck/xKaV7wVKjVnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787252169; x=
	1787338569; bh=ya4wd1xmm6oJDn/AcUaYWoW0WfDcSkSCP+SoRxgn7mM=; b=I
	QhOouORo2e0T2KoL70ypEd6wEAeBO2lNqk061ISqOgYFSvH4QUS7CdQhpj1RMpkf
	FhzcdOjTfufD5+EX4mae1us819miDDdKxhL92PjNcINt8xmI0jXM32G2bTT01CD2
	WpQap6AQCeEbGxHjLnTI4qYcv1UakM0/SzVszu338Co+mzJWDkACqfmIxM111rTS
	wI4qn+EmvgO1fpTnRt9/zqX0WOQAi3dHqjmscOGwRc09QvyCN4DNCXn/uaexeAdo
	dLZWx7WnriLyFBlQ/tb6NDnunmfPZIEt9sKPSfi82W5R21dEX4naI/d/4y+nefmd
	AK2M74ynbRDxPsig0HGXQ==
X-ME-Sender: <xms:yU2HavGnj7peSK0DtyRFGM0ALaW003N6wBuj28TpCjd4aFaFpeeOb7M>
    <xme:yU2Hajz_CgI90uNu7qklBJtVtNgs-jkFE4YyjgxRcmoyH-02Aj825yX4fJdWaov_I
    VPoIrRnNs7QuneLB1CREgR8Ma0MIa0J_0RtMyn-TryiGNNbT9QuWg>
X-ME-Received: <xmr:yU2HauiczEcRbI23ZfyqnWu16ZJjzGtm1R8s1jxwTaeJyt_0jRv6Ar4DVqNrzAhDI91ILZ4seUCXt4rlmUUWX65tGxbAcwRsyYJVcKokVsrZYEMuDM6Yd98>
X-ME-Proxy-Cause: dmFkZTGOuGjopeXEC6TYmXTuNPs6qNdNdRHcks7xB9Tg7/rT/JjkiUixENGQTVBjSAa99a
    cwOU06n0WIOQRY0JRx5ovekct2zG9nUM/RQV4KoTK1X4B5L8TvZqeFkZ6EYn1JIWHvDDzZ
    2ST05KpNs2lbauvcmGTSL0b2r2XM0xXvB9qIniTNaTc6TUEs7BCG7PYwMWfd0R0Vn20K3D
    9Gnl8CeXwldSQhQMNo8Vfewhmv2wTcbHBLzy0ci4bdOc2hQe7AIi+Zl9bkfNwfMfTKjgxr
    jBlweZgO6ubBZKX2wsf+fPPxPWGetbcLJWjR1L6fbwxzjV8HzGtJr0y66/qE+F21fGpibV
    zSrpEDwxmKPICYWquU5kOdLLBwRTeexdDx7ybMoDrDP7VC3r5VP/DQv1+p+7pkGatmk5tj
    Dkj5UmZ+hJ9TQqRCDr1pqehQoMIy3jwPGW5HbGMYLCx+2fUDweqSXqlbB5TWTVTm3s/5XJ
    qKrX4Rb5F+KYc5pI14SPkmgdxwZjH4wje/ZLKHpuYwEpidJyOf20O4kL8oNNRVxZQhbXI1
    vUNoUJYI1W4A3RuxqHHumpVYsV/e5iXcErzrMTjxI+RSUP4uwn93TpM0H67X/J9S59kbRl
    S3YLvZGcj/kfGcICzM3dw4q3tujMsQZ5G6Jp/MiJ6CtqozuLVl5+HQ1z9KpQ
X-ME-Proxy: <xmx:yU2HamzCwSUv3Kypc_yVqBOd3tQmkAodnN32CZBD_1Otfy5tpJJUcA>
    <xmx:yU2HapJLHnYpNujeXi2zXCRDYMDdEWeVGthhli99Oy4A5shRV8xUPQ>
    <xmx:yU2HalTa9NOXfCDlQpEHTkPNHL_Q0_xy9Ss0MNB4EjdIAvNGHT5JAg>
    <xmx:yU2Happ3q8a__IBh-PKjkfgSi6Vw2E5vOjigMlNsN6GVlDMHzDJ-9Q>
    <xmx:yU2HauH7CXw7T_WCRfraue2r8wNoMvvAWApShctf7wmcKHvO6D7pQRD_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 14:56:08 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 1/4] doc: git: list gitdatamodel(7) as a concept guide
Date: Thu, 20 Aug 2026 20:55:21 +0200
Message-ID: <git_help_--guide_datam.beb@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_doc_datamodel_advertize.bea@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

dee80940 (doc: add an explanation of Git's data model, 2025-11-12) added
gitdatamodel(7), documenting Git’s data model. But it is not mentioned
everywhere.

Let’s start by listing it under Guides in git(1) and with `git help
--guides`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 21b802c4202..63ae2a67c94 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -217,6 +217,7 @@ gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
 gitcvs-migration                        guide
+gitdatamodel                            guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
-- 
2.55.0.13.g85d2d65e389

