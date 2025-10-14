Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52D127E056
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437895; cv=none; b=Gj/18LLcelMHoaDUSn4eE7+AjxYPR00YntZ7qHDgVTJZ2vHdXv5RNCNoTdST0XRqm+0PJgVGDP8TSyaDMtBhOv28yquYKDRhd9v4RYjaShWUqUKfftxtY2ZpM9cjpDTksP+1on6kuCUs5BHP/gdNab9ujK3nJkbQg8t6oGLybvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437895; c=relaxed/simple;
	bh=xKMoU7whsypfO4qeQGg1nUL8JR0OTBx1QXFTU1UhHgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNfZ2IjPxsV23+SxgbvtUyaAtsDXU7zTQtxsoxJX0GD/HK+l7S7J938RfVN8R+WzFhUZaG7DW6+ObRh0owxs4vkNjMWVfRxrhRTYaHbXGEi1HiBKY9go/RIzLFY7VfG91FDbQS9E+jez6g61FfdkgO1w0P2m4jMjyRQbDUjDGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq0HfMiu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq0HfMiu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2897522a1dfso48063555ad.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760437893; x=1761042693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKMoU7whsypfO4qeQGg1nUL8JR0OTBx1QXFTU1UhHgU=;
        b=Gq0HfMiu53sWxZ5/OGO+A8LJhOw2GCUdon6z5JQib5Y9LyFfKEXtGYu3ae5azE4G2t
         rIaslQ7JMZlPtBhjZoJgpoqVNk3kQrfZwMddzD/FYZsR4b572a+6QYDuI9UHgMlHFqZ0
         Vvjmn8JF8r1W3GhIqQxTqGvTOlZLS8+QyYyulu3v+qot040WjlQ/WoLubL48pReeo0gs
         OgBXJ6mDlvDk6CYaGrFHHPI5B3oX8+vWrUGInS4Ndf7FsQJwe7DvyS26mtpr0btXeMA9
         BrLr9MyYrpFtffyzRf8YL6y6//xbhlkorM6BMobilrGlS51xaK3Qq0wdxYhrc4zAdSBw
         tq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437893; x=1761042693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKMoU7whsypfO4qeQGg1nUL8JR0OTBx1QXFTU1UhHgU=;
        b=eRjjrp4Zend9XWDSbSzC6v3X2ECgCi2NvT8ayCviWZCLYFOzoKoTnWdy3uUgIsNWjL
         daFgFfZswkOAtdLyGA7V6CnchMNbkeiXGiJVhufiDS53kiemtOsOpwq/0AGzzFWHsDes
         Y37h0f0GA44xuGwTv5eDeuKtgXWh45Ky096bnwGG8Fw4zkicdWfGwD7y6cDeimok9AU+
         d+d8bBOeYYA71GBazTiOekFqq8Rm7qcQLYumrfkfZaT7N3E/FMXeX0TJn5RPHOmDbJCn
         ftospNXsimqJXBa3vXKXOUBd91cPtNGtObgeENolrx5Ntf74ajE7Kd3vXEByLDZiwudw
         Kb9g==
X-Gm-Message-State: AOJu0Yzv/cdBLyVjnRsPV8r8q/6Dw9r47L7w6gSPUEdlG+Ml8qNuntZa
	Ico0VaU3lgAgXI5l4fg+fCQ6bWGR8viZ7UUKPcDAVV2F2p+FLabFqkhHmnMXPheuKHuiE/X9iOM
	9QG/N9oF0yJ2Jvt1/r3qtrmSK/H7LkuuXfb01
X-Gm-Gg: ASbGncsD+wMO/wgNiu6NiWj5LGVMWsxVifZG0sm+an9ik8oSfPRPQswr1zNdxxZcIXz
	yMdwRJtpVVZ3psEYuVZf+U7GEz5r2XtSJqClJ2rrav8Y+cfFJf667NRrxYriXpNLatfTJdZbfQu
	ihC7P60CY34brdfoCVZa2a7tkjNfZIUvbn3fHFRBrkoEpaFIo0V0jFK4gJG8obLuksRmqRpo9//
	JoJEBc6zt2Z7doCOnHPMUHOIj8=
X-Google-Smtp-Source: AGHT+IGiih6i0Ln/cGDLkihFQOa8xY7RYc7vEy0D+G7+TMT9BBF8yF5og7ay0+qIhZUNUwBGWe7P9Mqc34evT4r8qa4=
X-Received: by 2002:a17:902:f693:b0:27d:6cdc:99e4 with SMTP id
 d9443c01a7336-2902723ba41mr326704145ad.21.1760437892814; Tue, 14 Oct 2025
 03:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9Z2kPWv-=wPbtytbMS7BuUtmAKCv2X_2rq0hB_Wsh=UA@mail.gmail.com>
 <CAP8UFD2azLtbeMzGhgxHcdnCF=jD5esOs3BjhLWGCXvMmppX4w@mail.gmail.com>
In-Reply-To: <CAP8UFD2azLtbeMzGhgxHcdnCF=jD5esOs3BjhLWGCXvMmppX4w@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 14 Oct 2025 11:31:31 +0100
X-Gm-Features: AS18NWDN97mJPSWrcB-NOAWgn25yMEGaMFd1_v3YOLnBvK9Olpdotpgrm1njFFo
Message-ID: <CAD=f0L8F585EDRUBJW-WbCd3299wQi832rMK+69Lhfuo2atywQ@mail.gmail.com>
Subject: Re: [RFC Outreachy] gpg-interface: Replace strbuf_split()* with string_list_split()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 at 09:57, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Tue, Oct 14, 2025 at 2:44=E2=80=AFAM Bello Olamide <belkid98@gmail.com=
> wrote:
> >
> > Hello,
> >
> > In continuation of my search for an appropriate microproject after
> > temporarily moving on from my mail to the list which was about
> > the check-whitespace script check for \No newline, I stumbled on the
> > thread
> > https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com=
/.
> > After studying the thread and searching the codebase for other
> > instances where strbuf_split()* can be replaced with string_list_split(=
),
> > I saw some cases in gpg-interface.c where get_ssh_key_fingerprint and
> > get_default_ssh_signing_key functions use the strbuf_split_max to split=
 the
> > input string and I think they can be good candidates for replacement wi=
th
> > string_list_split().
> >
> > Please, will this be good for a microproject?
> > I will also appreciate any guides.
>
> Yeah, I think it could be a good microproject.
>
> The functions you mention don't modify the strings resulting from the
> split, so those strings don't need to be strbufs. This should be noted
> in the commit message (which should provide the reasons why the change
> makes sense).

Hello Christian,
Thank you very much for your response.
I will now prepare the patch.

Regards
Bello.
