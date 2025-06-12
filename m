Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957782BE7AD
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750982; cv=none; b=cARxon5Y9N+nYSgp3O9K5yxU7bVCdy5D7uHIU75FKF8W6c0Npt/eNVRZl/k1AYGOK84pWaQLQWB6EgjVjiK144Y513oJmh1ax+zK3uF4H7pGwyWPnF8TvKoaZsbbf9NoAmZT989Ir7GHKx8xm9SiyxGs12yZVPF5zsItpQZOTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750982; c=relaxed/simple;
	bh=IKKEsel4VqVHERdOSUACnk531xJRGgDvID/KWkO/iUk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g7F/6I/mOncMoM0bOdr+1682Ae9SutpguUEahFil/D/KV/aY4/j1R6boFPjAZQ33/Nj4mt1HQPx7G6WgAUNfHPX38B+REwq0Ifx3U/u5QjiOwfiVoBeiQmBISoERKRoBgl/bzEdK85BvzPRwFsLHs+6J0po3MDaTLw5R9b9jPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+CfGMBQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+CfGMBQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so1091253a12.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749750980; x=1750355780; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8GQkk2aB4NQWlzRCXZoCs31J4kTadABFZlcT7nUPrc=;
        b=X+CfGMBQPk5K2hlXv3eXcJj4uv5xxzb8Qn705ABrQ7x5XI4QDIN5zudFloP5OWc1jD
         KxY2j/q48fGPjYHQacD9kLnmNf9itduZICJ2gZ6SdNO8ChMOctaHydcThsutJ1zkYPi4
         H88IL2yQ8cqtmQrXY50SsEr8F55d3J8BaoYcL3c+4VLkdfz6U6OC81H89+730iJV7GCK
         0vlWQOOLQkV+qo3i2xsV3RWiVYZm1N4r4N5lpZCPrxjoLAUzDZ6CKzqvRSmN163bZoV+
         pslLTLq61JD2waUoFcMolyy0Z/YvBt1+vj1l+s/zXL6eyAJecd2E8he+csRLTehbCZ3L
         69XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749750980; x=1750355780;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8GQkk2aB4NQWlzRCXZoCs31J4kTadABFZlcT7nUPrc=;
        b=t0k0lOhZ9x8YhDN19U8J8BY4rdZ9AF27+4dqIf+LopE47gA8hs7rps/yp6i9hGupSQ
         vOau0qWlmXdcbxEGn7f5MroMwZZD6C2OogFQ73t1zu+N/ZZbFDR9+qZlaHO97rQkWJi2
         TC8HOk7oI3WWefI37Xy1Pdpbn3XzM3rdKpuQxgyP8m+QGyvfrtGsOoo1wzyzATlUhfFy
         f7ws+Nw67I5DFXypDzpq4CN75nLQiQqzexwUkEqr2an2/4XSPRC7EIM1SnMGIqAbC2jw
         tmJO8i6NKTqr8brZM0LASG7VTcnQyAJ95L2qAg8Ut5Uf5NR6XvQRvY1+eR+SLdXuxUGO
         8yHA==
X-Gm-Message-State: AOJu0Yyxlo3mE2AunmUhlXymL4mRSjXKGQ66LfHddghBSMKOG4TlWcGn
	aU6owh3QC4yeLiThi7Y53dosTD5mnH0bq9vleIrECJY5YAOoZNkLUJey64P+qA==
X-Gm-Gg: ASbGnct2osch7tBH4F5KLAlGgmkhmOVAAtemNIdfjnyP7MprTfQqhodSt2vzfgBDP1Y
	ouxMbrHJ06maNAlsIVuPMF0gUEQgfKA7AU/m1/Pm2VEnGcDjoqBcy77Qz/ed31vUH9o0QQcMyvU
	xaMBxM40F0gsq757Ud9dT1o2qTV+h/zfCvaOJrl5f+fZ592+/yWbvn4RFy1wGDw33ELp+8ekYOw
	rZ+/vrUP40xVEfvBJ/Lfk57QPt+2GeIDtkuw3W1RDhFx9ui+f5RrjVigyKO+f0abz3E508Hv9a8
	9kxz1I3euZGh5763RiCn95aFbe/jZacijD4yWhVH8jPaxK24OyKZrQiqvUsIzLv4jlRcYSYqyCx
	H5foTG7BJcTrwBUQ/VxOx
X-Google-Smtp-Source: AGHT+IHKKhkybjlLqcD+xdhj+WfWhSGKgF4xlEPNz2l2ZhXgGHJSLekw72D6xXZ7aK4Hld45MqzcPw==
X-Received: by 2002:a17:90b:1843:b0:311:e8cc:4264 with SMTP id 98e67ed59e1d1-313d9d7ba5dmr177280a91.12.1749750979716;
        Thu, 12 Jun 2025 10:56:19 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5fd7esm1774198a91.37.2025.06.12.10.56.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2025 10:56:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH 2/5] repo-info: add the --format flag
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZRFM5ZVyBfbpYjePN1c+cVBTfU-nk+hsQOGt5e1CJ3EXA@mail.gmail.com>
Date: Thu, 12 Jun 2025 14:56:05 -0300
Cc: git@vger.kernel.org,
 ps@pks.im
Content-Transfer-Encoding: 7bit
Message-Id: <5115663C-0F90-49A2-9925-389715618580@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250610152117.14826-3-lucasseikioshiro@gmail.com>
 <CAOLa=ZRFM5ZVyBfbpYjePN1c+cVBTfU-nk+hsQOGt5e1CJ3EXA@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

>> Also add a flag --allow-empty, which will force the output data to be
>> empty when no field is requested.
>> 
> Why do you suppose we need this, I'm not against it, but it would be
> nice to state why this is necessary. The idea is to have a default
> output when a user runs `git repo-info`, so I'm missing why this would
> be useful.

I was thinking about use cases where repo-info is used inside scripts.
A simple (but kinda useless...) example: an application that is a GUI
for this command, where the fields are selected in a checkbox, calling
repo-info with them and then displaying their contents in a dialog.

In this example, if no field is selected and there's no validation in
the GUI side, the default set of data will be retrieved. With
git repo-info --allow-empty, we don't need to care about it.

But, yeah, I agree that we don't need to think about it by now...

> If I recall correctly, in our previous internal review, it was mentioned
> that since we use perl here, we should add a PERL pre-requisite. Similar
> to the one in 't/t0019-json-writer.sh'.

Do you mean to use a `test_lazy_prereq`? I'll take a look on that.

> As of this patch,
> 
>  $ ~/code/git/build/bin-wrappers/git repo-info
>  {
>  }
> 
>  $ ~/code/git/build/bin-wrappers/git repo-info --allow-empty
>  {
>  }
> 
> So what differentiates the former from the latter?

In this patch, nothing. I was only trying to keep the consistency
of each patch from 3 to 5 implementing only the code related to the
field, but it seems ok to me to squash this patch and the next one.

> This is because we didn't implement plainttext no?

Yes!

