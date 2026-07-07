Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9341D4E7
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443768; cv=none; b=neoPh5j1rPOL5YiWMCDJ7Sjx8CvbepsLTkXyjVZHmvNMOFRlEicghUEoh+zHyfPstRf+Fr7VKE8OpBkWnnUncTvrLn8Pw03W0BXOrR/2PG4H1N+eUrF3R4GB50NQ0MUn6ljpLXVYeijj1FZh6UXFH213c2+OScoU5a0ZJpGkJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443768; c=relaxed/simple;
	bh=ejsA3K630jU1vrDZ/tgbCdIHh/lWaMB4C/dr3EIf4mA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DAgYQf0Bj2uVAQigJZA06rT5jsosSUH265T51bQDDu7i62o+Bk8ob+CzAT6N027VMSeCubYb/3T2ym9LKqcogxTySqyqax0sTY1H0BAY8ifU5V17rTdlcykQt9ep+4A8A8CzTpa1ChMizvJDNXakr3DCdvMXgsLNmGgs0x3KX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljfX697Y; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljfX697Y"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e7c6ec9dbso197640185a.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443767; x=1784048567; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtHDyHd0jyoGXTQPjfTXUb5KOvKmmqc4WKzRo+LrwIc=;
        b=ljfX697YVRwKZXVpqQPa3MAMscBaM4d5VjZB+LLNWwBi1Rk1DlNaOsTdEK6vhWheFb
         XBJ/Jwccv/KVt4M5Man7fga0aTqioSpZifsHYNaw8/fydkOObBrXF/LCZVgZMSIlSj0y
         DFTNTBwzi4M/PGI1B2IgT+LVVnpoMklhE6+6geYeyUEo3DBe1qUpYP9tAPSEdMQnzc24
         MAHrsd39hgex88yPQUXsSr4ICLvhKirUrqVl0vVIPEnQo/ZBPlJt0aE+XLnQ1osv2S+K
         AjOxv4D2uLY3xTGD3dONkFr1OJN5xfCSEg2oiIN2J5P6GyUTy3XOmMmhrECxKqwHaP8z
         X+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443767; x=1784048567;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtHDyHd0jyoGXTQPjfTXUb5KOvKmmqc4WKzRo+LrwIc=;
        b=dBLTs5cQCIqX3MSzVotQPsCYWtD9eN6AwUep+yEoZiW/C8wNmgKVQync1hehIdbQGQ
         X79msnA7C4ZjZbYnb7kyVh9qBkn48uPWaIIAeoYMwME+PYvKpkTmknj3J3W7Bb1PBnFR
         LdbroSkPODjh180lgTmtMSf+3b/fc7oi8UHFjntxh64lG1p5DADvs3c1D5QySedIzzDe
         v9so/rleB8vNgeQDO8/ZBlgEHb4Vj4Iobu0wu16LuSNATetpNRRTa/0Y2gStkKnEOysJ
         5YP4GiYHM6982QVtYP8ST2NPdT6fXS5XvrbdhUgkACn2xYwS0LeGNq3DAAep3ZFGm6UW
         AQqw==
X-Gm-Message-State: AOJu0Yw8DV/KMrKdtBKzWNxRqygYB4Jp4WpY4YE8b6UBqdsla6iYVsHo
	IgYidmOS7cCMytxH6Vu3QfgIh/QQPcaRV/aKoe8RfP04UOSFcMnZ46RDD54pGA==
X-Gm-Gg: AfdE7cnq8fp5JfSjmRVLDFTLqhWHKy48AlmJKd4WVpY8aQewGe0xiU0wTHYCzNevzqD
	X8M8jJfjuoQj1QggWnGugPnPHEX0H3byFdMoxYQRK11scOKzTEsf/rtyByWufOlOuf4C2iqPyIB
	dz/5i1pZWrEQg6MU8sxaqXqCRJFrl8gogwlNZ4Csvb7ruXd/eBABUa7MC1mfLH1DfTHdkQjOYNg
	KD0H333eFiTSvWKOlCBocUQvh2VF2BXNkh++8Ia9zuwu27AbcNySjsoTllJ1uZstlhARBnmuTZe
	K8g9Np6hCnSWMbYyUqGPMS/KeBXk4YI69C3ObZ9uHv0btK/3P7NreHNMaucU8/DkXMbNRDO1+TA
	07RhQfXgxhqbVV2sxSSZ+UAaRXqoaaOJzB+n0/BW16IGD8oNbKpqXW0xQCnHURpyMcknR91t5P8
	7hQU8eUOa2Nv3hK1o/nWFROjUohQ==
X-Received: by 2002:a05:620a:2b87:b0:92e:6e55:cc66 with SMTP id af79cd13be357-92ebb56f050mr743419985a.47.1783443766217;
        Tue, 07 Jul 2026 10:02:46 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bc3a9csm1300451485a.21.2026.07.07.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:02:44 -0700 (PDT)
Message-Id: <32af2c51a892c2fd646a867df7eb5224d5ea39c2.1783443745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
	<pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 17:02:25 +0000
Subject: [PATCH v7 3/3] contrib: wire up osxkeychain in contrib/Makefile on
 macOS
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When running "make test" with TEST_CONTRIB_TOO=yes (which is default in
macOS CI workflows), $(MAKE) -C contrib/ test is invoked. However,
contrib/Makefile only invoked tests for diff-highlight and subtree,
meaning git-credential-osxkeychain was never built or verified during
standard CI test runs.

Add a "test" target to contrib/credential/osxkeychain/Makefile that
depends on building git-credential-osxkeychain. Additionally, wire up
credential/osxkeychain in contrib/Makefile under "all", "test", and
"clean" whenever running on macOS (Darwin).

This ensures that running "make test" or "make all" in contrib on macOS
automatically builds and links git-credential-osxkeychain, preventing
future build or symbol linking regressions from slipping through CI.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 contrib/Makefile                        | 10 ++++++++++
 contrib/credential/osxkeychain/Makefile |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/Makefile b/contrib/Makefile
index 787cd07f52..7962a9ff12 100644
--- a/contrib/Makefile
+++ b/contrib/Makefile
@@ -1,10 +1,20 @@
+-include ../config.mak.autogen
+-include ../config.mak
+
+ifeq ($(uname_S),Darwin)
+OS_CONTRIB += credential/osxkeychain
+endif
+
 all::
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 test::
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
 
 clean::
 	$(MAKE) -C contacts $@
 	$(MAKE) -C diff-highlight $@
 	$(MAKE) -C subtree $@
+	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 219b0d7f49..d9fba07e8d 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -10,4 +10,6 @@ install:
 clean:
 	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all git-credential-osxkeychain install clean
+test: git-credential-osxkeychain
+
+.PHONY: all git-credential-osxkeychain install clean test
-- 
gitgitgadget
