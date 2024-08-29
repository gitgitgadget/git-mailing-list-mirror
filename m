Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E7156F41
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973141; cv=none; b=NEueHqcuN5K6LATBS/Ervi6ztCYI/8fRmGs/cn9CdUdj9xynIHZDe+vMfBsokrRB4nzpKT1YP6aCTH/KakdDJR4Ovk2sVyFWbuVKHHFC4CKQQtEyJF15L2yL1FChbxB5v5UDQpC/ptVaGTWiVBwn1Y9QPZHM9K+lVO45AkCYU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973141; c=relaxed/simple;
	bh=A0y6FPZPP1ej0fHKwyrg01nfoadYsxFZuD06aER8VAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aicm8TkKA30v1+b5TofoFgLQDmL2nSxWkrzDmtxRUa4G9dCJRG5F/Osl1wg1icQqP0UIcT6pyq9K3wPLLzrDpPdPTEGcO//0jQDtXqBhBMMEfZJpBlAPwVaDkbeK60nPChJ6u1tQDftCE0DNIWvSuuwP5MzDmjQ8U3oDInCUJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPPbdgoQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPPbdgoQ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b47ff8a59aso11431437b3.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724973138; x=1725577938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5Qeu9z5n5Ko3HAyOC7ABx3S4C5QwCdSt+sJo+iBobI=;
        b=WPPbdgoQsMgYyfBXX7gsQPAeH0ce4XWlac7qUxSBe9ca2Fv2ifs5ZXWi/3fxpBILAm
         n0Ku4FmVsmDMNz3+5cuxDqokJNNuD7cHdT220BxDj+eG8yUDau1M00/RRyvZuKSH25T8
         KfmsdRmBo0mNL/tPRq7F6aWAeMrv5gnm2Md2O36RuuBHbt896VGhiUuVNkMyarYFe9vn
         wHQwTtrl7sjFc8MBGsh05UVFZrkPyFo4OmgwKMvvLTz5klVUmzW+DQTm79R7+5ba+aWd
         tloz+v4ifdxkTX6E8XztfHtmCh/uDiNPCKObfea7qBxwEjYvH6BuP9QpYZeuv4/bBB/q
         0TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724973138; x=1725577938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5Qeu9z5n5Ko3HAyOC7ABx3S4C5QwCdSt+sJo+iBobI=;
        b=BAcmIRev1veZUX+qHBkDMdoGd1pCoIpT2FDiTCwWOsr0D85JwLl2try1zPxz2sux1/
         42bR9hKDOl6lIOQ/BsK3W2KH+YT7MH7i784In1LPhpEoi6fwqb8LTmcKdYVWYdK2u6Yf
         bG7BTJQQdrf1mg4g6A8m6B7nDWICagsIhB8XDcka3NsU4q3X8zuG1IqRHE3tW/qj3ybV
         Bn6BD6qeQoQjOTLBN5MBbHu8rQzwcaGysmCQyPefVHdqjFiajeRlWX9COi1UV6BPJg7/
         u9gwUeOnNzOibQZFreW66yal92ljrYbU1az0w1P4lDMArOobN0XEd/VcwM3iOR3toBLM
         w+og==
X-Forwarded-Encrypted: i=1; AJvYcCUIWq2babbnml2N5PTxs3HBJNtp2KYnY5sN/di3lgzTUFsTJyUmEdSRjjUUAmImXcvW5DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmHIXINE9jnl9BA5HwX1/IYBg17zZpMJPFR4gThxAZpKxiMFy
	O7Eu9Ftwa4IZwiIAndPW4ZGGYZr8TDfTanwXPFg/JCY5EfhTabUe7TsdwxUWfPJeNyH4NX2HPUh
	OMFarTzf5mHztvEIjiBVEnELAl1Y=
X-Google-Smtp-Source: AGHT+IGRnmR4Ru+fFMENdYJPtsOTOsgxhyymimiPu2rPI9HaVx/T9re1PDtyRKxtBn0eRLQYb0vhopCEYcj9i//dFB8=
X-Received: by 2002:a05:690c:3245:b0:6b0:a6f0:b0da with SMTP id
 00721157ae682-6d40f340af9mr2290667b3.12.1724973138452; Thu, 29 Aug 2024
 16:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
 <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com> <20240829214336.GA440013@coredump.intra.peff.net>
In-Reply-To: <20240829214336.GA440013@coredump.intra.peff.net>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Fri, 30 Aug 2024 00:12:07 +0100
Message-ID: <CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
Subject: Re: How to turn off rename detection for cherry-pick?
To: Jeff King <peff@peff.net>
Cc: Elijah Newren <newren@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You seem to have confirmed my understanding that I described in my
initial email (you replied to my second email in this thread).

On Thu, Aug 29, 2024 at 10:43=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 29, 2024 at 09:47:52AM +0100, Pavel Rappo wrote:
>
> > The reason I ask this is that we've run into a (probably practically
> > rare) case where cherry-pick changes a wrong file. We want to be able
> > to detect such cases.
>
> You can pass merge strategy options on the command line. The old
> "recursive" strategy has a "no-renames" option, so:
>
>   git cherry-pick --strategy=3Drecursive -Xno-renames feature
>
> generates a modify/delete conflict for your example. Curiously, the
> modern default, "ort", does not seem to respect that option. You can
> bump up the limit to require exact renames, though, which does prevent
> the mismerge in your case. Like:
>
>   git cherry-pick -Xfind-renames=3D100% feature
>
> There are also other strategies that do not do rename detection, but I
> think you are better off using one of the more commonly-used strategies
> and just disabling renames. IMHO it's a bug that ort doesn't respect
> -Xno-renames.
>
> -Peff
