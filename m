Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8E1CD1E4
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757842396; cv=none; b=DuOSmU6xvPARnaNK90AhYauaY8GgJFw2OtdREULKzl2500jyH6YsvPQt0JQsT/VSI1agyedor5IdzJvVgaJP/Vw0FsPI3yDxKdE0mkPrG98iZGvmv9hBY3fd8XHl9nH3QQZOWuKVt8pxOn5ETvhwDp1EnPsAklUy0pewK0x6y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757842396; c=relaxed/simple;
	bh=dTOaedPXOwsEgf7vfCqAnj9JcLw1Du44h5O55ttFiUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fumz7u7MvXsZcbhd6SeWvnhbbJ/P45p1PSF3U0yZZVJy6Ro7/vJNI6nZtU+YeXHblqdqVHfAzFyIasc545ZRau8H3RUjLmWINGge+uAhQH99zXiMwNtkmiHX+UgYYZsBjO3bBGx23LmFYQfv8o8ptG+4cv/y5WNb/wsNpsYilek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LiY8pqGG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYTgyu4m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LiY8pqGG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYTgyu4m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F4BFEC006C;
	Sun, 14 Sep 2025 05:33:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 05:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1757842391; x=1757928791; bh=yo
	2QYGwcvr2LvyJIzcOtxcA2MYLCbyZ+M8SgSl9R7LA=; b=LiY8pqGG2efFEIxG2C
	+OQ/nyWRyItREwNzmLeyQuip4ZPDR9JTKXr+T6gzzEO7zhctKZZ2+FsZPgyLL79A
	s4u3WraDwtZTgI6z4WmB5YlrsLijWP2udai1HP/CUs8UmVCODrK5/W7/Lv1xTx3X
	QzC/dM6rnAaWKwyFdKUcS8b4ONPd6ValqloEG/AhbuhbRh89sdukXwuK+KijDTAg
	j7ui29hBvWEgMmM1aAalebw4c12RgI+FfdwE+4rUQ5agg7PBjq95mR+5NIypEVpu
	f5AbfJIlohABkOV7Z117YBcsusZL3DpXo4KMlYGjdhKlH3IX1DPxQe3RrGzKBqeh
	0n5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757842391; x=1757928791; bh=yo2QYGwcvr2LvyJIzcOtxcA2MYLC
	byZ+M8SgSl9R7LA=; b=aYTgyu4mct2e8tKLu2M0hxU3iuGLZLc7OBwl3BUfoBbF
	ZYNfnRNFAVdt0Py7+KMif3h2ZcHpc0v5kW/jakZrIG/3KNvkHhVe+b2y2+y/oIvK
	i4v5audO9kTqngFZHZy4iCyispZgpSNcb8AiOCSBqyGOVYjFJeZDbc3faOcm8Wn0
	ECf2FHRUuPGT+6oD1mcbU46t1s15OGdI3tUyZA0KwebJ0dXq3rHHsCl6w3DEhI8T
	nUmJsv5EePeTz2IJSPZgzy6KUiKKTD+HpOLCUO2Ox8YxuKpeZyKG1PDhh2y7cQBp
	huyEu6P9AHPZEeBpRrHJ4YJ7v8BhpcLt1RBddX4rjA==
X-ME-Sender: <xms:14vGaIz89fFRhoJ_438AjUOMEeKPqi_DFuMaFbDMTpFuHZPtnyOp4WA>
    <xme:14vGaMdF-3MZ8jOcaRISjN8swzZ0k0y0vJzRgwvy-3DVvuvVSHoO9agwo7i1DvEvp
    X_HiuCPM7eM6lMymg>
X-ME-Received: <xmr:14vGaMLI-y8EHARaOuJv96GQ9SkLwDGvCB7Ycm2IXQ4Rec-RYyZ5QeJgD1pFmRCwTJqnxQzBrRogmWMBEj1DZ3G7ew61Vqr60HMHX_lVYRu0Dg8J5K_caBIzMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertd
    ejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhenucggtffrrghtthgvrhhnpeehleehhfeiueehjeevfedtgfeitdeuvefhud
    egvdehkeevvdeutdeufeefieegveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgv
X-ME-Proxy: <xmx:14vGaFFEMd2OZi5J_UEOMBqNt0CUXUS2Ptf2cNkvrVzBJOHgzDHHmA>
    <xmx:14vGaOrHnkeGWKxDdzYJTslhus5DRGPsmEx_FqovNjajJfDjlEmPsQ>
    <xmx:14vGaGQNhDl1fxqGiKKmCwiykI2v1OLu2Z0vfciUmWmEeqNQmWkUpQ>
    <xmx:14vGaDODQ-O6QZL-2xJ-UnqsC5afVkM6MkumymF8ScSQd6g-F3P63w>
    <xmx:14vGaDUu_HcnoiwKpiGNZpjUeRMi2eRXJq1Z3xppcF8F88qOql3bb-yQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 05:33:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] git: run alias subprocess according to the API
Date: Sun, 14 Sep 2025 11:32:34 +0200
Message-ID: <ad7066022efe5344eb1972d1c489372d97b2d18a.1757842206.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`run-command.h` tells us that this is how we should run git(1) commands.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    From: https://lore.kernel.org/git/a8874cde-cd00-41b0-ba41-ab2fd52ce45d@inria.fr/T/#m2667cc5ffed44fb7b73d349b1e6dba281e3e0384
    
    The alias question.
    
    But we just end up running what is named `git`.  So it has no bearing on
    that question.
    
    § Code spelunking
    
    I traced the push-`git`-to-command code back to `argv_array_push(&args,
    "git");` which lead me back to ee4512ed481 (trace2: create new combined
    trace facility, 2019-02-22).  It didn’t look relevant.
    
    § Other code
    
    The only other thing I found was in `upload-pack.c`.
    
        strvec_push(&pack_objects.args, "git");
    
    But that one is intentional; this is inside an else-block and the
    if-block has `pack_objects.git_cmd = 1;`.  And attempts to refactor it
    broke `t5544-pack-objects-hook.sh`.

 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index d020eef021c..f16a8fbb55d 100644
--- a/git.c
+++ b/git.c
@@ -825,18 +825,18 @@ static int run_argv(struct strvec *args)
 			 * process will log the actual verb when it runs.
 			 */
 			trace2_cmd_name("_run_git_alias_");
 
 			commit_pager_choice();
 
-			strvec_push(&cmd.args, "git");
 			for (size_t i = 0; i < args->nr; i++)
 				strvec_push(&cmd.args, args->v[i]);
 
 			trace_argv_printf(cmd.args.v, "trace: exec:");
 
+			cmd.git_cmd = 1;
 			/*
 			 * if we fail because the command is not found, it is
 			 * OK to return. Otherwise, we just pass along the status code.
 			 */
 			cmd.silent_exec_failure = 1;
 			cmd.clean_on_exit = 1;

base-commit: ab427cd991100e94792fce124b0934135abdea4b
-- 
2.51.0.16.gcd94ab5bf81

