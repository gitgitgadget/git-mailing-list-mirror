Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4A4685
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695839; cv=none; b=oCC9sexRHUGcIgzbqxlC/Mi2RG6pecsXONc4mzaznUYY9zGxkpjv+mS+1izCCrLdBPMTX6NlGTZoEB2E1vsJ/imakK5S7604WVJ9OfXEj+YaFu/PQCpaZPhFg1ISokHx7qt4wCfFF6lZL4H8Cas6onL/LD13LFdVf8S49nTz/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695839; c=relaxed/simple;
	bh=6IkG2FFxKfoOn/GmjQIa8FUV19eKMFilMjwGMbHqWdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSXms2ayiCra74TV2L7+2tKu/JeUllKNjS8SjJvX8eVCcgVhYjsKYBcynTeVp3XIHOZAoIjAxnsQLAt03PdLvS7W7mq0HcjawRtKiUz8fakytpMFYTCdzm0nHaJrXX8sArxOX5ItnC+DHFcaG1TDhCU0GaxYhakYhVov65obNbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=GY1zTUo3; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="GY1zTUo3"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b6d5400849so46384fac.1
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 11:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1738695837; x=1739300637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA6aHgvUCHNiipuBJKXmR6ctwuyydQlyeweLC4kxA8U=;
        b=GY1zTUo3MsgP56Mjlg3ErG1QM1aU6k+GHOVH6Jw6ZnTMryt7l/Z3m+PCyG96C72ixw
         HxInOgLMPbOPx2yNGc41CWgYJFxHCUgZ0FcHihYLRHZ5JoGYAf7HbGffvzIb78Lpt+42
         /MZs+kxY/ITr+QxsOep8h5lawKaqjaihMnSz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695837; x=1739300637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA6aHgvUCHNiipuBJKXmR6ctwuyydQlyeweLC4kxA8U=;
        b=lpbKN7dnxLtjzV0qsvjMWPT7dNPWdZsWJpHLOpUAdhBN+mvkOTjWtOn094BKsfD5Iy
         DrzGzrrv4JfCz5JoDnxzWC1xWMW0O1xe/iS73wtaS+EsZvtD18L6Tr+fA5H/zEJpvcnk
         yeWIWGFMWhB2g83wVBt3wr31F+mOf6x9T+w4qxDi2cNGufggFuoKkegG0B4U7n9ityAs
         ArvYRw5zGLrbdJmhH/I3pfTSRk8FwjIRdqHzgN970QBFGLZJ18BnPBU7F3Q3mIxJapqy
         L0DW/sFIxodxrkBcH3IZmbqpP8EgRlYTUJnlRokyt9lW/cseMgMPX1oKKrQ3rC/c1w3i
         Re3w==
X-Forwarded-Encrypted: i=1; AJvYcCUy8xZVND+nRv5me6qfFBVxzuFgU9rqLSzr8g5fEr1HGRy6hlkQV72ASdXTYMS4/QVREJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwrAvxanQ93YRgl1nL6HMUJf95so8qRgDIWr74snSl0Fk/36yt
	N/SzDqAFokEn67Kw2UicuA7kwoOAmTRBnLIJCYwcdEUd90h9HlD97/UFRRsPNJVdTaLcYAIgC6O
	ZdK0vPPs13Yt/gNKidU5nT9cPgWK1V9dt7P6xjUaGfndFbuGWmRYyNA==
X-Gm-Gg: ASbGncuhsolX7BqJ4b1rzwyrajByhBVV4cR65mY4qHNs/lCM/5u2f5KiSwtHBamkY4u
	5NWixxkUJ56mmnvSb84uQ0jzgxl4/pxpTW6ZOs5+8XjeiOBlb98UIA8zLGSy4yPTF35So/eFmWM
	0hYqIIvYFMVBDtusUjU8cEj8p3Ph1zxg==
X-Google-Smtp-Source: AGHT+IEBptxNXFwCWkPs2jeMczuuI1y8ioT9qz8OMNyBkmVk5THK1NP+7gQRhjjxPo5gTs0hW24TkOEdovjV2XwFWgI=
X-Received: by 2002:a05:6871:5881:b0:29e:723c:8e9d with SMTP id
 586e51a60fabf-2b3e5ebc0c2mr951228fac.4.1738695837179; Tue, 04 Feb 2025
 11:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com>
 <pull.1829.v3.git.1738346881907.gitgitgadget@gmail.com> <xmqqcyg294ft.fsf@gitster.g>
 <xmqq8qqq943u.fsf@gitster.g> <CAFLeGL52tKmurpAHymk42Y9DGazbK8nRdtWAoyzW85eMDxJQhQ@mail.gmail.com>
 <xmqq8qqq7n26.fsf@gitster.g>
In-Reply-To: <xmqq8qqq7n26.fsf@gitster.g>
From: Olga Pilipenco <olga.pilipenco@shopify.com>
Date: Tue, 4 Feb 2025 12:03:46 -0700
X-Gm-Features: AWEUYZkSjMDys4lW6o2oMWF5kMNeaa_ZytRpAuIJaZJr7O24v4M_BHZRbnYw77s
Message-ID: <CAFLeGL4v90zArJjtCOSGUTGQTq6qQJEcNMhi4P=ucDU+9bGRHg@mail.gmail.com>
Subject: Re: [PATCH v3] worktree: detect from secondary worktree if main
 worktree is bare
To: Junio C Hamano <gitster@pobox.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 1:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Olga Pilipenco <olga.pilipenco@shopify.com> writes:
>
> >> Perhaps the logic is clear to those who diagnosed the problem, wrote
> >> the patch, and reviewed it, in which case there is no reason to
> >> reroll.  Perhaps it was just me to whom it was not obvious that
> >> the purpose of "is_current" check was not about "are we looking at
> >> the main worktree" but was about "if we are not in the main worktree,
> >> we need this extra check".
> >>
> >> Thanks.
> >
> > You did a great job figuring it out and I agree it's confusing at
> > first, but we tried our best to make it less confusing.
> > `is_current` check is actually not necessary there, but having it there=
 saves
> > extra unnecessary calculations, also describes & fixes the exact scenar=
io
> > that didn't work (not being able to see main worktree as bare from a
> > secondary worktree).
>
> If I had to do a great job there, then the code does deserve to be
> explained a bit better for later developers who wonder why it is
> written in the way it is, perhaps we a single-liner comment?

I have 2 versions for comment:

1. Since is_main_worktree_bare explains quite well what it does we can have
a shorter explanation of `!worktree->is_current` part, something like:

/* Additional checks are needed if main worktree is not current
(checking from secondary worktree) */
(!worktree->is_current && is_main_worktree_bare(the_repository));

2. Or a bit longer inline explanation that partially repeats the
explanation of is_main_worktree_bare
+ adds explanation about efficiency:
 /*
  * When in a secondary worktree we have to also verify if the main worktre=
e
  * is bare in $commondir/config.worktree.
  * This check is unnecessary if we're currently in the main worktree,
  * as prior checks already consulted all configs of the current worktree.
 */
(!worktree->is_current && is_main_worktree_bare(the_repository));

Let me know if any of these work. Thanks.

> Thanks.
