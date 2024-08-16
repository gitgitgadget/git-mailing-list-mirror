Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462B34CD8
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789192; cv=none; b=O0/QibF2S30W2pQwJ7do2aVLLgb3ozWafO1OBV7iPTuhZYl9n/HNYF7gc4xOHyN4wWsuITvGLoLxzPgRLk5/TlbWJDYcxdS7uCGjdf0VSaC4H4CuejXmLzn3X/vJTI+y4qIZUro+ST9DJJi1UV+qWtaRbMNgh4qh6CUEq90EXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789192; c=relaxed/simple;
	bh=KtLEX+7qKs1W7TaV9zMEJslEKQnU15zRXynkU9V8VaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxgOi/r8k/lqbpr8qRJ1IgDAqv7bUUId8ZSovsA3dLewp822HwJEFFHZ4m3OO1/9TqLdaONOcMUryw5pIk+OnBBdM485Ig0sSmkx44I05DDpK5Uti2Mp8z+GghPKJ5LHf8mESbdOfgV9qKs6LSNS2EvzSnLSAUSOQiR+xrLdIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDOUqpml; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDOUqpml"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0ec934a1fdso1599578276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 23:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723789190; x=1724393990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUQEwjey57UcZzFHw9llkEsz8uYV8iNkrSv1AZwHRNA=;
        b=lDOUqpmlguf9p27uFvHxwwEEc5MfGPzB05zWqxu+hiDg9X/2HVMHn01URuuf7mOGMF
         A2z3qdTXeXE4zRbiFOABn2iHnWH4l42d+k/PDACch2aOtCb1DU5QLHzWwXPb5epZj/EU
         MC5GQVHh9z/oU+vAoI+oFn+7JFUwQ0Cg8FZHZMfCwa7si8UV1N1S02+1TvUZmGdC7KYV
         EdvByh0elkpT7aCALX8+1pIswLmAPKU23xMPze/NIeOLE54G7ZMtvXdJb7GAEgPhhNaV
         WFbvCRaavkUwxwrKeQpLEvExEuX3mRoQkWOqM48c87BKPX11ewB+ESDSpoXjymkGy9UG
         WA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789190; x=1724393990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUQEwjey57UcZzFHw9llkEsz8uYV8iNkrSv1AZwHRNA=;
        b=HWcGlqwlghRLHxZ0HNgiLG8L1SLTHDz+3wiUt9WdcSvwcs4XJIFOtXC4D5WNaLZiu+
         G+1m2rJperWAmllGKzXzO1MzDtMZ4DADnx+rJpIA7dgklBSem3FGxqOrG2w1AsVA+DHI
         QlCEef585mGm3c93lNrnVtxYNIUw7bQKUwabF8a/TUZbxlp65IhLF+PryJgyVNdZzJn/
         z4tTUR6yWeKTfFTXCwI3BgG9tlTAnZ0ZExPq11VpgAo4Jn40uvCKR49JP2TR1FdH2wb7
         NB5IjlT1eekjAf9gin1/NYr76c0f8NkRKzMcN+HnsTW0jcs1G3QiBhlYLw+/tEuHQkwA
         /0Lw==
X-Gm-Message-State: AOJu0YyGmqJ1frkDtM85aDQlGrVb+dAv5cj2dsw8UFoz3rLJToe6X8Rn
	YWjG2DMrlGlkYSk9xaaySo0Rlr3B7hQc6pPwdv2j/L1Nd3BE4hQom+pVCTBsuZwqiIHZOybU8tH
	tlDfFlhNH238SSsl0Bwjl1nyNcv499oxZ
X-Google-Smtp-Source: AGHT+IGLJ29p6ZPPQIpveaS2v13TTWWLc6Do1UjO113wC8r0Ev7Ry7ti2+DJXECWDamcycxosqhIJ/13xYjF5Ai+SRU=
X-Received: by 2002:a05:6902:1b13:b0:e0b:6cd2:6d6c with SMTP id
 3f1490d57ef6-e1180ef31a3mr2138460276.32.1723789190031; Thu, 15 Aug 2024
 23:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv8099vms.fsf@gitster.g> <xmqqr0ax9vlk.fsf@gitster.g> <xmqqbk1y8gm1.fsf@gitster.g>
In-Reply-To: <xmqqbk1y8gm1.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 15 Aug 2024 23:19:37 -0700
Message-ID: <CABPp-BGmeg3x-F2ZjLzqcDYzSMOfz8Q3BDKUtB=vMO90yJRb3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] remerge-diff: clean up temporary objdir at a central place
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>, 
	Xing Xin <xingxin.xx@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > After running a diff between two things, or a series of diffs while
> > walking the history, the diff computation is concluded by a call to
> > diff_result_code() to extract the exit status of the diff machinery.
> >
> > The function can work on "struct diffopt", but all the callers
> > historically and currently pass "struct diffopt" that is embedded in
> > the "struct rev_info" that is used to hold the remerge_diff bit and
> > the remerge_objdir variable that points at the temporary object
> > directory in use.
> >
> > Redefine diff_result_code() to take the whole "struct rev_info" to
> > give it an access to these members related to remerge-diff, so that
> > it can get rid of the temporary object directory for any and all
> > callers that used the feature.  We can lose the equivalent code to
> > do so from the code paths for individual commands, diff-tree, diff,
> > and log.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
>
> I forgot to add that I am not happy with this "centralized tear
> down" step, even though I am reasonably happy with the "lazy set-up"
> step.  I wonder why the remerge-diff related members have to exist
> in the rev_info structure in the first place, instead of being in
> the diffopt structure?  Moving them to diffopt may make the end
> result much more pleasant to read.

I'm not sure they need to exist in the rev_info structure.  I was
probably thinking that e.g. log --remerge-diff would "need to do lots
of diffs" but I only needed the temporary store setup once, and once
in my mind matched better with rev_info.  I wasn't aware of
diff_options.no_free or anything surrounding it.  If we can do the
temporary store setup in diffopt and only do it once for all N diffs
in a `git log --remerge-diff` run, then we could move this stuff from
rev_info to diffopt.
