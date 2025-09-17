Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA35221FA0
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077672; cv=none; b=Mrxpyhr0+Su4DRUEeSt1xcbgj/zShIFFy9ZmsrQKgBd8ZBZ7vptmgsB4C+1DAB4e/s8jp2HpTDsQigeayMoEkfFvYnt532CVKIOxU+gJovft46l3vI3jNJCCkXwCcY+DEpkEsbxJCsnjdmQBZMianmEhVhMWJhcm8AYBc4p1PU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077672; c=relaxed/simple;
	bh=VbpAsgQINljBFHnB/zyHMInxl5q4F9XEUlfkwJtND14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVBSGvdCpeoaSxdCLqHH+/2tKMUqN4vLMUAXX4VKoWO/JMj8njLYnwdgafcXC9UiUCpXr+KGFVSnpGC6PGycCEyEPeJXnkjerxXE0LvmbgdyJLoX6sWcJulgepMDckhR/KMklNZB5FNM3lOoTcK+aRVSfUPVj7U/W0Y0GogKvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeVAmMZK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeVAmMZK"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-423fe622487so46014325ab.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 19:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758077669; x=1758682469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flEG4uehFi7GqyLzGvohKFuWOoKanxZZMelOcKnuBrE=;
        b=aeVAmMZKnxjHlRcoG7WDgqYoBiYOooar8hXsVgHq1Gt38zSu9pV0HOFydm0jtO84nx
         vVSTQbCPgy9OiNocGSbAjVSM+odvqM5ce+hENTHpnrj90Q97cjWsTxtS7RzlGotVZP5Z
         RdIBipLWL2EOVg1Arlgdy98NbBxPZWaDHsMbhX4A5BwXGhj4k0r9o+CouHy1QZKbrkkN
         FySvxHqpFchF3ZOwS3uE53OcZII83nc70k8OBbQIhIL9PFFyqmCFteGqOp8r05LydJvE
         ILvg5soc2PVTr2toP5FtQUnfqaXgKFLUAsA2zHLmP7XX0lieNnvLEBWZZaTCe14Cu/Rj
         VFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758077669; x=1758682469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flEG4uehFi7GqyLzGvohKFuWOoKanxZZMelOcKnuBrE=;
        b=fBhEumQtXGQeFWzLaqgseDQoJ+L1WvkG4lGbuKIVr6oeF9NGiazXYn8WmjhvlXm1HI
         yK2QIpIshvnj76Gp7ADW6bSfN1DSj0ryW1SoIWRutvW+ZcY1CZrbzHPD+IhnBktjvant
         jbuUGdDssUenNoYfiN28eaZ9RKB1PNL4z753zhj/F9dV0QbQgnUj4Xmphdu/Opka+04G
         ZzI+xhGjSHrBoTeT5OeMwpyfXBaOGctUVaL0mywDCEITY+wvvgpoJPxNqZz1kULpzvSR
         WSmxdNKHB8g27cgmSWv231f+KD4xvl9L3X5OMsMq2BCDz6IhgGbYa2hMeydgSONjvxOA
         9LhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMX3FREpIolSVKcSQEQT01vkJSEXU48gefdy5LReyxDi96lWfjcV8hOQaghVikOkNl/Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eeCG07MdLySpHi3fLxkvlDdOX864+e8BFzbp10qKCpxTNAOR
	vKV5CRZPGPmWb6YQIPhuTSvoyWRc3VoahMR4hGHqio+v97LwhWNtxp0yX2WKDpxfi/m3O9PblZ1
	n8rTnsXuz9Ai5BipNv4l4cbuVZBLYYBo=
X-Gm-Gg: ASbGncuXR/CMOqCjNZqb+IAUYILWINj67QGZcPcw4qDUMq1sADscIqBNDGivBU6tedY
	hLl5uLS/T+/+q8v31GF5IdyBNz7Th9l8ZDZBJNfDVXbnq9dq678pyZHkMsaLGqwtef1OuoWBVQt
	RdQdAh+1FQnXDAZPYVwl1f3dCr8we2BHzIPcReYxHQ2uOMHPoyy4IFD3mshBzSkJfgF3ePMi8rt
	JPxIJ9HQ1nC3GOHenxjN56/LpGLgsS/lI1CJivpHv92Agb44FE=
X-Google-Smtp-Source: AGHT+IEEetYX2ps7ZrELwuhKt4/XTfCFlLE0bDWg3H86T2fvi41T9AL0QOxrEr+XasdL8SkW1BnesHONevaRghLkHcU=
X-Received: by 2002:a05:6e02:1a07:b0:424:71:32e5 with SMTP id
 e9e14a558f8ab-4241a55da8bmr8027485ab.31.1758077669365; Tue, 16 Sep 2025
 19:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
 <20250916145032.969133-1-phahn-oss@avm.de>
In-Reply-To: <20250916145032.969133-1-phahn-oss@avm.de>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Sep 2025 19:54:16 -0700
X-Gm-Features: AS18NWCtIuzefaW7_N3HuGO9dO2Y7O-MZjqTcxxSg02QsmatFJN4Y-MmWbH08G0
Message-ID: <CABPp-BFxqJt+2HbY+d_qdZ0w=UDaL_u4MzO_3cpPpArQHREBJA@mail.gmail.com>
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
To: Philipp Hahn <phahn-oss@avm.de>
Cc: bolide2005@163.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:52=E2=80=AFAM Philipp Hahn <phahn-oss@avm.de> wro=
te:
>
> Hello Elijah,
>
> On Mon, 24 Feb 2025 at 07:27:55 -0800 Elijah Newren <newren@gmail.com> wr=
ote:
> > On Thu, Feb 20, 2025 at 12:27=E2=80=AFAM bolide2005@163.com <bolide2005=
@163.com> wrote:
> > > Case 2: git clone --shallow-exclude=3D<rev> <repo-url>
> >
> > The documentation was fixed for case 2 in 00e10e07510 ("doc: correct
> > misleading descriptions for --shallow-exclude", 2024-11-04) to point
> > out that this usage is flawed.
>
> I have searched the archive and git repository, but found no explanation,=
 why
> that usage - shallow-exclude by REV - is considered "flawed": I understan=
d,
> that the current implementation does not support this, but is there any
> technical reason why that is not possible or undesirable?

I'd honestly rather not touch shallow clones, I only did so because of
user reports and their obvious confusion from the misleading
documentation and error message that existed at the time.

Anyway, I wasn't making any judgement call on what might be a
desirable implementation.  I was just noting that the current
implementation is guaranteed to do nothing useful with such a flag,
and thus that passing such a flag with the current code is flawed, and
sadly that our documentation misled users and our code gave a less
than helpful error message in such cases.  I fixed up the
documentation and error messages to fit the current implementation.

Hope that helps clarify my intent and focus at the time.
