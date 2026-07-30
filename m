Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA083FA5FE
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403167; cv=none; b=MNv7SMHnrlc8PY2hHeo7yHUG1+6f3IWRpylD4DnS/aJwi6MxNPISGPjTgQCokoRDz3uG4cvHkwMFID0fC7LL23JJvrSXSuQ3uj8VtcsNjNJhLg0L1OmLivo0xh5wuadJqkFQzaVT0QUtzp5/rN2ViZVW12NiU2py8lyOHGguIbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403167; c=relaxed/simple;
	bh=aY9wmOccwqIUfVjcIOeUYT0VtLohAt6zFb6GotmW/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr4VgSBsWQwe9P5fLHw7hxeJipbN2/8GqJa/fSm2e2KGyd7ddcHftxuu2UbGY9IoRuxUWgxnDJ2yJGDuj+pqIJrvP6/FDH0SQ7kCDYhNm9FdFYZO7oqfXtEuoe47+uNxbSpFVMYtRIzIXyQH6epDMBIFdOx5RobRP4lcRlMmJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HFzVEDMB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9mLqh8T; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HFzVEDMB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9mLqh8T"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EF5F7A01C7;
	Thu, 30 Jul 2026 05:19:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 05:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403165;
	 x=1785489565; bh=ZUH4ZWLnmmEEsN3K2RWApL2NywysGEXHOKaEimD3gGk=; b=
	HFzVEDMBJBdSR5fmV0vct9YXjiO8m9jycLRoxfr6SKyMmnHNuCyxIdD196FiDNwy
	ov6dPnlk8Cgo6f8mPbPHlOqW07UqoxGb79zaY6vN1RQgO/BCN8CdqnlHUWUswQ6T
	xNXkXGtZG2wk5KHHEfEGDl1gPtiHYCf6lzBLvTd3WCImEYGSjlxc+896NKK02ylN
	V/gqh3yTbhh3CaFtw5KDfo/DBx8bCrRzd4R+ASHFFXfStYopLFltYxzbiln/dSxo
	EFUdqQcuMzAiwrgRL49SZ6zJtDNqHIgYDfb1YG2ry6LQv3nNdav0Yo49gYqV5wfS
	MjZU/hAbezvmO7U8Q+moMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403165; x=
	1785489565; bh=ZUH4ZWLnmmEEsN3K2RWApL2NywysGEXHOKaEimD3gGk=; b=J
	9mLqh8THms6ykis7wy/y2pZgqYMFJ0MZf/IcdLG2T6xDAypNhBG49KWWafXmom72
	X3dFpDuM2WBZBazA72u2/O1gGR0tk8dh7hIVO0GzZzl0CD06yao55EtR4OhQ4EoE
	IRnmgeISprJhdhDvY0RmBdBqo2t1flUxpP4P/JgTlXizLb86mA4ol8vGqW35c4gF
	dm+MBWyk1gMtP476FYwp4sdyEHogdunmA17raV7auWOmqV5qyqbEkrmGgMeOVO7e
	8R28R+q0ok+tly5GfuXJb3aEHTIl3zgk5BjM13sHQjJa/9fzlPc8qPor6BwjXYxB
	uQ0fMGaW3Z1ldAXfb2iHg==
X-ME-Sender: <xms:HRdrakfzDWAJNh4p1uZ5AxH1KeEBjS21ie2vjGzi4jlL8BVG8qIYy8c>
    <xme:HRdralRaX9S-pqguoplkC9ePu-oAO93sn9KM8_qHRTaXLmngXr3dz9mXxd_w5IKai
    yTQMKw9NT9NanYPMCT0WvYImOYhu_f8JRDClZd-lr9bs06Mi_nbhBM>
X-ME-Received: <xmr:HRdrarurvciBlOtEOgRpPvdm-zS7F8EpkTi2Ln-jxVvcIrHPQmUs8xxlJov4XTBmv-hGDqffm7BBeCTO_HbSRpHYrmpzNfIp9ehSy3q2_lpw7IQseQGLo7Q>
X-ME-Proxy-Cause: dmFkZTGEif8V06QLJWp4Tr0XxWuthpDPXu8yXzE/6Wu3CJpYbMgM8lsm5jyJLeAnyrpZvE
    ycYhVYgpkiSon46eDu1/hD+XVIJYbH3Xeb45ZwNPUiCL5u1BeoKbRMXd2Dx36ClBh4cRfN
    3RDdslMGygM6+dnnjdS0m3p0cowhCsC+ewPbJAa763IQffx9meKZsfDOfBPvZRNlWFR95G
    1b/AcIyh8aIPq+fnefmHue4bAAgmxhPORPpGS4E1ADDTPqmGVvymu3hORTq1JjLamGV8UH
    NKlINhhPvBS5G13SWysle528nm5w3Xu9Dc9KfX3qSPABHdwZB6fD+D9CaGmb2OAuaqQ+Q+
    3u8IMNk6Ph7j1pixasLYb7OX6+OB+1UXA3a5zKnFvxIuBfqGUOw0GktBfVrEjK127J45D8
    OFK0CwUXwZvEYoA/HSp483bB9dUtzMC37JxjBZvt07fWlpDRaoOQ+9o1zGSSyB7QSfF5k/
    T8oagznJdWh3ZoJ/GCrsCBUSiRtg/TmueWfcQnAaTGFJFkfTGCOS80Ppn/1M5rF0qfDZi2
    eyb431NpZcCvpyive00P+pfH3MHATcuB5jUEm0TCA4GS7pCTS8lnzn2nvL+XjP6SSUxLFt
    a2yBMsUAsgfv3xCYly63TrzRnW/pJ7r7bdCKd9agf5E2oXLnsUflCMyoanqQ
X-ME-Proxy: <xmx:HRdramc-WdAFHssRY-MBe8v88IK78oKiS4lY_7aVz5deFqLMjhQy6A>
    <xmx:HRdralaqQuX1_7InZQVzGOnCD3VXmZ2KnoOF4bxWIIYwtA4dvxCsUg>
    <xmx:HRdraobIa_5aL7-IfIaqeE-A7ZO1DSyxioO8W1VXQxdJiEGwHDoOug>
    <xmx:HRdraqIVWLwh6MyXoEujrt53vL4iunQlQJ31-fhzCLvVbTnhFgCF_A>
    <xmx:HRdranak31SxvumHRuqoLBKmT5ubxkAn2qsbqYA_ac3cnM10ZGMJovM->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:19:23 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/11] =?UTF-8?q?doc:=20interpret-trailers:=20replace?= =?UTF-8?q?=20=E2=80=9Clines=E2=80=9D=20with=20=E2=80=9Cmetadata=E2=80=9D?=
Date: Thu, 30 Jul 2026 11:18:15 +0200
Message-ID: <V4_metadata_not_lines.ae4@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
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

