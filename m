Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D3395257
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333961; cv=none; b=QKyA97whAT41SDjkA67yfk/9Zx0Q3uLfI6Os5W7dL4dwb/sI3v2PqFwsrVS3wbNgFXXForNwytM82RZ9Jf6rD/x5qmix5wZZu+IB4ymq2j4bk/hY5dNrcndFwBjMfHYgjjBLoAIewJi24g0oHOjB4AoHXwhPkTZjw/Jq66Gx1QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333961; c=relaxed/simple;
	bh=IDnvwqEs5oj+Bo3RjI5GS8IJpl9CNfQUmkaoe6Vg8sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy3DOQrElgaUvpGEnzBvI3XlZa/qQp5DMElOBSnZ2KwP3rXYi7lc5PFQ3ebCCkEN9OK1RF7TTHX1QXOP3HhPITgXCJTiTS4Iuv9MMIA3iohkwM7eRtmQHK4nizdbM1swfCHq+fSnWn484Tbhr+/LFq2VsJiZNN57umESr8wkj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlJPn5N7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlJPn5N7"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e68e4389cso51702041fa.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776333958; x=1776938758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDhq5dSclHa2EMussik7LliMfMEassB2txOnb9PUC+E=;
        b=dlJPn5N7vto0bpIFuIQPAnUfQbyFdmIYDkRWNVwiMINfgWOCPocJo7QjS8AdGEJTyf
         2eQSCCJrhUri2wOXjVvs05wYnX2+QdW0swflF2STZ5KlET53/VGhwa4oigwsTJ4Iu9Rk
         pcTdBrxcL9r8e5xjg39/oqTJauzPoNfwtzQpa7/mu4EBcakIvyzAYkh8+snjdmwQ9eoI
         2QtNkzosFMmax7fPH0GLIUTZck+QuhznlgOoRepntKEQYMFo3w+nIiU3kmixofLD79Eb
         H/GEOMaXrW0aSH9S6GxGYfj7VW4AZSyC+Wp+xzA+d/ZoeSCrVcN8i7kx4AS9oD0mSTTe
         v9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776333958; x=1776938758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDhq5dSclHa2EMussik7LliMfMEassB2txOnb9PUC+E=;
        b=lBHXK0+W7HC0l8+5hkvSY2k2tkb2k+HrcEgbfxxFzLTXSsgzl9JSR5/4jpqS2qV+Vb
         Na3S6hxvmmvrPQX0yum7PbL8T7Sx/U7f/vJdrz5wXLsxSNNO6zkVC6EniLq0pFXIFF2y
         MnwQ4yNB1JxEL1WuhiXz290N+fK+mmmw2PVFlZ2tDLQl3YOfPLXstrFq0LoGl1Kx8wmn
         XGrCriQjGK+tQFD3s8WWlUeHfnqzLlzcregryaV94rYfocTtXOHxCEHgeTTE432ypT1i
         y0kbkAXmUZzW0ZOGoIPiyMPkSdAnWctBhT+TuH0exvU0dAMWaps+ulpHNS3Rl2+qFYWI
         i5pQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vqlZkP/OjeR188QNpBkmlerXKaAVcKwCdNAscru7Gn0GThom6TfbelIRQbHjebfA4sYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxstrSoGvCih7PtoNvSmv+MFL/7klgyrMmcUhzHfb0tCSVSQ8u
	AMqKSnqD9oxoCnqpShaGmNZPP+fkXbWPEkg3yv5yf6Io7E2RMEg7Q5nS
X-Gm-Gg: AeBDievKpJUe1paHbpdvkqy56Gh8KUUKmEROAuRfmlrzSHIsrOW4WcxTs3opG0OmSeU
	uSnXbPmxSUOSTGWZYkKwyUSATdWMqtgYd1sbmuKXv7YCEHkLXU6K6MjBFnQI4xcq9lIXyTPDmWW
	L9vfzm0WBRJ2bNjXoVo3SdUWRU8li0mf8WCybcNIeepj9capFHS1o6OSTeO7ruc6w7F3Cjksqsm
	qILg1qyjd8Nlbd6pTfwUVlbO8ET5237KS37kZxvp99yWGuCSmRpoFYicjcj+puMUQJgfla7WoRF
	J8BN0RPmDNJRvyqmIW9QpnT5hezgmsN4hfESoRZCN28RZkDazocWf28jrTSyEYojscJ5beZKCoz
	4VAjTXYcgk6LtPnFhhCa0WFhyVdfncOXcI7GplSTnoIl3hNpdd+MlSMdayA+T4FkNmOjuyj2/Je
	RiEH4+tKT2ezHabwoBviJ3u34IQ03mmh/6xEBL3z65GC72OR9mfE2q8rHRw99qx2cAN10TvK9NP
	azkp6O/c7JzU/LwQ7gqz0I4yYzT6tZSUYXPBg==
X-Received: by 2002:a05:6512:39d0:b0:5a4:b18:427c with SMTP id 2adb3069b0e04-5a40b184b1dmr1713259e87.9.1776333958054;
        Thu, 16 Apr 2026 03:05:58 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a308521sm1169156e87.74.2026.04.16.03.05.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 03:05:57 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu, 16 Apr 2026 12:05:56 +0200
Message-ID: <20260416100556.27823-1-haraldnordgren@gmail.com>
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

> It shows 350+ lines of range-diff to show mostly irrelevant noise,
> when the true difference between v11 and v12 is only that two helper
> functions create_autostash_ref_silent{,_with_msg}() are merged into
> one create_autostash_ref_with_msg_silent() helper function.
> 
> It is much easier to read that read from the diff between the
> results of applying v11 and v12 on the same base commit, which is a
> mere 55 lines (shown at the end).
> 
> I would not expect you to teach GGG to produce a better range-diff
> or add an option to instead show an interdiff, but doesn't GGG
> already have a way to add some human-written comment

I will work on my cover letters, that's a very fair point.

I do think there is some possibility to handle this via maybe a new
option 'git range-diff --rebase', or directly via GitGitGadget. This would
automatically create a diff with only the files actually changed, which
saves both author's and reviewer's time.

Perhaps this: https://github.com/gitgitgadget/gitgitgadget/pull/2212


Harald
