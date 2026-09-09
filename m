Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318F3B19D1
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981445; cv=none; b=a0oSb3D5tJf1MuTU45caQsVguRauC7J6Jc0oP5yogmueKf1EeepW1/K4RewUApEqcwieofe5GxQKsSFhL+OxXyT7bJJjGDdb2QnKqODWwBlMbxgVj/LBnKBBCE+gnnXVVkU9JxuDYDumYaNFRLSXYpga+vXJOpPuWtzAOeVxEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981445; c=relaxed/simple;
	bh=otKoDAwZCTLMe/mhK/XkAqcZlc7oxBQe8IkHMg+2zxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q9/vUQfP6fXHA3wGNZdaxJNTv9GDQe9YAeOZXrA0WTEkhvZ73ReHiFCFhIUqoI/2H0ZFQoM0p7xsI+OYmQKBk5LShU6kQsWvkSOHzfr9LPSNG/J76U1PzI4Lb8ahK3bI4wRL2Im8lsr9mNZ6maBaun4P79a4nk5rZKe7EgRRRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdX8vSv+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdX8vSv+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so18361475ad.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981443; x=1789586243; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=KdX8vSv+qCFJvf4Q3TpRvKJ2Kcsbh9lmcpzvpozkpNOwRJ4qeyfWsIF0OHBcGkzSdx
         p19n/qmn5qSWXlvcLYyfq+i4Cy9WcupvJr6D3IPqsq0G5WG18KcwqClAksCQqXdGxf9L
         4TRDfd9ndSno0HWcyO3k3GtW9mGOcQUqCkaj+8L8hYzemCNkcuKcTiq6W3SiyGGi5PD4
         umVjaCfzy1xyAsxJxwf4fdxmvvfqK3YsGK+Tf4MDADDGRbrwJwDJbMiIZzzpLhBydCo2
         DDT9EKYrL0BqlYgNVEdALm5CqhOrVHchgh6Hcf0Hy3P7BTBpHCkAziJ2+S5mf5GGk6hS
         e5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981443; x=1789586243;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=UDlPcP5tWtxZ2naCDUsdqPY23eHgnZHNT9XUiA6UwNTl59k2Opw5NE2TV2QkuyY1Hq
         +OzUNxHGKU3A3JOch007/WP6KP77lEXn67s3uuPvAPoGCJsouEUr9tfHgDtmL1VMb/Ih
         mxpTrl6hrQgClB9US5YKFfSwPevhmGBdTO7pFXZMvRFUJilZ4i+6y2cCs/pumnHpp+Q4
         ou5rhFLTZMax00BV4koCZrlXzREH21uzOma4t/N2pCguaNZCNWyOkrC+3r9kluXUle2r
         bKAR/5rrVm7FFaPxC6dWobTc8w0hlcfCLuTUHRESeWmBWFcdsQb2RI8oubrG4PJ5H9Zs
         b/dw==
X-Gm-Message-State: AFuF++n3C2q0+pB2Ba3KqHggCVQ5apqp6C64Xe9Gh9yywxFvl/L4pOia
	31TXmhRXlxyuz+qhw1K5uv9v6sV1cou0jvzrvOSIORC0vm+0IRC22zlSJMbmpQ==
X-Gm-Gg: AYBFou2GS7IkXa5YKqqqWecSKNfROYuac0W1ioO0KbkzXQfa4E2rQmXaB+vQO3EM+z6
	+PfwbY/dT1hGf26lCHuKPiis5svUTLY5tVRsbh7Hgw7O7eBR6/5JMqSiOBfZRYOb+gx6I5yPK7d
	aWQsqcCXcgbhu1JEsP8y/nVatrhMlPb+AkaiIGGgDY7HqMZft/j6qaRp0S6nzHSgen/u2NqmG5E
	Ol9JxkW7l+Gc+xfGNCQOdDsNbD19Mdu1Dr8StX3iOrRDK230AmixsMcavvY4zTOl5h30H1Sg8bw
	LANOV5dboG6AdYZad2BZrI2fqbXbxQNz129mNPhpY78KdjSfKKx3pA2eRWOw0FLz+Hgigmhq/MT
	ztaD0A2+paWpYO1IHtjYq/PVWYntpaqqjtQJrHYNDWLTJAWhmz+fbI+Kw3tdWMHgkkWwYyVg2AI
	OXmKVsxKuxEvHeuIzl0JapxWebXZH6bPj4ujSY8GRKKDnB+ltJsh4LK0zuJb0GD2HIghaN++gT
X-Received: by 2002:a17:903:320a:b0:2d9:43f5:b462 with SMTP id d9443c01a7336-2db8d8179c0mr103045935ad.5.1788981443281;
        Wed, 09 Sep 2026 12:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm46275103eec.17.2026.09.09.12.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:22 -0700 (PDT)
Message-Id: <53f1fd576379a7331e827a2384605a1445f85d86.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:07 +0000
Subject: [PATCH v3 03/12] mingw: drop the -D_USE_32BIT_TIME_T option
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

This option was added in fa93bb20d72 (MinGW: Fix stat definitions to
work with MinGW runtime version 4.0, 2013-09-11), i.e. a _long_ time
ago. So long, in fact, that it still targeted MinGW. But we switched to
mingw-w64 in 2015, which seems not to share the problem, and therefore
does not require a fix.

Even worse: This flag is incompatible with UCRT64, which we are about to
support by way of upstreaming `mingw-w64-git` to the MSYS2 project, see
https://github.com/msys2/MINGW-packages/pull/26470 for details.

So let's send that option into its well-deserved retirement.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index a464b2009c..cc0ed63af3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -768,7 +768,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

