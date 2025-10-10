Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655C214A6A
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058855; cv=none; b=B4wiBRcktlyvvPIKfcx6yNw9kJ0Kirik0EfHD1JScI38TM5xmcQpnk98b745sNmqoeT1IYs7cVir0OPnk3T8kFjFTSzzAt+nHlD50lWcYc1Fio+txjqy5/RtUtuRk33u6QXngeVvN+ZsiSln/6dearFv8DFSixX81Sqo0t6lzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058855; c=relaxed/simple;
	bh=fYbtVnYKkxilumWO3NPC6bAm2jEEYQQmnsZFZjYwLao=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A8P2IiN42ypfIziyirm+WjQ1C7BhF7zt1f9FQl2UVKxNjyG+l3O4qLmkgXVkGKbJPtRRmnuGf/+MyYPtKZUOdYCSTtgt7a4llPIDvdVF4VyW2wOT755kulVhit8Nt3bVt+BUrvJPSV3gIhMLcJGmxudR6bJRQqlszDZgxM7T4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5w8y2gK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5w8y2gK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso20456546d6.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058851; x=1760663651; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+0CGtNCLUbIeddb0FYDCRDYQXEy5Mudu/UVbaecv3k=;
        b=g5w8y2gKNgDWhUjbU9+K8skLJwpOMPgbJeqP5KIVlNe7u8Op02lCF6EfulfO5eSG6b
         9oDbK84fhCjaQfVvgi9uGwzDT/80yCYnOEVyN1IU/U4mDGcGBrSsksdAg06pA7unNGG3
         eGzVx54nEO9cA9CDK+x9kFcUv2cpO2JdjJg0cmmvvreThFwYzrxc4RKcApvV0w/WbCyW
         x5ieYvsWp69AprMvj6Qj8wWagT/57rU7XtuqvREUz1EPfDsPYnKLxz2ae/+XUfhNhZX5
         0/sxcB98xV84suiH4ZIXni7mUL3ten3+KrgsDV0ukTaC5PgMPg6SO9pcltlIqI9QkZth
         5qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058851; x=1760663651;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+0CGtNCLUbIeddb0FYDCRDYQXEy5Mudu/UVbaecv3k=;
        b=Mrca3ZUscXdcA+CnSt8KUUtWwCholZ/nTLQfhb5A72ZRQlo1jMyZzhQl+jbuxrU+MK
         bTh+0ezByuA71/RylYV/3Cd/2IILeuCm9NgBTyoi4cesZlCN5Gh0N+PwSaOtgZF/8EZZ
         ACFPlRZ/ZAEVXyWQ1+1jwXt8qsyvOxvxo9a0BYQKH2S+fiZ1+EARFoUN7SOVZMxcAOLq
         d/PveAeotJ5J9M50v2rEKAJXx0UxcgwGhgU99WDlkLR3jRty8PGU0IeNFwQb1DN9Ki3Y
         itDlmP9gQib1IvHycTSOrMAck3Aly2hKb/0xT976WofXrpqswcP7KTCpsO8VF4T2J6pO
         3bDg==
X-Gm-Message-State: AOJu0YwAHQ9eu9uCxHiQVrmjnOMhzNHI35lRqoAAPEScjHdSTmksvKUv
	08pgsJ1t/igpTtXmw5EkstgNVy/lyFD+rCNDf5cWCl13JsIxnorMjWZpjCH/uA==
X-Gm-Gg: ASbGncs879LsiEfAR9RjrW+O8eIKZlhpr85X1dDM0Gjrclmuq6bsVGDirbzWQj+fm+9
	lVh7xEkdjWuRtUxKFSffjelgGw2vE4SGT7lbTVmBD3G7kU+ZCgH/ybXXOtM/4khQIj0pv5YWw+S
	282u85NDpruDdE1F8W1DMdjoWLWrlasrBYd5dGAgGmHT7MxPYFzQahClbbbiDXd8xrp+1FisEvv
	vdtizz15496xQDTAOpsCQlknMnL1w8oqLsUU6geEooJRWqLtgmrYvKwXWYn95GBreLRvNizVIN5
	3bORF4cLGGiKiRHU6f+fRXhYdB4mGz3JqU8qvWMaOau43Y18RG+YSk+Y4LrAPmpzRvQ9pQt0/Xc
	084X9zrRyUCkIW6QBlol/w77ts3WOnVZJQlvbCQQ6PTp6/XiZL7R3Pt9KQg==
X-Google-Smtp-Source: AGHT+IEYZ/9WpbFIh6hWCC/n48MkyoHF7qcG8pn3mgs45GR71t8CIC4dsboLeH7VpSu2MqSM10CUNg==
X-Received: by 2002:a05:6214:b6d:b0:7f7:708e:4797 with SMTP id 6a1803df08f44-87b2100104bmr129834716d6.12.1760058851452;
        Thu, 09 Oct 2025 18:14:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc345df08sm6441476d6.10.2025.10.09.18.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 18:14:10 -0700 (PDT)
Message-Id: <c8df6a042b9e971f392b2fd2d09a9c3c655dbceb.1760058849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
From: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Oct 2025 01:14:06 +0000
Subject: [PATCH/RFC 1/4] cleanup_path: force forward slashes on Windows
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
Cc: Delilah Ashley Wu <delilahwu@microsoft.com>,
    Derrick Stolee <stolee@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>,
    Delilah Ashley Wu <delilahwu@microsoft.com>

From: Delilah Ashley Wu <delilahwu@microsoft.com>

Git prefers forward slashes as directory separators across all
platforms. On Windows, the backslash is the native directory separator,
but all Windows versions supported by Git also accept the forward slash
in all but rare circumstances. Our tests expect forward slashes. Git
generates relative paths with forward slashes. Forward slashes are more
convenient to use in shell scripts.

For these reasons, we enforced forward slashes in `interpolate_path()`
in 5ca6b7bb47b (config --show-origin: report paths with forward slashes,
2016-03-23). However, other code paths may generate paths containing
backslashes. For example, `config --show-origin` prints the XDG config
path with mixed slashes on Windows:

$ git config --list --show-origin
file:C:/Program Files/Git/etc/gitconfig         system.foo=bar
file:"C:\\Users\\delilah/.config/git/config"    xdg.foo=bar
file:C:/Users/delilah/.gitconfig                home.foo=bar
file:.git/config                                local.foo=bar

Let's enforce forward slashes in all code paths that directly or
indirectly call `cleanup_path()` by modifying it to use
`convert_slashes()` on Windows. Since `convert_slashes()` modifies the
path in-place, change the argument and return type of `cleanup_path()`
from `const char *` to `char *`. All existing callers of
`cleanup_path()` pass `char *` anyways, so this change is compatible.

The next patch, config: test home and xdg files in `list --global`, will
assert that the XDG config path uses forward slashes.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 path.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/path.c b/path.c
index 7f56eaf993..db7b94fcda 100644
--- a/path.c
+++ b/path.c
@@ -40,13 +40,17 @@ static struct strbuf *get_pathname(void)
 	return sb;
 }
 
-static const char *cleanup_path(const char *path)
+static char *cleanup_path(char *path)
 {
 	/* Clean it up */
-	if (skip_prefix(path, "./", &path)) {
+	if (skip_prefix(path, "./", (const char **)&path))
 		while (*path == '/')
 			path++;
-	}
+
+#ifdef GIT_WINDOWS_NATIVE
+	convert_slashes(path);
+#endif
+
 	return path;
 }
 
-- 
gitgitgadget

