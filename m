Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E387158A12
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053690; cv=none; b=q7Lof8Mgt3wW4kshVoUVBjletuSeJc/EBlTDWqVvEciPX00BVM9R200pPL1xLVLEO+ORGYa5NQSugIIobTpP50jh/tA1yQW5+bg6zUgh+OhX/7cNgfQDpGtIjJwItCsrfcWzsJF5NFyx559NxBq/3OAexU7N08+7DWdu01c+Rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053690; c=relaxed/simple;
	bh=BWWJzr9s6TcKs+eIdtXCn7fIDSRQhzmOLvRW7jBgSAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBBN5Macy8IjUbwIjCSvSbHoJtoGQ/w0vHljqW7AbJ4DqFuViJ+V8XbXGzT33E2y2rPVaEFTWuz62CZ3inTrIXP0oe1ptRGaHxhE45Fb0heN2ofQRj7SqLA/JLnzMcpwK1qULGxHw5aS6NV8UFodTlHmx9VcMrimJGpPx724C/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ad1FP0Yu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAasmAFe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ad1FP0Yu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAasmAFe"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8C9FF1151237;
	Mon, 19 Aug 2024 03:48:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Aug 2024 03:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724053688; x=1724140088; bh=VA/r0WjGhP
	Vfq5rtkOi58z2f2A8F1uXOWgFrpn6xXLQ=; b=ad1FP0YuAT2c7U5fp468SsZ7YV
	18sepMB9GqBxYeZroVWsRkLebmAkzeXdsyd9MKqc01e61kP4lYWMf432POnI2kHF
	4WXETzJ6atGk9zoBzbVPbVr//Fou1t7KTab0lAsMIBmn7VcXpdOiQTgMiFYtLpT/
	/OpmR5way+jvrpk3xQTvdgnwUl+RBQX1X17LJBkb7wq2Hao31Bl5+Sh0+WLeGEtm
	OJ4yWhZFRV1oooyZJHK2ssbL1OyC2oQDiIIb8eLYnFuXoMjjMiaY6XZPAdnxYNdD
	tCgz+s8jRcDmSrhJol7za7qPb41gI24s/xYveDfjKcPP83TT5zA3O5v7wAgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724053688; x=1724140088; bh=VA/r0WjGhPVfq5rtkOi58z2f2A8F
	1uXOWgFrpn6xXLQ=; b=kAasmAFewq22lpAwjKHwXgSn6Kz/YrvubDSqVt3fjhR3
	aN17qF3iQVK9eVDnQM+28p0nvEH6GZKquJF9xM9LHiyI3SgEk5ZfLZKewfY2OsD3
	kKK1Yd6crBGWArDLOxMUmDKbY201Dfgqw+/w/L5T6UVvTIdD35scz5qN62xy1/8J
	JGkzt982cf/W81B2bHrfoOjhCrIyDKkf2aWhLRbSr/VpDWBA6qQGRMufPJnlNxNf
	fB38t7FpHhTiauJw673il00PFr6wh5UIZO1pb1RKrZDA7DdZqJh55lDqxXeHlY6M
	LkNzsUI0bk978XqeSuJUZU1Ygd7m3RZ591XvfoLMRg==
X-ME-Sender: <xms:uPjCZgpQ2EdSqvnTQ4CyLyPacKPfbvViTgxGFBe79x3eP0hrTo2YeA>
    <xme:uPjCZmosMawN5qd4RXMyFhqZVlMmX2nJLVMEvQXlfv4O0TXXGDf0OZnOx7vgFiD90
    77bYJaqDwC30MBeQA>
X-ME-Received: <xmr:uPjCZlN971M5_oFC5Zc1F0VFwEFZc4n-imnvZTiadti19DttokQk2MqE5pqcYtXA2yXlLXBIew0HHQwMhSzgRrq40GMYrmU3SPHDjwquoJaWUiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeelueffgeegheevtdetkeeiffdttdehteekuedtkeeg
    iedtvdfhueevudelkeeghfenucffohhmrghinheplhhoohhsvgdqohgsjhgvtghtshdrrg
    huthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uPjCZn5a-K5qmumbRexWsPWTktptrrX7CIoPbIyeH8Sm7x2uQpoW2w>
    <xmx:uPjCZv5_d43rZq2ce76Fdq6GysG6nET2gUc_ey8Pw9zanjY8Zf8YOw>
    <xmx:uPjCZnhP7luNYZHgYGjFAgxmahreGj3UQ8z-1i2gSsy7SQPVbaa59A>
    <xmx:uPjCZp43GwXgz2Ipe029wLynM9gMNMpv5sCbaBF4dqc960DjEk8sNg>
    <xmx:uPjCZsvLgZ5Pa1Az6JVnO0UHEoueQW0Dw6Aqbbta9L3Pmx5L1kCeVHCh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 03:48:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e40e5d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 07:47:37 +0000 (UTC)
Date: Mon, 19 Aug 2024 09:48:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] builtin/maintenance: fix loose objects task emitting
 pack hash
Message-ID: <c25b5333f60a5920c1fade06532e3379c6686908.1724053639.git.ps@pks.im>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724053639.git.ps@pks.im>

The "loose-objects" maintenance tasks executes git-pack-objects(1) to
pack all loose objects into a new packfile. This command ends up
printing the hash of the packfile to stdout though, which clutters the
output of `git maintenance run`.

Fix this issue by disabling stdout of the child process.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 13bc0572a3..be75efa17a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1159,6 +1159,12 @@ static int pack_loose(struct maintenance_run_opts *opts)
 
 	pack_proc.in = -1;
 
+	/*
+	 * git-pack-objects(1) ends up writing the pack hash to stdout, which
+	 * we do not care for.
+	 */
+	pack_proc.out = -1;
+
 	if (start_command(&pack_proc)) {
 		error(_("failed to start 'git pack-objects' process"));
 		return 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 46a61d66fb..7cc4eb262c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -978,4 +978,20 @@ test_expect_success '--detach causes maintenance to run in background' '
 	)
 '
 
+test_expect_success 'repacking loose objects is quiet' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+
+		git maintenance run --quiet >out 2>&1 &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.46.0.164.g477ce5ccd6.dirty

