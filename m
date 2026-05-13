Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E835292A
	for <git@vger.kernel.org>; Wed, 13 May 2026 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657483; cv=none; b=ifxqlGeH5O3ua29vkSMfg61aoZ5IB56q0wIbRCgREwyOQDwnUHgIBQVSzI7qUnTC9gJlGFRuEwL9XfcOm1dNSf0KCevlEPk+gYguUOl9J0uDMszkMKfTYhF3AMfW4vmJCZ29XkCdaqWd+GcIkJssY1A2BcnXF+/dTzpPpBNhvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657483; c=relaxed/simple;
	bh=2YDnoXodDF+mOM0cHi/ZsFuBefewoo1eUR7h1tRryE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=AuMpf3vLGcwTL0gqV+GqTIWw2oMNMUqFQno4qxXdgTKNeCQ3aGVe6AFrMs8TSFoyDmFC0KHzXeeVBYw85YqrPdNX3B47KBpbTmO5yWumyHTyWT1L+oOWtdsh3/RdiqP9/JYhT0pOQJF4Ts4U2y4zqe11gf5EHBxRJK070RrURwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VE6ITh0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfB4MfIj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VE6ITh0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfB4MfIj"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 182161D000CC;
	Wed, 13 May 2026 03:31:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 13 May 2026 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778657479;
	 x=1778743879; bh=TI87QkBxjeimH7aEqfYnb9yh7lxMdBWjjIPJsac/otk=; b=
	VE6ITh0j0XE+UTk33q4Hcu9osytyBZfxmtgtZYIxrHybYV0YCW1eplpDexWqc7rq
	JMZKGBULPAnTG4CeICk5gPotLjfgViSMR5GBSpzDEpLk9zkdj1ujzS+akyEKe0ir
	jrJdlpqXmgy9dpI8V2Pbv1M8pGMSW9FASZbQ6CU4fwByN/KE8QqAfR3bnqP8kfor
	64M+9cStYgYyDDgu9boaTRyK2Ok7t3PiOV7XO6pQMMSomXPFKHLsp+StdlpEg3ZS
	ntYewI11YHx4A5pFQHbjlrOIB1IzKLiDU1wqRwtiocc0odfKv5SjUNjTaacoJDe5
	+FRKLa+azy7xf2JQaxGiGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778657479; x=
	1778743879; bh=TI87QkBxjeimH7aEqfYnb9yh7lxMdBWjjIPJsac/otk=; b=A
	fB4MfIjq4lCP9SzXHzpltgI+PzaB+cZ6ZQ3vGqg2BkEO8XRnAhdV/yN/g/p2mQt2
	Z7Dd1zYracDg45r9kEwgQVPnXrqcLKmtv16kPqzbeWjY9uEqLSCWg8/UHfyB/fS0
	UunfC0Ffy44SuXJ94jbNTxYDC+n49JtV9TY5qK0qvhapVY4tWVFbKuXqmkUAW9KT
	jBHNensWPSlshyojtXde5yHkDk+1Tf/9j8XqAg4o+xB31FAAJl2XvteNXCvVs3kf
	nREWmf8rpbKNlmN6TPq/9+RJT4YpwTHtjBYs2+PYqG62W6o9Uu9hQyigjBOEqmYn
	O5MlpWHQ4eNK68tJG37mg==
X-ME-Sender: <xms:xygEanOthBhUSPL3ahti5uMXue1PWDwQFfWQc11J02pVuxrdm8d9Jg>
    <xme:xygEakMwJUPzBiV0S6Ljvu9vVPZ1CI1EObQHiB73D49yzc8KFE7nPYtcSp18wVbmF
    tY3-PJPTnYfRLo-jWO_tn4inbmW2j3Yww2qCE2jIe_yzfqzY9gQK9s>
X-ME-Received: <xmr:xygEaoiaOYPfSHOCasSBFxNyK6ioRDYp-ibuvGf7RcYKmQAM4V09G8dQdlMKLP0h0uvdLoMIEXhNQyRk40ysMcPEej3w_lAXlmgfUway-3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvffekkedtfeelteevgeeuteehtdefueeggedvvdfhvddtteeiieeukeehgfefheen
    ucffohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggtthhiohhnmhihshhtihhquh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmihhkrg
    gthhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xygEahtqbJTDRERGTSSfE91UaPOU3h2K_dAtAG6EQIE7_j_uS5ZIcg>
    <xmx:xygEauRDFhxtJSis3YPeNyi2932pnW7DuwfymMtGRFvUBQJxo4rknA>
    <xmx:xygEat0f95bno_4CQXGFLDc2kwHHkY8k8-3JyC7drneR2AbyFvCoLg>
    <xmx:xygEart6b8cp4r07wOiuOT8M14mhMzlFPozdulOXsYGx20me6g3kTg>
    <xmx:xygEasO49_qsjxkSbHvgjhEVCXAiXWMMqJKa06tRJ45_qkvOItXDli3a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 03:31:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 522ee8cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 07:31:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/2] builtin/maintenance: fix locking and respect
 "gc.auto"
Date: Wed, 13 May 2026 09:31:12 +0200
Message-Id: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMAoBGoC/5WOwQ4BMRCGX0V6NtItyjp5D3HoTocdS1faKiL77
 loSceT4Jd98/zxEIM8UxGr0EJ4SB+5dhul4JLA1bk/ANrNQUmk5ryo4dwFOhl0kZxwS7PgGxx4
 7uHJswVI02ILRckl1o42lRuTU2VP2XjOb7ZvDpTkQxtIuRssh9v7++iNVxftzMlUgAdEurFZYm
 5lc57MJn0TZS+q7qH4sqly0qHfKquWs0fZTHIbhCcYpvxg5AQAA
X-Change-ID: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses the issues reported in [1]. The series is
built on top of Git 2.54.0.

Changes in v3:
  - Use Taylor's approach to reassign all tempfiles when daemonizing.
  - Link to v2: https://patch.msgid.link/20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im

Changes in v2:
  - Clarify comment when dropping ownership of the lock in the parent
    process.
  - Properly treat "gc.auto" as an integer, not a boolean.
  - Link to v1: https://patch.msgid.link/20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im

Thanks!

Patrick

[1]: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>

---
Patrick Steinhardt (2):
      builtin/maintenance: fix locking with "--detach"
      run-command: honor "gc.auto" for auto-maintenance

 run-command.c          | 10 ++++--
 setup.c                | 16 +++++++++-
 setup.h                | 15 +++++++++
 t/t7900-maintenance.sh | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tempfile.c             | 12 ++++++++
 tempfile.h             | 11 +++++++
 6 files changed, 143 insertions(+), 4 deletions(-)

Range-diff versus v2:

1:  5eb608ad43 < -:  ---------- builtin/maintenance: fix locking with "--detach"
-:  ---------- > 1:  3fc8872f36 builtin/maintenance: fix locking with "--detach"
2:  15e2ae8104 = 2:  665a6c9a50 run-command: honor "gc.auto" for auto-maintenance

---
base-commit: 13ef77ce6e222bef3ab145642e6ef1486075211c
change-id: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb

