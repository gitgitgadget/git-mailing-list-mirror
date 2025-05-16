Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90062323D
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411451; cv=none; b=XoyIkVF9sUDoc+k4wclxn2MZFWvfscpXB0S3/ESZcxffATvyO5xb7I/4/KDOMFViDkf0tXjFhqKr7l/Es1OfNBklkigHDRMPnvpPl0IxIvIVjXmCNE0qOJfFQjVnGGNmySD7340ZXi9pMo+kDYyQmPmNlVj0cl8RayPqo/x2ySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411451; c=relaxed/simple;
	bh=8q/gywDJQS0/SmuPCoonBlpJw8qrYccDLYvy91lBpro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdDXR29AUnzVpsauw4UASsgKVxw2k5sQonGOBa6AXH8Cfu5e1Vmr2XjhcaKCoAx7hUYsvuKuewmDNomvjWvMIi7BqQBi29iF09xkiTOilnmpkT0aZeNsBRsW0/3cOVJfCKudQRVDB/a+GyegSVCl8Xjewg897mEqLvqw1WLc5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDb52gP6; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDb52gP6"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d071fcd89bso166056fac.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 09:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747411449; x=1748016249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLrwFGCxLEgBMzUnoe42Tx2y5PGGcxLLmoJQFHTAjfw=;
        b=RDb52gP6crbuZKn7GicYiSWK5RuHSbeOu4M46ewQtEtY13qeoyRkHHGBibDrSYX9Nr
         birEJgpUUWW+7KxjXCLruFrlF3ZIrdCGTkutDM7dBMHgUsBCPBqJwluP4KsGxV74tZxv
         glqHfc1rnCe+iBTA3vTfjqJ+RISA/ylX++IaijJqH/Ua9vB7BRcDk7yswtcxVeRpgQ+e
         jkfINF/KDoNHPAy3rsgiV4fLKw3hXVilwQ6KK4pegc7WP66Gzql0a3THOdBqeBGBTpnJ
         d9llqvalN1Ct4faPeCQDthhcSQusXJIbXmgEtrQKjlbeJ9GlHjW7QhLLhg1h4DUWTN6z
         2CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411449; x=1748016249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLrwFGCxLEgBMzUnoe42Tx2y5PGGcxLLmoJQFHTAjfw=;
        b=Gr2Et+Bk7l0bX7eH8lUCejlFDXrfeI7f4i4qSgNrkjXMHxCFPSitGgOpK0QdACZpca
         uYR5XuVln3/Q2ThF04EdzqRat0Decvm8m3xDuqcSI60UUJ/d63zQrzGXUQykLkjkUqDw
         H4QyS/6Wx68ilNXZo9fbxbxccgcRnk2NDSfn1+c6AZqv5quj1LE9XV7d+/CcUkR6hb95
         n41mkuuwpLw4tFqOl9BGHa6iQSvVyOrtJfiG54IJ8PpQz9AlwlUqipE96/ztUqYYb/Jg
         m2rfknj7paFUvT2OdJOkka91xhzppqWwHkqVViSBdQOPlX2CsRqGdoqV5qPx3S9tEdfw
         DRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx1RydLs1yzRCj/IgCuoM1cqoWhdeIJnG0KIZhRV9gzji5AWgKQd3SX0uB4AcVzDCSamk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpt3e1OQ/jFTbkZHnWcRpumZ2oHWO19uUkoKQCiLI82RQQw+OV
	NagbbEKOUof/QKiD/po+g5ctwnt0KRBLOoI2GUe6u4opwkFrkyyWhGP2uPItAGR+USqrZAgg6jS
	tDsmB60A8ohnYix87B+KSGJMsB0fLBVA=
X-Gm-Gg: ASbGncs0lyngUuUIQ1sndxcvjJsIYFoAhLQf4shxHDFT9NgpfGIkwteGpc5gV8CwjNn
	LG457AT63SpnPa7Nh4EabKWkrcjjXbuR32o5Nq2au1ml5/juPtGcQqWGloy7KCNdej/iafL2Mr7
	plw7w0GjqSPYoZfYefBsCN67LuD5g32UQjfmQ2BcNS1eGjg7GWfuTu7Ir2sMhDC+mHNg==
X-Google-Smtp-Source: AGHT+IHGu6HN/OMMTTYZu76CvLD9CBiX2KUYubN6FeAsdGF3WwsossHan1x0FusGXPWwDMU6xilJTrzRAsARlsABx+o=
X-Received: by 2002:a05:6871:2792:b0:2e3:d029:86e with SMTP id
 586e51a60fabf-2e3d029a1a8mr1034398fac.4.1747411448379; Fri, 16 May 2025
 09:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
 <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com> <f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
 <23e4267a-34fb-414d-bae3-7f607d3bdbec@gmail.com>
In-Reply-To: <23e4267a-34fb-414d-bae3-7f607d3bdbec@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 16 May 2025 09:03:57 -0700
X-Gm-Features: AX0GCFvSrQHe_APmO3yJrCSFAY2e0VuY7xs_wk4loPkx_8wNzOmc4xO0cgSjgOQ
Message-ID: <CABPp-BHpuBnZacf39wVwYYuBjau_joW2ztkLJSAW_nNNTEwnpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] merge-tree: add a new --dry-run flag
To: phillip.wood@dunelm.org.uk
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 6:18=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Elijah
>
> On 14/05/2025 01:24, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > +--dry-run::
> > +     Disable all output from the program.  Useful when you are only
> > +     interested in the exit status.  Allows merge-tree to exit
> > +     early when it finds a conflict, and allows it to avoid writing
> > +     most objects created by merges.
>
> I don't want to bike-shed but to me this feels more like "git diff
> --quiet" than "git push --dry-run"  or "git send-email --dry-run" which
> still print diagnostic messages.
>
> Best Wishes
>
> Phillip

--quiet seems fine to me.  I'll make the change and then expect
someone to comment on it with an even better name...  ;-)
