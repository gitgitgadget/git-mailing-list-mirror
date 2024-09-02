Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B81CB50D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292025; cv=none; b=DWDiRuR2CqP8CjlFypIwb7Q7agn7GgRBl+l49/VtmLFIomsUJTHf6YHHHWMwgUhrApojjGS1HtNqgMJ2JBx06x/v6cfFA2tDzt9oauJsRO7XTbnr+h+sLm/LiRCgQej3dEt297Fy+nOLpFTKLfbZxF23i3p8FhcaHcSbM7WEt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292025; c=relaxed/simple;
	bh=ueN/ePwwow9FS5UQ4tfHtY1xvAD5P8HJtbC0kfs2R6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVm1qHROpxdRK/DK4cfnynqHk7K9FT0PCarzlbG3WgVZWB3wMdzr4PdICQg1aoseJb0U1Qg3+pW7WtZ3QpLk/5NdfO504m9jUTEEUHve89cPi0SlCLmYdUnwC1/hR/JJWV87QSFcmTQB1fK0S3MmagIrtqbNoWJulOjbfvhx6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVSiwssG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVSiwssG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7141d7b270dso3388112b3a.2
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 08:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725292022; x=1725896822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hj4JMYH+itNGD4J9+wmYmr2pxW1W/x27tlz63O/S1U=;
        b=kVSiwssGObvyp3koBLN/0MsagyXi9RYigL7jD3u8r2zeRjineDig3U8whj4orkCnDB
         69NKgY0tPwselbKZBHSoXO48kTMim134OsbD1Ep7qGnzfJMDZpa3QdxiSyE6t5OP2wys
         uVtyhvg2IMWhV76hwWglr6NksGX45qWvM04g3pLpW3cZOv20QHed8X6POwwRXDp479RD
         iiL67BoPLz4Dgjt367btuN0N4hzP0OD9G514MRRSoa72MEDAg9m+1413AtvfDRYgDPq7
         49CMQXkoqNJuJh0WNMhtQNS3PZ0bWDsGkNWIz6C8VU01BqpfPm3jfgK1g3SQrYBXwTpI
         0JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725292022; x=1725896822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Hj4JMYH+itNGD4J9+wmYmr2pxW1W/x27tlz63O/S1U=;
        b=aen/F5QY3CKDslK57dCI7Ll3FyuZepvqfpYnC4AcXO3rTs19XUm8Y42E95periYqDv
         5d8bAX2Tq7jysLdXRnPDg9B49cvfIXKxg/C/K9CB5Is49bmsIgdR4e2NKtl29AF6qDPa
         cIsoahRfwL4aTS0NIJCDlWKzgnyZmSJknW/fXSnNv/hOUsrD5XgKMwc376lFy3ph8goX
         NmXC+tFIpVTsJKlwuqPpTZS0j0oAwvK0Yt1SaSO/CgL0XqTThGl1U7JHYpv/bO1NtYgg
         MNXNLiBFi4l5LSBPCKvi6tKh7khz1gP8DUk9SfApMFawHkq858hSeIdSfA6PBeGp9tM6
         4q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDJhg1Mttuh9EXb+i8+F4SNgxvGEyxKXSu0tXTLwbInlO3ClII0rVp3T6zIegxsaxq8h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMkGOA7BEiNb0p/IiVzc/wxb4/RQ1rcX/4Urly+RYo4ciFL+b
	Eu0qExMLK/SSoLWmIqOjTac2cW8EAuJX7mit2zljeBiHJl6okoLa46LWK5mEHQPs43UEBqPCDwG
	ug14BtzccPBI6BmrtQGAqE3X28F4=
X-Google-Smtp-Source: AGHT+IGR3pkv9VowFIGBgPdqvJ8nH3kpBNKFTYnFOabJU5R0ady3TL/cI9wqsrpAl+wrscRWSPE85XWpfOXXE3xsJHs=
X-Received: by 2002:a05:6a21:648b:b0:1cc:cdb6:c116 with SMTP id
 adf61e73a8af0-1ced619563amr5189622637.24.1725292021836; Mon, 02 Sep 2024
 08:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG=Um+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmail.com>
 <Zs8KzG0vzCEDvkvx@tanuki> <xmqq4j7438yc.fsf@gitster.g>
In-Reply-To: <xmqq4j7438yc.fsf@gitster.g>
From: Shubham Kanodia <shubhamsizzles@gmail.com>
Date: Mon, 2 Sep 2024 21:16:24 +0530
Message-ID: <CAG=Um+2OQofcfo3vjvPJEAUht5cGg0LnPAx54SWUPETgkRACPQ@mail.gmail.com>
Subject: Re: Improvement: `git-maintenance` to allow configuring of remotes to fetch
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Patrick Steinhardt <ps@pks.im> writes:
>
> > I'm not aware of any discussion around this...
>
> I do not think so, either.
>
> I agree that it makes as much sense to limit prefetches to a subset
> of remotes as it makes sense to limit to certain hierarchies (e.g.
> excluding refs/changes/ or even limiting to refs/heads/seen and
> nothing else).

I'm seeking advice on the configuration option structure for this
feature. The typical config format for maintenance tasks seems to be
as follows:

`maintenance.<task-name>.<option>`

A natural extension of this for the prefetch task could be:

```
git config maintenance.prefetch.<remote-name>.refs refs/heads/master
```

In this structure, the 'refs' value represents only the source part of
a refspec, and both remote and refs can be configured.
Specifying a full refspec isn't necessary since the --prefetch option
may override the destination anyway.

While I've successfully implemented this approach, I'm open to
suggestions for alternative configuration options. My concerns are:

1. Most Git configurations are nested up to three levels deep, whereas
this proposal introduces a fourth level.
2. This configuration appears in the config file as:

```
[maintenance "prefetch.origin"]
       refs = refs/heads/master
```
which might look odd?

Also, hopefully my mail is formatted better this time!
