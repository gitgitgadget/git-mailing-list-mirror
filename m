Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5271D432D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345273; cv=none; b=BwoWdnauSWN4Nq8gI+c04MtjQsYl9q7epTis61uE7+Gb5IzNqNZvfzScv/I8Df3c8wSVX6rEj3h0MitGEGh8BqyQrwITcOyKseWHWCYCJunqkeNE0do08sXussZzcIK4qTdnnyinbZoiog1TGujcDl9oncZMbMojhjmavQ5KVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345273; c=relaxed/simple;
	bh=6tXL6YaroLH810HROftp8Jddj2NJTdnCQbosALfqHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B78EWUppgTFsrGwNGP0dyD8AKd+y7KRSPoJSI7cgBQLkWqjto0+mqdBUlHGJAJMCApoS02jnJujMy5uZIalPhL6111PV/u9gUgNohDQoM0OUVoWRqOaWQQtqS91QHsGRLfi1H3ZAOcgyAUEWp+NWXNHM7ZQounUBt5a5P1fS4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIJPi2rt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIJPi2rt"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b79f700a1so300770e87.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768345270; x=1768950070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plH0Mg5fGYz6oaLTN1YYorYmRD7zvWwEtQSWtPIbi6w=;
        b=KIJPi2rtBe623nl9T8M4xBti9FxFauHkq7NXpd0wkIa1Iofd/Kvs3qyNkqZXCep1jl
         0qXbWanFYdVLXec2cb6+YQlCOA51bt0QkoCPZ/R+It51HeAV4fXXPRQkHg0xzKZUxUqs
         UpqI9l2PLruGSiSwKt+EipoG++z+z9iA121eVS53JtaoB/balhekQPXHp+h/uuYuH7hM
         OskouWY01zyEHdJMK8whvAk/sagobpsdwgKOa4Lu6sJiufKEySKKXqrAP1sLmZI1k+q9
         sgVm+97lmZsDsTG14HybUhK+K35FG3Vcg8gKTqNtTz9qfc4j2hhkudH0bJkc3MddqdMB
         1mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768345270; x=1768950070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plH0Mg5fGYz6oaLTN1YYorYmRD7zvWwEtQSWtPIbi6w=;
        b=DBgmXsVUwVzTCjAmvJNpzTl11Pw55UKJEGCCm3ZgWpWTUfFAH/XQaZSUtpa/luM9gG
         eeFTfKwLXtFwsw37KU74N/p6i7ncRVZSS1Mz8Lz9vnzh5/NwAQ6E9TYX26+HEdAoUXIv
         ldbrZeik0h3WATCMyGc/hVG5CFpTFpbYTUVfnRtP5oAcavHU5t9qEkP0xe1m+IfOiZyb
         rRs/7Ih1orHnhqs6DXFetMl5cV8r7yVfRsTU8+8dMlrdhVQQr4QUzcM5NvpcXuCu+/3s
         oR8CbW48sNKiJ+1HGQWnCo7IsCxNd9kmEuMmv25S6gWrLAcxBpNh8cFzKUrRNRmk4g7F
         XIvw==
X-Gm-Message-State: AOJu0YxHbwZIdMgzz7zqKUy5zVgey2Xt3IV1DzJ9i8DmVPqXmPCdRkL2
	kRydTzAnNHYZi1tW3N9ymYbQFg+yiEepNN1kjBTlUv4GzdFh8v5xtocSYbLIBw==
X-Gm-Gg: AY/fxX7anWJza9ny1SKUy88+MdrDW+kv3yVuaUhG5r2Rf8x1LKUugCMOdnBm679Xjo2
	vmRLB12Pf6nMwv0B6IoqKSHNELS/pINyT8g1xXgCqprOcOwa/Fi0Ayyb0aVaCe2Ej1MzSqFRhlU
	NtjAxNU7pCi0kK2DORMPaR5N+Ks0gdbehDYDnnt7hUyrECaIBJPkkEkePbWD/jJ0HhuPaDdbs9i
	W5hmOUg6FZqj6YdsvoMScvPNFV4ao1W6vmA7Tp7LkSOqPPiYfvxMpmppSNB2Zi2KlzjTKaUYXzA
	5N5jjkH96kEJkpgE5Jc3KSsLkqFolXFOPdOzge4TuZK0Qw7wEWvEkJmf1SU7sx98wRiLFvOi8cQ
	LveS/uWaEglXgL8Yq1ObMACllt6Iqj4DpC1kunUn+prBdd3FbvIQaTH/2CQ2jsqp8gL0rgkUYlH
	NsMp8CyIgkmtf36gHVzUnJknigIOPg+H7SpDiIxrAC0S11+oPsYKPQwWrgMk/IW8v7qi1K66Q=
X-Received: by 2002:a05:6512:138f:b0:59b:67cf:ac0c with SMTP id 2adb3069b0e04-59ba0ed7cdbmr164366e87.17.1768345269338;
        Tue, 13 Jan 2026 15:01:09 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba10410c4sm105965e87.66.2026.01.13.15.01.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 15:01:08 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Triangular workflow
Date: Wed, 14 Jan 2026 00:01:07 +0100
Message-ID: <20260113230107.16728-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113214059.GC288857@coredump.intra.peff.net>
References: <20260113214059.GC288857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jeff!

I'm very happy that your responded respectfully despite me basically
saying that you were using Git wrong. It's nice to see how some of the pros
do it!

I'm wondering if since you are scripting this anyway, if you really need a
push branch at all? Can't you just as easily switch to doing this in the
script:

    git config push.default upstream
    git push github jk/some-topic

As a note, before I started working on this feature, I don't realize
that there was such a thing as a push branch (i.e. something different from
the tracking branch). So I had the habit of checking out and pushing like
this:

    git branch --set-upstream-to upstream/master
    git push origin $(git rev-parse --abbrev-ref HEAD)

I worked really well for me. The only issue was missing the status info
from my own branch -- which is why I started writing this feature.


Harald
