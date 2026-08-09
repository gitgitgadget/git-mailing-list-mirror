Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864323AA4E9
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306057; cv=none; b=ECx4eWET1MhB8vdencleGjGQa1gQsI/hF+LMZRfSSrzZmytcRRH23asR8AWfl7fkPTVZSdvj1Pc4zQoGH0XLBZd8htp1Sn86TDkMltNKp+e0NIYfsWLUDF7nzr66gnzFBZjYtLJ4DI12SveJAgghmyVIqA1Sqr0dJ8AYaimdrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306057; c=relaxed/simple;
	bh=2uj+1JB4BZEj7YRvVo97J8CW9nPYews4mnOKrN88/pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+LzTEvJ3lry8GIhAAnlyaFBPQ//uCV+yO6Oivju0DUuI2TJo1Us1sc8+WM9MImVfgbfGdKer6sqjNpyEvUY2ApdLVjRNTK0ufh3O+bM1Dx8M+CA4onoewP4eE9dDfOBUS6KfjZ7P1/9y2nPJGS02XVL711ytzw9qGrBpZGeTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hmt/h65z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AgXWIrgN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hmt/h65z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AgXWIrgN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A04401D00028;
	Sun,  9 Aug 2026 16:07:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 16:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786306054;
	 x=1786392454; bh=gnokYJhCVimqj9uTNikP6w3BG7bzTl75e5tggUvlJ6U=; b=
	Hmt/h65z368mNM++dGcFB1p93IAd+MAcgybFo8cX3WgBgAQ+zZ8YHPazSoQIrr+T
	CgUroSrKTwlND/GgASJMGpmBf3+UnBb7AZVRX5uo5Kfx1+50iLU6xDpbrQGi23ca
	vSLTF9HjR5tYqw5XEP9x8XbLQMotrJzZip2S9h/XKt3BH7WKlrf2RUR/0blDZwBg
	GzDeW+6eDExV4+v5GS6JgsVcfpWn5dsBMpMnJvrq3KdmzndqEyPB7StCGtpkR1te
	p8IjxNAtfbbZTQCOfBkVgqWKIuEg4Qyl1qx0X4PmKL0a8oSmrhLgBbTV/U8FGY9a
	hhMQiRfpEcEIIX7xXFFmCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786306054; x=
	1786392454; bh=gnokYJhCVimqj9uTNikP6w3BG7bzTl75e5tggUvlJ6U=; b=A
	gXWIrgNYaTqH3gKl+XICxowO5dezcetE1fKjawAkPyZ20EG8PQNZS1SHWfyDPDLL
	1k88vFRR7N2R7caTmX83Mywd9CoVqvyT8rrkIBfEpvrX7urxjOXH1wV+KEufsCNK
	9bxvjfNflHJJNM41/Lks8SAahTKhzVGe5pntesv2qBu+j6O7PeitvrfFeLkjIWOe
	dUjmLAdNne8clGRy+uYN8SVFJnhqYqnoDQ2NPadbgVt4epBTzUV5T7WVphkNSM0D
	BINRrRzUlJOtwFx6L+NUx44pqKfa4qNevSmjR38jji1VsiSkmP0Fm5DYf+y6QsD+
	Bk49mD6yGZihckhzKJvOg==
X-ME-Sender: <xms:Bt54au5zPHbr-nq67gb7q0U2AuCuA9MtsHl5DIl6oj_Ssu8Y8kvAXaY>
    <xme:Bt54am8rtnnPsuylc1ZJ05-uFjDwPqzsqBZbgQSQcB1YSnByn4QCIl-WVGJ2meazJ
    fIhZVKBZtwOx7bWl4LBO98_uWw0DcXRO_Ku6NsIcdm75wDdcn_E8w>
X-ME-Received: <xmr:Bt54ajr2dl1rOzXz2kCSTRX1iVg5pExzvKCkFmufX40D7hpwm6zuPOXCFq2cDHrys5xFS5BSMPNf-pJ_yP9Rz-zg-5NXzZL4DS7hCLQtwcGLe2U5FxcI7UU>
X-ME-Proxy-Cause: dmFkZTFeqnCslSnr8i5H1YvUsi9MS94aL9oIV8h94CFICeyCkTImgemHOtBmEDLdj4YL6M
    QmfCTYL6YrLhJb/lwW2VC0HrakoWakpWCNE9jFvC+66OlHI19tlK2BZcsyGpjAN3z99T2z
    Be5tJHOKdcV2bO7t91dl6gt9zYDKcCx3eU2iKl3UTikYbFrgIrhmIiuT1CBlgR+3Q9K1YQ
    AnbZHKwswfFWQ4fkEWEeu/Fi9ouMoh67ghpAerMDcnua3v1e7DV9x5J0oUgV8rWCUM9s81
    zOtn96KWnhm/S/REuw8JBDEdSkVCFGkDHfGjLR07DJ6mZf+9i3Vu/hjFDuK6y1z29DPMGP
    X/zM4dFcNilvc+iwNcVVb72Pe8XO2Rp0nd6J7eXjjcgKwQ1euCb4jp3h3yJYoAaDDQfmWB
    FNfuqDEWHAKK6XWnxJavJYc6Qxc+UN1aLHDUhGhUnpZcpLFyQQtMBkrlIHB3emCaiOa8mS
    SB7f35ATSopn92osWvO2YU6HVhTMqg34C8F5p01gsuJMGBjApm0600jK+3k8lZjgtc7ToG
    A7bhr6jwXKnQS4Y4bUV6RRAy7hrY+le/gCJyC4nfkVB22+eEMFAwQL0jKpiYyTk35NuA0C
    BfRwzBKxXn6XrI0WkCgccMLyMJ1L5XtwVcaNWFUDZ5niL6/dbjjRtBewa/vw
X-ME-Proxy: <xmx:Bt54anoQQGumviq5_3TwTAmg-AGiEouE2xfic8qCy1UKKl7UIcErrg>
    <xmx:Bt54am0uy11-PsnkapxL9lXGgShkdWrSBsE__cCUfkMdcFJ7NvyPeA>
    <xmx:Bt54alGwbK6q_5JHW5NNFA47hjppxX7Q5ouAh3De1sjYt-RYmJHfnQ>
    <xmx:Bt54ahEpHzY6wh8PtMPF_kdr4Dmk6yZx8nzJuLFRawQc-t233FfR4Q>
    <xmx:Bt54anWxiqBdKBfnCx-asaqQUSJu1TB_IbHxSf6D2mykxnz9qV7xZLlA>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 16:07:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	Brendan Jackman <bhenryj0117@gmail.com>,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Matt Hunter <m@lfurio.us>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 01/11] doc: interpret-trailers: stop fixating on RFC 822
Date: Sun,  9 Aug 2026 22:06:25 +0200
Message-ID: <V5_less_RFC_822_focus.b27@msgid.xyz>
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

This command handles the trailer metadata format. But the command
isn’t introduced as such; it is instead introduced by stating that
these trailer lines look similar to RFC 822 email headers.

This is overwrought; most people do not deal directly with email
headers, and certainly not email RFCs.

Trailers are just key–value pairs that, like email headers, use colon
as the separator. The format in its simplest form is easy to describe
directly without comparing it to anything else; we will do that in the
upcoming commit “explain the format after the intro”.

For now, let’s:

• remove the first mention of email headers;
• keep the second, innocuous comparison with email line folding in the
  middle; and
• remove the now-unneeded disclaimer that trailers do not share many of
  the features of RFC 822 email headers—there is no invitation to
  speculate that trailers would follow any other email format rules
  since we do not compare them directly any more.

***

Talking about trailers as an RFC 822/2822-like format seems to go back
to the `--fixes`/`Fixes:` trailer topic,[1] the thread that precipitated
this command and in turn the first trailer support in git(1) beyond
adding s-o-b lines.

† 1: https://lore.kernel.org/all/20131027071407.GA11683@leaf/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v4:
    • Msg: s/trailers metadata/trailer metadata/ (knock-on effect from
      change in the *next* commit)
    
    ---
    
    v2:
    • Use `***` as a thematic break instead of `❦`
    • Change to “metadata” instead of “key–value pairs” since this series
      version adds a paragraph after this one where we dig into this
      term. And “metadata” describes the purpose of this format.

 Documentation/git-interpret-trailers.adoc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..1878848ad2a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse _trailer_ lines at the end of the otherwise
+free-form part of a commit message. For example, in the following commit
+message
 
 ------------------------------------------------
 subject
@@ -107,9 +107,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

