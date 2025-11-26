Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175842E03F2
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148546; cv=none; b=M4sFzloCsftVuuk1f8LHBQI4DVNohCaDRha2U6zJPKLyRPJMDKzYFbsoZrIHKZOYQbrXI+dVrnPJuRFcYU0MkqW9byjhY7xbtNPC3axCEDF+I/uLlxy5G3bSvW3z539qrh0FsKBpHLviEAfL/SkQEiKMdoPdtjhsik0poTdmkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148546; c=relaxed/simple;
	bh=YfDJ9vHh2hlPlGNUH0iIMAno/yrB1gOC2w7GTW6ziV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAPnT9dPP8A8itlMl3Y7nn2wgTKrLV+7psaACpuxk/GSjX3jpaBvGkLrKuBh+ws3Od2oulgkbmPk1y4Y0d0KzCwVMroN1b95jeXBNItHlz5gKfl4pzRSLtDLPcnucJDkB4YE10GtU6bNMxjMu2qqUTYJFblWL8XO+CL1kwglvk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+OXCbsY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+OXCbsY"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1004635a12.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764148543; x=1764753343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BenOQoStSULv6TwgQK8jO+QcnU+PzhRO10Taze56OrM=;
        b=F+OXCbsY8qkCvRDnzN8BFUvAhTpSuOktPRGwzmdDVvm/pq+lK+AIdOCMC099bLhWya
         a8QRAfGaG2tNfzQqS9OBLKC6dQU9ux+qtkRQ6GZis6ki21GTLQAQ/Z11+kzzCu2xHx7x
         Yz/EW+u1ZwwEH0kLVAMUQqJoQi/ugrXCRjBGwV7nGEUASwiM/Cl1U5iNc3WJV0+529GM
         kWHCJmKJaw6FoF8RtQfgFZ4OuCI1WgZeU7Ebsk9cyYOOVpkLMyhZRz4duGIOoFVcQJrd
         O39xF88UYFHEXtsy1N5qeQ0l32RESAjQA9QJDRoKi70UkJJGWbOl74ucQ/EYG4pjkNRR
         cvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764148543; x=1764753343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BenOQoStSULv6TwgQK8jO+QcnU+PzhRO10Taze56OrM=;
        b=jxulTthvwC2pbNikjGZkz+DFAUL8VVEbqty0e+npyN++w78+k4xqrbJw/T6yEuUHQv
         YSDe1i6OxrTnDeqSDXzFoLx148uhhUnCxjkqjY/+jya06NX85joxmED2py9soj2UOIhN
         LHgBWAXw5YqjpbgtcWk8BRkCVgHeJcrOcbEGtfio8T+6082mxDjst0YfcYWdJHrq4ZXS
         vhrS8/oibRjeRvGLZD7v8yR3ZiSL3IXyJIoq6NunUG5y1pgF20fhMK1M8KwN6se3hipG
         ma11QPNHEFG31tOtMRTIVXGBDYZ+p1fxSKwE9CRP/ul3SkjtHL4WpJouMrFiQ/EQCRmi
         6vhQ==
X-Gm-Message-State: AOJu0Yx/f1v9VAR+45R8pgL1+DzK7mdXtLuAjxO2qLFDnrS/oKrUC9A5
	QRnD/YrsXlVgaGYnrri/6ZKbp9M/ZzFJODccN3eD39eRmJQ6WYBemKBH3nRMfE39/DseiN5P/MA
	/jK0WERsipzAcdp7FLaFL16PnJ2bfvXB0aYPvmBA=
X-Gm-Gg: ASbGnctTnlxNdMuJo02YBZDr9ceSAvoL/ZnPNE5Fqt4L6EHG0TPfRSAEjCyB+tMuPG8
	M5pM1dlyG8JPY73HPktx7Oy0vnH/myawOFstQ30MDf+Sw6MW//vxUEnlXuzLCpcpCoCL0B033Wu
	6fLKt5pjqAxbno6sFOWRVUJt7ViCmsQBpQTuX2HGa1hvkbQOgjRI89E2inAhaz/OAwNNjK/kVK9
	2yvMrOass2j3TPfBsi1ZE/ObGRHZgi55BIPAE+KtPr814ftUWOZgPViXSg3ZpOZz/0u2MQ=
X-Google-Smtp-Source: AGHT+IHo42Xgkd+2ObCIfBBwP44k+hXPainSzIbt53gg8XsyflOYajme20GYscgnmeoMZRJ/i/mET2NYDg/ASEyGPR4=
X-Received: by 2002:a05:6402:26d0:b0:634:11d7:f70c with SMTP id
 4fb4d7f45d1cf-6455507834bmr18760393a12.2.1764148543038; Wed, 26 Nov 2025
 01:15:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6oppqyt.fsf@gitster.g>
In-Reply-To: <xmqqo6oppqyt.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 26 Nov 2025 10:15:31 +0100
X-Gm-Features: AWmQ_bkYu5fVE8Lj9e0PF10qfncFcR6NvimImXgcm4xbEQ5tatYbQU4-U_OsOb8
Message-ID: <CAP8UFD3BfcvRYA85Pp5L66Mqjx7A4AoxKZNkw2OFXqyWwBoViA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2025, #08; Tue, 25)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 1:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> * cc/fast-import-strip-if-invalid (2025-11-16) 3 commits
>  - fast-import: add 'strip-if-invalid' mode to --signed-commits=3D<mode>
>  - commit: refactor verify_commit_buffer()
>  - fast-import: refactor finalize_commit_buffer()
>
>  "git fast-import" learns "--strip-if-invalid" option to drop
>  invalid cryptographic signature from objects.
>
>  Will merge to 'next'.
>  source: <20251117043450.322644-1-christian.couder@gmail.com>

Not sure why but you seem to be the author of the "fast-import: add
'strip-if-invalid' mode to --signed-commits=3D<mode>" commit now:

$ git cat-file commit 6c723ad30a3f77787e2247f52d62fa462a24cf68
tree 68ab2d63f36af2854b3e49c563bd213fea1357a6
parent cb034c020aba54360e7c19faf82021399bf131e7
author Junio C Hamano <gitster@pobox.com> 1763355463 -0800
committer Junio C Hamano <gitster@pobox.com> 1763355463 -0800

fast-import: add 'strip-if-invalid' mode to --signed-commits=3D<mode>

Tools like `git filter-repo`[1] use `git fast-export` and
`git fast-import` to rewrite repository history. When rewriting
history using one such tool though, commit signatures might become
invalid because the commits they sign changed due to the changes
in the repository history made by the tool between the fast-export
and the fast-import steps.
