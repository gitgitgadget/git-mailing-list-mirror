Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF92836A0
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571885; cv=none; b=FCAGwhiplcB43aGj6+Xz46b0iGVUeiVYayquqfQl/PBKSl7rrQ319FZa2X3JTSdi/qE0o3olGfd0fJUTtAN1cPwpXoPpcRAqrxoZZ3kBp8uJ3mXhPuh/CpUwlAtG/dno90hVryERx8w3sHxEo70MKPqRsNsPB7IRCZDuyHiUy1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571885; c=relaxed/simple;
	bh=DLJ5cEnr6QAxBf4yGm3t96HZdy9WEedamrXXH3SPoQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U783G3Xi0g4XKlNhfDB8c+ui7TGgFH4aed1HUIYlWxYoDYbytewFNaiU8rOVOKg5KQH6n2HCOWoibSzt1V/wXpvSMejSYXS9w3wR273JWz3sJ02xi+4jt8r53+r3e9B2xbN0sya6YE0m86sYNE6aH4eeJd7CrDXiJfZ45CWthGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhgnClYE; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhgnClYE"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so6244300e87.1
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766571882; x=1767176682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLJ5cEnr6QAxBf4yGm3t96HZdy9WEedamrXXH3SPoQQ=;
        b=YhgnClYEZdlvXuBxmiCY19qxnJUarzIQxsCWq0iJrFhASMR19QQfTSuLs+zTPJ3i0H
         WewnZckTW+UV5zVk0L/inQfeOoMRjXHhvV1iVGfaqkZHl+Lh0TSDi6vtcom7otdf16s7
         whljdOB7HOtMkh+XP4eZwv6ad8gzvKOgZjYCrIjLt6q2tWJ65wM0zhX/fQXJ53rqVs1S
         Ilv1TDe+sOSyM8RIg3hNt2pnImIBBTxNV1itwflruN1M6rFPa32POouvJG9IlRuqJhz+
         HCRZPWdXvoxW+jcICO0YVRAzewrVwP0iouGlT/nUBuKOiEzOoVM5rIb4xtHcUXcWeuqE
         FzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571882; x=1767176682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DLJ5cEnr6QAxBf4yGm3t96HZdy9WEedamrXXH3SPoQQ=;
        b=o/eP6wyo4mptX7xzM3uoWzPeINag7TurMuK4kXddsqenhBuO1qtkkRLtvAj/Jtrkpb
         TbU05lA2YihtpnfjAoYELpiKd2qgfMogkKny09NJvYI9n1ycVeH0DYJdXHTK2ysTh9Di
         iW1D9KxnCIaIoK9kWRYnjrS08wbUUdKJsNyseXBRJ5qL1rfl05CpAOPtVoqTviTS2r7B
         O8fJ5GhtqfGy/oSgLfh8cg+oZ4yOLk0bMJfdZG/hAm5eHLdoRHxNrv3PVmv73GKFUMwW
         lmjxJhhle6/2mtz5YrNHiXaUbaMs77jmqpjARU7cl5MAfsarOPU9IpiEQpqUR1xH+V8d
         wSZQ==
X-Gm-Message-State: AOJu0YyWKvz9Qv8fqP5cwU9kDKOashhNNkqZkFhV8IkevdW3jgR9tUdd
	C71e6dgeli0fmSmBiqT1uajOkElTwwvFDvm0xY09nkXqrbSnhPNrK2Yq
X-Gm-Gg: AY/fxX4ZhcelqNTeYKid9AwaxBjlSU3ch2xT+1ECEVzDzPs1k+6fNnUvXzZUWl3EriF
	FdT43B9vqRusUorgXwJ924vmwqjG9JuS/bgvbIasqIZxaRudn5IRfg6yELLRljp61050dviXgqU
	6tcRioaVT0vbPTW7yED/74gJkYSv79wKlpjia18YPZAmye7jCVjI4C5W1dQEnjV6Stqt2FxL0lF
	Bwq+exUXku55EhKmSOuKy2nuPStEpAvGn3gLiE6wi+68m9vaAE89BJVi9JWjJud1ifom1rAfbHY
	Q+KKHokVK8guajuHh91ednOcA5wddK0cdzDJpXlv3eYaDcEiIVmx+mYdSGj2u9NJTx1d71YGXtF
	AcLASJ5hq+KzeWmKmzj/aX0ZVprbiN8pCkR08r3Oas1oxu/Ym/usWIQ2VYEGL+gaJ6fhmEeGia0
	/IFY5LXl8kACN4Dp0GMOeOZckWv8vOBFlFJJTQmBc/D/s3VK8W9KsO
X-Google-Smtp-Source: AGHT+IE2yFC1PPhiMG/WNJRyI7XziWC5Ky8ICYmWsIq5hug3HMj12I3H6hW0Vz5V73SJ5Y7R9VjsZw==
X-Received: by 2002:ac2:4e0a:0:b0:597:d7e4:4e8f with SMTP id 2adb3069b0e04-59a17d22910mr5631942e87.7.1766571881977;
        Wed, 24 Dec 2025 02:24:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:801:7ab:287a:2dd4:6f70:cc:78bb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd1e9sm4766730e87.23.2025.12.24.02.24.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Dec 2025 02:24:41 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	ychin.macvim@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Wed, 24 Dec 2025 11:24:40 +0100
Message-Id: <20251224102440.66208-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqqzskodqe.fsf@gitster.g>
References: <xmqqqzskodqe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This series seems to punt on
> determining both repository and branch and instead uses a hardcoded
> "upstream" (or "origin") and "HEAD", which is not satisfactory.

I have made a change to the code to not assume "upstream" or "origin" as remote names. Now there is a config setting 'repo.settings.statusGoalBranch' to enable this the check.

I side-stepped the discussion about pushRemotes since what Yee Cheng Chin brought up seems to kill the possibility of determining comparison branch dynamically. Let me know what you think of the latest code and I can handle it if needed 🤗

> I don't have that much of an opinion on per-repo / per-branch
> configuration but I just wanted to point out that some branches would
> benefit from the ability to turn this off. Perhaps it could be a two
> layered setting that could be both configured per-repo / per-branch
> but I don't know if this makes it too complicated.

I skipped this for now because I couldn't find a precedent in the sourc code for config settings that are "on repo-wide, but turned off for some branches". I could dig into this if we need it. I would like to hear Junio C Hamano's thoughts on this specific thing too 🤗


Harald
