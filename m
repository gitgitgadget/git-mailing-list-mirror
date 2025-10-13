Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CE2367D9
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373535; cv=none; b=SUFrpZexFskEd9mEo0Xw247DyA+WzpTJbofce3FdmbfdNwNRntBRHETY4Z362F68dIZAMjFL2SG1P6UDjtKYO/bN+qNC9rtUV0kLW1WS8OuxWd/DEDdcdsFbFJE/SxryUPxWGORQssN75LGgzepx9vLfJE7wYjWeHC3MVwIj/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373535; c=relaxed/simple;
	bh=DpjBDyBtISdjNE/AnuZu9HUZtBFbOH1ZvW/dG4Z/9D0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Dt+vEO50nztAe6b4+mNpcRxx8YJmOxIDKM5Yh1J2F0tnRUO2pU8XtqYmboyLNYJ6+IZbU5PS2CYuIbQpIdDsuXdzYNNApIq5ijekr0CZLkGh/qA0D5vJqbZuZsdKqnuPTf1xn7lG2M+xtTDz8ZZiSFL/tvmy7onVT5MiTAshS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqmYaHWa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqmYaHWa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso2275108a12.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760373532; x=1760978332; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DpjBDyBtISdjNE/AnuZu9HUZtBFbOH1ZvW/dG4Z/9D0=;
        b=NqmYaHWayiRSKBO1Fsa8Q2jcc35TM2KsXP2UUJkDjs7Ix/4+dI3t5qCBIClptH+1/J
         ekcvFecIpU+M4uwVOnLTjdUkSMJyIzEoy2Cxc0kSE6G6qWnpBzursDllsPF8qO7s6qoW
         T9W1dbha62eijmw20prDBya6mn4lw+64Y9InkP4MePDpcgU5m8CHb72gYX2XYkWofunV
         TPBDYqRFAW5fkKWTyvSfF1r8DRhzRCGAmEpUYdMeXomk6PCOd4CCPJ6h4VnnZWdNzr4G
         IzN3j9u+dI5kGeyfV9ADEw8H9++iRp8YE9DelD/+laEC4iHWhWAYHWe+aLUYfp3wSL7G
         7DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373532; x=1760978332;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpjBDyBtISdjNE/AnuZu9HUZtBFbOH1ZvW/dG4Z/9D0=;
        b=m6vsBiGOm7gISIvXrkQwRMaW3pGN2+Plqpu/LHRF4646/8PwUzsjOYLkykwLsfpp2H
         LJGS6F3s4CVfcIYP9+nWDGv5hav0tCZIdYSuePXOpEw2Qb58MYfuMIQgyLCMw09iF+CQ
         77tUKJfSgwLSfHpsCuDNWmvyEQgoY6hEejZmY5bcGG+7Y0hcxaU1697tQzG5dJRG76D6
         5zihvYQgYfr7008+iPXxqrxyfTOZ9eRvmLPzZx+xBWIgi/3k5KSblPOdH4RZiSjYTFBJ
         JxNg9HK30VZOTpvEd5b6/6R4fQBRQ0IAy6j2E8Rnh2it2sfLiQoMpD/4bMP1LmyBr1SU
         IbzQ==
X-Gm-Message-State: AOJu0YzVu+mHQuDgiws9h4rXoyrLKsVKgHaJHjmGMgQ1saNwaeKN2l5C
	qirSKUKWEzxe2+XOyMGHF/a0O+QGYB2RLTDnnignloxe0vgemuh7fEgGbs1FDuys77C/G+MGrXX
	hnaSyvCRinRA02eVvLEpqTGDgwE13lL0JJKDFEHUGJQ==
X-Gm-Gg: ASbGncuypW8tf/nGqw4YIQBxMDIjLUykN4ozOuy31kxboaCM9AKRVqQGPBN6aIkWB+f
	J7hI596zp1yyWacJV5+M8+R1FBHcYTsKaP5QpXl+FDBu69p3x7hApYyjCr8pJyVKR231HrOzvcp
	sw7VxHAhSPNa3liySBgbjsUZHs+nOXFHmjWrwhOYjb2R+Bq2wo8JluYKKzWRERIe4UcOmO53ht0
	0rFQD9JeUJYH2Z/jxfU+cDyEvIgugsaSPZ8DDEL/lwTk0CSAlFI
X-Google-Smtp-Source: AGHT+IEFTDvv2DsNa1gFLDBZ6HOGwZC7eJPg3R52OIlIo83ToHTvBkhOsPLjN8bLP942Mvk9pNFA9tTxZZZjUfHI7C4=
X-Received: by 2002:a05:6402:210d:b0:639:e712:cd69 with SMTP id
 4fb4d7f45d1cf-639e712dbf2mr17605932a12.18.1760373531467; Mon, 13 Oct 2025
 09:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Queen Jessa <queenjessa34@gmail.com>
Date: Mon, 13 Oct 2025 17:38:39 +0100
X-Gm-Features: AS18NWCzkev3MinVLRtgHcu2ehFOmJS3tzRHjBkTSBB1_SbaQVnagoecSh_07Xk
Message-ID: <CALrKrsRS3ezovHJsPQqeUb=3=uQ65pkxczP35UFnNd4WtXnv8A@mail.gmail.com>
Subject: =?UTF-8?Q?=28Outreachy=29_Introduction_and_plan_to_start_work_on_?=
	=?UTF-8?Q?=E2=80=9CReduce_Git=E2=80=99s_global_state=E2=80=9D_project?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Everyone,

My name is Queen Ediri Jessa, and I=E2=80=99m an Outreachy applicant intere=
sted in the
project =E2=80=9CRefactor in order to reduce Git=E2=80=99s global state.=E2=
=80=9D

I=E2=80=99ve gone through the =E2=80=9CMyFirstContribution=E2=80=9D guide a=
nd explored the codebase.
As a starting point, I plan to work on a small refactor that replaces a dir=
ect
use of the `the_repository` global variable with a function parameter
(`struct repository *repo`) in one of the related source files.

This will help me get familiar with Git=E2=80=99s development workflow and =
contribute
incrementally toward reducing global state. Please let me know if anyone is
already working on a similar change, or if there=E2=80=99s a specific file =
you=E2=80=99d
recommend I start from.

Thank you for maintaining such a welcoming community.
I=E2=80=99m looking forward to learning and contributing.

Best regards,
Queen Ediri Jessa
