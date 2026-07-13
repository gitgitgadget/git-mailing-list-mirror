Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9A83E16A4
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939506; cv=none; b=rGqp//pM78hmw237HitUpYbWpKjetroZtaaF/4xXH6eSJx6R1JSCzp4czIZN4daffGzvxrXsSrQeqStwo3CRDv7eM+HxIzYEVb6Ebk2mVHcI/n2pLhc/Y3LbyflCYEs7AT3asJ57ssvvHf8BOk/02gG9hwaCZ5KBsx8n78HfmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939506; c=relaxed/simple;
	bh=dHJ5v+flstXJg1b4fiPgGpXAxz73aDHe48Jklc6zTcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6t+5gn4Nf9ECpyWohxB5cXY6Uj69pbiRT1nzkd3hyWfmpc9DquGgEx4hKUBHoA/hKzuzJfcGMhEurO91D2gBFnFnCN2VnT0tQ+H956INjxEW8SujRFsRZZEvaTsKYozPt7qXIELrQoz4XVvcojoDnRtpD1mhq/oNwxaiWehECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR+iPo5Q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR+iPo5Q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so13874435e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783939504; x=1784544304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=hR+iPo5QPglcb3GhtrIAUKLbYHkVXffmdxltprBHUMM8huohCGrv8/UMiMiixVmIF6
         p56jymFJkTRWfbiWkWK4KkRdlTtAXvSzh5InkdEGidw4IjFgAYEfg8mdhGCXn7eZS0vJ
         p5YmE3GgGc8ktv5WAVHeAErLbUyyWpB5jMm6r6fXJSbjeTfYb/19h07iIfJLTH7oAcYF
         O9YXsiO0LTmDzBHJgq7WWuzE/W59vrZpx29bO39xOtKeHfT1qdnYDnQtR2/zP6nfWCuR
         hCZOphdv2IXmCMjF+aNClqAAMAIoEGIeyRNcg0386EkP4fYU9nn1Pxzv4RzXm+QwvfSc
         XbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939504; x=1784544304;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5dPsCSw4rc76QWSUkZ/YN6TiycwnxZYRqoysQs1ZJU=;
        b=DfnPp+n5hKz+LXaT9zd1cIWYfDkKhuG77Tz3+K+5Q0DLaQFNb0xaTIbFEVainuDGhb
         i8qmzYPfLSyp3+0YoLhgidDfUkJ8f4AbXJTcm6i+PysxHACDMfzifazyqXA422hOREmP
         sRWvXjhx6gdSwl3kLIVdW+zcnXaPY05fyTLxLkI9SCy9U1NA2reiP4KV6Ty3gz4JV90V
         FGOjwIanC40gS7jmrudcV6LFsvld5uCLAviUftsPWyNhdbzd2MtXSupBJq+cjIocCmAz
         9w2VwXaLjj/L9xCCADNl6Y5n4H8c6pBBKLNiQRNgLeg2OZ8krIQMQj6H3TBMa1QD3vGF
         d4Ew==
X-Gm-Message-State: AOJu0YxYK8nI0ftRj2Wh4ejk8nWEtU91YM1TEYQPREuv6rwWtln6207r
	MXXGAIT3gQVJ54fmWHTVCB/2qQH5C1qforrOf6X5C4t4ut8AXj6ink5HcZjgBsr5
X-Gm-Gg: AfdE7ck7CEOLCQe898ElyrhLFWzZ61Bo2wd8+0IEvL3fY6uYRp8OWMRwz+nLa3Sz9Vm
	waCuI6/Co8Ks4XbhjltEmUO+KZLFArfqvJjI5VeLKphCujp+9woKmL+rYNMN+CqMpTvPYiU6fcL
	0dKDt5Psfy9XesH/ws5cBbFRHWUef+6WECPy+JniMI0W8XYitGhNTUMlEQpWVyQIskKJA+jybj5
	Z314cMfTMlJyl7ETth8J91MiXbfvLmy6WjCfg/jhIAh0SqvzUkBi5YzJzjSbAzQW94rvPJnyRDF
	GbJeqrtNE8FMWNOLVxX9uFY3HI289i8/f0PxEZupETU3/6dBFEkytBXMaxZXOPLf+gRgKpNEMYX
	ivKrGU3APLRsKyEMvXyWstkGU+A57xa3gfDBVV8UFhHDnM+i4kkVcZ+xCKgUFV5hT9sp/2tD4vF
	hxvQ+VwWQ3eMoPucuFldEbiErqqWpSZySMv56bkIeixOv/1AcSpLLq917WiSIKYPIFFkd42aML9
	bvFD+hvgLv1QbGiYDaPyY0n1a8A3+tPAtJM7kWo2Hd3iX3TPhn+nl7qLedoHld2L48cagTKkcWg
	AA6YccNjLBjgfYI06ZsYhR1SXyztkg/rlxI8iUVoagnqtwBEOb7ocnAqeLSugbNT5ZSuaWdsksr
	9p7ZNrXFpUw==
X-Received: by 2002:a05:600c:6097:b0:493:faf3:3ead with SMTP id 5b1f17b1804b1-494033f5d7dmr16819195e9.4.1783939503722;
        Mon, 13 Jul 2026 03:45:03 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm318564645e9.9.2026.07.13.03.45.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 03:45:03 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v10 6/7] graph: move config reading into graph_read_config()
Date: Mon, 13 Jul 2026 12:44:41 +0200
Message-ID: <20260713-ps-pre-commit-indent-v10-6-82ddab26bc96@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
References: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <20260713-ps-pre-commit-indent-v10-0-82ddab26bc96@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move the repo_config_get_string() call out of graph_init() and into
graph_read_config(). This simplifies graph_init() and provides a
function for future graph-related config opt.

This commit is a preparatory commit for a subsequent one.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index e3e206170c..c14be934a0 100644
--- a/graph.c
+++ b/graph.c
@@ -417,13 +417,11 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 		diffopt->output_prefix = diff_output_prefix_callback;
 }
 
-struct git_graph *graph_init(struct rev_info *opt)
+static void graph_read_config(struct rev_info *revs)
 {
-	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
-
 	if (!column_colors) {
 		char *string;
-		if (repo_config_get_string(opt->repo, "log.graphcolors", &string)) {
+		if (repo_config_get_string(revs->repo, "log.graphcolors", &string)) {
 			/* not configured -- use default */
 			graph_set_column_colors(column_colors_ansi,
 						column_colors_ansi_max);
@@ -437,6 +435,13 @@ struct git_graph *graph_init(struct rev_info *opt)
 						custom_colors.nr - 1);
 		}
 	}
+}
+
+struct git_graph *graph_init(struct rev_info *opt)
+{
+	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+
+	graph_read_config(opt);
 
 	graph->commit = NULL;
 	graph->revs = opt;

-- 
2.54.0
