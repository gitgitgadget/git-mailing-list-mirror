Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C317548
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709376888; cv=none; b=NPOTbZ8iBjjtvHpRBHTi4r1hymV9eqNy0d1DOABtTfZ8rLEqw5TfFAWvBQ1Kla0WjfOIJ2DTTs5JRfDskMKJvSZRNesGUMALVvnzRzEdL1rqPazsPTtzkdQV9EoXuPPXe+N4C7s5RcxoYyg4hiNng8UoFfhYWxxlNZ7msCHC4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709376888; c=relaxed/simple;
	bh=icVNLxMDBMydG1C7MhEmJoVr0DUiEPKCyBUCfI0o9Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQPN6axYQdTxMeN1sEOqh06T25kEw0D5qWgEvru2R1B0pYDeF0ChBiAheBrhucs+3B5sMrbpuajS3qkjDVyRNLH7yEP3FckUbfupkJSi1BY7pmuTKTDpA+JFEt5knBTgmxd3dM2wawCYdBzeYrC60+bFc5VYT7NEQqNR1SawGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbi8KdQY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbi8KdQY"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso4759604a12.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 02:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709376885; x=1709981685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icVNLxMDBMydG1C7MhEmJoVr0DUiEPKCyBUCfI0o9Eg=;
        b=Vbi8KdQYCFQH9HMgoh5PJsp0/TWhsfxGioGal3phFDH3YssvTyiYXjfUCJkbH1o9Fu
         wpRpB5rFYaxmJzd7WfnJTNNzeEuSImRQq4BL1qehk8psqv+PMP7ytSO9aK0jAQn2kVKf
         u8RU7AE6R0E/MmgG2PBkEKSmvKYXi4CDzUNtoafRwifGBXUCtl8o+bvmd1j9u3tDx8VZ
         wsC6BOMlnWC5vUo3O89hQik9BPMzAfLs9HMcTQsazMf+3lnOykkPVwwKqyAkcnCLjioJ
         Go0e651hxMWQjYNRuNvB+5TjEImkSCHR2JejK354g0oE82WptZy+3iQ6ACJmrhwrT2Oc
         o/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709376885; x=1709981685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icVNLxMDBMydG1C7MhEmJoVr0DUiEPKCyBUCfI0o9Eg=;
        b=eCDyWlkgCt7GY+VmFPf8bS14eY9bAcEFiDw2AdARqmOjuSea09Os7zEs9+0Yy0hxlv
         xKOBqQQq39xYQQu6yBqICd5ZhK99+J1zp+9MpXBWKfl6fixJwJ30ondKsED6NtL/sc8U
         Y7B6jNMW5vcasuTjTCEESW1vMcDfqIRoFJBOJdZmlgaFBYRuhr4XdhNp7zEHbM21E+40
         NE3G5StwfqfIwgn3bK+gaWkj7ayaqZColUHZOfqNToovBHy/+OamhZ7VGgIBc4eIj7md
         aUZs9Vpci04VgHX2etD/uQ2/YNgNqmMA3Jc8x3NnCOmmhdESHtP+fK7H7178zKrjU8ZV
         rFEw==
X-Gm-Message-State: AOJu0YxlQbwos2rTd24EaJeviFlRmubyoGYfEFUwS1LNm0OJWS53V/NG
	HxLjstweK7rEbE3u1AOBxjiXmu81CDDWcf74LQFXSEDh+ZoVbEVMusrApjgDDO5KNq6s+EgGFst
	/p8WASGP1UEmNg6YPmsW4JaRUFow=
X-Google-Smtp-Source: AGHT+IFxMpSGV74ADbNqw21AHRTS2HmS5xjVK7LH+TyZ5CNciwYd+aeZDN2go010q6CR984Atn/bSV1jCrxD/vEogHM=
X-Received: by 2002:a05:6402:26d6:b0:567:dea:c3bf with SMTP id
 x22-20020a05640226d600b005670deac3bfmr662299edd.41.1709376884667; Sat, 02 Mar
 2024 02:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttlsjvsi.fsf@gitster.g> <20240301074048.188835-1-sergiusnyah@gmail.com>
 <CAP8UFD1sAYORc_q20t4Y28mSjNa0BZ69XQ-hGFsNTzbThsG1KQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1sAYORc_q20t4Y28mSjNa0BZ69XQ-hGFsNTzbThsG1KQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Mar 2024 11:54:32 +0100
Message-ID: <CAP8UFD0DAX_7srT5-AhdrWCj7nOKUCFBdwBph=4YnydvKdgFzw@mail.gmail.com>
Subject: Re: [GSOC][PATCH] userdiff: Add JavaScript function patterns
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, pk@pks.im, 
	shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 11:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> The subject should be "userdiff: add JavaScript function patterns" so
> with "add" instead of "Add". See the SubmittingPatches document which
> contains:
>
> "The title sentence after the "area:" prefix omits the full stop at the
> end, and its first word is not capitalized (the omission
> of capitalization applies only to the word after the "area:"
> prefix of the title) unless there is a reason to
> capitalize it other than because it is the first word in the sentence."

Also about the subject, please use v2, v3, v4 when you resend a patch
or a patch series that you have already sent. `git format-patch` has a
"-v <n>" or "--reroll-count=3D<n>" option for that purpose.
