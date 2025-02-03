Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC41FECDF
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588034; cv=none; b=EQHs0TyVXA3IA79w0/gShrLDQmtW0+vMpNKOtPruLbLNa7A2YpNZZrUfbQsRCF3LT3Mp3C1W/KNhx3J/pgmDS85TDKWSXmGPP77+2q+J6rW9ihIymZtJV02FaXVz3ecSJwNb14YjcurF2/gq+j2Lz7slFcPzD+Hvo+0sc4U7utk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588034; c=relaxed/simple;
	bh=zoiTLPKVddUVg/alufFGliQ6QeD0w2cKbc8fzG1JyEQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vu7H5pVU+dJoxOMHRnLTS6qRSDz9o2VjXjfPTIh2yctapzXhGCj8r3Fxt+/lIP1Hc3Q2joWFwm41VF9rR3Vn+7ig7P69T8adZPNTfcleunC1Ys3oOpkgCxv6ZIp8NdbVKbWsiRqEbJmyPVAAjlEpIKMUtDo67H9zsu24SDkAc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kBGuUUDY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uWvyUTIS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kBGuUUDY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uWvyUTIS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9688B1140120
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:07:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 08:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738588030; x=1738674430; bh=UPfqspeOJX
	6qvAeAAkyfA5ke6CqaymQPrUbjTvNw5HI=; b=kBGuUUDYlTj9OC4YbaQoU+OUh7
	sw83ptW4hp86OX0G9xjTrmW2wwWki2bJixbbn2TYHesZiH/C55qVWYZ4vdL5pge5
	Pcvrfnz759RKUEnqk+pjte8A6ViMymXh30L/glDuORYPikjKCqKRKH1xF0yFdCMd
	SY/jVi3ldHPkL8F8gcquAzHAlc9C/FYj/uL9VK05fW7E+nYQHqeUWzEkhB7jQCRj
	QtJUfomuW67r/61mzoXSj97UfEEZyeSk2MQAW62BMm38+bkVHoGikNqokYwkQQdT
	MT7Jn4SGDnQsAEjpfv77opHSlARh7CGg3ocTPb5zoBHfxZX3epYH4JqWsmFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738588030; x=1738674430; bh=UPfqspeOJX6qvAeAAkyfA5ke6Cqa
	ymQPrUbjTvNw5HI=; b=uWvyUTISiJANq5nG/kEmB2nk2kphmDH7mSFjV33CLpw3
	itwn/FNTurh1bQcXSIgBloLBWhlleZ8xCvRh2b80ZyN1dmaMrIPXrskrx3f90lA1
	1WrK4KcQv6FJmf3uSwVMNzkmMLS0c9stYe1/zQROuGWooFa//GGd2SlzZbkvDWHD
	kVwKT+EVXqNodq9SqgIG7g6GK5dq/S2HLd+zoG0YrqCeaVEUIE2jZP+4hrMqOBNS
	1gb4d5tUfQ2rt0kaQoknkPI4CLJ19HwCnlTVOWqeM6VIpJfVJGM8OEVbN1M0Zu8U
	Yk5HMOtDtaeyprf9cdLAXklG7ybEsmB3vQ0jeIN25A==
X-ME-Sender: <xms:fr-gZ9wTm4eK8j3nJVSkoqM0DSrJjOflSd9__w8VGYmndVWGwQGPiw>
    <xme:fr-gZ9Q4pW-FKGluLY1LV4DPVwtcjBzdlDPYCxjInc_bKkeR53qhFv4v3vMBr9nVk
    vWnH6J6ZW_wsudn2A>
X-ME-Received: <xmr:fr-gZ3UCOC0Z-Yb0vWuN7uLIjSDF7miCe3kgC3ZlLu5tzqIbgU0L5ksuBd7XG94jcyfT15Diqal5yUjA9EEvvr4wAigHXnn6PVjYTRqI_qogEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtte
    eigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fr-gZ_iVzZFfQwatvznZeX1c5QXCu1ydSTx40zaaPzkSLjJf58b9qg>
    <xmx:fr-gZ_BuKVZMNRWyrrHAxvAfVmGidDgGjziWgxv13z_sBDPehb6ckQ>
    <xmx:fr-gZ4J4ds-yKeH0v3aYvRBTTK5NzUduxP8zlqwNgdt1Pp2zZYv4Gw>
    <xmx:fr-gZ-CsKwz145rIWjhUmgMAEy0h222kEWQruMIG9kM7f5KXQ4-UGw>
    <xmx:fr-gZ05o1EvwYJQiFiTC3xdeX2A-R8oQUlsgxj13avCDRcg-Wa-YmhVS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Feb 2025 08:07:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b82ff7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Feb 2025 13:07:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Date: Mon, 03 Feb 2025 14:06:53 +0100
Message-Id: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG2/oGcC/x2Nyw7CIBBFf6WZtZMgWBb+inEBeKtjGyCMr6Tpv
 4suT+7JPSspmkDpOKzU8BKVkjvsdwOlW8hXsFw6kzV2NNY4jgeus3JDDWnmZ24IXYwLuMQ70kP
 5Xfi3TbJA2blkvfEeY3LUT2vDJJ9/8HTeti/w14Z9gAAAAA==
X-Change-ID: 20250203-b4-pks-repack-unreachable-objects-wo-packfiles-33c26066e5c3
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes `git repack -ad --keep-unreachable` when
there aren't any preexisting packfiles.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t7700: add tests for `--keep-unreachable`
      builtin/repack: fix `--keep-unreachable` when there are no packs

 builtin/repack.c  |  5 +++-
 t/t7700-repack.sh | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)


---
base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20250203-b4-pks-repack-unreachable-objects-wo-packfiles-33c26066e5c3

