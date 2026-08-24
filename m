Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77026159E
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603765; cv=none; b=tmnWUX3ov/oJTY6npO5hfXxedvIjxBVTodhMFaNNOA4ivz0y8h6TyYpZ4pybX9Qnt06Th3OjLJgHmn05lcWCeTalMMg1105jq7x+Ts6pmvf3q/eRdw+xnsm8VIvvk9apbq/TrS49W3CJmMadV64qFclRQDgJCQwODeQnPGENMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603765; c=relaxed/simple;
	bh=hJv/0arHWDrHluxOqTsc3CZLIVcrB5YIUVc60CtW64M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdy4DUoXknrPadoNy+vmD7jtR+Yb1rhcSUyrKEEnBB+s6qYJIxZUG8a+WEJoNRlQoWoWSxeuBjbbcuFNj7U/GmS+LgTBTWr+iKcNEdxsswADv/RuDLEQi+kfTApM4GcZBVAXorF8Mac90q4rmGTGQJLwfmpeP9IdHHryoyeUUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E6GalL5A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hUSE4Y8Y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E6GalL5A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hUSE4Y8Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 983257A00CB;
	Mon, 24 Aug 2026 16:36:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 24 Aug 2026 16:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1787603762; x=1787690162; bh=Mx
	eC17EXcjk2ragbWN45cWoBcnEkD3DamUqzdtEuPGI=; b=E6GalL5A13KEofeliJ
	e8YuiLVR+zvWEOYNhuoQTIaB7UyLlBu60bmkQJucHQhcITn9B+EcS2W8Qr9LNX+l
	M30rU7A87l//yX9iS1Fdw+QfcV8+5yw2EmsspVrHO4UvYL+Dibz1KbFwp9glnd+/
	1yFYqGXqIzN+ErTR5Yhp7fKpXNkjnmu2sgdmupq78ZXd4Ib96Cox/KoSKFQg41rE
	OnR4toj7bJTNf5vNcbmM/QP7wljprRoNzlpBdiqE82vOSaEjCtMlmLYzpM8Yhmnl
	/6V/UUh9+zW+Po1vx99io1HksZssPUbtCjkR/nOuxOxRleUzLR+BWFF551GZFvwz
	EZbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787603762; x=1787690162; bh=MxeC17EXcjk2ragbWN45cWoBcnEk
	D3DamUqzdtEuPGI=; b=hUSE4Y8YyQaW41n9Oxkir1cDRBC+tP0Fu9EOdI44tWvB
	aVP84UCFALlIcuBZsqsW3qclLjwhVzjcRJUk2fyq3wnQPklrw0xLpSXEaYsyIDzI
	xKPEJTycrvLnnIY4IxrLOuyvZBpRUcEzG2k9p3DziyXhU3m/gIi/18nxaFtmb1Y3
	c7uM7Z6GJwP0EGv8HSdeYbzohmy+YbPDzkHcpNodjn78o6+0nQFQYudUce1d4rjo
	27dg1qD0KTvSHOw7ZHYtGTdxC2SmaO0DgcCfxmqyJJU2lQe/vxaWpIgK+uUYvSfQ
	ErC1GfSGo+VlhKIZ1DEGsVO8pViHOZbz167m0y4/bQ==
X-ME-Sender: <xms:MquMarQN4XHcq9ttN2LbtwLb_bq26fSlDY6E_tENcPolJSmNM6QXr_Y>
    <xme:MquMaiwtpkEuNNm8qL92Z2VtnCm_fhVePhh0v8T5i8jIQSq4IeBn-0aeE2IwcO6Ny
    -3VnoARCPKRtHbOzEIDZtuWYIUgJuXo9nKiUHlylO2E-GfRLlFy4g>
X-ME-Received: <xmr:MquMaue5L0FP9zNSsOxF_JTkNanVsVNbkM3DoIk_wnsVZMGy9R_xoMJN0yc1FKGXM5KxoJywF3gqfH97bGAV5LvVQQvxzBLSQaCRQGBgKY8GqyVOIuILRAky8A>
X-ME-Proxy-Cause: dmFkZTGQ80zzx7a+S6Ga7A6aWJ2c2WKgqYT90MUGAnbpUe3jtYvVd7gv1Xv7g318PiL1Yz
    IQq7hhbTu5fexbGVkJmHFH84pF3mPvD5KNwj3M6fcmM9gAdBDAcUOPoi2PJ+iJb7kKfSD+
    IaHGnNJkYAZsqgEviWpN8H/YLzHPNBHJJqj8J0kpN+iCmRL5FasMpCLEWrvSzhPl+2asZW
    xIFY5JqVcKFp8JdVcO5TjMZ/lNV61WXcO/KGr6wLD5/hwxWj6GjOPxwwir4XqhL44fGWWg
    NE3E4nrttR7H3MWZpjCX1Wxq3KtBr2fq4NkFbNg/t0CzJfU8t53b4RwZuDjNK6BSh6X9dw
    RJpd+10rZ/xG1PLoJsDt6KCB6HnGq9Op9mdrfpvSZejAVbeNTp3YlR5Szk0nPIQQ8hLWAl
    34jTUDG9/dc8VOOn44l6ThnUvITw2otdb44YOWLjTHQXWLVEEwvK2M4UpOCX/Qg2lzKlGk
    ONexOWUVZMR1IOQ+ofxklZigp8hGVDA3C68ezQi8i8Ean4zt3ixpFZ/a1V1ghwyypL1yBJ
    o1F6YRXdSsTWwGOGM38V54uHZZE2DqmJOr9he79dgUjXnrk0t66J+I+jbcfubP7c+IFvIF
    OWMHV1Ac8U9y6Hj35CvEyTDmVTWQHHV1IgkDMInumkiKdM9xfmTmw9VQnokQ
X-ME-Proxy: <xmx:MquMamL6JX0p8Pt9Yrl3nn5Lia9t5MbhYmstH4sXX6xioNO6VoSjmg>
    <xmx:MquManElPiC9FOfLW2PROwPZnc6927dnLbOK1Pl1DMv3bNyTu-KGEA>
    <xmx:MquMaopi3a8Xp8nTaHPIXDU1JDUF-nk-VgQnsXqs0jw35RQs8dlYaA>
    <xmx:MquMaoSjlyYmzEVsyWlueu8YsrijlARI58deW_2MvOqN2nThg8JO5w>
    <xmx:MquMauoFc1XC7cb1q703zoGPW4wekqYp9zHzRwfPqMFXgOYTuERwR_qH>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 16:36:01 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/3] format-patch: learn --[no-]range-diff-notes
Date: Mon, 24 Aug 2026 22:35:41 +0200
Message-ID: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/format-patch-range-diff-notes

Topic summary: Teach 'format-patch' options to tweak notes output in the
range diff independent of what notes are output in the patches.

See patch 3/3 for details.

This is motivated by wanting to turn off range diff notes, but the goal
here is to implement it in full generality.

(How many of us `git format-patch --notes` users are there out there? More
than a dozen?)

I have implemented this behavior for myself and used it for many
months. But that was hacky and only suitable for one person’s use.
So this is a completely new implementation. In other words: this is
new code, *not* tested for months.

§ CI

https://github.com/LemmingAvalanche/git/actions/runs/32762207178

I seem to have finally learned now that I ought to push to my public Git
tree for CI, not my private one. The latter seems to consistently give me
“insufficient funds” errors. But I don’t know.

[1/3] format-patch: simplify get_notes_arg parameters
[2/3] revision.h: rename struct member to reflect notes role
[3/3] format-patch: learn --[no-]range-diff-notes

 Documentation/git-format-patch.adoc |  17 +++++
 builtin/log.c                       |  21 +++---
 log-tree.c                          |   2 +-
 revision.c                          |  13 ++++
 revision.h                          |   9 ++-
 t/t3206-range-diff.sh               | 105 ++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 11 deletions(-)


base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.13.g85d2d65e389

