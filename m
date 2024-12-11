Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83D259490
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950551; cv=none; b=N+wv7up3vvQfdBA45BWIcCtSerxTiDm5nP3NGSbtxdukwaH98nNSr0UeFLuirkQmoS9kic2pRY9FXJ2odZBZzgC2S57RcbEY9OsNMC+5BCB22z37Ys36At87+YRox/n6noVRJspbIRPASX/a3caaN/Oq2eqwCLn8VlkEWU/TvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950551; c=relaxed/simple;
	bh=OjW1mNeLQD+vUddHjnpn8/EQmIfRw4+SjFgS63tjbEA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eP7OlfNwZCtDF4lKpGOHePS+meyFn17yJyY3alRQqEIWlFvlBnygz3l6eBGQIhjdZPEp1KmE9+Wl5MpQJXMbZdZ/Iv5+wFv9gubP38J0PC3ghLiPyjeP3+EcYu1bRU2XOOjyrChBKfiXJ/cAijvRNiTQ51vbd6McvOoGYXgWVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoBl9aSF; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoBl9aSF"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85c559ed230so989575241.0
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 12:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733950549; x=1734555349; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OjW1mNeLQD+vUddHjnpn8/EQmIfRw4+SjFgS63tjbEA=;
        b=WoBl9aSFEmdcfIiyXvdFhHb0zirJmXSKwqk8c0wffFp25Oa1Xvqsp648jEBbdWA7JE
         kKwdgY8HekZDWx1IyIiB2YU2AluS4PZPNP7mbe0y45EGLexakpMvwHUBpl2/YR1W3OwA
         M+RWQ6fsH4hMc1gy/p6c415ik2V9BiXgnUXJ/4cZm8z2rpXOOTQBcONg/DVRCW9+oZ1b
         9yySHUGdmFOHv/GeNmkl6zuwCPaLYL1PJFBJe+VnUaiGa43Q+TWOgkjNVZfXovP44RE0
         5elcya0YBazzVBeQp1nG+fjQEe7ThS69FD1DfYOT5/PNxfFGqOJdRsonzIfKxqVA/dp6
         XHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950549; x=1734555349;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjW1mNeLQD+vUddHjnpn8/EQmIfRw4+SjFgS63tjbEA=;
        b=UwhSO2i+yvlTYH4vvU0KZyzmJnFfrd/E3ShT+A4r4vxBrp0Uu95eAOS4YEwVmedLFI
         c2uAF0Uu6CkVu1qcmxuid4No1gFeSfPPA9L1Mt9UY6e35x+WOTUA2fbi9zG+6g20dCkL
         UKzi7+NRxuFDJFpSRAJ6AVwmCkpCgwqFljt9jKsjK3KA/xiAuWKUz3iRJdGF2Zv9HBlk
         nFAfzmjrbjGw8OOCdat08oGbdUdK/Whn21c4Pkuu7Dc03A72owBg5HrM2LmK1eDBDDUh
         fnPHSsmhsgSoRCH715p3ggvgLEfRW46W0U5BkozM4vb23bt5jVNGkGsXzHKoIPdVI7WS
         bkkQ==
X-Gm-Message-State: AOJu0Yxaf1oKJncR2Y/7ldnIVuTE65xtwLIXyTmcq2FogNA4I3Ni9CKi
	hiwx57p9OwxiKlMC/xskRc8rdXCP6aNvkumq1ZXHDybwrJLCQ9IXz/kSNCUQy5xsCVxVVKgp6U+
	lRMkxZ9pIpjHu/OaEK2wKTxH8J2UBTtHV
X-Gm-Gg: ASbGnct8hhfmdpe/pCdgZxXL4IF5rYz5IPGNg4UazOodaSgZDDWiqBF0cZJmQvpOJU+
	I8J1C61rINdBpI96JSDUhYjY7/PdhuHAVTfT3jCnLCCY12s+5yijc7dfTe5ZLSVZb6FFb
X-Google-Smtp-Source: AGHT+IFcTHGEVWt7zsIjGC3BhWk1HGde0jUo2aaelS8se69BrQjycj9OX9abCrnBxvkNv36vexUt1KwRx/9u0hzAtdc=
X-Received: by 2002:a05:6102:b11:b0:4b1:130f:9fbb with SMTP id
 ada2fe7eead31-4b2478e161amr1846316137.26.1733950548963; Wed, 11 Dec 2024
 12:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ricardo Almeida <ric.almeida@gmail.com>
Date: Wed, 11 Dec 2024 20:55:38 +0000
Message-ID: <CAMKQPDZWgq_qCdaL_S8cYYn=wtZSJiq6nP5aqFjvUZcFSnrTzQ@mail.gmail.com>
Subject: Git pull --rebase and --reset-author-date
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I just learned about being able to use "git rebase master
--reset-author-date" to, as the name implies, reset the author date of
the branch commits that will move to the top.

But, when working in a branch, I use "git pull origin --rebase --stat
master:master" to update the master branch and rebase the current
branch with a single command (have it in an alias, to avoid typing it
all). So, I tried to execute "git pull origin --rebase
--reset-author-date --stat master:master" but it's not possible :(

error: unknown option `reset-author-date'

So, I was wondering if there's a similar option that can be used with
git pull --rebase or if I can request this feature to be added? :)

Regards,
Ricardo Almeida
