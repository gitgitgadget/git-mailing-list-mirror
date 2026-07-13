Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC036997A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982284; cv=none; b=H9Inw/yR/LxcnyyPjk6oJIPGHCJcBjLTHJnQhdAvP/eZY8BjV1QmEB9yCBWYMtJ1Z33TcV9TiwI7XWLatimw7BKRXtIsRPLbph4VMWhlOIm+kTa1ZGKKglkYTe6gF0hhWwOoq+U6BGxLCVZtLF5tt7xKYlzLbuuIJq/eBYA5NK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982284; c=relaxed/simple;
	bh=sUhX/RFLC610lRzJ1yRQMc0iaAu3CIbOsYVQeiRxy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pVytLjpJqMfjK2CQ1B8SFbgrqtYNsdy4ajIPQ6Jl4/oSwYIH9rZw+EkmRE3xKZ4pJVxp6/uuBliwyH6jjs7Nw/FH5JKJFwERabCxgN6pE+SHpNNbv1Oymewg3YG0EtcBtJBquDsNU3s+PaKWhf+tCQrMfb26vguGUm+Bq3nu8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZCH6ZeEV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZCH6ZeEV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ee187d5adso24698785a.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783982282; x=1784587082; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=ZCH6ZeEVOsV9/2XWtQYhGfOSUjuOTOKOtye4unxQ/h0MJave1WpyGhGF54mDAulFXh
         eEFWbPBft08k/Cl1mDTTt2jevkOamxzkJymhcs8eQbmRMQmMg8l8GI5Fbo4XtzKqplaD
         7xyYc4QLD2XRqw7KYoQI1eaqH276wGSOLAKWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982282; x=1784587082;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=p8ES0Aa/xhPffuuz6sBJhYs0lDMjq1mOOlaViGcsL1RrLYGllwlScykf8gsP7h14AU
         Z0Pl0Ctwt38tmljKfHXlFT/fPP8xpOxlNT07FgvBwEOGtF5Om3/MImBQ4M2V87ZN/HLI
         B6cRkX8aWZ+9tCAwmVs93pq1I8F1fubduPWGttefKg/bQZb+ArQa/NQi/HvV+9/nTtPP
         9lsAahdjqlbQqbcE/H5ZTznL8VIkJJDHYpz1s8pas0RKX90CMrFFX9a6P9nuYb03UxyQ
         6dwdDkz83nBI3ffp5wyZiZsQSxIAncUgFDSLIucoazb97im9GvmAb8+U/0G3gqEj7iNx
         tQCg==
X-Gm-Message-State: AOJu0Yx5m8jf+MwZ8DCBaG1Wd9cmRXnGgVR6V1YDB2uvGhBO9UNXKF0W
	O2EhLyYCx1t0Cra/te56IW+XRRO5EujZdCLbwCn2HPh5i+u+yX4xm3OinjhXFnLEN3OIH8R0svY
	sr+eL5xU=
X-Gm-Gg: AfdE7cljDe0loGbtDopgqsRJ6VJnlzNsjRePbJdnt1VGCMICiso4quyIgv9Js1fN6M+
	zsM+DettobO7Dc+H/lLiu/dIGnkRssQZdLM90qrSs7vYBChW6rngxfHL5wsezUMw3AXka+LRz56
	3x/4ujiDhXq2l8j6aZRgOOVourtqgYVpFOs1GxpDPiuuXeB4u+H4jr0zPrNxMzNzn2FTy0IhA94
	oO2xxBKYLMiCa2MBLMb6gZ4TIG5rhuOX7+zjjjm+THfEX/O/lkfRVfccpkZ4LGX+w+SM7D/wGGg
	OJ87LR9fym4GSMujCFHDS+GG/SApj7IYMTeZWpT91mMsjzj2Qdi6lJsUb/IWaYcFou3LPaVrzDV
	XVah+M4olhksuCnTsRdpqHhRuBuKFByT4IxKPtUxDEnwFgic01vfzl3lb5UyvbwQzEP/cU+cAOI
	poGjHUxFaO+zW4P2plDeuvjcxncUYwAMoJGR6TN8dhRceiII21fSz2KWwYUz+p9ujPch8M
X-Received: by 2002:a05:620a:178d:b0:918:588c:d095 with SMTP id af79cd13be357-92ef2c7193emr932828385a.8.1783982282203;
        Mon, 13 Jul 2026 15:38:02 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a0cbsm1244644585a.5.2026.07.13.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:38:01 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:37:58 -0700
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <cover.1783982021.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Packfile URI downloads currently stage a pack at
objects/pack/pack-<hash>.pack.temp. Two Git processes fetching the same
pack into one object database can append to that file concurrently,
which can corrupt the temporary pack or cause a resume request at EOF.

The first patch gives each direct packfile URI download a private
temporary file. Ordinary dumb HTTP pack requests retain their existing
resumable staging behavior. A later packfile URI retry starts a new
download.

The second patch handles the related .keep race. When another process
has already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process.

Each patch adds a regression test for its respective race.

Ted Nyman (2):
  http: use unique tempfiles for packfile URI downloads
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  5 +-
 fetch-pack.c                      | 36 ++++++++-------
 http.c                            | 77 +++++++++++++++++++++----------
 http.h                            |  1 +
 t/t5550-http-fetch-dumb.sh        | 72 ++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh            | 31 +++++++++++++
 6 files changed, 177 insertions(+), 45 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0
