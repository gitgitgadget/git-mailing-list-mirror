Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594C2BF017
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958677; cv=none; b=JPf1hMe4kVd8qSuI9NMJvuZhMsjb1OB1qQ2TvOg8OAS1vU/jMs1cBpGDuxkFjls9FdAfe75llvk9LaZuemmQ2qLthQ9bDT73Rg8kVz02Ikr/MpMSKnlwg3IfZox4lL+bGoKQVdZfVTPBKDmkSEW3gWPGiwP1VWfhh+UxKLaQZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958677; c=relaxed/simple;
	bh=3jcFZxUomRTJMNzrQXMHukXdnfn/LItmufszuvi2W48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koNvR+twZkzLq9en9PyVIg8xmUbGWmiPAnvz+Ea8vn1I3Pxcxp+sxUUbAuJ/vJ6H9netss+cFPQC1Y1niz5YxXpTitCv4MOrwKuiRGv9F76vBzx1yn0FNb8DH1ficKAb2HnCfbis7BTjKNJPmRxlPcrSoVIYzqnAwZfn2ibczoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=U8h4COkh; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="U8h4COkh"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93607aec358so5415739f.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759958674; x=1760563474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=er9oMGaa6aSnKCIikqvjpLuGOM4OZaVnC1Mpwf45cis=;
        b=U8h4COkhS4mzrP22+n/ySweiCKeJj/MuLaPbe1zE8+6OrkQ3AnBrbcDoyOCETRYUMO
         RGPCXLXmcgLz012VBmVTfDbC7Xnm6SAROhyzi2S6CenEv/D1ts8EyRxwjjd9nmIHhHFi
         k88qDa69lktyFAn+zj3w2J29ufOsO4EEN2sBAD1euCIyPzxSK0pFUzrt/c+bmz5BSeeG
         Weg2lbMcfcLzzGCTP44wXgtSFiiJfxxjlqlSAmnkOuD+/g5/Rmxan9t/+ZS9UVvcRdTQ
         l2pv3Iz2wsU/4+Mkum8BYkyl6qe0ve1+wb6WDxByfnE/YXwP51bUxkDLJVMQC2zhgnps
         3EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958674; x=1760563474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er9oMGaa6aSnKCIikqvjpLuGOM4OZaVnC1Mpwf45cis=;
        b=rEXYajkvV8+UzpjSnucsJNXYVvLO5RN6QzilTzSbXZFOrM84g5GOoTbHM0OGwuEjOF
         mWy++0pfDmyWoUAOJRVEd4pEw0BVmQWOU/yoLsdXuX7Ehaium5aC3CEKKfbIyFxOQm/i
         UHoPKkqRAWMh1JLD3m1f0G5DE3bZ2xmAiUNu2vOwT/eO6PSFMB83pnFBe98+3WNVZZDV
         ou0VooduiMHFbTUqP5tp2AnR7RwFRMv18anQo/55co25o4xLunVXtT4Ap1G/a0iiMBa8
         FOOwIFDxbyk2AoFnEmGDssgMtz3k4comOvdTxW6Cg18Ph1VJhp29Hkth1JP9xEf7EiOd
         yeuA==
X-Forwarded-Encrypted: i=1; AJvYcCXVxwR4eIexNXAfFBfn3/u54CNz7ZRXeDwB6/hPgljxhHRCxJYrkgYaTgmJ0YIpoTC7gDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjzzlHEQiQlfHTJ6zmR3+HodMpWnZ5bWO3e6LBb34Ld2RoHav
	eBA98Rrx37KLdYF1Qhaxf+g3kTXLM8EJtqNlz1qdQHFCSnXUr+1ruWKbLsbRMGJolKQ=
X-Gm-Gg: ASbGnctfJDNL7SXTFd8i74QT2XG+vPDNNF8vehMXrzhuQn/2HvtboqLW7pI7YPhN/Yl
	fDqZ4NC7YA+3IwNXk4TZPgUUS5CoExgt6SkYklj2FweQJe8C7oLgahtsFmgIy+iJC6VYbICc6if
	Q8QqtBoQyRCFWuGV6MJ4fu+xt2d/zbkj58ElbHbWpb7f9KH6hbC1+ezX8M3pGV9JAHe/7Up2jMO
	VFebN+H20b4oTXR/Q1XvLk+ue2YlQZQ2THFNWE6s2dHtKDD/8z1Ddc0vPtx3dGNVmPhJK/BCKir
	cThN++DQVOsiSQLs1cRZItAdDQT3/RV0i9I4mskURS0EI9P7ry6vdOY1EJaPKfFFK39dYCASc/5
	ABGRlDmyFhoUnLObGIYD/c4daLeSUZ9/hBD+e77nt7tW++mIGZfV4GFCh1cyxInl0xPZAoOuU4/
	PpjKRq+cn+ti/183ctpgecleR5HTGRjJcGnMfQ6EZEVCkGbi0axw==
X-Google-Smtp-Source: AGHT+IEwxArsbQLvmEK1pdvQtflApH5OeNONCR6yiBv0WDCNS5VcN6gDGj+vgahx50dbZEh2JCbxtA==
X-Received: by 2002:a05:6602:2cc3:b0:8d4:2004:ce3 with SMTP id ca18e2360f4ac-93bd189035bmr539045539f.4.1759958674423;
        Wed, 08 Oct 2025 14:24:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ea31397sm7372813173.17.2025.10.08.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:24:34 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:24:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment
 to topic names
Message-ID: <aObWkRSU5TO9Yvcr@nand.local>
References: <cover.1759873165.git.me@ttaylorr.com>
 <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
 <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
 <xmqq8qhlf777.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8qhlf777.fsf@gitster.g>

On Wed, Oct 08, 2025 at 01:51:24PM -0700, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > I like the format in the cover letter:
> >
> >      * tb/submitting-patches
> >
> >        Extend the experimental protocol used by contributors to propose a
> >        topic branch name in addition to a description, and describe how to
> >        name multi-series efforts.
>
> Hmph, but the paragraphs that eventually go into RelNotes are not
> commit log messages.  "Extend the protocol A to achieve X" is what
> we would write in our proposed log messages, but after such a patch
> achieves X by extending the protocol A, we'd report it in our
> release notes by saying something ike "The protocol A was extended
> in such and such way to achieve X".

Fair, though I think the existing documentation suffers from the same
issue. It says both:

  you can propose a one-paragraph summary that should appear in the
  "What's cooking" report

and:

  Please write a 2-5 line paragraph that will fit well in our release
  notes.

I think that's a separate issue that we should clarify as a prerequisite
to the two patches proposed here.

> > But it was noted[1] that the-topic-summary doesn’t seem to have been
> > used much. That’s not surprising given that the instruction makes
> > the-topic-summary blend in with the rest of the cover letter and doesn’t
> > signal that the author intends for the first paragraph to be used as
> > such. This patch shares the same problem.
>
> Oh, that's a new theory.  So you are saying that authors may have
> tried but I (and others) failed to notice?  It cetainly is possible.

Certainly possible indeed, but I am not so sure this is happening. At
least from the series that I have looked at since this experiment was
introduced, I have seen vanishingly few examples of contributors
following the process suggested here.

Perhaps I am missing them too, but my sense is that it's likelier that
contributors just simply aren't doing this rather than doing it and both
of us are not noticing it.

That may be an argument for dropping this section entirely and declaring
the experiment as having failed?

Thanks,
Taylor
