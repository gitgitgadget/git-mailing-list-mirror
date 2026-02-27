Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0D3EFD04
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191621; cv=none; b=As0TTG8dTGzJzDwX8tNu4H/hb2HAfcS1KAg/J1bH0KmIkLklcA5vk+DcJxlgfLq9xlp4Igs8Y17Q2CLHCDEy3IMAj2Y3EaD2Aam6StBs1PtCpMY9FG6p6bCNqyu12zREOZH+AFzMvo2Y0mkOBQ4bFyac7J/aemsQFd/y3PLTgMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191621; c=relaxed/simple;
	bh=VwaVmn1EgL6rJnddtme0NjhhhSF91a+A3AaZDo1NpPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XzuPDwh+tXCF0TbUeo23dNgFtXxRexHcDj8z4S13uZFBDtU9yqAHAiHR3BSRmJ/zzEqPjgtcSwR+a5/vhtphLixuXBZHeeHVS2txBTj3/SclQLp00Ilq2CAr+tw+FJqmqMFAngNnhrUFRhCU1yCXvrnhTJWiophFKdU5yqPZpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cKaYsg3d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRWTZdB3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cKaYsg3d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRWTZdB3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4DE69EC0B56;
	Fri, 27 Feb 2026 06:26:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 27 Feb 2026 06:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1772191616; x=1772278016; bh=Pjmmk4WZyB
	nKfuPHYWqJBj36AFahRwPZFISaXmqveas=; b=cKaYsg3dnKWN3GPnFSm1t8XccN
	XZj3/fKNoHUMHxBMu0HQs75QWG9u2GELsWOVPn6IeXivCTo1F2nuMpyghTtQFw8y
	qETLrxlGrVAX9A4XphEID4F1DaPwab5vTWPT4PCZT2yVL+Vu9ZQ1ErF0KkdjrJ1i
	MegKedPke2MpZ4jb5TYA+0fqMgxOpPsGDLyq6n0fT3LaQjail2JB7YvZybZUKuQe
	fuzAYNUm15eqZEUrNcVl5zspMKpn8soDdEFtNkZ575UYfBxw85PbAF4aMb0ARkFt
	fAIZ7FyL5m2eq55edvA9KOuQhHonKHfxiQqzHzd/PH68MYDlZzardhMvKHVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1772191616; x=1772278016; bh=Pjmmk4WZyBnKfuPHYWqJBj36AFah
	RwPZFISaXmqveas=; b=oRWTZdB3OrRu/PzGqCQ8GYDifpZ3hjnqDyc8S7XsfuDy
	dqSL/HQunQ7VqZiph+iprVY9wsfIZuBlPCyTuFPvWv0VOMAjDMejhHGPR3SxIcEx
	a+S1M+YRy+0G10fi1SKEyY/I/6tVs09WyULE5b0Rzn4VGXrNGzu6UYfYcayDlnRT
	ZanLG7zu1shoFodhYxFH3QUTm6wM3XM3YJaDCIZLtHh/1A1CEoaTZPzwWLtIR+JN
	NTYtiqjUwR2AFVDy4vhmgkBEXwyHap0zA3YRhU3ahRphwivvZUMfE8FVBonzNd43
	Z8dbITnh7T2aIP6w9RhY2mtiocOc3ivHgZoPr4p11A==
X-ME-Sender: <xms:f3-haXB1eWCNI18l-4AenAoRBiPv9MGNfE1hzHtSTckNrTuaTRVhFg>
    <xme:f3-haThADW96sZQ-ma8qPNpzNWHT1HAiFyqz4nNJTTaNcNETa0K7jGvRl7kuyW66Y
    xL175SPIGaUxSOuSmHSNatZn6HUu1lESP98Bf3kfiT1BZC8sJnFLA>
X-ME-Received: <xmr:f3-haQOePyjWRjAoFjWN-2_zQViSQKIOpxIKFsEMsI1OAHUfhDj-v8G4yNMB4TM63L4ypTd_W8UOxIM1zxqmhENwHhBknXW1goYkVgTu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    efkeelvdfggfdufefhhfdugfelhfefleehueeftdekgfffffevtdegudevteehieenucff
    ohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
X-ME-Proxy: <xmx:f3-haU5Cq7dlno2CWsf-aNeRqXZk4Zk87bELBP_yU4J7f2AdtTEm1g>
    <xmx:f3-hae3MK79Em-ElADh5laQWmR07tPsDkW1gpKugVurc6LsypthLKw>
    <xmx:f3-haVYa180P-DGe6sYGLfKFNP2XAsRQZdrHcghWzIkQNT0AXNLH1A>
    <xmx:f3-haWAtHJ0yLiQE4Iy1jDz_QpsQFvAk2ZSbCtGAGD-kWmD9ygZ6qw>
    <xmx:gH-haYwQ1dZKYvkDCPpedDfBodXpt_T7kAY7Yy3fkD60rw8W36SQZV5v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 06:26:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5d77acd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Feb 2026 11:26:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] upload-pack: reduce lock contention when writing
 packfile data
Date: Fri, 27 Feb 2026 12:22:59 +0100
Message-Id: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJN+oWkC/x2NQQrDIBQFrxL+Oh+MbVqSq4QsxDzbT4qKmrYgu
 Xuly1nMTKWMJMg0d5US3pIl+AZD35F9Gv8Ay9aYtNI3pfWd4575iK9gNo7G7vxJUsA2+AJfmsz
 Xy2ihBjc6TNQyMcHJ979Y1vP8ARlUMe5yAAAA
X-Change-ID: 20260227-pks-upload-pack-write-contention-435ce01f5fe9
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes some heavy lock contention when writing
data from git-upload-pack(1) into pipes. This lock contention can be
observed when having hundreds of git-upload-pack(1) processes active at
the same time that write data into pipes at dozens of gigabits per
second.

I have uploaded the flame graph that clearly shows the lock contention
at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/work_items/675

---
Patrick Steinhardt (2):
      upload-pack: fix debug statement when flushing packfile data
      upload-pack: reduce lock contention when writing packfile data

 upload-pack.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


---
base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
change-id: 20260227-pks-upload-pack-write-contention-435ce01f5fe9

