Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F49443
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568655; cv=none; b=DNVyKwXCJA5Rvx01ykDomVkBpGf28wh1GR85V2JUgTFPXfny357u567SdKA7C3QnrlpLqPh9orgXJTUJEGre+4fhMPX9p06dUdxwXiXQh/N+mengWElJ5RbdksqTs/PxtMBWf0LEdiRCURYJPcK0C4SpeqTtmh8xyJPqHAAlCHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568655; c=relaxed/simple;
	bh=Pug/m8sPhsOHH8ScVuYAZQ8T+NVeFS8olj7JGKzLOVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYPTGeJfOZh/IeRuaNneXsRbT9Uf4ygJWM+rKenniUg/Bncis/ddiiM7Z25NeYfGx93/+k7a2417cDFfp2Ni1AviKMm0mcq9l8ArR+B+yxDrcf70DjSgXIeo3hx6FPZUqThO7QAcDpaxnAtKRdeL5buoz+fAySltLAcZbS005pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jlA0bG2L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pR+Z3yD7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jlA0bG2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pR+Z3yD7"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7C0A325401EA;
	Mon, 30 Dec 2024 09:24:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 30 Dec 2024 09:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735568651;
	 x=1735655051; bh=DZsyb48ekzt9AlLPCt5u+kD4bPRJqPOp4oYmUZ28aDw=; b=
	jlA0bG2LGZ43KdR4yynzNkSPhoFawJUavxOKAJ2qeeqYc1pwvNCKg9PGBQkaJ/VU
	zw7xyRAUZxiLkoZkjHgblc1buPxACVBPigLy44EJmME+b+fxjDgt67x4LHfY1qSa
	3jvuKRXlSkSuAQ8fFsv+cINJ2C+Q9wYqncfGdhbh7/5gSoCM3mIcpr4826Qb2NnZ
	lCDbPv0mggVeOA9rDzUkq0FJPjFqhA4U7yE/eY5Uu01ToIbedPvgrQj27oZv8Wtn
	sNucqHNxdTTeazZYkdNtrg5PskZAgKd0w2gIvRR/gLhQkeY4FFsrLrcOsN9ahUIR
	Zw0NHjsoT3RfTK/9D7cXWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735568651; x=
	1735655051; bh=DZsyb48ekzt9AlLPCt5u+kD4bPRJqPOp4oYmUZ28aDw=; b=p
	R+Z3yD70P3bWlQgrorXjlJdoO8DKzgJneqOCCKYxgm3pj2Ziqq2Jd5gefoD7nWe5
	/BXjA0oZFBbA9VH3cBemTFOYotRvF1nXi7RTQmdlV6akNDZrcRYw2JsReGWkUSBX
	ezycKkg4QlPtl8HBLjlhN+pHkkgyiY3RdIKTJV1W9WvF0uHYoTUWypDisP9/TIuI
	tm2zuCh8MLApKCd6w/ewGLIOt5WZyQNm+T/VOD7Q8GviG49XNUE3AsPXEetQVwcG
	O73+H5vd0pavHrQpkWPF0Gmm1V+D6+mLUSIQtZozWazAcRKhWoMtu2km57+tR/zT
	AwSaGDw/tBAPdnjdd5kjg==
X-ME-Sender: <xms:C61yZ0E2yq2-2vrAL0w8eA1t1efOTMgB5xbaHVsx1JtnooNh6JACSA>
    <xme:C61yZ9WbuVWF918WL3WHD3Tb8GY6wkKgohma9r3xRlADqvr15OsMVOrnLh4XDYPHT
    HQ2Mkv155LRzjuRrA>
X-ME-Received: <xmr:C61yZ-IPxZfTX9PFje3ZyyBWEXmD-I7SQmexv0r01TWuljwNa28xsyx7T6kZP6ELeLxwhe2WvNzXKNrSEX8FOKuHO_mchN2jUDwp73dNY6TIE4aa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddviedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C61yZ2E7aJAqEY8gZsTlKwZmnf9Mm_RN4jqO0bI9K9p91ZW6jBZCiQ>
    <xmx:C61yZ6UyajkOBAgt9A3m6QobrxCUlPYKArXMIUo1pVTN2KBEGJurhg>
    <xmx:C61yZ5NquiL-OwGMoJ2cY9HEkV2GAHgoT292A3StujuM41fpO1pQHA>
    <xmx:C61yZx0EQXEmb_UXdR-FXzsb7RJrsc8f1ds4GovYPLw-0UTam7OaoA>
    <xmx:C61yZ5RvINwF31hVg8lAphkxmRJKdmkQ7EqYxiQnW6S0TJ-_yl5Sf6m5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 09:24:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28cc0641 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 14:24:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Dec 2024 15:24:01 +0100
Subject: [PATCH 01/10] bulk-checkin: fix segfault with unsafe SHA1 backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-pks-meson-sha1-unsafe-v1-1-efb276e171f5@pks.im>
References: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
In-Reply-To: <20241230-pks-meson-sha1-unsafe-v1-0-efb276e171f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 1b9e9be8b4 (csum-file.c: use unsafe SHA-1 implementation when
available, 2024-09-26) we have converted our `struct hashfile` to use
the unsafe SHA1 backend, which results in a significant speedup. One
needs to be careful with how to use that structure now though because
callers need to consistently use either the safe or unsafe variants of
SHA1, as otherwise one can easily trigger corruption.

As it turns out, we have one inconsistent usage in our tree because we
directly initialize `struct hashfile_checkpoint::ctx` with the safe
variant of SHA1, but end up writing to that context with the unsafe
ones. This went unnoticed so far because our CI systems do not exercise
different hash functions for these two backends, and consequently safe
and unsafe variants are equivalent. But when using SHA1DC as safe and
OpenSSL as unsafe backend this leads to a crash an t1050:

    ++ git -c core.compression=0 add large1
    AddressSanitizer:DEADLYSIGNAL
    =================================================================
    ==1367==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000040 (pc 0x7ffff7a01a99 bp 0x507000000db0 sp 0x7fffffff5690 T0)
    ==1367==The signal is caused by a READ memory access.
    ==1367==Hint: address points to the zero page.
        #0 0x7ffff7a01a99 in EVP_MD_CTX_copy_ex (/nix/store/h1ydpxkw9qhjdxjpic1pdc2nirggyy6f-openssl-3.3.2/lib/libcrypto.so.3+0x201a99) (BuildId: 41746a580d39075fc85e8c8065b6c07fb34e97d4)
        #1 0x555555ddde56 in openssl_SHA1_Clone ../sha1/openssl.h:40:2
        #2 0x555555dce2fc in git_hash_sha1_clone_unsafe ../object-file.c:123:2
        #3 0x555555c2d5f8 in hashfile_checkpoint ../csum-file.c:211:2
        #4 0x555555b9905d in deflate_blob_to_pack ../bulk-checkin.c:286:4
        #5 0x555555b98ae9 in index_blob_bulk_checkin ../bulk-checkin.c:362:15
        #6 0x555555ddab62 in index_blob_stream ../object-file.c:2756:9
        #7 0x555555dda420 in index_fd ../object-file.c:2778:9
        #8 0x555555ddad76 in index_path ../object-file.c:2796:7
        #9 0x555555e947f3 in add_to_index ../read-cache.c:771:7
        #10 0x555555e954a4 in add_file_to_index ../read-cache.c:804:9
        #11 0x5555558b5c39 in add_files ../builtin/add.c:355:7
        #12 0x5555558b412e in cmd_add ../builtin/add.c:578:18
        #13 0x555555b1f493 in run_builtin ../git.c:480:11
        #14 0x555555b1bfef in handle_builtin ../git.c:740:9
        #15 0x555555b1e6f4 in run_argv ../git.c:807:4
        #16 0x555555b1b87a in cmd_main ../git.c:947:19
        #17 0x5555561649e6 in main ../common-main.c:64:11
        #18 0x7ffff742a1fb in __libc_start_call_main (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
        #19 0x7ffff742a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/65h17wjrrlsj2rj540igylrx7fqcd6vq-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: bf320110569c8ec2425e9a0c5e4eb7e97f1fb6e4)
        #20 0x555555772c84 in _start (git+0x21ec84)

    ==1367==Register values:
    rax = 0x0000511000001080  rbx = 0x0000000000000000  rcx = 0x000000000000000c  rdx = 0x0000000000000000
    rdi = 0x0000000000000000  rsi = 0x0000507000000db0  rbp = 0x0000507000000db0  rsp = 0x00007fffffff5690
     r8 = 0x0000000000000000   r9 = 0x0000000000000000  r10 = 0x0000000000000000  r11 = 0x00007ffff7a01a30
    r12 = 0x0000000000000000  r13 = 0x00007fffffff6b38  r14 = 0x00007ffff7ffd000  r15 = 0x00005555563b9910
    AddressSanitizer can not provide additional info.
    SUMMARY: AddressSanitizer: SEGV (/nix/store/h1ydpxkw9qhjdxjpic1pdc2nirggyy6f-openssl-3.3.2/lib/libcrypto.so.3+0x201a99) (BuildId: 41746a580d39075fc85e8c8065b6c07fb34e97d4) in EVP_MD_CTX_copy_ex
    ==1367==ABORTING
    ./test-lib.sh: line 1023:  1367 Aborted                 git $config add large1
    error: last command exited with $?=134
    not ok 4 - add with -c core.compression=0

Fix the issue by using the unsafe variant instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bulk-checkin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 4a70a70a951cfd1a488339a33bf3a76b5152a344..433070a3bda461a2ad62da67cc5515f8822d2df3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -272,7 +272,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 					  OBJ_BLOB, size);
 	the_hash_algo->init_fn(&ctx);
 	the_hash_algo->update_fn(&ctx, obuf, header_len);
-	the_hash_algo->init_fn(&checkpoint.ctx);
+	the_hash_algo->unsafe_init_fn(&checkpoint.ctx);
 
 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) != 0)

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

