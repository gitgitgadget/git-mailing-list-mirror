Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC3197A8A
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321543; cv=none; b=c97U8FnbD+5R30j0gx5HY4/Ti1Lf8/t4ln6PKM17G0mEOpFVInqSq4dMQFcpnBOfNNq+AAtmXlUdvzFgR0k1yDAdESG41iqHIdDhk6kXG9mzcy0bPjXdThrGmP/GmOhkBk92oHE+r/2W2RymYv4OOvzyA10jIixJ5nD3W0w0+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321543; c=relaxed/simple;
	bh=nDIF6WAP4xK1KRdUeTi9xdV3d3nFq/CPOnmy1vJ8t7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=efAyUmVO3sOcsWP2IXP+xLgixahnC5Me2h4jhK7UlTQwalpPqzvYw9oBB5iK+uHzyGq4OpXRRRVcpaz3mdxbVuHP2bYCnOJh9SBtGdODyavn6eah/cdUXL9fYaR9sEWZyMPNA2eyCR+rEbV44YrdJvhrzKcANOHjJQo9kf/8Akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o7R8dcuO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnJOibIJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o7R8dcuO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnJOibIJ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id D384B13801F5;
	Mon, 11 Nov 2024 05:39:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321540;
	 x=1731407940; bh=sXQ7uteLqy8IPeYOac9uismg30P/FA4wyqljZ9S3SB0=; b=
	o7R8dcuOGp8VDfw0cl3mVG1T1qVujgcng8Me8wScdxkvNr1rPEMW+QBJKl3jVWFk
	0PguYYm4cwowXTooPQSbJZj3DGHWDJJyXQQaCL36CJk0+oHZez48cbIM+maWhHe/
	voZRLhp1U+aF7bp5ArZuqssIhoxLJfYt4xlcobFolAeFhfltoQd0SzV4NT+H5ZJ6
	fuHiGx9OOSV432I44EpKyvK7L9MGbPw6fYaGnY/XKrFP2cEDnKmLtQyOddFsUauW
	Z7PD+Wh7WjYYGubgRPso2pQhmUYvrg4ihkLMQMKyldoeeM+8jeLGGSCA72wm+YPe
	GKCY5nLD691EMABTQ/GYcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321540; x=
	1731407940; bh=sXQ7uteLqy8IPeYOac9uismg30P/FA4wyqljZ9S3SB0=; b=Y
	nJOibIJtcB0TngqQwpPOVY1O9z+IdE923ajGF3jnRv4mJR1ZbhnV+KiWwvebellX
	BCO8ruRivD3Yvmx+TsA2AXeogUOjSiEJ/yO2rTOl0upucAQSxgDPwPwt8AV/Tjyy
	KXH6iU8bss3C5pO/wpkjlmnhoFDnOdbOzCzMFA7gFEu16lOf8OgJQihbx1FZisM+
	dAthNosKNx4J7mT0cLoz3FL4vL4//4LVlIZZUS3kvSqRZ4FysjUDUgFtFRRDJS7u
	l7HPZiedSSeLv/1GihnBTLikMj7zzDP3hPc4cKBZuqdRZANZWZCC4tS+A8iPFGjH
	esMwKunxwmrbgEb3rD9Ag==
X-ME-Sender: <xms:xN4xZ_dDiYPwUeorUCg50nQ7dGby1CFZEWphAXqlRCYY1yyBhcW1ew>
    <xme:xN4xZ1P2K3ZiL2lJ3-kkjkxRNFbFBNyL4olFui10VkLB5B86iNBDr85x5DKElSk7p
    I2zPvYUNG4HtvM8nw>
X-ME-Received: <xmr:xN4xZ4jL6tVPYyVENncXrjiOh4wxps_jBDaVCWq77eGkfDPZjKb5qushmpsrfo24hc8aesA4qArStufricaq-ZVkUGihKDu93wFmOKRosdDU19Yu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xN4xZw9FGN7CQquIlcCLHP1Uuk5czpcHXkKMqMPLYt8S9Az50YhhAw>
    <xmx:xN4xZ7uleEbLkIH5Ibe8RbZW2x4dMUhYVHsDioV0Gm-vRRjivtMEAw>
    <xmx:xN4xZ_Euj9lxLhGd_JfsvolZqw6UAYHZsXZUIw5JfTp7mqUkvVcTMw>
    <xmx:xN4xZyMU7fxlDr_ELFXq6sxP11KO7SdkvfbPeLpS12Rhy2sIij1VRA>
    <xmx:xN4xZ06PTtqi7Kk5sKxvBLzJ7dmoQZHhdruCuAMk8AM8GHkpO7J0gdI0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 251bf42e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:45 +0100
Subject: [PATCH v2 16/27] help: fix leaking return value from
 `help_unknown_cmd()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-16-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

While `help_unknown_cmd()` would usually die on an unknown command, it
instead returns an autocorrected command when "help.autocorrect" is set.
But while the function is declared to return a string constant, it
actually returns an allocated string in that case. Callers thus aren't
aware that they have to free the string, leading to a memory leak.

Fix the function return type to be non-constant and free the returned
value at its only callsite.

Note that we cannot simply take ownership of `main_cmds.names[0]->name`
and then eventually free it. This is because the `struct cmdname` is
using a flex array to allocate the name, so the name pointer points into
the middle of the structure and thus cannot be freed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c  | 4 +++-
 help.c | 7 +++----
 help.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 159dd45b08204c4a89d1dc4ab6990978e2454eb6..46b3c740c5d665388917c6eee3052cc3ef8368f2 100644
--- a/git.c
+++ b/git.c
@@ -961,7 +961,9 @@ int cmd_main(int argc, const char **argv)
 			exit(1);
 		}
 		if (!done_help) {
-			strvec_replace(&args, 0, help_unknown_cmd(cmd));
+			char *assumed = help_unknown_cmd(cmd);
+			strvec_replace(&args, 0, assumed);
+			free(assumed);
 			cmd = args.v[0];
 			done_help = 1;
 		} else {
diff --git a/help.c b/help.c
index 8b56cd6e25ba5f2be2cbf2a7a9ed48136e12a0c7..8a830ba35c6fd1377213e2ed40846f3d46dba363 100644
--- a/help.c
+++ b/help.c
@@ -612,7 +612,7 @@ static const char bad_interpreter_advice[] =
 	N_("'%s' appears to be a git command, but we were not\n"
 	"able to execute it. Maybe git-%s is broken?");
 
-const char *help_unknown_cmd(const char *cmd)
+char *help_unknown_cmd(const char *cmd)
 {
 	struct help_unknown_cmd_config cfg = { 0 };
 	int i, n, best_similarity = 0;
@@ -695,9 +695,8 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		const char *assumed = main_cmds.names[0]->name;
-		main_cmds.names[0] = NULL;
-		cmdnames_release(&main_cmds);
+		char *assumed = xstrdup(main_cmds.names[0]->name);
+
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
diff --git a/help.h b/help.h
index e716ee27ea174c4dfc3b941619bf361972894212..67207b3073ce48fa25f67f9a4922abc4e2ce7926 100644
--- a/help.h
+++ b/help.h
@@ -32,7 +32,7 @@ void list_all_other_cmds(struct string_list *list);
 void list_cmds_by_category(struct string_list *list,
 			   const char *category);
 void list_cmds_by_config(struct string_list *list);
-const char *help_unknown_cmd(const char *cmd);
+char *help_unknown_cmd(const char *cmd);
 void load_command_list(const char *prefix,
 		       struct cmdnames *main_cmds,
 		       struct cmdnames *other_cmds);

-- 
2.47.0.229.g8f8d6eee53.dirty

