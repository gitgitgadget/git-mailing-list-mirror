Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A864AA569
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827462; cv=none; b=G+5mNPNN2Ysa49UFBrCF2xCJq4bArxqvMq+LEfyf1QSU4we4tn5nXqD+299lLFPC6pyDOwejnTgayXduKktntmECqf77xGJ8OAk6uVhog6UJHyFsHslOXRbNRo+St101/23Hhs5k5rVaCcLP9MoGzZMJhEoF0C311pTVbtiC5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827462; c=relaxed/simple;
	bh=SztaHAyIkQWOhNnWM8FxRHau5ivKDLiPhWsqCasJImo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiyCwXgUl/i2YEcRc6vifkfB+dJ3tA1TjK58Fh45MLDranaYFEsCPuqZS8E43RIBuyDlNlne+VWZghLh757cJi26VG1y2X+U9ERoZI38mU/omP/CfAUdobMCHtS0Dv/YiJolcCTc87xO5BKz8Ziczgs2UV6wMFddMv1/xSLTiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCcZgNEJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCcZgNEJ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677ad9083feso1463703d50.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791827460; x=1792432260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+UR7EBBJR2ycfX64b4mN2Xa/Lf9R/0ELkcT9D0eF2o=;
        b=dCcZgNEJS6lkTqM2DLqiRqdv46sFrSlxLzvw1OssVOFXEYT90rW/LKB1svpyfxHzus
         evUVCdfkntkUw+thwqj5XHxUxcFCLZKJbHbQvH4V2JyurMruguzz40+kd+BHFbFH4BZt
         IqJBYgoi3m+j4W6VqX/5HOh3hFFKu6msRfLpwuoG8zWD5NcHP+cyWjtdxlcbQEqw3qXd
         erubuJo306VlRw+h1GwBPkrpDx8vLtWbgp2DDk8sFkH+HCUwVkd4A5Z8Csxo/Yevr2Mj
         ve0Tev6Ht5X+niv2uxNSAr8OzbynS+Co3FxBgZbd0oMa/f7L5ScDOi4LjcLIlqgmcyRF
         Q5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791827460; x=1792432260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+UR7EBBJR2ycfX64b4mN2Xa/Lf9R/0ELkcT9D0eF2o=;
        b=VKLMMVRlnbI2C3HqlTXz2ZcI+ZpsJ0PxERrBkrroDHBh40ig/YTIAASBqXtvIOkTWw
         LFAtNGTcoMPdAovjnKOtYodwNqbcfCaZbrItN1ONQSIwYLR5roLHyhJtYpZIQ/6gucfv
         21JyDMS7Pf85yFZ5PBzKF6nsFrPMASt7Jky18b0tm6BZek74n8kAmLTT+0vbOAwzKp73
         kQL669PlI4weYsgMI20vmVKwZnKi7GHNbHzcvfKvKKS0856wEPgGpOqvlepCzHWsg9na
         jDlwoDWNl5QmZg8EmWwHOnB7StjnY3LhTXpjkM+QIcAXaSr+2LHl7g80QSRQdK/8/mIZ
         hf9g==
X-Gm-Message-State: AFq9FYJtpY5MoJuM2PGPSMyOR7NwbbiXmKWwIt1RUfcMshkwV8W9B5+m
	BFnVhII4CE0jS67X/PpxIElmJM1iWNOMTGfZPeYm3LiE827mZOSFqiQDniXcvB0M
X-Gm-Gg: AYBFou0RDz7V30Ymp9FPttLVbKUWzIuBH3wX/saKZlEp3a4KCu7kIJ1JaY9M3jWcXO7
	CBmuAHZlRb9YzJTvvzD7aPIzRImOe97K6wQmMRu7OeYYnTVcU5Key7wrgirxE/x3UY0CYoYUfRe
	ZutVnBTnAeT4WNsqgtRnpBoix7HWofJ0LJhoXrWyuRwniFK2e4T6DfrSgWH/Ma01jWWn+WZYCwl
	5YZzOBq32jPkt7rUtW5JpT0roBhkXeNZN7FU734wW2u++ArotnSbyu63PGtwDmzO1Yv4PQttyZv
	teXNOH75zSX/tTbncV96p9J8SvaIAi+ZcOBwAzy1mfHNK/1xfWfsgCQSs6gmrkeubuTn21Jub9p
	QdXrHDB9WknDr+/3MAJ6VsZkpWZZ74EVT6NxjDdRP2OKSzyzSuxBXvvfs//SdUT7T1gGK8dLi88
	y9XJ7ov7NyP6nZr+jsP5r7VMlkGndT2290+YyA4pOIn22tRXz3uw5f2sl+8peStX2eNsZe68ZLB
	sp5enS/IT8CUa2dL1Ze6jN+0zsLP72DbtadBhRjsT5R67WVOwO8Ik2uv9NBHVkUpjcHV11duU6v
	120+ADV1EBoVGkmDbaG+jA==
X-Received: by 2002:a05:690e:16a0:b0:677:d6b1:d9a3 with SMTP id 956f58d0204a3-679369be51cmr3626222d50.56.1791827460366;
        Mon, 12 Oct 2026 10:51:00 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ee8603fsm36797127b3.4.2026.10.12.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:50:57 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 1/5] completion: simplify stash subcommand completion
Date: Mon, 12 Oct 2026 13:48:27 -0400
Message-ID: <d0e461a14a254cae7d15aa6b62deedb4a0ac6deb.1791827304.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.184.g5a00b4a6e9.dirty
In-Reply-To: <cover.1791827304.git.ben.knoble@gmail.com>
References: <cover.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stash completion helper contains a hard-coded list of commands, but
git-stash provides a mechanism to list such commands
(--git-completion-helper). The pattern for using it is wrapped by
__git_resolve_builtins, so use it, bring _git_stash closer in line with
other completion helpers.

Note that we maintain the "save" special case, since it was removed from
default completion in 0eb5a4f911 (completion: stop showing 'save' for
stash by default, 2018-04-20). We don't have to do anything special with
the exclude (3rd) argument to __git_resolve_builtins, though, because
save is already marked PARSE_OPT_NOCOMPLETE.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..d60e85479c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3553,8 +3553,12 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local subcommands='push list show apply clear drop pop create branch import export'
-	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
+	local subcommands subcommand
+
+	__git_resolve_builtins stash
+
+	subcommands="$___git_resolved_builtins"
+	subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
 		case "$((cword - __git_cmd_idx)),$cur" in
-- 
2.56.0.184.g5a00b4a6e9.dirty

