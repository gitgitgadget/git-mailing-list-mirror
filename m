Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BE2D640F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996916; cv=none; b=AIwhomhnFhpBVPqK+3ZCgFWRO7xFL1gNGFPqlquGJGtCuOEDtzKwvKTis/jBLqrWm0Ufd/T2k8U2IbntcpBSrBGsRQjJgxH1bdzwbn3uWZ98QvsKMGptt8S6NcAYmsIv+n4nUi1RjPo5A57yM01ttLPhOETDZkI9AEC3azYusGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996916; c=relaxed/simple;
	bh=GriYu0tF1bIMcFuxFeBncbOfHuPzlZfwBYtxKehBB7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAdfPTM5o6a4JnrerVKNY8cQEzA9FZhw97F+ypmGDihSRPsMpFtzpSQ9n4M/mr+nbhU27hCDckL5efhzlwyA7emdKmf1WZOkR+tbj5AJPuJb8F2hRTd3ezXuLoO50kPby/7s7lUcJpCitumx1sS5dP8eDysjJ+rvcdKkeFtaYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oXTqdmg0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cU0ZxEGo; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oXTqdmg0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cU0ZxEGo"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 373857A00D1;
	Thu,  9 Oct 2025 04:01:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 09 Oct 2025 04:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759996913;
	 x=1760083313; bh=+Uhw0I+udYkGUyPeu2sJtERf5/LYa7eZkGRxa7QZMb0=; b=
	oXTqdmg0dwKB5KTYVA1lBf3/TFwuSz1T/qjqCiFYf9on2VHQKaHzZH96llBIHvbb
	rYexmZ/yBAvkuPmPEseEXiU8M3wFqcjK14ppQrtwK4/1AMC2qS1v8utI0kj7tJil
	hFwCBEA+ATjvBIsxsc4y6yF6pgSoDuneD4M0dCJ8a/4/6Lu9LkCC7qWUrQ2Zzech
	NtCsssMx0yBotqkkNR51YfF4RwIWMM+afnO0gzUSLrjZ1J8ttaR1kjFOH7w1I/ij
	q2TuDw10M48Y2OQtB6pprCHkyX4kwRHpQwA9Ss3d5RovIf+v0SB+YIzLcWVJnnPy
	tdsVmhgMhKxYDlX2vKB2vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759996913; x=
	1760083313; bh=+Uhw0I+udYkGUyPeu2sJtERf5/LYa7eZkGRxa7QZMb0=; b=c
	U0ZxEGoHl6HgdDeSV9bGSCmSq8QuKEp1D89vcrrflClj51fU1eXKWYHMsXiAhKes
	QvMYeeskwUl/E5JmPbXK0MEbdaCZYMGzhFGwd3doXh7tC2g8uO2OYrvnACEOAUOk
	SCmhDdxoxhgskVZUdz/Kc+DBuIZdDC5E6eFYLfT0m8r8yhRwJcP4zDZT7BTprq11
	hjLf2RSUFbXajfL0vTOKTzB6TO7TZz4FGcZeobiKR/0bKFy9hrHg8ol1V/x5OAwI
	YmQhdvtC0KfdtWyz4mHfDtKOibJhZRAvcfI8nKP4qkxXPruaR/Z9aN2TtGoclOkR
	0o40vbbbHvSUYiEXgzT5Q==
X-ME-Sender: <xms:8GvnaCXJmGK1QsGH_IpFyD4Jr9plSaBv8FpedR_iVJVbdd7Qf-Rv0Q>
    <xme:8GvnaEmCdJw8LzJFrcmFDhgDSAnuKVJigWUdU-X9LuozB01wo3yBYJtM8UDCCfvJs
    hsSoI2vFN9paXfiLGKJ7slsLkqR5z0Hol32K6SJMn9VvXV4Tu9Ru88>
X-ME-Received: <xmr:8GvnaEAFPuiiDaBW2HL2_1-GI7ksPQYObm-r-hWNJFtNRqElYvue62n4U1WKd0D0G76c1y1wXpLdPBm09G55CP2nNTHXGxNGwtxIfJbU7RI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8GvnaEcF-hkXzHhlHZ3cZOGnApBaYN-sLC5rDCVJ7lNJdBmxTLLJtA>
    <xmx:8GvnaPKGbAkqC77GFk-PqWueichNIGZfMuozRmmyubE0EH5fqeWjQg>
    <xmx:8GvnaHfMImULxlHndRYAj5od4lAg-HMXdWRqEnIbaUaGskbRW9z1aw>
    <xmx:8GvnaG2rzN5dzaiYbsLcL0XUqP-XRHsyhKav8DzsznsHkQBDXWpc8Q>
    <xmx:8WvnaAcFuL4Vwuli1wsgXwbT0pVdt9gxPxBVLCP4ZJig_696OOA-P0Qj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 04:01:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdc7f122 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 08:01:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Oct 2025 10:01:37 +0200
Subject: [PATCH v2 3/6] builtin/grep: simplify how we preload packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-pks-packfiles-convert-get-all-v2-3-0d73b87ce711@pks.im>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

When using multiple threads in git-grep(1) we eagerly preload both the
gitmodules file as well as the packfiles so that the threads won't race
with one another to initialize these data structures.

For packfiles, this is done by calling `packfile_store_get_packs()`,
which first loads our packfiles and then returns a pointer to the first
such packfile. This pointer is ignored though, as all we really care
about is that `packfile_store_prepare()` was called.

Historically, that function was file-local to "packfile.c", but that
changed with 4188332569 (packfile: move `get_multi_pack_index()` into
"midx.c", 2025-09-02). We can thus simplify the code by calling that
function directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 13841fbf00..53cccf2d25 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 		if (startup_info->have_repository)
-			(void)packfile_store_get_packs(the_repository->objects->packfiles);
+			packfile_store_prepare(the_repository->objects->packfiles);
 
 		start_threads(&opt);
 	} else {

-- 
2.51.0.764.g787ff6f08a.dirty

