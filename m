Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7E2D8382
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199743; cv=none; b=e2eTJVV1LTirhfUaqA+V5jOa0+uV6L5zaJVZVTCMq0SdU5875OMMscC0pd4EymSTs83x4I9yF0Dk2xBjWrW9Cxbf28jlC+vjsZPWyq68bTD7+mcso3kiUKURLTIx4lSmb+o5KH9tjIGzWbfDCWRElt5ufJSFRQFYgWRciILjIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199743; c=relaxed/simple;
	bh=T+HBFA4YZk+NyWjvgpJ5aOCIZZmN7oWbUEhYZjCy2hg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Q0rMyEVOUlWek9Ckbly9G8pKw4+ozFiUBHttuGsvnLbJNTQftVw4/sXcjKMFC6zMxICl/QzdrZXm9PocHop6p7ReDfjQE3501M/mhmhIMDnLr8Z0tL0ZGYl7rmGbZeqB6LOJxbc50Yorwt3kj8Fpj9NyuT3nwyC3++FV/Q+xrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRkxD9S1; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRkxD9S1"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76bcb1eso4958231cf.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2026 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789199741; x=1789804541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NCtsIQDT/0C85/DJp7k4YBzxNJ90cTXMc/RomBFHnzQ=;
        b=GRkxD9S1sCk6Po/XOKxM6iSwMD/FCQV0OdynaNYfDcPJoyWdm+49NDsVgH+VYoWdUW
         WGPDZheE+iA6A6yNj5Gxc6BlnTogsvdzMO2IJYyGmVk9gpe+oVxsAHY9V7qVdy7ww62l
         fCUyoCnKwrymi09zZwZUpzUNGUPWSqXRt3PkuSa+CrqBhmIHogTUZvtGA5d/5ZKnZMXi
         3tyjSa2ZB1valAoor6NS8JTIS1LGDuEnS8rmzeJVx+8UGGi3MncE3FdaWikvYQXjvHRv
         ig9Uuref5SSn4lEnRp1HaW+5hT/OVL9ky9yl9PvcwCTdFogS2CW+dg6eQA3oeH2cMR2r
         rh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789199741; x=1789804541;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NCtsIQDT/0C85/DJp7k4YBzxNJ90cTXMc/RomBFHnzQ=;
        b=anYHDF560K/grFOB/jvvZin9wRt/rwENBN7XgUASKNpcNaev3P0TI74mk1/cHfOf+W
         x3SFRR3T6SEfFcIL2qlHAJn6MoO1ATn7CVlEIQJDZSS5za1EN53qziVHeUDJhJkY3ARp
         229bAE94bfMA/KTkhty4NiPolz3S45MX001L+nw2yvPU4jUy495822oE99k9FaBuIXEw
         88ZGMblXZN9Duxxv+AbkA7UHbKbvuKK+xVph/XkqCCPkXGjwKFXWUe0OCXmZIEgAWVAv
         mg2T/RQ5O6y1OuP31Z5A2FlNt/ux3TF37a9ldfger5f/cQhX8p1uVToSolOBImstBYJM
         6ouw==
X-Gm-Message-State: AFuF++kwV+0BpCSZPGxk9bvs/QyFYXa9Izr7+ySbs6kBx3h719JMBY4f
	sBjU4If8TBwYUaFTJ74HgNd1k/OVErlb4qqzIAqevXGyL0LPtgsaiEr7pS+9+Q==
X-Gm-Gg: AYBFou15oiFEQSwDXdvCRwpVZkOL3wn9eiBnvG7wu7rJc61HR6/IEVlvb+FOhT2D+BY
	o0lHd587gT6mTHJPOzke1Q+3R2ri1My9CPuPJUbPQZT1mNHoBUUYyGpEObkw9tDq3m1r32J8UIi
	HSGEM+Ooh+55wRGhBWvsAqfvKLj0U+hurksP0HLqy/sg+XKZz4e+RwkNEAzYLPPdevrbQtmMrQt
	3b7FaDMURv/9d8ybziBOha7Arj+pWeu9dLOlYE1ZY4egcj0vn81msva5WktFoDx6htmVlWfE9OM
	6cdaw72IvwxULti33LhZBvF8btUfSNsWB9zWWPpdymoLqJXIetz33tDsvLR4MLG7oj07bEaRMSP
	/GUfmMqKX9vWBrdgvsu/sHuoswoqFlfyBNIUdFFHL7ptR6KjBWWMPVAgUDYGubaNczbeSUsH18I
	ig3j+bex7u8vxkFw0VsmVwmkmYhU8pvpbcznKY49K1Ze/UBycW2JEXcr7ycxGN2X5ZG/WXqbI=
X-Received: by 2002:ac8:5c95:0:b0:530:d5e7:d782 with SMTP id d75a77b69052e-530e8319ff3mr26016781cf.58.1789199741051;
        Sat, 12 Sep 2026 00:55:41 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.151.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f494620sm40310756d6.28.2026.09.12.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 00:55:39 -0700 (PDT)
Message-Id: <pull.2402.git.git.1789199739368.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Sep 2026 07:55:39 +0000
Subject: [PATCH] ci: drop no-op gettext link on macOS
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

gettext ships already linked on the macOS CI runner image, so this
command never links anything. It only emits a spurious "Already
linked" warning in every macOS job's log.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: drop no-op gettext link on macOS
    
    Gettext is already linked on the macOS CI runner image, so the forced
    relink was a no-op that only produced a spurious "Already linked"
    warning in every macOS job's log.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2402%2FHaraldNordgren%2Fci-drop-noop-gettext-link-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2402/HaraldNordgren/ci-drop-noop-gettext-link-v1
Pull-Request: https://github.com/git/git/pull/2402

 ci/install-dependencies.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2f61fbb07c..2903c39fab 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -117,7 +117,6 @@ macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
