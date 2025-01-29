Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517433981
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167862; cv=none; b=nBNHcNiYKZ0/Jagli4nzV9os1IJNRW4vTzkC1dOUt1oB9Nk4zTQtj98F1dIiSN97IFPvd6+QXCkltfX7zeNsyP5t+i40MbvBzWmuxEFdCqbkUJeJLvUepCQljQW8u2Vg414ykItBFvtWDjKgCpH8c0MDY4Nbjn9SRdLj3TtnvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167862; c=relaxed/simple;
	bh=gNcLKj6BF/dF6Q9x3xhBWXnrH6WSm62xHFcq7jegqys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=eDVABOTotfzIxd+FPFvD9ZgZMOzivPvgL8fMZ5ksmMcqX6Wf+b9ZgiV2kpYCSn/53z5S1zi5P3lCTdz6qfJLLZZupsbt0mxjCmrXYSgHshbGyPE0uKMNRhY2/aq4MhJO13uZsnfNGvfAQZNxC6wWZ4AFONjCU1uMaMFNa0qXbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQMtQnFU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0ELNMQfi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQMtQnFU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0ELNMQfi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D073B1380B1C
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jan 2025 11:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738167859;
	 x=1738254259; bh=1aVpw2VtOckhmrUyo+hUSozBk0BKSyJ8lBXtB+PxAf8=; b=
	NQMtQnFUImdC1W6I+43LBA7fbVFsIkOYW600mo+sOUyrVD8YSK+rWW3CRP+4urPq
	bXPggw2puhBiYV7NwLZgnr9siBurS44n+KlOpZV3+Lr/sUsbB92XdsyxJjn1ddlp
	qoeD7w3K/25kFpldo8JUHqFim2saG3kP8Use7zUtxtAZgXUrOmCEsJIfCbb0WNG0
	lk23f+Psd6ibcDC/gT5er21dBU/XdyEv4PUioTDhnHcyv1tKbQTAR2h3ruI0tvrJ
	kVc9BhbDnQFTMqd2v/SIH+JuCALlsrPHOTVhg2Gr8xgHVFnnDiWQcR0PkfkXj3He
	X03AR2jVD+O/TNxv76OJfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738167859; x=1738254259; bh=1
	aVpw2VtOckhmrUyo+hUSozBk0BKSyJ8lBXtB+PxAf8=; b=0ELNMQfiQ5k9JAYst
	WnU2cXzB7++vcpdj4PdYkvB5t/Y/XaFbl5I7DK25EOiw3qlsi70MszRosbGMGs1Z
	c5x+jDdiFXHgzzjaD/NSPlqICPeOh/Dkn1daxqaOB1zr2XG4iWdod9Na6Dwu4dJw
	yH3hm6jQq6cIA/K6jwZ7oeKyQRPpYVnOJkHU4mE6eY6kMSb4SFSJngA6swRH26zb
	SODbcvQ5TZRp+gq4U/vetkMguDIqMEHCK+Ycc1edrWyh4PMe8r6CU9QXK4UGLBBS
	ErWYD6vU/E+iSOain1jY4uI0vynlCk8PMbX81XikLAm1l3QINjXQJUHUy8YO6wq+
	bOPAA==
X-ME-Sender: <xms:M1aaZzDyhqFTx5QbldEsagPKKRXa14h9YxGP9YcbFYEmFLCfv0E0Iw>
    <xme:M1aaZ5haQjCMpHXnsKhSgQQzLNz0MZ2EioGTvNFR1GLTeIszCX2ehFLj3HIqIOHzv
    leMJ2GKcQrVN9CyCA>
X-ME-Received: <xmr:M1aaZ-l6JXVDCvAK45vDTz_dMlTsa_ZayalyvuYBsx3CcfDJvl7uVZor0iF3BrqWxPTkHEiW5u0RuRDF84_267ebtPGCORxzKjltuSGGjrlipz_PWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduueelje
    elhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M1aaZ1wXEi-_0tme4La2gCpe5iHMGd_PoighkXKhW-_kUXjmOw0p9g>
    <xmx:M1aaZ4RexNiuRibAym5f90l3MNSq7GQwkTHcYTUbczHKZm7OdxEPvw>
    <xmx:M1aaZ4ZyHdMz2FZE5rJC25CDKRuFzACvnWgKPoECGJYQKY2IdMbjPw>
    <xmx:M1aaZ5S4k5LWKy-YQpr98fok1MRJpZk8f9fwnVA14DCfWjTzwKjdKw>
    <xmx:M1aaZzIyeu227kT13BPonDIvTp-A8JjZcwHbFtmjDxCsTQoNVYla3jK1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b6e0de2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 16:24:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 17:24:14 +0100
Subject: [PATCH 1/2] unix-socket: fix memory leak when chdir(3p) fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-memory-leaks-v1-1-79e41299eb0c@pks.im>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
In-Reply-To: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
To: git@vger.kernel.org
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
t0301, but only via Meson with `meson setup -Dsanitize=leak`:

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
2.48.1.362.g079036d154.dirty

