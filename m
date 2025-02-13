Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAC245033
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471470; cv=none; b=S4oGLPhxfvt6cpsW0jSBYeHz2X1RQE6eMdBaULk5wbdNL4oy600bIwr/VDw48B6wEws891u6wPEkN5jz+mr0QadhdaDifvz9fgDmQSzB9YtrW0e1gjJ0cYb2GP5eREvxYGa2mgea7QLmCd54JWrP68+7eU2lfi84etmFfDIwHQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471470; c=relaxed/simple;
	bh=5bGe6a6YcyA7yyqfP3iToR9AqUTETrQ48mvHFmMOA+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbuKupf6edLkZCA/IV7xOiV7vl/9r0IEFpSJMF082qPHNd32H7hj0HkKeM9youvIjqt+BmGOdIkfS7AiAJI0GhppBpwNZxVKyhyxXoZ9RMwc0k1WUAinSgTWFrb3zTmMwkwPiPBQCwKoblJ3VN4Zrw3k439nkT/o27sYuAXhxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUAfSG6C; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUAfSG6C"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8553108e7a1so92586039f.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739471468; x=1740076268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdPz1rwte9dLad6OlGFusAr6o9PG71F9JOBhuOr/Zak=;
        b=DUAfSG6C3zm9d9PL7SofdBSPHaa30D/f6mQpK0HLnY7FnxXNV6sAgp/2+SOgMYTRFX
         gsxK8jYrAd6t0qu+oUjLHw+uPu9ygPlrMouM1M7//dnZwIAfpSeERzgbIRTGmbEamA5Y
         DR8A0ArHDp5ZEtX4auplxaASIltzp8YEnBr+erMZ88odPZgciZI4FUlneTOUcMj+waYj
         jtmK/Df66Qcuus5p1bhMc6YGVD3zs+HUM/9vZWHSKSOSpDC7Dy+nkWrSsab1Krftqgh4
         7EOTfRfFA1TCqP2k1WYaxzUi++OERGGX2xwLKB5t9PWsOrpGLmjmYAXRwf/gNmtd5GQt
         89Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471468; x=1740076268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdPz1rwte9dLad6OlGFusAr6o9PG71F9JOBhuOr/Zak=;
        b=MWloq3d3ucvGporWkVoV1bEFTiW+GGsaYv+hWBwCqvY2LYXNvaAPuSpU6gJHKaAAXa
         sUYHSD+yzDnM/50w+8xaOis3lQ1yyPYscnu0rLpVljaZgVNqsWx90OLgLkgUit7CKCo+
         ewTJlAafoAD3cd6lvew9MRXIh99/mV4P9i6YQHaTdBTQogL5jbG/3haR6tk9q04GHtey
         Nb2T1KQebZn6MXapkGMpNNxPQuJGiF4LYpxSkpZW5IuduvJG2vwHdXdnTHlywQahh85Y
         JQXSyy2Fb4y7CVwu5MIOvGhAYSNlUDqmLixeHN3isnedeozW1U5WFaQzdQiwvLOIqEJE
         VceQ==
X-Gm-Message-State: AOJu0YzjsKjQ1/IGhQu7SoU8HhS/awASq4UkA2CXmo0qv9tniUQ96q5t
	AqJFkbXzccCPrCazoBtCx/LRWY8UeH65usNnS88SZWu1fjvjGcxNDbOIKLTJ5Pi+xv6RS34eYrB
	YPDvOTObXLpSuDQtTKnczXVUb7FRHZw==
X-Gm-Gg: ASbGncs3YqGDn/nQOeXwqYkD5+wDrgSqS4m33H9EjJQVkODBCxCgJAFs0/uqLDs/JpG
	ioIAkSw48vsIJSN6hMneOX6Rb3l3/mSIgiUPcdiIyDiyoCwACKSQm2FyRwD1JHDcCeCc4041nrv
	ehsNcXEw34MhxLhQp/vQ5fdeYxbuImag==
X-Google-Smtp-Source: AGHT+IGqg/ZsJZpBWjEZ+ih8pah6DJQNfyxZakPQjf0NaOvpP5MY0FHIBzWTETxh0nm06OYUVsfWxkPnfrEbtT05v7s=
X-Received: by 2002:a6b:f312:0:b0:855:670a:e687 with SMTP id
 ca18e2360f4ac-855670ae7c3mr262596639f.3.1739471467783; Thu, 13 Feb 2025
 10:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com> <20250213090040.16133-1-meetsoni3017@gmail.com>
In-Reply-To: <20250213090040.16133-1-meetsoni3017@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Feb 2025 10:30:55 -0800
X-Gm-Features: AWEUYZl8SItVCmSvnbY2K7P9h7eEi3S3JfO5f5Uey0ctwVkzHEjutdYOp50PVdA
Message-ID: <CABPp-BEC3UVQcJfXLia6+XrmNCnozNdHtGhGOTUr4A9J=Xo1Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] merge-recursive: optimize time complexity
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 1:01=E2=80=AFAM Meet Soni <meetsoni3017@gmail.com> =
wrote:
>
> changes in this version:
>     - Updated comment and commit message as per review.
>     - Added another commit implementing optimization logic.
>     - added an RFC tag since, if the changes in 2nd commit are
>       appropriate, we can apply similar logic in other places as
>       well.

The 1st patch looks good.  The 2nd appears to have some problems, as
per comments I left on it -- it might be easier to drop the second
patch and just apply the first.  I don't think merge-recursive is
worth putting much effort into (there's value in providing feedback on
patches by new contributors, because new contributors are valuable,
but there's really not much value in tweaking this particular file),
so I'd advise against adding more patches to this series that
transform more of merge-recursive.
