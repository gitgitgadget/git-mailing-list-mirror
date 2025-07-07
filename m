Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DC27A133
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871613; cv=none; b=XkMuzcQIaOG69LeSXNJTlFponkTd5AK3pbKCNwFdr+XX2pssx+gCgM9EoNQrkNcZwQklRFKwQ+gFiH6g0QsyBZ9wX1BzYgQ+bFESZo5/WeirpPgkYHEphhVWMO23wS0gbBOZDuxjnc+d3cE6H1DiNnt01brHGX6u49/F7tJnLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871613; c=relaxed/simple;
	bh=WnBL+++XpOnkHhxGDSf6EHZIury8n9AeMYFBzPR+V7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOK+Jk6qHie4HW3klDF2Hm8i11RDxEcDOEZrrKwafx4uEhQXLGoEcv5czyFBqyR8qDhuobShNcmn+KZbHWrnaTj5E5PgRtF7Bl5UHc4EAbkJV8bdZpaHFZ5/xDjByt6g1/JsfZ1WqvaarSlt26gSGk6XMNJKQjDB/6VPlV85Ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/xrMsSv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/xrMsSv"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso27597a12.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 00:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751871610; x=1752476410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=93xFF+Nk9OaxpNffVivUG8UM4qbG/VFJ/6dygiLbWQY=;
        b=S/xrMsSv8sqPPkOfi5RZvOKguoiu6tQwMMiAw2KV2cYdyOzu/X5oyFPOR4B9vszvVQ
         JoHwtLJBPqoseXBZkf6jeC+gziyNQ8sawsfRTQYClzHP+6Ti/xkFG3v8uwubAQ6yKQtm
         kJUBHXdBwoDo+wEfS9tTFzDqCoypQtp8hweH0OQwhNdQ1YDJNPg5ducTM3JZYl7R5Tcy
         e7eUVCGKGHs/zywrDt4HU6XNLGApxXA2OLoySCXDgiZw67H49nd53nVT7HOiAxtwGqln
         cKUlfqbZ44AQn2CL9V1EiOicj1ntCdmuH7L7X1YAfwPWwIu2OSCqcP/VtvXle7z3+MaJ
         tZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751871610; x=1752476410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93xFF+Nk9OaxpNffVivUG8UM4qbG/VFJ/6dygiLbWQY=;
        b=LqtkwhZRN+4U3p0CSt7Opt4LVnVbnbMbMUcYpToq40hSGQWE8B4u/3I6NAqInRNyAA
         Z7ukO7x2Bl3lLqBrKE9KDWOnL9i4ecDLfGjjRPQ78dzUMWzb1ADoaPomDTH/IB/qVz2W
         +aQqjA6kxdhbvt87k2pd7SX8ISGozSVybecfiWc+3g/1Z6m515TGTh1FasBGRRyCgXu6
         uSPlyQR/AsVPfHUNccDJQa8Mis/PSDI/n1fkSzG0LZ9tev+KUxACiO8iqhLo0GZwxI/Y
         Q3HRhWNf/fXa6GrtAX3y3yb7e16GFGwK0bsL2X2GccfzRUXu5u3a4ejryj3xDw04QBvl
         imCg==
X-Forwarded-Encrypted: i=1; AJvYcCVeoJ+KmOdNcA3jeIUyMd+wq0d5aovWNxHZeMXqGBZjOCPLN07Qr8+W8KN8IslsY6Vp3+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlwr1CrD3nlnfFSNESDrSu1TLDtP0YJsYtnByCf465/7dNvF2o
	0/oWlc1F+a0/DRWA+S15wNWoPxclTaxeg5kIBo3BwZyUWULYDcBYs/vXF44fvvo731gTrIqaeyQ
	HetaleB2C0uWgvvQ/LyRQ29Mcxa89tS4QnSbOcb5W
X-Gm-Gg: ASbGncueFnsguz+OuSWPtBIsLKMNqYJkVt1nLKPqIx1W3YatIkQx3YaYrrDhfBkeQx5
	+bKwpTp+MP473lndR6lKj1Rl9+I73WAIB73S4wNj1rQnT4cgtfrqaufeO8556lJGFdENLkCelnV
	f59BK62XCCf6LUlVCfx8TxF5jr1f7nkVfYXKT4C/9GQcc=
X-Google-Smtp-Source: AGHT+IHj93+tyXIISfuHPp/s4HiLc05vzPzEkqag8VJltl5j55vKYPZZqdQUkb01jUugguL3nyzAr9PYR23c9y/+8Ic=
X-Received: by 2002:a50:bb0e:0:b0:606:f77b:7943 with SMTP id
 4fb4d7f45d1cf-60e70791543mr215184a12.0.1751871609837; Mon, 07 Jul 2025
 00:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703113505.11889-1-drew@ddevault.org> <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g>
 <xmqqfrf88s28.fsf@gitster.g> <CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>
In-Reply-To: <CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Sun, 6 Jul 2025 23:59:58 -0700
X-Gm-Features: Ac12FXw12DSFySmgYF6Fptml_89trAE-mgs-JwpeR7-HT9CzSEsLQRLrv86JIQc
Message-ID: <CAESOdVD-gWts6H-pSFBQfVn02nPBT1b0Xpfzp8Hea-QXsEA_TQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
To: Junio C Hamano <gitster@pobox.com>
Cc: Drew DeVault <drew@ddevault.org>, Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Andy Koppe <andy.koppe@gmail.com>, Remo Senekowitsch <remo@buenzli.dev>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 23:57, Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Sun, 6 Jul 2025 at 22:53, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > >> IMO the right way forward is to use a mail header.
> > >
> > > No.  In the change-id case, trailer is the right way to go.
> > > ...
> > > But after thinking thrice, we may find a set of good pieces of
> > > information that should be added as new commit header ...
> > > ... and there will be times when we need
> > > to convey them over e-mailed workflow to allow patch recipient not
> > > to lose such information.
> >
> > Or a third-party software may add a new commit header without
> > gauging and waiting for the community consensus anyway, which may or
> > may not have much structural meaning, and then we may want to extract
> > that piece of information hidden in the commit header out, because
> > it was not written as trailer (in which case there wouldn't have
> > needed any extra effort to extract it in the first place).
> >
> > This part can use a bit of clarification.
> >
> > My endorsement below to use an extra e-mail header applies when some
> > commit objects ended up with extra non-standard headers holding
> > pieces of information that we want to send as part of a patch,
> > whether it is a good idea or a bad idea to place that particular
> > kind of information in a commit header.  And the question is "Now,
> > what is the best way to transfer it over a patched e-mail?"
> >
> > If it were a good idea to place that particular kind of information
> > in a header, that is of course an effort worth investing in.
> >
> > If it were a horrible idea to place it in a header, it still is
> > worth investing in an effort to give ourselves a way to salvage such
> > information out of the header, even though we wouldn't have needed
> > such extra tool if they didn't hide it in the header.
>
> +1
>
> Does this also apply to commit signatures? I just created a signed
> commit and checked what `git format-patch` produces. I was a bit
> surprised to see that it doesn't seem to show up anywhere. Is it not
> supported or did I miss some flag or config?

Oh, perhaps they're deliberately not included because the commit
timestamp is not included in the patch so the signatures would be
invalid even if the patch was applied to the right parent?

>
> >
> > But once a generic mechanism is written, then Git does not have to
> > behave differently if an extra commit header is something a more
> > recent versions of Git tools started using after the idea gained
> > community consensus, or a third-party software unilaterally added
> > without gauging or waiting for community consensus.  The same single
> > mechanism can be used to extract the information and carry it in
> > e-mails, and mailinfo can be told to extract it out.  It can be left
> > up to the consumer after mailinfo disects the pieces of information
> > out of the e-mail.
> >
> > > In such a case, I fully agree that embedding in an e-mail header
> > > would be the way to go.
>
>
> Is it another option to put it somewhere in the body? Could we fit
> additional headers (e.g. signatures and third-party ones) somewhere
> between the `---` line and the additional diff? Or how about after the
> final `--` line? I haven't checked the specification. I just saw these
> lines in the `git format-patch` output.
>
> > >
> > > I would suggest a lot more generic implementation to solve it once
> > > and for all.  How about doing it more like this:
> > >
> > >    "git format-patch --extra-headers" grabs all extra headers
> > >    (i.e. those that are not the bog-standard "tree", "parent",
> > >    "author", "committer") and emit these
> > >
> > >     X-git-extra-commit-header: encoding=iso8859-1
> > >     X-git-extra-commit-header: frotz=nitfol
> > >
> > >    next to "Subject:", etc.
