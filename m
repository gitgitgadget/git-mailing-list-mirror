Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73D3BE17B
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040186; cv=none; b=c/9YpVQMPp1WgJ9imVdKaB22sQPDijB09duv8+xR0XljjNFRNiauu0Gjcpaih6AUM9YQmf79/YAcAVYp31VEGLsURHe/RYE5hhYMobMoRgaVFRHN/7OF8xmlbZJH3atMiLJ/NxLVpswT7c8VLR2Jc1h4aJDsHbfc0QnvmP0a0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040186; c=relaxed/simple;
	bh=bYffihTMVWxlFOIiR30Qc+efFRT4RHvMD3WcgLpch0w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NLZwchZYB7OEcUWXTZG+oXwhvGRhZ56tlSmwBvhS0XH6oEdOE50frN4F/QWPVLe2STJoFMwyMv0yndQeGNLL6G3WJAusPxLNZgF69A7XV0bKx8HGgapQk/9mIQ3u7a5++gqLtwl0cTGG8fwcTXIIfzGXX24iGZmttH95xyS6GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FcO3b3Yk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXZ8BPti; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FcO3b3Yk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXZ8BPti"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 454227A02D6;
	Wed,  1 Apr 2026 06:43:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 06:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1775040184; x=1775126584; bh=D1CrVDuRiG
	7pAIbCqEE++sqr0irWCkgYoUR5ArHOr9k=; b=FcO3b3YkHv8RlJUzAnsNhMfezC
	lI05LU6WJLG1CKdhUKfnAyDryGyTFfqSaw4W7LmfZJZMg+V1uG4bxKyLlsr+w9pV
	sSfTg4lYONLRWiOgrSUUHUVideD4Tq82EBpcPcNwAEkA/IzFgwAHPkNekg7JxuOy
	MOeseCBNDcODMEPAyorNlsf1Y7MPFZHzyGk/iYvZ6EAIvp2QTPKzDRKeXVqN7KgZ
	IkbNPt0qOrzs8RkbJmCU1mu3N4X40nDLOBPaUsXQCY+bPXh/7UeSN7pR2saB20Qv
	q8VFi+DuhRfofTx+ifn5+19GVzNrfdCN/Qows7b+S9lzvrujYRIR/a3bp//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775040184; x=1775126584; bh=D1CrVDuRiG7pAIbCqEE++sqr0irW
	CkgYoUR5ArHOr9k=; b=OXZ8BPtiyl2sayi78cd+yVp5nS+IuzR55EO88grfk6Im
	kTnIOlCV6kRGo0vILzPxoL57M59SIFSNhU5ocWxKubKv8NWlrAgSlfYdmUeJBybW
	7/8lqWAjbh4UOU93plaeTiFyjl5FN/mUx7jtYfLoKOSpia3scFenIFcwOMU634yA
	p3oBufLiWh0ICsEOsRkhecg/DuMV0E+Ja756d/cfVtl/4kN806XIApxk6ZNLCQbF
	YfS7EN8JGsdbdl3Bz0TOrjslG2/xpXtQZAZjghr3aIWMoH34darvWKJp7VTej18Y
	Hvso4GiOD10x58o3FwTxXc2oAgQY3io5niyjjLQsDw==
X-ME-Sender: <xms:t_bMaSqJtVHadsl-1wQHNraCBqf-l3LcPr0XjLB2qz__yIMgJyCq4Q>
    <xme:t_bMaU8O119dUQhyf6xGBak3uWlsRxTDXgVArFt2O55JsU1Ldit_dxOokpX7WGtjp
    Sf1JMlcfvCFscZgsT025-s32_Irph3MWlMPKoLC5H-ZrGmv3Bwx5w>
X-ME-Received: <xmr:t_bMaWXE1JPuZSsUMHbnLjFRCyJojNSQlTtQ3jesrlE6oWKHAFcQHzzcwSyTE3m5Q-ujC-_EDmatH8yVPLkg8tuwNqSwBonZRLhKc8bBx6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevue
    egkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehh
    vghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t_bMaaBU-G6Yap_E_-OvdufQNLhs192iZh1ASXAX1xaIB_PPd8-w0A>
    <xmx:t_bMaXzQwVPSAvQdfH50GjgHjLRgnbby_kQnSd5rrrShnFBheDLxBQ>
    <xmx:t_bMaXCw721rsSLo4LGVLPmEG7VessY_v-L6RAsZ2sdTEowUX98kew>
    <xmx:t_bMaUY7NFlkDAGoz0VNItDAS_pIeWGwSd6hxUH-v0NO2Xl2QD_fjA>
    <xmx:uPbMaXauKZyGsdDVzqxUFA-8ZVUXvJfiEK7PglomcPkDso-Q-_ETBIp3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 06:43:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ea50bb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 10:43:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] t: work around bugs in Dash v0.5.13
Date: Wed, 01 Apr 2026 12:42:57 +0200
Message-Id: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALH2zGkC/yXMTQ6CMBBA4auQWTtJC4roVQiLtgx0JEHSKT8J4
 e5WWH6L93YQCkwC72yHQAsLf8cEfcvAeTP2hNwmQ67yUt2VxmkQjCRRcOXosTXikcxTO2uL8vW
 oIJVToI6381o3l2W2H3Lxv4Lj+AG1rxRzdwAAAA==
X-Change-ID: 20260401-pks-tests-with-dash-ea71cbb36958
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: b4 0.15.0

Hi,

while testing my `set -e` change for our test suite I was also playing
around with Dash v0.5.13.1 and noticed that multiple of our tests fail
with that version. As it turns out, some of these test failures are
actual bugs in Dash itself that have been introduced in v0.5.13.

There's ultimately two bugs:

  - Dash inserts CTLMBCHAR byte sequences into heredocs around multibyte
    characters. This bug still exists with the current "master" branch
    of Dash.

  - Dash may swallow some bytes when reading data, which has already
    been fixed.

I've Cc'd Herbert, maintainer of Dash.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t: work around multibyte bug in quoted heredocs with Dash v0.5.13
      t9300: work around partial read bug in Dash v0.5.13

 t/t0300-credentials.sh   |  2 +-
 t/t3430-rebase-merges.sh |  4 ++--
 t/t3902-quoted.sh        | 14 +++++++-------
 t/t4014-format-patch.sh  |  8 ++++----
 t/t4201-shortlog.sh      |  2 +-
 t/t9001-send-email.sh    |  6 +++---
 t/t9300-fast-import.sh   | 32 ++++++++++++++------------------
 7 files changed, 32 insertions(+), 36 deletions(-)


---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260401-pks-tests-with-dash-ea71cbb36958

