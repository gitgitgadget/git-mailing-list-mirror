Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B908247291
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667780; cv=none; b=ia2DwWZCd7tYpT7RC065iRXv3pnHtW4iz3VRIf46SHX8NPzRzoR8WEs0I+yCOUHG1Kdjy0UOKkPvmDYj3rbB8u2GxYMoELKBud6ThfDYSW/WDUbd+nP5GMyIMrQ+MQQ2tOuB+asgbBSpc46HtT6q8HS0LxwAkGK9XFRc3I45HqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667780; c=relaxed/simple;
	bh=CMsDlRfM5MYDRmT8OBrYO3a0sEPMTjFAyqIDNX0tTng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBvf/EbiYH/1P3oC7PP/tP1wnWdbyvg3Ek38fdPO9epxX6BJUCIwIh8rhfWySAYTT3LAtHAgN09N8AysOzglPmUBLSdBmg+i2NPxH13uXL9zjzlknhMhWmKpJdVvsubUWz68Qv9t1OCmIRMzzG/eqTW6Qk3fzx7dUVsGr2lVv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BzvlC+8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lA2Ho+qn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BzvlC+8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lA2Ho+qn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CD94BEC019C;
	Fri,  5 Jun 2026 09:56:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Jun 2026 09:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780667777;
	 x=1780754177; bh=67b6jDSR+5QqA5Q51VzG+0Yyc4jBq+tvy1UxMHWRuL4=; b=
	BzvlC+8X1qJwX6yc+0gCB2iHcZUFOwhM2cigU5NzC+Ml016JyGG11+Ih0+PpC08O
	Rew+92KL8seqkKHahZchkT9tWxYTE7tfKUGCkOaCddqHPyNETRmnkQ6qlrJ1PVrY
	Cyb1n4XPiKefUnimpP7WWIIn1/op7SKqVsZjiXKxvWqc1hMOfLYvzLcwBI4oQ7rr
	6EN3ZZYYJCqMKJMhrkaRGpyD5vsFnTTt5SFYdfT4f/7kbc8/ArZbtwCol+LtHoiy
	zZZf2OKb1iaAiIl1HHk8P87stghdmpdofEAq83MxfmKiUlyCal9ER0tkwEXJb750
	nsRQPjMU83uQXGAC706OLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780667777; x=
	1780754177; bh=67b6jDSR+5QqA5Q51VzG+0Yyc4jBq+tvy1UxMHWRuL4=; b=l
	A2Ho+qnXfmjchz5PLPtID6qzUyDk1N+FBfkO39hO93XRQjns7qXOhpeI8vSCCcyk
	aUNxzEM/sSUnGf4pnC8CLA0K18qDHNMMJHXnBvCP8Tt2zvLZnRFl3g5jZJr+Z2Li
	FRtZIWAGpFvvN33JPyc8sLuvxJrCLVXGFWEJpnD9eKLFa2etiQiYMhNi6WVCpOYj
	+PnupAN5G9qy3xJQ7F0MWzDH7O8IDmKBkGsjA4WM2Qi0m+99Nob+Cu30NHga/1ja
	R1ojS94m9M6ky8Tgf8yRIDgGkdA/E9jmLN0NRdPN1VskD/uTaA4GC4lW0UrjFf1/
	CaDR/Y52trb1u6JYOTVDQ==
X-ME-Sender: <xms:gdUiatbkghVbqmP9bEqWu5RAD5wQWp236PWmFKuVWjJ3atJ0B0qG8NY>
    <xme:gdUiarSZyGZixSSJ90H7dk6p_mUOvFHx5f99OkItRKGWv9NC6lunry17VmDRogVaJ
    ArNZOcXq-7IoYBqIftzDWVP8268ALPNH-w20wY-gMsc0W98pY7zIPI>
X-ME-Received: <xmr:gdUiaoS8g2r5s-Cj2iAcb_D6kGDQi_4W-ac7IzTNmjykUHvEeHxzWDaGBRun-hqUgWyNlE5YN7CHWH-jEyNAvvxrH9ZoDgYjw5YHqrA>
X-ME-Proxy-Cause: dmFkZTFFO6Fwf+zvyowHcCa9hlKykrG8dnYn1OYgVKNk09h7+7/dN4eI/0kKdWwB+piTls
    Ze7gRkM11mNG7ofTn1oVvlbqNq1mv7hSzCirHZIlccxBsHPrCVkOv+atS7j1BkFOV/QSF2
    qPGqL3SfRwa0Hp/Cta5AwGoi7AYvilT1LOBirloQfYBhVW3aIUD0WmIsl+thyB+lTQdPKp
    vzf9qZQOf1RdffMcpNZfIJcOVeGlh4ibmEv0RGlH3McwkL/T3Rb8XDsuMcUIw6+VQ7/tnq
    /MbNK0jGM/Tl52y5u5tdqpsNLmb7YZgGu0SZWL7t8y955Y6gigl+W70xynKBuqOLgcI+Gj
    24rffMWB5lpJuUbzFh9H8PSP56tI71lesMirZqESng0D/C30SEn8iSre5L6hzXYiThbWuh
    AiIfzJBQYQiChGHgF//Il7ddaHct8JwFCH2aa54d0bF+nYcmtgcjCpRyF44OEN8HoBvB8f
    ufMjXq0VPMICA/KZKunYB4p1iLNfLZk/cclPnYYXGCLeLErwQsHUTClTXyd9Y1UNe+ljHx
    Muq66uyEv3O2p4Wai4b4UtonKjscSOaHHvawNNBpSIIP4ET+URxD3xNInyrQTTKVNHA3Ys
    np/I8HmUi8bBFdh03KEXGjn+IR1oB+BQOLPQTZcF34dU7namobPvbjZ63Mrw
X-ME-Proxy: <xmx:gdUianQGx3wB5y7UzrV49EBaAsGtaXoSy_C9eQ00NRqTJn-vJ2sy0A>
    <xmx:gdUial60j7D-CG2lwWh-f21iM57DrhruKzQZULEBNwPTszHCfvnCqw>
    <xmx:gdUiar2Z4BcDSuTThH8V1wq6DSq2SmSxDPHn-sbGxPsRzpBt0XIzGA>
    <xmx:gdUiaoCLNuvscIiditgHS5cUyN9DTnNnRhkJ_xVIryGAtWBP-RxxTA>
    <xmx:gdUiaqiBjt3c3OCWbsTpnWjBcN4AHnBxozDtoBFVgITDlByue06psr7e>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:56:15 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] doc: replay: fix config link
Date: Fri,  5 Jun 2026 15:55:58 +0200
Message-ID: <V3_CV_doc_replay_config.780@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_doc_replay_config.767@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-replay-config

Topic summary: link to the config for git-replay(1) (one variable) in
git-replay(1) and git-config(1). Also improve the doc for that config
variable and `--ref-action`.

§ Changes in v3

Fix a commit message typo to “stylistically”. Also improve (IMO) the commit
messages a bit. See the notes on the patches for details.

§ Link to v2

https://lore.kernel.org/git/V2_CV_doc_replay_config.767@msgid.xyz/

[1/4] doc: link to config for git-replay(1)
[2/4] doc: replay: improve config description
[3/4] doc: replay: use a nested description list
[4/4] doc: replay: move “default” to the right-hand side

 Documentation/config.adoc        |  2 ++
 Documentation/config/replay.adoc | 19 +++++++++++++------
 Documentation/git-replay.adoc    | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 10 deletions(-)

Interdiff against v2:
Range-diff against v2:
1:  ef8212a076a = 1:  ef8212a076a doc: link to config for git-replay(1)
2:  b60e2e02826 ! 2:  35b44b922e5 doc: replay: improve config description
    @@ Metadata
      ## Commit message ##
         doc: replay: improve config description
     
    -    First of all, this bullet list for `--ref-action` introduces a term with
    -    a colon.  This is exactly what a description list is, structurally. Let’s
    -    be sylistically consistent and use the description list markup
    -    construct. Let’s also drop the harmless but unneeded indentation.
    +    First of all, this unordered list for `replay.refAction` introduces
    +    a term with a colon. This is exactly what a description list is,
    +    structurally. Let’s be stylistically consistent and use the desc.
    +    list markup construct. Let’s also drop the harmless but unneeded
    +    indentation.
    +
    +    We can reuse the `::` delimiter since we use an open block.
    +    But for consistency use the typical nested description list
    +    delimiter, namely `;;`.
     
         Second, let’s replace the inline-verbatim `git replay` with a link
         to git-replay(1), since we are naming the command. But make that
3:  d13cd39cb36 ! 3:  12c73641fb9 doc: replay: use a nested description list
    @@ Commit message
     
         This bullet list for `--ref-action` introduces a term with a colon.
         This is exactly what a description list is, structurally. Let’s be
    -    sylistically consistent and use the desc. list markup construct.[1]
    +    stylistically consistent and use the desc. list markup construct.
     
    -    We can reuse the `::` delimiter since we use an open block.
    -    But for consistency use the typical nested description list
    -    delimiter, namely `;;`.
    -
    -    Also drop the harmless but unneeded indentation.
    -
    -    † 1: Same explanation as in the previous commit
    +    In short, just transform this unordered list in the same way that we
    +    did for `replay.refAction` in the previous commit.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
4:  17804ea7afa = 4:  e2191c723fc doc: replay: move “default” to the right-hand side

base-commit: a89346e34a937f001e5d397ee62224e3e9852040
-- 
2.54.0.22.g9e26862b904

