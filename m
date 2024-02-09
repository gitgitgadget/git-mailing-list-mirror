Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E19383B6
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485758; cv=none; b=TEs+8DVL76/678ilQ36tJq3WXLxCsdNi+suEYmbWWXvPWnr13ajWxSdXvnoetO9ZC9Lf8wUWT1dM1mS7ChuEZtUcCyKtu4WUCaAGc3tkFWXkOkUGQZ4Ptn/sSgojPWe8wluc8MqSooWfeW49Y24ZpBW5fgwwoWbylq1R8QsKuoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485758; c=relaxed/simple;
	bh=sWOZ7lDY52/fxizsiGRJfusv7uO0hJCWJacq+WiuT1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BPmCcBzu8JM9gufxkOSni5OFkVD6uO/k60CuHO3sTWieqhK5rwoOuBLvbfOscExqGzh8KqEYOCDmtw57pU5RNu0vwSKHy3LyRd1sGlEjOk397ACE+E2RiD95uPTEoRVtkoxJrUmVkKYGQ0YPToMT0GQfVEEMFCbZmUAOuPohqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+HWcK2m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+HWcK2m"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56002e7118dso1338985a12.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 05:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707485755; x=1708090555; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJl0CgCUWXlzBXOQOcXjJBO200xUfYadvMq2llf+JQg=;
        b=F+HWcK2mQnI7xAx+ABrwZaXhSSljOEpMlqb4hxET6RmO8OMF5ooiDVoOYqW3nWqO6R
         1ztqkCJHTzGBNToHxOqXNDDesQ6cwkY43zCPeORhpm3y3ZxenZqV0RTM6YfGWMr4UMJq
         Tfyez7hGJTVYMzsZhLOW5JDEn12diSf17A3bYcddRqBxzCnyQeTD/52BZnu0ggi6qAw1
         dsBGcGcCYleXnjOn26Vqbm6BrQbZ90z/IOlfkt8TQ5TtphX9osMqFPuPX+0NEwjaofB1
         c0fZ7LhIKlfN+JmHYSkb/oZTXN6wJZ3altjnhgCic2wrU6Vy9VJVqsJgovxnnRRiy1zM
         8uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485755; x=1708090555;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJl0CgCUWXlzBXOQOcXjJBO200xUfYadvMq2llf+JQg=;
        b=iXwcUHFyfczrQnacs0an9PkLoPERjQzfCO0UQoUK7T/LxJIYgovdyY1u5R4M86TZZi
         hMJJYwBtcmC8om4nUNBIBU/VFtbKQ15SSxx0KHF9DXKC/kHLfSexUw0ZcaueZt96chgB
         zQZgSRgdO73h+0I3phDMFM3XiMuNqeA9KhZvNAdX4ZE8NOnm9TZaXLrxdpiQKHDKHD0Q
         xjE+MtF1dYVesv6U2/UI5GDEFEuhyBNwV5YdbunnUY8VFwFnfHEJq8X4Qxj1ECHU3oBx
         0vsfBqH1meGSPxsJLq2oatpxagRU2otffRjgn4/wgrraJrr+VOmU6YSt2zcJ89dNKbVt
         G/4A==
X-Gm-Message-State: AOJu0YyeR6mbwFoheKUtuMogkeNVPfm2fGAYfun3nJI4HatRAngxUSGY
	ZqvVVjl081gSd+/BDJJD6qewr+I0WoTWukx8Ju1Rut6iYgGtZ70NzK0cZZPCZ8Z16hy1CQNlT90
	hIUpe/NTiB7jjfF/5y/+cOLJqjJM=
X-Google-Smtp-Source: AGHT+IFBMXiFKOQ0KltzLNfjUDUS0Mz6jtC8zmxpAFpEgxecLQs1V7+FpFuviRRriEqj04XTzYNNBWgiWrsCv3d0naU=
X-Received: by 2002:a05:6402:2044:b0:560:da94:2306 with SMTP id
 bc4-20020a056402204400b00560da942306mr1166728edb.29.1707485754887; Fri, 09
 Feb 2024 05:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
 <ZcWCDEnmv97orQyY@tapette.crustytoothpaste.net>
In-Reply-To: <ZcWCDEnmv97orQyY@tapette.crustytoothpaste.net>
From: Orgad Shaneh <orgads@gmail.com>
Date: Fri, 9 Feb 2024 15:35:42 +0200
Message-ID: <CAGHpTB+_yo24d5wtTnxCHF+i+wLCiq3XjjpmaX1Z=AOxFjx+mQ@mail.gmail.com>
Subject: Re: Supporting --no-edit for git rebase --continue
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Orgad Shaneh <orgads@gmail.com>, 
	git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:38=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-02-07 at 20:46:16, Orgad Shaneh wrote:
> > Hi,
> >
> > Is it possible to add --no-edit for git rebase --continue, similar to
> > the functionality of this flag for git cherry-pick --continue and
> > similar commands?
>
> I haven't checked whether this is actually possible, but I imagine it is
> with some work.  I think it would be a valuable feature to add, but I
> don't think anyone's planning on working on it.  Would you be willing to
> send a patch?  Even if many people think it's a good idea, we're all
> busy, and thus it'll only be implemented if someone is willing to pick
> it up.

Thank you. I'll try to prepare a patch.

> In the meantime, you could try setting `GIT_EDITOR=3D:` in your
> environment (for example, using an alias) like so:
>
> [alias]
>   rncontinue =3D "!f() { GIT_EDITOR=3D: git rebase --continue; };f"
>
> and that can serve as a workaround.

Nice, thanks!

- Orgad
