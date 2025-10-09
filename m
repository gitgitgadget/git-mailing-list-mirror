Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93D25F78F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995968; cv=none; b=Wl3uQPol7+sH/06vZAQ7OzlEYwyode9QAQAX9cqcJMpQjDXmKXQMHLpCS7si+0EvAvqjDUraIQv35nXENYtgRGhlaKwQOOHAcNgGA3wPcInsrl/PqrreXSlI1SogvmHuQLDOw+mJytITYGMuNiA1lBGxDfWYen3oIdu6aemRsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995968; c=relaxed/simple;
	bh=Fp0/AV8LbtAQvnH0ncSDBolGa2NHFIv54XIDIIZ/xCw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=j+ZiOc5F7/AgA06xVc5FvHqrhgjKgZXcz13Vu+8KzYJ2v0Q5idsIkuwnklITDyNaUZXthAdThgBxtabOmT58DZLZW5N/JWoHDfpnPAHZ8KL9HZeFJmaHju1jhkRYoJFeMEQC7PKJynNcEJLAltufuNmrFK+msRXT4KmyI8yMLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH5xPs2G; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH5xPs2G"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4242bb22132so6968015ab.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759995964; x=1760600764; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xXxT77HFsdKEEvpJhGeCMIQ1F188ufil0bET5mCCtiQ=;
        b=JH5xPs2GA1jBu8mjU62FAOK91ww0Gamwg7tWZLXY36Pr9Cupdssmdtkv2+XzGoFweg
         IHtLAbXcSvhRJSPH7qad53cUsFiuLNHll8fSmnENKd9tLtHdCmcmG7K7MtcFdth7IitT
         8LWMc9Fima5N8mq4stlKbKwE/QjSXsDuiDDTWQngOQ9d6DjjcifzzogGc/kG5vLvdzMH
         8DB96bk0VCafQANuDvJ1dI3W12tAOWnCBZfyY9CALbWSBKLNqiV/sL0kY9owR+pWKdZR
         dHIRdPeFv4kOCxx4h0QMHnTbCEDr/r0pmwxmDcWOVrhfSCO0y6KIPMI21eDu+Y8qAJRn
         Y2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995964; x=1760600764;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXxT77HFsdKEEvpJhGeCMIQ1F188ufil0bET5mCCtiQ=;
        b=M0dDY2M3iQQfZXztulA/Ok67WAxiwt3QaL9rGfjWpXBclP8gsv0QD4MJZ24exsVqcp
         xMscxTFwp3VJYOAxLciUxTQ4JQYzecT6BmX5rU9IlbvjbHm9Wm/z2ijrlHQtCSrgZpIm
         DqZUDUg3eY9BeEwapT8k8FeU80Tjhlv6tEu6p9PHBqYLJ1Sqhf7m0HCQ+RSB0f1ffxwe
         Uq1hXSKklNTAPC4fjzt8kXUctjXsGtTnSBK4tj3bSiDdHM5SbTxl+PzjlpXfyCbkCt8W
         bCmOwEG7ExZgkcm2dU8budtiw4We307LCrdR7tBnZjGdt8Bs6eqeUEFWuiNwmWHUS2zh
         Mo9w==
X-Gm-Message-State: AOJu0YxneOnLdcjEB3UdiIbxFBZe3sbI8X2nf6jGKLstq0xyvzfRqW+G
	d0cTu6fPvGTTxIS0i05Cj0PLTvRLyz7hMEWrdn1PO8EioNrfyRHnPSBUVXSIIw==
X-Gm-Gg: ASbGnctzt0O/AKYNrECOoJV3CtzX/83/8jrSLu3kS4KbD+yX2rO+viXf7o8tTWGQ5SF
	HubJjbA8mwFfEAxJZ8kSQEhc3hmmYps+j7JwVXNdOEz/g9ImQnXhqg2I83hTiqa3jpKvTw9mbb3
	J7TBOrEj22tB6YdkkqJLy2t1HXt791G2bzupiRFjUCUaybLpIv0kvhy89TtN6oTsRTPP0rsnJO0
	QUU4jmdYQydQFJNcLf9MHgBGyz2QFmp7VbwEL4yQ4BYm2zp3t7wc9u5A67DOjRPU3wllDMbfXfY
	Z+5ojZVQLWtWvRa05cym3lITyAEOOugWRH5B/nIBE3xe3Xto2vzKGKJo2QHfwJXJLpz0X3tpYDv
	GXX18TWgPg7vGcb4pHz9DMs+Aa9FUEq54Lei9z4sdsUhZJdeoJQ==
X-Google-Smtp-Source: AGHT+IF8IDBB9QfzPQx+QJcDEJ2B7djVhfOYAumKbErwcqHVXD5hGPONjK9VqpnTWcC5nsGuPnOEyg==
X-Received: by 2002:a92:c241:0:b0:424:85b0:e1cb with SMTP id e9e14a558f8ab-42f8740330amr66104685ab.31.1759995963914;
        Thu, 09 Oct 2025 00:46:03 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.67])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec0741csm7729936173.51.2025.10.09.00.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:46:02 -0700 (PDT)
Message-Id: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 07:45:59 +0000
Subject: [PATCH 0/2] Organize mingw includes
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

Following in the footsteps of the many, many recent #include refactorings,
this patch series orders the #include statements in compat/mingw.c.

Johannes Schindelin (2):
  mingw: avoid relative `#include`s
  mingw: order `#include`s alphabetically

 compat/mingw.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)


base-commit: 79cf913ea9321f774da29b2330b5781d5ff420ef
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1985%2Fdscho%2Forganize-mingw-includes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1985/dscho/organize-mingw-includes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1985
-- 
gitgitgadget
