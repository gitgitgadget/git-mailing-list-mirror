Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D21171C9
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 04:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765082458; cv=none; b=aa1son6Cj1UVnVQEz3dAzVv0/xspVxBGrHpSkqgG9bR6BlSW1G9E6sGljkj41Cs53MjoezELEJ36Xo3QMpLC/FP3JnUCnUwOkg1a8UbpNui+lO87E66NxdajPv2jxFbKdQIiTyn5J5YmMnCBtGkFswXrfEBmTnaE0sVN5aoT79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765082458; c=relaxed/simple;
	bh=aZwWYJgTbXQd77aRxXLHS9FsQngTXBonX7cvjNAIIyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XmPQDmXQP8cO6a7Dw10R6GmrNrEOPKoNM7cckwdsyoMcGRtkmNXkQMRakQ3DTpp2NbtIfXrYiqlg1OLNPUyw/pfavhxWncM8a0ccLx7dboQI/Az32n+wJCIXpdey1d9ZuQ+H/Q/07/zjr2ySgRSO6qSG3C1ljo82J7R4hqVb+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m/a/9NFE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRySaoUA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m/a/9NFE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRySaoUA"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EF6EEC01F7;
	Sat,  6 Dec 2025 23:40:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 06 Dec 2025 23:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1765082447; x=1765168847; bh=Uyktx3RwIFiYywCgst2g9X99U8G6yVyj
	FpauGCMKqLs=; b=m/a/9NFEBltN7cAjNN6lx6JrV6Ch4mipGf3T/Xtdd0Ie9rJ1
	lReZiTLg1EqFvICGALTyKJdEw2N9KdsMX4t4NVGTHmjXN2slfMTMqMeywMg3NqUd
	3u8xTIembLe2oBFB1Tj+gEmvw5rqYNzaK6VzYm0ctpB9WScVsoG6zgVVzkBR6dKw
	9xH5YJGlHT4epVGbNcHvSE4Jg0DW7u53v3jthQpIw/uMv7a61ttluHow8cWN42Il
	WBlC+78nw5a/b/BFN7i/ffasyjbpGWf3GOSHdzxTFLRLhOzsd+CgPNzamBAJKzcx
	EDRnvSbpJyLT98Eoj8A6ee63tj65TEc8UDGjiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765082447; x=
	1765168847; bh=Uyktx3RwIFiYywCgst2g9X99U8G6yVyjFpauGCMKqLs=; b=d
	RySaoUA9HA5vA4+pjHUwfF+b1ECtqinBKpgcMHoQJEAO6WaEGa9NYpfsnKR0x8hK
	uSHSQBU35tTLkfRZ0NnitzlRnRKSVuz+AXGiHdTDsTXcrFwsSqFbwbhkIOcnUdE2
	qgnOKs9MrOvdIz4qjQi8E5SDHSTNJkOj6aCZW+pOjRfXiyi6WNPNpyEPnpVTdzeZ
	+WmqwIcnsdD+MWMDZ1QmO6P2YpXuS7wK1PQc/3DsSMGU9zGFVTVGbqU78s9u1aDP
	d/KMty4+FLwyD+s3NVf6nO3F0wimOsoNZWEynOQdnJlHWMsp38D3B1B/ZcHO7Z5/
	DZDhxh/2+sO1VgURaIxMg==
X-ME-Sender: <xms:TwU1aRcs_NoVq3ww6W52uOdLDr7yr51t7yDKoN2zhHMKKHJ5UIOdYQ>
    <xme:TwU1aVMPwzxct8TKL7LseOWzOW_W8BC2ZNXP8yTl17bt7HGQhNckFO-LHyxwnMcuV
    AyRA1Nx9zcC0GXPBPE_D2mmHgZ1cKRNVO_NNLK613YUcFbTnHLwQg>
X-ME-Received: <xmr:TwU1aYIOn22Wm6A4gDDjfzFV41FUPYEhgs4_SlYw64YIWFxVlnU9XRd3ka5W-CSnsPp3VcMGAfOKS8NpGks-JE83oS_AzFOz4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfggtgesthdtredttddttdenuc
    fhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidr
    tghomheqnecuggftrfgrthhtvghrnhepvedvhefgtdeujeegveefudekkeevgfekhfehue
    ffhfejueekueejieeitdffkedvnecuffhomhgrihhnpehhthhtphdqsggrtghkvghnugdq
    tghonhhtvghnthdqlhgvnhhgthhhrdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TwU1aWFCdNfVwtZOs70qLvQ6m3iF4rc6M40tzmrY8WVkrF91NJe85g>
    <xmx:TwU1aQTnVWk2_paytYk3A4Zb-TVIMHcZtzj6AjsLy_zNcZIXlxRgng>
    <xmx:TwU1aSHgaBTTaGyv-mbvljHHkJDZBR19pFHVLtxhYnGd8iiiDdT7bg>
    <xmx:TwU1ac_GBQJ6oSklJ045lQktFiulgbWJ-dlAvWaPzBgK-EUlDlc5ag>
    <xmx:TwU1ac0RJKrMcMP8HOp81Azn0WPGKSsmFZUdDKc0hVpl1v10k4E1ku4p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 23:40:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] connect: plug protocol capability leak
Date: Sun, 07 Dec 2025 13:40:46 +0900
Message-ID: <xmqqfr9mnbu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When pushing to a set of remotes using a nickname for the group, the
client initializes the connection to each remote, talks to the
remote and reads and parses capabilities line, and holds the
capabilities in a file-scope static variable server_capabilities_v1.

There are a few other such file-scope static variables, and these
connections cannot be parallelized until they are refactored to a
structure that keeps track of active connections.

Which is *not* the theme of this patch ;-)

For a single connection, the server_capabilities_v1 variable is
initialized to NULL (at the program initialization), populated when
we talk to the other side, used to look up capabilities of the other
sdie possible multiple times, and the memory is held by the variable
until program exit, without leaking.  When talking to multiple remotes,
however, the server capabilities from the second connection overwrites
without freeing the one from the first connection, which leaks.

    ==1080970==ERROR: LeakSanitizer: detected memory leaks

    Direct leak of 421 byte(s) in 2 object(s) allocated from:
	#0 0x5615305f849e in strdup (/home/gitster/g/git-jch/bin/bin/git+0x2b349e) (BuildId: 54d149994c9e85374831958f694bd0aa3b8b1e26)
	#1 0x561530e76cc4 in xstrdup /home/gitster/w/build/wrapper.c:43:14
	#2 0x5615309cd7fa in process_capabilities /home/gitster/w/build/connect.c:243:27
	#3 0x5615309cd502 in get_remote_heads /home/gitster/w/build/connect.c:366:4
	#4 0x561530e2cb0b in handshake /home/gitster/w/build/transport.c:372:3
	#5 0x561530e29ed7 in get_refs_via_connect /home/gitster/w/build/transport.c:398:9
	#6 0x561530e26464 in transport_push /home/gitster/w/build/transport.c:1421:16
	#7 0x561530800bec in push_with_options /home/gitster/w/build/builtin/push.c:387:8
	#8 0x5615307ffb99 in do_push /home/gitster/w/build/builtin/push.c:442:7
	#9 0x5615307fe926 in cmd_push /home/gitster/w/build/builtin/push.c:664:7
	#10 0x56153065673f in run_builtin /home/gitster/w/build/git.c:506:11
	#11 0x56153065342f in handle_builtin /home/gitster/w/build/git.c:779:9
	#12 0x561530655b89 in run_argv /home/gitster/w/build/git.c:862:4
	#13 0x561530652cba in cmd_main /home/gitster/w/build/git.c:984:19
	#14 0x5615308dda0a in main /home/gitster/w/build/common-main.c:9:11
	#15 0x7f051651bca7 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

    SUMMARY: AddressSanitizer: 421 byte(s) leaked in 2 allocation(s).

Free the capablities data for the previous server before overwriting
it with the next server to plug this leak.

The added test fails without the freeing with SANITIZE=leak; I
somehow couldn't get it fail reliably with SANITIZE=leak,address
though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 connect.c                |  2 ++
 t/meson.build            |  1 +
 t/t5565-push-multiple.sh | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100755 t/t5565-push-multiple.sh

diff --git a/connect.c b/connect.c
index 8352b71faf..c6f76e3082 100644
--- a/connect.c
+++ b/connect.c
@@ -240,6 +240,8 @@ static void process_capabilities(struct packet_reader *reader, size_t *linelen)
 	size_t nul_location = strlen(line);
 	if (nul_location == *linelen)
 		return;
+
+	free(server_capabilities_v1);
 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
 	*linelen = nul_location;
 
diff --git a/t/meson.build b/t/meson.build
index d3d0be2822..459c52a489 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -690,6 +690,7 @@ integration_tests = [
   't5562-http-backend-content-length.sh',
   't5563-simple-http-auth.sh',
   't5564-http-proxy.sh',
+  't5565-push-multiple.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
diff --git a/t/t5565-push-multiple.sh b/t/t5565-push-multiple.sh
new file mode 100755
index 0000000000..7e93668566
--- /dev/null
+++ b/t/t5565-push-multiple.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='push to group'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in 1 2 3
+	do
+		git init dest-$i &&
+		git -C dest-$i symbolic-ref HEAD refs/heads/not-a-branch ||
+		return 1
+	done &&
+	test_tick &&
+	git commit --allow-empty -m "initial" &&
+	git config set --append remote.them.pushurl "file://$(pwd)/dest-1" &&
+	git config set --append remote.them.pushurl "file://$(pwd)/dest-2" &&
+	git config set --append remote.them.pushurl "file://$(pwd)/dest-3" &&
+	git config set --append remote.them.push "+refs/heads/*:refs/heads/*"
+'
+
+test_expect_success 'push to group' '
+	git push them &&
+	j= &&
+	for i in 1 2 3
+	do
+		git -C dest-$i for-each-ref >actual-$i &&
+		if test -n "$j"
+		then
+			test_cmp actual-$j actual-$i
+		else
+			cat actual-$i
+		fi &&
+		j=$i ||
+		return 1
+	done
+'
+
+test_done
-- 
2.52.0-313-gc4a767987d

