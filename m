Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E2443E24
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928596; cv=none; b=CrgYF0PjAJgp2115IxwC1BljkrYKmUvG3jK4LDJ9O3/pdfuEXkRIDixfr5FOMUKDUZCzgnPENSaKAtUEFMM8jMw2t93mfN/67wfgTotrqgsPCgblxIBHrFEVNLgl4j48xpsoKTBknQRXT5quTh9qL20HlMY0gRPmeMhb9hW/phM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928596; c=relaxed/simple;
	bh=Y2zYfx922VKjOfR9+XvvzuXR07m+DxTdQkk6aLsMSps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1ly1yBnsF160y7J7xp2LZPYQs/9EVmut4kJ06hlAuviZYZxXVkYpgi2tYF2WWI0zku5Y3Cj8urjV7p05nYFPk74rP34ojtBkSl0gvkRglYiVdcgxDfVcyInrEX6wY8/edNziq3BuohTdzgZwHU/3enYR9YHmlUKIjdDmuAWsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P6OBKHyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DRE1oCSW; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P6OBKHyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DRE1oCSW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 41F2FEC02A7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:09:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 04:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790928593;
	 x=1791014993; bh=SZLHPzwla0PWQMrESTu+MZH8RaW4hSnBCS0Rdv8vuQg=; b=
	P6OBKHyELCB0vgX1qVgznsbxS/ZOrStIoSiW0DN3m24UM1UoJQIAYf5vwUAZKV5r
	ZJisEnf4Q3h9Cr5C8n3AddqlT1W0XKqZAYn6ldFwH8/3umoNCmQ3vWGv7Igxa/BS
	JoGyzqX7xu2sj/QN7ir9qqD40eiCY7sSfybx3NM9x964x7VvtqDASFbH1A6idr7H
	wVUYyOhnJkqLm3jXmF+rbq21X7KVt2DFtfMmrA7b4pxK7ATk9ZhBwFsvyvwkGYl9
	TrOw71RZe/E3roT/pn2wYHVh1P0QSQraXzu7u/cC4sAKahgXuhp+v7EdF+qmPQ8b
	QJ0BcnDT3LVlAPiTnPYWjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790928593; x=
	1791014993; bh=SZLHPzwla0PWQMrESTu+MZH8RaW4hSnBCS0Rdv8vuQg=; b=D
	RE1oCSW1o9v5ibKiH7DmW6Ngk9CQZbX98WoHerFs67JecpPnlY8x3gyR/MuqnI6c
	aU3gYywVMBZ4bQ9RaBwiMMI/4ypPA1kZ69DFaFE5ZkaEBqq9NbupaUnUGDYzLjow
	XVserQUgi7rK5rYrWusfJYzLB/yfGTyKfJtOcBUJdAa6fwTiWHZh4+xuDthMWkNr
	/l8mS52baCPovP2En0reRJetV3f8ts17g8q3V83iPTIgwQmGPmKv+LnyRdN4nL35
	sLvyTSh+tDGkb9obygbgokEHfqmca0JOFp3k2A1R3vqU/wKWZoSqgO5mchtaahuB
	29LyobE+GElp5Uplc+RYg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790928593; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hcwe4Ej0fRgRu93QYPPQABn1MQe/NICJ0udwG5slNqnPpyV
	9di5RG1XAvlxkmzu770NcDpMh9OUUr5oUOVW6zZfANs/6D//K/Jhv/vns6GZ6QB8
	Kc0hLddp2vJz7OwhlrX/cCL5gi5uhs0sdAhLswZFHbzwn0vrIbYUQoL4bUCWgb9p
	Ehvm3lYSGb0XJuUgCvoAOJJliB2ivFSn0b6LE3pU0zy/VeOYZqBjxxuTPdxpXMHm
	A+yujjQ0eIviMsOa/DE6QRa/8sobZmlBbb/dgK0eK0ljYwy+aYNUCWrcGNgPnrWL
	P6UxZpMPThj+o+6a7OlRO1arZ17kscH3e1pbLVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:P1z10MTH+sEov3rCTEPBCNrfIh2I2X6RZiN54orA81k=:Y2zYfx922VKjOfR9+XvvzuXR07m+DxTdQkk6aLsMSps=;
X-ME-Sender: <xms:0Wa_anhhDsQr-et-XibNuZcHLqWmAz7TKqyYortoBLYdF0L_KWeMpw>
    <xme:0Wa_aqDv5CjJBS5ZRqsUKHW_J8HPo6dGHHcjpAewV_B9y9Vz_r2kRmepoBXW8biJD
    _F2_s20cbvsWF1mPmVg42TzoyiThjtr3tFhyaGL176YMZnIK877duc>
X-ME-Received: <xmr:0Wa_aku9jPQM0OTrRUi8AI7IPx3x11eudsMJInNukp2EDm8-SsK7tw>
X-ME-Proxy-Cause: dmFkZTFiMJY6nxeo/jMccWltefuWy3cn6ea2g2QEG1GiX35x9x/1PEpsdmiCp9WYU3/3FC
    Lx3VCC7/j/MUylhq2vuiqaR+GJ8hE0hokZMHSIHuglPDy3SbjyR/3TkBILfy/DQc59DsE1
    sB8ckp1UHUSsuIwN+wEyB1HK3rStTd58Z3hy2qtRjP/ZyR2YZlUMU/6p2g32GbbIIBicsN
    aC12Dxlhrh+GBIwDkzs/sMQkLkAVa3pXZbBl3RapTLNTG9qbmLmuuzy/ZWykXO0fBK39Uq
    hV9htYxMjcGJ/jENaybjN6cyLjDTx/JwSZSTeWrzgvI74DM2CsHvizQSY7NsUK2Zh8T7se
    l2r8ficGS4dTbGqLUBp6ZJKtwHml70mMkwrv9MMRpeJJzRWmgFmTYe5aByg0JgdgkJF8QC
    h1yts4Ypk9bK+MzQI7lmnM6jpJIV2zR8MnEwGrTYSlwZ3KEme9wF0/CvbEbdX3s8JkOsVo
    QYvFLVCJABh+Sq9jgeSDgvheYJGHpv613FWL2626DEoV37NwqzcYTuGNYSlylfaJfo1UoJ
    T+Zb7Tct2iTyUzYjr1jhaNPozpf6u4cT/2egzei2oLcL9HyP1Wax+/G8bT2CwOfNlwpP5o
    fskfb7RFY/xfvcucatQ0Udc0j88qBxq7EnvMDUlCb7/cblnYoJS5saZXrIfA
X-ME-Proxy: <xmx:0Wa_avZD_ETfR211mT78TXw069VuaEfqOCpSysPN-xoT818VaMvLJw>
    <xmx:0Wa_anVxBumlTL8zpIzfXQNcb6kZNg56xUDpoRVGRaU7vsOorDtEJA>
    <xmx:0Wa_aj5YIa35zhN62SHgjh-SRcMxjkXrMzMVRVdD1t9pC1dvoLMnqQ>
    <xmx:0Wa_aij5NqUHwQHG5rS9wC5C1K_CoRqNgZBrDoH3CFwUyR1CCoGlDw>
    <xmx:0Wa_aq6LSX1DP9LqlaTPXgmzL3vt6IFjt2jmCIU62N2m3PL5_Wb1-tQZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 04:09:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df3fe9fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Oct 2026 08:09:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 10:09:46 +0200
Subject: [PATCH v2 1/4] parse-options: fix completion format when first
 option is skipped
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-pks-parse-options-subcommand-groups-v2-1-3299bee52dea@pks.im>
References: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
In-Reply-To: <20261002-b4-pks-parse-options-subcommand-groups-v2-0-3299bee52dea@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "--git-completion-helper" option can be passed to any command or
subcommand that uses the parse-options interface. The output it
generates is a space-separated list of subcommands or options understood
by the command.

The format is slightly broken though in the case where the first option
is not being printed, like for example a group or a hidden option. In
that case, `show_gitcomp()` will of course skip that first entry. But
when printing the next option it checks for `opts == original_opts` to
verify whether we're printing the first option. The check will evaluate
to false though as we have skipped it, and thus we'll print a leading
space even though we have printed nothing else yet.

Fix that bug by tracking whether we have already printed anything via a
local variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.c               | 4 +++-
 t/helper/test-parse-options.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..8bb30ec116 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -845,6 +845,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 {
 	const struct option *original_opts = opts;
 	int nr_noopts = 0;
+	bool shown = false;
 
 	for (; opts->type != OPTION_END; opts++) {
 		const char *prefix = "--";
@@ -882,8 +883,9 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			suffix = "=";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf("%s%s%s%s", opts == original_opts ? "" : " ",
+		printf("%s%s%s%s", shown ? " " : "",
 		       prefix, opts->long_name, suffix);
+		shown = true;
 	}
 	show_negated_gitcomp(original_opts, show_all, -1);
 	show_negated_gitcomp(original_opts, show_all, nr_noopts);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f181f0c02d..fbafd67756 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -351,6 +351,7 @@ static int parse_subcommand__cmd(int argc, const char **argv,
 	parse_opt_subcommand_fn *fn = NULL;
 	int opt = 0;
 	struct option options[] = {
+		OPT_GROUP("Subcommands"),
 		OPT_SUBCOMMAND("subcmd-one", &fn, subcmd_one),
 		OPT_SUBCOMMAND("subcmd-two", &fn, subcmd_two),
 		OPT_INTEGER('o', "opt", &opt, "an integer option"),

-- 
2.56.0.353.g0856645cf6.dirty

