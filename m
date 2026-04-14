Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF878F2E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197801; cv=none; b=YdGIvMjgWvh9H3hJ08SVKTSvT1a+GjXY3/WsnCpH2BIRPV7YbJ6d0D0QsTurcDl3RG/QwHN+sW4qFIx2Ix81TpQjCTaPqbgYmLQxI1r+g7+BxgdX37Sx4dEJmdhe/fslWOaf3f0URj0i9Turxu94hQZJQYflynpfaJxdmskJGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197801; c=relaxed/simple;
	bh=Eh0JCcPvgQOGQuQAEnEnvXTOu7X4ee7a+n0zOhk1YPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7MmPxLz53CoWMwONpOX5diR4yZ51xpvTHqiYt7BLiD3xpsvJOhR8KreKSIXoslcQb79lERlbRZfUppP8L3AqFtFSVTE+tUiuUFO+DkHJ9qweNtEMQ3llVCDL4K0Tt1CDC2NF7abqlu5ed0YeOVuRDTBl7e845NzDn8hpT2jl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2J6u4nB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2J6u4nB"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so6098289e87.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776197798; x=1776802598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiFsWAqgw3O8CfQtdyv6oEADJ3qhKsj+ebOC+/z6zrs=;
        b=i2J6u4nB/32ECFLWEP7b2KkRaTkOczn4mAvtsftSmWdhH2itm1vzZWkc9jUCPePzCw
         BCjJR53889CVVC8Fn1PSzO/1Yjr6/WZAF00rRDcOV1uQZDGgkUg7DgFS3OrPLWpnTUBl
         U3zNDDo6oKkcMaGtEqd69PouBk+lTBM7WumjJQ7ma4oLJ1ylqJuukOTNqA9syTAnWFEg
         69lpdbppwUhW+fxgRReshOfQWXU+yGXE5boFBOz5xBOS0giYSUv1Wm/pmi6lBk29dQl5
         0bzK0uFSu5t8RLdXzJLWXi17udz/MYTd9uN5+DEnxSui3KN7eOw4tVA+GJpLlssjxSed
         zumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197798; x=1776802598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiFsWAqgw3O8CfQtdyv6oEADJ3qhKsj+ebOC+/z6zrs=;
        b=Q4e3FNXirkbnWeBicZyx+we5qk8FPzL8CXZjcqSz7z9Af+XQKfP9p7HVb8l2Al/5U4
         Ynw1kRNzHcixERh9N+zI44S8H34HegqHqeQZfykhRpvGTpggo0qMZdzOyURf/QU1le3e
         coqpNdLxIZv7DT9bixxzXdap4pxreK6yMeM28WVkM/1GIvAvJoZPA5CWUUWNyV6c4QAw
         WCQ1x8m9D9h8kES54s2RE0Wxvrt6YFpD5fUNhsBzN07bvX38kZaByWp4ZHdyv3HzT55b
         IrfWSXK/CDZY6i0rgqYUV2UfxIxXXbLFWbEMOPyUyOPzG9OJfd+tUtFTT9wrbk2FN3ho
         Ypqw==
X-Forwarded-Encrypted: i=1; AFNElJ+LyQbahYkT5nJD4IG1bNmkJTGdqia8rv99i4zqGPCNGgvLhuIZyT7GzDwqWH1UUoP02JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhH+tXMz7SVB72Kb5GBI3g4aJ2r/dkhw68Fc+cGpm4V8cs9lU
	yd+TPJOYuVfVZhWp/ICMygnkNREScWHcuiiaYmZbZTAe66h9DyIsl4wl
X-Gm-Gg: AeBDiev8ubYRjmbrUYLlgMFAITw/w+TK/ldgltyeVwql4sNdhs+CjoSwHTfn+wDUj8v
	HTWiqsJAE2xrzfmauSgPolLL/NPIo7wyQ6PrNtmarAt0OdvTYgHOrATOW5zZVHvjhyJijwMFMUq
	UDu6KyIgJHOLjYiVotEyd5ac2qBwccdMPkhBfVATEHN3ZLzaz1hCFQyIUDHvw6M06ko7DJ5K6xD
	Yke4moH4Qgu5sBQl6VPP7h8rVw8JmeynnOKsNb5YEiB2pZFZ5JERPugx33lqmI2AhGUH1tVPkFh
	mYNgAut0nDkGE/YRNpE3vtn0mUOqDN35Kst90hMtJswuhMVVipC9GSytiyDSIMDpRak/JposxF6
	P3iyJiVLtQ/QKaF7iv7D5Vq3qhwRhnyxN/cntK5hbKKGho5894nceb6Z/GPHHSFmuhwI4rWyJDx
	SuwUpmlASljvNVKeuOWNkB6ulIoBlCizTYMtjFhvYYetIZhHZDjyXiFY68ZiLlkH8WgBIT1H+7p
	sFG0pVhSuKerJ+cI65oTRZ90J4=
X-Received: by 2002:a05:6512:3d88:b0:5a2:b4c3:d88c with SMTP id 2adb3069b0e04-5a3efb43b47mr6858245e87.15.1776197797820;
        Tue, 14 Apr 2026 13:16:37 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eee8d9e4sm3509392e87.27.2026.04.14.13.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 13:16:37 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 22:16:36 +0200
Message-ID: <20260414201636.51956-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <xmqqfr4xcz7s.fsf@gitster.g>
References: <xmqqfr4xcz7s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>    The description of the Pull Request will be used as cover
>    letter, ...
>
> so perhaps your pull-request comment should have something more than
> just the list of CC: recipients?

I'll give it a try!


Harald
