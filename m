Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EF331214
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143567; cv=none; b=ExKZh+gGjo0o/5FvnrUZGpA7XBLtLZ5ehihneVimTiKwO90kWxM+xJN0a9gULSNE4BBctX+5utdNng3n85JLoALyBrP0ARbGzCiXNB3HqVv7hSHU5pOO+8SRXWju1ZTEtsETdN13nHVxTUxB23gJDBQUfihP7GO+yGjZvFrMeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143567; c=relaxed/simple;
	bh=MmICx3TcPsiQKT0HSDPGcmISCL1mWecZmGQMKOvBXf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBRVpfCspRI840h/YKOjKXN/ZvLsCNlMdk7wd9BlasZ3gopM+CvBguWfJuCH5O++Skg9afw3gd9lRfUuEnfY10hHWfAYB0R/92IDcFuKnPODN3iyuOGc2iVCtS9UZxpWTUfcaxLxQG3jZ+Kvb7QHdESM01VN3UFU+VXiRInXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsTL/+/d; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsTL/+/d"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70c38515d3so12852a12.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775143565; x=1775748365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmICx3TcPsiQKT0HSDPGcmISCL1mWecZmGQMKOvBXf0=;
        b=MsTL/+/dwkyvVEUrMcQ7mMGvnh7C/iHJE8Gz2OtKk7R94RSC6XRQnMg01aMvqNhYMD
         kypBoWJ57YKKPUT4A8vnSnYNED+8R2LmWlDn+nkP44TozoZAzsgQcZq3iEQkeCguSKV6
         bPJsGk8jAnMTLp+QWU5bOTK81ACUAHTXS7J7Ht2r6q56gYDx73C3HYvlbTJWFL0rIXFR
         3LV+zC3OTes0A9O7mhf4ZYLjVhlcqEeXMOo2i9bwAOSzPLIbS32Jkibt0mDOIud54PV/
         2gHZXmHs3Cezih/AKg97ejI74HLzX1e5tGfkZ4hHBzgxAwZ2Hb/eDVGm1YNc9xAjbGh3
         pS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775143565; x=1775748365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MmICx3TcPsiQKT0HSDPGcmISCL1mWecZmGQMKOvBXf0=;
        b=I99J1QFuaUaEhGQ/PvresCzHzvfMlcq52w4A7roZLGEyxCwlu+fhmw0BHIpz/+ZAdp
         1wejsFeaCbjvXzM9aUaM7/Z4oHWxauqlGAJAggpHh04v1GOrA3tu1i/7UVaRNyOCIZOE
         B3uixxGFeUWvr9gGP9OGwHZo3PYKDZGMuN5KJaWZ+PbaZKaYvrjxl9UNzTlWcsDQ4qZw
         7o5HZpo3Kf44eAhbgDuA8exh+/TbDwfgRUMoZk8A7vXRMFv4AsaBN498jeTIQJVfvrts
         gIVGtEXswKTitt7ti7C8aTLBTZYUsm/NjmnvZvPXCmzBuYszOCAIUYTYwzdIWvGBIxCu
         62/w==
X-Gm-Message-State: AOJu0Yw3jnntmwXSXuZ4a8J2GKdAu+x0tBVhLgh/4tVd2mWpGa8YzzqL
	X2M6keIUYT7fbK75UsjRVISe/BrNe9bCZiUboT/L9coGuO6ahGye7By4
X-Gm-Gg: ATEYQzxluEErhO8qFG6OS7evzSXee5lrEiXBPm24XE3X9rh8SIh1ujsbmNmeBJND16V
	WSPfQw8t2P8ecTHS0VRjBzAJdIyxWQ8ywQPh1k8LcO1mvgevJOLoEFxOYt/8Eoam5u0k9HEeOZn
	EXqsIDNI+qoh0U2tlW2i8H8Ixy0zfboSZ2Xktc9uPnarIfGyRnLrTIBYkLdHyD/rIiztwoMwnpy
	dQOk/x6m4+NDkusuqeNgjRerjXtWoLfIaX7FitJ8CiB+l3zQOoWLI5JYUcDKWO608wihcxm5Gom
	q7OXXSGVzw6fc6FD2KaaBDB4xXsGoTR4P2w86DCZqlxQ2ICUPRO0XpdkaCzPzjRPCeF2Ga8yl6k
	qcE/1q3Ad6oWT/PgpPgbDhrqBmdDqv/GwWZKxoi1MXn3eYHN3NKChLtAYkQXC5ZsbjjCi15wxNL
	0Edi1yTtYlHFfss+8I5MGMMRBO1F7aCR2DE1OsVgTYvfAFA/9au15F4nqAh8KPhV65G5gJ
X-Received: by 2002:aa7:9065:0:b0:82c:a221:33c2 with SMTP id d2e1a72fcca58-82ce86bfa15mr5215404b3a.0.1775143565199;
        Thu, 02 Apr 2026 08:26:05 -0700 (PDT)
Received: from JAYESH.localdomain ([157.51.119.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3d439sm3460962b3a.35.2026.04.02.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:26:04 -0700 (PDT)
From: Jayesh Daga <jayeshdaga99@gmail.com>
To: stolee@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	jayeshdaga99@gmail.com
Subject: Re: [PATCH] read-cache: use istate->repo for trace2 logging
Date: Thu,  2 Apr 2026 15:25:33 +0000
Message-ID: <20260402152533.964-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fbf03f6a-c746-4b6b-81fb-f3eb4b2e2f0e@gmail.com>
References: <fbf03f6a-c746-4b6b-81fb-f3eb4b2e2f0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Derrick,

Thanks for the review and for taking the time to look at this.

Appreciate it!

Thanks,
Jayesh
