Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6818A922
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729360496; cv=none; b=mia2G/S04SGsGv8GU/vcDZEW9ykHp0KyfpHxt9ge4venprdafs2Vty2lH9vd6t1N3Se3oUL7DsT0An8gONtE4Blis3lA7+KWemzelkHKUYf8Msvhq2qK5EG/6XKR78yDmKBlNvnyr5ApAmdPkOdo25if6b7oxa1NXEIsmz54T+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729360496; c=relaxed/simple;
	bh=P5gz/RBiqY34Ha0QET8yMc37pvGCnTw7uY+QQ3YwUc8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ALNlhhQxFk4DhO+3D5FE/SjlYqZ5yXQpMQaEWhSflLQAkNpRjTE/xD+XzvmPqeB0odcfzxMdJJbRZ2rKx/qr8HGqu6q3dn2z0VS/9+OKxCIq1bdYZcWFdQiuSIyHHDgFaO9C2djS6LNbB4M24s+W4OAfX7B4wa85GRP8uzmsa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lkNXGqsz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+VGX88B; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lkNXGqsz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+VGX88B"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 790EB13801BA;
	Sat, 19 Oct 2024 13:54:52 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 13:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729360492;
	 x=1729446892; bh=uOZoCscyx+nJIfqxhVbJRZP6z10B7MMGgdU7bvyp8sA=; b=
	lkNXGqszoEEcaNJizOl85LF648zb33Or+pN+u/Y8oo8EkPsv08cAtikZqhTG3d3x
	TeiiCVK4CGQO33t8E0ozSTx44hJYZxd0pUHcrwZ5YU0pNwmIcDNHr7TkFi2P/Y6e
	Vc369pruuFG6BJSJA76Ds5oP+ix8s1n/FXzGtGfM/OJtI8SvIoEYQopG3OU+6vWa
	HBx6aR1Q02masehj5IuraqKvUzk8FRbufMSSnoPtuVB/LA2miYRtXzZzZGuNHTF2
	eE/5h3OTac2T51cQm6u8Y1pvusPCi/zyT5DNnWoQ+Hqyy4JOBbgEfg+9m5D5zlY3
	YZlR7Nk7jPqv/mpeWkJTqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729360492; x=
	1729446892; bh=uOZoCscyx+nJIfqxhVbJRZP6z10B7MMGgdU7bvyp8sA=; b=m
	+VGX88BWmBoBlLl4ql9WRR28pIakV/NP7VgoVm598EwNzttViUlQjWyKanUwgDQL
	VJ2eijt0TyEhZO9fZ66x7JA5M7/yTW44IwGdjVGg/7BU7SVa/oqszzV2CSGt19eC
	rEqtXnGZC7cp4VYaTig75vp6amMlMa88hbHEUN7KqPq7p5co1OBsjWCNWSng6aWQ
	r/Zxl/d5IqH11soHg5w6TJtn2R8uODRQC//27uGKN5bDMZxvXiRDSDncX4iNSexD
	I0pb60V+2E88m58jJXo5WI9ADSPORuBPYQsRb4OEqvxIulwzeO1qWLA1fNHURaaT
	6HfQJ7i52I5alXVPD8GFw==
X-ME-Sender: <xms:a_ITZy0A5aj-W-tQcIhPla2jLSMHvsVbECSuLaLXh9hGc5Va7zH3TUg>
    <xme:a_ITZ1GdGx_6ShjIK8yilHdnaOxlRoL2ChPpwB9MWZkYB2IyCDqdb-Gp07e2xM0r-
    iXQtV5reISD1igFUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgle
    etffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhufhhorh
    hijhhileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a_ITZ64ZJUoAVIiYcOkxhGzQ5qVSSirVDn6iL_tFyeIXD6wXfA_kxQ>
    <xmx:a_ITZz2vKbz7uSpmtDlVt7c8CZsoBa0TUgNsttOYuHjR4Pcs78MMaQ>
    <xmx:a_ITZ1EvsD9ZukNluvSylPWGF2MqMbTyG2_TtpPVBoHLvIGd1bMFsw>
    <xmx:a_ITZ8-HGcZ41aeN4y47O07m-IFSrhKH03FYZRQKHY6v0wUI72OE2g>
    <xmx:bPITZ5i5CdweGvqhR6iV8MpKwmu3KeEq9IXHRHcunupiUVSnPC1T1DNx>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 89776780068; Sat, 19 Oct 2024 13:54:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 19:54:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Seyi Kuforiji" <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <cb88194a-15d2-4c3d-8768-189853572ac0@app.fastmail.com>
In-Reply-To: <20241019163439.274656-1-kuforiji98@gmail.com>
References: <20241019163439.274656-1-kuforiji98@gmail.com>
Subject: Re: [PATCH v2 Outreachy] t7011: ensure no whitespace after redirect
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 19, 2024, at 18:34, Seyi Kuforiji wrote:
> This change updates the script to conform to the coding standards
> outlined in the Git project's documentation. According to the guidelines
> in Documentation/CodingGuidelines under "Redirection operators", there
> should be no whitespace after redirection operators.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  t/t7011-skip-worktree-reading.sh | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

I can confirm that there are no changes in this version to the patch
itself.  Which was expected since the change was good.

The difference in this version is that the commit message has been
improved.  At least according to my taste.

Thanks

-- 
Kristoffer Haugsbakk

