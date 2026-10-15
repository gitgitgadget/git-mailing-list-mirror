Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FE522F1A
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071389; cv=none; b=AuB4HqwQr5L/Te3AESM/DRPzJwfqj3mFQTSwAkafD1VYU11jyYX7gX4XuJiOCx4c34RcwKDEWhoHrOpBwmpfWiKKOTga0g9SWmMZJUni7tSJLUUegRHinHR/A6vekfYgEdLgA32nMeVO6hwnjagJkE3NIv1n4DueexFgZUNAanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071389; c=relaxed/simple;
	bh=uYelQOWaxfk2IGGof26JjkR2kV9+4SdZukKFB+DdtKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXX5Gm4yd0SOX3EBaCvMrB8FNU1QvCGNPlKI9ySTMS97q9cdwndm13Gg8Oe+ZcoLZyPwiFHVyMlPlDaZr3PcYLfAB0gL3U5bteKJ4lWdvdr5NHW0wsgcyaa/4plGTEu9z92TLXVAD384RhegEDIfjYa5pV06po3uO93+DMJf1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLuYVM0s; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLuYVM0s"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso88302266b.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792071386; x=1792676186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ya0rjeDttaLs9MRXsQdrTywO+x4r0boWkNkyTSCWB7g=;
        b=oLuYVM0szSKpOBQ8wIDYkqtczOpVS2Us0Ger6jbQedRsuUi47uO6xnbRrv1v0AKT2x
         oa8AjHFSmIEJK1ArwH5sManvDnIWMxO/u/zQe4QjaP+yuAaiUnXeM6yy+cjz7jrtrbtN
         wv4nQ5samJo0yU1IpXb7i/p4SsXJK8PqTBLfVo+B89b6N98Grga6EZsNMVv58o3s7KpF
         SmyV05/zq0YPgl+LPJuV0AIPT9ud3t7XDVdF32g1NFHRv9xKvSHjV0QBI684YQBbEhjc
         UGoTMakkKp7QKeVLX46tFCyY5hemEVWNi6f6uzI5P8lqw8oW0UQmgF/BhBj/wb6lZvUn
         Safw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071386; x=1792676186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ya0rjeDttaLs9MRXsQdrTywO+x4r0boWkNkyTSCWB7g=;
        b=Poy18xO3hKFfebv9aZ6U549a1fnOcstadlwLmRM3JGwAfLr/Es3JLZRKbnJDVA6Y0X
         mAGHC2Fqk+6b5u0kUtDJv3s1EvtY5dHIEH9Dyh0jXlWIEBlhvikZiZY/LrJ5YlkvLxWh
         mVpyaevRwXhu3BGVwZKWxT1vw+GvqAX/DDv0ThT/2aLAH0WoYTuNbIMevuj05CdU/a+e
         0bsteG2YK2Rlv3IIfOWcwhQxe1DTGZOGhF3f9o47OD4+4dQHArQzWCM2EubxpcXcdlav
         BfJUgltth17Ve+38PdHEuPzuTGU4es2SMt2048K1oS29jGcyKktcEXQFH8NwhJHffgSR
         5nxg==
X-Gm-Message-State: AFq9FYKldW3T5zR9m5easPFNLFp4tFnGI6l1xKzaWil5vdZwqx8IGlwL
	u1SPaQwElYnXmTmIgTurSRfimSJR99DIzsvxRxgNasxLd0zaggntbNzB
X-Gm-Gg: AYBFou0Ls030w3hLYU06mZnwK2LCNQdUaQdPzOS4jrBKPHHfnPAhVE+/bHjyB8YrXJi
	EmCnLvvsiNvjVD5d52EPWM9NZr6LDr3KMi/TPLAoani/wVWzNX0aUz8rX3OAQYBCZ6WRWSfJqS6
	hQ1JVHIa6tvikoXm8J2tuw9NoJi/6PAPl1/uGrcxDWl9+5+A+y2Q7P03Cv3QzKBre9A6UE9iVtM
	O5SHW0o9aiwrd9wVSH32KEz1yU0idc/csJaxcWuMBXhQlqHAI9WeFVwlYPNyMtsWw79dWM+Ed37
	tEJB2KWsv9WvAO7/nFAEpzfTTy3Ub7BwCEzdB3mSpib5JlncXgspDCkOg4duxGZclfrKzOOn90M
	4+BiEOMXG+5D7Swo6HEJ4gdK5DvO7Ht0aBqvVnTEv+qqtPcEJ61HZUrC69Cku7t+zrNYewscMpP
	yLazWrU6NVTAq+g3b+m+gNuHhKpyra3vEIRyT/TTh6oxIIpomzbrKrOWc+R50ShhtLaYXLdNSo4
	DRSQcw86qkIXCo/DjfR+gJ4ja7E2HssqizExTFHEeQyD/osHA7gwlRtw9GSQC65BRzY
X-Received: by 2002:a17:907:7210:b0:c2e:3124:2394 with SMTP id a640c23a62f3a-c31a9fb6cb1mr1780575666b.41.1792071385955;
        Thu, 15 Oct 2026 06:36:25 -0700 (PDT)
Received: from Haralds-Air.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed6be6536sm126275966b.1.2026.10.15.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:36:25 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com,
	mail2venkat21@gmail.com,
	ps@pks.im
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
Date: Thu, 15 Oct 2026 15:36:23 +0200
Message-ID: <20261015133624.82112-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.56.0.119.g4efe74b04e
In-Reply-To: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The general idea looks sound.

> +			if test "$storage" = mixed
> +			then
> +				git pack-refs --all || return 1
> +			fi &&

I don't see any reason why a test would need an if block, we know what data we
expect, no?


Harald
