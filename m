Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO4cBg/g"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC9C12F
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 10:34:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so148985a12.3
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701282885; x=1701887685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zhDYOzNmoQ/DAopJB2nJb6QttPlEjXLbB8C0zxO+KYw=;
        b=FO4cBg/gi07Hb0MZ5xUJuYC1NVrbeyLTsyaI5KyXrXD+OXZTl4nP7z9timdCvm7neS
         GvjPp5wOV2GY1qcmUNdb2aVUDjIgJBQ2XS4BWyHVSXROW++iiNKKeqcS1qaOE903geCl
         gKk5Q7Ag/xAHmwvcRw/mYf2Ya0g2LqczWHWn0x5aJXNfTsMu+eDk5FrjQVs9jNVwk6an
         q1GKPxDfiBZuNypu/5GVCcknZk2YNuMGCKi2H3SVPA3b87xAhpjKRdF0DnROtvOhyD+w
         sZ+X4etj9m1y+48gPEdh1FOvFHrFZG3OyG0cQ7Nh+4aBOgzKQHlrm+eggn2G4jIby8Hp
         h0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701282885; x=1701887685;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhDYOzNmoQ/DAopJB2nJb6QttPlEjXLbB8C0zxO+KYw=;
        b=ORFugOpnRxEpoR55jQb0GyX/sYL4qoWH5QQiIWRX+AYoxIRyhyi87MeCgNePJXF/Y2
         d31uQPtdIjZA7wG7zRVLZF/4nZxpAhHgqyGD5wHDVrnHsRMVPJskUxEq180DW1NhoxCb
         ZyXzJlIeWZkuBbTTC8NqoOZ+IbD8SByxiq+3Pglc85NF79Ub6iv3h9rccXfMMBsGaHrN
         PS5+iPwD1XUzlbHo3XE8/JnDXx+FOSd8a10Lyfk4+LBa34jY3pVZ43KCZg8xo3bJXsn6
         y8e20z0M1IcyktE87Pi9t5ZOMq0i1rY711KE0EDQ4P9k9NBEYnwYwORYoO9SffCHz2hi
         yiuQ==
X-Gm-Message-State: AOJu0Yznl7fJaIeRWdnEw82j5gMLEaU02iPGc5f17Un/hBbisb7qcEvA
	AN5kDfvZgJ+yQA6CdPC0o0WQrFlFntULTlN7phYGh+oXmqo=
X-Google-Smtp-Source: AGHT+IG/Wi2w/o0Z+K3lV7fN3UZy0NGIo7d0KhRkfYOiA58hfWmFsUTRfVVQsIrwlcBFs7gzt3ZOAGg0cbNg3d9+86M=
X-Received: by 2002:a17:906:7396:b0:a0e:79b3:3cf5 with SMTP id
 f22-20020a170906739600b00a0e79b33cf5mr6847128ejl.69.1701282885114; Wed, 29
 Nov 2023 10:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 29 Nov 2023 19:34:33 +0100
Message-ID: <CAP8UFD0evf7UR_EQq=bRaPBePE8cTaNbKUViwbC9fjKiFptADA@mail.gmail.com>
Subject: Draft of Git Rev News edition 105
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Bruno Brito <bruno@git-tower.com>, Alexander Shopov <ash@kambanaria.org>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
	Philip Oakley <philipoakley@iee.email>, Jeff King <peff@peff.net>, 
	Jason Hatton <jhatton@globalfinishing.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-105.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/670

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Friday December 1st.

Thanks,
Christian.
