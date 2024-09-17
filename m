Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6115C14D
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580604; cv=none; b=uyHxlk9cQjVNZ54Az2Al2yHTp8cRCD3FRWS4PRxiEiCDpssOJyhnU/Be7YoNWrXcNJQd1zkgFlzwNJXwpGiNL+EFX1diDvIJp5bmOpIhc2k2124gr7SHvrhSAQAKqQNtLZ5MtljCwWwiKOpSSaZbjBs4AgvC1qwv5go9MCxsv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580604; c=relaxed/simple;
	bh=A7dLjYTMaE59ICf8USNqQvAK6du+9PvhA8eQXSZ7BOs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I32vxDX/YAPnZncjtXnQeW1F1AeXzkZs19bsy3m7HYhOAMHcr4Vhi/3FhSCdIqIm9mA+jzdOEf3Q3ErVa2oOG/TWN5eWNlwdIGfmQ5aTOo2rLb4Qagk2QmTPSfyVi07V3+NPXZK//oU2DcZFVeZIOIDIw6ECCR3wgw6fKJcjm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DMKsTPm2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5Qa6fsU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DMKsTPm2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5Qa6fsU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 779A61380220
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 17 Sep 2024 09:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726580601; x=1726667001; bh=w71bZ5xI60uCTN4x6/ASeDSEKOkgRNfs
	heqFPmUoIOE=; b=DMKsTPm2VjtPcYVtD547Un99ufuzjk5RAlJlu3v/aw7NPfYv
	uNejspGQTeFTbxvChnUF1GoAq+XwYRcaCMeWsOonX3qumcveWnupeRZ3rvHFTx2H
	Fp5g0rXLtAMG/mvm0MOo4YlWG35DN0EmgySLNi+vMsjJefk1pDo4rTnGq1gMrA03
	jsYw9JyZus20yzQEWZyw0vtPOjCJPJJ3McTEY6+HfGrYP2ojZi9DZUzuW+5GVoZH
	EZYF+sdkW3upcNNuuNOcaZyAH8DEMOlnhy4Cq6JVvGjghUDz+A0hpxuljT1fsDfK
	uT9R+suouTsqO8eMCqz06FSkPLt3nRvjJT9/yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726580601; x=1726667001; bh=w71bZ5xI60uCTN4x6/ASeDSEKOkgRNfsheq
	FPmUoIOE=; b=m5Qa6fsU2ZlQeZuTEyA0VCMJ+TVB8kf46XPWkEbXEupYVYWbMm2
	Gsw9T/7J2b6eoWPJIB9SA/StaCoGko7oP40Hmva3NzJywXQCoSC5ISZOp0FWwpFJ
	55qpu0HPHXV45wE1w7lmENcF5RW0bJehavN5ufTs2IrhXF3nOPaJn8yEL6H7eA61
	vsYXsRadiK/0ii01RS3Kr4dyrKoBs8PoamCqYZ9wNyiU/H3tM6lQV7XAeWQvCjZv
	k1AYyJhaUnAZX398aY4jMZMUMwd2UeO5TwxQR2WwfWEARMzMdr8ttbhlUc7U5DdR
	M62Mm4x0CM8I9soIkcd1YCNVQTPtyConkOQ==
X-ME-Sender: <xms:eYfpZnmDbj9XONaWiLKg6PhJdFHIxKD9ejCmwt_mLEjFRH_DZYOyZQ>
    <xme:eYfpZq3MrrW3SVpozJSAcSeWXtXJGK2E7h5Tqj5OEgdxMQKziG44s_16zguCPXYS4
    62IAD-jSRmhguNu_A>
X-ME-Received: <xmr:eYfpZtrrLBRtO1FPZs1HTqREDw9NxYshd7KVFqJVUdEP1VLW98C-ywwfKlzY6kMjTbecSET9IIgXgYWjk0X67BHObgnoxpzTQa7AOuHAebqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleejgeevgeffudejhf
    evhefhjeegkedvvdelteektdduffeijeduieduffevleefnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eYfpZvmz4bDvhu04rincpZgvm-ye_yI-V2bD4h2QUl7__ZxkU07-ZA>
    <xmx:eYfpZl0bmys1Dng4OST61C2YhR_2b5lQ-JYzuBn7fe54BFXN6zeLiA>
    <xmx:eYfpZuvQQkyU7jXWq71wAAyXLMuM5IpsKfXvwQ7gcGyu6Z8nB8xJeg>
    <xmx:eYfpZpWnZ1Vr4Ur1cIxqJZyiXD_gYMyGkntmjjpc8jQQXTj4QZ98wg>
    <xmx:eYfpZm_lM8H3TqKaep6uVGBeAkI3ZFNcrwrZOesxioFT13UJ3Kq609W6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d31280ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 13:42:58 +0000 (UTC)
Date: Tue, 17 Sep 2024 15:43:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/3] reftable: graceful concurrent writes
Message-ID: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

the reftable backend cannot properly handle concurrent writes due to two
reasons:

  - It will bail out immediately when it sees a locked "tables.list"
    file. This is being addressed by introducing a configurable locking
    timeout, similar to how we have it for both loose and packed refs.

  - It will bail out when it notices that its stack is out-of-date after
    having locked the "tables.list" file. This is addressed by reloading
    the stack as requested after locking it, which is fine because our
    transactional API would verify queued ref updates against their
    expected state after the lock was acquired anyway.

So with this patch series we can now spawn concurrent writers and they
are expected to succeed, which is demonstrated by the test added by the
last patch.

Thanks!

Patrick

Patrick Steinhardt (3):
  refs/reftable: introduce "reftable.lockTimeout"
  reftable/stack: allow locking of outdated stacks
  refs/reftable: reload locked stack when preparing transaction

 Documentation/config/reftable.txt |  7 ++++
 refs/reftable-backend.c           |  9 ++++-
 reftable/reftable-stack.h         | 13 +++++-
 reftable/reftable-writer.h        |  8 ++++
 reftable/stack.c                  | 38 ++++++++++++------
 t/t0610-reftable-basics.sh        | 58 ++++++++++++++++++++++++++
 t/unit-tests/t-reftable-stack.c   | 67 ++++++++++++++++++++++++++++++-
 7 files changed, 181 insertions(+), 19 deletions(-)

-- 
2.46.0.551.gc5ee8f2d1c.dirty

