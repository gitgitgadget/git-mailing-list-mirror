Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E73019C8
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171297; cv=none; b=bG8TTMwpQgcGOOHaky4t89UpvcSQTBE5s9IVLiTBt61KLIaQhT6K+cvyiO+BR8OgAYzUdQ98XYmm7yhVcUZlqNnLS9lyB1Vqc3vCkQQfCHdiSImwv9nYARbmAQL53v+AMDaB1KQmtF02T5ptcXaeAkWDrt9Vi//WScDw0CN12Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171297; c=relaxed/simple;
	bh=i7u85nnwpdy3/BsI5i31Y/v3yNP8VrlGoblzf5Gj2IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Voq79Am+UIBgXkKJN8nnxDt/NXW1iFly4JrXfVjEDCchaV6XoRBBupZLRqkxRhHzO0MG6rd2D+IOzCRcGto/pU31lMVc7TXyNdVx9/pvjFZAVVKoTIpmUTV0pVD/nWF0Pk9auRNRtJO+YhR+9OrURE91PrkgM5AYX6k1S4NUOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6JLcdUR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6JLcdUR"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d61ce75aso937711fa.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761171294; x=1761776094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7u85nnwpdy3/BsI5i31Y/v3yNP8VrlGoblzf5Gj2IQ=;
        b=L6JLcdURV8rxhIKlULtxJeVuW8EmH+4CjKO+sS2Guztlm+wyO3kWW3axdIsuO3qMI1
         2NywLsm7MQ6PKbG0/S/0c/6YkxXuRD7bmaGoDsxhQ/8/zqH+VQAim3EeGKNlUqzzcjrK
         8lFt1sHX4uvuAaVRHVbuhVEWkGFwsP0Ubdqw9MvmYABLWZmA5uC3lh21BWtJKhTEH9wn
         1/zcGoCk5MK9NTZ0d1WAiwh1MBuGSgvkDqTgFaB+WoYbzEe+4eDu2IIWwk6M6ceUdUrO
         d3/X8CK0lArRwYFsU9ObWsHKb19CJLdEtKgzcjfDP9l2d7FVE/nGS9I/Mhxsyvo5Rwis
         u5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171294; x=1761776094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7u85nnwpdy3/BsI5i31Y/v3yNP8VrlGoblzf5Gj2IQ=;
        b=AhECmIfa9m42o8dcrdRgowLWbO/edR4g0RevfLnLiX2sxyDS9WqFhkhTIzBhjq8v0l
         TZ+OFG6lbsoI/zrsvpI9M9vi2BwXilrV7cleKHD0LWrGpDgb6XUg7+1jV5TmrxfDQyXd
         JLHEj3KIS7eP6cm4DTaSfN6xZrNrZt4NCYmVUl6DcK0Yer5yrCZGhoUFTy8TijT4YtYl
         qH0adX4rT8cRSjlk1L3jfQilT/j0Di9ag2XZWGTOG02djNFr2+kFlxRi7r9/x07XDrYt
         CWmGL/H+QXDSdfILqVqtdVDhtFYKXMf5K1j3Kgn1YXFEDoQ/cklP+hPG7Jo8QMpUcYHk
         jqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeO1dF/yfgAHjymGWDu2faKdnAK2AamHits4+9SJ1gT+6RdfcI/RrF1y/pyej/3LWnQ54=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/inOXILGDmCv7zccvg1PdKWRfKrf0VfizfxVEpJ21xvzXMD2
	I9iTFlgSiL61GQb48yYl7dMpz8YDPJ3iDtQDB8hKw2y5bqUiAhSoya6+9EiCaUELBug3tZdASeX
	fWz9hbMyqwNKnfHL0rSJTBR/FDvWcoCc=
X-Gm-Gg: ASbGnctN14urhwwflMdm4ulcM2PemCaoKPgWR172lSPI1wY3N4UyNKFd861ya9/KSsg
	73jpLiNocErSxmQ1Kb5d6hM4jUgyWgX1puwSLMD9ALR2M3hFHKplhovY6QIhVE5oiEvTdBIZn8h
	8M9q5Qzr2RGZbcHW0WJ97DSEgGVI2GFCCzMx4AkntVDFIYhTU5EK8gzgWu1XsAQReK8oGlzuxKK
	wFDZnPoUP9L8PiegGkuxWNvoQaByr05EZAz4bivGzC2OYcwC9CBknsAsl0gFrEfTY2tlBd8
X-Google-Smtp-Source: AGHT+IEdPen2CSei0+nJzHc3pDdyuVZ30gKE+vir/cqBvgKO6V4+m9+avnDHd+2vlI/XWWHsrmo57Rc1LXG6pREE6Js=
X-Received: by 2002:a05:651c:1992:b0:378:cddd:ca69 with SMTP id
 38308e7fff4ca-378cdddcdbbmr11645701fa.18.1761171293985; Wed, 22 Oct 2025
 15:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <6dca5e6222e1d02092d4ba8296b757b123b85afa.1760563101.git.gitgitgadget@gmail.com>
 <aPdFeHZKEsRw1cTX@pks.im>
In-Reply-To: <aPdFeHZKEsRw1cTX@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 22 Oct 2025 16:14:42 -0600
X-Gm-Features: AS18NWDJEn6xE4J1GD8wR4mVaO4k2On-S1lOKsWhMGhghPH-DqOt4LkhnCrusjg
Message-ID: <CAH=ZcbBbnoiBndEYryMpDzav+-iHFA7_3BPNw8hgOBiaFjCq0A@mail.gmail.com>
Subject: Re: [PATCH 8/9] xdiff: change rindex from long to size_t in xdfile_t
To: Patrick Steinhardt <ps@pks.im>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 2:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Oct 15, 2025 at 09:18:20PM +0000, Ezekiel Newren via GitGitGadget=
 wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > rindex describes a index offset which means it's an index into memory
> > which should use size_t. dstart and dend will be deleted in a future
> > patch series. Move them to the end to help avoid refactor conflicts.
>
> In a patch like this I would appreciate some explanation why we can
> change the type without adapting any of its users. So basically explain
> why this refactoring is safe to do and won't cause any issues.

The values of rindex are only used in 3 places. get_hash() which was
created in [1]. and 2 places in xdl_recs_cmp(). All of them use rindex
as an index into another array directly so there's no cascading
refactor impact. get_hash() was created precisely to reduce refactor
churn. How about a commit message like:

Changing the type of rindex from long to size_t has no cascading
refactor impact because it is only ever used to directly index other
arrays.

[1] create get_hash()
https://lore.kernel.org/git/637d1032abbd33b7673d3c101267816fbf1a343c.175892=
6520.git.gitgitgadget@gmail.com/
