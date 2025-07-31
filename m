Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFEC120
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964144; cv=none; b=rwT5FNd7qwrOexyuJs8ULq9h9oaHcS6wW4nE8FVlQkRHUnGjHJG1tpDyQ2LpnIDWe+ChPr9TB/bDGFBQHExhtTQiMLh/xg7Nzjawuqbv/5NIZqiceBBz+QLd1WBT5+upd5I7+nLa81Y9Cb/ttqNsgRMRriaNfim4HTfUtSMOVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964144; c=relaxed/simple;
	bh=7GwZvgDreLZqTKsRFUSgaxgMcUgvvdqMVLWoO2wW+vk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OHxQkwmVMOUrOnEKmMROMq+lUljFMX0EczYbQBJDZg65BIMwegHlOrpFa3qHfgu3gwX4QKrhtFe3ywvTTwICergYwJKnzeqjjuttzPQilMXdQYSsF9BqXa8xWfuLUbLcj4ifVTLqlmiUFe6FIA9y7yoDo/3I+HU20iclfogCT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=MQrcky8W; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="MQrcky8W"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b8a0f36fcso352204e87.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1753964136; x=1754568936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LevVRfV0K1No6rUf4JQxFLi80Iqr/mmBDv76hczDJgQ=;
        b=MQrcky8Wa4QHOm3jRygiKF7pXjTpEx78rd7d3JdgOA7RWvI1MKP4K5CpE2q/nfn1fs
         L4kRk8BtXFYMey2QPWJJkkSHNimeUyJD7GzcsCH5sP4V9M7rvkaDXFAKAwlSwEDzQCeA
         Jn64u1e8r2hGQs0y4OZj6OgH5OXBp54Nc6X7rRdER0RLoorhDZrNuka/41LiYuKXSyOQ
         8C1dno3fmRu5AvVsb7DhPkkztcpPr3ZgeOBsRBAsuv0YwEUCT8VRZLIISejA7iQuP2tq
         bwJVF+8WErmjiGQkHDIncpI/j+hMV7Xll9lPmYbRCVixpg4Wf3NjIYc6aUsVK9f1kfYN
         I8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964136; x=1754568936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LevVRfV0K1No6rUf4JQxFLi80Iqr/mmBDv76hczDJgQ=;
        b=Kgrj8nU1Z5tzKB8FyyQ9/7r2DAqv3CuGa5bdV9FJSbBrMUm75gsZRJ7hAubcMxT6+t
         6tnB0eYBxmNbdXlWRApl/zOk6hJzDZKh+Sl1orSLIJTVTcldDigz02vGiIki0n8SYC5q
         A4OrenGxO6koOlnIA+gdvTMcAm5t5UxnS6TBrL2122Xq4UGhn3WH31AeaLZQ22HIwfBa
         HZp/P4Cb1qb/Ty/oebHrUdnQ7Vzbi8aiv/aM6GQHOb/Cd+xafMDszCdK5PYR1eYP6opI
         d95OnOtsw3pFWbDRffCrVjNp8+BeHeZV8jI8T27m2VHcyCFzYmBEOWVrGcVvXiLAqlPs
         bGjg==
X-Gm-Message-State: AOJu0Yzw5kVbcrutKfOcuouzuWFaj0yNwCx53i3kiwjRQGq39auyh5Yw
	YcytLa2QagMSDhKtRG5NRze0w5lQ795Dxm+T/McgaBqeL7COqM1ln+KObQ3LoTaWw8VSHfySVBS
	9nHvWnn6+
X-Gm-Gg: ASbGncts/UaE7mi5UZGRSnImszETHOQ5b2jEcvCwWp4RhXjq4UB9L+Pxm9rYXOfDDvV
	LcsP4k5K7MlTuILfKmN1pD4a4KTd0iZSeuHn1Xzwhz4r6n8XrJr4V2P73WDgq6btaKq+wFheYGX
	8s/xoqXXyHbGfC4kwr3p8u8xNUMmU1T1CcqYd73ke1P/aO4BKFqMcNGpeD+FY2GD1ZX01b420Ha
	vePjcojnTqZ1W/Mp78kRZEQLFufhGcu7+gP2ZiRm+QhSM8MUlhhEl1dBdXdRhBtxLnCnqKAWUav
	gKsbk7G+h25PkgvDzC/7Si5NYN8xVQ90kgNS00wXdgSyIpFzU3Jjrye8Z3PqxI25bz1g9MgCJxX
	3SN+VfsKnO2VXTAFhSo3VTQNsT5218RT4GeplrlB2VqFUqRY2se9ADQ==
X-Google-Smtp-Source: AGHT+IH/0rlaqrn2lE6aHfwd4paHvoO4gePjRhgTlC06+1wg8C2Vg5AP8034Wg+iGpCWwY8fRqn6pw==
X-Received: by 2002:ac2:4e05:0:b0:55b:8186:8cb8 with SMTP id 2adb3069b0e04-55b81868d7amr1811284e87.54.1753964135595;
        Thu, 31 Jul 2025 05:15:35 -0700 (PDT)
Received: from localhost (dsl-tkubng21-50de30-198.dhcp.inet.fi. [80.222.48.198])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88caff99sm209786e87.163.2025.07.31.05.15.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:15:35 -0700 (PDT)
From: =?UTF-8?q?Martin=20Storsj=C3=B6?= <martin@martin.st>
To: git@vger.kernel.org
Subject: [PATCH] meson: Check whether git is new enough to support ls-files --deduplicate
Date: Thu, 31 Jul 2025 15:15:30 +0300
Message-ID: <20250731121533.178747-1-martin@martin.st>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes Meson errors like this:

    ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.

Unfortunately, Meson only supports the external_program.version()
method since Meson 0.62. So with older versions of Meson, we have
to just assume that it exists (or maybe assume that it doesn't).

Signed-off-by: Martin Storsjö <martin@martin.st>
---
 meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 9bc1826cb6..717365baec 100644
--- a/meson.build
+++ b/meson.build
@@ -693,7 +693,14 @@ third_party_excludes = [
 ]
 
 headers_to_check = []
-if git.found() and fs.exists(meson.project_source_root() / '.git')
+if meson.version().version_compare('>=0.62')
+  new_enough_git = git.found() and git.version().version_compare('>=2.31')
+else
+  # On Meson 0.61, we can't check git.version(), so we just have to
+  # assume that the found git is new enough.
+  new_enough_git = git.found()
+endif
+if new_enough_git and fs.exists(meson.project_source_root() / '.git')
   foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
     headers_to_check += header
   endforeach
-- 
2.43.0

