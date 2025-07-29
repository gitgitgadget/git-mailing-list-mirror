Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11E4A0C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810254; cv=none; b=AxTsPHppE4pOoakcofJPfIdhqgAXFuvWh8bX2dgMfh2zDBAcDTzMX0Ut2Qw3oPAQe4wJvQaRB6zzFUPvtlUqr8NSbhNNTwSfmJ5bLs1fcC1ulwzdexIYI5Cb3YOpGn58PoAJznHPryW1Ccf9CgPV5P9jHFehb9GY3a+Cg8eWw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810254; c=relaxed/simple;
	bh=/dsXRpauhyMWeA/q05HLMgRQcLiu/Gz4JnbnlJrZGQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAY7WrGPKbCKB8FQVVSQqnHg5QMem49W0F4F8Em1aoO2p6vgzC2B4hrZKo2lHXhspthVIFcPQvvfz36ETmso3bWXjkrSBaQT9bUf8uHGSi3LSw16mSPpNsXcd5yidGEuhQ5grJCcn6VdQNFOUN+jflgAAJZM/hgfeq9JejWeEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPdlNDAL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPdlNDAL"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6239712a12.2
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753810252; x=1754415052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZVe4d4iWJzjDCOgpR6poc8tj8xEgio5/ksvxFYhc4Y=;
        b=CPdlNDALB0QoD8n9YkObEyhj14W1XBD4+Dc/M4nUnzMq/j4lAYJg/5edDEACvQ3QxB
         VoSmMiEyLUqRFB44k8QfQ/k8x7GbCZVvw1uKgBBmqAVl94/HGuqLSdaL2ZSe2kI6qJC7
         JDiLI/BxMEYEAn3ZgA9JQOlkjD8SQFQyaBy5nfdTNYbRdsIWP048VcC+o1Y/40fpbERA
         SM3haGMifJ9IhWhmRBJ2M2FmpKa3GJFzSngjp7YgRkYPr3AdmAZ7QTN3WaRZZ956X7Lt
         zSYFX7FaVDi3toaXesCnM1aokWz6pWgbr8AcnSL6ifxRI/5gTMaW56Q1/v+wKAdmOk9O
         togQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810252; x=1754415052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZVe4d4iWJzjDCOgpR6poc8tj8xEgio5/ksvxFYhc4Y=;
        b=Ch5pUKHFY6GO5D1Pygz36Di4zdC7wTB57J0tEW1s4v1HWwPWPBYMBWv1hl0ck1Tnmh
         WltOmrI3adAEqItosatFK8UvJ6FPe2inhQZq2F7zjy5FXEiRAcpgqZj4gp8fyA1Evwwt
         Q5pv2ij7sMr7wcAOTF4d/V+PhF7k7BijBZGLSqslwHGCnx3ceI/w+zsfJfqlMoYoRloV
         HMMbE9MhO7xJI6ieMq3ypjl0uOmZPIm7YPnKpLE/51fVU2jSn8qPdVq7NLkwvqz4MlWA
         poWCnT9VEr4gjZUmgFB9uS5a9/o6oToJE5p4SjymNoozlG2u52wBp3PoXpXpyOUnX3rs
         OUCg==
X-Gm-Message-State: AOJu0YxxCsB2uXnWOOCjx80nctiGQnLIaAMR7H8emruB8gA/5mqB+t/f
	kDVRWTTaKVgw83JyBvdAG2bgCyHSjdFlBCptqlCLSYpCU7tOoVJBl7VbxU28PmxGgtgLhdW3418
	RqcMFy++ivE1WmpTKEVzIl3/vr9gxzXk=
X-Gm-Gg: ASbGncvapSoPQ3ozoAx3IZp/gvdYDChZ5FsQmIbYfqkADS6myctkcisy6kHbjwo/IRI
	x1TFNkAeSJS9kjpFZXcw/X6Fxs0z2Hq74FBQ1xPpceZtnaPTDKaRc9r6EYErZQ+nQpIISafU9+l
	j4b7veI9KEB+59RlV2+yTwTxNMItLxELBFOHzXmnQeJOm64UUIpW6/zzFk2y1nhEtIi/Sa7QOPt
	WOOpqyU
X-Google-Smtp-Source: AGHT+IFpqdMuyAf+Zax1D5pRDPI/V/1Hyv1tSVIXCzSAz1fsIpE9Bra/+19EIzYp3FONxSnozwvF1Ctbi9dzDRxG4CA=
X-Received: by 2002:a17:90b:3b46:b0:31e:c8fc:e62a with SMTP id
 98e67ed59e1d1-31f5ea4ccd9mr411806a91.35.1753810252125; Tue, 29 Jul 2025
 10:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753804956.git.ayu.chandekar@gmail.com> <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
 <xmqqfrefosdj.fsf@gitster.g>
In-Reply-To: <xmqqfrefosdj.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 29 Jul 2025 23:00:39 +0530
X-Gm-Features: Ac12FXwSQTk75_DTjo4E4VyFOwYWC6xB3uaMdjXtJ05Y0gcxCagcIWzWAJt2sb0
Message-ID: <CAE7as+ZwiMENJDd6rjnF6w9tt_mJ=Kzf-t9U6VxAKmCdacOgbg@mail.gmail.com>
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable 'merge_log_config'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, Jul 29, 2025 at 10:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ayush Chandekar <ayu.chandekar@gmail.com> writes:
>
> > The global variable 'merge_log_config', set via the "merge.log" or
> > "merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
> > 'cmd_merge()' to adjust the 'shortlog_len' variable.
> >
> > Remove 'merge_log_config' and introduce a function
> > 'adjust_shortlog_len()' in fmt-merge-msg.c to handle the 'shortlog_len'
> > variable.
> >
> > This change is part of an ongoing effort to eliminate global variables,
> > improve modularity and help libify the codebase.
>
> And the downsides of this change are...?
>
> One obvious behaviour change I can see can happen when you have an
> invalid value set to merge.summary and run the command with command
> line override with the "--log" option.  In the current code, the
> config callback barfs when it notices an invalid merge.summary
> setting, even though it won't be used because the valid value given
> via the "--log" option would override it.  In the updated code,
> adjust_shortlog_len() would short-circuit and does not even bother
> reading from the configuration, so the user will not be notified of
> a broken configuration.
>
> It is not immediately obvious if this particular behaviour change is
> a regression or an improvement, but it probably deserves to be noted
> somewhere to help future developers what our thinking was.

Oh right, I did not mention this in the commit message. I am not sure
if this behaviour is good or not.

Technically, if the user wants to use the "--log" option, they would
not care about the config. Whereas, if the user wants to use the
config, they would be notified in case of an invalid one.

I will mention this in the commit message, but do you think this
behaviour is fine?

Thanks
Ayush
