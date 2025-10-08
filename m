Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD9208994
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958431; cv=none; b=eE9AosViR43Mze5c4jsj4niaEM7QIz94rMiT6P3uq24oP1I7x9m79PNQqhGTtovITwpmK3LjSK/EZF29CLMASZGKTOCp0OnBcArjUL7iYsjODXYC6ThONap3DfAF9OF3IhitQ7yqYukaaI3lePnnmbM752+Y4z/pcOrP1abSpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958431; c=relaxed/simple;
	bh=XeIneWNudEOMOzjtrZA5PsEdtqheK07kmVOE9AbTuL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t37H59t6nriMC6RoPJZ10kxCuK1iB1gL3OYaxTiLGICxpLgJG/+v9GEbnEjApbi86PhiBX5PtPxiyivmpcyo+zVmwVt4j/93iVt9GTACJOpfc/eTGiDSUIqfjtz1vHQFJyQb4R3dPmnl1lS10FGt/ksZkBPB5ocoXaAeyIHpxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZGCXkUWz; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZGCXkUWz"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-90926724bceso21453039f.1
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759958427; x=1760563227; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27BANmIZlQlj0pWAvCXGHXjqzsvtZ/em0ssWrbrlqzY=;
        b=ZGCXkUWzm4pgSYm+Ho7DoLGfivTKEYViP33bXxiNxyxPsXhpoDBMUaUQkhIFGa2XMw
         Diw08XkYFIUr5mrHreOCQwbUUza5NJ72tkr2yND6vRoDm+SpnHnc4T2xj7XlOkyFqm9f
         i4rupfohU8dis8GYHHy3IWsV6llGKlEae7goAXd4NuSDVOYL4fJ2boK+kK0L0v4LqZnd
         CM8AY2pcuryDii0scKrzTZEvIIdydyITDl+1culQPG01K1XReX96/OTOnaRpgmIp1r4j
         75gnAmlhRGPdIabNifi+zBL8wEtmKnhpc5xZVHNTUGP51+DB3CoViQ+aeHEfamzXPKVk
         vp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958427; x=1760563227;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27BANmIZlQlj0pWAvCXGHXjqzsvtZ/em0ssWrbrlqzY=;
        b=t+Mjit0ziWp+a8fbC4hodiktO4lnx0vmGKKcmfLNstffVHx/nbCZadcA05J+TK14qh
         EO7LbtnXzNtjbDeI+5ADhN0gZks9rWrHNoMkcQpV729MzQY4l6OrWalCH7+/myFnKzLe
         zoG+OjV34E5D0ZLVD3YLvenXNzmbg7PdbNesM5AVdVsbgazmRFWXAkJxYewE95hOTi5+
         7ch0YNbGRrIf4zZQzVuTgdY61nseb9hMvgwzE0gh8fJ+C7ai6pjq8k6ixKW2d/CGWpVd
         S9OoLq18Aco2a9Zytd22zKgOCVGsNXSQyI37Va1E5td2M2hZQoakDA9PLJ0UhlEQHfZ0
         DGWA==
X-Gm-Message-State: AOJu0Yw0st67ORQF3VK9YhM76FT6LoQP7NBBrRr/PvLYAzcBZgscV/db
	3PG3h2Ss/A5lqmdT/89v0fOsWTbjpwNwF/2aM+4ZHKjGPtZFlGoHe8+/1xNU2k6/ks0=
X-Gm-Gg: ASbGncthgnTe4Wv08UBsnBuSADFpuf4iyrF+rEEL7glTz7HXgVJYH8Y+nJiWuc6/B0j
	ZcaN+XhszKNb3C5Qp+PYOo3JXimhbso3aZ4BajKmhMmSTx8RLCRnW+3cakP3NEpQLpaL30oWmwG
	GyRj8q3tXpazJXF8luq4vOalK/Usy49AJ0C09QlVDkUypLTzlGOehPwUptidMLeLkA52AuHpnhk
	Do3uSjYPVtIfvcDxO0LDHYaQY1i5rstD+CWkcZXVxsNYbB2emCTobAXgZnqN4m8MYOX74EU0Fho
	1LT6fv4Asxkc1nJcP4nO0G0AXp+LVHTzNla2zP/QvVIy+UWq0HjkqUCQRINc391QH4wReXQbtJB
	UUp7SaUVT4/fnV6J7YqI7TjMqkKyL0+OOme5qMms1OL+Mt1LQRO1+jJjuzf5Zwh6ysRWheL12EE
	7l4FoT5mtCLHju+NL0gQ1soWCqGCVvXNe2r1Go1anPu9tqRZQKOhS2aO1krryC
X-Google-Smtp-Source: AGHT+IGvLwDl5jgityjiCpGXDH++O6pguw+cORoCeGohG3U6HIL02zhvzC/HXaZ9me52DHZDlE9xag==
X-Received: by 2002:a05:6e02:18c7:b0:42f:81ab:1813 with SMTP id e9e14a558f8ab-42f8734fb58mr55784255ab.4.1759958427059;
        Wed, 08 Oct 2025 14:20:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ec10511sm7383826173.63.2025.10.08.14.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:20:26 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:20:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment
 to topic names
Message-ID: <aObVmU7m4PahMsEN@nand.local>
References: <cover.1759873165.git.me@ttaylorr.com>
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
 <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>

On Wed, Oct 08, 2025 at 06:14:42PM +0200, Kristoffer Haugsbakk wrote:
> > diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> > index 86ca7f6a78a..f48688e3700 100644
> > --- a/Documentation/SubmittingPatches
> > +++ b/Documentation/SubmittingPatches
> > @@ -579,14 +579,19 @@ line via `git format-patch --notes`.
> >  [[the-topic-summary]]
> >  *This is EXPERIMENTAL*.
> >
> > -When sending a topic, you can propose a one-paragraph summary that
> > -should appear in the "What's cooking" report when it is picked up to
> > -explain the topic.  If you choose to do so, please write a 2-5 line
> > -paragraph that will fit well in our release notes (see many bulleted
> > -entries in the Documentation/RelNotes/* files for examples), and make
> > -it the first paragraph of the cover letter.  For a single-patch
> > -series, use the space between the three-dash line and the diffstat, as
> > -described earlier.
> > +When sending a topic, you can optionally propose a topic name and/or a
> > +one-paragraph summary that should appear in the "What's cooking"
> > +report when it is picked up to explain the topic.  If you choose to do
> > +so, please write a 2-5 line paragraph that will fit well in our
> > +release notes (see many bulleted entries in the
> > +Documentation/RelNotes/* files for examples), and make it the first
> > +(or second, if including a suggested topic name) paragraph of the
> > +cover letter.  If suggesting a topic name, use the format
> > +"XX/your-topic-name", where "XX" is a stand-in for the primary
> > +author's initials, and "your-topic-name" is a brief, dash-delimited
>
> Is there a precedent for “primary” author? Why not just “author”?
>
> This seems to be referring to the fact that patches might have
> co-authors (trailers) and similar, or that it could be sent from someone
> else but the author, but I don’t think this adjective makes it clear
> that the topic name should stick to the author (in the Git model’s
> sense) name only.

I wrote it this way to account for individuals listed under the
Co-authored-by trailer. I'm not entirely sure that I'm following the
latter half of this sentence. Could you clarify what you mean?

> But it was noted[1] that the-topic-summary doesn’t seem to have been
> used much. That’s not surprising given that the instruction makes
> the-topic-summary blend in with the rest of the cover letter and doesn’t
> signal that the author intends for the first paragraph to be used as
> such. This patch shares the same problem.

That's fair, though I admittedly dislike the idea of prescribing a
format for the cover letter. It should be clear to those (such as the
maintainer) who are reading the cover letter closely whether or not the
first paragraph (or two) are meant to be used as the topic name/summary.

Perhaps I am in the minority in thinking that, though, in which case I
am happy to continue to discuss/explore other options.

Thanks,
Taylor
