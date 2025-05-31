Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2328E23AE9A
	for <git@vger.kernel.org>; Sat, 31 May 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748706124; cv=none; b=nDRhY5bvnemtqt4+LE2bzxpR+LBKEPZJKOJ36ShI/7vwhPeA3ms6KAivJlsdYspHFw7MFoY2qphmLf4dIFpsE0ydTHz7PxF5/m91ytGmHbu9+86CKzRmGpq+WDgjD0tHuff1BySXxIpajgW/tlpTdJxp7kyesDLMrHpdDJEWExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748706124; c=relaxed/simple;
	bh=wPJWz2iQCf1aOh/TBa8dkHACjYM6TJFohed1idwxAS0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KGRE2fTRJ9UJq2YKgB9RRDInKSpkASaa9eN3pSCRHrZJ6lBvDXxnX26/Pz9RPLFyQazdqHMyG8Cg7vX63FUh35BR2nrN7l0LPORE0v2+45AL58yXeEuAnoGK7NZi40g26p2pyGWA+apjbGO7D5wFi2BFyQ71CVkygND1V1entVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRDcANqc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRDcANqc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6046ecc3e43so4845692a12.3
        for <git@vger.kernel.org>; Sat, 31 May 2025 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748706121; x=1749310921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=itjENLd/n3S1dqdJHfHuzip9dHsVBLgFIOuo9T48dK4=;
        b=ZRDcANqcLKQ9baWLpiiEuIfdKoyISHD9RTDgfVKuYM5tLDDcvbMXuu7akU/z5pFYsf
         n+d8wr/zoytrTpi2Pnd8UDcjDbWQBCliDqU6Bb5P0+wPBoJJR7GP0M75yJ/YD6Am8LFk
         droOkP8FGShj8WZd+FdaPoUp97ap6rN7+btNgpwb3ipOsMZkRYVOwvHNYKnYkB4r/G01
         pwTMh/hqLUq33DsxcvvitKo8SB6+gm9RBWxmoLRumP9TM4hkv8g4NCxXa7ddN9OGU6Co
         aSJ7iAzkV7jE6pdy4jQVEo6SGWTyAac0r8Ti5W09LmPzh8jz+0oSkwuWLwkQ6w4pKC/o
         wxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748706121; x=1749310921;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itjENLd/n3S1dqdJHfHuzip9dHsVBLgFIOuo9T48dK4=;
        b=lGX8+/+HrS6qHAQkOQJld1E9IEncFuq6V1vj5IsXdep8xQU+wfTpMAayRhtDhI+6rA
         U1jjQMda7X0BLRigvrCJzebsOLcfJ42q3klPrsAg8jmGtKgSJAmZ9d7RN4FcVZX1lb9u
         /US/sEothJUMm3cV7UGj1GzLpWdN+fp75BEIU2odjkD0xDOHXbvm/V/GikrB79YjZNZS
         B31bWwIUdOS+w+vDOU/2wgl1Ehihodt0lQisqswNJsLHjUxYAAfAnKIisV8psuDuoe3t
         3rCo182wMuK5uTi8lKh1L8H1cg+b+FwGNwW93fXCTr9LgmxvYRjml+J7daOwPjSUjw44
         LmQw==
X-Gm-Message-State: AOJu0Yw5clSN67+Ymb93E5Qs1raZ1OhJXBARfrOjf6SWaEbERIvtDB0T
	MMNQNa1wGoxXCx0OVzcXRjDwa9+VyMXz4S/fGSdGgA7jNP3bi4HB6YQwK6d44sEawO42oYLzD5Q
	9e5phqK3c4hwq103xQGJ2mymsj4ea4uKoubwEPXQ=
X-Gm-Gg: ASbGncvO1eTugKUe6p6Hcss2fusbwVvXpOlzLrhx7ayon8taM9STBLCv2vgblWScX1Z
	FpHQqUFK29Yh++Md235yxsC+/xct6R2zPulVsK/fPiG18D1meHQNhzETk1ECvHZ8qPNHnLkG7zb
	Ypz/mSCp9Rrv3+Ld7/eO8PkmVDC9YRphPagA==
X-Google-Smtp-Source: AGHT+IEB15rMg5xrkFjPOyQnK4TFsWeTiv2iXOUwB4HE7IGHid/hY8f69t8jAIJr7HwEeiC82K7C6+CrEvDIwTcSshE=
X-Received: by 2002:a17:907:3f1d:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-adb322b01a8mr681412766b.31.1748706120445; Sat, 31 May 2025
 08:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 31 May 2025 17:41:48 +0200
X-Gm-Features: AX0GCFtQxxlH3ydJ7Nv6eSXQFKRSVTpjaBg2sriligTP3Mq93Ivs_h9sEcirAtg
Message-ID: <CAP8UFD2w0UaLW+psacZp6FfJumXS1DmR9dRsJ=JP9M5Abx+jXA@mail.gmail.com>
Subject: Draft of Git Rev News edition 123
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-123.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/775

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
June 2nd, 2025.

Thanks,
Christian.
