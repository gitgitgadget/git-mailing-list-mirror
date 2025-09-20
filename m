Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653D1FFC7B
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393097; cv=none; b=JGtGWFNjjMAMnDfWCoZ5s0RszZsQJcOfl1gGaYo7zbWOTNuDORIjgC6Ih4fkVzI0znVsLTjxyVAp/aj+kacRUF+fVOqwtKHmprdsj/Axl8Ld7zkUM2YVjyI6WnxExTdgX81CdfJyNdj76qMFLiLa9P+Fjj7TSRGRqvOODVHuLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393097; c=relaxed/simple;
	bh=P65V1t/3EWkbCmphbqTQgU7rILNPte2TR2MXjQNnS7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua7wM7sQzpd2SqoVd5msPMCty2tTN5vAOrIN9hGrTF+0Qm3qF2wt7UIT8TTLkNuLKUrmGvCzdsZPeczmWj6yGMXbce4rYMmkk2TzMFif5V5iYPBkcEzlEZxnTinps7VC1zyBK56psn56t2HfwsI17TP6ga1r6rw2RmchqqzlVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6470GDT; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6470GDT"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4248c9a64f7so3842615ab.0
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758393095; x=1758997895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChzyM4I9X490kbpRWZHWuBYsMPvUSrtcfkcuKt41oXk=;
        b=d6470GDTbedUNrQPzaVM7qe8QwtNnqN+98u9K9DD7wxI0SXfjSPxW4d8o831R2rGRx
         G7bqAnBdmv/0g6NM9KTjO95M2EdUaKO9pAm7dy8NAMjsgz2cm8sfTpj75RPX+aMFY33L
         3IydM+kEUztYeqho2hv6OJxe5eH0RGkWTYINdg1lQgzTleZ+vHwqH4zIuIPhQZUxN4N9
         WHPdzwH/3FN8oTM+Bwn4rV2G1QYqPerglCfCkjK2TdDWY8yfmaxklhHLPIqdIwfLWKbJ
         OeLtUF3WD5/3aV84r+B/ro6ZIn8jSR7YXMLvxZBUeoxZ7KkIN9B7w3VazbucYNSN3Cb8
         x5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758393095; x=1758997895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChzyM4I9X490kbpRWZHWuBYsMPvUSrtcfkcuKt41oXk=;
        b=WrscRBKR4NqPeW2Ox3CyF+i6HAnq7yuLopj18rtU86sKoEqxEm7shyE2GoHDxnDlok
         Twn56koxBOx8Zpkj5LiPfGsorwtGVST1qKh0e8nvrGz91Y6Pvxl6dLPfUd4X7la1WF+i
         wNw4MLSKnM/KjGH0UjyQUYI3K42WslIs/RvepcUy4HnTw+yayyo1wADUZtFk2vhszaqu
         BkDtuPBngLsakR76wE8ilUadqn38WuQdyUIhgr2EQJWjW9VCQ7aEg7fhcGyuQO6b+Hzo
         1GIzthCx8OSNZGSlQ1ZPPKERuFSjelxMH8hMJpKIvut13tlPL7M1WdyqOuS1JvDJ33vD
         i4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVV9NqypgCm04cidRhK3i8ucIP+4EWtM/LcKqWyp6YtCAr+qLcSZHsETZvmZEkMmYU+aMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuWmtN8oT2dF5N2st1/uaV11EvxRnl1FIAN7EjE21+VN9FBacE
	IkzDQxwLHwAyLQEXEMWrKXi+R1ZlcqgP1MW5ar5hEz0ek3KsvV/FK4PaeqKD3bjytpYb1SV+j9l
	M0VxTJEgELOqXrAS0M6oxAM3rtwAxA5M=
X-Gm-Gg: ASbGncu06L/a/dm6M7e3WumkGqK3lU/7zAdgNxKXQfDAXlU6HKY9h33bymiVvu3Ed8F
	1Ehs5eGNd9gNlUZUCvnxGvGUMQ0wUUzMnK4rysTPhnvLFZVHkgKggKh2qlUrqJ1o284fVYlACA3
	b+4zobuoPtWQi0/6xwcLz1GR0UbTFRcY7gq+/Z4OSxnin+7dca8iTHVXrs7AaCp4z0mlvTTpQ6M
	i1v6HYV4tsh2EF/olyLTz6KCji9dvZ2nNWhyo/E
X-Google-Smtp-Source: AGHT+IGcXroI4KPwRUEZOOS/u59H6wqaA1isK2dRMmt62/meeyKyZIAlQMPJea2pN3OsvICRMbozOkjR6/Kxe8g/rgM=
X-Received: by 2002:a05:6e02:11a6:b0:424:817a:5b84 with SMTP id
 e9e14a558f8ab-424817a5ba3mr86539465ab.5.1758393095319; Sat, 20 Sep 2025
 11:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
 <xmqqh5wxxcwq.fsf@gitster.g> <CAH=ZcbDzBvmzE75-7-BresWG0tYW05-1G-cnT+FLeuJe6JStcA@mail.gmail.com>
In-Reply-To: <CAH=ZcbDzBvmzE75-7-BresWG0tYW05-1G-cnT+FLeuJe6JStcA@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 20 Sep 2025 11:31:23 -0700
X-Gm-Features: AS18NWCfFodVM-DVKumBs1OeXqFAzKlHN2ZKGxv5OVZY_0r_vZQpIfSZG2_-i7Q
Message-ID: <CABPp-BFJPdVkA0U14_B_EzTj6rAi3jPFcQgW2uPqSz1ZBOdKAQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in xprepare
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 10:41=E2=80=AFAM Ezekiel Newren <ezekielnewren@gmai=
l.com> wrote:
>
> On Sat, Sep 20, 2025 at 11:16=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > > Best-viewed-with: --color-moved
> >
> > Two comments.
> >
> >  - This is a bit unusual to see in the trailer.
>
> I'm still not sure what the etiquette is for including those kinds of
> flags in a commit message. Could you show me my full commit message as
> a response with your preferred way of adding those flags in a commit
> message? please.

This command run in git.git will give lots of examples from various authors=
:
   git log --grep=3D"est viewed with"

I didn't call out the trailer because I saw Ben suggest it in this
thread, and he said he had seen Peff do this.  But, searching right
now, I can't actually find any such trailers from Peff or anyone else
-- am I just searching wrong?

> >  - It turned out that it was a very effective way to spot a typo for
> >    me.  You should try it yourself before you send out your patches
> >    ;-).
>
> Huh, I have viewed this patch with --color-moved dozens of times. I
> think CLion (My IDE of choice for C) "fixed" that for me, and I didn't
> notice until you pointed it out. Elijah missed it too. Maybe my
> terminal needs a more extreme contrast, so it's easier for me to spot
> things like that.

Yep, I did.  In fact, in v1 of the series Ezekiel didn't call out the
--color-moved thing, but I used it and mentioned it in my review, and
Ezekiel decided to mention it in v2.  When I looked at the
--color-moved output, I saw the sea of purple and blue and skimmed
quickly to verify it was all purple and blue -- and apparently didn't
see the one red character amidst the purple and the one green
character amidst the blue.  Since the range-diff showed no differences
to v1 and I had already thought this patch was fine from v1, I didn't
look at it any closer.

So, not only did I miss it, but I missed it despite being the one to
suggest that flag after using it myself.  Oops.
