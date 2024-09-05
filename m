Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFD1A2C3A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556794; cv=none; b=O2aFL/phT6rCPGPjlAkUxwnfgADQy14glycFA97Y1XdGUjgMkdj+qOkBjrp/G0TqwU9YmeqQyJPpHwChiq5iaOkWE9R6lC/pHdboNo74sDfdlh84C+drMSDAQ++7SVfGmUrh7UvzVOSLb0/eZl8pZoREFjV51rMNClyzZ5FVFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556794; c=relaxed/simple;
	bh=ys317bPTSXJJksDFDXfffaTtta4MTPEv7KKEropOKus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB2Io/BTUJw73zY5HWrA4Dq5+Jjxr7eGHDBbUY4BzgDeHS6eNepX53zC24g5ghGzCRyFw08bDXEICLPduEuXlW/A5dPbHJSkLhtzWM0rRHlvqiilFG7gD3jPO4UNRiSj3/GRxbP0uu2lALFSQOPHxWddyrRY6dd6AVsS8b86n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzzhy9kx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzzhy9kx"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d8815ef6d2so794585a91.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 10:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725556793; x=1726161593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1JemV8vdjvud/wCCMG2mbi6Dk0gnjC8ZLIDTVL3rHY=;
        b=mzzhy9kxMKadLiermZhugfI1xV6xvJyKH/X0kD+ml/8iPBfwmpkzhQouibh3bJwuhh
         46f/Ys859uspz5sylbICPD43sbrYjQyjDFpdswVxPJpVhyojJewCbJEIiZtde7b0mzSh
         +EHDirTB2HcnJ+D1OtPVnSPqRaC8DBMGpJ2Te791cLOWaDYAHcds++8b2XOVbhMUEJlN
         +FhPabyKWGyE4AQ5dy5iHArbyIgQU25Mjp5laQ6CIcH2UAPnmuAxMIf5Xz/PsVJIk0T3
         yWl6sCxpmgwjWZVSau92hFXQ0aF6+3h7M7Mj/MsAeE9qu+fJf91jPIqTGxO1MIZC/vx+
         sI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725556793; x=1726161593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1JemV8vdjvud/wCCMG2mbi6Dk0gnjC8ZLIDTVL3rHY=;
        b=U5BqcD3hLBvq4wA97D/CoHcJ1+pourGGkJgNM0LSGA9S0JGKZ2LyBJLk64LUC2p4GQ
         pT2AhW8h+uP8iyTmdlzg0zbQ4falSznJRFi+2Jr/sRu99uUT+bNTh3hFEDhH5FRJxUgZ
         7gc8FUNYBD6/us+1KfTcFUzQa5MFMv60y26GotCicHk4D+nmpfCF0tmca3M1jwdHEJlb
         Pvr2NxRVAs2jkbIY7W+np9i1b3mrMPENFP30FTID7D1j2yBv4d+Rq1drR30KRHM7Wk8z
         Rfg5aKeGO4ChFQ7Ox9VDGRVvDfdumAgQnQ1UgxKg8PyuP3Ohsz74azmeCmxJDigls004
         lVRg==
X-Forwarded-Encrypted: i=1; AJvYcCX6iKm687eCScfzx+tqdO10lSWf+7wh49nxb9HAFphr5idTV+baCPEH/bXUmuNNEFc23kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSAYD72dBtWsVchCKyEG36pvIihPOBEUPKzdb6/qz9dNAYDvl
	ZGLh+mjFl4aYjEevpnNYbXgh6m8YAirdBtvfQ6mXhnRTI+Hgu2Pjakq//PLNuH6XtIDvV3zG5sD
	UtvfiIaHofukcDRC3Odb4NqkC8n8=
X-Google-Smtp-Source: AGHT+IFf2BCdrrrijmg81yj0QEk6R0f96pt2+EXYh0t/wI8n3A9xhy9DPNjv3rv/6qXEWT5uIqAzeyFXGuS2mLj7apE=
X-Received: by 2002:a17:90a:ea90:b0:2d8:7970:726 with SMTP id
 98e67ed59e1d1-2d879700fcbmr20917937a91.12.1725556792423; Thu, 05 Sep 2024
 10:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1779.git.1725472799637.gitgitgadget@gmail.com>
 <pull.1779.v2.git.1725504725976.gitgitgadget@gmail.com> <xmqqcyli3x1w.fsf@gitster.g>
 <CAG=Um+0WinvE4CQPTwKdxMxj4xBJ9Z1SBWVrGzTMKM3CbMni0w@mail.gmail.com> <xmqqy1462gc2.fsf@gitster.g>
In-Reply-To: <xmqqy1462gc2.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Thu, 5 Sep 2024 22:49:15 +0530
Message-ID: <CAG=Um+0P8SgWo2sN3St8+PpBneQfDBoqnpnC6uMmYu2YOOaWmQ@mail.gmail.com>
Subject: Re: [PATCH v2] remote: prefetch config
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> >>
> >>         int prefetch; /* is prefetch enabled? */
> >>
> > ...
> > Updating my patch =E2=80=94 please let me know if there's anything else=
 I can
> > improve here.
>
> Renaming the .prefetch member to .prefetch_enabled would eliminate
> the need to add any comment on the member in the header file.

Do you mean for the struct member here or also the config? For the
config, it'll probably be clearer
to keep `prefetch` still as it aligns nicely with the boolean
`--prefetch` command line flag.

I can name the struct member `prefetch_enabled` =E2=80=94 though I don't se=
e
other boolean remote properties (`prune`, `prune_tags`) add suffixes
to indicate
they are booleans.

> Thanks.
