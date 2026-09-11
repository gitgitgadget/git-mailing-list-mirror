Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87466563FCE
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160991; cv=none; b=SGxov4QhskpEoWS+guL1Zg1WAKum2sEJuXqZGPRkdpsYOMx4nr46YtxnPdVxPLYff4pyBZ3obHNLvSS65F7fHYUHM7H+Ay3x1SLel2JVfwoNrRb+hgWmmJcjSC1LxoLEGsHfWrTWq/VygY678Fslu6BfV1Q6oCL3wxTDL7RB41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160991; c=relaxed/simple;
	bh=DK+pnqjZC6iOv4zzOKS+Va24TxBOP3kjuScdCrYmhtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKAGygfpJ5VurkTFZ1HZP/fsyCAXdJnRxr2Z6z7aNf88L0B1yK6wfFgCrkBeIs2/DV6v/zRNFpMMgV9S/yJ7ZXJ1Xoke0y+qQ0wP4xVXa2/faJvyYVi3eQRXy4zJOq4D6UfR7+QtJpKquG9OCbs9E9lUMiFqBuUmHAk6X++oBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h4yEDUkL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZWnFVivA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h4yEDUkL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZWnFVivA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 658317A0011;
	Fri, 11 Sep 2026 17:09:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 17:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789160988; x=1789247388; bh=qKmj3P/aeQ
	X8hwgIyU7aWUM82uXJselJIV0VfZREs2Q=; b=h4yEDUkLZNfmZzImtgCoGrNvqJ
	afrGWeVY7cURJdK6++lfZnQU9BYLhMQeazIj03ZKrlGaXv0tNzNIk2IWGMU+dMYB
	0j3FA7m2q496J+6IVw8Uid8AMXSafk8dqg5iCIeujyhxoRU3FXFOexdQIzt1NeHD
	o9PBLEEoblYh0OYbWBpdZ7aH7sZnk7566x+P79iUSGHyCVIh+2xL0T4YIvUZji9M
	dkxlLvWHbugEIKVdbz3S8t9i7t4802GeuayKN5fXLUrhiiCibErEChO0vI/Md5LH
	3iNeQFzDp22g6VG6gMHv4i/0O1nz5/v9PXCyx6g3pDKIPPP4MjHTWyRokabg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789160988; x=1789247388; bh=qKmj3P/aeQX8hwgIyU7aWUM82uXJselJIV0
	VfZREs2Q=; b=ZWnFVivAxrcDvaHTdtyMPRdzLuCK313qMZ8C+6Ixfk50MTbXnF7
	RIN93L9abrmt01ZHFyElW2Ff8C1auRljIfD7aaPKJNV+b4YN75h6fD/6JEsZ5y0I
	N9LpFhRAilHKaOFCOAeb5PKBgy64P/WwifoBzAGsOm6CqSIUaUmdK1+AgaAz7Mje
	rGNdHauFrzvsZlMIALrvI+v3Gm9AStUmSrxKNC5ScA39AvN3sXW4t9AnPoSUCR9w
	XNeYVVP38Q6/O7xhfRbCO/MN34e4cQXs+tbbpGSzLhGcuxRY+iBoi0iPHP8BDjnX
	pUPdo9uMnRrPEVlxk5lKhZFi9ZhhzjzlD4Q==
X-ME-Sender: <xms:HG6kaj2oTFja5lwW7Wjgksr8BYEmlbItODEvdRgrbLwI2-iZkUohHA>
    <xme:HG6kaqjKyb4ls33g5245GgpmtRhgEuAlhFPqz8jKmzTUP-gSwnrIB-zPit8lpGWgA
    0XlN6Zm3fS6wXwLlZ--7Q9LJo_TzfwPdSRe_vDmhSt8QirmDqvbRqg>
X-ME-Received: <xmr:HG6kakWpy-41LuGEMlKL-pC3CjE80XLMq8BixZEE2rqUDfivLJT-zspy0HYV5crh-iD8RLUihz1uiKTJN0Vyc6WKL3XyQQCUyKQZ>
X-ME-Proxy-Cause: dmFkZTGLp28X9ylhQ1yRKnW5W4wdX+ghFrbZt0vTV4EBIRUj5az/COn6CMPaMEw4rBSfg7
    zhd7wgtDz/oVY3da2I9701T0O2s69BZhPytcxzX+JBKpuGJ7Yh1FrbiUlsCBHtjYBmioRd
    T3MQMsaJRJ2l1FTiUiep3aYs1X6eBSxdT77xxNjWLbaHu9nksMe/tTZKnO05IObcU7d/1f
    bFUMZm8OG5JBKyTAtUn7bBkP1P0tYFmB2lEc3uR8DFOVggrL9EOAIILjaAgqQJcybSiZDU
    dSerHNNd/eKxFjNVSxget855ivT3qVugegRJQBghBx8o08yCew3LGFIV9NMMq4+/4GOLSQ
    kHW2bVZlk/WIMqT/jf5LUldnfh6P68FaVQx6WekUBjyWCDze1AxVNi/75/J5KnS2uVQ2LE
    8fsKTu0Yp4GZ9Pl2bxhwKeEs4kam31IKhO1SG+csfAK/xwrUt079h8A9rOJYsbMGYcnlZF
    svtSgBpX4yCp129a4vRZD7nPxMlqS1UTz4E3zScFHrXWH1YTpT3NZsQwYa+2TvdD0EXSQ+
    t40QedzWgGFfsBGyVnLxKnp63exr+enPIaLMMI6g9Ejg8dWIAwPd/n8Eg7C0AZGvDq0hkR
    eDxU77FLfKem6oqCfZLihAjJIw1TcVCnHsYhnh0Q5ehb2A/IitpjzbF0U69A
X-ME-Proxy: <xmx:HG6kapXf3O4VBmUObd8CgL6Hz0uHCs5lyTD2HFHDVDONPZEoy3yFug>
    <xmx:HG6kakgvdwd8L7ojK6geGN0lcQRvN-5goTKLdb_srbVjQHImG7NFZA>
    <xmx:HG6kakZIolbDuFqvgqwjyb206MPXvM8ei9KwB7gM9AjOL7PQH6RnZQ>
    <xmx:HG6kahquXQN5U-AYp_Y4Yk1FJTLro1nmzTbPgex9eD267pCDeL_dVg>
    <xmx:HG6kahRFgMXBSpIG5xjJXDR24rEO33UZhr1mjzGR8Xfi9mxTU1_BrCK4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 17:09:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
    "James Le Cuirot" <chewi@gentoo.org>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
In-Reply-To: <6567eceb32c1bdcff5927c6baf0cadc97af7485b.1789153730.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Fri, 11 Sep 2026
	19:08:49 +0000")
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
	<6567eceb32c1bdcff5927c6baf0cadc97af7485b.1789153730.git.gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 14:09:46 -0700
Message-ID: <xmqqa4pna411.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -993,6 +993,7 @@ endif
>  ifndef DEBUG
>  CARGO_ARGS += --release
>  endif
> +CARGO_ARGS += $(if $(CARGO_TARGET),--target $(CARGO_TARGET))

Should this use CARGO_BUILD_TARGET (instead of CARGO_TARGET) to
match what the officially supported Cargo environment variable is
called?  It would also help us work better with the changes from the
jc/rust-cargo-build-target topic.

Thanks.

Author: James Le Cuirot <chewi@gentoo.org>
Date:   Thu Sep 10 11:20:14 2026 +0100

    rust: respect CARGO_BUILD_TARGET when locating build output
    
    When cross-compiling, Cargo always writes to a target-tuple subdirectory
    determined by CARGO_BUILD_TARGET, even when it matches the native tuple.
    The build looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed to
    locate the freshly built library.
    
    Respect CARGO_BUILD_TARGET in the output path so the correct artifact
    is located.
    
    Signed-off-by: James Le Cuirot <chewi@gentoo.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/Makefile b/Makefile
index d4b775953d..f0ca2e4f72 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target/$(if $(CARGO_BUILD_TARGET),$(CARGO_BUILD_TARGET)/)$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 75f3cd1265..83c7e7b79b 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -38,7 +38,7 @@ then
 	exit $RET
 fi
 
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
+if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
 fi
