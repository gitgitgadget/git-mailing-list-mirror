Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB744313535
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981794; cv=none; b=EfEpRNvaXVCTA5RdJT1NduzcOSzplQSh5twEJCPyazOp/MMD0ScqBVJajyYU5MSl7ZxjGe2PMBJO1SRPUq4b8z5eHDqGdKNL+DD2dh8ZocFuuh8/aSGo7nA3WTkWXnzDij7bKWOzaf8wfZTf23h1BHSdpMYk9vFSjwhuuWa0Pzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981794; c=relaxed/simple;
	bh=5L/jCKD6jvRyYkoh42eUIQrJWCdSBv51NdhdxWOxHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSjq3oVEoAI/Gp8b1yXd9AqF/DqHIuwg3bbbTRwrxBo2TYzQjLnvfYeoUDJFN93sZZBlrM/MKcY/4iiKpyYtTj7wXtES8sSpfbr3lSaI/mMuCs3RXn2ZV/3IUWw0duaudHSKGXggqjaDxGzNWmqTtp65xKVOXkyXvQjqjJF2gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niQK2KdN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niQK2KdN"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b76c092acso1949065e87.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767981791; x=1768586591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVmCXyWvG1B0CRcfeIfyDeMOeIltQfjMvUZGRvcrYZw=;
        b=niQK2KdNkF7bOJjDepdenHfsZh6wFBMMjd9LciIkJYACsYRI7keZ23paPxHGb5gCP/
         aJd9wT1KHk6RdP5Xudkzfp27xeWH8Qq9tip51Hom9in7thDX7io+pc1lkR48lG8jUGf9
         1xeC9wxgthOPGNb6M1H0yvgXhJNy4faXDKcomR+UjzdHjWpaHXCEr/NMNhzYWCijpgjW
         +XNCsJHC/yyxgk8D/3oOb0jPGTn04+NFrEHdl2zK4Yhb2Z2uX4utkJXRZiw1UTGrUqjv
         odzoVDTj+o7f0auO7pTf89ot4GCW0jYyB35dWKtR+19RCvHSirhJQMqGh+KrowlYHTAo
         LQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767981791; x=1768586591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVmCXyWvG1B0CRcfeIfyDeMOeIltQfjMvUZGRvcrYZw=;
        b=Wnd3JdqXlD9dwIr7Yc+X21TxePSFKFBRVFcKU1p53abKNuQcC+GizL3yAR7XyBzeIT
         5Ufo2gYFQaCkgGkVbIvzMXk9w5p2Zvj6AhbhC3Qsrv9oer998IjdV1+5bp7m/3FBX/yT
         esY27/wDMgqjTvKjtx05OKJdM0+DBc39A155hKrocW0GFZsmt8vasIfqwjJUlx2wT2wQ
         tIjAUgNSB1VGtWeiOQO4dGgxUcCqh1J+rrvw6ivEqiTyl5DpPxj0R5wuA/wn93GS9yGY
         D6DgsnPVwSfJatb5DldKrHwgcxPGaFsAWrXXOxV+ZJXKoy4r1fUWcYi8sMEcEkWGlcio
         cRIA==
X-Forwarded-Encrypted: i=1; AJvYcCU1jML6hLkA8iwGLIkve9EnvknyG95j+Xt8GA2y6QaBYp75lMrKHwyJtiVqZTo0t/5iOgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82mebT0UNF63XOW1PqJ/R74HuWjJ9siBeZ+bmk5ZGisW0AfgN
	BY3qYb3V2dNMjUP36wILJFQOdVsjMN1wbY3vvdRSilv1CNsvOgeQsF4o
X-Gm-Gg: AY/fxX7s7NfkYH0sIOmQaEie5G81FX4yE0qNGoyy6xoJ8ov0cvj0U5OWlYBPdQPZHIj
	NpRz1O3/le+aAwQfWWZSmK4nAN4CR+LGFwwV4nq9q6eSvy3phOriENrKshMmQYqtn1pT7mwQize
	LWITWgAfloiH/M2Of4S5KVhL/GClQRjqEa6+dYWaNsl/p3gxAi1kdfBZ5R3Qhfe1cFYDTjS1TzR
	CyMhdZJ45c31FaudQefQrzsOWpYkyW3hhKy1fO7aedc/3NWBP+IU0KTn/QQVBQe2wGdzJFwREqI
	tR2cL7rfkSacFB1vemsgIN4CbFCBoasZOEciLA3+DZdJvPK1Y5uKZTJhUpvx4ACAPu1XaWGJspN
	cFbxN302cifGXRfGa8sEW7xB8sTdGFUitgr4YgJMyVJBd1dWUQVLFiLl5A2S7v9obEL9v/cDgY4
	lPs45u+l5U+QivlbV0zab9MZYkh3PXjgRBeD/kNnj67ve+okeAvpXOyY02kx5zOqUHUNequwd6b
	UDCIvJwQg==
X-Google-Smtp-Source: AGHT+IEYhDhYEYca8tK4Didk804y6JaxxUVwrfuCM4p/8kP7lzlkFHyTYXvlnzqRuxVue4yfXN7TAQ==
X-Received: by 2002:a05:6512:a90:b0:598:ee60:8aed with SMTP id 2adb3069b0e04-59b6ef02878mr2938414e87.1.1767981790655;
        Fri, 09 Jan 2026 10:03:10 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b7376b64fsm1796415e87.7.2026.01.09.10.03.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Jan 2026 10:03:10 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ps@pks.im
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Fri,  9 Jan 2026 19:03:09 +0100
Message-ID: <20260109180309.14669-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aWEtp77UB30SbKle@pks.im>
References: <aWEtp77UB30SbKle@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > I think other uses in Git declare a bunch of integer constants for the
> > bitfields, not an enum. Why? Because or-ing flags together creates a
> > value not in the enum…
> 
> We nowadays typically declare the flags as enum, but when accepting the
> bitfield we use `unsigned`.

Good points! I have updated it to remove the name branch_mode_flags now,
define the enums and pass them around as unsigned now. Will be in the next
patch.

Harald
