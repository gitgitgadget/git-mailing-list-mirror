Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260F2D374A
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562743; cv=none; b=PyG+8FYXuKNfaF5QrcmiAl0RDz0PW9mQG/a31AlmeoJISQ/WfHpfRkU2uEAwXOjVraY5hzJjp7p+zpFIanIPTA8pq3lQ/PhkjvYabFSSg6b9ZBcVgOtUAgB/LUfDXBec6yCr7LmC+AMyC4a1EgYCKUogQQNVk0uiil2DIuE1FcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562743; c=relaxed/simple;
	bh=rhL7z2JuUNObAPJolsKbTI6C1GU/Lgrn+nn1ssbaLoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdtrG2f4wBscaFuYpb5mkz2PO7VxFyJye3nUCIDgiJkBTw4DcQCjNx53z63pIajl6myV7xhJ6kg0gEuTvN4LwezumwsZnI30wqQfzfOhA6Qtwsrb5KymETmeGNBqlwkGglSvr2slZZlbbLQ1o+kjrahZXZjRSMUew49kgiYNi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCoDRnyW; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCoDRnyW"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-36c9859b036so6496fac.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562740; x=1761167540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=FCoDRnyWRzDVNNF5w8/knhC8H1Qdyk/pR1EjNeCkh3N/+kDEJzJL5Jygn+8s4RVPfl
         JLNWIVxMXIqnakWW4ZBpMsyqBSeGNZ8Y+ewFei91uXdBlqxQQI0OgHH3zc53/X5BZw07
         GxHnEEBHBJUkHJeOmXxt0IGjW2Bkj9xXXf9pUyfP6WGIGu+L6cg9XBl4sKomsZZc4i5Z
         wzYsRcPROMShzbr4UjKDc2vw/fcJX3mbw9ErNwmNeteYbU/r4JUtzs0vuiArXZtZNKWU
         CDaGGu8z0oukBA9hBs2tkqGKUVBp/ah7aLd6YvlpkUM+9l+ou7w7deTw5sN/fIUUJVek
         Au8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562740; x=1761167540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xISjwdtj2GzvnStBEQ4LDObogRyfw+Z5+EIiFS62pTU=;
        b=UtYKm7et1O5EJ3mr8rESz9EH+D4HZIH1yvKF38VNa6J0j7PdZf1oOhJoTNr2F4amBc
         UoEJ6Fk2yFOaBvnnZDFnOxGpXD+mFb9YNdnSfRTrp7RhxUzfDcfB8eqWA4KXMuLqpJa/
         Rf6GNBrlyGRiQoSWLPOxkw9yF071SzIN4Pk7lgYlI0mL706RNfFRUhOj9QLh5n+A+2m+
         BcyW2/fFXzqwxZy+kAtz8S5KZGXI0SFJFcFbxMZsLbg4HSLawDg7MpFKg0nmZxZlffFp
         W8Y2TUgF+Wb/91mxQ9aAceybEJZs0/xfJde8dx7LxcDLajkdpAXN2PdsDD2R8Ej3QnjN
         uSVw==
X-Gm-Message-State: AOJu0YzfWc44Ut2atwM3zpyRltKI8a0PaSlk5qPZ/S9aTBkPxMzItVk/
	F7zRzFvbxrxs9pufeWm84wn4ikbcy7VaWAQM9MBHdft8FeA7EZ5B30kY002wbA==
X-Gm-Gg: ASbGncuc5vrsdLy0TaKkZMThbB3U3kpxahJ1wtbBSOp1Guo55ohua1lO9+MMa33Nc20
	gofF45+X1btwAX5IVTGTw/froWuNzAvLsAZACyCzZjEVGNYf93vvG+FWc0tTG31Uu/b3DqHk5CR
	W5ivas1GSm6pIEZxh477zGpNgavd8yqpobjqOuAEUK3Vu/dTgHIdGGafl+BDSXxhHoZFW4AkjP3
	k6KTxFkwzM8IX3CAfXleGriraiJp6YogQNZvvz8xOP1SmNml6ytd2ybNGdj2mtksC5fUnvlyx5d
	P70s/As7H0MH5jogPpYOEZDEQOoS0y6TTQF0rX2rELbAZuL3rhZqSNgNG6CZsvLFxDOSZrcBUc4
	JFfsdDuwox56eHMItnonDkIhfxeOfEUmzpQ/MYFCdvxpRcawHN/FFpiuGK7106q/2AF5qPfBCok
	1wfRGu0fTQtBcTpBOvsQ8=
X-Google-Smtp-Source: AGHT+IEXZzsUx+9+PGpWlPIYVe4PfjdoT1pYPfNW4y6E6fvb2324/yvkRnXJINplbMlGfugUu76InQ==
X-Received: by 2002:a05:6870:c0cb:b0:332:8989:4ee4 with SMTP id 586e51a60fabf-3c968bcd026mr873749fac.20.1760562740166;
        Wed, 15 Oct 2025 14:12:20 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 1/6] builtin/repo: rename repo_info() to cmd_repo_info()
Date: Wed, 15 Oct 2025 16:12:08 -0500
Message-ID: <20251015211213.361797-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subcommand functions are often prefixed with `cmd_` to denote that they
are an entrypoint. Rename repo_info() to cmd_repo_info() accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..eeeab8fbd2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -136,8 +136,8 @@ static int parse_format_cb(const struct option *opt,
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix,
-		     struct repository *repo)
+static int cmd_repo_info(int argc, const char **argv, const char *prefix,
+			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
 	struct option options[] = {
@@ -161,7 +161,7 @@ int cmd_repo(int argc, const char **argv, const char *prefix,
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
-		OPT_SUBCOMMAND("info", &fn, repo_info),
+		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
 		OPT_END()
 	};
 
-- 
2.51.0.193.g4975ec3473b

