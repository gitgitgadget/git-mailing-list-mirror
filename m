Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79299181
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643445; cv=none; b=ICk4XAZAQYdCg2xeP5esQ0INl9evrYFN/pe7kUDaZAHimpz67ReS6ENuYcAhq1R/fM8btbvg3JG/Ov/VzxS0epUClqxBxPv4pwbdfHk0pN0bYw/CgoDyX5TVyvdoRDFZZu+S8OLEsHmFAi9DbAq8dzG0lExiRZtK82zwsdwojEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643445; c=relaxed/simple;
	bh=Fprf9x6HSMljxQ57nwz1KStg7BhMnPNoZ0WJ1GQnysc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNDz/pgz1l/Yzcq3QfYW4MjQ4v58BFUqGsfE9xYOKgtmgnsrJGSdBtzVu+vE2rom1yMaW4LJSuPh+NgkiRdufUpGeLEp4ZwS6Xs1hrnBJyMjg1utbbZyu/kb0W6JypKflGzfLkt5zUu5odRiHlncwKfTdmItb4YEqtSDqf4ABmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8jycsjj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8jycsjj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso803474466b.0
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 17:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722643442; x=1723248242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coB8d+ehijVsJZguQAur22KtN+sdbswbeIg9xR9tBxM=;
        b=W8jycsjjpiYDcahy6F4auKu4iLhlH2zbHizHzMRgyI5oUxe1AXlEbeDKJMX3KYZOSK
         4emQQ3IBpsqtzZIyKoNCgCYYZ+/JVgU52Tia0rciqC9Xe7BwTOfJuRQh1YPkDxSslNPp
         MQ9lGEBJTdle7tEmWkpSZVSosH8MxqWTIvcywe3ZNVly3pC2GPzrTK4Mq7xUElaME3Hu
         1iYRvXf5YNSjXTjMy5QZ19dLdtiFbh2EpCnI/SwzSZ6p/b7XCX83gzfDqgVgBvbGy8HS
         syt5TLgjJcOjEejxvgPhb6GnbBWpcK/UntjmWCBMhNrGQxW/lmXM1WqDFwgeo3JIkiOS
         CyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643442; x=1723248242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coB8d+ehijVsJZguQAur22KtN+sdbswbeIg9xR9tBxM=;
        b=tRQa0iKOvtsbNFIg6zAXnxSjymXGkKHIbGOMyLD4ogV9BYEXZABvjHkzgzn3iTlZZT
         ZZpuKV0/HKWwPJYnzdeAVL4I2wLYPsbMjLK290Iozzc6DGYRd/RTtpB8DhNs5ANkxowP
         JGvATU0R20AUTvAIVqiVg1SJWvkmUkRbyftOzNo5goGds8ahKWIfFgtW/mUg7rY8msYV
         UuRM+KYSnCMQThQjPI6Us7M+MRXaxbK2itTXeLXs4TVB2kroTM+iIftpxwIMFO2e3Dg/
         +UzEQ52Q1abdhWMFDlUAyndOecOXGjwaFK6s58sV9dSYPg8WuUzIDGA9HACyK8r335v+
         VjUA==
X-Forwarded-Encrypted: i=1; AJvYcCWAhM0IqeFgSYAnE5PeLNArLjcYH+/uKBp/g6zN1nbmwXWQynfenFRwwSxd2Ee7J44s+0EdxSyYtXCY5YMsKnAQ8ErE
X-Gm-Message-State: AOJu0Yx0tP9+hAYuwHgylReZ1SBBAUu/ej8dqEHEo7V6DGEKmmURMEVc
	agGnffAf/YTLnt2LkembcQjy9YMOrdldrHwJC+9XB/Ral7rtf7gudOMRlGualOQg7BA4MondmTT
	jtfccHP53MqJ7drzuqmg0Q8MeSPAztbNIT1xK
X-Google-Smtp-Source: AGHT+IGiqr/B673iFkWTCxyZpRL2PifShTFLsLQbKByV4Rvs5yuUUV4LY1PTng6uEz1e9Z+qFf6igw3M/DWDlWNCAm0=
X-Received: by 2002:a17:906:6a01:b0:a77:e0ed:8bb with SMTP id
 a640c23a62f3a-a7dc509f7e3mr377012466b.42.1722643441359; Fri, 02 Aug 2024
 17:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
 <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com> <818dc9e6b3e8a4d449cb9dbce689bfadb95099ff.1722632287.git.gitgitgadget@gmail.com>
 <xmqqr0b6a9hp.fsf@gitster.g>
In-Reply-To: <xmqqr0b6a9hp.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 2 Aug 2024 17:03:45 -0700
Message-ID: <CAO_smVh-gQWy7xUJgFjd6gUWCTV5jTYJ9E9E3rvaQg0EY-2BdQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t6421: fix test to work when repo dir contains d0
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Kyle Lippincott <spectral@google.com>
> >
> > The `grep` statement in this test looks for `d0.*<string>`, attempting
> > to filter to only show lines that had tabular output where the 2nd
> > column had `d0` and the final column had a substring of
> > [`git -c `]`fetch.negotiationAlgorithm`. These lines also have
> > `child_start` in the 4th column, but this isn't part of the condition.
> >
> > A subsequent line will have `d1` in the 2nd column, `start` in the 4th
> > column, and `/path/to/git/git -c fetch.negotiationAlgorihm` in the fina=
l
> > column. If `/path/to/git/git` contains the substring `d0`, then this
> > line is included by `grep` as well as the desired line, leading to an
> > effective doubling of the number of lines, and test failures.
> >
> > Tighten the grep expression to require `d0` to be surrounded by spaces,
> > and to have the `child_start` label.
>
> OK.
>
> I think I actually misinterpreted what you meant with these changes.
> It is not what the patterns are picking.  It is some _other_ trace
> entry we do not necessarily care about, like label:do_write_index
> that has the path to the .git/index.lock file, that can accidentally
> contain d0, that can be picked up with a pattern that is too loose.
> So it really didn't have to clarify what it is looking for, as it
> would not help seeing what false positives the patterns are designed
> to avoid matching.  Sorry about that.

I would have included examples, but they're quite long (>>>80 chars),
so seemed very out of place in both commit description and in the
codebase. With line wrapping, it wasn't very readable either. At the
risk of this also getting line-wrapped into unreadability:

test_line_count: line count for fetches !=3D 1
23:59:48.794453 run-command.c:733            | d0 | main
      | child_start  |     |  0.027328 |           |              |
..........[ch1] class:? argv:[git -c fetch.negotiationAlgorithm=3Dnoop
fetch origin --no-tags --no-write-fetch-head --recurse-submodules=3Dno
--filter=3Dblob:none --stdin]
23:59:48.798901 common-main.c:58             | d1 | main
      | start        |     |  0.000852 |           |              |
/usr/local/google/home/spectral/src/oss/d0/git/git -c
fetch.negotiationAlgorithm=3Dnoop fetch origin --no-tags
--no-write-fetch-head --recurse-submodules=3Dno --filter=3Dblob:none
--stdin

where each line in the `fetches` file starts with `23:59:48` here.
It's 9 columns, separated by `|` characters, and the line we don't
want is the second one; the regex `d0.*fetch.negotiationAlgorithm`
includes it because of the `d0` in the path.

I considered using `awk -F"|" "\$2~/d0/ &&
\$9~/fetch\\.negotiationAlgorithm/{ print }" trace.output >fetches`,
but it was longer, possibly less clear, and less specific (since it
didn't include the $4~/child_start/ condition)

>
> Will queue.
>
>
