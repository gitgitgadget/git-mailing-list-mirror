Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BB4C9F
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237604; cv=none; b=kthotfsTljK+vxNZFdfhukFAe+VJopEUny8poO6+iqzqSzFx6oSODDks8duMBptl4Xo+vlM99RY22TBfTb2qQ01PSuO67pUHoM1W+ohMts7NuA8pe6g9uIwShiA0tMlaFXj/XJr9MF1+Wk32fVcjHlbOJ3QbzUCGYLKORRgCCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237604; c=relaxed/simple;
	bh=uTB9wxfyhe+AQ6XjKXXH+nVFb9yP+kq2rhM87Be+Kls=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OR2kuY3M3PLTh1Zo1Ke6ENQmC3KV3749HjQ3KwOj9hTVA9eguO5DadHvXhnR0CdzR21t2an8f9XN0QVklrHRifUhAAwcODNk10PGGWLs3pGPusAGuh04pHp6X5H66JlHf3CHUZRLqCiJk4vaXyUQ4sRFjfP8GhiRff1Wod/sMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=block.xyz; spf=pass smtp.mailfrom=block.xyz; dkim=pass (1024-bit key) header.d=block.xyz header.i=@block.xyz header.b=I/JA+96U; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=block.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=block.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=block.xyz header.i=@block.xyz header.b="I/JA+96U"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1166864f8f.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=block.xyz; s=google; t=1742237601; x=1742842401; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTB9wxfyhe+AQ6XjKXXH+nVFb9yP+kq2rhM87Be+Kls=;
        b=I/JA+96UuEXn5VzU3gNEko/yZNClXI67tEYI/jD7SzzHy99cWIMrJtObqFNlJNTxyy
         pCFIU+VGQ0HrL92hgTOSi7ev8kbweiiBEhbpQVJfCrjadcxwWi67LoHH/gTVBd2NJ5g3
         dHnPobYQUdlIxUSpIuB7cDBkilNS7kjeJy79A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237601; x=1742842401;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTB9wxfyhe+AQ6XjKXXH+nVFb9yP+kq2rhM87Be+Kls=;
        b=l4YQOArT8DHoO++BJp0hqKYxXlPyVMA6h62P8DO2RWSMgNye9iBjDTZCjLKL8b/6W/
         i9chQFEbyHQE1nlmBM+WX9Uody8jtTzdsbaCkA5U8dd1jZLJHSOkspjULDo0tBuu4JNX
         soH9wxX/uIOqlEsjSr1Nl+R/vjnklIj2h2rx+WBL4x3JAcErbpHPxhs7fYu+oYi6mL/8
         w4xXdoaGqJ4sxLXARsaDeiFrUMlSfiHaRzduaSbhXQgMbOydNl9Tj09kaf2IHOWcfoLI
         eHghvLq5KRkxuIVYmVg7D5WH5ybphcvEPyovKfvracFt/0bkthT37XP0vH3wwI7t+P+E
         EgLA==
X-Gm-Message-State: AOJu0YyyjKnDSBz+3crva5oFnOUpif82iSDbne3kQCpLQ2zljm4ZwvpL
	zPbpZgALFSGs5Q30YP3uDHAubpfjT3K0RgjLqHH7J84C73DSMJqxE4+7qvz+PM6klu66NsLABCz
	koI4Ds0O3M5sUcs9A/XZx93SQdXHUSAz8+xYUD5MOw3EuatDSXUl/Bg==
X-Gm-Gg: ASbGncs7sAnWz/6YS0mIAvkz17d/XbTyjjPYBABsfUB1j2+VNrxQknwAnjWcr11z2jN
	lCoXC6cBp/iF1XBVmOcoWGezjAO7Y/8Mdgq4fUCO18sYUoJFG/F3zgpuGABGV5Qpw7u876FL7VB
	72gC2+sr1qIYpIGbgAnBSI1xMNhH3R
X-Google-Smtp-Source: AGHT+IEVeRivHCYBx51GxfVUi/M6V6Zvy42w1vjusSgT0WKhqKKr/MNGC4qjvQ6aoSaLGh3olNqju/wH1l/KSIXRdsU=
X-Received: by 2002:a5d:6da2:0:b0:390:f394:6271 with SMTP id
 ffacd0b85a97d-39720966395mr14574757f8f.43.1742237600951; Mon, 17 Mar 2025
 11:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yissachar Radcliffe <yissachar@block.xyz>
Date: Mon, 17 Mar 2025 14:53:10 -0400
X-Gm-Features: AQ5f1Jp1BC6k48Nj-9LGnVujiXN13I0hKN4otUpaKtrgVc56GrzlTDQ4VwPbDXU
Message-ID: <CAOHNGAW7ucD+xqvEuvq2GHMc42+WdKJX44XGguadK_y=pMf0Vg@mail.gmail.com>
Subject: Slow git add . performance in large repo
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have a relatively large git repo and have noticed that `git add .`
operations are slow (~1.5-2s). We have core.fsmonitor and
core.untrackedCache set to true and `git status` executes in ~300ms.
When I turn on trace2 I can see that almost all the time is spent in
read_directo and it's visiting 26960 directories and 77989 paths.

I can use `git add <foo>` or `git add -u .` to speed things up but
`git add .` is the most convenient for us. I created a small script to
pipe the results of `git status` to `git add` and that runs in <500ms.
This leaves me confused as to why the built-in performance is so slow.

git version is 2.49.0, mac os x 15.3
