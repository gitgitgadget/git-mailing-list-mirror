Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E242DF122
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777144; cv=none; b=ZEMjpnQy/E9MkQKAc+vJdlC8LMtE0S8ORMsU9I3JmU+cs9MtSIdtuzt/l21qiVkMkp+KT5rF/SudRf7dqra/64XP7RAoyqsxkMZ8JR0Hf43eg78E+F1Rx73XptOmnKeA6I4n3i2d1R6kcfzyXGWoGzNliDwBLuuAFytQJqCgjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777144; c=relaxed/simple;
	bh=MMA0hRQeD+iN0bSx3DM4Fg0KU5k7YLFYM4VSKxBACfE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ER/UFhLy96LLsg+DVeEuUG1cR00LIZnpOKaL8+KjP+3t2UReELfuzLGtTiANQGNyfDJyajXSxPZBOydoHCCRSbG5eoGdeMze+LfjK6a0oTFBsU8UaIIE4tfURphXtO0AtltR9zcjoEfVWMTwunssKEolVwGzc/tuzqE4vMezmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXmlMB50; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXmlMB50"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so4376985a91.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777142; x=1760381942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnWH9lfduIO7nFOcteVZe2W2IGrslz3ucmj5+/plwkM=;
        b=hXmlMB50KJHtqGZmgCJjP8FTjLquM7ysBwBDabu8kFdQC3rFJLpZeEm3PgpUKV7k82
         +wLnDGCuLK2lUfcIcYYID59xVXXLf/j30cF/pqTD1YcOXtUlM+JqbfFM7ciZygxtX2yg
         2sIwWwklaLH9+njDT2B1fRQtY6j9CZxtka5607I5z+am4q1mwfPFzrYg898bFjDyzzx0
         g4D1hMhp/SIwFSQkPFVOUxb91duhdjvz+p9Uzd5Na79tQLSU5KtuIT2eGYwvFoR094Ro
         g4QNfjhhZebzC0KShDcR1aB3eeg1YpU3Az9K68IkAk5LVzGUlCo5kH0hl03Ae7eFiDYG
         0L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777142; x=1760381942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnWH9lfduIO7nFOcteVZe2W2IGrslz3ucmj5+/plwkM=;
        b=TRM8xq1us1AEnCOu1rvafGA294erRfa6eYqkBv+rcWJsAeHyrd+7mQnDwfQ/M9h/rg
         9Ac6PlS6HLMqKbNPO0yDg0o41+BA1PulM3Nl1cU01Xla4FuFDltHAhoVwjz2oj6hht9U
         Db+UiUwmFsfuMkKidLH/4HDXSMmLvUze79PxI1Px/EAXL8b5Fo7JchFnBejQYWQf7KMz
         uq8ZBk6YjMYT65v/sqCUJXMwldbcWJ5OtWBSh86y3APT1uZ441dxAFdJx/DVOBoKNr88
         Ym0hu/JxX0NQTvq+byXZlbb5Fqp03jhqux1BF8/YwQXdiB1UMW90KsyXvsARDEt1z9rm
         Nh4w==
X-Gm-Message-State: AOJu0YymdTL8yAXC5PyypFBwPEUd4blylhqzBisW4cHK+vzQeWvk9HBV
	Idh2j6k8VpH2Fxs5Z7bdXWk2qB+elSQKIHKfUFPHej9g9Wzm3IB0b9FblmuJ8UE2
X-Gm-Gg: ASbGnct45dmqs+fWocmtcgYB6wiuXIzhP+vfaCPEL5RmweyCgcAEyiZe09CJuxumhbw
	lJ9kJo856CfMnccScGCHBlbO8aZt5Ms8ElC0/frDisXXPD2c0rFc9xUbzrLk7v0scV5CyckP+0a
	aUZ7IbxdJNZHWa0cAZZqe9T5ssiIoztgwLHjlIPlg22iay3E63uFbKncfXwTF8QHQi08t09AKUC
	6bQ4wtN92wY54VkqZaywiVyMEB8bpZoWKbA82HvFLcNs32D0p7XMHW8iaxFDbAN2b6YmOs1Tt36
	nPNofM0gMgJLbNWBUmpPHUjTZ2kkMAUk1wwPsUx0X9fZ/HAb2NP8QcIEhE1l5KZnF5Rkq0cP+Hl
	MfhsKi3AeN9RVnuuy6FAI/OEMOpD6BzsC8y+OzWcIER6kBLlnCQ==
X-Google-Smtp-Source: AGHT+IEaxFki+bysjyjRHO4CenbeoI3fZF5POKhBIIVyaZ+CrTRC/GwDECmwu2vbA82JebBvyvaVOQ==
X-Received: by 2002:a17:90b:3a81:b0:32b:7d35:a7e6 with SMTP id 98e67ed59e1d1-339edab9316mr803432a91.18.1759777141997;
        Mon, 06 Oct 2025 11:59:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.217.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339edf4f0fesm113698a91.0.2025.10.06.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:59:01 -0700 (PDT)
Message-Id: <ddeb8ecabe4ab30111b749dab3cb898ef41b4383.1759777131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Oct 2025 18:58:51 +0000
Subject: [PATCH v5 5/5] doc: git-push: Add explanation of `git push origin
 main`
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

What happens if you run `git push` without any arguments is actually
extremely complex to explain, as discussed in the previous commit.

But it's very easy to explain what `git push <remote> <branch>` does, so
start the man page by explaining what that does.

The hope is that someone could just stop reading the man page here and
never learn anything else about `git push`, and that would be fine.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index aa01efcc0a..36bf1cc438 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -23,6 +23,10 @@ Updates one or more branches, tags, or other references in a remote
 repository from your local repository, and sends all necessary data
 that isn't already on the remote.
 
+The simplest way to push is `git push <remote> <branch>`.
+`git push origin main` will push the local `main` branch to the `main`
+branch on the remote named `origin`.
+
 The `<repository>` argument defaults to the upstream for the current branch,
 or `origin` if there's no configured upstream.
 
-- 
gitgitgadget
