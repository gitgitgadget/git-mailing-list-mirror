Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4061862
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869066; cv=none; b=B5264XgZfykhy7wQz39CZofWEn9Vc3OT1vGtvEMizrHSBA+61quOJOJcIdQigHsm6gVi83XLfnasHkakGtcorK/GcNGPEepz6R3D59UAibP5enRv/YNIbfW65FzP1j238PGmIfsvXX6MnoTrNHBlnCfFWgUpadeCw/omSpOsSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869066; c=relaxed/simple;
	bh=qYmQFbxVyizZwC08WeSTIhDI5sJ2yoxE+r1xSSYxArI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cSC6pJ5OAfAQD2B1nn054vG4C3NgdWtFz/VanoVF8I/N1Zg8p5Txhqa8t0/UV1xC+I7H0eVhg4r3CgQiB3MRjvc7EPu3+LBYHS9smdlf+8nRUtzZHPqjjHdxfoTW5uS9NJ/ri5718QC2qAezi8XHBbVm5QHSDZpeNH6wOBS3SZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs/XHAdI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs/XHAdI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794acb33578so16394757b3.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769869064; x=1770473864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LB2lZ+LqS+PLrQYsUKNPYxe1MozWYGQRonkQ+Y/emcU=;
        b=Qs/XHAdIagkqDdNOqwCGkNo3f+y76mf7XuK02x3Sd6/L51sq3GLjBeMNp79UkYVDZW
         ztjplAZK+YN6G3r3lFPJGT1gMLT3Sg0luOU0PlIUWXrKwIpZPaVSlmBF+DW2WUSmxDfn
         ryBjGZAx+hVi+r7uX90ea44D7mG3uPFpjO9d5RR52MT+8kFbLpVa+hRrwXXbK+rYwe1V
         kfcnwL2MzmvV+a8ansQR4SqY3/pIoAFHlDXa7uHkCFHwzB+ltTOzxvI5Ko5mH9g6herw
         GxCot24qnEEvTy/vYaSPn3IRa96OVzBb2n6ko6okzdUWiBiIRlBdfnZEDXKA/3hZCcqS
         Pmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769869064; x=1770473864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB2lZ+LqS+PLrQYsUKNPYxe1MozWYGQRonkQ+Y/emcU=;
        b=pE75pVK4WhXMjKOHNri+aiwoYYlHq6w8mnaOy7fAgAJAA4SrypGfeH4gueAN9olaB2
         IQOjsaa3uf4iz/vPX5V+qJLj0pqSmA3BH+8j6bSJdKaNNgbP2LlzUCNqCWQaLlQ8pA/I
         bQJwSQX/f6LLQKzV6Txv3PpaVdjzkRPxj8mKYkVNaPQx4N/DX38FqxDb36kTVGMaro1C
         IiMHA/fXuFt/Zy+4s64rMxNd5IMIZViJCoj0ZgIZ7kdTPQguIXUtU+/Uc02LzNnq9J4u
         W72ziPTTKumOwQEvKt+K36qcbZJxNLlmM/0r3w5LaXJttLUnNhM5V3EK+XTx7N5UoaNV
         bwUg==
X-Forwarded-Encrypted: i=1; AJvYcCVwGzARp67klpkh6olwfdVwyxlPkwHxrE8wCRAVjQV7U1XahOeBpJliF529RK63iEJvT+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3H8zMd7WS3sPkA82Rh/DUuYNUlBS2EYXEBqV75IGjwJ8RgBB8
	1DRKGHB3ptzniAX0E5LKHdP+TkN6N8q2C6WFA/xrpaVBflxHesCUkzjB
X-Gm-Gg: AZuq6aJrCAYE+MOHylfoRg5YjqzJFxZrPo/IRXmTVpwjceF8kyLtigu5U1Hplp4Nn+f
	i8poODqPBQ5MiFyBwbt9Bo84nreY3KSCdI1hWmRekvyNVFDfBT59bun1fIXmBUlPQnclWb3XVXq
	kW6PnnZrFFDX9bckd9+iKOUK+V3tccbxdInqobNsSQIBAfBX52CpsDOHqLKO1qr0h3MRDD0eIjt
	Q8MyaMpmArHESFIrDYYPLzqu/zor8iFhsKWyZ3eP5+olo/9LnvereOkxBj6vpREeYosSPlF/cXr
	8huRa1Xw2UsDrmHAALdi3qzdkrq9LAQk9kxE6Fa++QESvojlLDcnV5RjnjtnhWBcB9W9tfWuSAl
	TOSjWGOvvmJXpMiHs/knikB00heJgUXtn+CLkJWq1cz66KzjaJ5JNpZsmjOmO6T43wC6hVTDisf
	vF9ShLWTuRiD/v/+rlhUnrs9FQoKHWfuI57cIjDfmsw2jwNqvEHROATwQ+MQvdJoa4hyEJ1hTUT
	QYl+PMXovZ7gI9Y2lI/8QyuFljte+K8v0PJ1y3YT3xx8L8AmGfPk0sIkcmd+rpwiZBhHdzLIso=
X-Received: by 2002:a05:690c:6b81:b0:790:8708:bdfa with SMTP id 00721157ae682-79490c00663mr88996407b3.6.1769869063655;
        Sat, 31 Jan 2026 06:17:43 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828f75f9sm46755167b3.53.2026.01.31.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 06:17:43 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?q?Aindri=C3=BA=20Mac=20Giolla=20Eoin?= <aindriu80@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Arkadii Yakovets <ark@cho.red>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Emir SARI <bitigchi@me.com>,
	Emir SARI <emir_sari@icloud.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [GIT PULL] l10n updates for 2.53.0 round 1
Date: Sat, 31 Jan 2026 22:17:35 +0800
Message-ID: <20260131141738.1173403-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Please pull the following l10n updates for Git 2.53.0.

The following changes since commit ea717645d199f6f1b66058886475db3e8c9330e9:

  RelNotes: a few spelling fixes (2026-01-27 12:12:06 -0800)

are available in the Git repository at:

  git@github.com:git-l10n/git-po.git tags/l10n-2.53.0-v1

for you to fetch changes up to 532543fa46caeaf03ac6d30116faf1a0cbc117ff:

  Merge branch 'jx/zh_CN' of github.com:jiangxin/git (2026-01-31 21:32:54 +0800)

----------------------------------------------------------------
l10n-2.53.0-v1
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE37vMEzKDqYvVxs51k24VDd1FMtUFAml+C8cACgkQk24VDd1F
MtX/AA/+L3XJD3hcwz6BbCqZdIYSdj324KylNHHfsNZ0jw6DH5SwAR91/6VM4wzH
7yqelAYydWwp265EkfGQNSxY8zPL5YCAd9/xYyNG3oZu7wbJwT13KovWgX2sXr43
dWXFJIurXNBpiOeJi+82ghmaRS5SfPW1YFConUFj7zsFq3Bb4iXYt2KZ65FpiR5Z
JJEkqEXi1a8YiuO/b0kTior4kuHyEyOVnzI7OrQihhAls3YQvf8L46zKcDqr/gPp
6MoiNIFPWomyJl0stNRb9W5w3sr5UDgJ2aR/qj7MutA/2JN7mOqmCB6uGroMmxCU
FV+gBqhj56di/+sQ0c446NLPUa3nSO4JP5TiUO8MUhP8BnEGopemngpyJLpWzhSr
0tG5LK32RtMmszBM+XNV247oWL9IiePdhcy6FZr2JIRrVGBpN6RtkmlRKcdAxUIC
7k+g4u1LzM9vVeLjm8brIMQ78TLY2tL/eOl91fl+5tTRvsJvC4tydIaqEb1k/L9/
sCj5GMmVs0hxdXMXLtArlbzYvNl0cwkJnqehpQuFkowJmqjAnAV9gKUkId2iaRQh
TGq9ukCSzwn1XpIsC1o477JoQm+hzCFOFXCESuj9+il4ndfZ+BQgsp7Omb12U0TY
f4upg2lJJokcoqd0HJoXXD2dkayZlslVhwY7X03BlHRd3VRbiYk=
=MkCD
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aindriú Mac Giolla Eoin (2):
      l10n: ga.po: Update Irish translation for Git 2.53
      l10n: ga.po: Fix git-po-helper warnings

Alexander Shopov (1):
      l10n: bg.po: Updated Bulgarian translation (6091t)

Bagas Sanjaya (1):
      l10n: po-id for 2.53

Emir SARI (1):
      l10n: tr: Update Turkish translations

Jean-Noël Avila (1):
      l10n: fr: v2.53

Jiang Xin (11):
      l10n: zh_CN: fix inconsistent use of standard vs. wide colons
      l10n: zh_CN: updated translation for 2.53
      l10n: zh_CN: standardize glossary terms
      Merge branch 'master' of github.com:nafmo/git-l10n-sv
      Merge branch 'tr-l10n' of github.com:bitigchi/git-po
      Merge branch 'fr_2.53' of github.com:jnavila/git
      Merge branch 'master' of github.com:alshopov/git-po
      Merge branch 'l10n-ga-2.53' of github.com:aindriu80/git-po
      Merge branch 'po-id' of github.com:bagasme/git-po
      Merge branch 'l10n/zh-TW/git-2-53' of github.com:l10n-tw/git-po
      Merge branch 'jx/zh_CN' of github.com:jiangxin/git

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation

Yi-Jyun Pan (1):
      l10n: zh_TW.po: update Git 2.53 translation

 po/bg.po    |  576 ++++++++-----
 po/fr.po    |  534 +++++++-----
 po/ga.po    |  627 +++++++++-----
 po/id.po    |  568 +++++++-----
 po/sv.po    |  484 +++++++----
 po/tr.po    |  499 ++++++-----
 po/zh_CN.po | 2767 +++++++++++++++++++++++++++++++----------------------------
 po/zh_TW.po | 1068 ++++++++---------------
 8 files changed, 3811 insertions(+), 3312 deletions(-)

--
Jiang Xin
