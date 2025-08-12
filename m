Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555C28312E
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006575; cv=none; b=m4KcLm8RnBbGunnq6NUUqxoX/UWGhZagpFqUKrfk8q14GMF2rej7t4uq5jiW7NjHF80puRiLuxV2CRSupWgeVWt+ptf6juRwd/f/DlSmhcLdc30JYLFg3wO4lddU7bHh6JpzN1U3AQyD4oYM8FsVpcndCBbDWQnakznXMuPq/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006575; c=relaxed/simple;
	bh=bLmeyXSHKM8Az49Ee1PjpFuNowdoVfPlCgQV1L1F/6U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XPlCLcb+pTEXatQtiWMT8wPpn2Mt+AgrkuvS6aII1i1MR0br0nbpMVXSKCtKNqWXSnJoRc3KYy0P/Rr8M2qThN83ts1/z7elQf1EyPTrL6BujLu+PJrimv6RgKTbkSueWKQ4+5wcHBTiKWf4yXIYHDWwjPO7nAhgnnjdqyW03Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tce/oPYP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tce/oPYP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b914186705so336758f8f.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006572; x=1755611372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=Tce/oPYPfTg/biVC8ofad59xoKw2SbXvtnKlI7cUJgYh89kXE3hbQW0pRvAIiVYHC/
         apYXDOrYBG/dRErjV7e0aRztg8BONAAwvOTgmBD3JVrr3d8t+ZvLQdgmBqGjB5eU8Vh6
         zAcY2RtILyHv4uGpQEOzxqcMdgaoeXSTdzYp5wmTgpw4jR9KeLGPeRM7Sk1ZVdSRKEzQ
         yEGxJAsnWQ57U7Bh/B7vOQ1nKATa6idyhANCoLc96u4Nr72YhHkS29bECQS02e2sEeg4
         Zmko+rWU+OHsT6A7p3fR9s5Nd8rHs5+EIt315t0EgTZGAsJMdu217Z4tI1XAe7ZxYUw/
         /3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006572; x=1755611372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRG1tCa/IrI9Mc4Lghqvcla/Of5GXD5DMJ1yUWYoUvw=;
        b=sskz88vergHAXJwkAdHR0GQzAgOBuya3zY6+noQ92OzQf8KzTvvJX/JDuVBAn2btYn
         OOnufI278rNdf+1ey0yZ5wJr0VmhkRRwU8ogUGggwC1GDFdX5Zu7ZHwWBUuZQhf90uZc
         vuqAeRn4K4QFF3GPfmo0ryBnrRZtQVJnVk7W3HDbvVNLfnDiBCcgFphvrVJQFzbV27LU
         Yw9RgQd5J6Vytr+E47rGiZco8ZfyXDo5rLRRAf3fmlms67KNBtC6u8F5cCqerrLkvi+9
         V58df7yHBC9ssnsH5wfRKOrSWS0v4BcqUvZSyOAFRryG1ntdtzRUj/B3EsxAFVhMz8ei
         0rig==
X-Gm-Message-State: AOJu0YwQZfyvDhsedjjJdyB8hivDlhU3ll1NAzANxYtMD8MERLPR33Bh
	DpjzBNkEPvVrCcR1nLu5MiYOp9qF+uyK+MuoT1g3H+Iai6FxVikAoUs/MVJ/UQ==
X-Gm-Gg: ASbGncuVW+kSjceTs29l4Jdqv6ijQXad0Q2VMOnhKlj1Cg5/1CCrbXZGWoWngdmsdZT
	3h5R5GZq87FU7+EgvVRA5LScHKKQwS8eWDH6yfOw0ONbigE4iuq5HUVXJzyutRaEVw/Z24vUfEG
	OCCnIBpJ91jgGGBF3aUetUfA4eWhsWZmhlMwnxN351kvzHRvhHWvnhyB2rJLCFrOLmVZjO3s7js
	KKYYjr6W+VzyToRo41VhqLQSKTBhCyxTpLeWlpJDh7HCHCTgrGFokmfUln9DhR6f2aAm5GDM7U0
	ne99gFP+xG5ggzeIuqCx6uxtM/uSf3HEQhR+UpKD6ly3EPS6xwsGwRGmsbOYy2Og6lqwSE5PE6n
	iHjwwRGR/sNqZFeGU5urnIIs=
X-Google-Smtp-Source: AGHT+IGqERoiZW2gEa/Os1sK2MXfWkuJ/lzPu7BRaiV3/dpIqIiB050CQI8bAu25C+LtxXVnYGg6hw==
X-Received: by 2002:a05:6000:2386:b0:3b7:90c7:3277 with SMTP id ffacd0b85a97d-3b900b2d94amr12812936f8f.17.1755006572184;
        Tue, 12 Aug 2025 06:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm44677815f8f.62.2025.08.12.06.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:31 -0700 (PDT)
Message-Id: <7ee6b0afe88fe4f5346776192a0df99c6b64de19.1755006568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:26 +0000
Subject: [PATCH v7 3/5] doc: git rebase: clarify arguments syntax
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index e82ceb9cbfce..6d02648a9b3c 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -62,11 +62,7 @@ one of these things:
 
    git rebase --skip
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

