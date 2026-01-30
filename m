Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2C330B0E
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738339; cv=pass; b=RpKh5l+BIjwBdLJIjF3npIiWN0jXEnmav+7DgvJmVBL0AkQmxryXgJ9Kb38j30IbwwPxnSDKH7AVg4g8JMyKDK0YokAM5T6KXZt7D/IaxPzXeOIz2xyb7LcLIAtfVz5nu/GQRQ5Rr9awiDepg5qG+qbnz7T7Qm6JicbYqJhrlgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738339; c=relaxed/simple;
	bh=s6IJNs4TsPsKXpfRvkRz/EyzQxc1MtX/xL1Kog0zwHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDrh+ViBn35Ao6MFLL1a/FhUBmTWJ/MICgmf8lnBnRh6Gs56AQeMzenw9PIPAi8of/99E/4lYnV4nabIYCwmGPskvWEGWVfGdQWDTPaojgAgCUiDmy3s7+vDzStdQlRU19ZSb4vV+qWBcotpQTJIugBxapEHBmisom2tLHk6DG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SePXqSlV; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SePXqSlV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbc305882so1052243f8f.0
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 17:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769738336; cv=none;
        d=google.com; s=arc-20240605;
        b=O6tUvUhCaQBvspTryLei3nh+/tSQPGlW2msyrQyZFbhAd7Fs+cPe8VR8eARC0vthlI
         Ga/RsC3dEPTgGrMpZ8kWGXeAwZRJdIccFoQydH4RNboU8z4A13Shvv2/xIr1La7bHNAC
         jJ8F3FG2nti3Mjrsk3Wuz0YHl5iuMtJgbQLTYiok9rrBDhSw9mIge9ATz6lelNdTvE96
         X5Gv7WERiWfRzGdaXp7DnNW9jw79fVVTubptYr+42jEidzRM1dQzR2IopCRx/CbXTHF8
         zfppnerVtzjT3gLygZNV+12DnW8r7KF5Z57WfLL89n61DNejxE5i+fgamgJVxPLoFdZp
         8gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zB2hw323qBbsef4d8EeMzlNRmLN0VgO7m+5AHgQ07j8=;
        fh=1B1o2XcUE/7rajZQiN8VAZsXVfKDpbzYuJTTuWStyzo=;
        b=ePOkHXCNwXv20OiA6+vEpEL+/mmuZJIr0SRBb+dn4tYkNkDa+qnVkEiWncqujgPDoL
         Tnz4TV6e5jrjgx+1fgvEaZ6lCsr7TIrMy9Pq0m1gTtBM1u9uLu2Zzv1GylI6t7IS1CeF
         fLD9RFQwqK6gtrhI2PQ23Rpbfw77xHWKP6zX7L4627zP/BXBSEerl1hIQvsW2ynx51Pb
         4eTou+MduPi4Cb7wBJhFEfUXdCqrrQ8wKa6vHUZV/ZjQ8z+IqmNYuzUddiIq2KOeKEjf
         n8eMPVPaKGtHPu3jk7oLRvlNO2mGcKUIVa9BM1z9sKSfpUOS7pL4mz4e5UEBhXOe3GvM
         bWBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769738336; x=1770343136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB2hw323qBbsef4d8EeMzlNRmLN0VgO7m+5AHgQ07j8=;
        b=SePXqSlVj2wNQy5wT3u+GN1C0lG863IxZq+pbdm70H0Zu9ILuZFc4DaDGkNrdfcCXm
         AI5zoXw8xYg/ZlPi1+p8erhTRsoB3Dc18AS6eHdyE7ICUUHrFOa26g2bv0l7JeouIT+l
         TOmy06bTYtgsnsWN/zxquzdGOpa/vKfMxEsfRZrIK7skqhHfG0FglMKBbgSFjRc99DxS
         OJBFuduDQQJ6afrFZA9gTtAqS6fQRAk870e/7ytIq8p2BNQ01XR7ej/SVFvNbEuOBmWR
         4AahlaMChQB+iO0ZEzbLKX4bUHLZO7CwcSNYT4uxjdIaCd92XZFRgq+aI+dTv+3EGq1z
         nWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769738336; x=1770343136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zB2hw323qBbsef4d8EeMzlNRmLN0VgO7m+5AHgQ07j8=;
        b=AKFFDEFwL0mW0HqsW21lszUYHt+ybbfaKEgLMyKnFXT9NQME2S7gWTQ2FsBX3YYw2I
         4cunj6NXDMHanIUr6aRKkAf9ZI5eD+0xjVY6afRaeqtT/HqnXsxfoKXBloG2yKamS9QN
         ytbWMVg8L62xETi0sKE0ICqxF3u6lxsJjhHjccLL/hUZE2D5PWo2ALuLgHnXKTUu9jSp
         8tqR3ZoVRPnGNdPuSkjt7cP2QF3SxHZdImKGhHRu1+2pJT7WcroMFiVxRGW1MNce+u2m
         aaXdpxtCs8ZPUt9dwJsWOxbGsirazKLdWICVRAN4Qlxr6kRqZMK+RK2c/IR2Pyp78kbj
         OQuA==
X-Forwarded-Encrypted: i=1; AJvYcCUvti3p3z2g0GfdvRM5F6wTW96KGk/HOPc1+Tl5yUPt4Jol/lVYtS4U+fEr6+T0/gCEXjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZZSpiu4B67kU8CW4YP54WNTnHjsumGaWJqbVfQPundP+Ryj+
	tbIJ47qO0THXTsDyy0apjSATO2wjI/S63y+dx4L8R5HskDDtGh3blj4ybHxnstuRHSEC3IEEKNH
	zAK/1RqOmSH2JcS/7L5+S8dhOG8uZVJI=
X-Gm-Gg: AZuq6aJSxvAXX/m2G6JbwNq0nt+9NvmGx/fHD4oDY30B9Uy6msj8yDhu8gqugw+4U1a
	m7FzjJV2EgVq10nBNBRhNXb9pjfVCAW5pqSmvS7I9WTVO35jcmXpTe3Uccn4srQ/c044COawGzj
	cKohSErCO8bd38EXVTx/6Y32/WzsSEODBNIbaNXDMA7N3jNK3V+hTYqj2TNIuUQ8fdtZHlfgSRB
	aE0pRdOSEGfpw2ov+cT1sGDPlqlyTuiO4A36Cc+MqAgT3eMhKzIBakW82kjxuiOgJXMKrQKX/TG
	+tHbRQ==
X-Received: by 2002:a05:6000:1a8d:b0:431:1ae:a3be with SMTP id
 ffacd0b85a97d-435f3a6f7fbmr1830591f8f.3.1769738335576; Thu, 29 Jan 2026
 17:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g> <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
 <xmqqy0llk33y.fsf@gitster.g> <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com>
 <xmqq343sjn4x.fsf@gitster.g> <CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
 <xmqqsebo9lv6.fsf@gitster.g>
In-Reply-To: <xmqqsebo9lv6.fsf@gitster.g>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Thu, 29 Jan 2026 17:58:18 -0800
X-Gm-Features: AZwV_Qj2PHfyNidm9CDZ0G_Ia2oPqMQ4nF5vkQAjjQelodIphJWDgP_TWSoVn3o
Message-ID: <CAHTeOx-TLwqbcdGcb2drD4vE6D3M93EPMjcAeTNR+XNTbmTVZg@mail.gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 12:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Yee Cheng Chin <ychin.git@gmail.com> writes:
> >
> > On Wed, Jan 21, 2026 at 12:51=E2=80=AFPM Junio C Hamano <gitster@pobox.=
com> wrote:
> >> By the way, this appears after the if/else if/ cascade that has:
> >>
> >>         if (g.end =3D=3D earliest_end) {
> >>                 ... do nothing case (case #1)
> >>         } else if (end_matching_other !=3D -1) {
> >>                 ... do the slide-up thing (case #2)
> >>         } else if (flags & XDF_INDENT_HEIRISTIC) {
> >>                 ... do the indent heuristic thing (case #3)
> >>         }
> >>
> >> Am I reading the code correctly that, even though this new block
> >> appears as if it is a post-clean-up phase that is independent from
> >> which one of the three choices are taken in the previous if/elseif
> >> cascade, it only is relevant to the second case?  I am wondering if
> >> it would make it easier to follow if the new code were made into a
> >> small helper function that is called from the (case #2) arm of the
> >> existing if/else if cascade.
> >
> > That's correct. This condition happens only in the 2nd case. The
> > problematic scenario here only happens when the opposite side is
> > non-empty. If the opposite is empty (case #3, where we run the indent
> > heuristic algorithm), there's simply no need to re-diff anything
> > because diff'ing against an empty hunk is pointless.
>
> OK.  In the version posted, it appeard that it is possible, after
> not doing the slide-up thing but using indent heuristic thing, to
> fall into this compensation codepath because the new code was placed
> after the above if-else-if cascade as if it is an independent
> clean-up phase.  Encapsulating that new code in a helper function
> and calling it at the end of "do the slide-up thing" block will make
> the intent clearer.

Sorry, I actually misspoke. I forgot that re-diff is actually needed
in both case #1 and #2. Note that even in #1, it's possible for
`end_matching_other !=3D -1` to be true. In case #3, it only cannot
happen because `end_matching_other` has to be -1 by then (meaning that
this diff hunk only has content on this side and is empty on the
other).

Case #1 happens when no *remaining* shifting was necessary, but note
that this happens after the do/while loop above, where previous loops
could have shifted and compacted the diff blocks already. Case #2 just
means there's some remaining clean up work to be done.

Just for a concrete test case that will illustrate this in case
someone is running the code and want a demonstration:

File 1:
AXB*

File 2:
CD*XE*

The first "*" is used as the histogram alignment anchor, which will be
shifted resulting in a compaction, and therefore needs to trigger a
re-diff. The correct output is as follows (which will only happen if
we also run the re-diff in case #1):

{-A-}[+CD*+]X{-B-}[+E+]*

Otherwise we will get the wrong output (note how the "X" is
erroneuously included on both sides):

{-AXB-}[+CD*XE+]*

Because of that, I'm leaning on keeping the current code structure,
because it *is* indeed a cleanup step to be run after the previous
one. I could still refactor it into a separate function and put it
into the the case #1/#2 if blocks if you think that's cleaner.

I will also add the above to the test case in v2.
