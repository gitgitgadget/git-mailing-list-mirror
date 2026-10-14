Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9714AA599
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968045; cv=none; b=Z+/AfawC3tVeiKMUxr7N1RO7R0HTTwdn4wQfcwFtsfdzy7/PS/oz2oWBVWIAlAjivcDor2O9cfBeZWb0Fs/69ULq+vgjhstOdUmkWSw4m54872fOlg3027eeTlY/B+VqoRksF2f67VwsDDAi5lUrD4qslRBYhYGtnRk1pPIRKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968045; c=relaxed/simple;
	bh=PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdtwKH0a3nUua+gM4PBNzz7ClL2crp8cvLauRbLGaa9E0N1YfzfKg+EcP1raeo/P0Hm2s0DmloYB+7RecH5Opwv2FhRa6iagGnqZMUGuSh0vZhRi5GQuvpO+YY3uIzp5FaIIjayXHbhG6SyKZgb2ziuJPXMHfIk9Jj9o2AbybuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/FeIaUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vJGnB8g+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/FeIaUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vJGnB8g+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3520BEC0228
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 14 Oct 2026 04:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968043;
	 x=1792054443; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=
	T/FeIaUfe6EpYRGzPp6t7WPG6Qv9S1wo+X8mls+2OomRSCqfnE3LniXdwptB8tce
	BXpAdUYooPNxBwCs9uUquxg3J9atPkQjqY6LoYlqG3zOHUrMdEI+qm+0gKCIlkfE
	+phT0++lwld6kzcD1iDFNcKzdESVb0I+F8f7sDM4FslSSckjczatebQINfbYIQG/
	UPtxJlEXLj8s3njobrJEvkFVOAYIUIJjNNP2pMsuL6mdnjFjTKaAjuMftxvkZ46Y
	rYhgrgEiri+lQozsY9L/dVg5YwziOxTEP2PGeF/Kv55jsbv2A2XIv7z2Gm55G7ZT
	ihG95/zNT9pAdVlZKOXSzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968043; x=
	1792054443; bh=UQkBZAwBmhkgCJVh0q5Fo+1NIW5QW3+wGHZIJjr+Ga4=; b=v
	JGnB8g+WvjzpqQ71j+mxwfeTPMuH2hJDqjCtYarBn5GCV6SUw2EBO/GG1egLedPY
	c5RjhLkcl8ZIgTWjqTK9BiGPEPB+xzInXKNFuNOCQ/zhm98ohjjHOXUGK/xyr3XW
	Co14r6if16SFWt2zh4q6lIlYwsew350drRqGYoobFNsjUDKFOCwr8R/7v4M8IDi3
	v1y9cTGg5BchkNIVo13yVKiybnYn0u3vAJ6UhkEMJlboETPUzsN48e6vt4Fp7vg0
	8CCanqPqru505AnsQez9L8hjt0qT1f/ZjxtQhCPO1ZRlXNc5vEn04IODkvumCKO2
	+EP981yBpEViyi+ViVzsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968043; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hHuV66fLoVZSsMWS5vNYGOQk2XaAimorufh71bfzT/ISo7H
	Qt2CI2FksudDEeT2DlfyiBdNMzQ2BBMiO6JPhhzbBi6CW2l8gqcdlqIZ0VatlpqV
	sqt9A6h7jjxOSvCVidxzZzQ2q5cBrtebOrQjHOPTjuIkC6vjgCse07hlLPH9ka+P
	Tr9SCxcDXEnHHFK53cmmn4xRh41cMeaHdQjYwLiYVO754LM/9uEBttTMDGdyI6vz
	UJpv7gSxdKtBOnwMnjEvPzujIptqjxfYbgeiN0+N+JcIvlpa0Jg4qubz6Ov+baIl
	VIvysweSwNGahBG4xOCFcYjXplUeFGuBgzOFIqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f5s0A1j96qp7rIShRixBOdmnNZYWmT9xOEnISKutBsI=:PSIn2NvkXJ+sxTIMwzUtf5SCYLoyX0FUhJp2hgVb9Zc=;
X-ME-Sender: <xms:K0PPatdQmJIuaTMMM_XfWOLjnUtqnkdlPzbds6tlKI_P6nBY7q3WAQ>
    <xme:K0PPaiNW3p6zA-tS7VQOeIdk_f2OT0KM4j4M2l1SArTIYZFG6bKxUOwaJlAru18s4
    5zyTcVCKS3NbTYoM9U431V_QXRP2R5ChOhCTfsnXLjb0GEsNa0qrg>
X-ME-Received: <xmr:K0PPargsPJZgU9iugCYERB7yON3GcmRXt2zTOp5OVjA97vurzhrixQ>
X-ME-Proxy-Cause: dmFkZTEIGbfxSI3LK1PjypvgEMHVXUW0L5HWcG0BIsOmbk6itNM66/4zvoSPIX2WOSwp1X
    61Ife/ZBu0XlHdtlQJBOGqy3Y4djmbT/ZTaw+DFeOy2p/xriFVqMihR2QN5pzzYBDKw2VT
    qv4rA+uKFyqpW0LG1fskR+o/dZ8j5BYdcM2t2y/v84NZWoeKtSFHlzlC59O3EAJaZsgJi5
    ab0DSmncPPyrquYVpCiXeeXgmWhnsNx1yTH2IoJtv9NiunhMjc0uAh6jITC5QQ7XMnL0lB
    u1haWUg9JeY4GmBu5H9VkPO9DUniWQ3hzuMSYDU6A/ES/I+5NjGtpi65Yl6lLdAwHGTwQb
    lMppnbvPL2BEWnheaX49N13SBjZM3YY7u5wIvpw0hIiYvgPQoWlppdUfaWuIiOcIlBETF6
    ckRxnxD3z7MyOuKRvQ0jImkoyaP/hC4jxzYroDdLasYASC4SXvCQg44oOCsuuO/7bHM5zD
    BnYJL7kWUb98aXqbWIz1TLH/P09Ncq5LMRNIHFx/Cq3GFkKYxgH+tB+lodWfNwgvaDRtwY
    hmYkF/zgCFs8n8rUeXj2Xx+fidjnmZocRSsGAoTWM3syUl+apbYn3TtwNAMOpKXglpIw8s
    te1QU6SF8cGCjjOUVSNNBSF1TkNXPGohHnppvjTY1k6z8klkTiwNLSrXB+iQ
X-ME-Proxy: <xmx:K0PPal1ojKrcZdZuumIeEjBW95mM8pFlsSqCy8Uwl89dfHgXtLCfCA>
    <xmx:K0PPalgziUxJITHWVQmVX9I7yC4Mfw6sDx_lzVqDN5E3U7tPPSz4KA>
    <xmx:K0PPalc6Qs4SAGPWybQ0lM3-BVGxwpHJPm1xXAVkoKSogPby-_vNrA>
    <xmx:K0PPaokUvBRaaJ9FHwp0qCOoy3CpxnD4A-C5-fiZKlc1I1bUcJwiyA>
    <xmx:K0PPagb6MNrRwM6jVAXJC-OsiJUskQQygpHtRKdgMEdC8U4HTy1AegZ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:54:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f04c53fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:54:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:46 +0200
Subject: [PATCH v2 2/6] odb/source-files: fix performance when streaming
 objects with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-2-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

This patch is essentially the equivalent to the preceding patch, but for
streaming objects instead of just reading them directly.

Exercising performance is a bit more complicated here as streaming only
really kicks in for large objects. Furthermore, I expect that the impact
is not as big as with the last commit, either, because for large objects
the time to stat the file will probably be dwarfed by the time it takes
to read the object itself.

But even though this is probably not as impactful, it makes sense anyway
to do this change to align behaviour across both of these functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 9268f5aa9a..54235821d5 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -462,8 +462,10 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
-		if (!odb_source_read_object_stream(out, &dir->packed->base, oid) ||
-		    !odb_source_read_object_stream(out, &dir->loose->base, oid))
+		if (!odb_source_read_object_stream(out, &dir->packed->base, oid))
+			return 0;
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
+		if (!odb_source_read_object_stream(out, &dir->loose->base, oid))
 			return 0;
 
 	return -1;

-- 
2.56.0.212.g129ede20d9.dirty

