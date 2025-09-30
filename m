Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A05185B67
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258172; cv=none; b=qI0t3Pf/qSWTdTfNj9sbnSglemvdgt+JalHyIh/RQhK5SUlfNHYVuHwY4ftttB/RtZPPk4/pwkJfGXZJDSkL1rAnzZD4EZUFcPA1CYiTswONEjpFheD1S5n79Gqv9Nj3eVORskThLCEK719ENMPIbDMGBkmKUuq6qNX9XWVTJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258172; c=relaxed/simple;
	bh=oRmBC2dcHzfzceuiz0frG+TAyXdl5f4vbLSJO55oP5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pclgEQqUB8g+3jq/fDcxa1EflHE3DK8fDvvi+vsw02pT2aaIcXXsrmwvpU6kibMwxJ+fd/zR7vygRajKYmUk2l+wWNi93AE/T/UkST9DAXa4a5LtkcHIt4D49gNe/Ke7VkRkZdwL/NC0joMeTxAtACDWqOOJ0+UjtqUm0+t6nBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gegncP4O; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gegncP4O"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so57484391fa.2
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 11:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759258168; x=1759862968; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1r2KBrdsSkvc7GkDXzKN+vl1/K6z8xjCEzFjWsWbVQ=;
        b=gegncP4O4WnnA+FgTyOt/WHU/etr9jV5Zb1wdcjCT9kgBJJ1vUTL8FtDbZ1Dd+pcB1
         8WZahdm8oZ2O5kW+unDFaq17W6uSIR1LC33TnkixSKnXiRbPI4I9F3LiXwOo0gSW0+aN
         V9Onb9hqh+7b9DR8owhYawO3w2xXQh2hP6X+RXLADWzTZRl8Gp7FCvs3vn+olL0Gg127
         BPylUlE0IqRQ4NP0YdtppSTocMdGNCaT+r/z+R9WpNzQgBhcfftHKx54xikdmP06UY2M
         kPwNSKAXgeOIFTAjbR54YZqUb8QGk+bzeo04bux0eExOnbCeBFMwa4JaNEtcIVNzAGHI
         H38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258168; x=1759862968;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1r2KBrdsSkvc7GkDXzKN+vl1/K6z8xjCEzFjWsWbVQ=;
        b=jsUDsuTm5lEIE4rlnqEdUpqAYAS3148oSBSRf0pTJW0lHz22oUwprn7l153f1ICRZ0
         1MxoTCoM+0L3rUPI9J8/BLnauvs221O++bwle2gefofjM9/IooWbhriE+Mz2okEu6EF4
         9MLaSQ220wSd1ziau1W7wJM8irxo6s20H4k8mLZQ7dN5YoOK2u/IvVbiZcPBgqtw7vxr
         g8n/m08XZT9l2p235L6srM4N1iPBUoTHtAG107WGCqEvTgbPOT4rT4/0jMqeeYQKs6LI
         VX7BOQjymPpiFbzJV0rDNkegwUoKMzud5s81yhsMuvfxWp1LswHhl+LdaGACIqQxjcDU
         wbnQ==
X-Gm-Message-State: AOJu0Yzjrj8JWKri+OubFDC+pK7lPnRifucN6b4HfShR3n7rvs1utUa6
	G+DMAjLrvhGYukaJncahFFr4lZ0ckkzHv9DZa5gT0GT9x9LtN54k5p7L+L58GOSbzqnXSvWmXp0
	dwz6qGRV3RHatGiXvXE2/+wP1apdz8eLRf44L
X-Gm-Gg: ASbGncvQm1zME7ZHTwDo1HaNYILmSwy+J5ya+hLfuu+ne8ywlQnLW6K1Iy/ajcEXdlv
	gWrijOwqxLTydA3gnReXFpxzBf6oZT9v7Y+0V7TbBI65yqwyVlAUmk5xuGe2Z8Lbg499Hv8pjvE
	iDg+k+Nd1pP5EZWEJi+4ySPvhGUjUmzpq8u/w0ag3yEh/6rxZPVlPlGQFHGhy+sm7Szx2iS4+M7
	CmZr4njyit6vKcAiUNWURQNTxlRoRraE6pXZrWbK9kUQPwHwJ977zhCz1pr9y1YQ+WLavml26H7
X-Google-Smtp-Source: AGHT+IFTSrxoLgkXbT+rYj7/+krIOk57UoNtT7D8dGeMZY/RluZreSSngh1Mx/07euV9oL4an5/8TLStXd6WyvF7uUg=
X-Received: by 2002:a05:651c:1988:b0:373:a537:69f6 with SMTP id
 38308e7fff4ca-373a74c163dmr2167941fa.33.1759258167900; Tue, 30 Sep 2025
 11:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Harding <stharding@gmail.com>
Date: Tue, 30 Sep 2025 12:49:16 -0600
X-Gm-Features: AS18NWAnuqmKZzA6r97bdUsbxW0K59PhQBmfmKx97YhieQ9l0BCzBTPXy9KAL4g
Message-ID: <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
Subject: I still use this!
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I just encountered this:

'git whatchanged' is nominated for removal.
If you still use this command, please add an extra
option, '--i-still-use-this', on the command line
and let us know you still use it by sending an e-mail
to <git@vger.kernel.org>.  Thanks.
fatal: refusing to run without --i-still-use-this


I use oh-my-zsh and I rely on the git aliases. I used this today:

which gwch
gwch: aliased to git whatchanged -p --abbrev-commit --pretty=medium

and apparently you want me to send you an email to prove that I, an
actual human really do use that ...


cheers,
Stephen
