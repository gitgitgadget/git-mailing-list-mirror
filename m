Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8AB1A4F1B
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568654; cv=none; b=YXdmEhSCJbgdniKIF/RSDB/GK2jLOSim4V7xaMEtyG1G77ZGFdIps2xgKRnFDTVwtl/zllljAOfzIjEcnoXQk2e4s2mjnUzaoFn3Z6Z62T0mWPgC4pM/Xy49/UvEK0xq/mTlO3d0hK07zoZVwkkG+Zg++ESWdDTpyEhxy6J2/ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568654; c=relaxed/simple;
	bh=Gu2d1mFr+xho7l6+ylwIKxjF05M1V+4b6bJtlGJ4EtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISlEkKYd0aKKQKYp+3YgW/WHAvTMOrahh4KoaMq9/gBOgY5fp1cEpx2nwewD+yXmAddnkkfD9JHtuoEy5FlaVv1oDxe3OfCCgAMoo7vfFuUusC/fQadjYMUAcMjWhewf2Rpf/XNSPxVlSaCfRVxhBCGyTss0kwmx96muQG3owD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ggq4u6qe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbKyB/9I; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ggq4u6qe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbKyB/9I"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB41425401EB;
	Mon, 30 Dec 2024 09:24:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Dec 2024 09:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568651;
	 x=1735655051; bh=octC69/NnKGkrseXmGfLiIr4R/ZslPAJ9Unyj9WG8wI=; b=
	Ggq4u6qed2LzYAUI97Hb9mSCHeJN5Hc3zo+AVB3RHbXC0UwnETbvQgAFVnTMjJdo
	vpuVuZ8zA5SYgued7i6z2lU810VGu7Tmdis9DItDSBWzr8dFXmarIcF7Uh87ds+i
	k6zBtYFOKCUDMqQZZiY4qYNEHKRiVSWzFwjreIwUPzSkb6kFhD6OFcRzR9orQjrS
	G0hD2F1TAgn1IJ1IE4u205+ZFFCWCqagADB7zYlEFiPoPvkwGXFKMJHSvPxMQBBT
	2A7Cmt33r/K/WtlPhkJEn3XjzajSXSnVStJ+EoTjAfdN/hP0OoQv4EE7aO626aHx
	t+qzULIoZPxqqarG5JAsZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568651; x=
	1735655051; bh=octC69/NnKGkrseXmGfLiIr4R/ZslPAJ9Unyj9WG8wI=; b=r
	bKyB/9I+6i47mc3yNXrVEXSW/vpAbJCbmHTA01Hc23abFNDjcsVsj+E3aqMdiUus
	/HQpdGA8c2OBh90HrFdGMVj0+1Z5S6udVvTkhzMuEsVZQYYZ9N1irjiNzllPYEJn
	y+BXn3pfdTpIsYAOmUvzpPJtNuwkhN6OixKX8p+cdHP8CeIzAaqvdkoRjnZHB2+Q
	htoexv1BP5nXD4qfpI2D1RukOKJ6WNSoPlpFwUJFylGC8hGlZmUwe7q/HygE3GN3
	onxfX00Ww5Bn5oyVWGGPGG8Obwhgy2UTqCHfjwg8V4FbS2E2a8OpG1aVAGnswz5m
	/bowNKc3qSYQHVc18/g8Q==
X-ME-Sender: <xms:C61yZ5CC5MC8XBOg91-HK-Gh1nJgwVZrrRvyCzD5dEAeLDpIsmSlTw>
    <xme:C61yZ3gTT_Ngj2q2-6MHb3GKZ2cCzEJn9g45lwQjmKrdiNz5Uh4oEbtdAsNYVfiYR
    BL8Az26x5QJSG7RbQ>
X-ME-Received: <xmr:C61yZ0lyKZ6q5tXBTZVxb4K1e8nHd-RzL0EdxE_RgSVvoZBWb73gqvAwhwL47NAkNDaqpCUdfAxAfQQKNU0HVp0xLnMfd2qOFMbpFh15ur36-dgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C61yZzyrgoLyfgLuCP5qHEc5iF0UTmhByZd-caOybWiR8vbBU4xgew>
    <xmx:C61yZ-SUDhefMQkaMtJYodjp58ND1iEJ2DUgCokLCos2-QlJ5h7nCQ>
    <xmx:C61yZ2bZEGZWMmVaWzB_sJbyl0daROEE2MG6XajdBGukbExQbL5ypw>
    <xmx:C61yZ_TFI-l80TApGy-IcEPrSXJsDajOPTShWva6e8rQCfyOpw5O9A>
    <xmx:C61yZ8fFmEoi7_ZQl5__uxVad1kyVSjyv80gs8HKTPLA1ikjvRZ4L20A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 857233b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:02 +0100
Subject: [PATCH 02/10] builtin/fast-import: fix segfault with unsafe SHA1
 backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-2-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Same as with the preceding commit, git-fast-import(1) is using the safe
variant to initialize a hashfile checkpoint. This leads to a segfault
when passing the checkpoint into the hashfile subsystem because it would
use the unsafe variants instead:

    ++ git --git-dir=R/.git fast-import --big-file-threshold=1
    AddressSanitizer:DEADLYSIGNAL
    =================================================================
    ==577126==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000040 (pc 0x7ffff7a01a99 bp 0x5070000009c0 sp 0x7fffffff5b30 T0)
    ==577126==The signal is caused by a READ memory access.
    ==577126==Hint: address points to the zero page.
        #0 0x7ffff7a01a99 in EVP_MD_CTX_copy_ex (/nix/store/h1ydpxkw9qhjdxjpic1pdc2nirggyy6f-openssl-3.3.2/lib/libcrypto.so.3+0x201a99) (BuildId: 41746a580d39075fc85e8c8065b6c07fb34e97d4)
        #1 0x555555ddde56 in openssl_SHA1_Clone ../sha1/openssl.h:40:2
        #2 0x555555dce2fc in git_hash_sha1_clone_unsafe ../object-file.c:123:2
        #3 0x555555c2d5f8 in hashfile_checkpoint ../csum-file.c:211:2
        #4 0x5555559647d1 in stream_blob ../builtin/fast-import.c:1110:2
        #5 0x55555596247b in parse_and_store_blob ../builtin/fast-import.c:2031:3
        #6 0x555555967f91 in file_change_m ../builtin/fast-import.c:2408:5
        #7 0x55555595d8a2 in parse_new_commit ../builtin/fast-import.c:2768:4
        #8 0x55555595bb7a in cmd_fast_import ../builtin/fast-import.c:3614:4
        #9 0x555555b1f493 in run_builtin ../git.c:480:11
        #10 0x555555b1bfef in handle_builtin ../git.c:740:9
        #11 0x555555b1e6f4 in run_argv ../git.c:807:4
        #12 0x555555b1b87a in cmd_main ../git.c:947:19
        #13 0x5555561649e6 in main ../common-main.c:64:11
        #14 0x7ffff742a1fb in __libc_start_call_main (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
        #15 0x7ffff742a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
        #16 0x555555772c84 in _start (git+0x21ec84)

    ==577126==Register values:
    rax = 0x0000511000000cc0  rbx = 0x0000000000000000  rcx = 0x000000000000000c  rdx = 0x0000000000000000
    rdi = 0x0000000000000000  rsi = 0x00005070000009c0  rbp = 0x00005070000009c0  rsp = 0x00007fffffff5b30
     r8 = 0x0000000000000000   r9 = 0x0000000000000000  r10 = 0x0000000000000000  r11 = 0x00007ffff7a01a30
    r12 = 0x0000000000000000  r13 = 0x00007fffffff6b60  r14 = 0x00007ffff7ffd000  r15 = 0x00005555563b9910
    AddressSanitizer can not provide additional info.
    SUMMARY: AddressSanitizer: SEGV (/nix/store/h1ydpxkw9qhjdxjpic1pdc2nirggyy6f-openssl-3.3.2/lib/libcrypto.so.3+0x201a99) (BuildId: 41746a580d39075fc85e8c8065b6c07fb34e97d4) in EVP_MD_CTX_copy_ex
    ==577126==ABORTING
    ./test-lib.sh: line 1039: 577126 Aborted                 git --git-dir=R/.git fast-import --big-file-threshold=1 < input
    error: last command exited with $?=134
    not ok 167 - R: blob bigger than threshold

The segfault is only exposed in case the unsafe and safe backends are
different from one another.

Fix the issue by initializing the context with the unsafe SHA1 variant.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1fa2929a01b7dfee52b653248bba802884f6be6a..0f86392761abbe6acb217fef7f4fe7c3ff5ac1fa 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1106,7 +1106,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
 		cycle_packfile();
 
-	the_hash_algo->init_fn(&checkpoint.ctx);
+	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
 	hashfile_checkpoint(pack_file, &checkpoint);
 	offset = checkpoint.offset;
 

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

