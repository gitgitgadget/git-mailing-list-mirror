Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D7264A92
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419441; cv=none; b=HAIup6s/4T+P7HqgXKl3pV0uz8PetonzCVuua/Yzz2s7SQOxGLnjEnjQ634+84/G47B9lYCswXWUGdCnJLBCZ/+8B4knBSE0Pdx+ELJbwl9oP40VmPwMvW01AscUUHE6PBNIr7e+Wpl39bL3P7bnOg1mdca4wbDW9s0yQ6rIB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419441; c=relaxed/simple;
	bh=pIA86w2ta6QRnUu+/uQ8sAN5w9STQ3erxxTvfek1v8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR5kGWN3jzsr5zwOZKSQAdyGUrfmt8W+G0ay1xifQg8bQYOIFYzQg0T9xXDsVZ0a6XKLm34JEZwwq/wQLuSuelzXw73kZDB7PaTsdPwYtoxhjGJh6ZUnWYGuhd8DOQwAA+ynLtYN6ZobNV5t9rlB2MVrUKxMCIKv8hMItXrgNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clQdQyDa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clQdQyDa"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb79af88afso867921366b.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 09:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419438; x=1741024238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8uEd6tpBoIeoK68NwSqpbu1NSQ9y5QOHMXTKGKqeZo=;
        b=clQdQyDaHuRg1lnE7JCAY6oTm23t2byoNncr6ZB67N9als2GWqTd32t8KiYiarhCNN
         mVYvQRULDWBwzujeDQQ8xQ2l5laAL0SdzPuJG4bGbFJg/zTeRtYDyN/k/XLfeTIwZRP9
         WkT8c0Qf6UYX7o2qVSBzG+ZkMSoAz951YxBt8ebfxq2eLRVlinsuAN67wvatZQYr6K8t
         S+bOFXG6JJzffB6vJUygIjxYwhtJGZ0n5NnzUSWzc21JqGvFMGmZKuRxpImobnHOiAhN
         R9VWbtlyihKVVC7y2gracMZteKCjAvtL8BX98BSYcuQOdSTeGrYskOH3MQoFQ/WXZyzh
         gLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419438; x=1741024238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8uEd6tpBoIeoK68NwSqpbu1NSQ9y5QOHMXTKGKqeZo=;
        b=crTLrFC3KyGrXfPB/k90uCdfQQICBV6dIa5pvKg+OH4jMTmy6O+yyUj9IxYwBqDmBv
         UQloKhZCfNyA+Rzdm30wBfjMYO3/+e6tgK14bEex9RsY4EC615j2FMqtUFENj5Ij5K+y
         vcn7aKDYKGWbmSARkVkO+zUBeO5g6eFB/E7Ca7pGs/dBtHL52oJ6iLsdTEEBrbdRKO9G
         mIDFCR4KDbUKaDHP+Udkxda2HnAQO0MkEdU+E9VLtgazhfEO/FgzdiTbqed76hTGlw7j
         3kU20qD69M+v3XsolVY9aiQDYuK8NUHIhAyJLM7df+aBvD3oAsqmkX3ehimRs2GyXBBL
         7wbg==
X-Forwarded-Encrypted: i=1; AJvYcCXL2mvfOHZ5h8uQCQGgXGgoW8jXy8Rx0SNLGVKwa6GFHc+00RRJLc1UWVsWguvqFLBibVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZD4unur8x6spHfY+n4hiKOwf40olqBjW77OwtFmlrC4/Opem
	R+nb6s4enL8lLbKWss7G3ya8ihvv92RkCmgQGM7utKpdZveDpUTh3ZgIc6xc/JmZrWp5FHvTWa+
	T8C3vONTKMQPlEzMY+yxcAPHM8GSDAj5pzEU=
X-Gm-Gg: ASbGncvkwjXBz0HPNeSMZTmny2NIAE6iUzCaACixeHVX7Q68xA0GKrm6xZ36TX+fFLt
	94oTP27dIMtqiSin4dIXMi0LYdqTbB2Tw+hVMni+zh4I6MOjJtm7elpFhANo3KqwvEkcdqlShpR
	6nolNAvNj8L8Dpkfnmc/4inACQ5KJGYG4s+cUTqFM=
X-Google-Smtp-Source: AGHT+IHPJuWKpfUY3NP29Qv4XDdE1choOK47wVoApzEvyYROF17aiKRX6Mm2L66EL5Sb/J43EXSg1T8dfjGtOykQfkk=
X-Received: by 2002:a17:907:728a:b0:aba:608d:4a22 with SMTP id
 a640c23a62f3a-abc09a09707mr1465373066b.21.1740419437589; Mon, 24 Feb 2025
 09:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANM0SV2XOTQ2Mna1B_sX0EF0ffohcrexh1EO5d4G0=sqdmxQtA@mail.gmail.com>
 <CABPp-BHObCVqxWuBLgeiWghy5gM8-f_qjwYFdBL+=j1bwtPg_A@mail.gmail.com>
In-Reply-To: <CABPp-BHObCVqxWuBLgeiWghy5gM8-f_qjwYFdBL+=j1bwtPg_A@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Feb 2025 12:50:26 -0500
X-Gm-Features: AWEUYZnK0MT4BunQyMj4mpcWBajnj1DtePquymY3FhiRuOzr97xo4nlnRlbj6oI
Message-ID: <CALnO6CDpEfugTReF3j_3jefaDg2-YtMB-2XrKg07wD4cofHK7g@mail.gmail.com>
Subject: Re: Diff rename detection performance issues
To: Elijah Newren <newren@gmail.com>
Cc: Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:31=E2=80=AFAM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Sun, Feb 23, 2025 at 2:30=E2=80=AFAM Devste Devste <devstemail@gmail.c=
om> wrote:
[snip]
> > Funnily enough, when I have a merge commit that contains only that 1
> > excluded file, it's the same behavior.
> >
> > 1) if there's only a single file in a commit, why does --find-renames
> > cause a slowdown? There's nothing that could have been renamed in that
> > case (probably the same for --find-copies)
>
> I'm not sure what this has to do with the above; you seem to have
> switched tracks.  If you have a commit whose toplevel tree has exactly
> 1 file, and you're diffing it against some other commit with an
> unspecified number of files, [snip]

I'm only mentioning this in the vein of Elijah's requests for
clarification: the wording "only a single file in a commit" is
something I often see from newcomers who don't yet understand that a
commit points to a tree of the entire repo, but the diff between a
commit and it's parent might show only one modified file. (Sometimes I
think we experts encourage this when we refer to that diff as the
commit [1], [2].)

Now, Devste's posted commands indicate they may have more Git
experience and didn't fall to this trap, so Elijah's interpretation of
"a commit whose toplevel tree has exactly 1 file" is perfectly
reasonable=E2=80=94but we'd probably all like to know a bit more to confirm=
. I
originally read "if there's only a single file in the commit" (with my
newcomer lenses on) as "if I only changed one file before commiting."
This is also partly based on a (mis)read of "a merge commit that
contains only that 1 excluded file" (perhaps OP meant "modified").

[1]: https://jvns.ca/blog/2023/11/01/confusing-git-terminology/#commit
[2]: https://jvns.ca/blog/2024/01/05/do-we-think-of-git-commits-as-diffs--s=
napshots--or-histories/

--=20
D. Ben Knoble
