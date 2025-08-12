Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72F17993
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029258; cv=none; b=L9Ln1nEzNyNIaOwLwCgQhADi0MFwtZF8FZU6srkyA1fSPtv5S3caT3MWJLf1XHB/XZtyhqvH8837PnFD1jL3j9O1je1+btksNJyeKICGvnYz037qtFttNXu669haI7yGm0a9JLzfPdN9lod80AyyNW9K1LbOhhkkHl7a/jzY6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029258; c=relaxed/simple;
	bh=m4jwm4TvPYRAwyq719yKRj+QoTszwlLmaiDNjqlGV+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=barEF8QStYzDYfGXifBNM9vw1TPkCr1fcThc2W+iMdTlweYKidpUkZHTarQuX81bs73VfZl1lPvp+nt76uaPmKX8ffY0xMYoI7JWKeqtMy5krQ31vaiKvgSkw49Ift0OCSBjOqzmfaObXvLCi6RvrFQrn+fFx5YmpqCJPNhAztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbxY+Xpd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbxY+Xpd"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78315ff04so4969155f8f.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755029255; x=1755634055; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L79Jx6ceqZKwRkTiq8EzxMX0meaZjrKmvQPUw2s66fE=;
        b=kbxY+Xpd66DxHYXTJeamC2C/qVfMkvKuYkvM6HYYzCtjKEKwy9gGz2xpQbfO0Y/Hca
         pphUOpJMMwCpi4DXfjNHnB6ia/4pT2l1HuhprzGaOMIfYo7aOR84R/Dd6lOcgpniAcwy
         QHmbax5hVlVb+P7DWyYBJW0/QZRCHZZfj8zGQ/aV3g0MjbhY3XthLFbuTRaIfzIjxYnk
         JcSo0ze4/Fii63AifItrrG6inkMy5SgEleUqWuccK3+FFJ5Shj4GILvooLCHIWIg6XYb
         dl2VQPJfHxvI7LV/k8WhAsS5NMURpLsdOmztc4/vVSKN54OlykJh682sz/fUicngqWbX
         8iMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755029255; x=1755634055;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L79Jx6ceqZKwRkTiq8EzxMX0meaZjrKmvQPUw2s66fE=;
        b=gI5ZQB74iQFK+BNWsZmDtVG5sQXzbKBjzPyKB/bDuKYnQgRM5prpBdgnaHlaBDNOL/
         BIjQZvWtXHUOdPkO/H3R86ttWnuyYq673uvrXc7k+++EVSpJSIdYcHHoK0Q1qtAMsnw0
         d2HGWIJoZ3DZoG9+UcyM+D0bYzDbou8tSG6Oi7ngsvUsEOCYmI/VQyjGqHgT/nh+1H61
         AdernApWyzZ4wc+ovU8+huuRondCoAFVuoM6hPBaZQDqyB/eh0XkSwnayV3+jEfWI/nO
         ab7q9yCZO5PeJoEkhcOpVTjalbVc3gqnEGTUxNbx/nMFOKIZCMroVddDfejZ70MBFZj3
         SacA==
X-Gm-Message-State: AOJu0YxIHhPNOyfnAb/pTA+uECy769J9wsjHoCEGzZ8+ZrJgrDp0utsf
	2QCtndqYAokIm2ssT9vg6B81kaWqvU/4SQuc6kj/UT23yH9bHtDQF8abaKBhpw==
X-Gm-Gg: ASbGncs5scdcDzSlSCNrfmyOKx6zBmu7a/TMDXV9aX9NK90oCbgHN7SKWlivCguD2gc
	TKfs3F/ZU9QlDcP55iYcMpNi0Yt7Z4qLmVkXZSaL3vsKVm/7nS+3aKkjXbIloUcWcaHosGNg/HB
	CretcIJTH/6d0kJU+czqjkUzyDAZ2yBYpvcx6tIGhjSJkTKCj03AE1F6O3q2D9jcmIISLOKFqV+
	xW+agtUC4i9YrMpR/cM79167GuvHsqw98D6dIaQabToIYkMyKs71Encp63ODu64euoeW0XDgQjj
	JSPoviKEqBpK/j97sQHiz14Xdh+gRET6VLQ1FfaPB4ieFM0hnAVv6/ofR/U1m1xJGlmV8KxJCPX
	fkSVOOVrJ/XSkssfzoJAD/Ok=
X-Google-Smtp-Source: AGHT+IEUKcmkPex8DObz3+oKHmA9/EPNOKQcSM/lUtHfgDY4q6r20m6Y4wAItLRFkgxmY86XdXj5uQ==
X-Received: by 2002:a05:6000:40cb:b0:3b7:9b58:5b53 with SMTP id ffacd0b85a97d-3b917ec345cmr204844f8f.45.1755029254927;
        Tue, 12 Aug 2025 13:07:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm45661858f8f.67.2025.08.12.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:07:34 -0700 (PDT)
Message-Id: <f7e8e4c63a1205740c2d54368d7bcdd686882680.1755029249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 20:07:29 +0000
Subject: [PATCH 5/5] doc: git-add: explain inconsistent terminology
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

I think the fact that git uses these three terms interchangeably is
extremely confusing and that it deserves to be noted.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-add.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 77cadbfee8e3..084342155f8b 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -40,6 +40,13 @@ exact filename of an ignored file (e.g. `git add ignored.txt`), `git
 add` will fail with a list of ignored files. Otherwise it will silently
 ignore the file.
 
+TERMINOLOGY NOTE
+----------------
+
+Git uses the terms "staging area", "index" and "cache" interchangeably
+for historical reasons. Many commands have flags like `--staged`,
+`--index`, or `--cached`, and they all refer to the index.
+
 OPTIONS
 -------
 `<pathspec>...`::
-- 
gitgitgadget
