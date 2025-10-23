Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265A27A123
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203715; cv=none; b=q64XY9SZaboKWOVd4DyERZxrGPj9iejzIC10HxPnwKpTmqQHZPPO4M+zXWbq6uD2oH/w/A8QOGDz0FHih7aGac+09KNtK/9Fen3qm6n7t9cHc1i3GpphbxTgpwcgkT51IUgpLAK17zyfv/Fin3lb/gyyDy17gCnL9qUfbT7cH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203715; c=relaxed/simple;
	bh=LJCFbfFHwPTpndVsw0Hyh2gIIN5dfdKUVlmZerSJzCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NDz9J3YqK4hjLWFgQqu1B3VbVgL1l6FX747UehOGsMcI/Q8F2eHiBhXBBHREL39YbWJCdxJZWE9bC8e5rV40jUxTIk68O2trt7nR4N3fuBc5HT4QrByRDrObHLevai2lJSMzJjiw7uBD73KpNzKHZqHA7mVPVVygyf1jYkC4suM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l3dJJqhy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vXch16vn; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l3dJJqhy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vXch16vn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7F5E14001BD;
	Thu, 23 Oct 2025 03:15:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 03:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1761203711; x=1761290111; bh=MxKj3nNSx0
	LoOUUT6+lgLQgq9cRVgTPvgMsdVSKq6N8=; b=l3dJJqhyBCKFrmudFxWAjnuT8F
	RWwBjrUCGEtjrX54rtFSeJqIchEgI7aKK0uw2TU8scGo5kU4wTQ8t6w4hWUPa01W
	A72pEWzPwBFS73JVcGcYZk4ckOkfQAdyE/GpS6fl3HNcAapsDDs7M18LpIWcmo4D
	ec+3uXCIRpg9B2mxf8X7VfIyxRALNoaQNVkneW59qEVVgD/S0xScxBKKCBYPlpxb
	Eqnx5JGR7eN9DwHP0tZvN2plDtgyatqA8w+a+3bx8N/sqdL9mFlGYbzyGCvXVSK5
	HJOW6tJpUM7AQorkit8/O7avhrOSb/BR+QLTrhBb52h280vZhqsRsH9+TsRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1761203711; x=1761290111; bh=MxKj3nNSx0LoOUUT6+lgLQgq9cRV
	gTPvgMsdVSKq6N8=; b=vXch16vnmyfKDGcMw/WMbg1eZnHN1NRzqAjiKdN1VSHx
	OrmbqNd4EXjWdbCJu9kd/AFt6pEjrIfoG/cnnUMFOsp9RNlVjJYkcu2LUnefNjXS
	HFirZv1YXFZF2RqlkAxK72hf02iGRz8m+t90N7nfmZViM+awa8PerZJvi6/a0lai
	FBnpGM3OKWn0X4uYIVJv71VlpDhrAxO89SvPXqUWQs2rGdETe1ayZTJIZmva6NgG
	S4Aqj/QOIZxRShC+VTQm+HOEl1KBQiJjHvYmZQHUQ/hBHPNoIHjw7VmI2fNTLkhu
	f7Vf8uMG9qDWAfEEUShllb5D9+z0JdLupen5oK5BUw==
X-ME-Sender: <xms:_9X5aL94xZtPsLRAtmS0SR3vY_Qq4yD9e3Dr7QPGcBCJ9i422x-rjQ>
    <xme:_9X5aOnp0MooLT3OguPcQSWjp85RhwWyEniK3XT4m2Wri_4h8OaAK6F7IOzYh6yiN
    nMQqMYFOeorvBfP7FI26oXcJGatZIaKuQ7uD34nS3YYGW63E5O1pg>
X-ME-Received: <xmr:_9X5aBWB-WBIqcmmv45byBVRHIcdF0F3REVm4qm47sTPpe0FbkeUsOdNwVFIeZ8GDtF4BxqWLF0K4WkGBJ1fe8mLlrDdRvvJkg1AK83LFznVkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhkefffeffuefhhfffgfegteekteefjeegjeejgfduvdfhffehffehgfefjeejleenucff
    ohhmrghinhepohhpvghnshhshhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrghurhhisehhrggtkhhthhgvph
    hlrghnvghtrdhfihdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepgihrhiduudduseigrhihudduuddrshhithgvpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_9X5aDH-MS_X_eDk2CSv5BEKHEre53ZX2qG7XGRKviovVQNVNhy3Pw>
    <xmx:_9X5aNf96goU0CqtIuqMaGVWgry3rZn6JaKHt0NG5odDVtURsMeyqA>
    <xmx:_9X5aEKYTT60pTYNNtNcuRMSQ8dgCR9eBiTG5JbX93aAcaKN8TasYA>
    <xmx:_9X5aCFo5iwUXp2yx1twNmu4M4gd_JEGt7FHk_FZ2GFaFClgQdHmKA>
    <xmx:_9X5aJjwe5DqLD0N0YE09kQ0jAqt5hwszg-GsjkBs4H1HsMCYL7E86wt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:15:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0180d1c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:15:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:14:59 +0200
Subject: [PATCH] t7528: work around ETOOMANY in OpenSSH 10.1 and newer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-v1-1-f15eeec199f3@pks.im>
X-B4-Tracking: v=1; b=H4sIAPLV+WgC/x3NQQ6CMBBG4auQWfsnUCyoVyEuCgylQaek0xgTw
 t1tXH6b9w5SToGVHtVBiT9BQ5SC5lLRtDrxjDAXk6mNbWrTYrxi3xS5t+YG1RXOs2RonDbOEPd
 m5BjxiuLR3Rc323bsenZUinviJXz/t+F5nj83IcG5fQAAAA==
X-Change-ID: 20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-69fad53b67ea
To: git@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Lauri Tirkkonen <lauri@hacktheplanet.fi>
X-Mailer: b4 0.14.3

In t7528 we spawn an SSH agent to verify that we can sign a commit via
it. This test has started to fail on some machines:

    +++ ssh-agent
    unix_listener_tmp: path "/home/pks/Development/git/build/test-output/trash directory.t7528-signed-commit-ssh/.ssh/agent/s.UTulegefEg.agent.UrPHumMXPq" too long for Unix domain socket
    main: Couldn't prepare agent socket

As it turns out this is caused by a change in OpenSSH 10.1 [1]:

 * ssh-agent(1), sshd(8): move agent listener sockets from /tmp to
   under ~/.ssh/agent for both ssh-agent(1) and forwarded sockets
   in sshd(8).

Instead of creating the socket in "/tmp", OpenSSH now creates the socket
in our home directory. And as the home directory gets modified to be
located in our test output directory we end up with paths that are
somewhat long. But Linux has a rather short limit of 108 characters for
socket paths, and other systems have even lower limits, so it is very
easy now to exceed the limit and run into the above error.

Work around the issue by using `ssh-agent -T`, which instructs it to
use the old behaviour and create the socket in "/tmp" again. This switch
has only been introduced with 10.1 though, so for older versions we have
to fall back to not using it. That's fine though, as older versions know
to put the socket into "/tmp" already.

An alternative approach would be to abbreviate the socket name itself so
that we create it as e.g. "sshsock" in the trash directory. But taking
the above example we'd still end up with a path that is 91 characters
long. So we wouldn't really have a lot of headroom, and it is quite
likely that some developers would see the issue on their machines.

[1]: https://www.openssh.com/txt/release-10.1

Reported-by: Xi Ruoyao <xry111@xry111.site>
Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

I now started to see the issue reported in [1] on my own machine and in
our CI. I couldn't find a patch yet, so I decided to take the discussion
that happened in this thread and cast it into a patch to fix this.

As I am merely taking what others have debugged and agreed on I went a
bit overboard with giving credit.

Thanks!

Patrick

[1]: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
---
 t/t7528-signed-commit-ssh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 0f887a3ebee..b50306b9b39 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -82,7 +82,7 @@ test_expect_success GPGSSH 'create signed commits' '
 test_expect_success GPGSSH 'sign commits using literal public keys with ssh-agent' '
 	test_when_finished "test_unconfig commit.gpgsign" &&
 	test_config gpg.format ssh &&
-	eval $(ssh-agent) &&
+	eval $(ssh-agent -T || ssh-agent) &&
 	test_when_finished "kill ${SSH_AGENT_PID}" &&
 	test_when_finished "test_unconfig user.signingkey" &&
 	mkdir tmpdir &&

---
base-commit: c54a18ef67e59cdbcd77d6294916d42c98c62d1d
change-id: 20251023-b4-pks-t7528-ssh-agent-socket-name-too-long-69fad53b67ea

