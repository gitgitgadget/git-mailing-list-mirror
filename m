Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E681FE44B
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763866457; cv=none; b=GYXuDDkPF8fIEgUofI/WAyeGqOnhtSoXIftgqXkkdD7kGH0bcdjSE1XornMKc6KAbqB34v82ZULx4UMRF0cwslyFPmVtrEGA6Sue4zwbTPOvhmX0TsTNr0jPO0XgS1RXPTSYwMYWEBRYmCFACtDzDT/9aZA6nba14ryqI8vgQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763866457; c=relaxed/simple;
	bh=BAQM0y9rNQWhuLf7JGUijBNo0Y6pwL1mk2UzkggIX6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egkC2log8zkNCOLFQGnzxLw70jNnO5RFWGLDjwwTJY9443bsgRvHcTcKxsLlE64w6k/VW2e3FNtmIH7O6HVC6TNbJgoPNHepO/5+cD0X40XfQJgLA19a3k6f6G3vqtktPbkbMeVx25dMUHOQlOJr6m2SWd+YbQutg2sA0ul62Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbL5cVCz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbL5cVCz"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4330d78f935so12353225ab.2
        for <git@vger.kernel.org>; Sat, 22 Nov 2025 18:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763866455; x=1764471255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kJz+U+OLNJ4f5PHpfrywK1n5M5umxzwppy8sqx4z+c=;
        b=FbL5cVCzDEAtCVZs9JwmppVirlauo4hZyxWyh9jyc7pz4TwUWhub5VCQZEm1GlfsWb
         OpoYhN1k1+b3FfYq0i32MA0Qp+4Tw3xfem2zDq9NQRmfbvzaoQuwPHBvRRqAZOTCMOYw
         FmzlzsHVHMi5BXDVbXFfJR3pjFbIJqupdM9UptHhVDACSC/XupELnl3qtLrADDQX3Lma
         j8jo6JGPtlYFsS8+SeGq+eKiIgbemw+K9XjPTGw7XluCmWVJD3bM3PFVBK3ndCegQcWQ
         CPN/pqTxPDZSSo5aUYVw/BLSbGkloJGi8jEgstwbWyl6Xw+rPh8CFcS7MDhzj0dY4Vou
         d6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763866455; x=1764471255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1kJz+U+OLNJ4f5PHpfrywK1n5M5umxzwppy8sqx4z+c=;
        b=p5hNn+3vNBv8kQWGfwlpd7RSdxzABKK2kPBciq7hyzcjvWQ+9okwsGr/gkXY3WmJLq
         7ZFCcIJJHw7/LeqHz5RvACPeSbgkQeXd0FgzVuhCaTaxFUurA68Hdh1UzrHhyqEEq6aw
         mp/Ct8Hu44o+NXMscEeINQvwlTJG6QWoxLmZBOm3cm+P6sp6/DiwlSvJoKhaoRK/9XEz
         qnYBEwiPwftLEQOc0U8Hhr3k9Aa+Fh2b1Ul/G5qRRulO0jdVw8f86E8zgsdcqh1yNXiV
         /imZHDnFmPpPWeUJ5Q1uGjRZYDR7hurvJkvC21qckQDk7NfHyTxYXfqTVx0nfV5o4dCd
         Cqjg==
X-Forwarded-Encrypted: i=1; AJvYcCWhx3tLUkVEuO13TFd1vqxtPAOo866iYC47Xh3gEFL/HASkg+iWkzgc//GKWHrvOmJiCkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VAuQCb2zq6Qo2S2LTRB6fehRKSQPnQICIwfhj+vjDCTomA6k
	ih9da6XWvBICWjcaWu/fjhsYE2mea5dGz+weJIdauzHqVHljGVC9hik9z3aihXq7VFG4atpKPXg
	gJR0tuW8sXXR0KNVQYNlpXuuQOMuh/ug=
X-Gm-Gg: ASbGncuWSW3YR+c16KhvuheSp2RxCbh3UIs67EwQv4XVYGUug30GS0c4IItDba7O0RB
	19DB9yOYConkMegCrk5LxG3xLd4M4/eyr1T4vrFQVLLeJxfriMBT5XTY1bm0T8Nn8EqjZIAFARb
	u1yerJkRNAL1daBdwv5UiI/fU/Gd1oPIcbjZmIneYf1mnM+iXzdrETicSGm3K6+GQBk1bH/h75M
	kj1DT4EZCPI7PMziGykInOq81uj50Pg0bslWTfg1oMxL9+32O+gOoqmxwsdzKC0jKSfIrwFzpyd
	vuLXsKjiR7DVy3Qfie2dWUf18P7K
X-Google-Smtp-Source: AGHT+IEHvxn9k0WWIMOK59DOjZUOKGpsFQTtN9Zm1w324v2E7lc2yo9N9CC7rXyuAf/JLJGsehomlYhEwpZ+To+n8kQ=
X-Received: by 2002:a02:ceb3:0:b0:571:2bd0:eb59 with SMTP id
 8926c6da1cb9f-5b967a2077fmr5363184173.6.1763866454692; Sat, 22 Nov 2025
 18:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g> <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g> <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> <xmqq7bvj5q8m.fsf@gitster.g>
In-Reply-To: <xmqq7bvj5q8m.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 22 Nov 2025 18:54:00 -0800
X-Gm-Features: AWmQ_bmc7w6Y7LldTNYUsQQgRxA70gnK7Z9wYN4RbR0CmEYcQL1pvqOoiDDd6yo
Message-ID: <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> Granted, I think good progress is being made and perhaps the changes
> >> needed for the rest aren't that huge (and maybe there's more pieces
> >> I'm not quite understanding yet similar to the
> >> two-split-patches-always-summing-to-the-original), I was just a little
> >> surprised that my comments are summarized by "expecting a small and
> >> final reroll".  :-)
>
> It was because I didn't think (and I still do not think) your
> comments are something for the immediate future, for a tool that
> wants to present its minimum-serviceable experimental version to
> users so that the users can experiment, extend it more and fix its
> behaviour incrementally.  I may have been probably wrong, but I was
> getting an impression from the reviews that it is getting to there,
> not the feature-perfect version that needs only maintenance from now
> on, but a minimum-serviceable one.
>
> We could instead of collect all the I want moon and I want cheeze
> comments and iterate until the tool has all of them before it hits
> 'next', but I do not think it is often what we do to a new feature.

You're reading my feedback as feature requests rather than as bugs
and/or possible paint-ourselves-in-a-corner situations in the
presented implementation?  I must have described things rather poorly;
if they were just feature requests, I'd agree we could just implement
them later.

But maybe I see where the confusion arises, since you were focusing
solely on the single branch thing; that's the one issue where it's
perhaps not as clear whether I was discussing a bug or a new feature.
Let me try to explain that case another way:


The early cover letters said they focused on a case where just a
single branch was involved, yet they don't check whether there really
is only one branch involved for safe operation.

If a user tries to reword or split a commit that is in the history of
multiple branches, the current implementation does not check and makes
the branches diverge.  Some users may want that, though I suspect most
would be negatively surprised.  The commit messages and code do not
even discuss this case.  If we merge the code as-is and then later
notice and fix this problem soon enough, maybe we'd be fine, but I
always worry a bit about a git-switch/git-restore kind of case where
it sits long enough and people depend on side-effects in a way that
prevents us from fixing it.  Besides, since the bug has been
identified and there are multiple not-too-hard ways to fix, I think we
should do something.  Some possibilities:

  * Document this case and warn users to check on their own (not that
friendly, but might be good enough for the first cut).
  * Check if the user-specified commit is part of multiple branches
and error out, unless the user provides a flag verifying that they
want histories to diverge.
  * Just rewrite all relevant branches

The third of those could sound like a feature request in isolation,
but I raised it primarily because it's a potential fix to this
overlooked bug.  I mentioned all three possible fixes, but assumed
others didn't realize how simple that third option was, so I pointed
out how easy it was with some code (~12 lines, which also replace many
more existing lines of code).  I personally think the third option is
*less work* than the second option, and that the focus on trying to
limit to a single branch is creating more work rather than simplifying
the problem.  But if folks really do want to limit to a single branch
despite the code existing to handle the more general case, then we can
implement one of the other solutions.  (If we do so, I still think
choice three is more friendly to users, to cpus, and to future
extension of these features while also simultaneously simplifying the
existing code; so I'll volunteer to investigate and post patches on
top of this series if others decide to go with one of the other
choices for the initial version of the feature.)  My main point here
is just that there is a clear, un-discussed bug, and it should be
addressed somehow in the initial version of the feature.
