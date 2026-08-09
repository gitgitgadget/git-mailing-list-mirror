Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547E3D3317
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306077; cv=none; b=uzFx8O0WcJ2ToptYTKiKep2ZBdECxlvu9jUAKETDZSRUjQg8LA8Bmpd4kC3GzhEz79RsqI3q27mCj6B5k3jyTtkXCBNQ3fPcG3Je7R5hOu2L4Xze0pSO2yHhqo6eA73ArX1HxCgQoHnVyQow13TAd/6s3g+lS3ev1myv+cA/MFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306077; c=relaxed/simple;
	bh=aY9wmOccwqIUfVjcIOeUYT0VtLohAt6zFb6GotmW/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmPcCGmVZXIx+fCQhONs5WHjsIVm5dYNUgxmQB6DAKNEH+gvNWEkZuIR0rpFYk6CsjJ7EM/2TryJvmHXmrGi/FNhjXUUckd5KKr/0BcbA2j/wKczozIlNZwwD8WPUdCmi0M3PtABjjPeip6qk7af/YKjuQgdJFeYQAiMqVPg6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=oWkEQwKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHTqj57h; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="oWkEQwKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHTqj57h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8BB87A0147;
	Sun,  9 Aug 2026 16:07:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 09 Aug 2026 16:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306074;
	 x=1786392474; bh=ZUH4ZWLnmmEEsN3K2RWApL2NywysGEXHOKaEimD3gGk=; b=
	oWkEQwKWAuK71O1j4IVlm0fETeG5AhSp7cZZKzWGK1qe9TkTyHMx4fzm2FR8ul0O
	Ip+7qoFjeK64dw9gh5Y10Uq92TXFWHBokF4JaQIO0bZAzEWg3CnEkT9P5NrRfKL4
	uWb9p0LSvatxhjRXwi1e6zJAIac8O+6W8NoTlZ6jr46sWH0ckcreFhe61s5LYeqv
	s95S3ZPkBUeo2H8QJRPH9YqoYgDTzcb4BCOZ63CrMtzowh5wtzO6kUnGUbRabzb2
	YeQCH0ueOgpGAidOcsbpcJZ/MRGfFKBq+G989f4dNn/3uNVmMIrgU5InXnqQ92Un
	DZ72tjDM3McTUUQ45rEbgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306074; x=
	1786392474; bh=ZUH4ZWLnmmEEsN3K2RWApL2NywysGEXHOKaEimD3gGk=; b=S
	HTqj57hq2+prk9mS7pStNw8XTDWr9HbwWLV1hDlqKsm6LdW5pAY2op5T/Nq/n9S+
	I1Pv5RRSy2LtU0kA8e746A5QVma4KTzRhrxzPFUgEpfV7IpcbkKtmwtm3tYXFtZO
	PHsoAk4u/lFGrdLH1aVr8oBMb89OMPpZx4UPTwucF2BIdOvhGtwhElLe2xQTQEJB
	gX2zIQZj4oj7TLo+EtfM9ppF7sZG9/J82x38OL934CiEXgNDRz/4AgA3FD9Qbs9r
	rCrTGQv74cQ6dGxF7f+Ql8CYnR4MWv78RJQ8H+5dio08wRAy7Olk+6treLgS8/zi
	/aS14arlcyNEAZ7aWDvjA==
X-ME-Sender: <xms:Gt54amJ7IfKq8pKndKJ1HK9_L6StQrZ_3WfPao7gEXSpmy01C2DugGQ>
    <xme:Gt54atOP3HVLASHaV0Xn4MnXRsm2YX1bIEQyaivD-2MW8CrXqaxDI2atCz0_jLI4D
    DzkHH3cLmoTt-u6q0dGfGrFLIaqgFZSzpF6mVaAPECOR8vQw5cUM8A>
X-ME-Received: <xmr:Gt54as6MMXxZfr7hGB7VZIa0E8mVyHBeJ82M7BHgKKBcFunDBQeBkKppHw0FXgQv55D67CZmlAooUKWbafV--Z9-12TIzhHpiPCcGC3dnE4T4-wDoWeFs8Y>
X-ME-Proxy-Cause: dmFkZTFeqnCslSnr8i5H1YvUsi9MS94aL9oIV8h94CFICeyCkTImgemHOtBmEDLdj4YL6M
    QmfCTYL6YrLhJb/lwW2VC0HrakoWakpWCNE9jFvC+66OlHI19tlK2BZcsyGpjAN3z99T2z
    Be5tJHOKdcV2bO7t91dl6gt9zYDKcCx3eU2iKl3UTikYbFrgIrhmIiuT1CBlgR+3Q9K1YQ
    AnbZHKwswfFWQ4fkEWEeu/Fi9ouMoh67ghpAerMDcnua3v1e7DV9x5J0oUgV8rWCUM9s81
    zOtn96KWnhm/S/REuw8JBDEdSkVCFGkDHfGjLR07DJ6mZf+9i3Vu/hjFDuK6y1z29DPMcr
    /WJn1InVEPzQQLUeqOeJZSm36E+/xd7aL7bjELzdIYsEr9KiqAs+hQ7tilI9aFpp+UAoYR
    oM4wnW8RdE0U/RI//z1QuPABcoFpav8a/j4fXo6lDQr/Cu5udE20gDC8UkzL+FOfzs2atY
    fTSIh/JGZsH6qkBs8ZiPA6oc/uk+yw+7191QYmM6XHn3ZYmDHZuoxpxrDKCISL+Wq2A+wa
    PG08ODKk1sq/o+n7Byfa7yrIoRwNQoM8nu4bUP+eavWk9dbm1doqc8cqwhrbAg9G/NKwvE
    609aZN34oXu8RBAISEctyciKR7nK6JnLDUjCvYXECki/++7wE0dr5punPX0A
X-ME-Proxy: <xmx:Gt54an4la0yUpvNFBrfwSs4usO06HL5hcfaINisLdV5wG4dHC43Q8g>
    <xmx:Gt54aiG5tMmDJ4ctF3EPKdxkZ1pUmZh5Bh45R1v_A2cnP67Sbc4DWg>
    <xmx:Gt54avV2aml6dHlaAPqUx1f0MCBocrOcfPB8rbtkb_B0AVeHSEckcQ>
    <xmx:Gt54auUU1Cui9Gc9h_Gih_L07Gmk5p4MF3VLQDSLvU2qUM7mf5o7VQ>
    <xmx:Gt54agnWXHtbm2t88CwZml9J7pmDyfzVRqhjekOPaine0oIs8qBxjpi4>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:07:52 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 02/11] =?UTF-8?q?doc:=20interpret-trailers:=20replace?= =?UTF-8?q?=20=E2=80=9Clines=E2=80=9D=20with=20=E2=80=9Cmetadata=E2=80=9D?=
Date: Sun,  9 Aug 2026 22:06:26 +0200
Message-ID: <V5_metadata_not_lines.b28@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We removed the initial comparison to email headers in the previous
commit. Now the introduction paragraph just says “trailer lines”, and
the only hint that this is metadata/structured information is the
“otherwise free-form” phrase.

Let’s replace “lines” with “metadata” since that is their purpose.
This also makes the introduction more consistent with how I chose
to define trailers in the glossary:[1] “Key-value metadata”. (We will
introduce “key–value” in the upcoming commit “explain the format after
the intro”.)

† 1: 68e3c69e (Documentation/glossary: describe "trailer", 2024-11-17)

Let’s not emphasize “trailer” here since we are going to define the term
in the upcoming commit “explain the format after the intro”.

Let’s call it “trailer metadata” rather than “trailers metadata”.
At first it seemed better to use the latter:

1. We’re introducing the jargon, and the format is often discussed as
   plural “trailers”, with its constituent parts being singular
   “trailer”
2. What this replaces uses “trailer”, but it rescues the plural mood
   with “lines”
3. This is very soon going to go into the constituent parts, including
   each trailer, so we’re contrasting the concept name (trailers) with
   its parts

But:

1. The former reads better (most important)
2. “Trailer *metadata*” suggests plurality, similar to “trailer *lines*”

Helped-by: Matt Hunter <m@lfurio.us>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • s/trailers metadata/trailer metadata/ since it reads better (and
      see commit message for details)
    
      🔗 https://lore.kernel.org/git/DJ5W2I8UYXAA.3O4JQUHFMKP5X@lfurio.us/
    • Msg: Add a paragraph to explain why we remove the emphasis from
      “trailer”. In the previous version we replaced “trailer” with
      “trailers”, so we didn’t need to explain it then.
    
    ---
    
    v2: [new]

 Documentation/git-interpret-trailers.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 1878848ad2a..c8950d3babc 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,7 +14,7 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines at the end of the otherwise
+Add or parse trailer metadata at the end of the otherwise
 free-form part of a commit message. For example, in the following commit
 message
 
-- 
2.54.0.22.g9e26862b904

