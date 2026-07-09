Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068F3F1AD9
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590166; cv=none; b=eRUtfh55yDExt5SIjCay6cOWH1uoQgmko7KPYUTatAvI3F82D96MWRjUrskEYcVKDAsLtDXt/iZvsBcxQ0Ss6NcdHx0afal+vzEua3CqTRsyI9YefgdYhDhh9UzivTIt5pUx6y6eeWWdgziWMHG/86svsGwY8iAM1OXyDX+C2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590166; c=relaxed/simple;
	bh=2aMUP/c7L+IcFYVjrWCT7Eto+3oLJaqjt2RCmEVwB8M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LQU+8HCBRyayoUC0KYExJQUtu6lrm+gZztDbXv7liW50tBVrteWC64UBvy1NLZd/uts/fnv/qPn/SmV485RfJykI4cLSzoYm/rZuAnhzTtfAWIhGJXWwITE4F+3x8lQnsrpGB7OfCdp2MkMT8UCdHzwrwmeA69mykYdQMqPElrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yox41rbc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yox41rbc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d6f35c1so134245185a.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590164; x=1784194964; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y8TAto6JklcDYgB6SJyuSrOBUTCfgum89hXaF87wXR0=;
        b=Yox41rbcsxrM1uhje+7eAK/z4dxkA56xomCs/9QwtRzJ0RX5KEXbdEIfUky875km8k
         pJdwwPm1nZOLSYxG82KIS55eVJrJIqn+/+7iOcDr8h56oO+T63IEjTVkrCXVslAeGPL4
         oWPPGdg/zGfrl2HU7HufoH4rPkeZ8rCgzPFCGiamCC8h7V2dDbzhePyhOszPB3RR5qJc
         yQVjEKt5cc7QSNhg6Zu0TkbHgK8x7aR94fmJmFbYYZFMU+MswQYlDfYzpTbvjy0/BThW
         M3Lliay7iZ3QWsUNZlybKgIuKNyqKlOtxuTfStJoJiMD9Aj6ROhy/HyKFYtmzcGaVCaV
         A8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590164; x=1784194964;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y8TAto6JklcDYgB6SJyuSrOBUTCfgum89hXaF87wXR0=;
        b=EkB4nuD/e5yFiqh7wgrDvw7i1OnrmAUogeqqJn7nSlBUPaEorCNjFvtx75bwj/PtPz
         SXjo588XfKXxagRcDJeZBBhbpO++CrvdomhC67EIWyV3lOmKzp15v3ernTXWyk0qxyde
         psF6ZwvZObfIFLMEdONvaObzPoiccWkKErZPAFTN43knpOJcOpuAXf3OJhrgUl2SkSNp
         TOzOtkNH8fPuVNqCNWbYXxztpiwLWbFwGdPaTVf2Ne7n5dl7+NtoeESUDjJvy1YLAImI
         7r0DmjlUxcYcC2+5tTWriaGC0yeALVs+Yegx9o4aVhLGHyvF3de/n46e83wBXETERKTd
         ORuw==
X-Gm-Message-State: AOJu0YxrtkEy7xBOWBsraKfc2tggJAT8SjEe8obItx9K4yRw76gDBoJf
	spGmMe5qSgg8fY1tSQrP3BdXg20dtW6WhoSTbk7dtyLY/tfbaEs6cWdrJhMo11Ae
X-Gm-Gg: AfdE7cmRNlQVNXtOJdqb2+n+J2QpIFJ9vxj4uvwFF5LIrKHwMRyVMh3oBUyId4UtU5h
	stAq3Ka8WZ02AuRz0CELLzhG03uCIdR55ajDU/kb3evRf9KXO3TfRmh1S3vakpuUJKcCraY2ALN
	OZrlG3ScWAjrTcMqUP6GkISKiX4Eqn8nhlceNtbQrQnoLk8S+UTppPYGXM1u6m6Jf2fVLWONvPQ
	wLMdpPIsRHYrqlwHy2nb/L3JI1jXtwDeXZdF/OvgoNGzgPoD7nc+yqT+A0t89RynPiFoVj8aCxu
	buzrwDxneZSBTslmgWx0D5J6ukemTA1p/60x9LWDrgXCrKOOsmzakto/IsHPWyAxpe5Dv4zPbRt
	AY0311mUeKjPUXBgHMO7XLFr8ZCMnRsl5UYkiK03yJTMe//4vSlUpk3YLcUlMIq16kNoZoacZIt
	ahu6aRuwPAugHW
X-Received: by 2002:a05:620a:890e:b0:914:bd27:2d1 with SMTP id af79cd13be357-92ecf62a061mr716191185a.11.1783590164232;
        Thu, 09 Jul 2026 02:42:44 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800e3sm1577218085a.2.2026.07.09.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:43 -0700 (PDT)
Message-Id: <dcaefc598779123cea19807877e074acb3e1575a.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:30 +0000
Subject: [PATCH 03/11] remote: guard `remote_tracking()` against NULL remote
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `remote_tracking()` function unconditionally dereferences
`remote->fetch` without checking whether remote is NULL.

In practice, this never happens because the only caller (`apply_cas()`)
guards the calls to this function by checking the `use_tracking` and
`use_tracking_for_rest` attributes.

However, it requires quite involved reasoning to reach that conclusion,
and is therefore fragile. Just return -1 ("no tracking ref") when there
is no remote to work with.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/remote.c b/remote.c
index 00723b385e..34d0367f11 100644
--- a/remote.c
+++ b/remote.c
@@ -2681,6 +2681,8 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
+	if (!remote)
+		return -1; /* no remote to look up tracking ref */
 	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
-- 
gitgitgadget

