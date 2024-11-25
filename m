Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ABE2119
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520107; cv=none; b=ptW4ryl0CmgjllBk/sMbOUGbIxziNbsg570X7ex28MA3oYZiLleyL8hVsEfIm47dW0bEuQFYfFq89VxFg3xTzc67+mFQaSdtq3bA13WmwkoLti2QehddIPvKogZuQTSeMLNTZq61KMyvcKrhYXrld2ulH8aCnPGKPG9dlWfS4i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520107; c=relaxed/simple;
	bh=q27PtD1tk98UrI5Veh6Kohvo2P3Bs0dyplHSt0jCdzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jBrnYC9zzQ5O1F4NlaMq4lr/YUTAQKqjQcmOGytzUsdr54y8im2LTxgjrPUzLgXINMQsOrdbRRpc6ELKHp5Koth2vmd00foTnakV3MxCbSQsVIwr00p/0dm7H9W0rZLTRQxsGhnnfH6HWOpRhDStNBAtNY3Ce0JOJgKGR7qLLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j84vN2x8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W7mQx+mq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j84vN2x8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W7mQx+mq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA01E254014C;
	Mon, 25 Nov 2024 02:35:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 02:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1732520104; x=1732606504; bh=djg7HK4O5V
	NAMONIArCGEQN6IuwEhFvjMsI5Ojxcckg=; b=j84vN2x8aWweJl/jFoEL1YXzpb
	o1TLi65Ce/hRgDYYSWsQdt6kry0tmniBd7lE1kC2XaHWEPN/jwCI8SB4blNTi1qt
	rERncDk7sJ3sRaEki/RQUXOVuvm113DjJzE4heeavBe6SZVBwBl4VoYbtOQu+ECr
	6+TJv+IbFqlLROjX6Jjri6sX/HLwa3hHupq/Ry7W6nCoSDbkEkTE9jKJIwGWvHO9
	hzfmzS/n+3pyjf2t7XRBOwNAPwx69eK4Lh9rGAsLiNa3/n9v2wU9eWbvcLanujeT
	NwcWzguoFfDXon4gKoPYooeplsblGvbS48/lLvlBYg3zvaBLOnREM897pvOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1732520104; x=1732606504; bh=djg7HK4O5VNAMONIArCGEQN6IuwE
	hFvjMsI5Ojxcckg=; b=W7mQx+mqqoipOfecjRm3UUSFAhGfMMHCUrkmtspiVDuz
	kEiTGp0yYNkFQkonrEXRhD6oXXK3yT1gyapw6YduBJP94MJl21G3ZkF2jzpQw+fj
	4AmqW7ubp/9DF4UQFhes/P/CdqQEyky4W9IYshk1olfSoNJya/rikgibiT/8rEkp
	itHAZVCjfrqLlCS+Ealh9o53+YLCnBFGRwRIiM+pYumi3LcVGqyMFYH6PSRKyES6
	d/IyuHuTw8YjNARVeAtg9gKpjtlJjH5Pjtd/p7q+iYkfKKEdAuTq/usaJmcbMXsV
	8qf9OyPJ3yPuAQjGAvz/tSPLmEKBtixB1IM1gFqvMQ==
X-ME-Sender: <xms:qChEZ8nXaqPCVfF4jNWZ2AzTzc9VCiizhYMs8Fyu_Yucsa8adHYnCg>
    <xme:qChEZ72SnhWxoO2QTApKzgjVhgxVtlGDhJMwPITEKlf69qERsjbADukv9s9yqfl0Z
    N1pC0KoSfecEnRC1Q>
X-ME-Received: <xmr:qChEZ6qg9s_2iPlr8upgVsaH9QT5j7rttJSYd8zcGnqeiVmM5BBa5GDN5GftF3I5cjA0QHHn58ju2yAeTWGRPaU2BRvdGmbmKAcF5IWDKvNepw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qChEZ4mQ9u3ZbgL1-mw1m0_s-UBcle_gnSwhCddgx9qiWRzSqmJzoQ>
    <xmx:qChEZ61kZiBRK2R2Xo9lPdFUrihzbT6Pes8BF-XUblXbX5Sh0jP2zg>
    <xmx:qChEZ_vnbiBRQC3fZb-nZ2qjwHLsFiAhr_-BBWKhLsCpHOUDqKVUxg>
    <xmx:qChEZ2XZpWvgW7Q0qwb-TF-mKHkePgLBpRu45GXoNihVcrnP1V2C9w>
    <xmx:qChEZ4B6hoJDlEXKPd8kAvRuvv8hwPk_XgrsP_TG-d7fOfXmebjcR6EJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:35:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 466de3c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:34:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] refs: stylistic improvements to ref migration
 optimization
Date: Mon, 25 Nov 2024 08:34:41 +0100
Message-Id: <20241125-pks-refs-migration-optimization-followup-v1-0-0e1b4a2af384@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEoRGcC/yXNyQqDQAwG4FeRnBtwhjravkrpwSVqcJlhYmup+
 O4GPX7wLxsIRSaBZ7JBpC8L+1lhbgnUfTl3hNyowab2bozNMAyCkVrBibtYLhpHHxae+H+h9eP
 o10/AJneOClcVD5uBzgVt8e+8er33/QBg9LiFegAAAA==
X-Change-ID: 20241125-pks-refs-migration-optimization-followup-d766e86b8925
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this small patch series addresses some stylistic nits surfaced in the
review of ps/ref-backend-migration-optim. v3 of that series and the
merge to `next` have crossed, so I'm resending the changes from v3 on
top of what we have in `next`.

This version is built on top of 6ea2d9d271 (Sync with Git 2.47.1,
2024-11-25) with ps/ref-backend-migration-optim at d94ac23d3b
(reftable/block: optimize allocations by using scratch buffer,
2024-11-20) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      refs: adapt `initial_transaction` flag to be unsigned
      reftable: rename scratch buffer

 refs.c            |  2 +-
 refs.h            |  2 +-
 reftable/block.c  | 10 +++++-----
 reftable/block.h  |  3 ++-
 reftable/writer.c | 22 +++++++++++-----------
 reftable/writer.h |  3 ++-
 6 files changed, 22 insertions(+), 20 deletions(-)


---
base-commit: a468246cedfb3b54b03609be75d9e13f0be1cc29
change-id: 20241125-pks-refs-migration-optimization-followup-d766e86b8925

