Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C9186E39
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687607; cv=none; b=dxphx9t0W3kgJYyzY+KyTSy+VipjoNiJ1oP+jWSYVXICSvrfIuCTz52lIItaDXQ82hHjJ4+5X8CRcAQy8pPMXt4wBXKTRpYU+Js/DURRySVXoUyoujWTd8FqAWwTSvqOMv18BjhXLQwSJdJMe0PLWnxIVE4LJulYtWUd+pQ5iGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687607; c=relaxed/simple;
	bh=xFp9RHwLy+SCLaa924+hOoWuhhArpaQZmgyY97voFOA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh2ZdJFLP3AhxOSaVFT/rUaIsGJ/GAbARsgjmHiX0Qc5EVjgSUS1TVCMtEgLut+LdaWDyd6qpUQH5qypAK0WIfVAxCQS5sek+PZX+WvHKyyhl8EUxZUKsW/CtAl+qu4HlvGWFYEIWVhhjYFKjqbhnogOMC9M0onmL77GEojWZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L1+DG61c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkCNhS43; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L1+DG61c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkCNhS43"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F68C114025A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 05:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687605; x=1727774005; bh=qRsvD3Mtth
	ug8xvsdJ9xkljxj03Rz5uwS5ArjocElXU=; b=L1+DG61cCUIMy6A8vDikPUNAmY
	S/IvXaDgln9gjDa/fM5Xx1NMQ+e7Nmz2IGQpZfAti/g4WJVk07N4kBtkoBfYW/hQ
	a9d3l4NHA+d72ldYY5HcqPp2y3taIKZRNTr9NbvlUZChjUimnRkOzjKYT3ESVCKx
	mBgyH+GVWRVqTR1lFQubR1jwgF0dPDJvSEUjcTGJMpzOfTnGEhFJ/E/vZ1LDjxiC
	8yByQFoGzILmaCh/toQPpm3rI9uyLL9lR2CZ0zuI+PSayHWINaW2k1zoJKfoUCKR
	0mvMoD26yh6izYo6AcXs02vApNfdPDq/nYXVN2r2WW43Lq/+zSCez+3oQcQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687605; x=1727774005; bh=qRsvD3Mtthug8xvsdJ9xkljxj03R
	z5uwS5ArjocElXU=; b=jkCNhS43pBpEYOxtDckPZBlOBlhGaRf/oBFFRY8XuaQi
	PtVTOq04IngvIONcVzWIwbYPlcyrTVJc6hKlhL1ZCSivhP51jZRN2fBLb0fsqURF
	gIl38i1TuNsW+TLNke7fr/zvQejbaqfq6itzjGS/04d10yeRhgbVvcfxeHirN8bj
	B2UdVIhklyOaTQGzw3QS/TzaXldrvrs7S1lHQVXasfxcQOBRsp0fy9VouBp/39tn
	xL+SmpUHsZoRJwIwACvzf8935mE8RSwmuVFb3dA7kmDN7Ysj2/66P8Np6XtBiCJN
	mqC5dNyEskQMcTVjnSG6FxhnjNZZ+ABeKr8lVC8NhA==
X-ME-Sender: <xms:tWv6ZoYic1f2SaYbhMd4zsGnZrJL44HEkMULJI5hWu3SZXVsuH1o9w>
    <xme:tWv6ZjYziPwpEpBy5Nn_40WNImrLR4fSdAaxq3oi_w7uJHUlPgbPrZMj0SjDfy20S
    Cl0KayPibikjOjrSA>
X-ME-Received: <xmr:tWv6Zi-qKOWIp-aux-EGo07NR2-Fc4aLmeSQIlJH1nSqeUl5IpHlr6zolxKXON_mP82nRm10tuATXstcuBES6iPqwbPqs5_26pUsQ7C5goPBmnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tWv6ZiocbgWJJnlJ0nWxWPXUekTDKwnDvpK7tDHwdGyY9sOllvEDsg>
    <xmx:tWv6Zjp-K9wpe0-jO-cjxU7H0N4-YOcD1Ab4hGCE26-Iues9kNfwCA>
    <xmx:tWv6ZgR3S_yRYxqO7qDU2RSWd-2ShJhCyCvf_HCSsLWXL8X4emjDVA>
    <xmx:tWv6ZjrWXNv0Z-DLJmLgoUwIfY0heuyLmSVe57Y2ZDoZ-AUpyzvHaQ>
    <xmx:tWv6ZsDCGFoja_0SVoJs38LhrX6qwc2P-jGDTJvfrgRKTiaktI8uE_9s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17ae639f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:39 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/23] shell: fix leaking strings
Message-ID: <0fbe431b508c78ab2a12107af0bc00eb5573a392.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

There are two memory leaks in "shell.c". The first one in `run_shell()`
is trivial and fixed without further explanation. The second one in
`cmd_main()` happens because we overwrite the `prog` variable, which
contains an allocated string. In fact though, the memory pointed to by
that variable is still in use because we use `split_cmdline()`, which
may create pointers into the middle of that string. But as we do not
have a direct pointer to the head of the allocated string anymore, we
get a complaint by the leak checker.

Address this by not overwriting the `prog` pointer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shell.c                         | 6 +++---
 t/t9400-git-cvsserver-server.sh | 1 +
 t/t9850-shell.sh                | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/shell.c b/shell.c
index 2ece8b16e2..76333c8068 100644
--- a/shell.c
+++ b/shell.c
@@ -143,6 +143,7 @@ static void run_shell(void)
 		}
 
 		free(argv);
+		free(split_args);
 		free(rawargs);
 	} while (!done);
 }
@@ -216,9 +217,8 @@ int cmd_main(int argc, const char **argv)
 	count = split_cmdline(prog, &user_argv);
 	if (count >= 0) {
 		if (is_valid_cmd_name(user_argv[0])) {
-			prog = make_cmd(user_argv[0]);
-			user_argv[0] = prog;
-			execv(user_argv[0], (char *const *) user_argv);
+			char *cmd = make_cmd(user_argv[0]);
+			execv(cmd, (char *const *) user_argv);
 		}
 		free(prog);
 		free(user_argv);
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e499c7f955..6da7440e73 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -11,6 +11,7 @@ cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index cfc71c3bd4..f503f16d1b 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git shell tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'shell allows upload-pack' '
-- 
2.46.2.852.g229c0bf0e5.dirty

