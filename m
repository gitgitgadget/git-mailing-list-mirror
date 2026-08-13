Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E62337BB8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631075; cv=none; b=UE4Ynpkdzf6pn9M7Bv9CJ3fXcHSfmRBbAOZWd6RtNewIEHTtR7hpVTI3pg2wTPi2CNODMcYKKbS6jCg8WjzjO9TmSUZuRkBJhd1ku4oFvMmA5n9d3oEy77tg9Ew4G/AIxZ/VcIXPREw0fpAl6gvEE/CZpqnnqCPikkJbkzy2xjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631075; c=relaxed/simple;
	bh=K/AIQCv5AjKXlaIBLwr1c6hyn665b6jTcJJvK1nEgvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGFW13CLILwCzSPj1I/HNTgXfJISkRE6fVNhf1n9DM+7pM0xdCsmxpk1/ma7pYN41bbPOoubIZKdFy74ZVXyzRI6Iqa+BxiVhKbHLHrLlkPyG+WHjT4WK1PBM/vAf5tSYJWaite0llRe4uaXhBFSxHvCfP0ApWS8kE1KNUpHAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=k/IOxOsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6Z+7wMb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="k/IOxOsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6Z+7wMb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B53C8EC0285;
	Thu, 13 Aug 2026 10:24:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Aug 2026 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786631073;
	 x=1786717473; bh=lrFq1XGMuungupOT27TjdfRFwGbEEXLb18tvYso+E00=; b=
	k/IOxOsXSpTBwQqvWd5G+CDqp39pJ+J2LLBi2pJC8aPZIVBGLqYTftAHROubQQy9
	imo77qV43c1xN/JkKOwEBaFKj0isewUxccPpYQUx8HxZJz2U8chR4SdjV1B3r0Wr
	Tw+TM7/LyQfie1rw/NixmOLOe/pTgsNEVR4KwbKm4XswgZ/hC5dWXIsblKlKMke5
	iYzIZVuIuWcDUs8dZ0DzlgcbyEph7reWRiU61D2lANV6gi9qsN5TOzttbdp8MM0t
	c59yRna04Pc/8UqrXyH/y7Vt6aYvH5t+buPgTEYUba8B/yKyCVryVDaqDMQXeHup
	9d9ohchd8I4gs4CaqlfkCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786631073; x=
	1786717473; bh=lrFq1XGMuungupOT27TjdfRFwGbEEXLb18tvYso+E00=; b=c
	6Z+7wMbe13h7C3u08xWd/HIQwF+EsB//QDrKyhE3ZwDd3wRpktDydUPVAAflZp+e
	VG774w/jtzYi24bpwxO/CUG/3ajb+Qy942omW4a40ujQc6uplXQ/mWKx+UHIQxnJ
	+afQX9ZqInK3swF9Rdiw+AHhNqia/WG7G36Nq4L3C6pvud5nFH/8Pt+mb0RIZyGs
	QTHGQCPUnVkyszg5KyQ4QycChbY6nwDCK04ymb0FQw8zxL+jXCzNhNP4aRKcpNRX
	QdlPbO/qyWE7sW1LYhmM1QOcORgm8ojqxptzhVn8V6wL8PefSRMccfdrgHRK2GxI
	J69bjORxNShb+MMSVXIxw==
X-ME-Sender: <xms:odN9anNHQ2HLqa3MYUjSPvPJvp9JX0SmP0u-gZPB6tXBu4Hxnbx7UdE>
    <xme:odN9ao9-CddIqz079OISySJFeQNeP457F8R168BEIP5sJLGvjI4kZcgDKtbeMmSwj
    NyiA_jVg0LfFBggpYcZFE_Ip3OfR2phMOkvXTMPabDMqOHdBCUH5AA>
X-ME-Received: <xmr:odN9arRqfTJoZk56LB_av5HalEmV4qiczqASB8HvWPuAxcJfnfT-38XsWszmfLrIBFmXVxOZUy-VKwY-LkXRrEjPjfrR4npIuRlxEjw5oGN4b1m7gQ>
X-ME-Proxy-Cause: dmFkZTFxb1vDiiJVsTxnnMT4JeGcT/LTxcqf8saTTK6TYmFccLeAmYAmRs0RussylGrhnB
    36JBcgASYCkSo4Bq/Lbuu74bBPXnQXxO3Ms/lHylOTqWPH/efLScHqQgRi02xPtLXGcm2r
    L8cuY3gWrZvENzK/sOUTAtqh9ZMlkvwUUh7QXovYRGviqArfwkI6AQ8wju8bvbAvBZHA6A
    FU8j67iSVsadOF0dP7UlVJ7UhaGwFbdDYaWNkX5f50G3U7Bu5BTHYbb5XKby8JN0z1W0Wf
    RpilK3uDTdSPsolufTqrnxhC1MrZ62yaqsP3ifAHt7hWUszsZcfMqi681ogiGA0ZZUW3JR
    uNlCg/XU99SB5twRWPP+KYknCQ2xKMIRPBrptUdmsI2tx73hG7CiV4q/Fmj7vgG13LMF4G
    le/bh5jcwygbp3+pUweMhDGSJyNLhtoXc2YtpMjPGbTY6HN/qOFwLbbXbq8DMNMVYdnzdJ
    KnkwBWcci2tFm7qCT3y9u+SyJa8mq982jMayy1UXoG6F1M3lrylcoXg/HSsuj4Y5NHcl9I
    YVKyrioVtU13duj/weD/A8UhrNpydIA+eEk4B4JNFZPK9fOZwVIk34eqyc1IVQmxBg4rpH
    ShcTccdH1e6mqiRdTllEGUjd/7FLSK+Vn6BkciU6RpqzNNmrsi8Xxl1p0+zQ
X-ME-Proxy: <xmx:odN9aqk0VHyHWINzzLWShcG9_K5-l0dKJumifSdRY7miVkc1l3h_jg>
    <xmx:odN9arR3N17ilvQYNuUQc6FH2eYNzFiJUKE3z-sBlC5E_dZEVBvqzw>
    <xmx:odN9aoP9r7MDvkNuVbLQ0VEl8_WRPYdTeQ1uX7HCy_0I5hl3tKwXdw>
    <xmx:odN9akW2YXYqc7swE1ahCzQC2e8w5lo-h7gdhZdE7ENvhi9sfo0oFA>
    <xmx:odN9asMgI5c5bXbHGoldBuVHDdM3hqqLq__u-BOb_rVeqljtpucg-gts>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 10:24:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 2/2] doc: format-rev: use [synopsis] on code block
Date: Thu, 13 Aug 2026 16:23:46 +0200
Message-ID: <V3_synopsis_block.b66@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_synopsis_block.b64@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V3_CV_synopsis_block.b64@msgid.xyz>
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

Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
docs like this one, be immediately preceded by `[synopsis]`, just like
the command synopsis is:

    [synopsis]
    (EXPERIMENTAL!) git format-rev - [...]

Cf. verse-style:

    [verse]
    'git name-rev' [...]

Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3: add Ack: https://lore.kernel.org/git/an2Wwe4ytilGoyHz@pks.im/
    v2:
    • Add a paragraph to contrast synopsis code blocks with synopsis
      command description after talk with Patrick on v1[1]
    
      🔗 1: https://lore.kernel.org/git/ansWZxZ6lB0tYIJD@pks.im/

 Documentation/git-format-rev.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 19241837345..d6c2e4aec1a 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
 formatted commit, i.e. the format `"%s"` would transform some commit
 object name to `"<subject>"` without any termination. Like this:
 
+[synopsis]
 ----
 Did we not fix this in "<subject>"?
 ----
-- 
2.54.0.22.g9e26862b904

