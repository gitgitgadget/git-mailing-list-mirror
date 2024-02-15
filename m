Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178088833
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040079; cv=none; b=O+jMsTyPUq+2FcH4REcE5KE8FkZc6boCvzEbzHyvDDfNRLDCUr5PYbwOyPo5hdpu/LBk2ClNTQiG6V5a2nSA36EgaKTNYyLm2NEJbXfEPKL2sX1kuzr7clxDeBtOL5KSIGvwC6jXLJSlRzORvae9WyLWNq6fEldn5cDQkob/LuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040079; c=relaxed/simple;
	bh=QI5jOLOEeOIfdIJl+GrOxN9U7AY9sbDGMvBTR5hmbtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEKoocrMRXXpN02wkACq9SJljMULnkKFKmzJxp3OXzttMe0nHHJYkkm9KqPDOZRSLlA1Rw9PbfJxaJ5m8+h1ZlIQS8wQnoHQ1Uoa6/V/28mhYQGWUocBr+nB1PDCf9c5bKJijUy3XUkqRvTeFZOnGdULV3nOwoKqkF6lKgngHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cznlFC8R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cznlFC8R"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4124158f6e7so398825e9.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 15:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040076; x=1708644876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+Yn9ZCA8c9Jb029rxWPqe9eVM2ykQOGbQ0q0wM00rs=;
        b=cznlFC8RDUUTNoCtQwkrYBqqdId0yO5RX3+7BrVSXZVva5h/F0XvRryKew55Qq/lq6
         l6BA/kCHCvmj4OTdbUUvZQHAyL8FOVdcljEx/k1JRJOyUyulCwpqIUTPWbAM+H8QqgXK
         FiJT6ftw4r3HE4MUYTnAtjR7p/xhbZPiTaElH3TnFJ+ErVafU2pGoUFuXhz//Oue/PTi
         XppRXjB0vUKNTBIfhza7EEYwzRPpCHW30dATaX44NNSu8gtdDHhZaTStP05E3M4jSC6K
         E3BwdK848r8cz/7FcA0jNo7sDH/zB3x6W9PgkGnCnQVW2ufvQnwmpq1o5xZiBChUH6Y4
         R73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040076; x=1708644876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Yn9ZCA8c9Jb029rxWPqe9eVM2ykQOGbQ0q0wM00rs=;
        b=iA5ZwUey5XgWcZUcSb3CZI4yRhY6DnrefLNymmDGm6JyVIfDOKkfPJylMEQdIkmtKr
         3LN9K39Lvk8i/om0rjkZooX1CDYO5nUcogqVsPkvveSNdJlKLkbYizB/PuuyGPc1glgw
         GTo+XjbDTw4+CbrIrGsPHPKWOhgWcv5yaZaknxhgR6xmJie6OEwr3E2oZrp+MqTeqemK
         tE8lxDZzPjSxSGdB5810W/9TZ7iUevUBpH8ocaNZAb+47MNtlA+wd3yR86V2Tev3ARPZ
         EMBsesw8zIvVd7+gvxHIX6eWiKAOl6MYUGhxtii0dPTlw7mfrDlt65KYDCCs/mQmXw3y
         9wlg==
X-Forwarded-Encrypted: i=1; AJvYcCVjg5coB6PEv5w2BzBSETt3Hh3Lsf3BVorVIDfHIJA0QarF5bAY8LTgMesVDJXll+sGnl13ArRyNFmAfWnY5jxG22K1
X-Gm-Message-State: AOJu0Yy7n3uuXp4w8oWML2m7xdtLUegOkQn2F5eF1fNvhNagZnhPmHJ8
	KvHOWl417+BGTa522QkWRBvWiJMrXnERD37D0r+iTaXfEp71mFGdzTNZByqa
X-Google-Smtp-Source: AGHT+IHcDjz3ELoPlnDGMVFeRbxikuOj/5WZ73dEeanXjYI2g0yj+U5sa+qXj7OsRy1+A7nPKcGXtA==
X-Received: by 2002:a05:600c:1d81:b0:412:107d:cd69 with SMTP id p1-20020a05600c1d8100b00412107dcd69mr2913292wms.1.1708040076085;
        Thu, 15 Feb 2024 15:34:36 -0800 (PST)
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b00411e1574f7fsm523768wmk.44.2024.02.15.15.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 15:34:35 -0800 (PST)
Message-ID: <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
Date: Fri, 16 Feb 2024 00:34:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com> <xmqq8r3lnzp0.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq8r3lnzp0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15-feb-2024 14:13:31, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > On 15-feb-2024 19:42:32, Dragan Simic wrote:
> >
> >> Move the descriptions of the <oldbranch> and <newbranch> arguments to the
> >> descriptions of the branch rename and copy operations, where they naturally
> >> belong.
> >
> > Thank you Dragan for working on this.
> >
> > Let me chime in just to say that maybe another terms could be considered
> > here;  like: "<branchname>" and "<newbranchname>" (maybe too long...) or
> > so.
> >
> > I have no problem with the current terms, but "<branchname>" can be a
> > sensible choice here as it is already being used for other commands
> > where, and this may help overall, the consideration: "if ommited, the
> > current branch is considered" also applies.
> 
> Actually, we should go in the opposite direction.  When the use of
> names are localized in a narrower context, they can be shortened
> without losing clarity.

I did not mean to have longer terms, sorry for that.

I was thinking more in the synopsis:

    'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
    'git branch' --unset-upstream [<branchname>]
    'git branch' (-m | -M) [<branchname>] <new>
    'git branch' (-c | -C) [<branchname>] <new>
    'git branch' (-d | -D) [-r] <branchname>...
    'git branch' --edit-description [<branchname>]

To have more uniformity in the terms, which can be beneficial to the
user.

We don't say that "--edit-description" defaults to the current branch;
It is assumed.  Perhaps we can take advantage of that assumption in
-m|-c too.

Of course, there is no need (perhaps counterproductive) to say "branch"
if the context makes it clear it is referring to a branch.

> For example:
> 
>     -m [<old>] <new>::
> 	rename the <old> branch (defaults to the current one) to
> 	<new>.
> 
> is just as clear as the same description with <oldbranch> and
> <newbranch>.  With the original text without any of the suggested
> changes, <oldbranch> and <newbranch> appeared very far from the
> context they are used in (i.e. the description for -m and -c), and
> it may have helped readers to tell that these are names of branches.
> But if the context is clear that we are talking about "renaming"
> branches, there is not as much added benefit to say "branch" in
> these names as in the current text.
