Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43A3D649A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954684; cv=none; b=MXwbhLvhWj2OjIcLJSethsSKaYVJXnRYalAk4DYR+kHYJ+UNOsM+IX++fw+KwbZqH3wqga/H1lONynGEK1aLbrc31BYP6BYPkoN/iyjkPa+GZy4NutT9uUvFIsbAu1l2OaVjeHopdaOSzYsfVFCPs4PnYqS2JPjhcEGhhdtCZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954684; c=relaxed/simple;
	bh=3xmFoFxSEuQnafaj3zEgUJo20mJcKUzb52SVfeT6Z5s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b6f+Bj7qE0A0QbSrsuK/ca+hlL09p1V+rX/DZBjujSt8XpNcXDOj+bEUXA/MNyHfxUYOLZz4sUcmjR2I3Yhf7iUkMrpV9FnAjaDRIG4aY7zNhUvYelMnrRCyHfXkrh9uPjFTeMklYl2KmAhNl7Nu8B57UAwPL0XxP8PNqvJ6iJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRo3FUE+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRo3FUE+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d049069377so14343905ad.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954681; x=1786559481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OZ2XyPS4XdKkEnvZFJJ7lNUmYR3BDgYmSWS+zi1tbqA=;
        b=hRo3FUE+XOQqRLVhwg1B4XqR5/ERUxSRvoMIF12Prsv4o0kk0ryH0UkFKS9WzkQbyd
         ZoYdwSBtvkVyaWZZCI/ePnv+xJC62LUB/3JM8FVdWADVfZPD0HW8M0GNog4g1bCAMV8I
         5EoaoYgkQAQ7bZPZjbeUuvfmHEQsF/Xf+GlcugP7lIsHYesZDmZjLYSXm3f145olRtZP
         mQwXVjTJBOHRqqV/45I7wgN9McvdSKZMJvKTNOyvh2NTxZfmDCMGvO9xETtjotLpsVIL
         E4iiZEAwZhsmlqAnBeBlHzKIJ3beVY4dM+e6ToZEopJez+II8wmKMAMjz4UMDNBx7ck6
         e3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954681; x=1786559481;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZ2XyPS4XdKkEnvZFJJ7lNUmYR3BDgYmSWS+zi1tbqA=;
        b=n+tGbcK/AUNNcAxrRCgroJziktGHuFXPXFOWju0XhWFzEQZ6LI7UXNPQe7vpFf/K3G
         z+tuGXKIXdlKZQ02M1UFvbDWtoSCDQjzOx17zd0L/DUlTTi0P4NqbWNcvuMkbt2qdcXK
         wl4q66Xa+rlpm5GwLGiUWnGsdZvENv+H5sxT3m4/MPhVvBGHXPQV2UUOZVvJ1XkFQAda
         aQZf0rg0x4GC02e8YFZlfums+y3EcGjoLzEcbRH4sfxlnfaiKfTcIO38NSzRRoRBJs0K
         GrOWsvxciaos3otOKLkcCQhues6kjWlwAeumcW1M6HecYRbiQWqDIY9ra28VkaOeMBRa
         poDw==
X-Gm-Message-State: AOJu0YwYvEFvdZzszxM6qk4+cPrISSzbNb2t12C89JSl8BpaL9YQ94RE
	qkr/yCu98fEj9XgbyJdpzStxfnBPoIWPx/WZKDs38q80OgsmFnoYFhSAUZtsZA==
X-Gm-Gg: AR+sD10e2B6tgNE6MvRQ58Jc90n7iGl85H/9HShqEYv3slydQWZE4j8sCr7aLNEZ4JS
	GfsLf5uPXGA18a+v2ehCGjiAd91LY6GwrojR5zj9F4f7YppGn8275elVAKojgFC+02STmqHyiS1
	qAzCxUz0+f9U89/G8eJBMCFZL1QH+D2i80Bs9za+r/sgk5gtSfN8kSaxEVPV7h9A1Ab0V72Ltb8
	vWw68vyz4m9eIxUa9iQzh0p1JBX7tdD3WGw7ElGjucSJ6ocmKRyFSZX4SCCNzP1Hup9wI+ib9ET
	wjYbLmpVPpfTXIV3J3AQiEQf860/aP0SmAB70mOSWafCynN8qwq2/ZwJEYUIEyObkfjnSbTXY3v
	eRqcpaCMzyBgaNe6OG8s0umyR8xuT89i1IbIBt2Q0A8/cHh8o/uKpZUat6iRhTpF7HW78Ucpl35
	cxCm8oSXY52sYHgBrhsHeaTydN7He9uLzSkhYu8VU+JUOZRd831jF7gQ9tUssYD83sdA==
X-Received: by 2002:a17:903:2342:b0:2cf:bf32:b754 with SMTP id d9443c01a7336-2d0ca711fafmr97721085ad.8.1785954680872;
        Wed, 05 Aug 2026 11:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492772sm20711885ad.42.2026.08.05.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:19 -0700 (PDT)
Message-Id: <7f2b9631032bb2719060b6fe1971fdfd267de6b8.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:58 +0000
Subject: [PATCH v2 09/11] bisect: check strbuf_getline_lf return when reading
 terms
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

get_terms() in builtin/bisect.c and read_bisect_terms() in
bisect.c both read the BISECT_TERMS file but do not check the
strbuf_getline_lf() return values. If the file is truncated
(e.g., a partial write from a crash or disk-full condition),
strbuf_getline_lf returns EOF and the strbuf remains empty.
strbuf_detach then returns an empty string, and the term names
silently become "" instead of the expected "bad"/"good" or
custom terms.

In get_terms(), check for EOF and return -1 on truncation,
matching the existing -1 return for a missing file.

In read_bisect_terms(), die with a descriptive message when a
line cannot be read, consistent with the die_errno for a
non-ENOENT open failure in the same function. Unlike get_terms(),
read_bisect_terms() returns void and uses die() for all error
paths, so the die is the appropriate error handling here.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c         |  6 ++++--
 builtin/bisect.c | 11 +++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 94c7028d2a..c2ef5da462 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1019,10 +1019,12 @@ void read_bisect_terms(char **read_bad, char **read_good)
 			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
-		strbuf_getline_lf(&str, fp);
+		if (strbuf_getline_lf(&str, fp) == EOF)
+			die(_("could not read bad term from file '%s'"), filename);
 		free(*read_bad);
 		*read_bad = strbuf_detach(&str, NULL);
-		strbuf_getline_lf(&str, fp);
+		if (strbuf_getline_lf(&str, fp) == EOF)
+			die(_("could not read good term from file '%s'"), filename);
 		free(*read_good);
 		*read_good = strbuf_detach(&str, NULL);
 	}
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 798e28f501..69ab7ea248 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -498,9 +498,16 @@ static int get_terms(struct bisect_terms *terms)
 	}
 
 	free_terms(terms);
-	strbuf_getline_lf(&str, fp);
+	if (strbuf_getline_lf(&str, fp) == EOF) {
+		res = -1;
+		goto finish;
+	}
 	terms->term_bad = strbuf_detach(&str, NULL);
-	strbuf_getline_lf(&str, fp);
+	if (strbuf_getline_lf(&str, fp) == EOF) {
+		res = -1;
+		FREE_AND_NULL(terms->term_bad);
+		goto finish;
+	}
 	terms->term_good = strbuf_detach(&str, NULL);
 
 finish:
-- 
gitgitgadget

