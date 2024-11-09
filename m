Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A88836
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731139953; cv=none; b=J+gKsY8ukMV3gQELj7lMP1rkigWjMZSh1EjCgi3aS/TpOcnHrc2qHYtjKsvXswJvcwa+ziYxbIRWnrcnlnSuIFxZzRWcI14I5UdeZAX/7L+xSdoMBkPGG9joTMRCG7cZERUMMPJH0Zx2h95KSsDH6noStXhnLaqjPjt6y4lvKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731139953; c=relaxed/simple;
	bh=sJx7EPO4WKD+PK/a+D4+28WB6ELLQKkf45C5by8A4I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RbPK3F+S2/Kal19L42bpXaHIHwo/VQ66UwtNvBEYLvZ7rZVCTpy7rCGHq7ioqeWwA1Ts23261yozh0+OYi5qFy1ex8K7LAC1svwjeIbKQ0PJ6yP8ez28zdNmRCCJq+xsDSOKOOVRjTuoifgTm+KHlUuonsu25eudycYL66dnkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T38Gzeab; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T38Gzeab"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so3454462a12.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 00:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731139950; x=1731744750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJx7EPO4WKD+PK/a+D4+28WB6ELLQKkf45C5by8A4I8=;
        b=T38GzeabOmYbDGm3+ob/Qw45DIP42uTWjI7u771+wzcPjBlpeZRsOD+6HY0BGExcbQ
         Ll56gWfit48w9XZJCgFDI4K/he3BxXXg/wvvzO8OpB6hV391n0MXSHyXnz9eTH96QzVd
         5UQYJ39uUERMbPfu10RYcKFw6l1eSbOZAuQj14E1/3Q2YV1SA4mgdL1K7ScRGhfvkeUN
         q7es4svG3DmdyWWgZ5cg2WsuFcMhhlS4dhor8YiTBsVrQfatryeqgKHOxa58ZvnwntMM
         GxbWeq75CSg0Hq421bSM4ZKOCUeWI4Wkq4ikxtfuD6/+kkjpRabJPMOGTTwV4I429eBx
         ZSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731139950; x=1731744750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJx7EPO4WKD+PK/a+D4+28WB6ELLQKkf45C5by8A4I8=;
        b=dYmzM7Bs4i/I3VBfBxANZM/8mWRlcEtCbFWitgWLq8dBNgIuEjPIO5cmxpxbbG06Nf
         ZIOfmbmeZUHVfFji3L1zQGZRa/ZnQd16fZHdrCPRJR2iO+DD16nLk8NOnhXRf6l6S+ky
         ItJbq8Y14sRtqdgcZcH5R3Zz3z9L/2JD3FNLO531QVFHWebNGCv86RfVW2sNkeA2SB15
         3NY8zClX9JgP6gfTB2BhsNFvV/Mag0xdW9OlysPU+mIliacQCeso/dqPIxuzGQ3av0/u
         DcHft19zZ1SObDBue9WA1MfHQ69b1P53T0Krf9W8Jp47x5/mDem9QzTp5AMxa+iz7Zxe
         4Jbg==
X-Gm-Message-State: AOJu0YxIdN9xmHDsWPI64prItoSVxKnm3qFPrCcleC9Rvvk/136W2QTR
	+ybpGIQenzoXwhoTIFGof4ZaQ2nTGkFNZBfaGcZipnA/9SZx60v4Md6rN9NBHhWRpvw/WSs95JL
	VO4AbPG6WI4wuofRwVMNQeAfhSS3mfCxR
X-Google-Smtp-Source: AGHT+IHxwbquZ7fHTxDPQKqC4LLuUBhUAVmhjsL1z7VEF9G37rDgnVWTPDXzjR9FuzolZd6PnanFPIW1lQQvuc3s9y8=
X-Received: by 2002:a05:6402:1e8c:b0:5cf:4f4:49a with SMTP id
 4fb4d7f45d1cf-5cf0a446c17mr4681636a12.32.1731139950086; Sat, 09 Nov 2024
 00:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
In-Reply-To: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 9 Nov 2024 09:12:18 +0100
Message-ID: <CAP8UFD1-HsYsPRQwWMo8ipf-VdqF+9=HUTTr4BhEArR=V3ucxA@mail.gmail.com>
Subject: Re: [RFC]: Test Were failing on Fedora Linux.
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 7:02=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Hello,
>
> I was trying to build the Git project on Fedora Linux. I just
> installed the Fedora.
>
> I followed through the steps in the Submitting a Patch. About 42 tests
> were failing.

Please tell us how exactly you ran the tests and what was the output
that showed some tests failed.

You can run each failing test with some options like -i and -v to get
more information, like for example:

$ ./t0000-basic.sh -i -v

> I noticed that there are some directories created that did not get delete=
d.
>
> *'trash directory.t0000-basic'
> 'trash directory.t0001-init'
> 'trash directory.t0003-attributes'
> 'trash directory.t0004-unwritable'
> 'trash directory.t0008-ignores'
> 'trash directory.t0012-help'
> 'trash directory.t0017-env-helper'
> 'trash directory.t0018-advice'
> 'trash directory.t0020-crlf'
> 'trash directory.t0021-conversion'
> 'trash directory.t0027-auto-crlf'
> 'trash directory.t0040-parse-options'
> 'trash directory.t0041-usage'
> 'trash directory.t0061-run-command'
> 'trash directory.t0070-fundamental'
> 'trash directory.t0090-cache-tree'
> 'trash directory.t0202-gettext-perl'
> 'trash directory.t0203-gettext-setlocale-sanity'
> 'trash directory.t0210-trace2-normal'
> 'trash directory.t0300-credentials'
> 'trash directory.t0301-credential-cache'
> 'trash directory.t0302-credential-store'
> 'trash directory.t0303-credential-external*
>
> Any idea of what I am missing ?

When a test fails, the directory where the test was run is not deleted
so that it can be inspected to see what went wrong in the test. So it
is to be expected that these directories were not deleted if the
corresponding tests failed.

Best,
Christian.
