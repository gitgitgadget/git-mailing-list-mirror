Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FA4E3259
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849632; cv=none; b=rtrNBbi86A+qF9xyxYHJVLL2zbGCd3lCEv0NZ7BRCQc6FaonSnTidgqan9SqS9N03E6kTS7cQ+frwNWar4LVKbTD81p3mizWI8B1rxbTJUM2Fkc4EDnS0D21Jw+igf4GYq6jnAAYwO5URV9HNpTyo4smQnlgH6l9VeaNdvQh5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849632; c=relaxed/simple;
	bh=YiVXJLLZpCaGkZAqym5D/4GQnrJ/d9Y2KqJnz7rGRrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jf2unhiZcED6Ylg/+O28AGSYtKWjgPsvEI3VXnkXbcvg2fBYt/SGZkcFOs9NGBjxcNG5KHpyzwSJSpM3PDkplDw7jeBCUWiK2z8IkKEp4iwqFpacKPU3D2G+JzOwSpoyiinzeQiLhyFTRDHI9iI4zCoQyOL00n7mJs4vH45swa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fj7i4Le8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xGmfonqS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fj7i4Le8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xGmfonqS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E9E61D000B6
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 06:13:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 06:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790849622;
	 x=1790936022; bh=lJXqNTv4zWq26IGIP8A9UDsb4bZqRJAT5MvIF5bg3ig=; b=
	fj7i4Le8ml/M92VNQ6B+OA9bZdr/jvhqh2YLwYrGPAaiEg2b9I2t/ygmcHhfZuQ1
	h2P/rD1mXQ/Pk0BkHaQpo1bLJMQRVFYKBDn9SsVGznRWn5MotCvVyCty8zU8w07D
	YdKe/IyjuQNpBn2vwetMr9Vek+3mgj/bafZEmiG7TtEzgmiMKd07jcAdNSLyvhiC
	VQwyJCcf9XpIg8kHMFAu2OCfXn5OXFGpcA9ccW41oEHwsysLbp7tCEifipFr0aIw
	rSukWF2Ac+V2MNd2bZpmYqyrW5ej+OVWZdhqng9GOZmpkhzxFkwMgXVZXGTk3bxj
	mvcath8ASqiumv14N4gHdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790849622; x=
	1790936022; bh=lJXqNTv4zWq26IGIP8A9UDsb4bZqRJAT5MvIF5bg3ig=; b=x
	GmfonqSYcsZBQp+jY/hI7Xq6lmGL97iYtDH1QI+DcEy4+2BzAXXmXo2xZV7c0xLD
	4PRw/gjLhaVB6w+VzhOHuNO9Wj7bh14tcp/FNo5KncxvXLIG84T/Tq/zzWzqNvgB
	4tUGxNfXrM0v10lNt92V5om5YEyPU2DTXwwGV1kD1PR6HaWKDvJgpILH5MOMGBYy
	1SpBra+UvwmBCrmWWDO4UAeqs8scEtd/lL0Sm8ilVKnzhArfzY/E8H6cHSD3MPoF
	EzQZcQe2xV46RXiCU+Ftzrw6CidTXTuxJuGeJ0uiI2oFJVm1fbF/SziJkqXFCpe+
	KiD3Udrp+J+eT5XXAbnpA==
X-ME-Sender: <xms:VjK-amvtXrJDl0KQp85grAvLBGezeK7el_P9a4j-dmrGDYEZpquS0g>
    <xme:VjK-aiZN_YrJeMUdNViBtwOBeav-TdVrw7LRVFBfE2IyHCOZjCn_HDEa1R3w-9MTq
    d1xsrEynJ0Vdu47oZnENp8CTJqbD_O7EYcVrOMssD2d8bNMuX6_KOM>
X-ME-Received: <xmr:VjK-anZoVFAaA-iTBxqK1uLQ60b2WKgAWMwmdGxW4CZUY3pSXmjAEnj5kj9Ot9qtbu9UbA>
X-ME-Proxy-Cause: dmFkZTF0h35Mue9KHmP8mMGW4ZegWvlnVie16JZ/OUm/O4CJZ3hjyFnJDlEtSwqdPkGNj4
    YcSPAPsLVCPLDg5/1Nw7H0KdO0Ff3jIpzIAf4Pszwl75qMiABMJqxbODbWGF6c3siOaumk
    P1BEEb97x56OYefJOHgySdEogrsY5wMeRcIs064fiS8yalNUdFLxWg87tX3sygwlrYa/i6
    EI9jRTWudpfTsXkoNkGhS6YanrhXcU6LKvDlL1yE5C7cXJ1J+qoc2BJlMlhVtIgyz8UeV5
    fB/BrLFUPqcGt2QRcdYzu4CJ2vOXFJYuyFavPwoZGFtjhKVKj2r/T2CPTKmJVZd7oZ9bQ+
    9sYzta8chIhWmpu5zpXSYCMIjqM8HPtBOUI0u/JctdiQmUDTkaNkjsIo0mpK+Z9+Xv56Os
    aw68VGOLwxEC8OnSLx/FB2H0zDQrLtvJfxFNFefSK5fWBO1eqYR8NchNRGD6+CUjzoog2U
    pwxRvTxI4kYY0yN7XqMrikmPp/4oJu11vzuvHn04jS9WYJNcOlxt/VLQ1NyVPl/GmiO6R/
    /yw/8TVPxY9jGxcP6J/qnEmAJ1eIl9lUPjMop7NFwpYwoq4EzrTrZmoTE22BgrwuLExGdH
    gKwrVj8Z02KtbkS/7ucj4LoMapNlKiXutx/fcyOT1h3aDfO0XBo/HR8omGvA
X-ME-Proxy: <xmx:VjK-amX_BxNIT7GPkEJy096o3dnFEOXBxh8s8-HsNlVtbD9u1Kz0CA>
    <xmx:VjK-am1xHfJ4oDIux7YY7dn1ngOKqY5vZQ7QCUw4E9nEtL7QnlouJg>
    <xmx:VjK-alYmmGJ9THCpTZ1LOHxoQD6U8vYQ93FEAr1Dg_nS0WVbNf8Nzg>
    <xmx:VjK-ahqggKc0PBmxi64FBOaDSfGcLG-ZdEeXEgM2oZoCb7tdW1gzQA>
    <xmx:VjK-ahfyvuDR8QLYs4SB2h4iOrR1_cOR0g3dbuUDbWYY5Bbno99QjCQb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 1 Oct 2026 06:13:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c500acb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 1 Oct 2026 10:13:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 01 Oct 2026 12:13:28 +0200
Subject: [PATCH 1/3] parse-options: fix completion format when first option
 is skipped
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-b4-pks-parse-options-subcommand-groups-v1-1-01eb2f4a4c32@pks.im>
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 4519ead9dc..356eeff016 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -845,6 +845,7 @@ static int show_gitcomp(const struct option *opts, int show_all)
 {
 	const struct option *original_opts = opts;
 	int nr_noopts = 0;
+	bool first = true;
 
 	for (; opts->type != OPTION_END; opts++) {
 		const char *prefix = "--";
@@ -882,8 +883,9 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			suffix = "=";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf("%s%s%s%s", opts == original_opts ? "" : " ",
+		printf("%s%s%s%s", first ? "" : " ",
 		       prefix, opts->long_name, suffix);
+		first = false;
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

