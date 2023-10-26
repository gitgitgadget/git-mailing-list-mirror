Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27A381DC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSI1XMHz"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE13D10F7
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9caf486775so979768276.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698344555; x=1698949355; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EX6oftXkHWSW08FRc+9r5HoctSmiGO52b1depWLT3z4=;
        b=lSI1XMHzHGdzQyt9TD93LzgA30L0wRgGBYCpTEpofTeHXBL1CApyyh63a8fVXJg4oa
         bb83RBlLADSR00c1nP+/UvV+cbC1R11FRaDIp3a1vDMFWKXIqn1ct8wGL1nSXjDUuuvk
         RsRpObzw0ogvekbTSC+jQBzwmYe+4YC4g1TwJ81UQNJ2zXRKHd3wjfSW1NuFGFQrqH60
         +Z5rR+V6IVqYKVJjkZpKRZR9JijgTXvHi69dhMHCOPQQ8LijiQmsUJsvzH4FKiA35Rv6
         d1GDxKCc5zEskR57hk80Pu71IdOteAWS/YYCyM1LUee0+Xce4ZSBbVeRBH0ebqAOyLO5
         uzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344555; x=1698949355;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX6oftXkHWSW08FRc+9r5HoctSmiGO52b1depWLT3z4=;
        b=mwSAildpg9urXfsPtegQab5abBX0jhBKBkcK+WE1jjIITgK6/C/2HOqAp5TIPn0NQG
         lNafZNOlu0exiosKMu+smWjQAEOyyaM0NGUMLaFXSqMQK+pDoeMIRnQH0pyNOPZZ6kD2
         RsBViDIojDK6BFpUuw2Yq/9iWWlyNC15rDRayy+GXmLWteJvDSSS2CCvs9aaG49mm6pY
         h0y3bF1Hl24vouqwicjU2ItHUQqzzCR9aCI1fe3oeFK0FODk6Nv2C9ZHVE31L+XLm/uw
         8sDfd0kweeM8Vkgny507EL1nWEOtaSoqlVpVx6qJHreEclmKq8AqIDKkjG76SyI1bCzr
         BQbg==
X-Gm-Message-State: AOJu0YwPLcH81OW9S0GCJYmMW7sAdcPQO+3ANO9Vxwf3t0Z34jR+laCc
	oi9OpG/LVwGwpZRFizA1i+uNvrEgWVRNjaoeYVWUxQfQa0aXf+M09ZstQ69OP3d0nC1KbiWbH+y
	MWDSs4s0G/3Fp8vrwjgMRs8gSrPXubs2mJEv8z9iEF0/09sBb+7pMts43JK8H1YgKZiP1W3cavg
	==
X-Google-Smtp-Source: AGHT+IFCQYbbkKy3cqcKnZuLFNpGdFeZLsZMNTpEA542m3kWY2ffMPJSwuCcZTPEve9PoTYUzngefflInopDo+hNsFY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2d3:204:a9a1:5044:5663:ae78])
 (user=emilyshaffer job=sendgmr) by 2002:a25:abcd:0:b0:da0:42f3:6ce4 with SMTP
 id v71-20020a25abcd000000b00da042f36ce4mr2799ybi.7.1698344555569; Thu, 26 Oct
 2023 11:22:35 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:22:29 -0700
In-Reply-To: <20231026155459.2234929-1-nasamuffin@google.com>
Message-Id: <20231026182231.3369370-1-nasamuffin@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026155459.2234929-1-nasamuffin@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Subject: [PATCH v4 0/2] bugreport: reject positional arguments
From: emilyshaffer@google.com
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Sheik <sahibzone@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Emily Shaffer <nasamuffin@google.com>

The test I cribbed from for the newly added one in patch 2 was still
using test_i18ngrep, and Eric mentioned us not wanting i18ngrep at all
anymore, so I went ahead and cleaned that up as well.

 - Emily

Emily Shaffer (2):
  t0091-bugreport: stop using i18ngrep
  bugreport: reject positional arguments

 builtin/bugreport.c  | 5 +++++
 t/t0091-bugreport.sh | 9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.42.0.820.g83a721a137-goog

