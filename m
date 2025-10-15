Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45C33A02F
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547425; cv=none; b=ileWQ5EUozPTd617z3vNxbv0tPz5/V2t6UzZGtCw6yc4sjlHfr1QegDwdHIXBd6qsVlA0Yp6R/soYYF7zYAI94jdSWm+i4gpSf54v6B2vxL585Dht5MfyBDRntze/xuqVVX/5seRfZjlqgiqpVd+c8+bNkMekvB9UJZLxDGRPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547425; c=relaxed/simple;
	bh=8nUgjxLnZFwaYFCA3yuBDLEhZrnnL2npUg8EOVyibGw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=C+TkYLh9Yaj+MWrfwZCYYfGpkYIvC5JDReAQoez2JDDEdNr5+1PxGCJLAXXJDMi/ZT1omyR+76IeCByX/MqVSkzrBqNK+N7AWPy/JMBeiNVgtn8E/SxrdQStbhkWzYtOoczK/EYEzWncCPgXliYsQUUMQzHHEqHf6bEimIb34GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnSo7iI4; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnSo7iI4"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63470a6f339so6685121d50.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760547423; x=1761152223; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEa0z+zWqSCvzdoDb8yFBljnL1knU9Pd6lm5c4FwEhU=;
        b=AnSo7iI4S8Sn2Xx3bbcbpbwd4DPUSlxkCzcHaMqifL9yeewysC5jisDPHeElJ2cqtG
         bgVXOpAuDCOFc9LreJmDJZYCF8v3gD3rFbtGj0pAdYsPYpytltStpTtolmCPffeZZSLz
         DuCk2QBpFJB8LkJwG0B3HecOkIOIbMOWHGGoU9hGq1fwea+mi4MtJ3+zfZwVGwrHwYTi
         gMUmhUGbhcAQUUM3BlxIvp9p0i+bJehERPunxvKY0RnGJpL5GPZAOviSRksLmCVsnd3N
         DFPvQwA8bjyp2fgR7PrLmI4mSif+3FQnxHC0sYttWlne693t6ekGboROeOSrO8u+bnkG
         OxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547423; x=1761152223;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEa0z+zWqSCvzdoDb8yFBljnL1knU9Pd6lm5c4FwEhU=;
        b=MUKZ+Ueeu21cG1pISEwSS/0xV9z1Wn2E1pa98cBz/qrMxl+VBZpxuFdSqWJYRhEN5P
         vdKno8LKkhKSmNMuWyOxyD3vrx47pSq4M8gA9PDfERTRjhbuh2fZBv8y9FjFYulkzE+j
         THdAG3PRySQH6rGBXUc8ebBliTRpdt6HnOZl35LAWvggci33weBc8Kr/tnQWEG+aZms/
         SnnNUnP7lCrj0WGH4Eum8xrNLdBGVJ1FS5P6jj+fAHMNPg9kWSpSyKf2SQq7xdO9HSDG
         ZWyZqrkq59IzzYbl3xIo9t0y8ecXe2ioZQsFlQ3x/tcEJuIVES+2CDEERk1wf9ioEm4z
         Fzag==
X-Gm-Message-State: AOJu0Yz2rMShULo3rlZbdKTlw9WSS5Q7kqNF9kJohpATatgHZUe163aT
	/98Jm64i5lIBzY63zUDYR7IhPtxMBn/uhHEilOc3cOxXOOENi79SEwYA
X-Gm-Gg: ASbGncv3tyEdQKdgySUJ+yrzhNhMYawK3lieEfqwiQ1ypPpo9oxyIpiOgtH7ix15Vbs
	LlsmmAILBiM4/ovIDhAUMyVPBFupzuk8R029OgAJTnQhjx3Mjk+c8EAH/mRllr6Dwk4iVojyphp
	z1wj7ZxJgJZRuMzCra8yIgUBv+sQw7BMCmOqHwmghdy6rkD13nvx4VP+eiQsU1kgnty+vAITPWB
	l0YRS0/fCuWSEQj7tuQ5Wi9HEO+iy+ZX1yzo8abNkXDNZqO5bFwqt0M6mTArtrBwDRvPRadeH/p
	AoasmjCjlNSlfWpScmhLiY84D2xqhdMxx3H8r1zKFmsj3nU4cogvXAx01VndArce9QvH2V5SJsn
	lJcqRpzSEAVj5IdFBV2eDGbUSt8MuddVa0mNFebqpkQuuaKwVGu5X+olnD4i001gracvSq9Eiqe
	Irc2IT
X-Google-Smtp-Source: AGHT+IFfwEG3Vh/SQDtMHHfBNcdVr6cIMoboUZJjLmlVLQ+eD0qYoiHvDdGqpHMSA/8FetRYadYocQ==
X-Received: by 2002:a05:690c:260a:b0:72f:d215:60a2 with SMTP id 00721157ae682-780e1520605mr475546237b3.7.1760547422792;
        Wed, 15 Oct 2025 09:57:02 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:8da5:cfa9:dd2e:9131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7828cdd2645sm517877b3.12.2025.10.15.09.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 09:57:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/4] doc: git-pull: clarify DESCRIPTION section
Date: Wed, 15 Oct 2025 12:56:51 -0400
Message-Id: <0149FFFE-608D-48F0-A80F-D2B76D943F9B@gmail.com>
References: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Julia Evans <julia@jvns.ca>
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 15 oct. 2025 =C3=A0 09:13, Julia Evans via GitGitGadget <gitgitgadget@g=
mail.com> a =C3=A9crit :
>=20
> =EF=BB=BFI got feedback from 15 Git users on the current git pull man page=
, using
> this tool: https://text-feedback.wizardzines.com/git-pull.
>=20
> My goals here are to be clear about the relationship between git pull and
> fetch/merge/rebase etc, make sure users know the current default for git
> pull (--ff-only) since some folks still remember the old default, and to
> help users quickly figure out what command they need to run to
> merge/rebase/squash/etc.
>=20
> I've taken a pretty aggressive approach because I think it's possible to
> have a pretty short and focused DESCRIPTION section here while keeping the=

> most important info. Open to hearing that I've removed too much.
>=20
> This references the UPSTREAM BRANCHES section from
> https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.17577=
03309.git.gitgitgadget@gmail.com/
> , so if that isn't merged I'll need to revisit the approach here.
>=20
> changes in v2:
>=20
> * Add "(excluding merge options)" to clarify which options are passed to
>   git fetch (from Chris's review)
> * Say that git pull will by default merge the upstream branch. (from
>   Chris's review)
> * Add some links to the UPSTREAM BRANCHES section, and to the <refspec>
>   section in git fetch, to make it easier to navigate in the HTML version
>   of the docs at least. The situation where we repeat the <repository> par=
t
>   in git fetch is weird but I don't have a better idea for how to handle i=
t
>   right now. The UPSTREAM BRANCHES links are currently failing the
>   documentation tests, but should pass once the patch series that adds tha=
t
>   is merged. (from Ben's review)
>=20
> changes in v3:
>=20
> Change "fails if the local branch has diverged" to say "remote branch has
> diverged", from Junio's review.
>=20
> I did not come up with a better idea for a word to use than "integrate" so=

> left that alone.

I=E2=80=99m happy with this version ; anyone else ?=
