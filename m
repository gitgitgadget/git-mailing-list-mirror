Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC633987
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217870; cv=none; b=NON2e7ViWri68SJEMCC/gZYarACUILbY90hiMvFD017/MqmjTtxtvgRzRwXIq7qgJrojb1pcSk24Chk0jdMIlHs8ZvnIYT3eFcLQlh/HbPdeIThHx8KMuHiuu7j18wE8/i4r0gudfbE7ON+P01U2ZdIZVG4as6kw0fvBZ51oud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217870; c=relaxed/simple;
	bh=+GqcjI+RKHPHnfPfhkoHIfI5igMkmlqre7IGUlCQOXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6sJ4/xtHx2UdfFNP9lEwB4LoyzP+6VfuzCDoGDNfQ9w9JXhY6wdoDZN+ZQxw1L0MWfSAOSCbEUS3OmTSXPkKdAYlsWL6vY26W8s525vAAkisu3E/uSir+WsiakH/9DPso+f8pVundoHngCrYhYgaxwoobV4tvxbFM57/bZJBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZcY7fa8a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdMZSOa9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZcY7fa8a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdMZSOa9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7570D1140140;
	Thu, 30 Jan 2025 01:17:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 01:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738217868;
	 x=1738304268; bh=drkv6oUbCf5k8OoQeLC/gl6e6n6JaaUXtcSzA1cRku0=; b=
	ZcY7fa8aU3niKDhuXC7bhb6GnyS0vIvhTwfvZhXhi7GW0N+dmQad8s7TYYqRkjfF
	VYm9bdkfAXtJgl8fjWqfHUh8ov1RpY29SFUHwUARbs203MHGHboHNTiwbjnTLZRr
	k357mTn5gRRZhbwcF48OPP6JmO8atV+9bSsb1poadD5FzEdyXp61jY3nF4V3YcEb
	8qZaTSLEI080gEAey44ZOQu8keKkdK0LJwfQIDpLWc6Q2eHh3d8E4pfpo8IUII7f
	Q7vaalV2ZseWC3WJXCoGOTouEU+qEZ7jMpB7212b0YrnQm9+nqn7Srl8UEu4+POs
	ZkIn3A29C+6sV4iBBbXc9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738217868; x=
	1738304268; bh=drkv6oUbCf5k8OoQeLC/gl6e6n6JaaUXtcSzA1cRku0=; b=c
	dMZSOa97Q+8JZTmDAcQBbmu5ZKXifQKSAh2d2MWn+zGesh/9oe08F7iUG2HPirce
	dQq7tdVrFI8Yetm8ozm9gc7jHisipDdfRlzbBnPBie1ON2+gDcPGlz9SrAN22ubv
	KgAevHj6DNsrU3EJRV/1cfDytKbnUYO9FTMXhBNt4HvgKJlixnJ+LDJlKBcHeSJ7
	Y2S7F5IW/SxDq7pSX1LHyq09xahFMXzjTUsiz3qcGGym8c878o7qDoZ+aErTUeVM
	n2yjqs2NkHYfBVZUR//NP8PvUen3lj0O5SQt1orOvCFxy1rp64d1MbCsIE0cBsFB
	I187RUUxJBXD6AjgWKacQ==
X-ME-Sender: <xms:jBmbZ_STvNCvE_5CqB4ice9wgGur4jKd9z42iUujMYo249hKPHw_vQ>
    <xme:jBmbZwxTHpIuycTAoPzXqmwq0__tNWh6EO3nppfp08GzSkFk319Gva1VZGIWzGsiR
    RnfXsblJCNbXsQrXQ>
X-ME-Received: <xmr:jBmbZ0189mPmAl_y-5WU8B899c1E9O7tXj79JLm6rnKLJCEQnxpF9fgtDUyyCTJG2Ojvkqze4vA-z4TB2IuP-FH09GsM7nopROtKAZjVx4lp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:jBmbZ_CGf6WerRNBoR3dMXwoAs5B3Yp-coQlcy50xtwUhg_Kt99TqA>
    <xmx:jBmbZ4jYC8wywpODUME9v0bhgBY8ir0kzisFcVtXNHmOzttHokKctw>
    <xmx:jBmbZzr-25P_FFIe7On2HRB6CfVrx4NdOybGdmCNoSr01OVIBbv0Ig>
    <xmx:jBmbZzjsKLeYVMztZtAxayy6YSvr2pn1emj5O8FqNqrxMGjXcNzq6A>
    <xmx:jBmbZ7tudik0DrkxzY4mPy605SupBSG2J-n7tW63Gl07XmmH6irWQ4_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 01:17:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 465e81ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 06:17:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 07:17:38 +0100
Subject: [PATCH v2 1/2] unix-socket: fix memory leak when chdir(3p) fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-memory-leaks-v2-1-fc29dc7d4b19@pks.im>
References: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
In-Reply-To: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

When trying to create a Unix socket in a path that exceeds the maximum
socket name length we try to first change the directory into the parent
folder before creating the socket to reduce the length of the name. When
this fails we error out of `unix_sockaddr_init()` with an error code,
which indicates to the caller that the context has not been initialized.
Consequently, they don't release that context.

This leads to a memory leak: when we have already populated the context
with the original directory that we need to chdir(3p) back into, but
then the chdir(3p) into the socket's parent directory fails, then we
won't release the original directory's path. The leak is exposed by
t0301, but only when running tests in a directory hierarchy whose path
is long enough to make the socket name length exceed the maximum socket
name length:

    Direct leak of 129 byte(s) in 1 object(s) allocated from:
        #0 0x5555555e85c6 in realloc.part.0 lsan_interceptors.cpp.o
        #1 0x55555590e3d6 in xrealloc ../wrapper.c:140:8
        #2 0x5555558c8fc6 in strbuf_grow ../strbuf.c:114:2
        #3 0x5555558cacab in strbuf_getcwd ../strbuf.c:605:3
        #4 0x555555923ff6 in unix_sockaddr_init ../unix-socket.c:65:7
        #5 0x555555923e42 in unix_stream_connect ../unix-socket.c:84:6
        #6 0x55555562a984 in send_request ../builtin/credential-cache.c:46:11
        #7 0x55555562a89e in do_cache ../builtin/credential-cache.c:108:6
        #8 0x55555562a655 in cmd_credential_cache ../builtin/credential-cache.c:178:3
        #9 0x555555700547 in run_builtin ../git.c:480:11
        #10 0x5555556ff0e0 in handle_builtin ../git.c:740:9
        #11 0x5555556ffee8 in run_argv ../git.c:807:4
        #12 0x5555556fee6b in cmd_main ../git.c:947:19
        #13 0x55555593f689 in main ../common-main.c:64:11
        #14 0x7ffff7a2a1fb in __libc_start_call_main (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
        #15 0x7ffff7a2a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
        #16 0x5555555ad1d4 in _start (git+0x591d4)

    DEDUP_TOKEN: ___interceptor_realloc.part.0--xrealloc--strbuf_grow--strbuf_getcwd--unix_sockaddr_init--unix_stream_connect--send_request--do_cache--cmd_credential_cache--run_builtin--handle_builtin--run_argv--cmd_main--main--__libc_start_call_main--__libc_start_main@GLIBC_2.2.5--_start
    SUMMARY: LeakSanitizer: 129 byte(s) leaked in 1 allocation(s).

Fix this leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 unix-socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/unix-socket.c b/unix-socket.c
index 483c9c448c..8860203c3f 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -65,8 +65,10 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 		if (strbuf_getcwd(&cwd))
 			return -1;
 		ctx->orig_dir = strbuf_detach(&cwd, NULL);
-		if (chdir_len(dir, slash - dir) < 0)
+		if (chdir_len(dir, slash - dir) < 0) {
+			FREE_AND_NULL(ctx->orig_dir);
 			return -1;
+		}
 	}
 
 	memset(sa, 0, sizeof(*sa));

-- 
2.48.1.468.gbf5f394be8.dirty

