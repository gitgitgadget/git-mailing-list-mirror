Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2134F48D
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 01:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317520; cv=none; b=MFDK1gr4K5z1CJlyiIeknH1UwEC9YxwQsmJQSz29uDgej8e+ABXkRt9ZIpwjWHNRTeOOj9jsAt3PxB2PqmYDRX+0DXpfYNTvolFsGcPL6Fp4ueoO4bkVacGYUVR1Do5kNJlJ66ULWTjvWyX7eSCKO5Z6cKVKJ3byD/VoHvnSapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317520; c=relaxed/simple;
	bh=bMfTVYhI7LrCBKaUwFLRhevUgdO7THNsDNcRktMiZuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpcs2SW2oI0L9bJVYsSgkhlfrz+/wMQ/hMyph/WQ4Ke3jVklm5R37DNGkwt9GqPAFNmKF59jtfpDiYI4sHsQZdRXIMfxy3gWnPfCCDcxpSuv2Rkwm4jW5BO47SewJ29A1Z1OWTmXPPI6kD3AA9HGOFJXdPmBlugaMGl6hzRysyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ+JZxN2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ+JZxN2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829781b2b01so506268b3a.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 18:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774317519; x=1774922319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaOPg6KX/LuCj5NaGLfjLmoMNpfPhGOjQC+5sEE6dRk=;
        b=nQ+JZxN2jzoGUEqIR/fFOKBxvFlacBa6F2JZIaLwz6jmB0iBQ0ajdK3u21H9nrCsv7
         57I/HA/g5oKF+Z3e15b53fS8Dm9B4jK7OA072kPQK/UJJaLgBGClwptzCl7+M5SqFiZP
         VhcUwe7xIq5DGIklr4Fgcq6HQuglYWjQwrnirykCypyPnJwxiisOxYzqFTY0Cr/tgtyk
         Qb056/sZ548Bcp1ndjM5w5byYNd3ByzckXVay8/VrtxTbYPvBAC4MaVJxx+jXOKXvMvM
         gO+RVU33G17xr6Itjqp40JP0efoK+GZRrKnoQyY31/+iv8vvSUVt04u1wbsajE3MxWZK
         V3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774317519; x=1774922319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BaOPg6KX/LuCj5NaGLfjLmoMNpfPhGOjQC+5sEE6dRk=;
        b=li4rXJp+Y5JsuC82wkGI8vmMMavIKHTFVvKAx3dxSOD9XMQPgYffO7qdlDHLrnLOSM
         ROgkaqLoFzM9zsjVDvkPa1hk/z7IzJtcO74og4lkUDQbEaI4bibhI2yeO7x9fZ91PhbK
         bIZJIowD2IBFIuxBjTNuE1pYC5fPoaNiv6e4tf6O8rXEhY/Rn/rXyTgERfZDatBeZF7f
         2tLr9pnvwcqb7+Cmf4I+UAHCbHtTlZuWx1xeb3A1KTR5og3jodRiM3tVlRVAm96mV+s6
         iA6xwoAo8sY9mXuy5vw61ybPSgwC/dD2Mbg6MjtgIxu/4VYPMEyG9oafr+bWLMBF3Kah
         Otyg==
X-Gm-Message-State: AOJu0YxyKQCfjnDJnvzjrJszQFTRKIAcjm92ngg8nxR4pA0xh6cp6MCi
	8XsZowRRo7HdHqm0wrAU5is4ZqM5CkPy3zyxJ/WC3FosZCMs9a6cRSB9
X-Gm-Gg: ATEYQzzcFwcRPBzSFTUncjnil5Y6anwZbhtsQ9dcBaKpWBsJyU6EAyqAcKOPHEXvu4R
	M1weDDexMB6LZvnLt+sLq5UcqnKqMEWHI/5z9LxWGpG3vud4umizPzNG9uxJ+KDxQIr7lq9tmXj
	aMBfG7iEn7PYviJgFr7unn6VssKx7usnD+x5KY0ZEvXP5yDWmoRyr9aBx7u7d7FXzbpIWfL6Dsa
	ZLBXHcV1BA3pcErxNJ+6cFaX+lE9CUW4eGqg1heXepjIDw+17zy9XPk+1V7w6iG5AoioQB8pC4U
	kIT9VTMe5ZNSOyp248E7NpMBxZ/aDX9JfsvYLee2wG4SmSvDFHEZDF3wBdiHKslTgLv/vt7PyGu
	URU9Mqa+0XC13QQPWznPjpLFe4VJCFnfdec6DDHiXm+VVcWzmKIIzIC9yuxwzKLHhHL/m0jI+T9
	8vuw4YjLljNTE2opfg5MhE8Srr/hMwYZf1bTzgFkw8WS5eGuohuiJpt5+XErGynliAmUKEWnOk3
	nGHo/L3KDLJlhsEAQI6bin0ILerPn2pXZapdpsoFdYm
X-Received: by 2002:aa7:8308:0:b0:82c:23f3:e6be with SMTP id d2e1a72fcca58-82c23f3f317mr6506955b3a.22.1774317518851;
        Mon, 23 Mar 2026 18:58:38 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm12467623b3a.32.2026.03.23.18.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:58:38 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	joliss42@gmail.com,
	joliss@gmail.com,
	peff@peff.net
Subject: [PATCH v4 1/2] remote-curl: fall back to default hash outside repo
Date: Tue, 24 Mar 2026 07:27:33 +0530
Message-ID: <20260324015734.18470-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote helper like git-remote-http is invoked outside of a
repository (for example, by running git ls-remote in a non-git
directory), setup_git_directory_gently() leaves the_hash_algo
uninitialized as NULL.

If the user has a globally configured fetch refspec, remote-curl
attempts to parse it during initialization. Inside parse_refspec(),
it checks whether the LHS of the refspec is an exact OID by evaluating
llen == the_hash_algo->hexsz. Because the_hash_algo is NULL, this
results in a segmentation fault.

In 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside of a repo,
2024-08-02), we added a workaround to ls-remote to fall back to the
default hash algorithm to prevent exactly this type of crash when
parsing refspec capabilities. However, because remote-curl runs as a
separate process, it does not inherit that fallback and crashes anyway.

Instead of pushing a NULL-guard workaround down into parse_refspec(),
fix this by mirroring the ls-remote workaround directly in
remote-curl.c. If we are operating outside a repository, initialize
the_hash_algo to GIT_HASH_DEFAULT. This keeps the HTTP transport
consistent with non-HTTP transports that execute in-process, preventing
crashes without altering the generic refspec parsing logic.

Reported-by: Jo Liss <joliss@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
Thanks Peff and Junio this has been informative.
I understood a lot of things here.

 remote-curl.c               | 5 +++++
 t/t5551-http-fetch-smart.sh | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..60774af929 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1552,6 +1552,11 @@ int cmd_main(int argc, const char **argv)
 		goto cleanup;
 	}
 
+	/* yuck, see 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside
+	 * of a repo, 2024-08-02) */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
+
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 73cf531580..a26b6c2844 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -782,4 +782,11 @@ test_expect_success 'tag following always works over v0 http' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
+	nongit git \
+		-c remote.origin.url="$HTTPD_URL/smart/repo.git" \
+		-c remote.origin.fetch=anything \
+		ls-remote origin
+'
+
 test_done
-- 
2.53.0
