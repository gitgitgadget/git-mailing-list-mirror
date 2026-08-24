Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9135E94E
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607945; cv=none; b=fe/gJFhpFrHXeaTxZ/tA2P/0YzxPEHzDrpgV/xsK1eCS8KgQKe++E96AHJ1Lv9vQYyIfDpOzqlQD6aEFxBiDPNWicFYellVUMgsqH5WiZlyf4ftiVF66PEmho4bwihu6rqYd9eAPmhhf1HGnGCpKuM2GGShOlLg1EgTmC5uDIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607945; c=relaxed/simple;
	bh=gGWAT34VRFMX7ZRtjzt6nYWsQ540rH1qJXMwYLxfkc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTCAEnb7Ca5tMSpaBgJL7RrhsEQcSHl0w55fYX2LjN0ruq19L2da504hhasgsFlylN8DCy09R+tsh075o52kj3BWx3+9AOXEPqT9fnTxcue51vjO6HiURr5p8xoZ2cRg9VWAxdB1SCA5B79GaXsWu33WMif2u3gBE4huhlge8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ct+YxL8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4Cby8c7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ct+YxL8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4Cby8c7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 81AEBEC03B6;
	Mon, 24 Aug 2026 17:45:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 24 Aug 2026 17:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1787607942; x=1787694342; bh=edhfPTcavkt7tMxXhQjLyouI7PFMa4PG
	+7jRKoDPN+o=; b=ct+YxL8OyclT8+4oaHbDFwXBCd+YSc94G3rwUlNNj3nfZb2F
	MgFgKLhyxBKU76toDp5KqWMpGOThy1GRAQtmKLhlSoJ/2zXKN9S+C2834xnWooKH
	h6osCPu+BqizyHjkpVk8ITTZhjCFf+dYSVF+N/K8Vk3uewPsUOrjL1YdysVMJm09
	H3Jrosv/LYdV7pPKvgDRBXFT48Qh4fpvz1/JEeQIajfCw5wQXljLWSFnTcjJxcr1
	ZHLi8npmVEylcIajHDTphkg79OrdExzW/eiDdD7ozm/KiAElTQaa7gwopITIjfie
	dsBnVPvH+WHmFxjbTm8+XSSrnuQ8oi/PhIf6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787607942; x=
	1787694342; bh=edhfPTcavkt7tMxXhQjLyouI7PFMa4PG+7jRKoDPN+o=; b=A
	4Cby8c7bnIpcLTo6Qaj9xmUHHVF6fsLFtaYKweNvO/MYofQ1VkYJESvCJS5ZYlts
	rqMWjBF6RrqlFCStpwFHadhhEk+R9Ragy3TRgPqzTaM2MTiz25XgDpWJO3v07fVT
	v84XnTcsKZerTZhXWTMu9ZBbJSV2hJRaVg8mgixARH1B4xE+h/3jBBMQvIYif29B
	GNJFv0zhqwVD5DGCaoF2ylquVsX8QEcSTdHiTbeKlIIlighQekvKWqkEiWHoEfZB
	r7UswNHoh368enoYxFzEppXITzkdUcnMyiaHV3zPiHl5IXStgUZbpZWxk8dfcgfK
	DO544J4Pnbwx3+rKRRaqg==
X-ME-Sender: <xms:hruMak4VkCgbhhrLjOjqHKMjr1AsOp7DVvE1NriDDtuGw2bwczsl9Q>
    <xme:hruMar7F-NhXNiSAcMAyFRmTueW7VRunjKM9od8WTO94fqt04ZOWI1eBdR9ZXNODC
    Nh15gDxrSMBrFTbBKfGvjtGB0aQftuvlWvpHR8kM_9s1Fungal16A>
X-ME-Received: <xmr:hruMahHcBSdgO4m86QxFWuAqaZb4C3jTm_7sRnNRqD0rvMDFwDBfnjsYMWgHFpiKRrU0G6TdMzO0hIp7H0rNuHjM7jxpCE-cCw>
X-ME-Proxy-Cause: dmFkZTFIbQ9uOZsH4mG0CEPvJH8CaJXutRs36JmyqGvWbbBnbyM/sG+qbDgTkF1CsL3gJ4
    cEjwrvuiFzeaqQCfW4kYfSvrCwRB1Tb8E7priuUJ7Xv1FtW+3MFIsBcNCpwGFIN9HMMTD1
    0nl2XHqa+2DDyqdGJ4NoQFtwPeY/yfZaWX8qlM53rZJs0gYX844Tn+EaTjtU3S9+SfbO5z
    sv+EGlUWNh2om4G9Qk7r+kpunZ3I9GLFD+SSdW97a1C8VWpRf5zekcDRAxIV4Lsy0gyYnu
    P6iXy1GuMc/UlBuEBtK+b25+7TjJbvMDN+6b4UEDcKvAGxopqx1+NrOOp9YuaSrf9Pw0YW
    YlB0PqS0UaVklRuLgktMNpDPV/b0luvsbZep0C5q/vZdoc/diHkjQCSK0Oe7fqvDYVQJqA
    i52G21MBDOYK0bNAkxeAadDnciv4M2IzvF9YQnppQk10crJTBeJYhfN9cUxEpkA6P/wA9w
    wgL5szuAxzBLFz3yeYqEeuGLPasilVpUknYSkhv29R082x9MK76ocG81RMYuAIqJC0qxAx
    Oo9Iy+QoqedrEP4nCW4Vu/Vjr0DLrbnAiojqfqpNoL54DKKyENeuuFyr/MCVZqYHrC4aT5
    sC/SRvVHbHM63sz4tTwfS5wXUzGLnEneUOT6lmXf56lqBnN7YBVdlt+3SOHg
X-ME-Proxy: <xmx:hruMakRCvKbxCfgemmWCSJRMj2zbvzrBtF5m7e0ibxkUi8HqH2mdPA>
    <xmx:hruMaqvMJxoAzZmNRVZCMvHWaFwq1D9FgdAN7RKruclR2XCsgZioKA>
    <xmx:hruMajyyD3rxTH2QmUy0Js1mRitbvgEA5hgRDd4AxGaedE8rz7APCA>
    <xmx:hruMak5-tUUZyTpLx3jGyDiiuG7nG53msjFifgCbTOPM7-pwW7_sYA>
    <xmx:hruMaoTiz50zY7nqOokaWKXkycHLuhCamRpsFJnCfsGTgoh7z9Skwj9s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 17:45:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] rerere: technical documentation typofix
Date: Mon, 24 Aug 2026 14:45:40 -0700
Message-ID: <xmqqtsojp4zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add missing preposition "in" to a sentence.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/rerere.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/technical/rerere.adoc w/Documentation/technical/rerere.adoc
index 580f23360a..56ec7093f5 100644
--- c/Documentation/technical/rerere.adoc
+++ w/Documentation/technical/rerere.adoc
@@ -77,7 +77,7 @@ Sorting hunks
 ~~~~~~~~~~~~~
 
 As before, let's imagine that a common ancestor had a file with line A
-its early part, and line X in its late part.  And then four branches
+in its early part, and line X in its late part.  And then four branches
 are forked that do these things:
 
     - AB: changes A to B
