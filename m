Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D03B530D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385884; cv=none; b=EWQP5YwzmeuJDMSbXD+ubisBBbD9syUKtvr/0FTxCXkH+6VIBov5l3dZV4PMuZ2/9cgXN8ZPEwMfX09H+RQijSXDiMeYehPYo0S2//OXhNcHobYkzitQ7vCrz2wNXE/6Icm65nMFHEYl1l+pj0qQ5VRvLFkWbphzZhjhvTGLwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385884; c=relaxed/simple;
	bh=kPbjtEkPM+CaU8EITxzWN81WEXqT+P7Jy86h3bkPEmc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nIosJeCYygkoBBVD8MGAVJeBwUfKHxSnrqlQ3d58KW2YmQvaEWB+PNTBHktecRvH982p/AD1mrVAVqoaanxogJoFDaAMkvmqvxhTCPa6/V+dgfrRdCy41rrOmgy8r1p+t/a/QMZIciYcySE3Z09Zn35iP1w+CCN70Aeg9YDxCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adRs7G73; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adRs7G73"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-915660e5b8eso204776285a.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780385879; x=1780990679; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYtaVDUl9C42lq9HGvoiBz1XrBStvEDnRc0BWbVuy0Q=;
        b=adRs7G73D7R7N6s6iBHNstu+Pzvih2MUKe+VG3ciq+0Lg5HefmX5zdjGmZ5zUcoeZ9
         GKWrDsUOnZkznbz6vhYbmAxTDHg5KtHZBPFye2r7mSGct4kc3LpdosTF0mQJ86pl4TML
         SG+xuMiQikAISfD/1MVTOUASo2A1WPmmt6W/CcKmh/vshpC1GwRodTVwQQ7nQVU7FtTx
         s5UpIdCBfOM55pXHoVUYRS9zYPN+bR63AWZQQtXPziclKRbYLyXKvDq1vA//MHu4kmdF
         8hgsmckW2bG4VqTLbUbrINvbKn3Ln114n9xpII4PfwJRgohFjEW9H8WFkySboOqv4LBw
         qZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385879; x=1780990679;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYtaVDUl9C42lq9HGvoiBz1XrBStvEDnRc0BWbVuy0Q=;
        b=rKZR3t+3R2aCeWV9Vo8jvm0czzGiozzMa1CEMu1KvS6zsIVc9xI5d8jNnr9TUuz9b4
         xTXf1h8deytdS5EM/cGaze3LAbQZPzVom+xNxwRS7PdYu7qqexUrNfQ/+589ArbYSNwE
         0nkGE8y+a8xTFkpf2Aikv/Hxl1ERrHDvX4MCaVCJ7eXrvtSsm11s7eXzhxxKQ4KU1bmD
         xatSwdmOX0f6lzPF7mWrsvWqIQgeE3weo1BjU2pW9CwvmEaUMLHRzwKzjAHircAbHcSi
         peymVLP338bRTX92YMq+ZsXf3oAZpkUeL/SAjQWXO4yokZ71esFx3MGy9q1heC/F0YnA
         Uo8A==
X-Gm-Message-State: AOJu0Yw+rJBNcHK13aicI29IYRWv0RQYyE4wtAroS5K75lcJZi6R/vmO
	z36OfvmFWPQsKG1EhCMoYGPXLrzLy48e57HtfS17I1tOE9bWYM1aF632PygPgg==
X-Gm-Gg: Acq92OGq3+y72uosdNIloa/YN+0bbfqp2MQE5sL35iO++5l+kC7Dc6Nsono1hpdYZN5
	c7Ob2WwNil8FWCFjRgkMMO72SVROVypfw4yWJjsqQtdAhK/iKk269vlKfzNGJ6E/NtvLPKjAbrA
	uKhsV5GKQAcLgv6pTl1fvHCK+Fc3e1Wc2ZbHIaAs3c+4JDRJ3qEiclkJtxUOiXVCgsOMW9Fc17P
	kCPEB0YYRd9k0pRL262hAh8pvz6E5E/8c4xk6x66kZ2bsIFnRbrmr/cR/WKtUaYHWBNxwzKyjXh
	nlxGEuOjeEOGc4RAjyVyAvHEx3WYsTHdjBLgcbnX0yTWCKjXce1+yCYA+aakOQ1kqvSfsTTg5Sa
	kjgOgY9r36YKR6hXrJoIussjAD2OAU/aq3wNiIoFt2JeA4OQc7Lxy4wmrYVsqVH7yyv8PxUJEYg
	Y+V5hgR1zzcyVbtAv/B+QkLmvpA4FoDwJ4NL29yRU=
X-Received: by 2002:a05:620a:284b:b0:915:7e22:6f2e with SMTP id af79cd13be357-9157e2279b1mr138570685a.24.1780385879561;
        Tue, 02 Jun 2026 00:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.207.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244e114sm1255426085a.5.2026.06.02.00.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 00:37:59 -0700 (PDT)
Message-Id: <pull.2313.v3.git.git.1780385878555.gitgitgadget@gmail.com>
In-Reply-To: <pull.2313.v2.git.git.1780065163866.gitgitgadget@gmail.com>
References: <pull.2313.v2.git.git.1780065163866.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Jun 2026 07:37:58 +0000
Subject: [PATCH v3] config.mak.uname: avoid macOS linker warning on Xcode
 16.3+
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

Building on macOS with Xcode 16.3 or newer emits:

    ld: warning: reducing alignment of section __DATA,__common
    from 0x8000 to 0x4000 because it exceeds segment maximum
    alignment

Pass -fno-common when "ld -v" reports ld-1167 or newer, so tentative
definitions of large arrays go into BSS instead of __DATA,__common.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    fix macOS linker warning
    
    Check for empty LD_MAJOR_VERSION.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2313%2FHaraldNordgren%2Fpkt-line-init-buffer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2313/HaraldNordgren/pkt-line-init-buffer-v3
Pull-Request: https://github.com/git/git/pull/2313

Range-diff vs v2:

 1:  0e660a346e ! 1:  f864912c53 config.mak.uname: avoid macOS linker warning on Xcode 16.3+
     @@ config.mak.uname: ifeq ($(uname_S),Darwin)
       
      +	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
      +	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
     -+        ifeq ($(shell test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
     ++        ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
      +		BASIC_CFLAGS += -fno-common
      +        endif
      +


 config.mak.uname | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index f9a5ad9720..8719e09f66 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -173,6 +173,12 @@ ifeq ($(uname_S),Darwin)
 		NEEDS_GOOD_LIBICONV = UnfortunatelyYes
         endif
 
+	# Silence Xcode 16.3+ linker warning about __DATA,__common alignment.
+	LD_MAJOR_VERSION = $(shell ld -v 2>&1 | sed -n 's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
+        ifeq ($(shell test -n "$(LD_MAJOR_VERSION)" && test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
+		BASIC_CFLAGS += -fno-common
+        endif
+
 	# The builtin FSMonitor on MacOS builds upon Simple-IPC.  Both require
 	# Unix domain sockets and PThreads.
         ifndef NO_PTHREADS

base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
-- 
gitgitgadget
