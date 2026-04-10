Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2D6FBF
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775846887; cv=none; b=igFYCOReIU21i3xYimKwjx3sPs9s3iYg6CjcVZa/DGRFk9+YY2zY/fc1rKoK4kmXydhu83Xt46zwMIM9aDgvtPeuOQJx5z06mZBzTHbRbPLHmb6hDlnAM5/m/k9nnqa5c2mY7YIa5UT93TgHuCM/4oFmXmCdHbp2Fr0ldCmAzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775846887; c=relaxed/simple;
	bh=uQP2uI1dgKUuw4MdoQsXhYIQtHtXtUxWkb+QhYw5WKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9GXMuOLecDadi5Iu68QeasTd4d8ck/EfmclMIWlfkmd8EkRc0t1vpiMVUyhP5ZO5402wSNrSbNgN2LyE+6BKGJPEDpGpQC5GbsJ/Ox5iVRbSFUYDB2lB+67OsCwgTjYKfuNXUKIS89nY+QgmF+lDfwz27IhTXQWSOxoivOQdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tpxy59JT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpxy59JT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso2187444e87.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775846885; x=1776451685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQP2uI1dgKUuw4MdoQsXhYIQtHtXtUxWkb+QhYw5WKQ=;
        b=Tpxy59JTGvSQH6GP0aySo9/iXagviKWdZcjL+dTqwi4IrmSAkBpYCagfsMGz4UeaqV
         fQZAYnX5GHLXONRfWWL6zqnoCY25yIKwkWCQFE8lnwgIgIahGjCQqExqUpVqxJN2+P9C
         j0ju9Jhx/KNaIk5O+wva2YVrYD8xaVAm5q1AXez7QO9NUkA5OzhQMLhDHVwcc+be4J0x
         uwTCirx7TF5JX7eXMwxmU4+EVBmIKX4kjg72CgS05e2rhL5epxUqHhuXLvqolk7/oLFG
         d6fYwiHIvCgWpe3/T41VRAQdyQgYHhbknsH2wBJ/Dj++yeVxe0gEyhA0zdzj7D5+nXLU
         UdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775846885; x=1776451685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQP2uI1dgKUuw4MdoQsXhYIQtHtXtUxWkb+QhYw5WKQ=;
        b=BYWJszzoEhcSx2dNZNJR3twZ0qB5U4MADc7zgskLarAp8f27cbaqeF6K+hxFGO9neC
         BOcSx+grBPmX6AJZ5hfPF1KaQGHshVSTPTgPGV5KuDEvQz3/foHFRJJSVV2O3HXF/Tq4
         JEHywjuwucTEQ3RjG0EBkE9b2E8PBXybesvcCQLmzbm2qz64I+bk+dFmOTj5gARGvj1+
         6fF5jjbWqr8fTcHA1Tkw3aobex8PK7EZL7owTF4W+RU2ZJTMUosYy8PpZhYr+nfDT/DF
         gxs6Sl3rc7lhtnhLmE4Wub57fJMcq/22fL/q+F8spDN8RWCSNmhSymHM0QCaXja+7v/m
         Z+Wg==
X-Gm-Message-State: AOJu0YySXJvZn0hF9dVsOvNlE9y/pPAA4DixJAqlXKMIuVYkiPGmFDy+
	L7782A0T40uLDg5AJRcZmRYC/k41tdYLIOawyDuiIxzPPR1wW9ga7bpz
X-Gm-Gg: AeBDievdrq6r64oWWdEavDrT3st9DcnXrbEuaH5JiAjBEgHniBPXRobJxFYjqPJkwjJ
	BltUcTy45GtTLNfsnhrLm+96y0eBZ0GueVuYX1omWVHHt+oCfU2Unob1gUK/q7tD1BgY+YbBcAd
	JdqQmodDXoYz2ti3PfNqNenVtS6Wu+sqnLwKfSyG3AzD9hOIOw2FQ2NquRxsAFtuBRkv0GTSizJ
	Dp9wT2e+f/7SlAdj5DmOUIcX/x/spkcq6QyW8kYJoW/ZUdTQHzGPBo4Ihx72HQee4jLIMJlt8gB
	/LlIp/z6MIAE4tFePMKUk3XI6DomjdCsYzZESQ06p+MfLn/5wOzbOkgkTiWVkSSf7z/gyHNg3wu
	KIClrOZsf5kRi0oG+Z9yJa3l8KZlN3t2Gd1TOe34Rgb3IzkZSKITrHZAz2mJ1ocLiwXo8rAgAjw
	YIAXi7196s4q2rPQqdVZphco6V38VmtbMKtKLGicb/ZiyxS1evT/V+L2dv8cdrXlFSBDj7OHTck
	TVpTFmv7o7ZhlmA
X-Received: by 2002:a05:6512:3b0d:b0:59e:5c8f:a5 with SMTP id 2adb3069b0e04-5a3efb2ddefmr1388048e87.4.1775846884461;
        Fri, 10 Apr 2026 11:48:04 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee865adsm913324e87.1.2026.04.10.11.48.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 11:48:04 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Fri, 10 Apr 2026 20:48:03 +0200
Message-ID: <20260410184803.67039-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqa4vapyf3.fsf@gitster.g>
References: <xmqqa4vapyf3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sorry, I just noticed that these three should have been updated when
> the actual parameters were renamed.

Good point!

I also switched it to prefix naming label_*, which makes more sense to me.


Harald
