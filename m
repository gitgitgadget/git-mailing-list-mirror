Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CC36197C
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484787; cv=none; b=XjGgnIs7PR/z7tqCgA+YGiPTevbWYD6ZNQj7oe52pCb91/ZY0A0Jwx4+WfSNxFtBqSJknEhCJv2nl0iUVHhTxs8YClXmyFuhstnhCvwhg9mYORLC1PFt2zt2JioCwz17q3HFNCwEfVCJUXEFOGuc3TTE5uUo3Z2aK61i82Yirq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484787; c=relaxed/simple;
	bh=9Nxjag3YpcHTUZBnwYrdbJUv0ZBr5AwzsGiPXDkb7+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEOiZpAPClshADyNfNbBrjeFcofDCNvp95zXQknkpgu0E6kPK2Q2szX1jhwOa4ZJK1PqQVbIShGHczR+XJTL9y/t5ebFXNECd+gQEw8jxldjeGUZEYnQCe5zKW28sZl4nYDOwPWU04sfRXS3FqkiEAI80U7yuLSoV0XWHrIHmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E4nLmLe+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvR+GWtn; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E4nLmLe+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvR+GWtn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61535EC00EF;
	Sun, 23 Aug 2026 07:33:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Aug 2026 07:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787484783;
	 x=1787571183; bh=zRjpv70nDplNnWm5axOLe/wg1EmwaYzyQaEtXmHw4yk=; b=
	E4nLmLe+U/03eiJqAMJ8PVZiLc8AAI8v872VEVyJJpoYE8kb9LOxmZH8yh7tkBMb
	LxTg/6tqMO0wvu061+HgAGyLQ7Q+7Wwv6ruohXrrV8gWGsOa1Mih5IOmbn2pU0Oz
	DiWa47OCH3sHCzXyeK1wibveow02C5SDU+mNCoa0NZMmvBJVYBiS53Lb5DVhAYUp
	pwTUWu0K204HA9e7Ux5hr1B1IjX0fOtPgn5NrerpV033f4asPZdBd0CczoOHhnDx
	GnVWwk+YECBpGudKd/aHADKfoz5+Pj+xNM8HxTTKJDOunUcZQNTLHN845ZDUyJXN
	+sLGBiXy8RGh34D2tWE4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787484783; x=
	1787571183; bh=zRjpv70nDplNnWm5axOLe/wg1EmwaYzyQaEtXmHw4yk=; b=H
	vR+GWtnr+vbIqKo4cvaAyWUq7Ul1G5wTGxwuxOUBvoozE9KeDPPASYilhFy6UnBu
	JIiZE6o1iyRoRAIuUV0o01Kx7YdZVKKkMWMLriAQtpDeo+jceFwZJuO0YMOrVUOr
	DDMkfpThGtMT7ituLQR2fiHwt4St3YXabWcpsLNUlwCvzs+98tR5MuB/CGEkHN5W
	2TQJ2ys25W9Cth6Vp81tl1XYODttmnkyM/Y30yZbcO2qBfo9p3VAnDzpRGc6xCet
	FMT0XfdfyxiO5ErUVhZksnb4UKBsJvaXFU0K8rvk9JvULLnI1ZS/LeT41cRhSyLH
	IDwfaMnLJq36j1M8BAeFA==
X-ME-Sender: <xms:b9qKak2Ig068_zVB-_L9j4_g_x2sEQkdV9c-feaj3fln4h8ZD1IJ00M>
    <xme:b9qKamH3oGpFqVMTIEuFLGX1M2HdCPma79lSfz8xTdFaXgMWFI9z47p_AF_eJoFBE
    E5ZBBWEHOk74_AGIF7gsXYfi7X9JbAhJzh6JZxiP29v_-hdjo1gjA>
X-ME-Received: <xmr:b9qKah6IIJ7zmZugo69CT_EGI43JnHTjF2vE8Rru6Jni0Ei97lcLem_QQHOojKtUKtMZ2oe8jGV1CEF-MDCY5GTLLvEr3LWp816JHqe0nkremnX5v0B0Ga8>
X-ME-Proxy-Cause: dmFkZTFfJ3LWw51gC+1cNjjS7elSyMDiWlFQmemF9lL0fYBM851lerZ4k4xRpiBSwH+R4W
    451qFezDmEOh/Q2iNE0YpVVEhLqcRZIYIMEfKUsMRYfLsN70n8MCVcKIIP5iNzo/OF9k8Z
    fpkSRYckclG3nWrEIc2nTsZmeGYZacUh/bilZPpsd7/5XNbDlC1z+gpc5B1AqV8g4FBKlh
    qtdJLaaDVn3Lbohj3KaFI2eEBTQAueJYOGHkEvYCEAMAPuP/aGoIJOsCSQlWi4r8M5SVdx
    kruf2sb1J7RaWe1iK1BrrMIOw8tEjP3YPCl0isvLjM8e5VHZGSZQCdPIVrWXokv2cacTJF
    ahj6SC3f5BjLCCYhOLU0HL3LDXpkjIgyYIUcKMw7M7pkPhhUEHBsqOe8Tw1iMxIO2OEldr
    u0vnUADt03uelkrTvNmRq6xzHeAHlOEPwiXtLzfJK+DACy1MZHBt1HWv1h14TPU8KOPJtw
    t4t6jSKkHVe1UeP20JRH0qowIkR4SM6FJw3c90iWfB9O1G1aK9P75MR6McF6gF11PDREK2
    eVmr7cBzgRR49wrqJtEdFi3/JGusOu1O9+KSrSsQdfRwE6L7aH/4VEmM9tTJe3vTsfMwW9
    jzDoTG28/6CLxPzDr3qVxYsMOH5yas6MuQ+1keVnFoJQa4VBxKizwf9HPt0A
X-ME-Proxy: <xmx:b9qKasv27ObwsLnmYslHoFn52wEd70dryUPb-ay0ePmM1Bc9gSpHIg>
    <xmx:b9qKai6sBHP5nNSDyGF6F7ZiByFk0H-2DuB34UwIqLuUF0qtODCYxQ>
    <xmx:b9qKanXxrBgyaEkwksflWkJe4M6w4BG3zikXWAfy3xpoDO-Rj9Zr6Q>
    <xmx:b9qKak8AWXjCVPGagR2oMFYdvSTDp5b0t346SyDRRdV7A32sGEd9QQ>
    <xmx:b9qKaohjqoYS6GVnl17MRwPFzG-pHnnvVgwcvLUV6qqM_Y_aBHN-gTsn>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 07:33:01 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 0/4] doc: advertize gitdatamodel(1)
Date: Sun, 23 Aug 2026 13:32:45 +0200
Message-ID: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_doc_datamodel_advertize.bea@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-datamodel

Topic summary: gitdatamodel(7) is not linked to from anywhere. Let’s
mention it on other documentation pages and add a link to the glossary on
the data model page.

§ Testing

Testing done on v1. No tests done for v2.

§ Changes in v2

Thanks to Patrick for reviewing the first round.

Correct commit messages for:

• Patch 1/4, “list gitdatamodel(7) as a concept guide”
• Patch 2/4, “link to the gitdatamodel(7) tutorial”

§ Link to v1

https://lore.kernel.org/git/CV_doc_datamodel_advertize.bea@msgid.xyz/

§ Aside about context lines in gitlossary(7)

Nothing to do with this topic, but I noticed this “..” in gitglossary(7):

| Different subhierarchies are used for different purposes. For example,
| the `refs/heads/` hierarchy is used to represent local branches whereas
| the `refs/tags/` hierarchy is used to represent local tags..

From 74b50a58 (Documentation/glossary: define root refs as refs,
2024-05-15) by Patrick. Is that intentional, like an ellipsis? In other
words listing heads, then tags, then using ellipsis to communicate “you
see the pattern here”.

[1/4] doc: git: list gitdatamodel(7) as a concept guide
[2/4] doc: git: link to the gitdatamodel(7) tutorial
[3/4] doc: glossary: link four of the terms to gitdatamodel(7)
[4/4] doc: datamodel: link to the glossary

 Documentation/git.adoc              | 12 ++++++++----
 Documentation/gitdatamodel.adoc     |  6 ++++++
 Documentation/gitglossary.adoc      |  1 +
 Documentation/glossary-content.adoc | 13 ++++++++++---
 command-list.txt                    |  1 +
 5 files changed, 26 insertions(+), 7 deletions(-)

Interdiff against v1:
Range-diff against v1:
1:  7fbff6b7d1f ! 1:  35832098717 doc: git: list gitdatamodel(7) as a concept guide
    @@ Commit message
     
         dee80940 (doc: add an explanation of Git's data model, 2025-11-12) added
         gitdatamodel(7), documenting Git’s data model. But it is not mentioned
    -    everywhere.
    +    anywhere.
     
         Let’s start by listing it under Guides in git(1) and with `git help
         --guides`.
2:  916e9f7d46f ! 2:  3d8c4334785 doc: git: link to the gitdatamodel(7) tutorial
    @@ Metadata
      ## Commit message ##
         doc: git: link to the gitdatamodel(7) tutorial
     
    -    The previous commit added the first mention of gitdatamodel(1) on
    -    another page, namely in git(1). But there are also other places where
    -    a mention is relevant.
    +    The previous commit added the first mention of gitdatamodel(7) here,
    +    under Guides. But there are also other sections where a mention is
    +    relevant.
     
         Let’s mention it:
     
    -    • under Description, since it as useful as the other tutorials already
    -      mentioned there for those who are interested;
    +    • under Description, since it is as useful as the other tutorials
    +      already mentioned there for those who are interested;
         • under Terminology, since it complements gitglossary(7) as a
           pedagogical rather than reference source for the core terms;[1] and
         • under See Also, since the other tutorials (plus the user manual) are
3:  5c83788e417 = 3:  04802040a8d doc: glossary: link four of the terms to gitdatamodel(7)
4:  f8fb18b5f98 = 4:  5e8911beb4e doc: datamodel: link to the glossary

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.13.g85d2d65e389

