Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7644C66D
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588678; cv=pass; b=iJQyNdgA9rZB9M7oEh39vWkn8VBxlnWtUuMoPAGu9ccJtnZ0zr3r6Mqrl2DQ6grSXoJcYGJztE9PDlhTNLlFk4atdxuQ6RURrCDGo2wXq/YYaIoSPFfCfSeMtgCgTt3D2IodwScx1e65CyZxSy0nTd2mkhJIu28+6y9LrA9eNYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588678; c=relaxed/simple;
	bh=2a87W/ubEbF0nuwvU2Mv3VkBPMU9GLREsVI+l2BztII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebj/ELKXcEvqrnrljZI7DBLTH6BH5gb/GAkG8Oqy1VFiNTe1dL1e3COvODg5j6cqPlFQhMobMDyn9zdrI+j0O5b2Q15iWDShSIKXpgG4iU3fizWWw60lRi44Sie8CpBd3QpFa1g7d4v6TYwh63SEqpxDNjZdrUqcrkKvv1vrli4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barzilay.org; spf=none smtp.mailfrom=barzilay.org; dkim=pass (2048-bit key) header.d=barzilay-org.20251104.gappssmtp.com header.i=@barzilay-org.20251104.gappssmtp.com header.b=ThTaV4AN; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barzilay.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=barzilay.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barzilay-org.20251104.gappssmtp.com header.i=@barzilay-org.20251104.gappssmtp.com header.b="ThTaV4AN"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4838dbf1bbeso20391f8f.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 12:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588667; cv=none;
        d=google.com; s=arc-20260327;
        b=os50oiOjso8w2j0p/izocWNH15RGMMadrRnFybeYT1AwbwQhJ7SS6TaVqRAmZWyo7o
         nLI1meaRgODzYKJPseIhOxi7q2ABDKxfwOMxefNRlaD8PSCJFhnc41bK1WqRBr2k57qE
         iSZOP3n0JvKTbGJg4AASzfLJ8GpdujvUi/xgaEeNeqiSbx3YzZw+Z6mnqwqpJa4MLPZS
         XrMH1gUjwO2zUXZLOXlki/zZvzk/5DtmeHH9S5DKDCLn7r8RY99cH1+Hzn/ll1M6+rx0
         rwie5VjXSe5it8j7IiuHwKsVrUvivN1EHFzsUocFzuaZlxA1qAkrcVhSMGnLzpsA+L/f
         tzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zwo2sCEL83huURbAlNfYEaf6Ot/kqJaofYrBA+e6aGo=;
        fh=RtiEkbZKYfhrdOcn7h2i8sV3us4qXUJ0hO3+vIOMUEM=;
        b=RsFwforg2DIVGIQk4oYzkoGudij36Cji3hg+BGDyycH6+Au9lrnUENDAp4PcmCevQC
         ieq9/4B4HqkIHPkbZU9rP6sPMUQDFoSVyYq9XU2TUNcq5Z20XeaVxYYI3CDtzh8X9g17
         hGYAFL0EMBeYq3c2NeZur75Rkb9YZtGbtcJW4zCLp5xiYxWykVkyR7yBNPGew5sCwyjL
         Ryh32eLSv6s9rCyKhNs9A9JAa9L54Izih1gqO4wrA2bZA+4vsPbSfNinU+Uwgmeddzoe
         kReMTxqJ6Kk2Wv9UR6yxg+9a3fAgZ0DhSwyRUiHgyVS4KRf6KAJABJXcawtmWHQYlo1c
         i/Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=barzilay-org.20251104.gappssmtp.com; s=20251104; t=1789588667; x=1790193467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zwo2sCEL83huURbAlNfYEaf6Ot/kqJaofYrBA+e6aGo=;
        b=ThTaV4ANN3cDVAoe1gW5ejR8NsuNLxCW5u2DqCIbonETP2YmY6PeWrJTldI41Vetg9
         84t5oclCJq9kWOoNIMuTOt9qmk2aXASQPcfsB3j157CfkQDjJK29euKO0GA5WwV1ILDz
         Ag68KnhhUCE+UrrW0Y6porr8cDNf20b0Zq3TdIrKOq/cYy2jw9077p4Aj2Ja2Zj9ucit
         fi8no8/2L1yXZNgdPlWpVTIys+g1cnaCpf0/q3qVrgb5DP39J3j6ahysk88j04fVTqRZ
         HA2Ue5Pux5pCAw/te3YKzN1/uqi9ZCLO+BvS9fSFJLak8PVNSZVkL5nEKRU6Zq3MB9/L
         2eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588667; x=1790193467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwo2sCEL83huURbAlNfYEaf6Ot/kqJaofYrBA+e6aGo=;
        b=cI7DC4Vxr8u/Z+aKYC3vDZJy+VS8pvDt9IiJoeq5BHK1Dy0iwj4frsWHa0QawVDEAI
         u8at6hbQStFK8n0YAP6NZ4smHWqlHInwikTvoaYW0DdR3YqMC7U2fGs8rElY5WmFAjqM
         R7YPm5FiUfEtWUjQQiegAaG0QnKoqozsBNd1Kt3SZRl4VkZ45F8efwzvRASncVHqLQnT
         pnzWQ/eErA7NTcNmJzoHfbnsT0dLMuzGxeoqaDjQqTNRGxyYXHd81OCZEOTsH8DSV2GJ
         YBBeL8Fq7dWzxGAcwt76sswTfts+QdVPq7oOn2LLEYUQkYYmdBWHgqxYCCm/qCRaJF83
         0p1Q==
X-Forwarded-Encrypted: i=1; AKwUvByjH/HI7e289mf6g2hNUs1xqodPPM9yPFO1ECLu2FIwzTTpiIysKJosK2ssqRCUjZzIYCg=@vger.kernel.org
X-Gm-Message-State: AFuF++mVlakIC4Mi0TUYru2N28Nkx7joLbl6IMYE3VptJID6mAk/RAPT
	4k1kwc9N7LD7waumXht/B3yBTYejNo9xCdZHhCfQTD2qKPvLu1f2imo7+/AgUNcV1sp/a2UcYLb
	T/p/sEjf+EGWvbb+jqpgKLQ96un0FbmLUFXF2Y0ayJXShwTExU/xD8xJSEdw=
X-Gm-Gg: AYBFou1V58Tz35PCvTFPOYyl5oINaVDp/EoX/nH9DHbpPTd76NW0mcGYETki1z4gMRO
	qKdTxKxPv40mHB30d0Pg+fS7Ra0Y6kpPmAE9s2jrGLILIPytABg4RF20jCKrvDM8Sq9/N5Ac0+3
	yMZzDfsT1fI+W/L/lYBVRli2iP6JsoX/9tLXPpxQPuueqF+trCceUXnhyYQgc1c7p3hfclhdc3U
	zx5QDlWdajvlx2amyI0ovQFVsD4Ebn8+rdZBvv3BosmjQJvAWtu0fsU20qmzm9CFebaZteqysBG
	aGR30jo89NpetBnFrE6xy6ZXxIJ/icdl6p3qKdWSeXcUhxsXws04G8eofYL3+yX4YJGEQWEKr5J
	sVVm55Bw7liWz7O3JgemocQ5HIvwxb0Tf4WgcP/LcUR4A8AqQ
X-Received: by 2002:a05:600c:4ec7:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49f1d516b6fmr43350495e9.0.1789588667234; Wed, 16 Sep 2026
 12:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com> <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
In-Reply-To: <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
From: Eli Barzilay <eli@barzilay.org>
Date: Wed, 16 Sep 2026 15:57:37 -0400
X-Gm-Features: AcwNN1W5MLbFNJKqd9xAUKQ8Xjyh117PVZ-2rLbzsm-rjtMMftlvpLtRNU1VbZc
Message-ID: <CALO-guua8fcRq5n_M8=r9GMZ-aW4LaddXxS9rz0YhpAQ9TL3mA@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Note from the peanut gallery since I can't spend time diving into the
code -- that's result of collecting dead autostashes is the only thorn
in my joy of discovering `stash.index` + `rebase.autoStash`.  So while
I can't spend time in the code, I'll be happy to try patches or
whatever if it helps...]

On Wed, Sep 16, 2026 at 10:30=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> =
wrote:
>
> Hi Phillip,
>
> > Le 16 sept. 2026 =C3=A0 09:35, Phillip Wood <phillip.wood123@gmail.com>=
 a =C3=A9crit :
> >
> > =EF=BB=BFHi Ben
> >
> >> On 15/09/2026 22:16, D. Ben Knoble wrote:
> >> I'm experimenting with something that swaps that out for a call to
> >> reset_working_tree(), but I don't think I've gotten it quite right for
> >> this bug yet (let alone run other test cases that might be affected by
> >> this change).
> >
> > It looks like stash has its own unpack_trees() wrapper, so I think the =
simplest fix is to replace reset_head() with
> >
> >    reset_tree(&c_tree, 0, 1);
> >
> > Taking a step back, this code applies the stashed index changes into th=
e current index, writes the result to a tree and then resets the index to H=
EAD. We could avoid touching the index at all if we used merge_incore_nonre=
cursive() to cherry pick the index changes instead. That way we'd get a pro=
per three-way merge and avoid spawning subprocesses for "git diff-tree", "g=
it apply --cached", and "git reset". We're already using merge_ort_nonrecur=
sive() to merge the working tree changes in that function so we have nearly=
 everything we need already set up to merge the index changes as well. Esse=
ntially, when merging the index, we just need to call merge_incore_nonrecur=
sive() instead of merge_ort_nonrecursive() and use info->i_tree instead of =
info->w_tree.
>
> Wow, I wish I=E2=80=99d had this info this morning! I spent a couple hour=
s trying to understand this flow and still don=E2=80=99t have it in my head=
 :) Thanks for the pointers.
>
> With the way I batch my side project time, it=E2=80=99ll be tomorrow befo=
re I get to trying to make and test patches for this, but I=E2=80=99 excite=
d now.
>
> I may try to summarize my own notes (=3D questions about the existing cod=
e) and send those out later today, though, since I=E2=80=99d love to make m=
y understanding line up with yours!
>
> >> BTW, it's really weird to me that the reset manual doesn't mention all
> >> these "extra" cleanups reset does via remove_merge_branch_state()!
> >
> > Agreed, I think it comes from "git foo --abort" calling "git reset (--m=
erge|--hard)" though that doesn't really explain why a mixed reset also rem=
oves the branch state.
>
> Yeah, that abort bit makes sense. I wonder if we should have had a better=
 side-channel for communicating that, but I=E2=80=99m a bit too afraid to t=
ouch that for now ;)
>
> > Thanks
> >
> > Phillip
>
> Thank *you*!



--=20
                 ((x=3D>x(x))(x=3D>x(x)))                  Eli Barzilay:
                 http://barzilay.org/                  Maze is Life!
