Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199953939DA
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705869; cv=none; b=PAIGwrWCwszOzyD9Z+N11WQsrIkxxdRM+zmz4P8h/QF/gAO8MDpFYOoVDr6MJ1oZWhc8JT5lSY9qeK9urvZDjunHqoeWVkP3bqMEF+joEFk2SjlCKawaUX2SNQy/25xuh4jAEQzU3m24s8jg/8mPlyeyYFeEl/uc23MDFgGExnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705869; c=relaxed/simple;
	bh=CI4OKoSh1iWoPaOEhPqe9w5jYPHwoPlMQoAC6JJHwfs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SY6nIP6lc0md+YKFAye7REBXdMUSURoxJUXYh/huiNkY6w94tIib4SSnCxbhRYJAr8PUYAyxFqplM1m7JRfjEnNcngR7XyEVllI8Jw6sKpZQDOrZasinTUZfcyv/FXoNNBUQqmj/ZFgdGx+wGhPzIPvKD/cStYTd2y02NTQzFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jitVZFcD; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jitVZFcD"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e57a753f9so205227285a.2
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705866; x=1786310666; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cnnLcub7HtfOwutKjAfqo3ybXMfPN82ijdgS2xT4UKM=;
        b=jitVZFcD2sMMmoMA+bjDZiF9S3F03UOdRk6UWAvFkz4XK8IjPGrvmuOBUhMM9pBvdc
         j/ehIuN+6+UmMrLYRrkea5wlZ9+p5IGMOlqs93peXMznuL7RDdf7yfjb5ZsDjSyiU9Jh
         NWuFFTKFJpFc7vENOwuOoGAuIO+qYSnwipevZ4CvyTaXpzsyRP134l/5LkKrrJTWAfjT
         K0EDmyQvyBq84KmnqBnnHnSGYEwOm27g9IvKixIlBNsW1gLY4+Hxkn4jh3neZA9h3hto
         yVhZRS38dXbuAN/9FHLe1j7NhFN8NkQneek8nf+RquMapyf5+q9VzZD+MGFJZTQjKCd/
         rFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705866; x=1786310666;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnnLcub7HtfOwutKjAfqo3ybXMfPN82ijdgS2xT4UKM=;
        b=hw6qiyj7XFAtdjB7emrPm2hUeFVFuRD3FI8EaOvjYpjx5ohkmGhY4au3GDGoJ7oQUf
         16WIL4VjI6o/4qqEXkjrsnrWPBOtdpFX6a3H4BEvP7ppFbT9bCS3ZmVljw9uchaPFVW6
         /jE2U3tMgHX8UHQZOKX7F/noKWS2OCgyCRuDNp7wp3KtRpFARfuXVtHQlXH0d9Y49QJZ
         p+H867iwVtXiAmNzyhQDRxLno4TAQgP6xi9SkljMucP4NtHPXsvG0KUBh6UXmrAS3QvZ
         OrJqquzpZkp01jOJbgHCYNXfUAJic1Pp21Ly5L7qbQRU3QvuWxDVH6tuyiD9XraLSOw1
         SSYg==
X-Gm-Message-State: AOJu0YzHkrc/g98f1P1TFWuKbqpqu/D16r+RCiZ5SnG+q8fdXTaNGxVj
	zS0hLmZouS3TPZfEfvhvuJBADGLAIcTvHpVoS6/U/sCG1yb7/umDmzKpNhGxsQ==
X-Gm-Gg: AR+sD10qgOf3hA017ScTdaJEomF7r9WTPl/eUqzvhqbfeuJUe/odCwbmMIZYJIE/XdN
	+Z/765y7oI4WOBa5KNN6kLv1YGKS1VpyHnMk5JsH02l4WrWdKSPc4MMqZtYw90LE5e6Yuolj5vi
	tbWwoReuVjuJQvTrbtcnSKi6UK/xHvLE0u6RamiSHs8bD1/SIVuQS60RHuZRFxjIO6PHraDtrcB
	S6ddfdEfxpmAJs07p/UIznujbGWvDKA+T/37RiAF3NubY5q7fCI63VVul5qkSHJWG7WStEJmr1b
	ekyQ+nWdjWv3RGSywjqXhUrZR/t0RZ2kAJbD9+27jgP1x7Eiclq68EsGdbN6dEdd8XIYNf+85Ds
	cMuvzjEJkDGBSg6YLBYVwYaZTbc9FLVRgzFsK1l6M8kScaEl4ln7MRh6qr0VyWhhfKoSjGrz1r8
	fO9UT+DNL6Z39jyVGWiUYrWVe+CrSpzAZCsxn1ZK1wFYIxDvo+dH/4LBkI6k6WFeU=
X-Received: by 2002:a05:620a:6c0c:b0:931:328:fecf with SMTP id af79cd13be357-934a093f005mr1547143085a.26.1785705865765;
        Sun, 02 Aug 2026 14:24:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1df954sm525545285a.40.2026.08.02.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:24:24 -0700 (PDT)
Message-Id: <b6ab87fd29ab744ce28bd86bc087bfc5956b8676.1785705860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
	<pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 21:24:19 +0000
Subject: [PATCH v6 1/2] bisect: let bisect_reset() optionally check out
 quietly
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a "quiet" parameter to bisect_reset() that passes "--quiet" to the
checkout restoring the original HEAD, suppressing its progress and
branch-status output.

No caller sets the flag yet, so behavior is unchanged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/bisect.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 3264e2da54..5393690f6b 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -234,7 +234,7 @@ static int write_terms(const char *bad, const char *good)
 	return res;
 }
 
-static int bisect_reset(const char *commit)
+static int bisect_reset(const char *commit, bool quiet)
 {
 	struct strbuf branch = STRBUF_INIT;
 
@@ -255,8 +255,10 @@ static int bisect_reset(const char *commit)
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
-		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
-				branch.buf, "--", NULL);
+		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees", NULL);
+		if (quiet)
+			strvec_push(&cmd.args, "--quiet");
+		strvec_pushl(&cmd.args, branch.buf, "--", NULL);
 		if (run_command(&cmd)) {
 			error(_("could not check out original"
 				" HEAD '%s'. Try 'git bisect"
@@ -1096,7 +1098,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
-	if (bisect_reset(NULL))
+	if (bisect_reset(NULL, false))
 		return BISECT_FAILED;
 
 	fp = fopen(filename, "r");
@@ -1345,7 +1347,7 @@ static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNU
 	if (argc > 1)
 		return error(_("'%s' requires either no argument or a commit"),
 			     "git bisect reset");
-	return bisect_reset(argc ? argv[0] : NULL);
+	return bisect_reset(argc ? argv[0] : NULL, false);
 }
 
 static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
-- 
gitgitgadget

