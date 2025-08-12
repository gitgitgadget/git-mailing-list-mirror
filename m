Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0B2F6571
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016965; cv=none; b=QaDL43pV5+k+cl/ARr84pKYA0hOvTKe5GCGUnLZa0RRVEDINjKucdR7tfFHpRoc50x15JptwVYHr8xfdc7XduCQ9Qsbdv1T9AbqRkFGnnKheoWHnGeUZADYTqivhpxLx8nw3z7Zb8Wx26Oh2X7UxCs7gaBrpE2APt07nEnS0dM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016965; c=relaxed/simple;
	bh=nYNquAlVj5YL7pFvfX3OjmIRyBHaH6LyHHYtNSj1Y7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsL0Rn58MY0gdq7LSZ7QelAXLM7sTB9H1Hi1na+0CrzCEglKHmstyMkjYLNpxJa30XqUiMFIFObp4LzWoORitl1nOXwtIQPvAsJyK50ERHGxJEjBMsdDyKJME6hdrpXv0IZekm1zpj18TMTSqhGFkPumFFzYWcJdKenLDHWYLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwXrfzvH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwXrfzvH"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615756b1e99so7736071a12.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016961; x=1755621761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQegTtoqL/oA1vL0yCbEVUPP/1xocQsw57UlB8p+/1Y=;
        b=MwXrfzvHZLhJNLmnGqlcONazR09KNDwk5hXiCEnZyJidcZNok8dBKTW9HRlgmWxcte
         4+6qSLrETW1XK0+yWdwN99EB+iutAIVw//LTHEdAFZOqRGuIMzBbrVhXFt/i63vYn5XR
         MSu4tnM486O1yaQX2DwHc8VD8Kc74n/c+lUIIPXaHIA5n2cRlxBfbvAvvWQNRX1LzykW
         iTAWPfMSePBv4jLof6r1GyxyBBOciO1Tl3fikWOBBEuvPos+VQuB0PgLBT/SkLDVAhGA
         DyVh6gzj8aibK9kbos3XSJQ3fd3x1EAfWOaHF5MGAIeBzak9+dBjVHR3PvYs3B/v9Q24
         8PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016961; x=1755621761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQegTtoqL/oA1vL0yCbEVUPP/1xocQsw57UlB8p+/1Y=;
        b=MunSyjQtPxOis4LvZAmiSK8Efc72Q26a5Bj2E20oZ7ZB80xBZVizPXj23jWYPyxvHT
         hdb+GX+b6vSdHY179/tDTBMo1CFxnTEIJNu5kHtDHZvz9qFaWG6Uk/Qlq91ytOrfauvZ
         oD9mDsQxIjblKkZNUAG4/3QF0YWV8NHF79cE2E/Fk6AKM+oEf8jku1Uc71TkiNDztdxR
         8ddfZKfqj7XPogafySKfpd+M//nnB/O9badXOYjdFa4UdQ1jM5dXhKYLs/lE/ElRMIwT
         DJ1+rSQq6XUmyTJJu67yAeYg7UWJLk429RJnyXUXJBwYZnU1pPcOM+3RB6qtoOKpHH10
         AyEw==
X-Gm-Message-State: AOJu0YyFl8IpcKUSIGtqe5KcQrGgpaRRl4nbpfNwSoWKUKG4OQEQVLVi
	3hCS4l+T3NnrO0vHQDwFeOC9/+7bxj+zY9OILRATl2jfat2zKTzIG8Qh9f3PW7w3n8NBrRgFDe3
	d85BqRnTT+F9P0j9+C6iTTudRDYAYrj3yp3Xc
X-Gm-Gg: ASbGnctASLlQLCx6KnvEztFLWiI6/NW+cfJU1xldhxMYStNgiYaAHAlI041+KqoxwEN
	HhgdjbVNDj3vbrYjpaeWzWhjoPHjTcJHokMX9pTI4gF/sJ7d5lizN4/+iUVIhxAXOgo0isxYrbR
	6oZYEeYISkNwL4WpPXFpMcQQdHsV16bViN8nAGXkyOikYiZBfPD9ZL7Aij3VssH6s0DLiljZE8W
	Lk4ecMI24g132NzdenimkrOd1h9CTctAlqsR1I=
X-Google-Smtp-Source: AGHT+IFP+kwfAyvQpPrVgcssk1unvduzdk+4rb6Eua7WbbHIC1p/llEmWLMAPsZytJrK0mc/s1Sc056NfEe8f+y41XE=
X-Received: by 2002:a17:906:f5a8:b0:af9:3f90:12a0 with SMTP id
 a640c23a62f3a-afca3919058mr38456866b.16.1755016961383; Tue, 12 Aug 2025
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
 <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com> <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
In-Reply-To: <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 12 Aug 2025 12:42:28 -0400
X-Gm-Features: Ac12FXxqXPw0usWkF0d5uTVtCh57SOJgF1GSHoq_tkEn2gS94Tl084xORJXKGtg
Message-ID: <CALnO6CApnHgakYf_ihVOxkmOq9_Rph5hkK_9aC6vrecFhgjaTA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:16=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Mon, Aug 11, 2025 at 6:59=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> > > Le 11 ao=C3=BBt 2025 =C3=A0 18:17, D. Ben Knoble <ben.knoble+github@g=
mail.com> a =C3=A9crit :
> > > =EF=BB=BFChanges from v2:
> > > - shuffle setup code and use more helpers in 1/4
> > > - insert 2/4 to stop abusing --exec-path
> > > - improve environment-cleansing idioms in {2 =3D> 3}/4
> >
> > Some of this shuffling turned out to be unportable, which CI caught (bu=
t running the test locally didn=E2=80=99t??). Fortunately it pointed me at =
test_env and I=E2=80=99ll either use it or go back to the subshells.
>
> To catch it locally, you can run:
>
>     make test-lint-shell-syntax
>
> in the "t" directory. Alternatively, `make test-lint`, `make test` or
> `make prove` would also have caught the problem.

Ah, thanks. I was particularly confused because running the test file
directly does run the chainlint check, I think, but not this lint.

--=20
D. Ben Knoble
