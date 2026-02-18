Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E33451AB
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443163; cv=none; b=bzT0uZlQuP/pKDcaNQFSA7c1Se3tNiYS9mhJKOMQNLeizFjb6Azdzmze62WRPVEI4Pgs2u7ZEt1KNE9/VXyHS1bxfkOdlzoIteepsaqIcJkLAL0HzaoZeRWLaNVvUUTGrzOUSMyBttTHa+WxoTD/+DUTxWqqGlU4kW1UhggEYCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443163; c=relaxed/simple;
	bh=hEEFl/ownUY3SbdXtY7t3y66ggfBgsDlMtYPknHRrf0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aLu0FqnVVKUeVK6qnPc27P7Kool3xXMPM6O4iDWTkKedkUtNLl1AjT9U+FANRxqfJWkxN3WMeWF8ExWEzVR4I4qiuXl+8780FQi0ZKkWLP0Q4ifYnjjda9ZL6fNtzr5Xu+gr6GCfOf5qDrNn/a/1B2lvhWOOazMzTmesBCtPW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq5UdwJq; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq5UdwJq"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ba94dbf739so171049eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443161; x=1772047961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DcJw5Q7AUIUvARGjPM/6T75yOXGNVKQO2S4pFf1j/os=;
        b=Xq5UdwJqAFJyCHl7dfpiR5Y48lP7gM4XtXHMYOYzmtKvYCAWdsXel2IGsyKAxmHq79
         yLtvY3E5WOE+8V7CBLdw+ybqV092ViVJ3N0pM80psJYIwwq9bSIitjDxvy1Ocdzra7T+
         BzawxvN68/Apusb+xulWyjCAV///A54wkRjL3IglXoRtYQh9rWZQviCIw76H1Kg/IOtg
         F6UpXbfTJmTNyOhVFmDFaS1CYwUMoykd5O/IzUOM+yCZ7D9nyrJKENSbJaquYodA6lHu
         aAqnbWmAZeYBU+oCa4BLLtU7WEixNhXvEQFr86S76jTT0m5TucJSrl995VvvwEbQev3k
         93pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443161; x=1772047961;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcJw5Q7AUIUvARGjPM/6T75yOXGNVKQO2S4pFf1j/os=;
        b=PTpjtqHWVcx8JERQnA43+gAn3JXNrZBzfZriGax5P6mnCXJPKMetMgiVeYqmtSj5Tl
         mIAgb9eIHbYxWZIsWifz1m0ggVHYGbDr+LoMmp+mE7U3r06Uf47UQ0HL80x/VxqXgfCe
         QeJKf7F1PkOhdK6XKG9inPmj+EVIBtJcEASOhYIDQ1LXuYFKI5Zz0daDGBTKuyd05Szr
         2wTDmeY+hhCnbQOFSO6Q91l35fDzUCsDkHxTh1FWZgDaXkh4sH15GNkHfv4wk/U+Z5p8
         xDr1fFbIcQlzQ61g/qHflw1Oyrhv/pgcKaxb3MERnvVmGGvnqV2fEIAMPAhiLbWq2uxc
         w7iQ==
X-Gm-Message-State: AOJu0YwMJPFuyiPxGpeC5sBiAiHTeLy957bGYkSrSGSkg7L+xzl68Ff1
	jkXbQXwcqR3IdNEOj63XAHLdNbutPqRsiwAgmsgkK+uIdgAVEguq/5Vh6KhHP1Hi
X-Gm-Gg: AZuq6aLr5kdGclY8iLI/FY7dV/VQ8dRSlxQF+EsH6l8BfsHKZCHPrOBAhz+YPJ2WRte
	zsn6QgLqIwebRui23ubM1uH48d3uqNGoCpZOy/Glm/40nEkSn09o8Q6XSxKxA8SN4ARDr8d3fcy
	nS8Ev75NHMKsSBdb6uPS4gww3ClbTZmr2xjiWxfqvUlZAAxIfq7jnkX7rlvTYF0h31JCf6fy+s0
	y0qUS9QurP8YXnLzFw95kRYxroi9r7P8wAZiHhqfeOMOYtZQk3RMe7K9auYWHKLCpfgfXG1jQNe
	dLgCUiW4r5743I7P4J+1Us4BzDhOUD+Jygqp1NworN0r6JnTWjnk7a7OKEOO/Ftz30wkCAD+4xJ
	T+OFYnc/Uxr1SnjX20cnpdlyoRbPAiTlFeloa6DGLjxRUipAISP3QnU+hseNP6w/y6PYHO3Gsga
	PnT8yxIxKzO1jhMRNgXVl9Jc8=
X-Received: by 2002:a05:7301:3d10:b0:2ba:a075:541d with SMTP id 5a478bee46e88-2bd50174e3dmr1538960eec.32.1771443160814;
        Wed, 18 Feb 2026 11:32:40 -0800 (PST)
Received: from [127.0.0.1] ([20.171.55.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577c1csm21803379eec.13.2026.02.18.11.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:32:40 -0800 (PST)
Message-Id: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
From: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 19:32:39 +0000
Subject: [PATCH] doc: fetch: document `--jobs=0` behavior
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    "Daniel D. Beck" <daniel@ddbeck.com>,
    "Daniel D. Beck" <daniel@ddbeck.com>

From: "Daniel D. Beck" <daniel@ddbeck.com>

In c39952b92 (fetch: choose a sensible default with --jobs=0 again,
2023-02-20), the `--jobs=0` behavior was (re)introduced, but it went
undocumented. Since this is the same behavior as `git -c fetch.parallel=0
fetch`, which is documented, this change creates symmetry between the two
documentation sections.

Signed-off-by: Daniel D. Beck <daniel@ddbeck.com>
---
    doc: fetch: document --jobs=0 behavior

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2047%2Fddbeck%2Fdoc-git-fetch-jobs-0-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2047/ddbeck/doc-git-fetch-jobs-0-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2047

 Documentation/fetch-options.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index fcba46ee9e..e15cbc51f2 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -234,6 +234,8 @@ endif::git-pull[]
 `--jobs=<n>`::
 	Parallelize all forms of fetching up to _<n>_ jobs at a time.
 +
+A value of 0 will use some reasonable default.
++
 If the `--multiple` option was specified, the different remotes will be fetched
 in parallel. If multiple submodules are fetched, they will be fetched in
 parallel. To control them independently, use the config settings

base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
-- 
gitgitgadget
