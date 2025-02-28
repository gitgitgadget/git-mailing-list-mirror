Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1523DE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724701; cv=none; b=b1HsZvcvUtpfagFcdV+oMGXWuTYoTgcnahBg9xqG5gWJEJsm6tE0KZZe29ODe7L6KXtHvZD/U2nM4bINwxVmY4bS9XZbi47qPF8+253O3XqZJ1REtqeefPhSLjXtJASiL83y/iAsqz8WpSJ4bsBNGX4yv5gE8Pze3CCeYmjxfKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724701; c=relaxed/simple;
	bh=7KYT+gbFTms6vxd0ityQz8M9KlYs7VVIHq9oJzFjnYA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G/vwIcrE+mi4puWDCCBp9TiU0s730S9XVp8kAVvVlDnkbBERlpuPyfaOMMxul+Y4M5PsQylvDGCDgfiARfvpU7C13oqeWPz6hbmEMQ0B7TSRjVga5he5o6LIcHOZij7oVsGGarsO/I8yA/jogZ4QEGO59ADUeS41YX35t58HgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNATnCq6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNATnCq6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so3146501a12.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 22:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740724697; x=1741329497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nwdaGyVpEljER99c37egNv+wOlRJBZC28CYJ3gOVThY=;
        b=MNATnCq6PS8eNrq3fihqEFLTwiAMs12qyGZBWUI9KsDGu8lY/o0HWkVvbcUqG5Gj1D
         e7Cv6i8+Oe5WJOIYsdZlM3Qtb+kCLfQ+xoux1D4/C7y2RPPa8FBGCdB0BhwP8X27cpSE
         hc3zfw3oM95IZEAC7dZq0+n7R14vgOmst3nPApt3h1Q9nCMGcHYUelaHtujqq/tsjW1y
         epROV598VOIxzJ9fPoCxq2RIie3y2fNstsCzwkdoXNSP6YyJTerXRV1+JU7YX9BeQE0w
         q68HrPyktlNaxx989KgM6deUmRDsIwoG/Uq0WmqmBHWNO0gMHh2mCYoE93Mn365NCh2Q
         6YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740724697; x=1741329497;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwdaGyVpEljER99c37egNv+wOlRJBZC28CYJ3gOVThY=;
        b=UdDc8OirprzkR6oHM3Ayh8DcQwG8XYc3VoMWxhWr2/07enaTOABZhplXFwZUp157QE
         tqVAJabLrvXcJ2MHDutdd0agittRtukwvctn9f5HrEDWW88KK0akNyX0Jcmnd5OZ2pOu
         os022e+e4SiHH0AHG9BmQHLHTId278D8qv8EQZb3/KRXpAB6V9Nk4Hr4XA4vuq17duIX
         YUS92fwQ268EhHchBGHfMLpR3jubAuhfqaQEycZyv1B0tHa0qs4gZpnICH3R9D0YHAfz
         yNTriWx7xk0Sebv4fTOE80xUc1jndskj8KQKasd+hPDk7a1B5aFsTPl+lv+Be5PZ3wWg
         BL6g==
X-Gm-Message-State: AOJu0YyxyK+anBJJndNY5p9jUIciSTLRQRufIzYATEM2Drx7NhQjSgBQ
	E7yc2l7hsBt6rwu57FjDXR7sLcR2T8Zp65Wy6VHgVfG97ccKE4IYL7uG9s2J6SmBS5BOtPio8ea
	azfGM3rFZ6LwIfTmNDIa9/Sf81g1L1LXd
X-Gm-Gg: ASbGncvdGMJJENYwToG7wlyq3hgHrSbaINTDnakcC6NR2sIFmmZtf3CyXA6kYX89qyf
	oUwzQkq8DuBEX5KwGm0JSdKRe6B+sFNaxlYWBw4t/EMHzyARBnW19a0QpDTvlqno8grAkVCjgkZ
	603mKZVGZP5mpGZcXzCbYDdSeRE0oyIF+CeIH6qKzS
X-Google-Smtp-Source: AGHT+IFiPAqM0O7/bxkc3QWcjF2s5xZdJvorhBH7AYLBpF/hY4/Cicjv8rxQIGlvC1gTAKLmqh9vpOi7sIkl5oiGRPo=
X-Received: by 2002:a05:6402:2114:b0:5e4:9a0e:38a3 with SMTP id
 4fb4d7f45d1cf-5e4d6b18ec0mr1546466a12.17.1740724697280; Thu, 27 Feb 2025
 22:38:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 28 Feb 2025 07:38:03 +0100
X-Gm-Features: AQ5f1Jq_9krSJsa17g6xc7uaL-fEFJeBS0mzqkYWzU9pPvndQf0XO-6781cI1a0
Message-ID: <CAP8UFD2NSvRJo4XUmuWFVfqN-XF4_Qiqu2VncEdWVi00qSLNaA@mail.gmail.com>
Subject: Draft of Git Rev News edition 1ZO
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Olga Pilipenco <olga.pilipenco@shopify.com>, Chris Torek <chris.torek@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-120.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/747

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Sunday
March 2nd, 2025.

Thanks,
Christian.
