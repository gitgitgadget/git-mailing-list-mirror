Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14A6FC5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997252; cv=none; b=qngwmTd7HUJv9OTZjcEvx6QKLCjvkum2BRvTnPQg1x0BevuPwSnWjhqiPsEsOHBhyByGVTwWv2xS0Uw7Dim2DGj2mkxF+dGJwAIcoiZ/B9WeTNovhP4RetVhyeK+JA+A7A9nQL95ubWQOdzw81HZIuSxxdMpN8kqkX0VCfU+W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997252; c=relaxed/simple;
	bh=w6gXWHHk7Mm2OJlCEnAacOF8l4szFjA+4xcTVJCc4x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egH9mdmG0nJjS6smSXDNkDwFmxdFtGp7HdnUUN9SeHSwFf/Il7bs82Q/1Yfp84FC1KiHXQEi4xKvUjmJFWqX4H/+CdtCMQjl7dDhj2jP61yYE6Vc5/1/xDG4rSkxUPqhwO0BLCOJDxzUYSLaNYoOKcABteIdQjWTPTVpRKG8ZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OBhn68BW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CmigqOlv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OBhn68BW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CmigqOlv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 816257A0122;
	Thu,  6 Aug 2026 02:20:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 02:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785997249;
	 x=1786083649; bh=w2SGFr2ar5YJCxx1RmdXMEw2mn3F8CczsHPZPYuWPgc=; b=
	OBhn68BWwhB+FX2nSGjrHXE9jYFgf8I9DzgD3oxmn25uIEw9Rfd2R+k3YpsYe2+S
	rXZ4TL85joWH7YpwN3+tfUG5iZ7oR/h2uVoiErchqsgYMn0Cgrm6QaL/o0WhBjdX
	75KP7gfssqkx0K8F7KO5bVxWgudGL5EciyrtowabFM36M0cqRMXJwqFPbnqmVYao
	6/8/7C5XDPhJ5m7A185FO0ZFvE0t5vmBJICoLnNakJUdQSZ84vF3YAJU0rZ4Z9KX
	cuu1HyTHbdvD2ZAZlDwfsQiMop5egeJ6nyirrQQRFyzAxNUc7hNwvURfI/RKpy4x
	1OGYSLv7+STQhE6DgsTjiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785997249; x=
	1786083649; bh=w2SGFr2ar5YJCxx1RmdXMEw2mn3F8CczsHPZPYuWPgc=; b=C
	migqOlvKqoSpGS0qT9x3q+RJOSXYTZWycCvO2zWdWxw1if9JlXTgN3FhtUoOwTjx
	YNtN4EeWktGqSpfYpz0pyaRT8iO+xvfmm4IFKsdVkaqbfLj827eJHQlSWXV8QAdU
	lLWAr2VyvaUdHmBZ0urjfeo1IORyPRdgasi1dUuGfS2hye4saqH2yBLPpixXhn7N
	gBaOlkMX4QMBIlL4r6gmd0HE2BJk0mwE/Mld5UnyG1D+XowAztwWGXL3NxNWvHag
	Dw0ms+FtEwv7eNB4AQnz+EkO23cafQ42VRwCAtXLGICd6WpNHoVyY8hp+p5vo9B/
	DSH+DHJgQLdjjnQAjKTBg==
X-ME-Sender: <xms:wSd0aomR_HYLL6iJD-CfDLFidyDeRV6-bZvEWHnLElhRd6ybOuCMQkY>
    <xme:wSd0auvzw6cZOqv2k1_qBOD5uNZ62igjv7FVrp5Jnxjl1fzKKrXQL3461NQst3XxU
    bF-G_3yK8ZN5aDH7J6a4Q8GCm6Kw_VHZddOF0s1MQclLzvjpfReKJQ>
X-ME-Received: <xmr:wSd0au-PSsUmu8b2-7Rczp9rSnRQNzyl6W5R4nlNtmeW9zueOH0WLNqYWnGTpv8Vk5AIVC8HRbjT8a9fUP-sX08VEfVtb4UsuoDMzjc>
X-ME-Proxy-Cause: dmFkZTF7opqThSzJJIz/EpKNfuB085fd4M1mlOTNISiTx7j1F2foq4or9eip76oggg7LtA
    Agkm1f0l4Rrc5+oNq84yhL7xAAIStLV7UawSt4beiuT+P/stYY+OX4N70Vkfy0UL+lvZT1
    oD1vNZjsUzXtxNmrLwrXu9U5HIVtuur+8r99kxfv5ENDUVOF/bhEEr3FJYJrSebNnPq8Zr
    Fayi0Fo8wlf1QHts0QaR33F+G4o18smJiwR+sc8Uk8j1fs399srs9RdiG+l0DpHDFGUA4+
    O7RZ6LU3rT3o5y2nyZS6/3r/zGEdqC0rTaP2YXjPVEKWR/m1xwjzwnN7+bEsl5ZjtpCrXE
    NT9ykNho5Ipdi4nn93NWaSVeLa+ilyEKRJNj55d28PXjiNTs3sG0nYfTWV//50bwTf0C5+
    p1G1BNZCsk/ja0JwU1f/CMD8EY4PjA+Tk8nc+XhoJeRvdvtzeFDPAaG5YDwQayLb/NAlrh
    k9CgdqLqJFdj30Bre64IAbs5yI9pYF4flafPxf39ltFNPVtQDdiip22Aij1pJ/6elHk9oX
    wMSdVvqFHUkOVbBQEuTyp7YeBgQ3OrZw5y6EhRzoxCMwb0ESxIA6Gben1rtVMwyusk2/h5
    za+CbwTF6buASP2lxMUDqeRY9jAjLkC19NwbR2C/aAJK4UfSWvO/D03n8RBg
X-ME-Proxy: <xmx:wSd0agMtBXabYsPQ5J9bLf8DZEo8p9L-wkrP35netDV8i3D_HSWe1Q>
    <xmx:wSd0akGZfjSrCQThfFkNwOCwQCHxQCyW8DogFXHcsNkObYCA_7XPTw>
    <xmx:wSd0amQAgMH4gBp72h67sKe_exahBgcncVXl9T-xHqsiyV_IcyGZkw>
    <xmx:wSd0aptKQ8522WRpNm5TUiZSbnskd7HYdLk1RKWIJFKdPInytOgwyA>
    <xmx:wSd0avfQmYVbWEd6cA2aD8nwCuL_yzPL4hNwkZ8DP86SdGLCsSmvJe5M>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:20:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] doc: refs: put ref migration warning under the command
Date: Thu,  6 Aug 2026 08:20:20 +0200
Message-ID: <V3_CV_git_ref_migration_warning.b23@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_git_ref_migration_warning.b09@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): doc-refs-migrate-limitations

Topic summary: Put ref migration warning as an admonition under the command
so that it is visible.

That’s the first patch. The second patch adds a missing `linkgit` since it
touches that same warning text.

I have two other patches that are not included here. They are unrelated
cleanups that I will post later. Here are the commit subjects and the first
paragraph so that you can see what they are about:

• doc: refs: wrap standalone placeholders in underscores

  This is a synopsis manpage which means that standalone placeholders[1]
  are supposed to use underscores (_), not backticks (`).[2]
• doc: refs: use inline-verbatim throughout

  Use inline-verbatim backticks (`) for literal commands, options, and
  subcommands listed under the “Commands” section.

§ Cc list

The two people that I have the impression that have worked most on
this command.

§ Changes in v3

• Patch 1/2: Add Ack

§ Link to v2

https://lore.kernel.org/git/V2_CV_git_ref_migration_warning.b20@msgid.xyz/

[1/2] doc: refs: put ref migration warning under the command
[2/2] doc: refs: linkgit to git-maintenance(1)

 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Interdiff against v2:
Range-diff against v2:
1:  8a6415e2d9b ! 1:  3ea1680afc8 doc: refs: put ref migration warning under the command
    @@ Commit message
         description. A one-page man page. But that is not the case anymore
         now that the command has nine subcommands to describe.
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-refs.adoc ##
2:  801a3d7f539 = 2:  1d91be5762b doc: refs: linkgit to git-maintenance(1)

base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
2.54.0.22.g9e26862b904

