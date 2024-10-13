Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33851862
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728791179; cv=none; b=oJMK+8vDXcPCqlJn0TlXpvSa7ncvf0PKnTvpB2PcJN5FVcaq2rKLJum/y8CklLy8FXaNYmLbT/74Cx6dej1fNm+xct3CrrZrJh4TKoFNlblMG7BUJi/ekkItYPXQnsSLVaWBymeNHpAXoRGgro7N0SDJHS+vtAcMamrc5gxwU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728791179; c=relaxed/simple;
	bh=VJorXecxrhkp98bQeQMDoe54Cm03m/GGSya0IHEFh7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzO6RdR1hyRXU8gQoKn0uDnJuKXi1+P49snhPWUq0CQzgSfDB+O5zx1pdCLn1f3bGWCl+KpDj5ubt5/C+xST0FC8HUC3tnn/E0CAKWXJilLgvru/HRy5ETpVt2Yt4Yjg4lH0A2vuc9RdwBIvtHrInk8AzeD+1EHG+05BXesByb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmS9sCn/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmS9sCn/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d564df009so756e0c.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 20:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728791177; x=1729395977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTc7ZUcp+ZtH3yR4gT+snjODldNFz/c78HiEq/sNbW4=;
        b=CmS9sCn/zdLeLkUJhfNbsrOqF6utZZ1u7Gn/bfEVUzmqlf6LpY1uTks5HBPDV81vBM
         cYqKClOpyupOI/Z05xW7SksDQAjI6b/jWCDicCg6clTKKO2LPIJaExDjG8vpmF3dczJ7
         xUR1TB+WL7AXjvZmCPmRYflRKWwAGOLkRslKqoFpwfe6t0DQ0FXI8Tn+LklFk/Rlbb0u
         mMNhJfe73YWzqmouV5D+FfdqtU5qz9z6Wfh4MzkJjC6MJqYi4532pfef7rh6XkH96Q4O
         lUsOUkMcWw7qEyBomIhaiC9OnRGWpI8O1EtHm2PGEsmva4FEKABrPSGZG9Ffl3jgIXgG
         S18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728791177; x=1729395977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTc7ZUcp+ZtH3yR4gT+snjODldNFz/c78HiEq/sNbW4=;
        b=BQiAp8M8d9r9he6szrhEfCbJgByaUQcMZ+0zbfSnUkmk7+bLGWoNMOO/SjqEd0ilrE
         PFPLKv3v4WfP+oMsmvQGtFl7YoyrQ1Wx+ga6iNUHEaUNZIoJppfNLNCgCqtsxzneUjVs
         Q0+bwIM58BpLoGGLdY6gOTBTVwFVa9NMZR4Z0CJo4Q/1Prs5gW8opyK3weCIUxGmSHvl
         AElSWF0is17ifvxBopR9ZfwmarAuTtvfP4io6boYPGmKfTrrSWfFb++JjyskrjbkrIUc
         sWzV4VAB+eMjXdrqqlRnrM1pFl3SlVTxWcPJwP/SrKkTENdMJ8Hg+JQhhdZXVqVsI8Rg
         OVZw==
X-Gm-Message-State: AOJu0Ywxa0jUTlj4B4sBTrgNYuyfNHDdQIL5cJizLWwS/aPkuASJjMKi
	t/X5HIbYhBWQ33icwgYBMlFSI8KuWDwPkpMMjZLnf6s3qmi+6SHEwN0jnnabJef4BmZbgAZAVyk
	kwVUvIPxXxWMEofC6hmggAGfq7Ts=
X-Google-Smtp-Source: AGHT+IE007NpadbL8bNfJ3mkdQC24vslYpp0/w5QRcx4rF5JsPyJNZEEcByt+vR25C5V0oNUIk8Pb52u1Lc4TbCVGVI=
X-Received: by 2002:a05:6122:2a41:b0:50d:4cb8:5aef with SMTP id
 71dfb90a1353d-50d4cb86025mr320276e0c.6.1728791176603; Sat, 12 Oct 2024
 20:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local>
In-Reply-To: <ZwqcHDzaR2U2JNu0@nand.local>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 13 Oct 2024 03:46:05 +0000
Message-ID: <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	phillip.wood123@gmail.com, Christian Couder <christian.couder@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 3:56=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Hi Usman,
>
> On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > Hello,
> >
> > I was looking at some #leftoverbits which I can work on and I came
> > across this conversation.
> > https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yNZzdAaa=
5CGTNGFE7hQ@mail.gmail.com/
> >
> > I followed the conversation and came accross
> > three instances where I think atoi can be
> > converted to strtol or strtol_i or parse_timestamp().
> > These are the three files which I think the atoi can be
> > replaced with.
>
> This seems like a good #leftoverbits to use as an Outreachy
> contribution. From a brief skim, it looks like this is going in the
> right direction.
>
> But to get help from the rest of the list, please submit this change as
> a patch or patch series, following the instructions in:
>
>   - Documentation/MyFirstContribution.txt, and
>   - Documentation/SubmittingPatches
>
Thanks Taylor, I already went through these as I already sent my first
patch before.  Also, I already sent a patch as you suggested. Thank
you very much.
Usman Akinyemi.
> Thanks,
> Taylor
