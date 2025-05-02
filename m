Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AB57C93
	for <git@vger.kernel.org>; Fri,  2 May 2025 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159079; cv=none; b=HcuX7Pw41Wnpy4nlf3aHFUgOpLWxfl6WOm3+ZdzXgWXAzzsGCt8pqJ0PfrTPu0LMkRSzJ5CYO+/oSpTsVw9SPY5kG9A6S/bjBcFeRKl2b4fuJ6eFXYwbOfL98+2vMz2kHFP5eH6wWubkcb/Gtpxq9Qt2akADAkGyWTD2oIIMZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159079; c=relaxed/simple;
	bh=3w6ysrxuGe9eGkYty80pYFMOC1GfDtiuyx1Z6nSt8Kk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VVWsivPb2BrIryMMTEDNBrva64U99CZ9LLp3bZjJvX0vA53FaGTpj9oICDYDh/ZUjM/tvalJG5tdrUf5MuOhTkD6IFHbwkaEiKB3kPaF6kYxCBjM/75C0iznOftjcFwjIrDrpHn5MfnNhW+6cuRxUtzVIoOHE33Ys6yF5D/yWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxAcktOo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxAcktOo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2255003f4c6so18149325ad.0
        for <git@vger.kernel.org>; Thu, 01 May 2025 21:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746159077; x=1746763877; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2tfsEYvMdqdc4OaTnpR7X1rVlvMtSkGhaVtoNcYkjk=;
        b=fxAcktOo0Ikqw0IUB6riF9/Y9cJDF4+y50ZZTjmTcqrrF7UwuqkTEP2345ngzd0cvJ
         fsjKXD9/F2bPAf9k5lBkjQhwenZQ0FIygLUh9hR9UL48KNBbA6rVxjYuEHxT5wiQqVx/
         NSGGPvAgAtjx2Ky4k+c+kE9NlLATaOmtHNunqsh6pakze4PJBiueKL5rNY6jgUe7G/Tu
         jQjEjJ1jFk0m6AEby1QcV15RZ60+ApuyYz8T153AWh9XidR24bASONqWqKwIxGYdMpPI
         o2tRJSTKGWX6HYphsy3gPqOyZewj67DAZFHbAyBb5yq94VkcT5gdF5+KjQ2e/VNAt+/q
         xr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746159077; x=1746763877;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2tfsEYvMdqdc4OaTnpR7X1rVlvMtSkGhaVtoNcYkjk=;
        b=vbvBGezvU/bO3QKGxhd+qlrA4zokdos5Kjqvvf5PycszCs2+0OFAD44wlPkTGBaSmh
         IdU8HOdeSEawn2ZGLmI6zjNo+kbIDaHoXx0WxD5FheJSgFcuu2Y6Ha+0QYxa6j3BwC1D
         s+d7ZXBD8FcO9pLoCQ+hA4ZyTZjkGVsZlQ1lgUSbOtktT6/gMKnoDexCTypMWnBEEI3w
         mH3L8cXzHhP+9//dJ/+ssX+anwAceqtEQAco269HnpmSH0xwcwnMyFkpjmHyGxVlMOVO
         veYPMnk+OGFz/w1SxXSXTFG4H9oz1slHKR8sZkckITUd/GZt82AQo1RtYS4tNFXi8UeG
         D8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEQBE21VhPttp/20ukRCqhmQsVOCIOYdxGY//nqFYuj7whC86O44G885/ObpV8+4kCBDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJ/pwrFfZn9c+7D7VIGA7mSmqUIkK4C4UqYld2TA3G0ipd7fN
	wrd+P/IA3YUh4FKHR5DMpJYHyBdr29TxwE9VrXAs8Af9fBcdkPWV
X-Gm-Gg: ASbGncuEuOwthgxDWUIngYarmY2YIwQlcUwa/Mmi8Qoo+waYRY1h7P2YpfOMDxcNjj8
	6k03+RGCjN3f7d4HvEw1DvgQqiwh3GHzVNr9pdQgE3qdF5zYnnXUkbGQ5bQv1tLyCbcfu3+UdN1
	npzL99YPVvW3JfsOhry6bWEMSIQzs9gk6u18MBBPlwX1dcReuquk00ElIM8NhzpSYFj2d0FM7+U
	wokGVwQePsx6B7RlXaFOsYgZNTZsUkEZV8cfy+85X80f28FUOl6Dg7aIEdazmVLCLuU5qQCGg6R
	ZuE92l2YTdo3snYRz7NyEqOjlrtxUcy9yc8MPn6DLFh8UoqU+RLCFDL9oCcmle3k5lyU2IftlfQ
	Oypmn0QH+V/joLg==
X-Google-Smtp-Source: AGHT+IExYS15fwcR1oVtgUUpybYBUNrKSoM000KWENMdNAUb5cVL6Tn8FpvTnLhyHogQkKY8/An3MA==
X-Received: by 2002:a17:902:c40a:b0:221:78a1:27fb with SMTP id d9443c01a7336-22e102b89a3mr23928105ad.11.1746159076594;
        Thu, 01 May 2025 21:11:16 -0700 (PDT)
Received: from smtpclient.apple (168-103-166-254.tukw.qwest.net. [168.103.166.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fb902sm4554715ad.144.2025.05.01.21.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2025 21:11:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
From: Ryan Hodges <rphodges@gmail.com>
In-Reply-To: <xmqqmsbwxpfn.fsf@gitster.g>
Date: Thu, 1 May 2025 21:11:05 -0700
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Jason Cho <jason11choca@proton.me>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 "aclopte@gmail.com" <aclopte@gmail.com>,
 Ryan Hodges <rhodges@cisco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED60E13F-F9D4-4261-8C85-29AC771B5D54@gmail.com>
References: <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
 <8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
 <xmqqmsbwxpfn.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)



> On May 1, 2025, at 9:31=E2=80=AFAM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>=20
>>> Johannes Altmanninger submitted patch v3 titled "apply: =
--intent-to-add
>>> should imply --index" to fix this issue.
>>>=20
>>> Is this fix merged? If so, which Git version includes this fix.
>>=20
>> I can=E2=80=99t find any commits by Johannes Altmanninger that =
addresses this.
>> I also can=E2=80=99t find any commits that start with `apply: =
--intent-to-add`.
>=20
> The documentation says this:
>=20
>    --intent-to-add::
>            When applying the patch only to the working tree, mark new
>            files to be added to the index later (see `--intent-to-add`
>            option in linkgit:git-add[1]). This option is ignored =
unless
>            running in a Git repository and `--index` is not specified.
>            Note that `--index` could be implied by other options such
>            as `--cached` or `--3way`.
>=20
> It is clear that whoever wrote it understands that for this option
> to be effective, the patch needs to affect the index, and one way to
> do so is for the user to pass `--index`.  But at the same time, that
> is not the only option that makes the command touch the index (e.g.,
> `--cached` does, too), and it would make it behave incorrectly if a
> patch automatically pretends that `--index` was given when this
> option was given.

The person that wrote that understood that there=E2=80=99s a conflict =
between
=E2=80=94index and =E2=80=94intent-to-add:

=E2=80=94index means add new files to the index and stage them for =
commit
=E2=80=94intent-to-add means add an entry for the file to the index but =
don=E2=80=99t stage it; ie it will be added later

The author of this commit decided that if =E2=80=94intent-to-add and =
=E2=80=94index are both specified, then =E2=80=94index takes precedence.


>=20
> I can't find the patch either, but given the above documentation, is

The reason you can=E2=80=99t find the patch is because you took issue =
with the fix provided by Johannes and asked for more analysis.  If you =
want I can dig up the details of that thread.

> it even still relevant?
>=20

This issue is still very relevant.  Firstly, let me point out the major =
issue with the current functionality:

Given a repo with one file, =E2=80=9Cb.c=E2=80=9D and the following diff =
that adds file =E2=80=9Ca.c":

	ryan@Ryans-Macbook-Pro git-repo % cat diff
	diff --git a/a.c b/a.c
	new file mode 100644
	index 0000000..e69de29

Here=E2=80=99s what happens when you run git apply =E2=80=94intent-to-add:=


	ryan@Ryans-Macbook-Pro git-repo % git apply --intent-to-add diff

	ryan@Ryans-Macbook-Pro git-repo % git status
	On branch master
	Changes to be committed:
   	(use "git restore --staged <file>..." to unstage)
        	 deleted:    b.c

Bam! b.c gets marked for deletion.  The whole index gets replaced with =
just the files that are marked by =E2=80=94intent-to-add. That=E2=80=99s =
very bad.=20


Lastly, I=E2=80=99d like to point out my use case for =E2=80=94intent-to-a=
dd.  In many VCSs if you run =E2=80=98apply=E2=80=99, =E2=80=98diff=E2=80=99=
, and =E2=80=98commit=E2=80=99 in sequence and in a clean workspace with =
no changes, the diff that gets fed to =E2=80=98apply=E2=80=99 should =
look the same as the diff that you get from running =E2=80=98diff=E2=80=99=
, which should be the same as the diff created by the commit command.  =
Because of the index, that doesn=E2=80=99t happen with Git. When =
applying a patch in git, new files get added to the worktree but they =
are not registered in the index.  Thus git diff never sees them. =
Additionally, those files will be missed by commit even if you use -a. =
The =E2=80=94intent-to-add switch fixes this workflow and allows files =
to remain out of the index until the user is ready for them.

Thanks



> Thanks.


