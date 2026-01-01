Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDE304BCB
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767306777; cv=none; b=X8hp7+oa2t/j1mlgiI55UgSllxyK7vLQw08fRUBqXSyS8uPSnXEeVN4rezqOoq4wSKRvXyeCYm/QEtla47h1ygp/m2DbP+rtTYXAx6+dTKAmhr0yjgZ9IIBgCdiXFdL+M5/7CVt+JXJQsPUJ2WBo04ZOnehv8PZWIyNbKfVUvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767306777; c=relaxed/simple;
	bh=uKZBes3MwRage7toRChQlSCL3nNC4YN1kv8dY8mYlKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8zob71F/VlDHIxCPEFT+4+P3NgDupWaWsuuXZdBxsN8Y1utjliGK9cSxYgwQoEUSnDLVsvcY3pIgSuSlUi7ANYgtBfH2ZoE5/PUR8W3DvnyZIOR+uISIO8s8sdjOuA8+r3KyZhmHqSgTh3Npm8UrlNoMOjj4WFo0CWqG8sbC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjrqoKFL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjrqoKFL"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c27d14559so9119624a91.2
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767306775; x=1767911575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp7xnnAVVTDYRB2A828jQWAcyY11Xe+8LOVJ5Gmb5wA=;
        b=hjrqoKFLzcH3HoWBOHISs8UXgnRBwvp07qOh11BUGvkfcyo3L06QZF7uEYQOat7j2l
         1ti8lfx/AfjtFWdT6lJNP734OTygnD74MZkasKUm9kp3O/4gW37YXERIwvV6DN9puyyh
         Ofp6NrpppGS9ZHbcmT43Rp0gss72ILy9beGnubHo/FhnNxKzo6laqfuiHOowj80DqjNh
         OPWhHuzjKaHsN/P2iAGZIxZfXbHGwNyiod6wFCRFYRo7WGkhfAQlD7apK+zaJPQVcPwi
         cktnaAKf/ohwrZkcsRYD3GJ98H3i3XQvpFyUdYS8i0BPC7rySvSAJ28f4OWSxFhDt9ED
         qnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767306775; x=1767911575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lp7xnnAVVTDYRB2A828jQWAcyY11Xe+8LOVJ5Gmb5wA=;
        b=ns0CKlq/rAHc1KOgfJcQT4d9CRsTxgPdDNoJ2x+XMvOokIUDa6kDN199lcwvQJST3A
         ajQRbjojxZcwfg41U7K4mQGXwkM4MOLvf3B9+eqeKyxVH/r3AN8PlzTrrtnk/+zyn0iR
         CwIVvOvBtphlsLcOX/y3UqIZWnQ6coNzKSavBjl1mEQn+qFEH7EB/Jwa1RDm2/4t/K0d
         EgdK4iy22kgfQqpmzg+4GrQHvhshNZpPIg9SPqsWiyJleTajykSWf5bo7paR0f9qPgy+
         RRzAwzfmOh1rWxuRxCzDIQQ8OPkSYQAw3dx9J4OcGpY5ocWTc4TDKPKXdY+GLbfci6nb
         wC7w==
X-Gm-Message-State: AOJu0Yy8YFjJ8a+V+9ThVzC/+nA5cqELC5ueFyMBp4KUwn2IY3qSwCMQ
	iFmUoHoF6ixvR4ehnA+CAhe2HdvkYcuCL/mNBj9xwNnhtlYvFKX7BLbpuDnG6MEXGV8I/A0fWn7
	vwrBu1N6x8r8aO8WQmxLppv+P8alZjR4=
X-Gm-Gg: AY/fxX6eN8Z3PP/XQxlQOBtLvz13SjE3Vk5pb4R9g1iCV3L12aZkI8272d+pqaDb01z
	2YCroHBSToU9r/aZWq94JgB/airyu7wxGexfUvP7npIsz0fqnQXyolGto2qB4pIpIy0fcRGAnYO
	/uv70kf0e7dcbe0dkcMsq5bt/N7Yd+TGyDtNwhzZ5S5LaGCITPEwmOypCL4aQTBmiLOc4rEN08O
	Vtqe5Bq+0jGP8HhPg00kXsRhCyCId/9noC1QUASPQr2YlhEZM49RRImgL3JnkFGjY/VerEXegXU
	BUARqo4=
X-Google-Smtp-Source: AGHT+IFr+wf5ppBAdlGLrMR0baXHi9MRqnHRFncqWxSCfRfc5Xp4awoRPSO9ZxxdzMRgfcc7bAH7TiB81msdkoRbnEE=
X-Received: by 2002:a17:90b:2689:b0:34c:3501:d11c with SMTP id
 98e67ed59e1d1-34e921f0ba6mr33692090a91.37.1767306774908; Thu, 01 Jan 2026
 14:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
 <cover.1766103827.git.ben.knoble+github@gmail.com> <d6582dc53ca852ef01421d2dd2c446dadb731dad.1766103827.git.ben.knoble+github@gmail.com>
 <xmqqwm24fsq4.fsf@gitster.g>
In-Reply-To: <xmqqwm24fsq4.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Thu, 1 Jan 2026 17:32:44 -0500
X-Gm-Features: AQt7F2pCzORK2ao9s1WZh4pHkpRNdjrk_AYd356kdwltTrsqehvGaz2tEM9VZ2Q
Message-ID: <CALnO6CDDqwC-YpL6c7Ed1yD+xBuzTxAZo867AUue7=iAo5adNQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: git-reset: clarify `git reset <pathspec>`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:23=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> >  `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
> > -     Interactively select hunks in the difference between the index
> > -     and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are appl=
ied
> > -     in reverse to the index.
> > +     Interactively select changes from the difference between the inde=
x
> > +     and the specified commit or tree (which defaults to `HEAD`).
> > +     The chosen changes are added to the index.
>
> The previous iteration said "changes are unstaged", implying that
> the changes are removed from the index.  But now it says the changes
> are added to the index.  Which one?

Ah, I think I really mean that _changes_ are added. The change might
be an addition (+) or subtraction (-) in patch terms, so some changes
may result in the index having fewer modifications relative to the
working tree or something. But it's not
very clear, and certainly a bit pedantic.

> I think neither is correct.  I wasn't involved in the design of the
> behaviour of "reset -p", but IIUC,
>
>     git reset -p
>     git reset -p HEAD
>
> show "git diff --cached HEAD" (i.e., what damage you will cause if
> you commit what is in the index), so chosen hunks will be reverted
> out of the index if you say "y" to "reset -p" prompt.

Indeed. I was actually expecting to see the reverse hunks here, so I
was surprised to see the staged hunks.

> On the other hand,
>
>     git reset -p COMMIT
>
> for COMMIT that is not HEAD gives "git diff -R --cached COMMIT"
> (i.e., the changes to take you closer to the named commit), so
> chosen hunks will participate in the next commit if you commit after
> completing this "reset -p" session.

Hm. I can see how this behaves nearly the opposite of the former. Yikes.

>     The contents in the index are modified using the chosen hunks.
>
> is the best description I can come up with.
>
> The actual prompt asks "unstage this hunk?" when operating against
> HEAD, while the prompt changes to "apply this hunk to index?" when
> opeating against a commit that is not HEAD, so it might be simpler
> not to say anything about the direction of the application (i.e.,
> how the chosen hunks are used to modify the index) in this
> paragraph, like the above example, may be a viable option.

Yeah, I think so. Will send a new version with this update.
