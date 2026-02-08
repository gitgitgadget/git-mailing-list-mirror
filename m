Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C6223B62B
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770530642; cv=none; b=DFUyKddTPoBUJKEGNL1MN0PZePx7fOT7uIua8loe4pBJvIDRVT1FNH7vEFG7b9Pk8Ps1UDQCPhtKbH1GEaNQ3zdD98+bSqogUEyk8DLQUiVpGWhYvlCm0eKi4mNUM42eWWUyIV5Bz3GNWKhJBD9ihmb2g0XNN9o8iBy98GzAtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770530642; c=relaxed/simple;
	bh=q2cxc/dHm9SSZLYngmw75nM7IijrkP81IqD5qCJ7ihA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk0obBXCetQe9u30EKlnSTuoTBqA99IUbXj08ijwGuOrcbOBec6oa8TaJmUMVtvwz7KLGsP/br2/K4kBgTh3B0o0DnjaTIZinwlpR3YICNXh6whf0OTACRz/RnFZnIRVBV1kB1IycOhW4wK0zz0eC9mIAjTV7Bl5E3t4v6qdmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuIbuPAj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuIbuPAj"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1235312a12.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 22:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770530642; x=1771135442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2cxc/dHm9SSZLYngmw75nM7IijrkP81IqD5qCJ7ihA=;
        b=QuIbuPAj89BY75IvsAEhTLDfICDiiXsWXrUSgQ2SKCb3goZmfYPgLyb/8RHju5XlMh
         WnN8RoB6wF6Z/38vuws1Zg7Q5fE5a9gZ+hkE9E2NO7Z4F6F74ls8c9fwlPtXYE4Tenaq
         EKY8A99kSgaT2APUSnVyXN9kiiCy1kGSzeg5zuaACFJ4fFQwvqAQ3t4FwATgdOA7Pq5F
         cxdxDbp+gxy9c1rNxdkbUQWZPEgNTZCxqozjCH9uc4w6wuEZclsqvtzU7an+1QE3qtLj
         vsMG1Djbsb74yJPiodyVj24Qnx8F7J8LVliUiQJfjrCIjADvVuNiLGlioRKihMNeAT9S
         wJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770530642; x=1771135442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2cxc/dHm9SSZLYngmw75nM7IijrkP81IqD5qCJ7ihA=;
        b=avnTAUvpW8UN4CobmHy1SZFxQDQz+/iZujun0CD48hmHpTkTsmWM45TbxFGc7EZjKz
         KFjmWpvnBQTql557UZO0yCx+nsJ1dAj79AozjCcLNcd8WHjqMaL8hfAeU4FkjLjDhFm3
         Ixc0Tb87WCg3mI3OLrGC73BugqlqZhPx3oMpn/shLeoqNhCRX1Y1QZgqCmtlOB0j3uBY
         R0bpQos1Bsb0Zs3YhgqJUIzwaMJwGL77Rk6KOH5x/JyxWRW2lGoQ9SJjIvMK9v8j8mLv
         Z3VW6eONmoZVPi6kKmlUcEIGDwmgYuCm0nS9XeBRCB0Hh63gS4wRTyweWwQAnSneJskA
         UqxQ==
X-Gm-Message-State: AOJu0Yx1CzaPTMCisJd8z38yKSy+6Ek6853L1HAdSIw8gFTIyVk0vq/L
	KenuAi8TMmg+S8cLOE8OHHpCQ/VvtGgIzkOihsPB3OLj0AUCmv0J7FV4P4u0iA==
X-Gm-Gg: AZuq6aLO/6V6ZBr5zwIQ688JZC5a+00FJRIDTch95boyCNid3TAKRh6xX02eG3nUc/V
	Tbtp4M/B4JVOb2E3XZeuWGRXNmQpxGRGM0U+jORJ3WmKDd7hHbbr4JeSHZR3JVQ8OzqqqgKyd51
	4fihvOcAwNpS5txQ8SuViBBxFILt4Ex+h1GJJpjhSRi+ZTHgM4MLdBw0CBEnTgXUsrqEYExhBrU
	oKtlR3KtVlEvyD1QlcqUnaVsSgM/6vmk2i6xOV9vtIeg1uLhMo3/4j3OsM65emcePoaEDTlVwgS
	zZn/jQa2TFIlhOFVtqLDqkiVfzp9oBHKfpIlVAHl30A0XPCR9wAPOnHXmWemns1usTxqNFx2rzs
	4z2hyuVu+oa7o6IkLcQKO1OmonXQjz2lXrHbq87BPBahtmzrfyEg583U0OxkpSHFtlb/7/nh8qc
	W1qdpODEDSp9VTQu8ibIHpzeBA3DdiFzVmN5eqKJjK5GAtnCLrsr+bpqMll20Ky4LPp2CX4E1aE
	qN0JBmw
X-Received: by 2002:a17:903:b4e:b0:295:8a2a:9595 with SMTP id d9443c01a7336-2a951709b3amr81625685ad.39.1770530641596;
        Sat, 07 Feb 2026 22:04:01 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b21fbfabsm6763631a91.12.2026.02.07.22.04.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:04:00 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] fsmonitor: fix two bugs in watchman hook retry path
Date: Sat,  7 Feb 2026 23:03:59 -0700
Message-ID: <20260208060359.50233-1-github@paulisageek.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
References: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Friendly ping on this patch.

Thanks,
Paul
