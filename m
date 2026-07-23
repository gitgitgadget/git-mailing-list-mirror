Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913583F99F4
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842847; cv=none; b=D1sW4rpsN1Wlrlerh1jyVeYo6WzWHeZsTYTDhLKAb0URw3lIWQ/hfQLgDW0c6FBYfcIR1C5cTCVhscc6jbmi7SUG0GlWL12IOfCHcT5jR8lMJamKhd+bzafOQ1rqmKHcLdWHFZ7GX9811i+O0KiygbKpnMosCi7Oo1c/ZCaDvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842847; c=relaxed/simple;
	bh=WrLubwdvmUVv8AiNN0UuntNVd06qaZmsvUY8Obecf4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EtidutNC3eircF8An/6lgeF2Yc3OJKDfTioQ/MWGlLYoR6EcDAXofmBUCM0Jl1tyQBZVMQdsp4PGLpNThWcZaZHy0YbLyKFOGVCL25qumnrZ6kCq+3/p7UgWx3ZA5GrXYdpkP7yvjhLTtXrFogWLExM5Zbwqeyi6NDZmGc3VukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpEDKXZ7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpEDKXZ7"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-49ff971e903so570524b6e.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2026 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842836; x=1785447636; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=HpEDKXZ7HGxlgjML2YQ+7GhDUCMr7Akfoj6dh9S50xZjOqTcH/kZnCmTA3pP9RXtxL
         11QO7M1e+2Rv1gugdAJEllx5PZhE4obXVfkAJzzORZ+LsPPNgtUcvfxGTyfcRNspmWI/
         k624osqgha0V6/K2L6SGOBUr1dS3PYgV80pVpasIc5mzR4MMzppK19lEEeOU2B6MtBlg
         a+OQh3Bw/NCCfcYnmKDf+H2qOH0FLsmKzXTTOBUgqTgawUi3tI2OGf+Rjjs4QaErp/CH
         mUzM7itkIi14mKj/7PBxKxOjP/yXRr6luVYTxKLlkQkGzbeN3GYCQu1JXVRI6Vm5Klrr
         sFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842836; x=1785447636;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3atA0DeGODCtG50yPZ9ieMEi0ZD5KhNSu53hbxdm2xg=;
        b=Az4ZaUXWL8EN6M15B3ffaJCQkh3NtMav91f3Qait/1JXwGvRcgqgk0qldpLDuyEVup
         ZppPfzjxXpwb5o8mK5WlSMV1pBiMPL31cUBdWNRC6M1xwIIkZHAAu6qbNmhOOdpKoD4h
         m3IhtPSJSVFq6UeS9kKHkHYf/UqNBtec924dXA0jFYHKbzYS2g8/f6ej8plNqAnqi2rS
         AAfPvGEB2ajopLpgFTxdOh3cGV9A0Nau5xeIf8a450n4xATuTkMntIKl35gJ5QUHvI/5
         /2V3E6qx1/d14c65/Up6B9rSKQUQzf0z0X3k1Ej5QfFDj4/MZ0q5D0io4ZB88+oP3Rb5
         U0eQ==
X-Gm-Message-State: AOJu0YyuyucSn/i8oTjSUeP8PUI/QNSbX1e5/1ZNVRdQeuYjl5J17RXU
	wDuUthtLTY5ZpwpfnI/w2yNW0u5KqoeKrJOr4oz0bELQce7y20iS/RWn4ChiwQ==
X-Gm-Gg: AR+sD12t0G0s49TUviFvV7iuWC1K7F2gxZfGy+rH6ztrZSyF+8UPG0uHhWzFNybLOZ1
	Y6sE2kLX10s1g8kJcplrLnm389T0leN1tkaJcdaL/S5/HzPEGFE0jmmpxt88JNqd1NxyODtozTn
	cdXQ5ChKyAhcRZttXLtClIGKPHBWWk41eVDjeQ78lVAHMYvE+TMOgSlZ7jtdJp6j/H2JfJRyGrn
	HSKqFs6DTKcmqtfxP2DzZ2F5toWE7pQn7j5epUPr+8i3KNms0WR2OxDLW3xKu/qTsc7v6bnCCE/
	ijl1RvRnXlJwtgAMCYv+Z0y64fBC4EHXYpcX6mEeBTXoUVplQ3DnZuKXxZ2DcbnQ2odI/kETf8p
	+ofnEBy38NZFaiFaNv+3ZEDtCGER48Z/noHNME3QVZ/FcTzPgXO60gh8L8ycJ14njBkPmN8rMB5
	O7KxTy
X-Received: by 2002:a05:6808:f13:b0:492:7abc:422e with SMTP id 5614622812f47-4ab38421ba5mr1949404b6e.13.1784842836161;
        Thu, 23 Jul 2026 14:40:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.139.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0f2c96easm3849298b6e.17.2026.07.23.14.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:40:34 -0700 (PDT)
Message-Id: <0d67da588bc86c5257ce366903ae58e171159b8b.1784842831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
References: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
	<pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Jul 2026 21:40:30 +0000
Subject: [PATCH v3 1/2] mv: name both source and destination when rename fails
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

