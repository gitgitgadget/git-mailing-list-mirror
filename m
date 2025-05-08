Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606817BA5
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710348; cv=none; b=bMJPbRmt/5GiOUtSTnKPh8YM5j8FflgSk8QFNhlbrwV8DAmAMn8AxCNB6yXdYJ1vpln+0kc1X2+KPmrixY3DgogaRuZuDRTavOZpIWTIFEoFYzmIvCEgvGTaivNksH93dZ9D3X2BwjboLNJ9HuSWjnQPSAc3iWRWogz6crvNHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710348; c=relaxed/simple;
	bh=u8n8MqTktY64IHZmBE2PSI9gILn9dIY2T6Vs/oDzMSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eD7bx7SNaR+L7Ef9+b9SC0VYtGXYeLDpBdsvuMmWEcrfOibHekOO4BKb5mz+XI/rwfDVhK6E95EFBHsHpiWERMWBsVbUV/EhZH518KdQaJDFVk1HR4HnIFCqiIWXlgUb4tS1x6+7/SSecQ5ujKoKcSnkTIs3prc0+2xVdq0ICHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfdgYWcg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfdgYWcg"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so1523522a12.3
        for <git@vger.kernel.org>; Thu, 08 May 2025 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746710345; x=1747315145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWNHoJlqVBDURlRawd0y1LogWpAKo2mXppCzUjlWYcM=;
        b=DfdgYWcgnT85nUJWOJqLvXLLQH0x4aWPJgo/T2t0NP01xrk8LjjKXEcuoerlglRnOu
         xW7rgLvqNCF6Zi41rxxQi2T6lU8PDfHzO5wjnF47zvSH1mLgc4/becgRXXczA6XsBGPd
         R3Q9vQuiaB9UpPh8HpfOxE7e9KUIfQ7jT0BQCL7dmrp654YwfzXpGrW7srrU/8BKYjbg
         gRYT7SwHhwZIxy3Xc7ecUvIXqLBkRg2EHYkbf0srgcEj+lnh8r20N+RLAmEUStwfnujt
         SvHOOeMaMGO2F1H3mAwiljWl/qM1Zncrq69Tosswo96S8TnZy8BIREyGXk9oKAirVYZy
         a4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746710345; x=1747315145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWNHoJlqVBDURlRawd0y1LogWpAKo2mXppCzUjlWYcM=;
        b=t/T1hmOrb1+dJyOZEfvDt8Q6AUzNgnGgBdzKWlzJqMviYElWvY+t8PDGYSjMknKdKR
         YJz/CRfdo59yydE2NO9zxA1661zX+OpVAKDo6GgMEdutNX3xCiToujVUXpQMb//RrpTf
         yyw82O1gYFyJAkL8UKK7DnKYRM9NlTGD4Xnm9Y4R2eCYAPdKDrqALFmoNTCTihMqKYjx
         BwcyYaLylsKPwAq1SrqDt5Stjkf3110SysgF/hjrOX2s7pG7dSgGoRwrR1qWM2Bgousz
         xmRwk7IyY7DC3XFE4TKYKJHIcwxCYGmp/dGp3GzGKf84q5Y7Zyub36hv8jDn1Z22FyIh
         S3kg==
X-Forwarded-Encrypted: i=1; AJvYcCUNJqiYmaEmVleZIh0MQjxXHLsx/T4xPkrAE8iz/cSMggp11omtjk7OO9L5HRgRQby5TPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gzD5RoQYcwIDnZcjvn1ap0Mc82McpsCosdlSEEH/VAMTowOR
	a5i1cx7aRbwO4i7PnS7a3Cpy/MdnT+nULCpEkvKWqwULhR+jdrWtLdU9qubxHA9FYGiXjtJmKd6
	eWouL9oOTA7/cYoZ8GfkqCgfP4V4=
X-Gm-Gg: ASbGncvxsdnX5nUQic2xATvMrfm1tiGRb1R0oVogHB543PUhOyNjsthAiP/NJKLWoBa
	saECTfjn0Y2s00xY9SXYTaYs3GZd9dKNu7cSxofuKcukZmkONk+hjA3YZ2eMMoV2zf5N4kA94Bd
	rFnsNuHz6ZF2MGE6GGRH3Kixll9UeSjUwClgJu+h8VyAlUr8M8dLhXLNs=
X-Google-Smtp-Source: AGHT+IFIRDglj5B3+83EhyY8VFL2Z1dm/ChOL1ZhZ83r1ZPp+7e2M7tquTFy/L9ZYMDKQStJad8BsIIrMqwreiSY8nY=
X-Received: by 2002:a05:6402:42c7:b0:5f8:30c2:8650 with SMTP id
 4fb4d7f45d1cf-5fc34e824bfmr3135769a12.14.1746710345156; Thu, 08 May 2025
 06:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com> <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
In-Reply-To: <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 May 2025 09:18:48 -0400
X-Gm-Features: ATxdqUFkYy7BdfTLAN14IlHyIROu-b8hMD2FEBVNBXGicqszNlJ0DKZjJ7s1ayk
Message-ID: <CALnO6CBzKbo86RC0DprT+ZxWfbsea8Kb7ZZurSZeMMA5HOthSw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 4:23=E2=80=AFPM Marc Branchaud <marcnarc@xiplink.com=
> wrote:
>
>
> On 2025-05-07 10:22, Toon Claes wrote:
> > Marc Branchaud <marcnarc@xiplink.com> writes:
[cut]
> I agree that blaming is a well-(known) concept.  I also agree that most
> users would understand what blame-tree would do, *once they find it*.
>
> But I think that's beside the point I'm trying to make.  Git is
> notorious for making users learn countless commands, and having two
> slightly-different commands for blaming is just going to make that worse.
>
> I mean, from a usability point of view, it makes much more sense if "git
> blame" simply understood how to handle blaming a directory differently
> from blaming a file/blob:
>
> Want to see which commit last touched each line of a file?  Just run
>         git blame path/to/file
>
> Want to see which commits last touched each file under a tree?  Just run
>         git blame path/to/directory
>
> Git should be smart enough to figure out what to do from just whether or
> not the last argument is a file or directory.

I quite like this idea, too: today, "git blame t" in git.git is a
fatal error, for example (no such path 't' in HEAD). (#leftoverbits:
it's also not translated?)
Turning an error into a new use case seems like an excellent expansion
of capabilities.

>
> >> If this is really a form of blaming, then just make it an extension of
> >> "git blame", like maybe "git blame --latest".
> >
> > I'm afraid that won't work very well, because the code is very much
> > different. If naming is the only motivation to shoehorn this in, then I
> > think it's better to rethink the name?
>
> It's not just "naming" but rather trying to help Git be intuitively
> useful to users.
>
> Also, I think sacrificing usability because it makes the coding hard is
> unfortunate.
>
> I personally think it's fine for blame.c to contain two different
> internal swathes of code that do different things.  The ~500 lines or so
> to implement blame-tree don't feel like a major burden to me, especially
> compared to the ~3000 lines already in blame.c...
>
> But if combining the two features into a single C file is too much to
> bear, perhaps refactor the existing blame.c code?  Something like:
>
>   - blame-file.c (the existing "git blame" implementation)
>   - blame-tree.c (the new functionality)
>   - blame.c (exposes both blame-file and blame-tree under "git blame")

A third alternative is to allow "git blame-tree" as here, but as
plumbing. Then we have "git blame <dir>" use it=E2=80=94today, that might m=
ean
directly invoking "git blame-tree"; in the future, that might look
more like the relationship between "diff" and "diff-tree" (assuming
there is one)?

--=20
D. Ben Knoble
