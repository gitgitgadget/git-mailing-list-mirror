Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD242D74F
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381118; cv=none; b=jRjMJ6x3TujQEFCA8cDF4mgsy4geeIvKTl9ltAhxaqLwOV5LdfchatwoAuUGzspxoixb8/F/4EcWgZXIJsnf3cp/+RtX5Nsnc+LYwhDLAJ2JG6j/y3UAYE+fmL9/aMgkvsar0L7ECL7UCGUeNsSVtOao2V7Pr5eSMnZbinDy1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381118; c=relaxed/simple;
	bh=0jTmqsUkMCAFT2jFNDV9xpR8EyGfKX7NnhCKcvUF7dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UP0UjYRVzOSlHM8A54q4JqBmtAfx+r4ml8UkfZ7ZHNdOmMBlpqMm3mJdXcGtyin35Jd/h4p6Oeq3tdFJHNIB+1HRF5i7Xxc9sfxYoX2I8huFL69piSgROdHwOFVO3z7HbNMxzIgKbLVatigdRworMXOyIduE6+k+tBhNYscxiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T4ajOjdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctk7B38I; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T4ajOjdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctk7B38I"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 57F92EC0143;
	Mon, 10 Aug 2026 12:58:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786381115;
	 x=1786467515; bh=LVi5MyvnnsbST7Q6N/v17lYwTnAX+nuMLCRAZhu4Dp4=; b=
	T4ajOjdzkJ0sUnQjrnrLDMyc2jby1MiR04x7u8YzQgSvayoqoVFD4PmvLC2xzXp5
	Mei2rw2OXufJZinyVaKSFME+S7HXO5spSEBsughGSI028f21vCjx1y9aRxpgAC5i
	NSZv60yXABz1VmltN05CYRVskYvkVVpPQWUuHEDHrbINgIefiOw2NlvWrP7zIxpO
	NJuKcU2QTQMYfSg8h8A0Vo0VCXyyuHsUyWCDB35UdcJVR1o+wjQujH3E0wktSMhJ
	D1Q+eeNVKmXU5uLe2fmGuTLgmMB4Yuf6XT2CPNMwegaZF37TSaBxCyx0v14fJ6NL
	OfeztMB81q8wM9dU4dti6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786381115; x=
	1786467515; bh=LVi5MyvnnsbST7Q6N/v17lYwTnAX+nuMLCRAZhu4Dp4=; b=c
	tk7B38IGZJnFT64R5lTHzN8lYROaqP9YpKR5NBOZyB1q8yhHq79wJ0sy10cB2l/K
	2//JoRlEL9FIVMCwao08W3cZHXPllZNFhQanFN5NFp6WfHKxDE0mlfbBs5uT8Lpo
	1Ubs/D3KNfEGWaXxaM/dQzDNsyl+M+NatsMdPusmt0w2uHy0x7vIjkyG9Mf58Tc3
	OS8uzYoF9gFwpCrwsKXJ10XXd4zIKR1bA1LUvp8tDgL71j4NFcmLyDgS4MECLJ5+
	PuAqOIOA0SD0BVCl3ciM2iGbcpK//U/cpxFJvPJRmy8gY72pJJAt9ShONkBagDoY
	M+JRlf7p247VhgbYGLgSQ==
X-ME-Sender: <xms:OwN6aodenBOjnhETDrl0rkKKd05p3c0OVZ3PjTIKUq4ScjTpU3Di48g>
    <xme:OwN6agMpieVmf2iogifhK_HhGiK4btG4c5JE0B39UMdMevVTfyBTE7CX8YHddMkq5
    QAqCUwldrZxEAN8ixme8f9xtylnDQE4VhLUB6dMbHdIDYAFD2CZdA>
X-ME-Received: <xmr:OwN6anIeTJPZkNGMqbViCSdgYwJQbphOhf6nUvPtZGO_K4aQ1v_wDfHnDn3jO2Yv8RbjvMP0c3xDGp3MWz06lxDE6CVCSbAsFsaPqhG341CGaEobvO3OWgI>
X-ME-Proxy-Cause: dmFkZTGI3WFoBLFdQftS13LmYTOJakgH2QTQ5dGfVvhd14S6wwQPoiBHkIlXjVgQRhU2aW
    m4Bz8rH8jhSq7ALs8PmV0AhNm6rZSEQUiigBQJw699cxGiR17imDJ5B1MxGe2UU9MaeQCY
    1Eld3M3HsKByOK2mrhuCPgq9+YOntfGPEGEbMfvbxAluGw+twTRuV5gOsAbw2EBQB2Nwjt
    wmnvl0d5erLZcRdWgmul6mFOq2xcEph4NNxs+bDIZm+LEhuIrEoUkW4FEkNT3jRyH8Naju
    kijMj9HJGBJ/p5TAffoyHRAnsBxh1C/6FixVeAJC5OdmpIHvGnXs+3k4Nyv4wVXoMq1pFa
    Wz7J3VmoR2oOMrt5keWOXe9yAVnwIvMe0slaQAXUvDA44sk20laznWKcF7/aJqrzBHCXUg
    O5dTEDZQLXnsi2gbFx32sVhTU6N7dFRJpkQG2WlXKgls4RN4eV7jjy31P/IkIuNZEViFD/
    qOzPhpp6LyOjA/1bwdvnUWqkW4xlL402vkBft2TNQ2Jf9FOXwLvdHzsnuQIecZ29CcKaqE
    HK9HlYCUEThMADELXQ2QWGh7rdF7oreL0Csumg3Vv2ihdu+S5VKBpCHRMc0LzNI2p60iH3
    Q+/8WG1bqNg/lQjf5m0E3qDDAfScfGzC+wmC1885ajz1Md8eepCXbh/rXaAg
X-ME-Proxy: <xmx:OwN6apGrtS-7Sk6VBa8D_t4Le1IcxrPVAiefpu6WliKj544oJQCvcQ>
    <xmx:OwN6anTQ8FnJWo3-WF5mbkP1LAtSRN8RBUPSTl0TdV8p3rXDWXtVyg>
    <xmx:OwN6atHkWAffFZ15vrrGfX1xIPusBmaYTzaromEtR8FX08Zh0l3JNQ>
    <xmx:OwN6ar_lrQgwFblZY8g2JiWyjKtHx_O2fhXPorEkUp4cnnPlWha7NQ>
    <xmx:OwN6aj08fsg6TPpcPQsLHzCvKM5LN3k4XSqCmmCDUkG9Kalida9q7vJx>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 12:58:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH resend] doc: format-rev: use [synopsis] on code block
Date: Mon, 10 Aug 2026 18:58:05 +0200
Message-ID: <synopsis_block.b37@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <synopsis_block.af9@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This code block uses the placeholder `<subject>`. Let’s highlight this
placeholder properly by using the `synopsis` block definition which was
introduced in a34d1d53 (doc: convert git-show to synopsis style,
2026-02-06).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-format-rev-1

 Documentation/git-format-rev.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 505a52feccd..836ba4b0c24 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
 formatted commit, i.e. the format `%s` would transform some commit
 object name to `<subject>` without any termination. Like this:
 
+[synopsis]
 ----
 Did we not fix this in "<subject>"?
 ----

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0.22.g9e26862b904

