Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7C411671
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410891; cv=none; b=hNCpmNoaAsytn8zHqkzxogptA0ABjFViVLAlfn4slbfs9RKBB3UcfcZ61ywhNd+UobwrF2LQaYRvlfTnNmGl34ZwqPhU7gxP9Ocb86A2E866LpNugftawVFD7rXBjSJmYgEX0i6hP3zKc6QAb7v6gAZmN6yXgi1iu9xMIdRw+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410891; c=relaxed/simple;
	bh=WrLubwdvmUVv8AiNN0UuntNVd06qaZmsvUY8Obecf4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ovyDDGvUUOorPsW/Nsg2CYkve/bTMSOq+EPIqUUgWaIWE9kuZHGAWs7nfpibaRf6u8iKKebBnWdQBT/0U2liUiq1v/CTQZFOQNPedQEbVN3suA3MvgyF+LXM5924yeKXMzGsXBNyswiTtZOoydroxoEMQC+rYjbilkpT3q3PB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVmQ0g9M; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVmQ0g9M"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e0688b859so1250714b3a.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785410889; x=1786015689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=pVmQ0g9MNeJ4HhEXeykEdzL87lmVo/4YSx5HCmTdeIXdhkzMbnK3TtUJeqRS/mD56R
         RjOiwacmr4eHTn6JbIL+x3MFmxwKNTwrGl9NUad/DUkaWgGd/UsSSFayKSWYZXPldL4E
         NDxGrx80s5hP1hhRQY445C64n8rVJISW9IsG1TwFkHxr6bsH4lSCxek2kujIhvSTH2E2
         ktOphtOLbNS+NuvxubvmyumfwQ/ThjM4x5JKjfVIzSNr1Ll2wmVotI8OzoQbBvB8O4pZ
         RnmGgEyGJCHStclHumppdTGjoahlg+U7BFmgK9Du5IJlN6t2nf8BiI73Xs4Yt1K1Ws88
         HhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785410889; x=1786015689;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=sh0FAgHREZ7WRj5Z9g0eAbiqmqPzgAUFm2O+alfl5q4WNVoEGo4JLBs2dhhmZ/5Zke
         QHXz7mM602hium1UT2toirHrXUD/0qroJ8V0rHJrQxspFycCpK/gZYzV3TJepL8d5Zy4
         tA9k/KwDexi6EYEEfki/O/78b01SObbLMTGO3DyWQp8cqo7W+BybK+1zq/MiUzJPxV35
         dgnCscdV16OQND1w9kJ+szHBNoNaZr2Rc3S0yieAy26E6pZeUmoRvAC094QJrh8YwE9w
         eAa1MQw2WGLq+pI+cCVYAClAH61MQSHtgs2PWg+B5UKXmqJCRT5lhqY+5I3YGyeZ58ta
         URmg==
X-Gm-Message-State: AOJu0YyH/jO96WyJaAEkdFdDB7SEeZc3nNTSGnsj0/yqJsq9aiSIFLkh
	cqmlEM9D1s/xrV53+a0Gl13zmLgOrpmk7lXABiCRle99Ture3VMemmiZpmVg1Q==
X-Gm-Gg: AR+sD13Y4oMst7u9s18obtGBKClMYlcE4TcM5RnbfpwMy26AqfDufvJcoaY2sIOzLzW
	ZMgUmUvYNCltfQmpj2mCMqigibPH9KZiHjFb7u/ycGES+fnXMK8tjKmbPycBONIu9ZFU5CwFEWC
	D2nooTGUgKymq0vwBhgBOHrtfnqt02roy4r2YlYlQ1yc39JHRbJib+dcaHUp377vZnv1ALbGgGm
	5MnTNJW6GaGefEhr5bAf0x/uUimYQEN7Ja/aHR6WzXWKiqUckibNHamVzieBHrL/0+XX1ZYdNj5
	DLTDKYNZzsV5XNnR2RNwPQQbhZ2InAL5rIbUE+KPND+tzphE8MiTDgQ4hDhpKNvjZdzp1iOPjxX
	/WTCgvJ2M5ylIe0XPKe98FB8/bZ2iS2R7lPbzlJlWrXCU6APo21wz6/w9LuTiRyFH+768Hhu6G5
	SYPaHVsSE8j7f+WsdrkkO1csbaMOHxXm0zGxFpU6IRBopYY3zZKLZS7torB7er01Os
X-Received: by 2002:a05:6a00:4091:b0:845:d286:1fb4 with SMTP id d2e1a72fcca58-84ebc3b90a5mr2147661b3a.50.1785410889031;
        Thu, 30 Jul 2026 04:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe1d07dsm2945661b3a.8.2026.07.30.04.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:28:07 -0700 (PDT)
Message-Id: <0d67da588bc86c5257ce366903ae58e171159b8b.1785410884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
References: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
	<pull.2356.v5.git.git.1785410884.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 11:28:03 +0000
Subject: [PATCH v5 1/2] mv: name both source and destination when rename fails
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Pablo Sabater <pabloosabaterr@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

When "git mv" fails at the rename(2) syscall, the error is reported
with die_errno() using only the source path:

    fatal: renaming 'src' failed: No such file or directory

rename(2) returns ENOENT both when the source does not exist and when
a directory component of the destination does not exist, and errno
does not distinguish the two. Reporting only the source therefore
misleads the user in the latter case: for

    git mv a/file b/no-such-dir/file

the message blames 'a/file', which exists, and gives no hint that
'b/no-such-dir/' is the missing part.

Inspecting the paths again after the failure to determine which one is
at fault would be racy, since either could appear or disappear between
the rename(2) and the follow-up check. Instead, simply name both the
source and the destination in the message and let the reader see which
one is wrong:

    fatal: renaming 'a/file' to 'b/no-such-dir/file' failed:
    No such file or directory

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index a82fc97a19..35e504484a 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -549,7 +549,7 @@ remove_entry:
 		    rename(src, dst) < 0) {
 			if (ignore_errors)
 				continue;
-			die_errno(_("renaming '%s' failed"), src);
+			die_errno(_("renaming '%s' to '%s' failed"), src, dst);
 		}
 		if (submodule_gitfiles[i]) {
 			if (!update_path_in_gitmodules(src, dst))
-- 
gitgitgadget

