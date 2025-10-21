Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83256329C6A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042008; cv=none; b=MVILYnVdrKrV5Qn7IFteYJf4bfuxQ05WT1fOIrzS0OXNcaq46FLWOHXknaww9fULwEW4GGQs6UpR+Z2V0+kfaHNLPVJYvqBC1zitTWXSciUgDhNMSUA/rgwzEfOUgDRfEoL3u4JLXqiMQJGN32K1E+zMfKWcSHYzKP2usEK1xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042008; c=relaxed/simple;
	bh=WGT1bFrtwD/jSuRS8Jei+oxHIB+yD3WKoSdovx0hhX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZUYSVAIDxQcVO6ITx1UxD/PBjm4og3KZePTaJukxfp3g7cdzqahNtnPWBtw5hmjRcokj/f36y6JSS1uvFcJgDFzDrf+KcBrCHNTF93AWfwzHxGLzvfG+brvS2GULrvmR3L+50SV9gy1c0jnneLyUaOxHXnJVRKdLiN39asBpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7AW8tlC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7AW8tlC"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3999430a12.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761042006; x=1761646806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8K4e9QsTqiHk3qfKy3Xnihi3jMy8cZ9QtWeoxuVjvs=;
        b=W7AW8tlCRouUTNfrKaQDVKtmy4nrDr0/VZX5zbJwP55NOl9yqrAK+f7MtJHRKiTa7h
         vMvTpagq8yS5smRybUEv7EqyY0fXLtnnlAJ/BBDlNrx1TvV1xnSHuvrTNQDZRRRQGjPT
         VgJjOhC9RiLlWjfQBDuTMoGmFE1v2JLG1KQWNNH7ElavbURU4xklRgFNt3/oJlqazTYr
         ETDw/ABE7G+DKgrBxnYJVPCiXaNF9vT2k+QIk9b0lyquU0i8KAXkSW/zrPaQjqt80qJ9
         MmT/JWwEor9xe3B8flDH/XBr0NeZ7ogIR7zvfSnA/3IxYaA7u0jvrctC45GaCR6r5txX
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042006; x=1761646806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8K4e9QsTqiHk3qfKy3Xnihi3jMy8cZ9QtWeoxuVjvs=;
        b=K4YLOGUtEWZ/SRiixzP2E9eshPRdSbQqf4l+Ed42wgdoeJvlsWbdUflqowz57ywxDu
         O4H+gU/0yYKmS5H1NdYG18JQUIbxH64T8XLAaXrN81obubnrCawGqtd6VF7jz12rOdpO
         AJ7VJLoCPZQSqt2UuaHdzeaUp4c13+kO0IeFav1K/zI6XqAT6G5XKGi2kMFCBJr2oRje
         b4EOCsrICzSreePL2SaaYczH0l4YAXEqhF+wc6GZpZMw+e9h9q+zwRzOKJe0hPNoJwbV
         oaYiYw4BSslVBS0r6bfeG6P/wXFdIjEjcIHF/9+j3A1QlUc/OPA4JF6r8duu6XyUN9xw
         VYWQ==
X-Gm-Message-State: AOJu0Yz2BcVEULpWk+J/CADnZugKp+HCALFWu1hERu0vDLC59qJyKLWo
	VMgZU+EOOyS+KVPTrM1FuL01kNKXITmtf2F1zYrN+75PU/LSK8DacFTpR13hhWW+0euzuSex5EP
	t3a3426WFcrP6jc+8Tbot4aA6br1fIHE=
X-Gm-Gg: ASbGncutD8sTn26YhlTNpNZNqIBmbyf+hhLCTCfJ4Nw31Gs/XVatbfygoDtOw9im9ON
	E3Y4oXMB2RqgVE9cQRrFZbOLjhNrYpwgyWMFdWGH8bsMyw5n0skHOJ1yFBostE9RuzZAswq5uxZ
	NsjIQuBnqzVNisXocsahBRAC4gk2oxPMWbZWtKHjR96x1eyijE61TTV0Sq71RgFVAn5UqfKGv0k
	70ko5Ki0KiL02nCrfJ3MwlcUn3NTiN3QC/Q7kssaJeAFQE6sB36HDPqACeXFQ==
X-Google-Smtp-Source: AGHT+IFo94mqNuc8kiTI/HN/SPdhXcdRa9pOxsZUi7dhDx0GocH42G+HUf1ePQg90UqlKHpJezu/YTFd/qKY/fWf2gM=
X-Received: by 2002:a17:903:98b:b0:27e:ef27:1e47 with SMTP id
 d9443c01a7336-290caf84612mr204294715ad.31.1761042005571; Tue, 21 Oct 2025
 03:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760997183.git.belkid98@gmail.com> <CAP8UFD3sxU=r-zVmM7xL84qEsDL6cFUceAV4np6uLxFTVOnWXQ@mail.gmail.com>
In-Reply-To: <CAP8UFD3sxU=r-zVmM7xL84qEsDL6cFUceAV4np6uLxFTVOnWXQ@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 21 Oct 2025 11:19:53 +0100
X-Gm-Features: AS18NWBQZc9AMAyn4P1DI6msOXrFzYmVxbiPRNXwg1XVXI4B4EsubGcVeYQpO6I
Message-ID: <CAD=f0L-9e0uYv-T6HYkCFAWPa57y44PXV0Xi8S5MfHQVgnYUAw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v4 0/2] do not use strbuf_split*()
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Oct 2025 at 08:19, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Oct 21, 2025 at 12:56=E2=80=AFAM Olamide Caleb Bello <belkid98@gm=
ail.com> wrote:
> >
> > The patch series by Junio Hamano with link below,
> > https://public-inbox.org/git/20250731225433.4028872-1-gitster@poddbox.c=
om/,
> > notices that the array of strbufs that calls to strbuf_split*() provide=
s
> > are merely used to store the strings gotten from the split and no edit =
are
> > done on these resulting strings making the strbuf_split*() unideal
> > for this usecase, with the string_list_split*() being a more suitable
> > option in those cases.
>
> Now that the string_list_split*() functions are not used in your
> series anymore, I think you can remove "with the string_list_split*()
> being a more suitable option in those cases".

Okay thank you.

> > Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for ex=
ample,
> > in the series, notes that abbrev_oid_in_line() takes one line of rebase
> > todo list and splits tokens out of this line using strbuf_split_max().
> > However, no simultanous edits that take advantage of the strbuf API tak=
e
> > place but the tokens are merely used as pieces of strings.
>
> I am not sure taking this commit as an example is really useful now
> that the string_list_split*() functions are not used in your series
> anymore. Maybe you can find a more relevant example commit in Junio's
> series?
>
> [...]

Okay. Thank you. I will take a closer look at the series and look for
a more suitable
reference.

>
> > Olamide Caleb Bello (2):
> >   gpg-interface: do not use misdesigned strbuf_split*()
> >   gpg-interface: do not use misdesigned strbuf_split*() [Part 2]
>
> I don't think having "[Part 2]" is a good idea if there is no "[Part
> 1]". And maybe using "part 1/2" and "part 2/2" is even better if you
> want to go this way (so that would be for example "gpg-interface: do
> not use misdesigned strbuf_split*(), part 1/2"). Otherwise, I think
> it's Ok if both commits have exactly the same subject.

Okay. Noted.
>
> Also please start to use the `--in-reply-to=3D<...>` option of `git
> send-email` so that your patch series are all in the same thread on
> the mailing list archive. For example right now if you look at
> https://lore.kernel.org/git/cover.1760997183.git.belkid98@gmail.com/#r,
> you will see:
>
> Thread overview: 5+ messages / expand[flat|nested]  mbox.gz  Atom feed  t=
op
> 2025-10-20 22:55 Olamide Caleb Bello [this message]
> 2025-10-20 22:55 ` [Outreachy PATCH v4 1/2] gpg-interface: do not use
> misdesigned strbuf_split*() Olamide Caleb Bello
> 2025-10-21  6:46   ` Christian Couder
> 2025-10-21  6:51     ` Christian Couder
> 2025-10-20 22:55 ` [Outreachy PATCH v4 2/2] gpg-interface: do not use
> misdesigned strbuf_split*() [Part 2] Olamide Caleb Bello
>
> So we don't see the previous patches and messages related to v1, v2 and v=
3.
>
> If the tutorials and documentation are not clear enough, and you can't
> make it work, then please ask for help and say what you tried so that
> we can help you with this.

Thank you very much for your time and review Christian.

I will study the documentation to see how to do this.

Bello
