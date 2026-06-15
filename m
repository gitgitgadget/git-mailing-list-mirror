Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44593EFD3D
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528394; cv=none; b=Hv6Ey40544FetiepJMdw92TALNByq8/JhUbJC2y7uLhoyxIAuaZX55+1F5Swt8vTjMEhN2euCtC4yqwyVt2JmysYgDHOH22nYTivjQniFekxE6ciiew/O91BSV2EO9khJkwt60Xhx/wpHzxYBtDdYhBUZ+/HqilCbA5rtSRr2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528394; c=relaxed/simple;
	bh=8tyB7GElwYgZcp+nsPD5HVzaioAklseN9GR5Ib6naTM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=aJYwgYY9/tp270F2FKrPH8dWV5Idt6YnQUAZxdPN/n0tCwC9OZ6i73DfSQBO0+NvKBR+G3j6MbBOAoNbsVIQvn8qvh9ZF3UkmxJfUL1nWNX6XEyGd9bMpb5xEVeFb24gZITFmqr4XeBqbvWtN81aULk5vrb1PzSDcqK3Y7NdLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L5yvE+Y3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfDUtaF2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L5yvE+Y3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfDUtaF2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AF66EC0216;
	Mon, 15 Jun 2026 08:59:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 08:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781528392;
	 x=1781614792; bh=8aKFvLG/0k0tWP+e5KngeL6BGuCgjEgWmSWJ7J10xqA=; b=
	L5yvE+Y3fybiAHy1bL8utim+YKPwc2uOd6WrJPlg3fFM9We4DemQy+8NeLGMhqOP
	a2UbwsWnjbh5pSAYQuVPcU46CDk6HTZs059XNPZt03tbkocWf1yJsmmnv//Dolq4
	1SMa4mVR+eFJaxXD8taJTvtrPzaqworXAtivaiklis4MzXChPCiw9Hlq6/zUq9ns
	YMEWAC1hFrhmSOp3XK3EfeWQBOHo7m3945y5G2wAuA4IZG2av8MhTtAAS/gxXzyp
	a7VJ+yuL2La0nTNz4Qh6DXLBgfwtCyDaOpuTbhMKSbJOXquf5aLLWpI4I6EtBr2T
	rv61BJ3YwyczJ4AsBB4SeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781528392; x=
	1781614792; bh=8aKFvLG/0k0tWP+e5KngeL6BGuCgjEgWmSWJ7J10xqA=; b=D
	fDUtaF2+QGq2226vEdLI5YnWRTjRxQkqMfJsdcCza65oHsjJbTfiyYPTDmZWPkMy
	g0KglpvvzJA2Q7kw+dmi8mM4+q0SZOv/5dYSVVlWcZirvxgZTE6Kg5t8UZvTJXco
	If/45Xb5uXIs7ScdR+efI3u5qjRo4P+5FLccFxadlDL/2kFsW3mTpXNfn3rnkQET
	kTCI7AV6vGPO+UaGPr11w/kMo9Ykz8pHNTEsUm9exHJ1Ppmj53Mo3Id82twkomqF
	YVmLZRK4i8vexirPm34KJrXGcoKzrylsTbCiotW7fETDWoDvLXVUPF9pGIUfH0nS
	NdirhFGXYvFiqZkXM05Cg==
X-ME-Sender: <xms:R_cvakmQLp4n2Kf4R2OPSrUcU3hdrEY2yqtbJM0taxg0NeoicWjl5A>
    <xme:R_cvaoy6TY6WjQ0p8pigOeVvfTMaHMBG5aXdkFPSs2TKoVWMSrDfFGZ9K3Z2HLLb4
    oHhzHsXnFWmRPfYJQfMxEKvA52DqzqE4W1lMi9KzTShjSklhHDh9A>
X-ME-Received: <xmr:R_cvam5lQk_O6On3oqNcBxFopqsGYqtKxtJLQrfe9_10qsuVnoU1J9OLJcjhhmchj3Z5F5I5W2P7YPDzMZ0CKoW1AAiuQH60szrrcA2e0Q>
X-ME-Proxy-Cause: dmFkZTFmdNu17YhtJDxrCbUpnQnMoz/DQZ+gTBcNenJwogdQdAd4HYlDgU4x4qSalcArj4
    ishgZUmOFhBRJ+R8Fv13f28m8wUNLWFTM5H5a0BHKdVE35co3kG8WMSychTqI+cVo4VZKB
    VHvjp4mPv+i71UG5u3xHZUYyJ7OoPY3+17OBKLhn5LT3/6aXAGTTsDFl/zFEct0ij3BZvJ
    7mUwwYHN/soxaCMCn+i7CpWJJMi5sOQVJI04n9WjURvGzWRs28B20xZI2T7JJJ/01mLS0M
    Rwm+++iyuSgD8+UHSKn663jeK7q/q+KDbwukhaUxDwyls6Uo4ZnWqG+jhwSmcnx+IuGoEj
    FcaVTpCnhqYvzk1HuiD1gnKUph6YboZyK+y/gpL0jq1qWM56u3E3OXO12WzaB2Bxqpppj+
    fFv9CAnXigemi6RxMDOS+Z5GQUvmGK1mO2dJSc5sO2I9mNOLuhRz9OfROGUUw5nGqzmQzA
    luRaAsV+3T7fMkbRHPtezrfFTOaLBi9OyQfjCfnFoB3AicQNaP7YGegYhgJe/78BPSto0G
    1rddKeUJWqwM4y6f+H6yasur1GPQdI+Vs6h5KEptkfcDtdpKUzrWaW/YHKoS64u0Pg8j2i
    IZ2E9DHJZXsD8TEyWq+s17So2oSxCoSrMdFJo9tw6ZPSnDQ8M9Be8MvZFP6A
X-ME-Proxy: <xmx:R_cvagW6b138x68Ye936QhcIM4sHT9O_eg0Q-87BVmy6Pj_bkeSr2w>
    <xmx:R_cvamKuVcWU32Tn9HPFPI7BwW09_eOp3RIlD4MgCSjcTJEWB70syA>
    <xmx:R_cvaqsySzaMar8oEZon3kHF44ZTSvh2MltjqfBn1kaX5SqTmiBBCQ>
    <xmx:R_cvarJt1CBxfSwmUgoU_BrFQoNhhU7Du1kYVowaB49JgB47odHVHg>
    <xmx:SPcvam1X-dxoJMTBnjhZWO0aLnxxOsNKyxD3ScrqiXjnulcCWehFJ6DN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:59:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83ec25c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:59:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/3] Documentation: recommend the use of b4
Date: Mon, 15 Jun 2026 14:59:40 +0200
Message-Id: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADz3L2oC/2XNywrCMBAF0F+RrI3k1Zcr/0NcTNOJjWJbkhqU0
 n83qVAqLi9zz52JeHQWPTnuJuIwWG/7Lga13xHdQndFapuYiWAiZzkTdLh7WisqudaCNYUpVU1
 ieXBo7GsZOl++2T/rG+ox6dRorR97914+BZ56f6OBU0ahAMxAVVhpc4qHg32QtBjE1sjViGRKQ
 GAAQgv5Y+TWlKuR0ZgMVVU0nOksX808zx9INPAYEwEAAA==
X-Change-ID: 20260602-pks-b4-31cc20d7f84b
In-Reply-To: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series wires up b4 in Git and recommends the use
thereof via "MyFirstContribution", as discussed in [1].

Changes in v4:
  - Improve a commit message.
  - Link to v3: https://patch.msgid.link/20260608-pks-b4-v3-0-f5e497d10c56@pks.im

Changes in v3:
  - I wasn't really able to judge consensus one way or the other
    regarding the deep vs shallow nesting of cover letters, so I still
    have the change to shallow nesting of cover letters part of this
    series. If we continue to be split on this one (or if we favor the
    current status quo) I'm happy to drop the first patch and adapt the
    last patch to use deep nesting of cover letters instead.
  - Hopefully fix some confusion by saying "shallow/deep threading of
    cover letters".
  - Fix some more instances where we recommend deep threading of cover
    letters.
  - Link to v2: https://patch.msgid.link/20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im

Changes in v2:
  - Reorder commits so that the b4 docs are added first.
  - Add a section that highlights how to configure b4, and that points
    out that the per-project defaults can be overridden via Git
    configuration.
  - Add a patch to MyFirstContribution that recommends shallow
    threading. I mostly intend this to be a discussion starter so that
    the `.b4-config` file matches our preferred threading style.
  - Fix a typo.
  - Link to v1: https://patch.msgid.link/20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im

Thanks!

Patrick

[1]: <xmqqik81xpqx.fsf@gitster.g>

---
Patrick Steinhardt (3):
      MyFirstContribution: recommend shallow threading of cover letters
      MyFirstContribution: recommend the use of b4
      b4: introduce configuration for the Git project

 .b4-config                             |   6 ++
 .b4-cover-template                     |  11 ++++
 Documentation/MyFirstContribution.adoc | 100 ++++++++++++++++++++++++++++++---
 Documentation/SubmittingPatches        |   6 +-
 4 files changed, 114 insertions(+), 9 deletions(-)

Range-diff versus v3:

1:  1aec56f76c = 1:  b6b488e6a8 MyFirstContribution: recommend shallow threading of cover letters
2:  f2036769bd = 2:  1a68b993d2 MyFirstContribution: recommend the use of b4
3:  fb522c7d90 ! 3:  5bc8fba96a b4: introduce configuration for the Git project
    @@ Metadata
      ## Commit message ##
         b4: introduce configuration for the Git project
     
    -    We're about to extend our documentation to recommend b4 for sending
    -    patch series to the mailing list. Prepare for this by introducing a b4
    -    configuration so that the tool knows to honor our preferences. For now,
    -    this configuration does two things:
    +    In the preceding commit we have extended our documentation to recommend
    +    b4 for sending patch series to the mailing list. Introduce configuration
    +    so that it knows to honor preferences of the Git project by default. For
    +    now, this configuration does two things:
     
           - It configures "send-same-thread = shallow", which tells b4 to always
             send subsequent versions of the same patch series as a reply to the

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260602-pks-b4-31cc20d7f84b

