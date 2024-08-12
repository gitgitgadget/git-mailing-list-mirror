Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502CC187844
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481914; cv=none; b=eRR1R7sY9ThMnStyutIadUphN0+zK57KO7y7fPeHX2502wH1CL5UtHjW8GKOXZrU89MWCLUHPspbQ87++wZZ1YgMIdl0sa2ar6FgXbHD9PUkQ8I73EqYnDja9JdK4mwuluc4UV9MvCdGdjABma9rfNfFp+FjVz14LRWX94KzAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481914; c=relaxed/simple;
	bh=exqNXh8Hk86doeRfwVdefaEQsQngqrKm/z7NMUk4ff8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZiFzmZ4wDFFYjlAe9IOZrmaKsFiBNP1Mr8OW0b4NkDsm5FbBnHxxoRHh8i+vKoLv6q31/HRt8x1EtqYbIF0k0PhWmHgZ2HgqgXhgDT+1FrsjUSQnrfHTD/2IZ52xuxj+d2BdbWL8ts1PH29L+UxF71PzpdV837YzgQGtu9535XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/4GUvH8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/4GUvH8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so578605766b.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481911; x=1724086711; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVH6vXku8VfPoVRonziqxPHn4t7VnDc7lwurJTAIF34=;
        b=c/4GUvH8Qj0ff7KnDzLKXlKs9c/zOFLFsMM+3WPUJWrDX1Z66eBl1nr4wXC4GKQmWW
         vF/yAFvnG1hNY/K+iUhHz0cdpfxSNzp1NmPouW/QBeQtOvI+79Q2c2Xe3bwNVAhekDP0
         skt49Y+xxyAx2Lu3uXNBrHhmDh0r8043/dDvVfcA9QLy0/DRD9Vcg/WFYRwhpq5ijIiK
         QU40w7EXKSaByp+tmxyPBG2eM8ndXvNbiIPX5ZEazG1R+3sfPxXlAehZluAM686fsIB5
         J+ZEk2f2l49sUt/wCQJFw0+4mOtSuh3D0gFiGNqbfuAAOzCWxa9mVkHNOhuMsrozShps
         Ct6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481911; x=1724086711;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVH6vXku8VfPoVRonziqxPHn4t7VnDc7lwurJTAIF34=;
        b=vVm+vI9oCnRCjg5LI+Y7hB7/uTdg7wVyG2IGtfxmX94FpKt5q1VcGaXOYyAZYuH7FN
         NPBNn+IqPmw764/EjhigL9Ip13p+9Y0SJNlpW3sD1Rox53e+LA7gyK/D/UQhCoIfeEqG
         os/yoW5+0gwLXpL72zO3rbKtJUKhF87hNA/mYG0DfACzkM/s4OobDKfJ54Kj1QTutSGf
         sJ97QHBGLdy6i3J6dQxL5ZmyA+BD6zS+l3tXZGrKQ/vslz3nKDd5ByGRREONg9QQ5TQs
         IMgvniwXE9xP8ulwhfJcODNN+q9zXXS9PCUSSfiyN0+OjtAuU3A76FLT1qTtRx9Vm7+x
         K0wQ==
X-Gm-Message-State: AOJu0Ywp5fPRuFkY0dAf10Ooup+j9f8usUKAE2Wz0EI9uZwrNkp7IML8
	wdA6O6VOqbKzeor01ylWTiIuykL+EgmuXz5kunBqBkV+pP1K7xjujlvI4Q==
X-Google-Smtp-Source: AGHT+IFj2WkK0e4sbS2sPqqy1GHEj0D9TWv6KRfs+PBOfzUwJ0uKcTQcgGYldTtQPpgo4gQStr5+QA==
X-Received: by 2002:a17:906:fe45:b0:a72:50f7:3c6f with SMTP id a640c23a62f3a-a80ed1bba52mr88573566b.14.1723481910943;
        Mon, 12 Aug 2024 09:58:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb214441sm243699566b.186.2024.08.12.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:58:30 -0700 (PDT)
Message-Id: <002750ea47a09d2f26c9c7b040c6730bc3f62b10.1723481908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
References: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
	<pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 16:58:26 +0000
Subject: [PATCH v3 1/3] git-svn: add public property `svn:global-ignores`
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
Cc: Alex Galvin <agalvin@comqi.com>,
    Alex Galvin <agalvin@comqi.com>

From: Alex Galvin <agalvin@comqi.com>

Subversion 1.8 added a new property `svn:global-ignores`. It
contains a list of patterns used to determine what files should
be ignored. If Git-SVN is going to ignore these files as well, it
is important that we do not skip over directories that have this
property set.

Signed-off-by: Alex Galvin <agalvin@comqi.com>
---
 perl/Git/SVN.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 7721708ce5d..b0913ca1b63 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -763,7 +763,7 @@ sub prop_walk {
 		# this needs to be updated.
 		++$interesting_props if /^svn:(?:ignore|keywords|executable
 		                                 |eol-style|mime-type
-						 |externals|needs-lock)$/x;
+						 |externals|needs-lock|global-ignores)$/x;
 	}
 	&$sub($self, $p, $props) if $interesting_props;
 
-- 
gitgitgadget

