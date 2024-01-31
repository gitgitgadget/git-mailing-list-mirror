Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE333FE
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718870; cv=none; b=XbNAxosqVtIfJi2P2XdaQtaxtJeYWt8HIWAh42CCSwgLkYabI9JmcV63P7q+5nY+ycf4500iYIu/b+Cn6tupdtjVL4qCN6+0ZoUXgVHi8tEBtzlVj2vu3sjKvxJwIe/Q1cZPWmAU0elko3Rzdkm005zwxe4bIZLZ1rxBz1rFxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718870; c=relaxed/simple;
	bh=eb5XmVeOrlwEXHw0EDH8dwO++gg6g+2jy6oydT6A6kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pj3+SwmMdZJUtjWAbfuPV/60ZjTkvMHEpwCN45o26vJ8heFLMZN/yR1/sZy4xl0au7vCSAuC8bB4iKVCE9eXxgzpkS+Zjw/CFJx/qxLYO/mnNzJBQe3l3rtkg4PbfaSXhcVHQgwNhnKc7jF0hLDZZvT69UJzd1ORULlY8McB2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCISH/gR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCISH/gR"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-510322d5363so6511706e87.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718866; x=1707323666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cRCIiGuuDEzOz8qjZzrr1oEBOIEXLyeBUiEswEOPXE=;
        b=SCISH/gR9cQ9KZvAjPF75w9SGeMoSQ9IhJ9CREOy6vQsi8kaI1ZwBef7+I8z0XryjW
         PTEEhgN7Pr76fdMTusKDPsNQjRwloBOfKGuEEn6GNkmW+D0lh3lv5mOCQqssPjbjc7Ae
         xy6IPHivfT7O8BXtt6kJcZX+vpUW8tvH5trRApAMgAH4Cjkdlqp3ouP/d+LFpeH7aHmi
         xY0hpbA5HtyWI3Edxe+TLnmvOpSGBq49E7WOu2BzXIcmjY/AwhZbowf4dsk+lptD56Jn
         xTNZT8ilWynpirjrE3Msd3p9HjnsgFljJ/ihFnv04Y22yNOn/kc5vcxOKs8zkvudGiTv
         nkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718866; x=1707323666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cRCIiGuuDEzOz8qjZzrr1oEBOIEXLyeBUiEswEOPXE=;
        b=S3A1tx59Nyw2kjknYoKcCaim4LJAIgTHwOWUxBislSr4L9J7vNo/O50ZsxuMOZp04z
         Xc4OP7Xfi1CWvrXR91EcsjtKVtPbZjQ4TVOOFcd1sKV98KNpBShuvD7C5JOaLe6e7HCk
         ceplPlaoBMOvPtZVC1hGQ9R95CFKtgx/jdeiYDbKdML5KHONO9cNhFFIR6TTyb6thmYJ
         7oNY00VrbZ6xuZI4dog7oWInYT7pIFShNjDW0fRCMa26He5gK06Q9odyJiLAb9uDsXOS
         1nOHHPPfXxy1kTDJswgxI/rGzOYPxQy/017zVS7eU4qprLjkWeVpEvpRv67MICLxez6n
         N+yQ==
X-Gm-Message-State: AOJu0YyNIoxpkAFAHPL+w6OmYMT1OKCC2igP497R9KVMEHD/W0k/affp
	MtAHtSU8eY/iQK8uRGsjmLlrLOmWuB/wHSW0KzOcYfKNja6DhIzpa8wPP5rVutmiwwaykESv97v
	LHqu4BsXRgLM9UvmNha1s6aNygOk=
X-Google-Smtp-Source: AGHT+IEUiXEEq7yON+Hiuo93zMY/GdSiOoLv/ZwGZy45ciH8OmtcbCHXtMlpNloC+0fLKaFd/oOzHAFaF5DLldEHkcE=
X-Received: by 2002:a19:c203:0:b0:511:215d:262 with SMTP id
 l3-20020a19c203000000b00511215d0262mr2004lfc.8.1706718866275; Wed, 31 Jan
 2024 08:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
 <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com> <xmqqbk92bv43.fsf@gitster.g>
In-Reply-To: <xmqqbk92bv43.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 31 Jan 2024 08:34:13 -0800
Message-ID: <CABPp-BEDLsVFxjr13XJX9eBLeqD+tRoeHxwJyPsc_+AgGY2GTw@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 9:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
[...]
> >>         opt.branch1 =3D branch1;
> >>         opt.branch2 =3D branch2;
> >
> > If branch1 and branch2 refer to trees, then when users hit conflicts
> > they'll see e.g.
> >
> > <<<<<<< aaaaaaa
> >   somecode();
> > =3D=3D=3D=3D=3D=3D=3D
> >   othercode();
> >>>>>>>> bbbbbbb
> >
> > but aaaaaaa and bbbbbbb are not commits that they can find.
>
> Correct.  They are what they fed as two trees to be merged, aren't
> they?  They (or the script that drives merge-tree and fed these two
> trees) should be recognise these two trees, as long as they are told
> that is what we show, no?
>
> > That raises the question: if the user passes trees in, should we
> > require helpful names be provided as additional parameters?
>
> If the user wants to give human-readable name to override whatever
> the code would internally produce, such new options may help them,
> and should probably apply equally to input that happens to be a
> commit (or a tag that is a tree-ish) as well, I would think.
>
> > Or are
> > the usecases such that we don't expect callers to have any useful
> > information about where these trees come from and these suboptimal
> > conflicts are the best we can do?
>
> I do not necessarily think the output is "suboptimal" from the point
> of view of our users, exactly because that is what they fed into the
> command themselves.

Yeah, I was worried though that the end user wasn't the one running
the git-merge-tree command, and was trying to dig more into usage
cases.  Johannes example of using revision:path specification lessens
my worry, and you are right to point out that we can add additional
options in the future to allow overriding with more human readable
names.
