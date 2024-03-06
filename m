Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AD11BDD3
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735151; cv=none; b=UZwK5DhDh7FjORGXbypskqQ2Gx+HfKBTSYwFsmAX562f9RbdgDmlm6g97U2vUnsKKQfsHcEeS5zAAXIA0wvpp9R1KvtfVCdyfgWi9mUIENdf54Qh5wTZv0MQXw8OFxfGZmRQLx6CnAb7rwtJ88EE6MImWxO2AqHOwGsJpEox58g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735151; c=relaxed/simple;
	bh=pDx1Smwcq7AZltMhOv5jqZ4qwIyUyc+d3/7lN4xXzlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkQOX4BbdLx3mmuBtBTgT2hceLmEpQ2R8PGgM6iXrELfgxGGF4v5A5qY37G5M+ETHPol1L/5w71BJJZwtxMEN2TiQGD3R/+I4ZrrCiYGrK1GZXR7KfgtslOCbGueflxTB9Z+0XiFwmi7/EYh3VdWVHtq8ENtx6OC/355yYdGoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUvbFrRT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUvbFrRT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a450bedffdfso455692866b.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709735148; x=1710339948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsJ/mVOCta/fK+wzT6k5EBvKkMwsUgV8P08pJxAPpdA=;
        b=RUvbFrRTa8oFYlQpqF2k6CTTZx+jqgnEEN8Z/6wPXn/qw7EnvPVcPjJt2P4ffbKbdF
         iJrgkFF5Ape4N50E0JxJ1p44rG3yWFsfvMPzLZYADTKkLPRrwBCmO+p2+TbWphBKJykt
         4qCdmBD3IDKTDQDmdOaALD64J4ry8v7mu8zW0q3yckI+0rhsn6eSVKLPzrmMk2npt6mt
         BQdbEQlVk28oKeWlhAZYALJ9ChFDLVWTzyWx0cBBBzQ8v09h6gDh5yEFOHxeOyt9wQMq
         Za+pI3ALdvi62+9lrNfaFd7o3rX1k5arRX0mgqhR0WxgRqVRG5bBthzuYTk49hjprE2W
         +5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735148; x=1710339948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsJ/mVOCta/fK+wzT6k5EBvKkMwsUgV8P08pJxAPpdA=;
        b=Lqz+DS4E6sDnbyZ6KchY7Tec7IAsrR6yahtpUIpUpADwXZ0YF7WSeFWfaAPikJ6244
         bDJgaeUUG4i9mjngORsBDDd7wWqxVOBRHZ/dvOP5JOyGpyFxx4uTfTPEfYE84u4SRIkB
         wuvuD4UNZi9jOLEIO7XFwBZEXDlwyf8xWOPsxjHYsQAMXo3092TW6WGDc4Qbx84OjnpG
         JM3pyDh4z0dfCzfcnPUndrRWCRMFcUWsCUFA6VmVXX3T8E8js3jOhu51ld9iUQRN0+vI
         Qh9U04uBODcFhCcmCqIXK/7CnJEaYmYFuapGo96DUp27eTluioK4AusJAbDJB0dp873h
         DaAw==
X-Gm-Message-State: AOJu0YxnZNPnBE9YXMa4zEvLINxl+EVQQM7SacmTmmX2Xdag8FFCmOp1
	91QR3pnL7XGhqpCKpE5PGcCoC/BpYmetVD+sI+9ND7x+IAfkq+BaoCYttQUZtzcVmUalNC0ij/0
	99JebMVyX0KIq2K9S6/O9T0Er5e8=
X-Google-Smtp-Source: AGHT+IEkh0iq5mjsQKk8zpfswl5OtrVMccLHMq9iNysFAGdIXmcvoz4udJbrpbOm9O4EGvW0LZsimo4ZLW8EyRUeHg4=
X-Received: by 2002:a17:906:2548:b0:a43:7ea2:a289 with SMTP id
 j8-20020a170906254800b00a437ea2a289mr9551444ejb.55.1709735147544; Wed, 06 Mar
 2024 06:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226143350.3596-1-ach.lumap@gmail.com> <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240229054004.3807-2-ach.lumap@gmail.com>
In-Reply-To: <20240229054004.3807-2-ach.lumap@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 6 Mar 2024 15:25:35 +0100
Message-ID: <CAP8UFD0y4fsi8fsVAwjMNdBwWMinL4=wQ=d1pNW1nr1OVkGwGQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2 2/2] Port helper/test-sha256.c and
 helper/test-sha1.c to unit-tests/t-hash.c
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:41=E2=80=AFAM Achu Luma <ach.lumap@gmail.com> wro=
te:
>
> In the recent codebase update (8bf6fbd (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>
> This commit migrates the unit tests for hash functionality from the
> legacy approach using the test-tool command `test-tool sha1`and
> `test-tool sha256` in helper/test-sha256.c and helper/test-sha1.c to the
> new unit testing framework (t/unit-tests/test-lib.h). Porting
> t0013-sha1dc.sh is left for later.
>
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>  The change between version 1 and version 2 is:
>  - Deleted t/helper/test-sha256.c
>
>  Here is a diff between v1 and v2:

When sending a patch series, even a small one, I think it's better to
have a cover letter (using for example `git format-patch
--cover-letter ...`) and list all the changes from the previous
version in the cover letter, rather than listing some changes in each
patch. Also, instead of `git diff`, `git range-diff` can be used and
its output can be put into the cover letter too.

I don't think it's worth resending the series just for this though.

Maybe I missed it but it seems that this patch and patch 1/2
(https://lore.kernel.org/git/20240229054004.3807-1-ach.lumap@gmail.com/)
in the series fell into the cracks.
