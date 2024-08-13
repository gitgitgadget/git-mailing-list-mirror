Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921416BE2A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541474; cv=none; b=Ng4TtI1SDBYOJVVBkJcbLr9KWB4TPny+Rpxf40UCu2DzqaVRTXevE5NUNCDvY6R69bAjL4ZWktcWVI04nUPOi+ZE8BmCdfEvye1ri/AiZRSdm23zJdjzKVMEZcF2wm2bVfxGLu/lIhdDyMHXJobOZkTyJbN/A2mQpMPDtkmGdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541474; c=relaxed/simple;
	bh=AzUj8spFAxsKjMaTFz5FGByM6NOtBXz8D0GKavJxcGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d27GLSPcdAVpxZ7Ij0zG+BUX4x5NtwyvuvSfIDxH7HHDE967iHr/Xn8vMQ9luYB9J/+ZZOunHe1d/jgaIhtn1IQR12jSFYMcXmIFPyif9zyyVKDziAVnl1W+rOKgNffyFJ3tLinKXplC7TDIUdHax8SOTEoGkNlZHbGUTgcZ/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NdWpEiXc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8y2+zsp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NdWpEiXc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8y2+zsp"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id A0C3A138FD2D;
	Tue, 13 Aug 2024 05:31:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541471; x=1723627871; bh=ZCyjENfYzz
	oX+ZOFJv6cSiPv2bzvUen9/0czNnq2aA0=; b=NdWpEiXcmzP0uoMf2tUBkEbnM9
	V3wNQTBzCZLuwmyXMby0JknoDaIbAnT8KXjogvX/lvJ5UayFllIFZ7Qna0afGew8
	/clM5HwVhPDdn6SMmEX7eiTAP1FuYt8ZAaNwKN19t9uhkVXkMYkoB/Yeq0d6l0xx
	NgctC6lwegNCH/jJNlmbsuZgGBxVOpddfB2c3k90EuvgSTnpNMpH1b2Kq0T12Sfo
	7UKRr7O5u+QKzxua0RlsH1DXvie/uuS3DD0jYURjp0RgLSu4mOqrhwjxsmO9bkf8
	6ZsFeFqyFQ7gbHooxblb730anCN1LE0x5Rw82c0j4nhMi81CM9mPZqGPQM0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541471; x=1723627871; bh=ZCyjENfYzzoX+ZOFJv6cSiPv2bzv
	Uen9/0czNnq2aA0=; b=n8y2+zspWDtLDXuer+HXY+bIOzA5SfkkC53Qq3b8uv9Y
	2rQ23cv5Krnd522mwQVCFV90ntX3kJJ6i8IWej41zOFG3DW6tYoEqbXOwR+nqx24
	acit6IzXw4QMmLLGHEV6tlZO9x6oi1gawbQ4tzGjHiI6qNx83b/Zh/9cxYDR4ajt
	eXljTRX37GgL+AxNGvtnWwzh7WqNOoLG4KazGJyJKqdT/+bggyZ8iWifVpeF8qxS
	VEIvgi8sgUeVq8iscJiynZDzMMglFqRIgBc8Quf+K4exzaSIlrizB2dxNwZZlwu7
	4hrmtKIh7rN+HWmqLObANOFplIV7fjy4qwSUXWHrmg==
X-ME-Sender: <xms:3ye7ZpGnxhIcKLQZbL6kZHvzJJ6XEpF8p91SqCBwrWCaFfTDQBNNDw>
    <xme:3ye7ZuW6w_gy-DdHRET5O8r6HIYzD_YX9bWMwNYaUjp_iZFL8LogpjkwGV9TQx3xk
    uSxCMh_YOQ8Y3sTYw>
X-ME-Received: <xmr:3ye7ZrKpvJ3AxeJ1xT4ftgDxiZ9PTwa6-XlJmEeWVrURw_zZhmq-uq5l9ctMJnmgsQ6nTNUBSBjEv8rVinhLXYR2A8myi0OAlOkEs-3P3HZhxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3ye7ZvGYxbpvuhsUeeXVIfpWMisOSthszzD5Fu-xJ_eafg901LyFxA>
    <xmx:3ye7ZvVo-kU6SZ3wqsTusvlKHAMAvPp8DiHO2jB9G0G6En2nZzApcQ>
    <xmx:3ye7ZqNqrX4USgSCrij61iMhAF7nba0Lzsro0ZbJ_wALVBHMXN060w>
    <xmx:3ye7Zu1qhtghDPGmdb3EWrRmFHtP5joG_5cdlpQNMXuNVri1jlkCGg>
    <xmx:3ye7ZhIT4UrVcDSxMiRz2o4_Cm7HUdLlr3ItKrBMjIRq2CDKHvuqIjyz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:31:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eacd7e1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:30:53 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:31:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 02/22] git: fix leaking system paths
Message-ID: <f36d895948a2b26148062a3de2997fb6d23301d3.1723540931.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540931.git.ps@pks.im>

Git has some flags to make it output system paths as they have been
compiled into Git. This is done by calling `system_path()`, which
returns an allocated string. This string isn't ever free'd though,
creating a memory leak.

Plug those leaks. While they are surfaced by t0211, there are more
memory leaks looming exposed by that test suite and it thus does not yet
pass with the memory leak checker enabled.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index e35af9b0e5..9a618a2740 100644
--- a/git.c
+++ b/git.c
@@ -143,6 +143,13 @@ void setup_auto_pager(const char *cmd, int def)
 	commit_pager_choice();
 }
 
+static void print_system_path(const char *path)
+{
+	char *s_path = system_path(path);
+	puts(s_path);
+	free(s_path);
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
@@ -173,15 +180,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			puts(system_path(GIT_HTML_PATH));
+			print_system_path(GIT_HTML_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			puts(system_path(GIT_MAN_PATH));
+			print_system_path(GIT_MAN_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			puts(system_path(GIT_INFO_PATH));
+			print_system_path(GIT_INFO_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
-- 
2.46.0.46.g406f326d27.dirty

