Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFAE2D027E
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317290; cv=none; b=YdLPHCZLr28otd3rnYN0ub+6WdHGpzhW6mBhK11SzPjCWXnp0MU5UfgJ+81Cc1AutYRrM2qZBW1K5C5zWHxQHaVI1tAwtRneyasW6w80ApxCcBrMXpm8MaNNLr2DwcUOtgSaLKi3uprMN0UogvPp/619MPJVo+iCXKXb/O6aOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317290; c=relaxed/simple;
	bh=diKYkEwtlSEEl788QxBZBNps5C+YwqWEosvTGLTau1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gt9yTv2uhZsyyjIHXX9bKRpGQfX7aointG31FkUa8I6KIFa/qOaXfbllCd0u56vjalFC4J3lX+6Yd4Z5cYpi+t353i1yd6k7ANpM+1TOuM650rrCOajRBpwALhvHXSjTgfL/8pAo69i2dP8Rji9rUPUBZYmF59qUNKxBN2xTaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFRWkgZW; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFRWkgZW"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9486696aafeso70541039f.3
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 00:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317288; x=1764922088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5xiwSTe0AtsC6K77xev7rck0np6+XM1Qze3kfrfW1o=;
        b=HFRWkgZW43rxkg1UaWxIoRSARkNerxK3lN0mMnuWdejD2hO2CF3bea6Rav0biOQDnM
         NiwmQwL/xKf4QJYTO2mNcmpHtz9jv6B7/c3zjMZl5R2El36+orAfkySWC8bHJQOaKW3R
         aUmqKP4mwQryzpVr30l33Xqca88EG9ZrkPqWnTt6GZFJDBsyg39fJGTi7vE9QvcoRCPz
         dp7Z3EaJWL33FqO9aV+L1jEL5wBhifAahgGpSc0YbOPmmxld33GMDHZChYZMweebOf0n
         DOrQ/rYzxQfvFd9MaiEOZOqCZ79EvAVFDTGaCm1Wx8AX51K7lygTwEt/XZtCXyECcg7y
         xb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317288; x=1764922088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5xiwSTe0AtsC6K77xev7rck0np6+XM1Qze3kfrfW1o=;
        b=wD3Ea4Rsg7QjXZu9ZQsbU7qofzLz9tMuk0+5XJo+og0C6UjMbRKks3vCpYxWr+t9t/
         qHa+NR8HG/LTdgDC0luakW4DXuIGv577afTaHQElZY0e+edrbogO9gtllRu7qUbDbK6M
         YmDyUJG5OPicH/kCub4JaeuA9xtsSKcqrUkHFflX62Jo46+d4p1aNHHCUPlfyr9JF4SG
         gRPKJUhmugRGqV9TSYv89i9ikTop7klLJJK3ZtBCZW2DF/5LddnMj3ppTJYSqE4BmqJn
         dzT3BSb30eGjbjVMMLctZLXWAxzQo/7n10YadY5T8r+HShnaXG+9NaGD1/mCyX7RjsXM
         zUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqgItBWstjzYraOUB6jgKL1tQxC7mj2t++kWmcR1Ei87pEGrf/W1vMB4gwUpkVLr98qhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS034uo+5vaHQkadBRJ6OOcR44A6BMA43OvZktC8KuqMSklZqN
	PxSyf+R7GfoAq5WaVr46wkDaAmdIGYoMXQtZoCXdnwjy4HiYZITN0oQRpVhedv3w/g/uGjVpOEl
	qMIWfkT9P2OGsnghjkqzyyxZSlDbd6hA=
X-Gm-Gg: ASbGncuPWKJsMirJ8WXpBVeNgVM+Q3MKNoRtj3vq5m7SQUjBmWGigRuuB8ojAWTEWYO
	WnFAVhLR1Z2O5nNLOOWtdIs8/PeyGQNESHcl4pdy65n1UodF2h8om8yIlxBooTd6UHac5S8aXgd
	tl8KRL4qDQJ4RH0bWhbEXj0Z0ykLUCe+VIHw9GdhCEys1Zgb1TW67Yz4vp7ViAscIDxvksXZgPv
	siRF1EdMGNekkqBed860TPXswEUFgc48d46bE3IOXmoNWCZcKr7Tsi8lYG7tJoS/N4pN/9XfaSk
	+0myK+w5574me4UDRdzIFnvqVBWj
X-Google-Smtp-Source: AGHT+IGbbF1iM3mF/Qkvv/ZpMR32S3PHR0eG4vB+pUserH/4YGE5BebRSD9FKurMks+yO22OeYDbr15kjiN6IvjG22w=
X-Received: by 2002:a05:6638:4a4a:b0:5b7:b0e4:47e1 with SMTP id
 8926c6da1cb9f-5b967a06d39mr21842485173.4.1764317287528; Fri, 28 Nov 2025
 00:08:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de> <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com>
 <xmqqcy54mro6.fsf@gitster.g> <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
In-Reply-To: <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Nov 2025 00:07:56 -0800
X-Gm-Features: AWmQ_blzqXjznoLv_9nx8hadjamqRn2QNs9-lTDCciXxF7t1fx-qxJoljL4AYLE
Message-ID: <CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	christian.couder@gmail.com, ps@pks.im, phillip.wood123@gmail.com, 
	phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name, 
	rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 11:21=E2=80=AFAM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> On 27/11/25 02:34, Junio C Hamano wrote:
> > Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> >
> >> 1. For quick undoing an entire MR, the `merge-tree` approach you
> >> suggest is indeed more efficient and avoids unnecessary intermediate
> >> conflicts.
> >>
> >> 2. For commit-by-commit reverts, we need individual revert commits wit=
h
> >> proper attribution (which commit is being reverted) for auditability a=
nd
> >> history clarity. This is particularly useful when only specific commit=
s
> >> from a merged branch need to be reverted.
> > These are both good workflows with appropriate uses.  To make the
> > tool useful for #2, it needs to be able to allow "I have merged a
> > topic with 7 commits, but the first commit and the fourth commit are
> > faulty and I need to revert them", i.e., not just a range
>
>
> Since replay uses the same rev-list machinery as `git log`, users can
> already specify disconnected commits:
>
>      git replay --revert <target> <commit1> <commit4>

No, this command does not specify disconnected commits.  A <range> of
"<commit1> <commit4>" specifies all commits in the history of either
<commit1> or <commit4>.  Thus, this example command line would be
asking to revert all commits in the history of either <commit1> or
<commit4> (all the way back to the initial commit), rather than just
reverting those two commits.  This is just like how
   git log <commit1> <commit4>
shows all commits in the history of either <commit1> or <commit4>
instead of just showing those two commits.

There isn't really a mechanism in replay right now to handle a
disconnected set of commits for either --advance or --revert.  If
there were, it'd probably look like

   git replay --advance <branch> --no-walk <commit1> <commit4>

but the code isn't set up to check whether you specified --no-walk,
and thinks "Um, you specified multiple branches here and it's not
clear the order in which to cherry-pick them" so it throws an error:

$ git replay --advance main --no-walk Commit1 Commit7
fatal: cannot advance target with multiple sources because ordering
would be ill-defined

If you comment out the relevant check which dies with that error, then
you end up in some codepath that segfaults instead (not-properly
initialized commit/tree objects or something?).  I'm sure that could
be fixed, but "users can already specify disconnected commits" is just
not accurate.

> I will add a test to verify this works and document the capability.

Supporting --no-walk so that folks can do disconnected commits for
both --advance and --revert may be nice, but given that it's missing
for --advance already, it might be considered a separate change from
your current submission.  I'll leave that up to you.
