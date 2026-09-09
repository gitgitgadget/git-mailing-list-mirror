Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAA3A9D8A
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981442; cv=none; b=Z+JXYtBrfzZ5HTP6pjuLUb2rwr2izdKr1ylbtgviOnKw5OI3PMi/jCjhcqsRJntbvgZ5+jRUEICGAoRvOs/wUoOZsT2l29qTmBKI/6ye5pOzWOTGsX8J4Z78kbesYYztEwmKJy35zBMrzExQcj5RMDRRale/vzBNqsY1iwS2XlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981442; c=relaxed/simple;
	bh=G8sl7dzNjgylOgBZaK60IpBPczSgVPHJwVnzdpn98mk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OC7AVs7yYAmlqCQbK31JTuVL3JFb3zZG4Fw4iDiiUePD6oOYuun4hTJCIQZt9s8udwPvw7Z8Q8bK1iMuNw4zHmPUbDE7bn7AjQ2kzO/tKu2RqP9kgxUZGk8hMnUX0H3r2G6+Jlh7sYB1lXHTBemxbN+oH963deG9dBoKRYhNUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqqxWo9z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqqxWo9z"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c96c92c0980so3440275a12.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981440; x=1789586240; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=FqqxWo9zO+fRHOby9kBEQpAf5ACxpXcdISEBSsesgnNqcWgMPZ2V9S5CZAh0ImJcnH
         cP6vXrEfB3RERFJ9kvqGhdm72+HODf+GC1a8IqXR7ULRZykEZFteHXC0etw/f+SdgZw9
         ACsveL86kw2Cw4VVc4znnlz7RU7TIOSldXnKh2lelSK2x5kl0PUXUzXZEOGd+DDMaewP
         lXPMZcH6GVAt6gvPqq5uLJCSUeTnPz8tyUHKQSh+4Afd/ULroomhcZvq8M8I0ENoTRwj
         6PoRBQID4r5If+Z0HCJM2/sW9glP0MtGTzamgBO/wEraukBedFUR6KCxFxk+XnXqBqOo
         Bfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981440; x=1789586240;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyKion8qKaZ7fDGgi6y8OS2wF/7TkO90zb+N3hqj+GI=;
        b=rhouIZflPK/vk6ty/ZKVuVn0E6zhp5uBLf41UaBIcV9qr5ClZyydYV1eMiZmYDjaJU
         G5RKh6Ize3GPPUrInFHfuQOM95MQT2JLMVuf/J3UnzNf92n32X8iAu9dUUTEwMSoyjSI
         J/kSb6ieXe3wgy1iTTYWngIBGcccQ5DVrfCvdgykJoqJ/GRjMTJC/VJFoVqEqxbpeJWd
         rRRphDxFa1GCwa7bCuJEIg2so+r85E+ByHyd3MgLzzSzCUkhVrc+nqnGqSx9oE+Aw7vR
         Z3ZujkqyoMb5CiXUfqR5slW5p+5UAuJLrr5+RCiYWSOtzx/hUP1PbInFbVosAatFFX9b
         AClg==
X-Gm-Message-State: AFuF++mIXFXB8iqxnKgeKj2Iri1U9I2O3FlerNyxqgSwykw7hMSa/mn8
	1jpx6Q+2l8zRdldF73y89G5AVGLjepv764KbfXY5ydu6T/P7BbTAbMDpXtXGHA==
X-Gm-Gg: AYBFou1bxdEZ0hipeQj8LCUCyTw6igrkkPvfk1OOcRUpjKfSbcdM45NDyMJcp8qG4t2
	XHAA/cGpZqa+kMI6q+/DgRtCg0cdRij0jwd61qhnXWSU/gBVH2T/E2elyQf9TwGDScH85RpF5WX
	SHNZHa4FIlUNsL9F17qD90durh7Bg0sEVmte9NjsXAy7Wag9Fm34ARL6nCfJ0Yb7ylSI9QhPZjO
	Qooti1xWf7kHy88tuyxPSe4wX9VicHXEv/0Ik7dKHuXTmfKcUzbyUlIcTKjQEQ4f1evOGzg9Wq3
	jobVQGX3H09J5lQB5P+KDd1yWHRtHLVvJZaxkgEnArZYpkgXTXPURtuCk4SKu0CRVc5YXbmExFt
	/omy0aw4KkAJOm8fB5u94BOodsNOq/LnvS8KMoo/sUV8Wuol/ylyzMZ7hkc+kz2qzmbJ4TNSt5W
	78XNvy9tBpqnY0D9rLWJMpbpDYexnICn6QglM6UqZezTaKPXvC8JGLEfyKBORRuGQMP03jPDOp
X-Received: by 2002:a17:90b:560e:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-39b261e7931mr56870828a91.14.1788981439889;
        Wed, 09 Sep 2026 12:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm41517765c88.0.2026.09.09.12.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:19 -0700 (PDT)
Message-Id: <fd594ffa6cfacaf7896ab312d51d39f30d09be81.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:05 +0000
Subject: [PATCH v3 01/12] mingw: include the Python parts in the build
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240378..8dd8acfaa5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -781,6 +781,7 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
+	NO_PYTHON =
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
-- 
gitgitgadget

