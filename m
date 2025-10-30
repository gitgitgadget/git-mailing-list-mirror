Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3DD285CB6
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811208; cv=none; b=iiAVaFfK4HRrf6FPuwmvXy0WqIBeH9NT1v3d64AOf95IJXputj1rge6nHzcQ+9UQLEw9cyyrsJRM4M/mRp0aLdPvKALkitIdhtSyuEE+1XrHapEdc36Z7VN86I52JktDfR1aY1vB4vDpdcahwGisBF9i5CHg3TovqBD4p5Y7mt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811208; c=relaxed/simple;
	bh=RJzhP66oLiBHMpgVOZQACZiWSNhmjZ+Tj5URlsu3cOI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YxhOeWXshtWr504ojYA0lwyhZkRHfgeWKg9bcU/4u3fcVfL3NJV7ZTAK9yiXMlJBIBk7Ym6DoARuWEgVmCZsfiqXx8PhyNr4yWkHhIdKZA/WAuhoMAmaavQXf+aA6Yd8FpTtYoRU2tzrBaHV3YAs2QcPjnryBVn+MIb0NaluKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldwF/AXT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldwF/AXT"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so1104000a12.3
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761811204; x=1762416004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=352urKWraBrufjJV05l39qDQ12wDLNezHaFib6477/I=;
        b=ldwF/AXT1VsZzFf2c4cNJeGbOxBhqBg6ud4znQdAIxFkquVetkdD+gCjTWgwYtGj+C
         NpPBKFMLPIFGl8ptV0/efgJ7ZKClXo/LHsgiSN2Fr9Rjw/013ZuBpmDVdLjBh2w7ukjZ
         Hx8BynbJdBi9AhFgsqyXinz4cVwGjkWcqWiUA2IFy7FtjEu7KP4PUW5XsNmBMYJBnRyH
         BZw/VwFRDq7e5dLXwiMZOSruhbGMqixz0w404QIXDFDsC8weBEMQrtjCzGGHGaC43PlT
         yKU+wl8Rr8cgNC2zUjxKjejKFdw6VJ4571LNTqQX+WH/qM7YGmlxu2eJFWn3irXmvUZC
         KzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811204; x=1762416004;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=352urKWraBrufjJV05l39qDQ12wDLNezHaFib6477/I=;
        b=JkiNC4pmgBny8d791d8mMHkwMMEGvc5muon7eX+7CSHA3+0FtgFv+i+yeXgTmnpFoZ
         oqo9VEzSreUsqUjU1YBxgKeNFstxomIb56cBdUitoDU7fcytX/1Z7OfEt4vrDmHgD70H
         SvbFWsy4QlT7MBn8yEkvhRXEh5ZDIz5pQkwvy8AzgUxaEFiD1PVZ3UxVFzCXOLTGoJGD
         hBqQue1kJE9upsQkTRzsJCreo7DCf4o9Jlqo/RnXstHqaZT3RzMdXsHnZLfXrss3H1Ks
         CjgeDrYxtv3xzMKFiKsQ+G7RyQwpW+zrod4irpa6bJicG7HFAHxKVJr7wwgTXtuumOLA
         64ww==
X-Gm-Message-State: AOJu0Yzr5corJvbTVE2mJkCcpkepuK91HrcWXXc5ci67IGAuJ2yDq04x
	SDuqWwfpNY20YXqOmS1zkakz0KZkM59etLO+/LXcBi5C1dmIaBfgcgn1W4y1yVp66uUOITiDM+2
	vBp8q0Qf3WIl8ZbYWUqdqq4HosRjATsklB0Vc
X-Gm-Gg: ASbGncstwiAB3OrbEy03HqKQgu/dCB582m/n49s0G9tvIAg6fORtyLM8sooXxrL2xpp
	/PhFNg1bpXSRbk9rUZ1V419YdFtYCr5Lhyt+m+ZwlcYbzVQ9lI2psiVRkZ19H01MuEPZVsF6I36
	ZuFY0mLqInLb89gAiSYzQ8f1waj4cC6WyXOfZh1hdnE4vkF51BtrRuOdzw3MGeULmMKi9oXRldv
	C2+9alIppIaFNgtbAQsNu/TBXWYnq/Ve5X6G3DkwPDgvF8nbBybxT1W9SJ9PQssaMvPBbd/kvCD
	H4TtYB6ML3p2OvH3AnAM05prKg==
X-Google-Smtp-Source: AGHT+IGAl0fVhXrHQWeDUto+4GrK/jjvvnzNamu94GJWqyYGEFZYVwHAs9QRrC0pZUj5HUu2krCzHjhjAviZkY42KUo=
X-Received: by 2002:a05:6402:3514:b0:640:6700:5972 with SMTP id
 4fb4d7f45d1cf-64067005e43mr1171326a12.0.1761811203860; Thu, 30 Oct 2025
 01:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Oct 2025 08:59:51 +0100
X-Gm-Features: AWmQ_blime1gdzHT7xL0MWoKqru-Tj3JSqvVsukF1blDt9QRNSfgxsVdDzB9EBg
Message-ID: <CAP8UFD375A28P6hDxj9rKOjZCCNtSPh1UnLT244SBW+wu3vUsA@mail.gmail.com>
Subject: Draft of Git Rev News edition 128
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Lee Reilly <leereilly@github.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-128.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/805

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Saturday
November 1st, 2025.

Thanks,
Christian.
