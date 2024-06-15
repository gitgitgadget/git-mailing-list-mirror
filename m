Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163211849
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446928; cv=none; b=OgfZEWBu+EQ5XofeFxodNstPCYBkVYtgHvS/Yewe7yYoftq/sTd9stCvjQCe1TXsMzDjPdEtPz4Emkzens3PP+/xO/bLVzw6TRN8kUGsEe75VqWY0Fo51F+eYd3ZPRX1JWYPZZWmjvPBEXKODrYwer2Xc8nibMp24+N166O/QeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446928; c=relaxed/simple;
	bh=Y/WOK6B4TWktwxjfszkYLBcC/W5i8Q1qk1WuyK5OMaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iu1IQv5uq+FrYdLJfQiRYWa4gZYuMEkT0kuk0G9wcN7Ayzql24VTOkNy4cw8iNkhZh9M+FbsCPXQqWJxXpIg25lQDRu4JneGhbTKhW5cGkY7bmQbcmJZBCABGXKSQeTxoUFCsrj2pKwvdtWMVIDYcG5u8ZzXMCQbIGFOLUhQ0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyMyjxCj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyMyjxCj"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e9f52e99c2so2286574a12.1
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718446926; x=1719051726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrQnAnQpgFSHZ0erFWBoI94kCITDsuikhj2sjk3nKHA=;
        b=HyMyjxCj5MQex3OpIW+c1qHCTmyl+k8veTnzfexEetgA+kfR+PvrQPOouZbtBB+Er+
         G/AfJ/HRJdosUJA2nc74FYpzWW4zxhf0a1PPvNGJXstFUEwhFkNcr3WRycsWrM5WccHv
         8DM1YuakgS3QZgAl1RLgNq1ekDlz8QVw9luHV0FxrqZL9dovtxAsJOX+tShzy9OTJzXw
         wticbOcABU9/O3AB80T9rsojSeEYccPlixe+tiMWIPoOZzYguptTIqgC+wQRYMNRlq/B
         m1T7yQDXw8XUZAbZQ0RD95GQd/gsYMOMuQnw/E7japxC0ZGQBOamVPG1hGBN0RcHGcmJ
         aJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718446926; x=1719051726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrQnAnQpgFSHZ0erFWBoI94kCITDsuikhj2sjk3nKHA=;
        b=GzroyFkOyLmKdt/GZnKsXrKLDR/c58DopD8XxqS7GJ6syP7pNAj9zY7zEbfu9dTTfN
         FjkkYCjaUGeHv8vZG6mzIEml/jbx8WjeMA9+YUfEw+ECxQ1JIudnyvmpx3U6tB9divmV
         eJfIMsS5clrKTb6uXwem4XMZuUl42gJRbKImVtZc3hmOjHjjh3t6rEn13b1qDUqcf4HQ
         qNZ/hwhe34W3RlaMtsQYVRurSDlrW8eU8nRESWlYIgqP7z/RyYrAeG3wQg5vAv8wO0Ye
         MX4udBh9mrXJOzyqXDusui0o41HuJ+qW1gE7se4uDK1RwDvjKSzLYv2tGiThE4kXBNVD
         IKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH2jZhH5mExzPSqOslAl/87Y5fmHxgNBnez4E2SDRkwT0NAmdAL26rS5putlH7aQwaaZ2i4pKvwfLuM+pYEd78UYIK
X-Gm-Message-State: AOJu0YzWrzJjxf08hgNn+wWWvgyyNr5h1SyBosL9K2Hz0c6gGZPi5r2Z
	mNJR7SqtjEhqWeVmksYDn4A7NrEc70m7e3VGBdRAIPmKZgW++qjAkMmgs7lP8wbgk/u0JFKXvdB
	ccMlrhwMcD2oNr582idG7IzK4i9E=
X-Google-Smtp-Source: AGHT+IEYhZjk3DmW7Ag0y8eJtgCjMqgt/7dcCTrCHbD4PZlFLQxhbCn+sTfBA0YTXUqc6mQQzZdjdXp00+wGlbBqR3s=
X-Received: by 2002:a05:6a21:3987:b0:1b1:ed95:c9b1 with SMTP id
 adf61e73a8af0-1bae800c4b2mr6231057637.40.1718446926481; Sat, 15 Jun 2024
 03:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALyzih__9sZD31SVMECcxk55+MAMjkfgpLzecoHo0xUoauerqA@mail.gmail.com>
 <CAPig+cRGnAcfpr4JWp9WWC0b4yvjKx-_0up_S2iaXCBxgcSLjQ@mail.gmail.com> <xmqqbk43dyln.fsf@gitster.g>
In-Reply-To: <xmqqbk43dyln.fsf@gitster.g>
From: Rickard Andersson <rickard.a1992@gmail.com>
Date: Sat, 15 Jun 2024 12:21:30 +0200
Message-ID: <CALyzih-5qtezCnizj07Gi0MyoeweXU1Kw5-gnv7YwSg0DC965w@mail.gmail.com>
Subject: Re: git grep bug replacing - with :
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Kudos for the very quick response times, nice!

I tried to reproduce this in a more isolated way and did Eric's setup
where the issue was reproduced again. However, I realized I should
test this without my gitconfig and could then isolate the issue to the
pager delta. I then noticed the issue is reported there already:
https://github.com/dandavison/delta/issues/1674.

So this is clearly not an issue in git, I should have tried without my
gitconfig before even sending this bugreport so I hope I didn't
take too much of your time.

Best regards,
Rickard

On Fri, 14 Jun 2024 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > On Fri, Jun 14, 2024 at 3:22=E2=80=AFPM Rickard Andersson
> > <rickard.a1992@gmail.com> wrote:
> >> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> >>    Added 2 files to my repo with words in them
> >>    text-file.txt
> >>    text-file-file.txt
> >>    ```
> >>    git grep -l ExtremelyInterestingWord
> >>    ```
> >>
> >> What happened instead? (Actual behavior)
> >>    I get
> >>    ```
> >>    text:file.txt
> >>    text:file-file.txt
> >>    ```
>
> If the command line were "git grep -l <pattern> text", and there is
> a branch whose name is "text", and in the top level tree of that
> "text" branch's commit there are file.txt and file-file.txt both of
> which have the pattern, the symptom observed may appear.
>
> But ...
>
> > I am unable to reproduce this problem:
> >
> >     $ git version
> >     git version 2.45.2
> >     $ git init foo
> >     Initialized empty Git repository in .../foo/.git/
> >     $ cd foo
> >     $ echo ExtremelyInterestingWord >text-file.txt
> >     $ echo ExtremelyInterestingWord >text-file-file.txt
> >     $ git add text-file.txt text-file-file.txt
> >     $ git commit -m msg
> >     [main (root-commit) 765269f] msg
> >      2 files changed, 2 insertions(+)
> >      create mode 100644 text-file-file.txt
> >      create mode 100644 text-file.txt
> >     $ git grep -l ExtremelyInterestingWord
> >     text-file-file.txt
> >     text-file.txt
>
> ... with your (i.e. Eric's) reproduction setup, which agrees with
> the way how I interpreted the problem description in the original
> report, I do not see there is any other possible output from it.
>
> Thanks.
