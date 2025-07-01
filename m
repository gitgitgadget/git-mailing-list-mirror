Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860D415C0
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394858; cv=none; b=n6XC+Atztju7FLkXGdjrktrVuxMpSsgV1yHSmXkf2sERQdrUjVHr0SObkf8PJ71Ly/cpoZI1mYeezkttgRk9R+mUq3Dnuxf5Un3Dq04eZaGLF14qlzLlekt9HgYNwAaDjnJNeO0f8WV0622q+wbgpKL686qo28n72EHmmZeOAyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394858; c=relaxed/simple;
	bh=S7kGgh481KbV7LIoi08sPnoFhmLO1y/OtA44XccqbTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUiv/am9YyFfclaKmqYdGMWV9Wk2NtCZlqOM6Y01rLDLp/RX8cD4PRkDgZFrEijgJycLKWl4v0qHX5VP5eX/+978bvFt+4QdPaLPZRXA44LVGaW2XbC4Wnphna56d5iXBFFwEZwXQLKfGCXCGwqHNq86/iMIjiBCwvkmv8JAyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7uaLiIx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7uaLiIx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313f68bc519so2553000a91.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751394847; x=1751999647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcTMbeekxaSS6x+wsBkkzPPsle+4U3JDlOjttWahEvM=;
        b=d7uaLiIx+6qbRrZwFXo9QHnefbZ4BZgbnptxqzOko/Xi8P/ymeqswJZDGt4VVkbi8j
         jSCq3k2hqGfpIq1axhBWKFw3/rCWBCA4gANw99Pt/kHeUdJffuxtV2WgRbvq/nOhDMS5
         AE4s0oG0drxcCfgEJGL8gV21Dute1SpPjTzCAn9MvkqiE8VzALbYoPRHLfEqolpYyTQC
         aTjNLU5dawTnFCjCRr3utjyu3KiAHeNEqV6FWgnTFSHyUHqcJYtTAFdVypkGszXiiS0c
         i6kMIiW03j0SVkPeIgeCH8X6qKovZaeMFH9doNLpABWVEyB4t7sPD0CFg/wZTeYZ2Epb
         jKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751394847; x=1751999647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcTMbeekxaSS6x+wsBkkzPPsle+4U3JDlOjttWahEvM=;
        b=hba/DdRHDWW2g06h5JzSBrAVTqk3Jm5Q/whoraS6rg95sL3nAIvGPf1JRQChiik0RH
         yv4wJi8rLLpHzRSHLiyv9PTfXrft2GaIjccc2/g6gLwSJYxcH/Oq1uVSmXEZ5ILujuFQ
         2r8X6j/AxFrJuENBjCje5Pafb02Ci2hepSGniq7sPHlnLlYzDOtAFJpILhO7HOLTb49c
         754xCP94llaVNSOCcsEmWro8eI7SKLegc7dpBSew3fHCQk27kvIvPRWQSf0xf9rL9XdR
         yN4TBt/m8SspYTHZgi7sXGM0StS/U0sFNyQpDGG4NatzItAvwGEqvvDTBbLo5WCSW0rF
         cvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+j7kAiI/xUyJ8KswwOENhzn157IDnQDh0/vY/EreqlXqMw1/asg22nen2y0RyDXA/ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJi00skt0I8UHLIfUEArcZrMCk16fu3rL2KIRi/ThGsw+bcg4
	e6pSzwHBmGeuTnP5ih+aMyn2qNc5eV9GRnVL+frm8UXAA63JVJOFymSgRqZ0yeBtGE5icwlTGd0
	StXWXOPoe67ElVFDDxQ9Glg2j8EZGqEo=
X-Gm-Gg: ASbGncsAdegNZ19nL2PT3/elri/KrglQ0PPtGg9lFzeSmiHXv/Kzsju+v1jLEjcYI2p
	tmejs5g+ojzosJIqTYU31PVu721/R/6V4fLSISZGmqLQPUitYtmAvRRVcXr/uVCc9lFV95y/5s0
	l1ekxlTefhdcikQSoHQlvI1xyEJH/IqJz3yvgQZeD8WVcv9+tiLboxPyTxATzsnR+BOP8yNKLWO
	fLzIgIDQ5p+/H/k
X-Google-Smtp-Source: AGHT+IEpQwQuCoocDYdTQQsiS2GVaZufRQVuWxb5LYOWyml+SipdeCq8KEMFIJkbij5IBui8IxyvlmoZpSD28uNpQ/o=
X-Received: by 2002:a17:90b:57e6:b0:311:ff02:3fcc with SMTP id
 98e67ed59e1d1-31a90b604afmr115658a91.14.1751394846538; Tue, 01 Jul 2025
 11:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250630182527.69167-1-ayu.chandekar@gmail.com> <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
In-Reply-To: <f22e864e-669d-457c-838e-961bbc977c4b@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 2 Jul 2025 00:03:54 +0530
X-Gm-Features: Ac12FXwtheph8Tbsrk44AGQZXm8Tdnh39lBzKCNjDjBrErhcuR1MQMtcPmVk8Tc
Message-ID: <CAE7as+Z7GXMB4LJGwESK3Pj63ppfFMKDq-xw46YCELJ7E3p+DA@mail.gmail.com>
Subject: Re: [GSOC PATCH v3] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:47=E2=80=AFPM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Ayush
>
> On 30/06/2025 19:25, Ayush Chandekar wrote:
> >
> > Range-diff with v2:
> > 1:  4e74e7a9a6 ! 1:  693f890a36 commit: avoid scanning trailing comment=
s when 'core.commentChar' is "auto"
> >      @@ Commit message
> >
> >           The "auto" value for core.commentchar was introduced in the c=
ommit
> >           84c9dc2c5a (commit: allow core.commentChar=3Dauto for charact=
er auto
> >      -    selection, 2014-05-17) but did not exhibt this issue at that =
time.
> >      +    selection, 2014-05-17) but did not exhibit this issue at that=
 time.
> >
> >           The bug was introduced in commit a6c2654f83 (rebase -m: fix -=
-signoff
> >           with conflicts, 2024-04-18) where Git started writing conflic=
t comments
> >      @@ t/t3418-rebase-continue.sh: test_expect_success 'there is no --=
no-reschedule-fai
> >        '
> >
> >       +test_expect_success 'no change in comment character due to confl=
icts markers with core.commentChar=3Dauto' '
> >      -+       test_commit base file &&
> >       +       git checkout -b branch-a &&
> >      -+       test_commit A file &&
> >      -+       git checkout -b branch-b base &&
> >      -+       test_commit B file &&
> >      ++       test_commit A F1 &&
> >      ++       git checkout -b branch-b HEAD^ &&
> >      ++       test_commit B F1 &&
> >       +       test_must_fail git rebase branch-a &&
> >      -+       printf "B\nA\n" >file &&
> >      -+       git add file &&
> >      ++       printf "B\nA\n" >F1 &&
> >      ++       git add F1 &&
> >       +       GIT_EDITOR=3D"cat >actual" git -c core.commentChar=3Dauto=
 rebase --continue &&
> >       +       # Check that "#" is still the comment character.
> >      -+       test_grep "^# Changes to be committed:$" actual
> >      ++       test_grep "^# Changes to be committed" actual
> >       +'
> >       +
> >        test_orig_head_helper () {
>
> The changes here look good but I think we want to update the config
> parsing as well so that comment_line_str is reset to '#' when
> core.commentString=3Dauto. We probably want to do that in its own commit.
>
> Thanks
>
> Phillip
>

maybe something like this?

--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -912,8 +912,10 @@ static int prepare_to_commit(const char
*index_file, const char *prefix,
        if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
                die_errno(_("could not write commit template"));

-       if (auto_comment_line_char)
+       if (auto_comment_line_char){
+               comment_line_str =3D "#";
                adjust_comment_line_char(&sb);
+       }
        strbuf_release(&sb);

or we can do it inside the `adjust_comment_line()` function.

Thanks!

Ayush
