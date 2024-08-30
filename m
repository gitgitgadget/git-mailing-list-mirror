Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAA1BD00B
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051569; cv=none; b=hoZcAbrpkVSmINPeZdzWrFLH0OIBoHn1AAjNHhTOuHe0xW7mp+0lFkK3hV11MzYKlQOLAiXGs9vpyXWiw4waocij3PW2uHIh+IwGK233VhSXDdYog/aeWclf3+yKlScSsjzlPBk5Hy3/e0j8rsmgHxoiah1k49NSDmhhesCyktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051569; c=relaxed/simple;
	bh=097/TVNsicZ1Br4UdXLTyxoy6yN5KzHrxLYwYIN3rWQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rRwx7VeYPZXC/BNys0oMnkDI1IdkwKhisdOaltSBWD8PbjCXPqCDzbEQEVKWXnz0tv/S0GQEsrycu6PyaMV8jxRUqbgoblKJbp+uy4ZiRfG7AeQPm4ZbChjcBQT9iwmwP0KZN1/tJMACWBykRff7+sz39wotUUJYlbbjpDyZMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDzQJo8V; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDzQJo8V"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a869332c2c2so549187466b.0
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725051565; x=1725656365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RLGoXtXWUzUDOQiboa1CUzuutjA9Nf3xzQ6EeSsLAbI=;
        b=cDzQJo8V2FqIvbHCCNaPKyIE9xTGOpJdjQkPd3yqIe1MKIUi1XmfHObdTszVeLTbkJ
         w6wf/+fuFWwoQ66cEQglYDFfFxK4GkVpIEbaTJ+jioZ6kzvt7a8ugvCiKoQ313yzTy3V
         tmQ3WF6/WYUP194UE1v7eD4NJYK1uKGIch5c862HCXpPo8U8ZzIvHfwTsHSt7WIt4+eb
         Dqc8YmtCNH/SWBOcBde6692lw8/PVoMOjvzES4XWvLIgecj/5K4oXUqD5L2WzD7+JJEo
         fasf5pA2zmP6p96AoiyHUQQynPHmF6ED9T33v7qhnYRvzMlMJYZsg+FK02VfQxGjyhsM
         7HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725051565; x=1725656365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLGoXtXWUzUDOQiboa1CUzuutjA9Nf3xzQ6EeSsLAbI=;
        b=LqhBRc/0EOU8aWgMHTqOU23TYuBsKMAlvB5yoXn8hick6knnuEio0cTuJIn8LYXQMG
         kA5cqgNH3dIm3h5ddIHig99lVY7BlMGG+5Oj8snzA5V6inaXsIAqGFWIewK+i/bbmO1y
         2Fhsv8AKKh2k+JvndeAKo9cplR63wtIu/zSgltzniIjNc5Vm9bifiMtEMhpdXkijA7DV
         OJHE2cbJdqXWD9G6U/vMz6u5Xlmb70QaeeHgViYtwSeZrPzh38zzVX8E7YQi0YIRzzkY
         zhIet2bQ4ziDiX6ulZoJTFFUQ/v/DycELs17926yBKv73U666rwJKrQFSPBWCVF652zn
         bKbg==
X-Gm-Message-State: AOJu0YyJ7fO0hVbVsJITIZgNWX/2K1jXwJFVi8Ivm5Eys6ULr0CAHiuO
	YrzMVuucP1O0SrwYAVoLcipH7Az+gsjR+8vVEqCa6RUZQP167MdcBmPXuA3OpmtpbZW+SXci8gE
	gGUw30iz6rWgc4ayQadmUHMrONsP8suuj
X-Google-Smtp-Source: AGHT+IGeMO+Vj1Tyx82XixCbmScJ17D32wOhpNEaSTfAP/rVOmSJ4qvK0gowJjGMVBr+K6wJzl4LkwmiNl2yNeXNPyI=
X-Received: by 2002:a17:907:1ca4:b0:a86:84c3:a87 with SMTP id
 a640c23a62f3a-a89827a9635mr732669566b.24.1725051565000; Fri, 30 Aug 2024
 13:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 30 Aug 2024 22:59:13 +0200
Message-ID: <CAP8UFD0NFhuhs66Q3CGSCxbLnZR0M8PCjpqKuFP0X=NvEA=EbQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 114
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-114.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/724

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Sunday September 1st, 2024.

Thanks,
Christian.
