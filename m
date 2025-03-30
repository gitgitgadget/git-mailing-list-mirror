Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F14EEAA
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368616; cv=none; b=gGpJ+/neAayb+Jj+nA21vphpG3ad7dQSlfIDuvtjL98oql50Bj4iH67vcyyDFhID8Xl4ZEr4K7HMrBOwJY0Csx+eKVoFu9FduBIZA6TdE44T5ANYFwjSccCAbjCKW1cBr9xbI3/zJBMvtVnVHe1ppD2MxriQRlmkQINdRx+Lrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368616; c=relaxed/simple;
	bh=2uJ0OK3x1+alJOML64FJxYsujJr2RSlQI1fPX5I55pA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RXQqb8Xw9BTbA7avbcOpgUuQEq23dVMw+02Cpq9IHpv6jkkU0jdJWpA2XfKSyd78AcwQE0YOb7WKRB4gcQhMHzwtNX9bkenLcCZ5jV/FqS5VjcpdEwVwUdCGrl6/qoCEpV2zy1cZ2koRVvry5rw1RUpt+QDtouQE6XH4DxiHog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOusmwTX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOusmwTX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2938098a12.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743368611; x=1743973411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bhUxS3jvkC9oGjJoHGWSq/9C3BCL4M2SxvxUM96uIs=;
        b=gOusmwTXoaiGjJPmhyU0hLyDCX3DN7Z/LAiA+/lu0D+y/I4JqmGiVF3ic92hF+GKAP
         T8Gf9yfdjYPTXr3ueccPheZ5yRuFm3DnhMJRWXUKyPbEWa1EzB87bT6tjP0gkJYM+uqW
         RSHqBy64IW3Ah36ojFisblwGMdAEYzie3xger9JlZmdqMJ4ytwIV+gaT8PzKEhhs5kyo
         qoaBDiD1vSXRDU6G4PDOiFg8cuz8DQ7a7iNnaVGUIjvtKxTDIUduT4raFl8YDs/lojc/
         5y4DRAzRH+hlhlhGo74G3npcxZ9QAb1E5oEij41jACFRQINDFbNPv37Sh+d/jDuDyPlc
         BkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743368611; x=1743973411;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bhUxS3jvkC9oGjJoHGWSq/9C3BCL4M2SxvxUM96uIs=;
        b=bX82aV2BmFRMARQZzKim3z6wBBP2Snl7I7K9b34U47Fbb+pRb6JlX1dtY1IXVFHb03
         IGHFl7dmYoZANMWr4xYrxZbdGBQtNUMazxPeJKXl1GbN3sJ5lpY8SfQS0mzQcO3+EVVz
         xOKZtyCwq3LFwmVpxpO8tuMptUeMEu9qSiD77ocmCQe8PaCbB2eb2nn5cAsWsg2pospt
         pPxxHD4/MNRCeMjsnJtsMb4UD+siXrtggy/m9Gx9KObCzl56pM0CurltOl/YbAukglkF
         YS9locnNRmwDHwg2RP7ZT45u2PG/tPypDzrloZ801TPydPmXjt8dwV3aKmLdggITa8zr
         jaWA==
X-Gm-Message-State: AOJu0YxU2P+KtCzdhyyx2dVEZz5IwuKbUqOth2J+9Sx0VmmJ5LtLByFi
	nFbIkGMjgfWstJmUtDpmOblMN/jVGGNFVRRbUFVfSelFkg44svTJcZZoxilY3OQzsWZmiiTdYmo
	bNX58qj1no7WuH/DwDTeKQaQTuexGwOn2
X-Gm-Gg: ASbGncuhxI2x7vzg37V/S9kNra5W3Bnx4l3Lylgq3CzcpPd8YDklHANgUb1JYK13hCX
	kSEH5OYp6BPklp23am6HAdOrvfD7rXRG/bCoPC3HttuMHX24AQlB5oIjSDNAQ4ZKoplIW/Cjn0e
	etw6Vuo+Eavgq4wtISDBWs2Ne6ZK3k
X-Google-Smtp-Source: AGHT+IHU/JwaJ/Z/W1V/yxl+yQu/5ZSwcXLcEi2HjLFvlFtyrESWSXwz8U3v1O80ju9o3QAsLkUB66z7z3Si3c4Ra6A=
X-Received: by 2002:a05:6402:254a:b0:5ed:17d9:91d4 with SMTP id
 4fb4d7f45d1cf-5edc44e7895mr9468849a12.8.1743368611162; Sun, 30 Mar 2025
 14:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 30 Mar 2025 23:03:19 +0200
X-Gm-Features: AQ5f1JozeW7qrpnk5rBCeKnDvD2fFmBzAr_tlddXJb7VrmeoRzpwkUz6j9UicwE
Message-ID: <CAP8UFD2KXVB3w+YSK04oPZ3rkoCgzW_V1suTO=ipxx9w6HDn1g@mail.gmail.com>
Subject: Draft of Git Rev News edition 121
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Elijah Newren <newren@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Philip Oakley <philipoakley@iee.org>, Andrew Ardill <andrew.ardill@gmail.com>, 
	David Pursehouse <dpursehouse@collab.net>, Jeff King <peff@peff.net>, 
	Matthieu Moy <git@matthieu-moy.fr>, Lars Schneider <larsxschneider@gmail.com>, 
	Thomas Ferris Nicolaisen <tfnico@gmail.com>, Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>, 
	Nicola Paolucci <durden@gmail.com>, David Aguilar <davvid@gmail.com>, 
	Mirth Hickford <mirth.hickford@gmail.com>, Seyi Chamber <kuforiji98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Peter Krefting <peter@softwolves.pp.se>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-121.md

We are still working on some stats that we will add to the first
article about the 10 years of Git Rev News!

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/753

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Tuesday
April 1st, 2025.

Thanks,
Christian.
