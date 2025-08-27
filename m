Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339A2253EB
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279047; cv=none; b=EW8Hwi/mJumJxrIii9zttnB/BO0LGpnY5bDoE4zHT6Sb2aOUvOxq+MliNztI6FrppHOSKITZyAKn0wRQ7D3qoDpIQy2bnn5UcH7IMMBkuBBTaO+l+ddqpS2MjGkRhw7aVwYhENRdD6a5p2MEVS1r3huHJNvjYxuddfDs5icbZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279047; c=relaxed/simple;
	bh=hJTGvZ2VovNU2PYN7HA7zFXmSEGgVJ6YOKuD69znzwM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=c+w3S0jJzjVlln1Z/AJkIH9M5o1CNmGxwknJ/Yootj22yODhqYWQGukPG4tSVr/tDteDc4bzGoBqrrxTlEgMIUPZCLVKN5hD4R/IadShY3O0vc3Z/ZaGBKWwZG7nqm9MKBUvzQNPK+ii8U2gE1CiruohRL4xS+Np2/sNM7swL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlZ+rGyX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlZ+rGyX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4a25ccceso38353555e9.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756279043; x=1756883843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GJcEg2O9nC1jsF4pxwvSabn3qPD8ZjzwktICJV7Pi3g=;
        b=TlZ+rGyXP6/tRpYdqAMzW9RDOBR/MksPRNZ8pFvBtAf9YgdoPmQudG3t+GV4vxzwDp
         7c1QolPlpvOAFeYCa5GMNe+LtTzrYgzT1G9ynziB98L1cFjmSrgN/Brs3i/ZTKWCPiPD
         6xWGYYayMn0JWfKrHUejPmpE08It4fkqf9Yir8H9OXezjVrYHt8rLQECey4cMAolcpci
         TLOw/6AKz7leFGqPj5KlnM7xL1gDtl52RnoqxDq/RjcVilcy0ofZzi0jr3uF6G+8JDuJ
         RZzREuAt4319QnK2rNbZ4dBWn/9lwPIINkm9tvFlRyA29oXm19Ckf4xQTzFO9b7BL9G4
         OK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756279043; x=1756883843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJcEg2O9nC1jsF4pxwvSabn3qPD8ZjzwktICJV7Pi3g=;
        b=MH4xqb06emLz6I6ws6hBEqW9ccIhBYFn0tsVrGjXsKPurm98uNucTWZYch4pbyAHoh
         w/u5Ej/bSPc9uL4csdWUePEW2qTxRIHHDy/6P04Nkqxq036ZDZH/2CjEx/fp3i6vKfpQ
         O2BWDFfeX5F+B+5r2EEUGv8hryeudPcqU8OvUVhqkoFrIJJ/5Q48+q/1XRmbp2WZUweR
         lt5KQD3/sI0i8Ho4n5d/3pZHmKum0wmK046B9CUZiwQLF77KKVm2sw1lqxDuKx7KarW3
         67KTzoidb551iK5jAPf11ejSCP8TYaap4nnCc6rIEGkcN16FlTUw68t7XudDzbMXcz8r
         Cttg==
X-Gm-Message-State: AOJu0Yw2ETCZuWBiJFAEVwPQnQga0wVxdMqRtLBaOy27mQYui+w3Ft6K
	A+C3pKcG4OdTJGOPxHRhYXQNfhsDau+oxnUt4tFMoGReCYf+N+jfCEr7kSkXZg==
X-Gm-Gg: ASbGnct5XNfZGCW2MMqrnjCw5rvZp8RKceVdt2d75p9fAAY/SwvvBKUeMMfPLv5HhSh
	+1srLSJwIs51hdg5LvvGCU5KCbqcafzn8SjxEfQRRGn7pQ2YKOf01+nEWltq0LkDdQyB9NOQSnu
	3TF9U/npJVKugzo9o7CDA3CSZu3T0mII9DLpCZfGoKHhWwiiVJea0NBo8lAjal7SllSUyVnhoV+
	/vphd1rHlUeueg+4GnDycC8cNpym8y15eiOGJkUS8I+XtEdVWOzsaEJY35JCjjnH0HPXTbNpJtN
	VvXdLe9Geh7OwQLR9nrUSeR6SnbXUGhrB+loPrQTshbqgg/Y40uc3J5D3AniHLtiLNkstGwp7B9
	nwbJQFSSBoF/6Zj4TJA0Hc4tlRtBzf77pje5mZXaSRvmy+iFS
X-Google-Smtp-Source: AGHT+IEprWGX9amwadbnJplJQT9ltX01nR3mnDfk5xNNOhFI0KRevfDoQScnTVEiRf/8ZhYRNcczwA==
X-Received: by 2002:a05:600c:3544:b0:459:d709:e59f with SMTP id 5b1f17b1804b1-45b5173f9d3mr143528355e9.0.1756279043183;
        Wed, 27 Aug 2025 00:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c72f8sm18150565e9.3.2025.08.27.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 00:17:22 -0700 (PDT)
Message-Id: <pull.2042.git.git.1756279041881.gitgitgadget@gmail.com>
From: "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 Aug 2025 07:17:21 +0000
Subject: [PATCH] cherry-pick: document rev-list options
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
Cc: Andrew Jeffrey <andrew@aj.id.au>,
    Emily Shaffer <emilyshaffer@google.com>,
    Emily Shaffer <emilyshaffer@google.com>

From: Emily Shaffer <emilyshaffer@google.com>

In f873a273d1 (revert: accept arbitrary rev-list options, 2010-06-14),
we added a handful of new options to `git cherry-pick`, but did not
document them except by example. We have a nice shorthand for adding the
rev-list documentation, so let's add it now.

Reported-by: Andrew Jeffrey <andrew@aj.id.au>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
    cherry-pick: document rev-list options
    
    Reported on socials (https://social.tchncs.de/@arj/115099134305875190).
    rev-list-options.adoc is unfortunately pretty verbose, but I think it's
    still better than having undocumented secret options. Or, worse, options
    that are in examples but not anywhere else ;)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2042%2Fnasamuffin%2Fcherry-pick-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2042/nasamuffin/cherry-pick-docs-v1
Pull-Request: https://github.com/git/git/pull/2042

 Documentation/git-cherry-pick.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index 42b41923d5f..03848aa9f21 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -174,6 +174,8 @@ fail unless one of `--empty=keep` or `--allow-empty` are specified.
 
 include::rerere-options.adoc[]
 
+include::rev-list-options.adoc[]
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.adoc[]

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
