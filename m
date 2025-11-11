Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918C137923
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762820424; cv=none; b=EGN+O1SubPITLq+2CLadu/kf4FKDrOouAkHkGT8TH8kLWkU0bwmrh4OwlCG/NZIu0vEQ75VWHvqgjpbmshDO2gOZyBTBaAmMwph40YqXC2WsgILe1AGk2hfWpzvZqqSP6PYPXPXMy3KCsM5+50CIeiyNsO7ZDxe5K/eOdpA4am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762820424; c=relaxed/simple;
	bh=kMwqF2XXsGB7OPxd0A7roCXTlUtCkBwcTCcFx6AKuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+gYqEzWXrrx87nOWB2qmB1pBLlxFAhpCSDDA1Hjk6O9TG7L9LWAe5h6lwVi1Ntlcfg+77DK739dWhNHs7MtEaz19shjdY1Xg6spTp3cw8Cf/DuVMZqWE/zC0gSHxBpCWPeIaazfVC5YTjkCnGmRiqNpAMpvXbZCKRIMqziAkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7j5InBB; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7j5InBB"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640f88b873bso199845d50.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 16:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762820420; x=1763425220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/egOHAxQeEZopFNL9cgNfraru2so9tREvNRe7TWbRM=;
        b=F7j5InBBZ6kJVIBCbvrJ3ZharaSLh9lqhtKkrdTl7drTrOwRt0NcYUfHHybqEkXQZm
         fJJAodrMpOO7HKpD6qV32hOi5kyTsggS6jpwf7Zweweq+pk5V0wkojUFGrmLBc4WGIup
         upL7DvKWO3taGxMyfBelihCPZMH4X0ml09KKqCEQmOEoYbeHoJd+ihfdL53Rw73Ikhb3
         qW/7o9f+/mSAsDwsHUgVcBXDenLSz1lblmeEc/3/48YCgjH1VgIyfs8sPf+uextGIK5A
         0oEDeGra60RkzpT5e6yzcxemLGDeQvS3Se4lQD3PujxsTthqgU8PGcYEhnx/bKdjS0q3
         38Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762820420; x=1763425220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/egOHAxQeEZopFNL9cgNfraru2so9tREvNRe7TWbRM=;
        b=A75cvyJzGjzJ8ItBv8zKrG9ooM8pKgHdhfHiHMNYHpsZ0k4kV6MvimUqi82+sb0kAD
         YiYn8Jsk4K9GA98WVEl2g0/6fYeCikyNSZLmZl/ttDF8xm1aPYfWBXVChVZXY8PF9+3n
         V9scSJa+K28EbWUAPd4px3xP46eAjRTuXGpSoc7M7LFyhzPH9cq7e4m0+C4SiFmrICIF
         IZNBon4he/cz5OXFV6YXJkgYwI0wGbECX+9XOFkT7oOv8NeOdDC8SI8Whz0hHcuKo7g9
         EYUF0S31zWSYTLEQFi+27xbBYEYVpHK0PcuOtMdHc6BWauV6gRSMLlFuqJfJkOQ74Coh
         IVOA==
X-Gm-Message-State: AOJu0Yx1uMIgnRh68xaSDuJF0cxxI9dCsvYkqbtsA6OKgzZ6Ve5lQQN0
	odSyCUrXPlgIfUUQE1FD4TvhQlkXTPdt4L7m+kHYwhS2y+b6cADCa3Dn8bulPgZVVL4=
X-Gm-Gg: ASbGnctq8G9W2hemjGamP3gpCxGqHjFS9VdtLQjC93cLQ458Tgabc/RoSysuqyKSvU0
	GG/JWNE6U6ypZaPi4zBBDNq6tVt+a0fLPdMFmDlLrNW1BLj+VmJvSVfPXZL/jWw5L8t4nplJBf7
	g7n4Rk6RNwYhXKabAqqfJI3YPXMvg86ugxBf48FaViqLkHw837kvrZ086khOL3otKIHul/JWVzk
	dM8whISlu4UESccySSXwgSDKhu5Jqe+jqz94baMFeKj6EMLPW7npxLCvwdR1UM5z3bAD159PbRR
	L+2K8OsJATkne5QixCUO6ZRG/p7vJM3cEfD2GZ/vHs9C4NA0nD7R+JJdC5YnpETdx0vvRPJGwkq
	bU236gGsxBcpW8LOs7GABD7y8OYDH5bmgz47QvQX9prS9khc0vkvanWVWcpXOdDyE9CsafbGXSE
	YNOQjIuJA6/n1tr4c=
X-Google-Smtp-Source: AGHT+IEqfMqZ0u9lWk9e3eB1ai/QGZZNe3EJiJxAOToxfpgbdHGYaAU9XFZm4FLts1SbfKVrzwPcEQ==
X-Received: by 2002:a05:690e:42cf:b0:63f:abbe:3964 with SMTP id 956f58d0204a3-640d454395emr7709473d50.13.1762820420017;
        Mon, 10 Nov 2025 16:20:20 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640da6324f5sm2609254d50.27.2025.11.10.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 16:20:19 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v2] perl: also mark git-contacts executable
Date: Mon, 10 Nov 2025 19:19:57 -0500
Message-ID: <15f07afcb66a900e5391e6b07e0701ce84236f04.1762820188.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.71.g03eda12af0.dirty
In-Reply-To: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
References: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When installing git-contacts with Meson via -Dcontrib=contacts, the
default Perl generation fails to mark it executable. As a result, "git
contacts" reports "'contacts' is not a git command."

Unlike generate-script.sh, we aren't testing the basename here; so, glob
the script name in the case arm to match wherever the input comes from.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

A small typo fix for the commit message, thanks to Patrick.

v1: https://lore.kernel.org/git/7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com/

 generate-perl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generate-perl.sh b/generate-perl.sh
index 65f122ebfc..796d835932 100755
--- a/generate-perl.sh
+++ b/generate-perl.sh
@@ -30,7 +30,7 @@
     "$INPUT" >"$OUTPUT"
 
 case "$INPUT" in
-*.perl)
+*.perl|*git-contacts)
 	chmod a+x "$OUTPUT";;
 *)
 	;;

Diff-intervalle contre v1 :
1:  7fbb341e8f ! 1:  15f07afcb6 perl: also mark git-contacts executable
    @@ Metadata
      ## Commit message ##
         perl: also mark git-contacts executable
     
    -    When install git-contacts with Meson via -Dcontrib=contacts, the default
    -    Perl generation fails to mark it executable. As a result, "git contacts"
    -    reports "'contacts' is not a git command."
    +    When installing git-contacts with Meson via -Dcontrib=contacts, the
    +    default Perl generation fails to mark it executable. As a result, "git
    +    contacts" reports "'contacts' is not a git command."
     
         Unlike generate-script.sh, we aren't testing the basename here; so, glob
         the script name in the case arm to match wherever the input comes from.

base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
prerequisite-patch-id: 664e4667d11a226a89da52814505a0c8d31b9fba
-- 
2.52.0.rc0.71.g03eda12af0.dirty

