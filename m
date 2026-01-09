Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C15E366DCB
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989133; cv=none; b=B8MWnxNVGddtBNccyxRLpQR4tipr329e86KzCXrGamhKGaDAAQB4/EL2AA78gj+x9ze5u8R9eMMibfcxqQxYSItX8YzWwtxsl4h6VwAwrs17sj8QG1jokRCjSWCs8ZHlsha/2JyTPRD63I+HeA3uKVfziI4OkNbN6G0JFgYV/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989133; c=relaxed/simple;
	bh=4xrE4Jvt9l4HkbOsJQfOeObohvuJl6ZyZ+5Gi7+cKLA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fv7BD/oocf1VqBPdklDaUHA26awwkfIxUKWwULagacQoLSDk35X10xViFj2nYc3eNJi11ulxbDIMIB88K6t4pjZOGjqXfqRvdoBymYSW48NGm2FW7JISP7HAhnDq3O5tSxu+FThUHr3Sj5elJGhiCHncQvQSeFbbQr7uSoDn3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtpWFcdW; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtpWFcdW"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121a0bcd376so2503143c88.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989130; x=1768593930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EFDAI8iBPpxqKThFi4umfyFjYvpgq2DQwp4RIIyD6Y=;
        b=NtpWFcdWqgSjsi6McCqPkrKDOCnMvXlvEIne/1cIV93EH87uw/dye7KcHqHeMqyFGE
         fo8TH9KqdW9IXESQWft9mmvwkXfO4hccR3A/LmvAQMexjS62Lu7iGoCaVfL1NtJsnzyi
         b4JQiXqgU9x0eOxScp5houPJ7sxh0DYON5V8zTZZi7uDN7SVrKqzbRbH2bY2to5OfpI4
         zCK3fCQqUNEW23d5sa0prfzQdIBAGzSSNL7Qv/HtCMc/pZWa7OIrPtqB5wiFHKfarZu/
         ZubZ4jgAa0c/QKUa/iWRZM5MtDd0peagkpmR2PNlobgUnrmY2fqEdhUUzHXC0eSSQIa6
         21og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989130; x=1768593930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EFDAI8iBPpxqKThFi4umfyFjYvpgq2DQwp4RIIyD6Y=;
        b=SSvu2ppkseCVor0ioTTFqubkcRi0veVNcR/vY8IqJsad48nW1tAiwTdIHPkNPsVmk+
         8rN0/60RkDk+7P+/nsFlnspP6scSb7sBzquO2dyECkPYHpmR/sq7jgSnwEhSLJ+2Pj1p
         pGwMmAydU8aPFA52UyO4vc/D8nFTRiJtt+2edfTEFb1+lPv3uvE3k0wHB03hEAASk/lJ
         6+BckhKrct69gBQYdfbN5V3UgpwtEZkF+WbXpLrJO4Xp0KjUXoHjHDCfsKJEAcKelRka
         KadVsMo6I5Ncktl8ckgT8rXCABs5b1xNhKX+Hhk70Z1x4U/hMEPc4EMR7yMHVSV/WS3r
         SVcg==
X-Gm-Message-State: AOJu0YwdEgJaWOyWU8ML1kQLxD6y2Oaff6j49o/mz9zMl542FMjgZNS8
	BmBmPnDRy89GpGGkQm21/2wLmdfgPXGH2klM4hiYfGCgjqbyKckDXWs/yFZQag==
X-Gm-Gg: AY/fxX7x8kSjtIBv+A8HEuBONGQHoJ8KFgSQSFSDHxiht32uzU1UxQtWUXfOmSFzWjj
	QfSVVlHnFjUkvCaFkOAhR4FYp6lsNsB2oDGxybO1XgUMZMvyYCAoKWG5vQ3v2Rhn5VqfcmGxy0B
	H4m/UgVLper64SZ+hppFn/afdS9K/K3j+E+FxuYv+WxjxY5sq55mNa85WLGF2HRRM4eYToD/YJm
	y/x/lCCjNps0pkGlmkVF1uJYFqb3bAztCnYu1MYAhsShfpWM0yE7PvMYEEfi8qADSVXA4t5AOqe
	8+Qhh6GBxfmKT3KzkK8iXJE8V2sOHhvczgiDRCFlDzm1BWTiJFcn2TBJGJ/LZi5gKVIV0DRO2M5
	9K68sG/2ckOTRFlimpknLFVKEUfjvBC05TsXiRploClwGHq1OfdxHlTjSsQMMEhZ4NSqjOMOwau
	F760T0pJTjxSd/X2Y=
X-Google-Smtp-Source: AGHT+IGhdncSam1ISMa3kVba1Quu0tBNoy6+Spg7NmTGLINZKiIkxz1c4I5qboaIrtdgWYTK4ooWgg==
X-Received: by 2002:a05:7022:a8e:b0:11b:9386:7ed0 with SMTP id a92af1059eb24-121f8b722f9mr9639216c88.45.1767989129795;
        Fri, 09 Jan 2026 12:05:29 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f2434abesm17651980c88.4.2026.01.09.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:28 -0800 (PST)
Message-Id: <9823cbb6df84eedfa40d7120d3949f70d2f960ba.1767989109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:09 +0000
Subject: [PATCH v2 5/5] trim_last_path_component(): avoid hard-coding the
 directory separator
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
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

Currently, this function hard-codes the directory separator as the
forward slash.

However, on Windows the backslash character is valid, too. And we want
to call this function in the upcoming support for symlinks on Windows
with the symlink targets (which naturally use the canonical directory
separator on Windows, which is _not_ the forward slash).

Prepare that function to be useful also in that context.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1d5ed01682..67082a9caa 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -19,14 +19,14 @@ static void trim_last_path_component(struct strbuf *path)
 	int i = path->len;
 
 	/* back up past trailing slashes, if any */
-	while (i && path->buf[i - 1] == '/')
+	while (i && is_dir_sep(path->buf[i - 1]))
 		i--;
 
 	/*
 	 * then go backwards until a slash, or the beginning of the
 	 * string
 	 */
-	while (i && path->buf[i - 1] != '/')
+	while (i && !is_dir_sep(path->buf[i - 1]))
 		i--;
 
 	strbuf_setlen(path, i);
-- 
gitgitgadget
