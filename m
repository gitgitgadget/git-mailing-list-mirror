Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745422AEFE
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149751; cv=none; b=OTo1Biizqjv8jIg+LeDbck93r7q1n0oj0bN43Lur4qshglGM/aVVMMkgBgUf152qjfnN3KGEea8ekKfGNxcqh1rWsH1vyXYHEHO8IBJ/27ZgYjfy8By6J71RIFpgrEnYH4r6G47E+RDkMm/5UbhvWeFO8Mh8jiUtqaxwaKqfLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149751; c=relaxed/simple;
	bh=h4Zp+1x0Rrus+cVF7vls21aRG4pVPr5EdDT6jopBmjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qLT0jyyAhomPBKGHvAXJVIIRMHRVqmsAFsGIsoCM4kxx/RCn7IsbCiqYmV12n7ACmCTDahByb3dwL2r5llmL1LkGaYbXYX8/tcaLq8hLX0T3s+zd1h5pCaOsD20NPRZed9vJ3afIUrcF4BKbH2sfPnnKEhHICCkXbz8hXtdMbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZlJdXkQ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZlJdXkQ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso18766242276.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 23:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736149749; x=1736754549; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hwe8ngaWJK3SHkuHO02Fy/wLPl17bVdhbxOe2WN1SE=;
        b=CZlJdXkQshqiX5PcZD+RpLShLNLdPdC+GLkYBKYPz8zeHYD21uF9Q+OAXVj0z6zvdo
         v0WjCp8SJiIfTUFsYmGCzFl5+1kEOfMgBbQgkSfvVc1iMaA5Ja8phBdfQYAmYA35LNVN
         jodt4tOXiWA8b5W5Ypuvkn1gRVlXnHELlCeUruL7w4oyqVOSOAtQMIrrBj9TuKj6vpxc
         W7ABT8Mwwn1UHNVG5pzGdAsgQflNvOlvS72NpaWxCEfWnD9v8cwRi+dfp0IVLah57mSp
         +oSyxLMc62DAgtdS3x0X44Scs6wYYMLs9jttBTCvFIoua5ZhWfn9jhHIE2Y49Zb/q8/8
         3DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736149749; x=1736754549;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Hwe8ngaWJK3SHkuHO02Fy/wLPl17bVdhbxOe2WN1SE=;
        b=wTksqYqB91mEOslMCrS3Uvow3Dcxiao6otVtG/dQRAc61U7Uue2mupGGzxpitdJy6j
         JHUVLHE6J/+PLjIw3zpppY/OGaqnq+gtSkb7z+SANWiLWMUvBjA63AuBJNoy1NvbF3Wy
         MNdRcDRvFt9LsS/nfn1oAhdzfaSQIB9Aixp6rknHZCu/hPCoFWDE17AEZH/MWBVGghSR
         Let0ZpwtoWPTtl1lrJ9O60ymEJ+JfySWe4BWpysoFtjQmZzk8oF8g12/AXemrMz3o3p3
         Y3qC+35EDy35ChTyu/qvPGV/jl26BtvtrLszkRlUhoVYJJyv/8OavutZjLjnRsFkhxq6
         M1Ig==
X-Gm-Message-State: AOJu0Yw6dRR1i0xc85UMLRuUbaUDA8yqwCe9inocP6rDYxnGqmkpC2hW
	trGVcp/0Sv/6UMAREaSRW8csqan4vHBrATz95MsjjIHo/URJoRtqQADYm1kPKo3tF/fq5YUCz3g
	ctMRAXLibrgow9rzSNRM3zSkljpdk355f
X-Gm-Gg: ASbGnctCzz0xNMp6QM8OBCwVltYbUclv6kYl6Wju+/qywAlMF8Z5N9vVH4lQjNOKAZE
	SLJtgkkCTzoy+20OvulyPqIOLi3I1A192pd0+fuU=
X-Google-Smtp-Source: AGHT+IFPi54BMKqNUAi2w02JgspxkWGnMFObzIfFnNaeFjAc7WPUbdur/L1j5nhjT8aUl76TFSZQu86vJBDe26CSqXw=
X-Received: by 2002:a05:690c:d1f:b0:6ef:146a:aac3 with SMTP id
 00721157ae682-6f3f80d6139mr434262787b3.1.1736149749374; Sun, 05 Jan 2025
 23:49:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217020843.27943-1-worldhello.net@gmail.com>
In-Reply-To: <20241217020843.27943-1-worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 6 Jan 2025 15:48:58 +0800
X-Gm-Features: AbW1kvZa9FKIl0jvhWz0nq2DFJ8LZWx0lATtEIVgWbixHQjwYGGuSdmkQbyOoGE
Message-ID: <CANYiYbHBvmD=F72F7MYptSGYGR8rCht09zQD553PZmuyrk_o=Q@mail.gmail.com>
Subject: Re: [L10N] Kickoff for Git 2.48.0
To: Git List <git@vger.kernel.org>, 
	Git l10n discussion group <git-l10n@googlegroups.com>, Alexander Shopov <ash@kambanaria.org>, 
	Mikel Forcada <mikel.forcada@gmail.com>, Ralf Thielow <ralf.thielow@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:08=E2=80=AFAM Jiang Xin <worldhello.net@gmail.co=
m> wrote:
>
> Hi,
>
> Git 2.48.0-rc0 has been released, and it's time to start a new round of
> git l10n.  This time there are 36 updated messages need to be translated
> since the last release. Please send your pull request to the l10n
> coordinator's repository below before this update window closes on
> Sun, 05 Jan 2025.

Will wait for the release of 2.48.0-rc2 to see if it is necessary to
start a new round of localization.

--
Jiang Xin
