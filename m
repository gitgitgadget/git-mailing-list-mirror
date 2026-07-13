Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62B33469C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982072; cv=none; b=pnOL6iVhcYNbCjCGcGzEs0gZ2RQOHABg+ffODYjhk+Ipnlpk0ausVKM4n0LpR0QVZXrBrQ42+VFcqCg4CIiBaBPgi+XcKNlB0IGJtb/5iX1Z5jfNxQ3DqL2S14MyQAdoCCla74n7cEISFY+wtukul652pAmji/hz4IFPNwYenPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982072; c=relaxed/simple;
	bh=sUhX/RFLC610lRzJ1yRQMc0iaAu3CIbOsYVQeiRxy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W4tLIW6b5BmAZ1vYITOsFhONb4P8VzGvd+nLjQvCTArUucE8jDYlnBSwBGd32k+QRUcxyBpHV6/DRfjB8aM3c9bY3S4A3c5ln6AmxdSawtfYC/3tg/cAj0rqK4BV+M3giBfdMMancsoXhQ5F4dT5Z2wStAPHL28n/J/bfbl4iMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=O1xOwf9x; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="O1xOwf9x"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee9fad9c36so5423876d6.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783982066; x=1784586866; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=O1xOwf9x08/YKXx+Y1NR8iGss+Bp1I651UqUD9VcWh4XlkkGZmZdyCi8d8Hnj6cDyp
         vShO/VUrbLrMDYyv5ahvvo09NyTmm5BWBls9KOu8c0ElsvfIpHO0hwz+4sv9z8iDeO9Y
         6Weoqua50pbiaUH2twH61r9cuM29Tgh60gMjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982066; x=1784586866;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS4js1h6usHZuwAh5k3jfpeeQOETNf7Jxq0DoUfHieA=;
        b=Z/I4u5X8uHaC/tCXCJNxnyDP0xfD95deRdJgyt2GQtuAeT8m5fdmxJnNfF4qBFfQoJ
         I4rAsbpcyULh5+jJ2GWhLd46GkpmT89Xh+RlLOwKXLOoXWlzu9cP79/t5//SoC+SjxKY
         u58o+ZsjVtQnXfcwByAFGuP0azuhr9jYY5ppyoj0KI0203LdsxpTslRptpSxvg86NKNm
         9skZauOcjnlce+62PLr6Ct5AC6nwIWNENnWv2ZzFlEWFuKyF9ITmMFYfxv1lUJs8lXGd
         9Y3ocgGZh4zjzPqauEVkNLjK82wWMKpO5R9pEEus4aOqf6JjQjBaEXe+HAtBLlTwAu7o
         S11w==
X-Gm-Message-State: AOJu0Ywr7JKGHvMnrufVjTFuwCrxZ1ZgqdOixSs5vmJxRyWHnhhWhqYg
	1WXAgE3as/q7VuHf0Fjnkkk5hBJObUy/ZxF8Gd5bdQIrn5urY9NobFSThGBerV8POlqKEA4oNJ3
	vrCdNNTo=
X-Gm-Gg: AfdE7cm6JF+m2Ok670rH+vXTsI3FO7hSQfyx5wBlfpLEXooSW9hyAmc19gFFwF+f/p8
	ZaaEFM2pJDv9ozR165tEHjh1isBm5WTDBXsITu1Kwzfl0C7Mc8skmpZIvf2Rn1I74cv+ZcqbUJk
	JTYJSe3Ka4NjcPruNF0At4AoKdS7+qmx8MjikEfbnW7pwiZFWO+j2I4wlP9ySzSjg7jTjlo2y5U
	5l3Shs3dVqt6Azon0F7PJCxu40KO/gTpjkjOSN26qe6BVYUBcPRFWLQv3G5fASytPoNuVnMiORJ
	Hk59srygYyVZf+VelSvBmZaJvZMdp+mU8yqnjkeq4Nks+Iy8rp4xwM04onx89a0H2TTf+y/eYBI
	1sfrRyQHBSKXgkmgfxGLV8unCVW0HI5vzO9P1c+ADuDTdC0DtFgy9y3bDSwGMAJ7G4TBKMgbSzZ
	HITTktm71E01ZdN3Hul4AvfT/AtkotfhtWM5zlFuyYTo+Fr3GO5s7mCVQU/sNGqikkIJwA
X-Received: by 2002:a05:6214:3d13:b0:8f1:1359:2af9 with SMTP id 6a1803df08f44-90403461031mr101722436d6.10.1783982066000;
        Mon, 13 Jul 2026 15:34:26 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b78sm143956416d6.18.2026.07.13.15.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:34:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:34:21 -0700
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <alVn7UWvdWRAG-Vv@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Packfile URI downloads currently stage a pack at
objects/pack/pack-<hash>.pack.temp. Two Git processes fetching the same
pack into one object database can append to that file concurrently,
which can corrupt the temporary pack or cause a resume request at EOF.

The first patch gives each direct packfile URI download a private
temporary file. Ordinary dumb HTTP pack requests retain their existing
resumable staging behavior. A later packfile URI retry starts a new
download.

The second patch handles the related .keep race. When another process
has already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process.

Each patch adds a regression test for its respective race.

Ted Nyman (2):
  http: use unique tempfiles for packfile URI downloads
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  5 +-
 fetch-pack.c                      | 36 ++++++++-------
 http.c                            | 77 +++++++++++++++++++++----------
 http.h                            |  1 +
 t/t5550-http-fetch-dumb.sh        | 72 ++++++++++++++++++++++++++++-
 t/t5702-protocol-v2.sh            | 31 +++++++++++++
 6 files changed, 177 insertions(+), 45 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0
