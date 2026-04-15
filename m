Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7D3A5E64
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259580; cv=none; b=VzkZYqjO8Ga/WFfNpjpC+pmzSyaBiU7M/kIzyyKJFV72ou0I18kPR0yLegaP5yC79tvimqLDq/yRNIWzNWFmK29ZqW7mRPp423iGsH03VilmOQZTUJdaDQtriC78lkaVu+EgC63JSTYJNwu96qYFHFwlKLPrEHkwWq44NjchRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259580; c=relaxed/simple;
	bh=8JeJbH9C+BY9k2KwcZAZUdHvN7Q3qlG11Tu5DT9eJu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9BSa93j2q/5QmAiWu0Qf7P57UXR7x6Vwo8q2KYTQVDv2xO86kgDIY5m5UeYdBNdnz4GfOXjSK3jeYdEumc/uMcyhCQWNQgHMcxZMkl4tckQOH6Y+0sCmabOSzEXheuEIRODXrCUQMPZ3SDxjempIiWj1eizHKxbbsVo1ZysyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhwX4yvg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhwX4yvg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad4d639db3so35307025ad.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259577; x=1776864377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XajuCgpr9WGMS5zPg1avRImN3lx5ayzvnVezIOtZZzs=;
        b=IhwX4yvgrWYhfNFgWuENrRxg++Ls7qctWNGXGT4pB0ysfpAJ4j9hPZiXPhppOTkpsB
         pggy2n0BJNsTjhasD5Nu7A+vHKw+qsPwb90Lfkh8hEGw2z/Mte/ZFb6NxkWRAMw8CDxL
         3Q1e0pLp+goRDt/Sa8GauNuWOtM6D1ONyNDZ0r56lzqPLUA9zxI/DlFm9O8xyJtuumkl
         xyuoLUACJpztFDCWydcseaE72qjA3kF5hnNPvNyWxwI8ObhAvWMcAisTLJ0Q3PfVDnRv
         X2nZdMk3w5myxip46kkd++n7Us9d0kWgh5K7LwnW7OjXAzbXP6wKGUTc0Ik6RGkMzzqX
         JKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259577; x=1776864377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XajuCgpr9WGMS5zPg1avRImN3lx5ayzvnVezIOtZZzs=;
        b=BHoRArAzCqjeLdUWaPiamDQ6phHSDJzABsWBKFBJApk8SmRczMhPanJvwdFiTakuld
         ckK+/QOEqZoPZ6tTdl//tgJ499tl/tAQsr3mOYwjcCj+Moumdp2BxHkP8vpAUtBYNdwX
         Xw/suksj6RfoXzYdBN4UyRV72iNBgr6U25Ix2Tm3PioX+neRoOwbtoorCTBmeqvEN6fR
         VKc+TOtDlZyDzQX4UpcMna9n7H+TMZMGZGadZpbzJvYZmHGm1I31Ymlb2sHGmL3GtBdH
         TJKf3t5bBo74aV3CgDbk0bGs4lP/S7DnsSr945kdpTitXa+CPvabp3AyaBgNRg9Nly20
         swsQ==
X-Gm-Message-State: AOJu0YxWZ7PI7UG8OTYN0H8WVsw4cKmwyvkg2mkr3jvfhwxxfElD3ERn
	rTWf0ZdWUfl49W8hVsXiHQLbcI7zGSkUqXIqD8LF+obvpml30Zy7liBJt+tB5O12
X-Gm-Gg: AeBDietyONey4L/yb4jkRf6x7mMnpZdYkf4mzd5ug3DEbbSJTyyH6ZqqBuSRKbJgLUN
	X0yYx4sEf2R2u48FuqtQ5rzqTuXLMBL31pgSUqNTgPfOT1WeY6JUrNMzOfW+OPZxAE9fl4dUJ6R
	3mYY91iVLDAcR0jddkHKFK3fZCUnUnZa2lA0YvwoIru6v9dBPSSOROrnLa3UFJsb2CNAiqVQvol
	LqKzpkPxCS4o9gRhCJMzXh5Vj3swvohCfrgyH8n/WFcDYEl4PWo24esysx4vl13JEidzyJtKts2
	TaFOPdU+8IwUQ5igMk1Bl4ylq+h2eqsnlPGyWk5HrLhxOqt6e6SjiZTRFbd0nGTqWgcnU3ob7wL
	f1nd5aRZ/FKGDhBa7CetNYl+qj7anKj4hO5qCU4D0YlXiBhueCLhGvVEvNbSOsYDbc8edyxK+bk
	SQIUBliiT+O9AVtfc9ZBuqehAkdnNAikTwb4bVgZXGZ+5vv0WciWwdwM7vWwheYuriX2M16IifJ
	a5+5wMGhQ==
X-Received: by 2002:a17:902:f34d:b0:2b0:7026:24bf with SMTP id d9443c01a7336-2b2d59c7601mr151908835ad.14.1776259577440;
        Wed, 15 Apr 2026 06:26:17 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef741sm21739775ad.11.2026.04.15.06.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:26:16 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	szeder.dev@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	gitgitgadget@gmail.com
Subject: Re: [PATCH v14 12/13] fsmonitor: add tests for Linux
Date: Wed, 15 Apr 2026 07:26:15 -0600
Message-ID: <20260415132615.47913-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414221335.GA3413665@coredump.intra.peff.net>
References: <20260414221335.GA3413665@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> Do we need to put it in curly braces to avoid interfering with the &&
> chain? Otherwise a failure of anything before the maybe_timeout will hit
> the "||".

Good point. Fixed in v15:

  stop_daemon_delete_repo () {
      r=$1 &&
      { maybe_timeout 30 git -C $r fsmonitor--daemon stop 2>/dev/null || :; } &&
      rm -rf $1
  }

Thanks for catching this. The broken &&-chain and
2>/dev/null were hiding the test_might_fail error.

Verified that test_might_fail rejects maybe_timeout (exit code 1,
command never runs), while the { ... || :; } version actually
executes the stop. No other instances of test_might_fail maybe_timeout in the
repo.

Paul
