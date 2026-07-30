Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A834028D8
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403242; cv=none; b=Mb+VR1GeK5IJ5QycvQXlaRfIylAgcf3u7dbF54t8uabgsgpCr+EvjMtV+a9ttRG3wsdbaHnnLg5aNo1fSgPbag7AB5m9oLsmrjA3fD2q7YcbrMnY+Is7MkIQEBfaaGq0TVKG2g1ZlvC2nPIY5aii6bTA8ehgW1ppLwbAgmYhP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403242; c=relaxed/simple;
	bh=6bk9+isX6J6bNb7H2Nijd/CjyDWqFdDLgxcFaOMh4lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrNxahjqk+OwDCAU8k9OyT5LExNIoYcxMCdtKUxV+MWHDQub7mjgxZkgaIakSlo1T4VWAsoJ0ebMtHqLNPdanCAtsdjp7/NHgFhIZM4SGBbv4bOqhXAF8xDAHSiSzo97+ncQgWVke6gNzF6+TEbgzfWvnFX2Xkk63Wj+Oo96Nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rPlGEDij; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebrPNqRY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rPlGEDij";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebrPNqRY"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D9B9F1D00125;
	Thu, 30 Jul 2026 05:20:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 05:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785403239;
	 x=1785489639; bh=R2SdBQIkFOdAz4KtOvDLt9ZtoM0TdUaEgdCYHkCgDcU=; b=
	rPlGEDijCYd5Yz5vnJobVcsl0whrdHOO5LZ+MBAK+WhVqcRfhLyWmV9i7T58XWTU
	1q1Z2rkgPRDYMBSXNwqk/lalKYAPDVDspE2TO6JuWyrA8Sa2yzXKWltsQ3qU+G3X
	aDK1mOs+VBpH3TGSm2OOn6blfXfUKNDVsNAvVBHHU+aStFP67bRNz+MISA8r2J5O
	4l2/rT9rmTM6DG/KeqYdcECYgZngbnqcsbgY8D/7+NcV3rQ0fYWf86Lir9USHzod
	WktPO3b01OF74Hz+XAlmRjQW75DaK9Ji2cdNZZb+/Xn5W+YufN++pOVy5F+52RBi
	CLvnIUOhlTaeaJ5K6mTpbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785403239; x=
	1785489639; bh=R2SdBQIkFOdAz4KtOvDLt9ZtoM0TdUaEgdCYHkCgDcU=; b=e
	brPNqRYv0eP4OM+IGgbXB0JuUe8NZywMcTCGSpsEgyDhgu+cBNcDxnuiWPgLDjJb
	4iobjeiN6nDUhZfsl/Fo7OANriAn658eOLC3FXsLrzn0CQeVIQhtjI6unE/65cPD
	Gcvb/0QjGcsryrr3qWo5A5uBl2hTFR0CDoW//tRHxqmNDXL5L/6XD5yRO4FWErPo
	BDjRtUEAeXNE9Fgce2xZJGEyWarBdjP7O7LVGLSYAzfkm2heiGutNKbCGcThmcLH
	n542OoeDVl/UGUgVp83AxlIN265y4DHo8AsmF249TEh7D+XnNer7WgHpI+9YdK/I
	xDImuGCA4w1/W/IYs62uQ==
X-ME-Sender: <xms:ZxdrapkIBvzDPlBDheWs-eF8aZNy5p8JpdLXOUWX7IS_P9PBSZJQH1M>
    <xme:Zxdraj4awOMdsHZSpQbc7hud9H8qJ-gvSCf9fdXvTSt9CkcI7hhfk-ljD4ntnrhoz
    igZX_RP7tyk3-uINiof1a1x1wwCy-UgiM2Qy20tLLVFgKOnmUh8zhk>
X-ME-Received: <xmr:Zxdral2eExl4whs6Q4aC0TA3tprAwYvRFIGnBu9kG5cQEsuMrF7boaz3aLWY5Oj-xJ8DdPMRJCc-SNgb6x6dNywhAdhV7ygmWkweKEe0-HzZsdVSfPm8YWc>
X-ME-Proxy-Cause: dmFkZTFomTnSb+31p5NPZezN1HN0kXXqK1sw5PZwoB9qrOM5crVq75lvN/qBplNI+WaUmK
    SzBNJFqOpuKn5VJSRpZGcVyiO8T0hBeQz2AS6+PRYyxihtQzo4ShWZLDMRK2dyxw4hAiBQ
    yOTD/iYaPBE3Wq47yd2fzMRzITJ6K2f5+pwOMeOme85f9PtrphssWvC4hdDvYz1/Y29Nrz
    DTXBwjqzpxgKNjIt/bvEQ0GmSTEkzsHpWoy/RhtVYjrFmEt4MS+WI7CV79VhaDp6I/+iKR
    9vWjo4rp2pDXV0Z+5TseuTh4jn0WG1BGRcqwi33dD5ZZXKvZuWqiMSR8mVsOP4BSYJWnOL
    xxrsjilZldvsfDuJAASo0OnwPZsCR7MADr2pG4iIWXzgpCBR3xss9Qk3q4QVQwPF9r/X0y
    LeRO7JW5chVlgs3zmD/h1FbRabUGNgFWVycYTay43OV/sx3SL2jgGIINhnr2ex38+S1Ut9
    zoGLBcDimY/SFcJYq4lM1Hk6QM+dGH5g+ZdhPk3IGSRni7YJl6Vylkwm2tQ83G8fNB3lOT
    nGGp7Up7QvIG87SpExL99ik73+bXMmScqj4onBMud2Lf1cgEePIpRSqflxYxlqFLF/he99
    zphMD4REDEZUktEZXaMeFw4djdsuLuJFXFN+Bco6dWEEz0uwMqQMW8Yp8YMg
X-ME-Proxy: <xmx:ZxdramEZR2aLOkEt5UG63wlzzi2vsy1sGDcpJZ-dpo7DHDNLYhxCVQ>
    <xmx:ZxdrasiCvRgh-HA4xP1GR96khp8V8NsS3BZLRqnk0_3JS0_I6DLkYQ>
    <xmx:ZxdrahBdSK0D6EPr15S4oAbrx9foXF6b6VlvewyMEvooASzpF8De6Q>
    <xmx:ZxdramRQ7_jyLm8UfW3pD4u-J5bIc1hZYuBX8wqFQqW3-0Uw5RkexA>
    <xmx:ZxdrahgCf_Im2TFxBofbys1tlBfEzZaO6baD3zxIhS8W0dNsShIYbXQJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 05:20:38 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/11] doc: interpret-trailers: explain key format
Date: Thu, 30 Jul 2026 11:18:19 +0200
Message-ID: <V4_trailer_key_format.ae8@msgid.xyz>
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

A trailer key must consist of ASCII alphanumeric characters and
hyphens *only*. Let’s document it explicitly instead of relying on
readers being conservative and only basing their trailer keys on the
documentation examples.[1]

The previous commit provided us with an appropriate paragraph to
describe the key format.

† 1: Technically they would then miss out on using digits in them since
     all of the example keys just use letters and hyphens

Reported-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • PS: Reported in https://lore.kernel.org/git/CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com/
    • Remove the “paint by numbers” reference after review (unclear)
    • Add apropos footnote
    • Tweak the paragraph about how we now have a context to describe
      this format
    v1: [had a note about code spelunking (isalnum(3))]

 Documentation/git-interpret-trailers.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 109059f11ed..fb503cbe952 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -18,7 +18,8 @@ Add or parse trailer metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
 
 A _trailer_ in its simplest form is a key-value pair with a colon as a
-separator. A _trailer block_ consists of one or more trailers. The
+separator. The _key_ consists of ASCII alphanumeric characters and
+hyphens (`-`). A _trailer block_ consists of one or more trailers. The
 trailer block needs to be preceded by a blank line, where a _blank line_
 is either an empty or a whitespace-only line. For example, in the
 following commit message
-- 
2.54.0.22.g9e26862b904

