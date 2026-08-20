Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677939B944
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252156; cv=none; b=ARnZAJL13Vb5TMwAZHY1W2SYvGIiwWx7NzKa03Lc5Oveq0hT0wjNhtxRu3aeGUM6V13eMi9HfqtJ4IPh0P3BAiVPX2XeJcGS2Luhp80mIqbUmlKsbQNwAC833F/RBcrEdA4jOIIVi4h9/fyxQBu1bdxg7+XSb5s8VJ8F5sEGpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252156; c=relaxed/simple;
	bh=8E/LHA+G2kMrmBsXQp59A9ZeaTafdWZrrfgY5Wv0CHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YHjqX1gJnbE3mOmfr3ff8LQqSkISHWIVNJ2LHmTJOmO/vwTGu91wB7Oq5CY8oNM4fica3kaeJqE7JXneGxK7RoITvOmgjKHtONptiJcMjuoZcIrH8D1VWm+9QhSCAXCNZGkWEd1QaKI/I744Mjvga+ZgTFk33fyx9MBlEKg2RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nPGk4exA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3JtUo45; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nPGk4exA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3JtUo45"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEDE07A013A;
	Thu, 20 Aug 2026 14:55:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 14:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1787252151; x=1787338551; bh=Zi
	GQ/zdpvS3WClDlMeMvzmcdN3Y/PlqJP/9EGQgl47o=; b=nPGk4exAKEJAg91Ohf
	EG0AdbwkdtPSh54TTqu9P3aqwkZI7HzBClQafVPwVoUbD3MxqRdB3LoXYsdV/Iqu
	CoOKWs2tQkPfhPUK1oZvccM8AH7Imic/kEyJftUyKV9FghuMK90Lh0E250LhRMiB
	OEMfLf0LQz8p8ErDoNm8StFiXPcTgNBfFY877TBgRhhbGRj7VJV10QsM1vQhkOiz
	P8OAmu9hlUhs1mTMPbcqIyiPgtuz4jJGYmG+AF5ACURjP8KKJutcrXZxbs7RpbJX
	C0T0PO8v5PoqOBtuUUueMgitw4oD81mlPxD+Eaw8ZjvjlwHR8JCN4yf5pgS84SqB
	dCtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787252151; x=1787338551; bh=ZiGQ/zdpvS3WClDlMeMvzmcdN3Y/
	PlqJP/9EGQgl47o=; b=Q3JtUo45oNHiaFMJdZVuzmDKzAd6xexN2ZRBn4NApobj
	b6hwviaZmVWYWk/yhQpDMiHmVQ6FLqWxYcrfKfVw2Ky9dhE50gKr2oFEjv9Gya3r
	hcCluVBK6mFWIu1srKFKP2zPt2Ekr1PCAuD8U7S6iThbiQmo23bCZV62RmthnMdY
	1tIFsH/V67IZ64vgcSzb9n7BP0xNC/5C6eMWzTL8aXvmQvE3Nt75/IVL3rQQnEqp
	Z0yYvOqXDAMboJ44d3Pzuui5Gx5Uzl+W+PzrCiOsRyrKu9gsKrSPAfYuvqV8buhJ
	nfaHPA9gutc5Z+M1juheKA/5tM0HYrQV1uXJv147Ww==
X-ME-Sender: <xms:t02Haibht5TQdHaN-NZz7LbYFrBcQ5l56FZHbUJvgfszqbU7MBBRP_A>
    <xme:t02Has34bLsFiMEyEGy9_5d0R2mq7oHux6uEfnR_bomuzqXxGvhQQlJ4OmWx-TF7K
    Rt4kmEAN6rmwRvcaPdTwmRwLOxJcJaLzeBiBVMjFAJK150fDFGb1g>
X-ME-Received: <xmr:t02HaqUlaAw1StMEz78jDBZkj3Dy6kvMFlmCOLdad-jJ7UjQqODotOYCKVxrZBdq7mruGzOM03CgpcSj1rk296cxDBln8gSN1VQL_bpbl1Sn8VouxWrsNJw>
X-ME-Proxy-Cause: dmFkZTFFSgPLUrrUXwV9yjKzrw6YlpXHXrIOX5WsmX4ItdzHbR51pPd8kXM7mGCWM/RP7Z
    qsPk12jdy8if3yk07jy+xKkVLS8YkH+9s89xl0mwPOO+plQESlc4i1XdezWldUsbfatcUO
    s58MC2aQNdPZkIRHDtNUb9veS/SRVA72Dxlr7tRe6jinE1OH4EkqRApulm36wO6fsTy+jN
    hmixAq4jlzyS7uHf+AUqpwB8mfvxSOejuFId8adkgZAFb9bBII9+ao77XlenOPLGGBidHi
    GxfPYgZqrrHx6HBDOsch6spLw3aLfhk4jacAwj52oqmHuEkGulejhehMpVYcIprTEAw2WI
    PpY6NqzLRhlSCfURSb3vf94Gqcp0nmSJqkVVd+RgsqowaJK04CjDoz/99Sq3QOiqskuQjd
    KGItQMz+kkoyEN9CR3mpqqbw9neGiHeceoIxzARhFbnOg2GZHSBhdTke8/6ghPaKobF6YG
    VI173ZFK+DZ2Zho28Mo5cy7t0X4A764uCoNyQ2Od5t98cVH9DTL2OhEygQNTjNhI3F5KPe
    xG+TmDTLeljW/L2cVrcOqtYFg8TcrDMlDH/88DZXCM0t/lUznixfDFRpSCnTF8Ix9gbC1w
    dFLhdfWPalB7tbibKsf1r6Vun9UZUjKMDL4lNAn+WH8RYeoJlltxSG0hpfGw
X-ME-Proxy: <xmx:t02HauXIEI2GoQ1cY3EVizwR0r4Zg1BS9HP7IlGInAg5s9VEYDJEsA>
    <xmx:t02HahfDIFhtU7fS2AoYjsEh8Lq198OXcQM02WuxPi-geiocxR8gfw>
    <xmx:t02HavU7_8ouMnfCWB_OqQXYC1Z85octqQNz0yu1crYDfV0g9jAzFQ>
    <xmx:t02HaievOeiET8jLEZ2SYjI3P6_vc__OeA5d47gZ-bijbNpKUFUeaw>
    <xmx:t02Hak_RXbFsBZue9HNM9vaXkvtZWmhjFAgd3leWpbectuFH7Zgm03ih>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 14:55:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 0/4] doc: advertize gitdatamodel(1)
Date: Thu, 20 Aug 2026 20:55:20 +0200
Message-ID: <CV_doc_datamodel_advertize.bea@msgid.xyz>
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

Topic name: kh/doc-datamodel-advertize

Topic summary: gitdatamodel(7) is not linked to from anywhere. Let’s
mention it on other documentation pages and add a link to the glossary on
the datamodel page.

§ Testing

Other than the usual documentation testing, I was unsure if this would trip
any tests in the t/ directory which tests what output you get from `git
help --guides` or whatever else. So I merged today’s `seen` in in addition
to this topic and ran `cd t && make test`.

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


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0.13.g85d2d65e389

