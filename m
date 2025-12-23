Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C572E03EC
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485467; cv=none; b=J8adV5ygbbExiickhAUBUGjkbDmCCPx0QLh56yKrxNt7lSx6CxkdPKBjpr5hPNBOVQ7Tnt44DLmehrel+AJhJJ7U/pIC+hVcq+hXoG9W11axEkMEhxifxOM7aOF4Qahz0PnT91EAb2+49yjLEjkXOHsTV60/xiCfTxEz2Ffdi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485467; c=relaxed/simple;
	bh=N1gs+vBrRtQcEqb9vh17pmcEKjouFmRNGukbIj+BAlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T329pLVbDijSlN/WqwjP2FnOjfyAGRLog7NcQeUN5BDikvPKjpBMpc164IUL6QxVsCUPrLo85UQNw9Gj0sO3QLKwc1yAd+2xrkeHlsjylKyOJKyYNDiuj2m424UW2841Hw5NWpKhBDVKp8w0i5kruSRFX16wmuxEPWAGZ4Jyahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih6R3RV8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6R3RV8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a2dced861so57559271fa.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766485464; x=1767090264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vArvQ5o/9lopa5tcacx/U2aoSi3H1kkb+xtRQ0Bk7JM=;
        b=ih6R3RV8L28uflLtYY5IbMcOgtp3PQRNYl3lgK6TBgDTREDYQUWg5K3bCeW+o6Mxsq
         b81poZozAQGdcpBm8PoSPtpTl9J82TWLgRPX+os97loXQR2Af04SEmiL/xTddpe8eYuZ
         7T1BjVqdV45AZbXmK1DmmZRA8mxWCiJLqhDWbbWlw7YZe2mMQ2EEqThayp0o4bu7y24d
         unEzkwCkBZZNtKHkCvZgcG4MiCQKKHh92DiM6Eh9i9/behw28A+xH1gd64VzUFrgCx8K
         FO/sIun+ljD2g8oQn8Kk9zKe7WMR1tS1VsS/K1bOOBVCgka6tN/WGvz5y9dQ7qLiVzA6
         /UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485464; x=1767090264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vArvQ5o/9lopa5tcacx/U2aoSi3H1kkb+xtRQ0Bk7JM=;
        b=kOnC76eDXNb6dMN4kHbKEjrdUuZ3FufDDypc7ZP0+tgxIT2hYOOvKEnZ8xUv4hrTiZ
         mHXgvksH2tye/avZmTxQUoRFVfKGlBSyqqgsom1aOtwR6S7gaXgWeAYW+RtoGpd/ClDq
         5/6PBR57BF1uPOqMeHDcD33O09wSbkQs0r2H+qXS7LFeHfsoO59BCAuGcGtXPf5qDHcY
         UcMzVvd48UQMi9HslmsNZeJ9viZfNOZqlABnYnpdVcUGq8bo6w3qtBYgSNu6bxHHScM8
         Y+6tI7CXdwooRj5h9x7/jHnAIosi+qD8CmgF/OaVluTTYoJl9lZrtPwCNBy7IVxmiJla
         GEfQ==
X-Gm-Message-State: AOJu0Yxh0jA2xAyfuJ9NB8+zxT4Z/NR/1RyrBEKm7VAgrmlNQgQOeDIZ
	LNL3JAo2YJpBMjACAiAUeRQcUFUhf5ssJRNBC+gU5h6WwE4LWz5btDQ7
X-Gm-Gg: AY/fxX4iF/dSeLdX0gapQ4ItdC8t0rZ7BSpJZme1nBsZKYbMYeS8JZvGiCkKAiAGH9S
	feen5FyFyFgEabJSPW46Zn8TtDneFtkUH0xJegqsWO1tq8oNwUXlkkrJwS/7HMhuG21kFM16MDb
	dkrLVzCTyIecJyslo6AOj1SeJAJ6Qpd03TFfRAPAgcCFsDVRYlI7Q5qj1TXNkSL734W2UOWOjPu
	bA4rTm6EHPRXSQMyT4o4DZIan/JDxH6Cbxyse8YSdeGY5yO3J7FozRnI8HT9kz9exfhfxFb7clX
	ZPurDsWdmU0zaz8Ll2W02hgjxB+N52W0Ug8h4w2Yx7b8T6xMpddK55N/GI7GYl7/Rh6/fxf3/AE
	OzzBZh6shKU6YxeAGYaxI3iSknfjCS0j3fdOwLEMMr8ZoNOI8LWRCQR2SB6ot/cKpISa33SW4T0
	tnVPa2o1t6QOiwyc/+iTlowNEDaMkBMx4xgsayGorXwazROp0GuADdg8fRV9lNSfOGjnufqG4=
X-Google-Smtp-Source: AGHT+IFcRO0WUTzTYf4kK94xMe4rrB45HXzHi8akUd+v7+42FuJQ7cP8qE97nHGieuA/l5W4yyWuNg==
X-Received: by 2002:a2e:a986:0:b0:37a:2c13:87c1 with SMTP id 38308e7fff4ca-381207762e2mr47919741fa.4.1766485463386;
        Tue, 23 Dec 2025 02:24:23 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-381224ffc47sm31628731fa.11.2025.12.23.02.24.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 02:24:23 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Tue, 23 Dec 2025 11:24:22 +0100
Message-Id: <20251223102422.36853-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqy0mtpxti.fsf@gitster.g>
References: <xmqqy0mtpxti.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In other words, exactly the same way as what we show with the
> tracking branch?
> 
> The triangular workflow involves two remote things.  One is where
> you pull from to catch up.  After building on top, you push to
> somewhere else to publish your work.  This may be a different branch
> in the same repository you pull from, or a branch in a completely
> different repository.  What you pushed out may be processed by
> others and may come back in the branch you pull from eventually to
> complete the triangle.
> 
> In such a triangular workflow, comparison with these two remote
> things may be needed. One with the branch you forked your work from
> to know how much work _other_ people added to the branch to learn
> when to start thinking about catching up, and with the branch you
> are pushing your work to to know how much work you are holding
> locally without pushing out.

Yes, it's the same as when tracking master/main, but with far less complexity for the end-user. For many years I have had the habit of running these on my feature branches:

	git checkout -b feature_branch
	git branch --set-upstream-to origin/$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

	# To merge in other's code early
	git pull --rebase origin $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

	# To push to correct branch, because I'm tracking default instead "feature_branch"
	git push origin $(git rev-parse --abbrev-ref HEAD)

I have found this very hard to explain the benefits of this to other developers. Git is already scary to many, they are afraid of losing work, so they would rather not mess with the tracking branches and break the regular "git push" functionality.

For me, I feel blind of I can't see how my branch compares the master/main at all times.

> I am not sure what you mean by the word "default" here, though.
> 
> You seem to be using the "what would a new user get when they clone
> the remote (by virtue of their HEAD pointing at that branch)", but
> I am not sure if that is a good way to determine the other remote
> thing to compare with.
>
> Even if one remote branch you pull from (but not push to) has a name
> that is not one of those usual ones like 'main', 'master', 'trunk',
> 'default'

Agreed, this should be as agnostic as possible. "Default" might be me using GitHub terminology. However, it seems that 'git symbolic-ref refs/remotes/upstream/HEAD' always produces the desires result, so for the sake of discussion we can call it "upstream/HEAD" instead of "default".

Harald
