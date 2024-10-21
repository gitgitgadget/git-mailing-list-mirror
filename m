Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E710A3E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729547069; cv=none; b=K5vf/5TrbsTjDIfIj12jlHe+zsTPRsP40D8V+cicyEEOU8ztl0N1F4rQgO26+k1C+Zhl8ViDNRUPLzdfZECiM7DQ2SgAiu8dUXsImphGIcXpiOdhmapOI/KhZL3NppKEhl4hc6lDX0NR90hMbTiOGjrSoMAiGQOjCsbMTpIHghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729547069; c=relaxed/simple;
	bh=fOHgzyGHr8qC8/3UkmSpaoWnge4VxS3W8c6Dcit4/FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0lkZifg8DtyD/fIP43lWjdiMKFMRi2CZzvdaSrAjvcP7Xlwl2uf5JHSJn9uNk3JPHqoGQay96GwLq7cZB5io4i1iPGMKwbi9ccny94s4f1hcUuHUylVDQsgYZ8pxHjquJ3SG/BKr7+8wXwmwzXhOsMst4v7ym9DmVOxq5EvZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3XmDRLf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3XmDRLf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so54639595e9.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729547065; x=1730151865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oSJGzj7cwFXP3YVip6riaYxot8ekV4OZF40mwtOJXGw=;
        b=f3XmDRLfM67I7ASVFIoyUI9ToQ3cofwnx5P7kOPi3yTpLviftUzNiNjYz5oGELEK3M
         cmPQD0DsF/GcHAP/u/08vKMdH+fu0d4pa1UAoTlW6+2xppdJp6VCVnQzYSpjJDlab8+J
         mYixv2jwbUP362TgTXUidFrPXzKiriVl4PmBCAeYM/9+Q2pftANikGkzNjk6fnjOcgwe
         9OMabk0wUZd7xhwr7bO511J6opUNtGX/I9PLvtgBjc4AgkCCpgE8gvO0Zg2myv7bZsGb
         ATQp4j707OMUcUKpNAf3syL2Th5R/UnD0bz9QtF8U123VSWNnS3/wHfgzRVemybVx5Zk
         FPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729547065; x=1730151865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSJGzj7cwFXP3YVip6riaYxot8ekV4OZF40mwtOJXGw=;
        b=F74AYeZ9yQjtnHpud3rI0LYUlukQZIl5WG7ng9oRC4k7pIE66XY4z19HYDpEDdceq4
         6Dr2IIAme9+MHmuWdzPN2ENh327HwIgLtwVUMLlLfZiWaH1/i0G7Th49znNH9Nwdfg3n
         c1s9LLobfGevwY9BWBGXCnhr/HYSLNvW8dy03IhxuuEZsLccA3zPvQrktPsx9EJWxeTK
         0ktyGOl9/BfGxke3hNcG0RrlwiX3mf16PJaJc4EXwdBYO2ORksyjk88IGJAvUNhRcpjg
         IdKGJoPzXaJ+6Mk2AjvwTdEc2ahTllfVZy2MAAOembX9yoduNtyTzjJOYwz4LCyigiie
         v6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWuk733AKvMK3h4XPzxw8KIseCrolcm2e9MFo1FWt49O4Esoko3TGA/Z3+cy22GHnBTEj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8dSapUO9CAPidenghTUsQO8/p46cYErVIUPqPhbYZ1RdnRksq
	dMPpnRcomBd0RxjYyMcwcgOnQht1GumxgDxEe5pohRrzt6t1D/tuqaZj8sLuFN+Da5QP0IrrRjr
	YyWt3YlJGzO/NP3q7+Kz/PXVdZNw=
X-Google-Smtp-Source: AGHT+IF8RhYVeed8scP7kcdf/3aw6HemRNu+S2DV5QBF2rhT76tsdvdPSDCeW8hXBGdm0dpnHEB51yE2dOvFiBEOgMQ=
X-Received: by 2002:a05:600c:1d04:b0:431:1a98:cb40 with SMTP id
 5b1f17b1804b1-43161667bddmr79195465e9.18.1729547065137; Mon, 21 Oct 2024
 14:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
 <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com> <ZxaxHmIP0iJZfvHr@nand.local>
In-Reply-To: <ZxaxHmIP0iJZfvHr@nand.local>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 21 Oct 2024 22:44:15 +0100
Message-ID: <CADYq+fbHKf=YZvLYnWPyqctFeunz0dPxt_aw3t-J2Zd_-vpMfA@mail.gmail.com>
Subject: Re: [PATCH v4] notes: teach the -e option to edit messages in editor
To: Taylor Blau <me@ttaylorr.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024, 20:53 Taylor Blau, <me@ttaylorr.com> wrote:
>
> On Mon, Oct 21, 2024 at 06:12:20PM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> > From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> >
> > Notes can be added to a commit using:
> >       - "-m" to provide a message on the command line.
> >       - -C to copy a note from a blob object.
> >       - -F to read the note from a file.
> > When these options are used, Git does not open an editor,
> > it simply takes the content provided via these options and
> > attaches it to the commit as a note.
> >
> > Improve flexibility to fine-tune the note before finalizing it
> > by allowing the messages to be prefilled in the editor and edited
> > after the messages have been provided through -[mF].
> >
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> Thanks, will queue.
>

Thank you, Taylor, my Outreachy mentors Patrick and Phillip, Junio,
and all the maintainers for your time and patience in reviewing
my patches. It has been a good learning period. Thanks once again.
Abraham Samuel
>
> Thanks,
> Taylor
