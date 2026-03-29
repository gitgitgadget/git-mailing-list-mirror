Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19455A95E
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759672; cv=none; b=MNC28t4VhX/s02sCrI9yBI8iGD2GZublK/TLBy6JFu9+uZrfnAZ0vZkYmjYmmLv9QWepyZ9YE8ar25BxRZIk4TO+EP9js+zxWpnd+sPjVi6fJWzWqpdNIFq75CSUVVn5JAoGzKrqNjFTvdktUzOqWqSGFkC7Qfr0pTAPYdQtUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759672; c=relaxed/simple;
	bh=64Q7akD4ovnkwIDHP6aPpxFqwBse3so3f7Lzn+0hoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qt3M6HcIBQHPsQ3/xO14GK8ErRwGcHCZWJiNHn5JKGSvG1MyTW/AkAqKnWVNMYFRdA7a4ZEM8cq/a0XnjI0ISccEZyI7NEiT2NxrGCpfQM9cjd47Ytu42A+If9ElRo1b6LPfkpkdo5mGhDNazH05z3toHEVOew0J9ArkMVHczs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvCgDwW+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvCgDwW+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829afe24fb5so2422494b3a.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759670; x=1775364470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64Q7akD4ovnkwIDHP6aPpxFqwBse3so3f7Lzn+0hoeU=;
        b=qvCgDwW+M+x2ndT28oUEshDpweWqrS5PqD8CFM3XgPcJilkMM3YdBUmYNYEVk/McQq
         UTmvOgw6dfx3ALfaepDeNSWkzjMZKMlH6UzKNYdld+xaIdgqHQFqlI2xmYK7dI3CFGvJ
         X8WuI0L8Xq0fU5zRKKh85V+o+dv3zhLjaZnetxK85OEsGEl5791x4GsCpLMgJRV5IZ3T
         l9Jtva3GcsoDxDwh7sqRnCOUCCoFstLFbyvl+Q2a65PREH45VzLVeMxnqx8Nd+uWIkwr
         SQ73ww18kh6jX+FMREBK6ZDi36HODoohQ/NZsSoYRrkJj7QK6gk0KHAKdSYaJydC85dZ
         HU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759670; x=1775364470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64Q7akD4ovnkwIDHP6aPpxFqwBse3so3f7Lzn+0hoeU=;
        b=ncC8CwTChpsp0YEEn7vVH6E0YLwdyQpnLm8PePanySaA2r91cKai1LY+pacWH+S+Op
         pnduassA+nRpbjTNhzEha3/3e1d1XElN0msv7d452n270HrnyR2WNRpS+Bb6xbz6jUDV
         0Gpk0tp2q6Q/78BQe/Li63lNZQYIY5oWe5xD/udmm3kN8hlXtwCxtEkHaMjBIWTMwo6V
         Va134eDNLyvPErSFVy3NOtXAoKHFlSZwlI+fhbAl6Mw4zalcur5GHDjOLM0uQhYmZYn/
         zYQ9AFtCzywiwnbenFSN846pWHFDyzIjNdcls4tdq4lBPbr53xMEM1xrJnYpzC4JRU01
         3C5g==
X-Gm-Message-State: AOJu0YwLhBSc4k6mU0Jb52th59AWcIKfDaiutRZ+1wH9Ei2/26v2owGA
	33xFrDUkyZBTLL+ZeK+HTA0ywmLl4avLMeYadfTWOLWa4OspUo63tHAbieLvppV4
X-Gm-Gg: ATEYQzzXsIOYgMiXr8E5BfTuMKq1D2F0/ewbjoFEPSUyDmli5TWjBZhMtOzYF6hNIYN
	4XuPkdA/CX69Ojjsb6+6xDAmw2fjeJKmcixLS5P8oMRN6mo836jeEusgv3BHiUF1HnmJVsJKeVL
	5fg2GqgHfnP6cBxYsuhthpLPIaz4qHP5CCvfz0sD66724Nc3UB6X0r57tSvflJ2NNxOFCnedfeD
	tLcoBddIL9XvAtWZ99wIOYRXhwsoGK1fDB5Ti8HBYdpGCnp6XP/31/Cn54z+mTHozV27mQurvyu
	DVI1xdFppXMk0x+8MEzr023Ja1u03JSuUs+Gfopmu1RuxBJNo4Uo9T05KNdeFjeLiIyav5xEnTz
	Art56buw/SmEtfwNTv1PBQJR8jJ6bj0NM+PI0LWdG2OUFfUH0IWs6TKT8dlLJ0s564BcNVl5TA3
	c+YGhBh5R4ZK+XxzEFMoIWspO1MN46Y/DVdB9RMboobIxG4EwiyXkYjBM1DmIitY2Do31bbmUZw
	YZGFOOtiQ==
X-Received: by 2002:a05:6a00:909e:b0:829:86a5:d30a with SMTP id d2e1a72fcca58-82c95d3979fmr7396410b3a.16.1774759669815;
        Sat, 28 Mar 2026 21:47:49 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466d89sm3651797b3a.22.2026.03.28.21.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:47:49 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v11 0/8] fsmonitor: add Linux support using inotify
Date: Sat, 28 Mar 2026 22:47:47 -0600
Message-ID: <20260329044748.99269-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqwlyzsmq7.fsf@gitster.g>
References: <xmqqwlyzsmq7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> The topic went totally silent after this message; is this topic
> still viable?

Were you asking me, or Patrick? On my end: yes, very much. I've
been using this across our fleet for months and would love to see
it upstream.

I replied to Patrick on Mar 5 (slowed down, answered the AI
question) and haven't sent a new version since. v11 is identical
to v8.

Happy to do whatever's needed. Just let me know who the ball is
with.

(Also a small process question: I keep getting gitgitgadget emails
about the branch being integrated into "seen" every few days. Is
that just informational, or does it mean something I should act
on?)

Thanks
Paul
