Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDD3376AC
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469817; cv=none; b=ABA4+3weOUc240GbrF6YUH5lgunFkbxcFqONz11azH8nrAaTqW74fzN1/OUPx0CUdHP17MUXZnABdQHHFZszewYR9eDcd/hE82cdrB1y0z2ASmbzdB050H9Yq5eBVFlOUWjNNouDLvofbbkAPJ7idGnwe5q5d86/rdWz1Q3uyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469817; c=relaxed/simple;
	bh=NId6yoLFY76583Reb3SRC7dL8fR3xTl/AqVs8KPXHSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jmo/4kddsGptt2iKlvKw+0R26zXNdb+tgEJ7HfFtcDFEeDwj2UP4hLWL+adoGZdQubwwDuXWvNdgky8RrYNwbStJ6jtY61wDz3DoBEV6HmDNtIcPAwBhp8f6Ov0yx15PiDlcThZCg8lWHcGNRmXqRsd7V6/lT91lToRc4/YRSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rxg9VBI+; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rxg9VBI+"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-43321629a25so1350825ab.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 14:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469815; x=1763074615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NId6yoLFY76583Reb3SRC7dL8fR3xTl/AqVs8KPXHSc=;
        b=Rxg9VBI+ES9qC6B6dAmO2iX4wDHKZw2A+6EkVJpQaRrFXt+Jt7rxoHAmzmdL2AHnbf
         eL/XgOafELhsJvL5ChEufzorzbmtRYvoMO3oHNjHSjF7xUn1HYWOpUJJ5upW3lVqrBq3
         myADnzKd21QODwYDER05jBbgqF1EHQEVWKIRMkhUoNEZ5xr9HmC5fcELEuAZ8eDK028E
         mNi12qsE1ZeMvDCnMCsmbX0dJlBuiyvpByWADV7H8OlpbHsGO9l7+t+oBxSPxljj56U4
         z2X9p5cxA1goykl/NdIl8wNKUQA7ujlgpzcXcOhEKGsu2GtHBM4d43i9WHA3zutWrOXM
         p0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469815; x=1763074615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NId6yoLFY76583Reb3SRC7dL8fR3xTl/AqVs8KPXHSc=;
        b=WB8BmSVQiZjTs01HCBjsabD7yU+VyTv71BrVIIALSoJyM17F1PClcN0o9HL8XTY2ut
         D3bKT8oxLwF9DYRT34r33A2ZbA9CjSVR58FMijjscnCgS+6s2zEUGA6FOBkRSh5HE49d
         PT/4EZbZSotbw5mU35tnqWTxAlaovp+u/NOlK2z/jHQTwQ+oMKXirt4p8hQP0ltyiSqT
         8gJdV40C0r0musBiaPJg4MbPwLkcJGvlkVG1YFbEvqmw9xRVqocymXyBb/n02o8jz/hz
         oCt39KOx7yogZSA+msaXMBgxlCK6aPD1pyObjUWj8ZHgKgBbJJ0lZBmyaoRzESfbcOV7
         EY1A==
X-Forwarded-Encrypted: i=1; AJvYcCVj2LjrjIXAhrSD3hiLd+Hicm5bHFLmSrhXPb4m2x2XjW034bdUwXAGOGmVTnBvauObUVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/l8diUkqtS9MiDWDGbi5acy93aw3k8MHyFf9f4XnjyEM8sNIh
	X5vPnjEWgUwmG7TSD8OPD0/Gg/UlxsZanHqw63ESga9u66xgCujP7Ql2pTTdoEw0YDZr1cntTAh
	fd5WH08GwfIJJH1CUiD7SH8IrKWU6dS0=
X-Gm-Gg: ASbGncutaUVHKC1+gumzFCE3xaA+KWoVrezt7R841aQqGwbwkASv5vNpm+bL+FMDunD
	2VeJNKaDchaUkteNsKH925wr2Vv1vRlu53C2CayFF5cpibS/Y81SPwaKC6GzLWn9UnzAJYiZbk7
	eiRV1BvyMVjrmwocTQ9GgzzbaWnMqo7FuN29RUVP7yl8dMkyA0+HQ9kBuiprpqBM2aK5dQMu58v
	Ws3fMxNpKikhaJvNz8yhhpHUXOT+p7Fpq0bPTxVgkhIx8j+zLj4XhXUz5T3y7+W+O1AwqYR
X-Google-Smtp-Source: AGHT+IFlmqY5mLsGH9OuhUGij6WICuWbmbcue+5LnZ26M96Yk+x1GsnODAsJ/DjDUY2e4Me6EFoa06zvC3DN9JAHtpI=
X-Received: by 2002:a92:c245:0:b0:431:da08:d652 with SMTP id
 e9e14a558f8ab-4335f2c4818mr20216895ab.0.1762469815543; Thu, 06 Nov 2025
 14:56:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com> <9197903add26e5b8af0bb2dd25bf115670e18e8c.1761776388.git.gitgitgadget@gmail.com>
 <14496da7-3d9e-4e07-8893-0a5414fbbe70@gmail.com>
In-Reply-To: <14496da7-3d9e-4e07-8893-0a5414fbbe70@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 6 Nov 2025 15:56:43 -0700
X-Gm-Features: AWmQ_bnQgL5NpIUWPtIpkcAN8nVw8Vpw0HP3Mn7VqMyTGvPLZLh4jQ4biFe8Tm0
Message-ID: <CAH=ZcbDe+3Bdxz4OYZw7VMRSXaR1PsWx0GipogD5gfD0n=+XYA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] xdiff: use ssize_t for dstart/dend, make them
 last in xdfile_t
To: phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ezekiel
>
> On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > ssize_t is appropriate for dstart and dend because they both describe
> > positive or negative offsets relative to a pointer.
>
> This paragraph and the subject need updating to match the change from
> ssize_t to ptrdiff_t.

You're right. I thought I updated that. I'll make that change for the
next version.
