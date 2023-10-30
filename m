Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BDB199C8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1/MC8WOh"
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE25CC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:10:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a82f176860so44246057b3.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698689440; x=1699294240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9wSiqwjLk8G7pavs4mWUe6VWulecGYAyl6W5Jyir4M=;
        b=1/MC8WOhm26CAQtOFS6QDmS05cmQb0KDn+vUSrhloJbtYWxnv5cYjr9tVZpW/q/jCf
         0W5yqlOH+49BI71BEXC5PexDAQU71dclQI9XqYnYmiiQzt3A1GwWGexuSJRjOKkDo6fz
         ti3kl22Pj5qF9k7A+84C6FUPR4RgS8Pi2t0QsNejrOmj4rT92tHm/8Xe0X6bauqhFMWl
         X3gcB7nkVL4R0pvDWeP3JLE7zRAQkYGykQZZOc8O4G90msoyYB0dKJ0XjdCkOKvyBvLO
         VoZ/lTb0UJACJcX8PHiCIBHJ0MvJSvQwcrwWwIS10E6fk6ZtUn2K933hyF+paFUQf5Lj
         KrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689440; x=1699294240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9wSiqwjLk8G7pavs4mWUe6VWulecGYAyl6W5Jyir4M=;
        b=DEhuA9iUKvod8yR9hglXxuRe8eTCiAMv4o54gpZ/guLbb8eRWMYDKE1v4CR8VhBhgF
         5QwBT90rEIOwI7p9m05+pAwZBHI9uVRmTFZKqRZj7ESQNmwfVBQSv7+qrCejV5mLayCm
         GNjJyOSgkxnlAyeJXM08kHLOPyOy8KbOZPFTu9FiJ0xtNe3WH9EjeC2xCKAnoouGvwmf
         zK29Vzgva6d1Y8mqRANMFbGepKmq004Cx/prtx+hOTbQzYNuyM0qIfPfuHLmGciAyoUy
         yLYU2epBlskLEuBKE0PIjnYAp5TZkkfcDaM4eMep1WpEkpIJYzgyJhLBzL2K5PgwRD6Q
         H3Yw==
X-Gm-Message-State: AOJu0YyvA2RSlH95ZyVh01NWaA0mTQF8CXvSva/DM2+naYOPdgtvQFZq
	DcWUOK02D4elQPwFOoPtHg8UBpOvNFAPQKdmqBuNhQ==
X-Google-Smtp-Source: AGHT+IFUWxsGOL6IErOkdWtsQ4omo27LbJLr3qNBpoRHjwyWyyv4nhEnmPsb0ryhzHLZKIN6In2Syg==
X-Received: by 2002:a81:d308:0:b0:5a8:60ad:39a4 with SMTP id y8-20020a81d308000000b005a860ad39a4mr10000423ywi.3.1698689439912;
        Mon, 30 Oct 2023 11:10:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d140-20020a0ddb92000000b0059bd8447721sm4594131ywe.21.2023.10.30.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:10:39 -0700 (PDT)
Date: Mon, 30 Oct 2023 14:10:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 03/12] builtin/show-ref: fix leaking string buffer
Message-ID: <ZT/xnsoAs5cK+bsU@nand.local>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <bb0d656a0b40b79c90dc2505239976a93f18f432.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb0d656a0b40b79c90dc2505239976a93f18f432.1698314128.git.ps@pks.im>

On Thu, Oct 26, 2023 at 11:56:29AM +0200, Patrick Steinhardt wrote:
> Fix a leaking string buffer in `git show-ref --exclude-existing`. While
> the buffer is technically not leaking because its variable is declared
> as static, there is no inherent reason why it should be.

Well spotted and fixed. I ran the test suite in GIT_TEST_PASSING_SANITIZE_LEAK's
"check" mode and didn't find anything that was made leak-free by this
patch not already marked as such. So this (and the rest of the series up
to this point) LGTM.

Thanks,
Taylor
