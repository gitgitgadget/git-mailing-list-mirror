Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D3D19C558
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501908; cv=none; b=AW80zoEqo83TtVdQYWqg0hvC791sTD6RAwrfOOzLz9vhTdUrbHlmsSDauQJCbTy6867iVgCYy/2WYtobyQSaRXvKjaXdiLDOLgrmEk75wLKstEY3nYmWMcpk2euaukOChlxmu1AWJLCYSHGcUydJA3FMJ6fayJo04Q4E/TpeAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501908; c=relaxed/simple;
	bh=MdbMrZ96cDMMR6MrOR10DynvP9kI7DdwlkSrsGNEOao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dquvKKsmr0abTVAEiuLbfj0LoJv5nBcpVZ8l7bF8QsFuJMIyPHR+JkIC6p2drRaTB/ghhFNYYuBwCVszYE4YvLAp5Gxkj5Aj9XnMKU80dzvwnOhJyP81K5v5z0SB6jMfLMSNgZ6VY/ENeJwdBql1KHbFBdsmvMWRRmVwv6bvjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WIcadMRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oa5XTFdY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WIcadMRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oa5XTFdY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F427114024A;
	Thu, 24 Apr 2025 09:38:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 24 Apr 2025 09:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1745501904; x=1745588304; bh=pBF1oPOPMw
	t1hK+uMyClgE40UVyDTGuGQmUf3/Rzy/M=; b=WIcadMRPODZR5jHRwcqSjJLqWp
	fMT6/NO1CPKZ7EOsAtVSYbwH4lioh0e5u6AagTW8hdGq36gvQS4jGXWCPRSz/iiJ
	3dCQR3aqKleMQUla1jgUCx/DgGDOaT8rymZQpPaSelwmcXpq4MiqnXvHgcKtjdEZ
	DQjhLXimmK5a2UCcG6DXiiZ8O1zkZiL/3HupPv6lhylp1jMTPHpt5KWFF/71JHLI
	jGEYPeUleCTCnFk6EJc7bKpMqpQ6H0y+wp5OFzaQc18BdX7viwQQJbw9j16TGcPO
	f7d4SVYYVEtwVksfI0iPZ+aGObeX2dNCqDnF/XKxoCN7eMr06UPO/0VqqDgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1745501904; x=1745588304; bh=pBF1oPOPMwt1hK+uMyClgE40UVyD
	TGuGQmUf3/Rzy/M=; b=oa5XTFdYKx5jXiKEQzMteLwaLyZnphL+549yu+P0qC2k
	WtQTipxpHLvrttXNf0howoorYDCwRNizxgoMJTYqStAHDHMgKqXVEnRpHuFaK8Bk
	5fOZR0IjclMvuSrBi6d0BFBeZ/nJNo5vx19eIxmKWComdURPS8W6hl42qfx3gNnS
	4gbwnrrKE9eTDTiN90/o9UOlsTdc1kpsKoBbgt3pdPu8KA4E8gyKX8Koa+5fipNR
	9ruULRVruDNlIAjbZmJ0KOPsYeTXzv4e1J3fybSoEVTpS6bh30WThO5mhA8pEY58
	/ZQPanbsqG9kmEKvUFXlDB4gW/qRVBzdpg5AU1khlg==
X-ME-Sender: <xms:0D4KaIwo81eVti3wmWI0a4RQT05ZPvkGAGGHmWn946rC3O158P0VEg>
    <xme:0D4KaMQn_PmShx4eW492hesgEIIyM8XLuDEBwtllOzAY7WTHbeHpiBwzRpzdpGVE8
    MobW546E6WpGqXd6g>
X-ME-Received: <xmr:0D4KaKVeJ5RvxXjxEvHKdInhAmHQlFoXgkdMkGqN7RJba6j9-L3Peyjp2jH6cz4bmPXWaN2q-8gtfpTL6uW8h5YmTXB_dzppFrqGldJl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsrdhr
    vghpohhrthesghhmgidrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:0D4KaGj2yg48OCGGCxscj2DwTxh53jOYWDof2IGpW2hx0OeUsbf8xg>
    <xmx:0D4KaKAe8DlnLIdshm9u0FOfxCBgOh4e73g6Yk65PnZT4tBWd0kNkA>
    <xmx:0D4KaHJmJ-NBi0vtIucqMdbArkKmjlUEEC8HzkGnm-nR3bshGZwJ4Q>
    <xmx:0D4KaBCcht1XVjq6Sfi0DJQDIBTyWK14Bvy4lFMvTytqI2m5M6MhMQ>
    <xmx:0D4KaDi0JynDeBON-Hi0Oric0_eDUB-xTBV4-xwxB8MqbQzMejN4AlBU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 09:38:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d72922c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Apr 2025 13:38:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] meson: prefer '/bin/sh' over PATH lookup
Date: Thu, 24 Apr 2025 15:38:13 +0200
Message-Id: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMU+CmgC/x2MQQqAIBAAvxJ7bkHFAvtKdIjaaslUXIgg/HvSc
 WBmXhDKTAJD80Kmm4VjqKDbBpZjDjshr5XBKNMpayymU/AiiQFTFH5QDvIereud7nWVlg5qmzJ
 t/PzfcSrlA03sGaFnAAAA
X-Change-ID: 20250424-pks-meson-posix-shell-4969161025c5
To: git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>
X-Mailer: b4 0.14.2

Hi,

at GitLab, we recently got a couple of bug reports about Git not being
able to find its shell anymore. The root cause is that with Meson we
have started to look up the shell via PATH, which may exist on the build
host, but not on the target host. We have worked around this issue with
a cross file:

    $ cat >cross.ini <<-EOF
    [binaries]
    sh = '/bin/sh'
    EOF
    $ meson setup build --cross-file=./cross.ini

But this made me remember the report from Peter [1] that Debian also
faced this issue. So I decided to address the issue in Meson directly by
preferring `/bin/sh` over a PATH-based lookup.

Thanks!

Patrick

[1]: <20250209133027.64a865aa@gmx.net>

---
Patrick Steinhardt (2):
      meson: report detected runtime executable paths
      meson: prefer POSIX-specified shell path

 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


---
base-commit: a2955b34f48265d240ab8c7deb0a929ec2d65fd0
change-id: 20250424-pks-meson-posix-shell-4969161025c5

