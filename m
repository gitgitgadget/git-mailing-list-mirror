Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921E29ACD7
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932006; cv=none; b=GEfIrUrJbnLT/YdZmlr6msQN8T0Jnvd+DUy6I7U6BahL0attrUc4NCWwCWiZRVei37nnfEFrVd47+r7gJysV3xQDm6siF0WAUsWsYASBkruEebohjCZ5okndJw1GB07YziE27lXsbn4egCA123FwY+3Y6vKjnyqIZce7Fyw/ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932006; c=relaxed/simple;
	bh=Lemx7VzjTg4I3SUUHx+JMWwsNz7qJlZ5ZK+5acbnZ5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9EtUEdwwDWEAKF8M1JV/OIIOjSGd4ZXBO70RcEsmFZ4ci5684UDajR0DGYfHMq1nARWTnqGuVf9AE/3Ia8qbqdnLjGd9WNhTVy+e936hjJG8tkXBr7JkRmjzYkeRWRImcS7QaR5jwXbh+M5mnBp2GukD7HvI8/SlMHLjq4o80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cItMXOBb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cItMXOBb"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so837566a12.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932003; x=1763536803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ogEpLQgBaEEpgK0BKRzzLSC18RvISYEDumvjJ9CXXw=;
        b=cItMXOBbGukEgtvEbR2LLwIEzqxz00lPn7G0760TaFyEM92XQA/Xlowq16Dvx+BUQl
         XTVMQwX05IW1mpj/ARPrRwcEl7LLoN6CKRLcb2Tt/lA1fPLt61h+llx4fvzFUrFQAcsc
         Rhj6XlJsyPkex93Dr3gUTmRdlg9fzj1U98GsbM1u9foI/FzTghGCgolhXjcDR71n6pBo
         NnvH4ucwcFTqI6DQFzjiVQPE757Kr0/XwjcKNNAh8rUO/zbdx6X64lV5c2ViwNkvbPoR
         XUPCOVq6oJ0cs1RM8IgABdStcBjjWIFku72LXh6qiIsfwXI9gNH/C7ZODZQwNMVJtR/M
         ROcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932003; x=1763536803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ogEpLQgBaEEpgK0BKRzzLSC18RvISYEDumvjJ9CXXw=;
        b=S7zqY0188x8UIFCIZzbJmRy2XbXi0P8xQR6p8i+iSM2kNd2SSf1Ut3NYRWAvOK9JFj
         Is51kRJVVgC4EaTRdxE/CNKYbrJITry+tnWfv7SBkhDGQ5lkXwkBSOCXjYsc5EzgVrEw
         4sb1r0t9Tiwy4wtUAVd/nWR/BfIayog4gwbpAHo5P7bqxGceZ2bwN/eUTsYEZtIEErhw
         jvXhaEkVTdT1h5XYTlg5PNe5MqH9kOmM46+PG7v51F1OySdGzKOKBEuVyB31LbTWJlbw
         rJyqm6Hl4sVf6A8N6NYTjAUPdluSYbip/pFdSWLJL1GrNFbGpQf7vbz5DmsqG47Vb3zI
         WwTg==
X-Gm-Message-State: AOJu0YxE/BgQ83KzK1t+UfN4DkpRHS9nPzjBnBAJXoImVLSD3aE1BHCZ
	VQ4GpgAEgz4JP7Ssbv1aHTZxX/iRW3WQ4fdAyA5yFyo4mqxMAoG+CxhSttK1GsBCBJix0Ic97to
	WRLggfQnBiqNlxhqOnqNmFEEOQ+cvX5Y=
X-Gm-Gg: ASbGncuVSXh1DB5N6gAG9ExpZ/7jHXI66OTx9ia9iZGCtIOGWA6Cjcun8SyauL8aEf2
	/czH8pZbEB6qBXksU5s0h3S2C21lzflRXyY8BYcYK8GT/XyFGedaKZlZyz1nFsTwBKxYOTWZ4be
	z6ViJaDKphH2HstTIPqhN0fUVTbXiwuzQZBtBc747NpqgnsOxMWwDUGkFb8IzFgkQw+6JbL1JYa
	h8WMyLKTfAyqff/HT4k2ViSi6nKCmFo0D0Zqh9rgu/6iQtz73BPi2wp7mENHjgBuK+H42o=
X-Google-Smtp-Source: AGHT+IFk/RbmZFJ1B+6jvsZP3JwisFodeOmmDHbELvwwexScyTewmbmec7ZjGg4PT4CFr6oMnLltHFQv/oddfZUWglQ=
X-Received: by 2002:a05:6402:2755:b0:640:b2a1:8199 with SMTP id
 4fb4d7f45d1cf-6431a5a73ebmr1528976a12.36.1762932001537; Tue, 11 Nov 2025
 23:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com> <xmqqjz04mtji.fsf@gitster.g>
In-Reply-To: <xmqqjz04mtji.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 12 Nov 2025 08:19:49 +0100
X-Gm-Features: AWmQ_bnmJWefXTMbdd_KnKCmMd3MbcfNwARXuXpiS0U5uwAWWJWIGimmgjqhyo4
Message-ID: <CAP8UFD1YqadtkYriePJKUBjzhXAyYjNEk-9rj55ZxbGLRAOd2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > The `--signed-commits=3D<mode>` option in `git fast-import` allows user=
s
> > to decide what should be done when commits with signatures are
> > imported.
> >
> > For tools like `git filter-repo`, it would be useful to be able to
> > strip signatures when they are invalid, so let's add a new
> > 'strip-if-invalid' mode for that purpose.
>
> Sorry, but I do not get it.  What is your definition of a signature
> being "invalid", and what is your assumptions of how accurate a
> validity check ought to be?

The definition of "valid" is the same as the definition used by `git
verify-commit`. The description of this command is:

"Validates the GPG signature created by `git commit -S` on the commit
objects given on the command line."

Here we just also "validate" commit signatures in the same way and
using the same underlying code. If `git verify-commit` would return 0,
we consider the commit signature valid, otherwise we consider it
invalid.

I will add such clarification to the documentation of the feature in
the v2 I plan to send soon.

> For example, are you assuming that you
> have all the necessary public keys, revocation data and accurate
> clock?

Yes, we assume all that, like `git verify-commit` assumes it has all that t=
oo.

If we want to be clearer about what is needed to make sure that commit
signatures can be properly validated, I think we should start with
working on `git verify-commit` and improve its related documentation,
and perhaps even some of its features. It would be simpler to have all
the docs and features about this there, and just refer to that command
(using for example "see git-verify-commit(1)") in other places. Such
`git verify-commit` improvements could be in a separate patch series
though.

Or maybe there is a better place, like perhaps the `git tag`
documentation, or a dedicated gitsignature(7) page, where all the
information about tag and commit signatures could be. Anyway such
improvements could also be in a separate series.

> Even if you are not changing a single bit in the import,
> some of your early commits' signatures do not "validate" and may
> need to be stripped, and after that happens, wouldn't signatures of
> all later commits become unusable (i.e, you may be able to verify
> that the signature on the original commit object may still be valid,
> but because the commit has to become a child of a rewritten commit,
> in the resulting history the signature would no longer match)?

Yes, I agree it could be an optimization to consider all the
subsequent signatures invalid after one of them is invalid, but it
would require making sure that the commit history that `git
fast-import` receives is completely linear or that we properly track
commit history when it's not not linear. I think it's better to start
with a relatively simpler implementation like this one though.
