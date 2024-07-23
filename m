Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAE13B58D
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 22:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772490; cv=none; b=VAXqgmIY0MgpFcCf5Ref/RiXKHdAlfZMxF+j74ifGdB/KnEvl2qrxSVJ92FE42kDnKuR+KO0taEgDWwD0FirKo9wV08SL3e+S0GSx+aNkN//6qp31/sOdj9E0l3r15pPaIX/lmdw4rBDCUD7UhE91shLpSVW7ifMz1TWFUoMOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772490; c=relaxed/simple;
	bh=NxkJ6jk78UJ/oqyqJK7tI69Cj5cgwAE2wMnTAs/8euk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R18oXFUxQibQE0ADj6tgayV0878tkHel4kv1a6f67zo4bthfvWBO2jy0qx3yKzJ94UuqJ9VSpqE8E4pYmeCDv4FZIlDmkmbWpF0BiV0CN+20s3VOlSM/om0JceTuBa3C9j9IYqv8JLl6YwT9Z/AGNEoej48n2csXWYCW/h/LzV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxZHGq3b; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxZHGq3b"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eeb1051360so61056741fa.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721772487; x=1722377287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ViKzZACtTppugv1YqGLykRU6OLz87wxO6gbQtFZGAVg=;
        b=YxZHGq3bzz/Eur6qnuhlVWbK77M8X60O4bPYT9zmgP9cpUpi6hIErRJgIv6EwYoHhZ
         iG7CLtfmA7RKL17UiUvCt3mCBrk0A9rVHMbnmbSLuy/d/8isSD/UR7DhF1NvAibCpNez
         0S5kmXIvjDf2/Ybdms06p/3O97yA5aRZd+jCWDs5HO94mCZrT5Pb9mww5HF0nxO+e65q
         DQHMg8Xb6eDs81gk4Y9xZCXEZg4DVDdkAMaMPtYmMiYGM5xhZCmBT1llKOH2141SksE8
         Qu1OJb7b6j4F9oycdM25JEKv7WKJhicwkZ3JSSG8ts6h52FkF5lCse51GEmGXxOz+YC5
         b++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721772487; x=1722377287;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ViKzZACtTppugv1YqGLykRU6OLz87wxO6gbQtFZGAVg=;
        b=tNBXUu/KD7oK6+BFdib1sOtnF6PJeKkhlagDQ3fsvSXpp29Al43E8VWUL9I/8Vms3Z
         hEp1lXfw550YS3Fm+sume+aauT28dNrtrtBqz8iGf93iz+TXSxgnZ3sCOxmskOf9aB8+
         K/qsOkGLbZl4I53jawQ8PbVjkII+HAfL2R8vYnd9bJF6Tc1hP1oL1mdVak/X0YwwwJUr
         XdnnRe2AhwcIMcsf7yhGRpWgygg4DDX910VHLKGkye0GQnEO7lpa+nLweTtAZFP3Mg0x
         ucRUYXikzS3shYOWeyr1zwi5A+POWHmZQKzXBexngMfqoBQQsHLmQ2xHvKbNXkF1Ijp/
         LOlg==
X-Gm-Message-State: AOJu0YzO/laTtuhVvnfZXT0Thrynh17qHSjTsssjPmJ7pw4qRDVsoOBp
	8OLpDDEA2VqFS5Adpz+9HE20o3NqOHLoWXP4lTQnxwD7Z0snOAi7smj/Vg==
X-Google-Smtp-Source: AGHT+IEVQhXw5+R3bg8qqZj+KtnYOU8NEDEY1QPGU05mDpqXzMwDg9hTMzJNqFQ4kJ86AffSrWDjvw==
X-Received: by 2002:a2e:bc19:0:b0:2ef:2061:8bf9 with SMTP id 38308e7fff4ca-2f0324dd68emr1447351fa.1.1721772486827;
        Tue, 23 Jul 2024 15:08:06 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f935dc32sm2765005e9.7.2024.07.23.15.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 15:08:06 -0700 (PDT)
Message-ID: <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
Date: Wed, 24 Jul 2024 00:08:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] add-p P fixups
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 23, 2024 at 10:15:03AM +0100, Phillip Wood wrote:
> Hi Rubén
> 
> These changes themselves look sensible.

Glad to hear that.

> As rj/add-p-pager is only in seen I
> assume you'll re-roll with these squashed in once everyone is happy?

Junio has already integrated these changes into the branch he has in his
tree, including a small change to the message to adjust it to his
comments, which I think is good. 

I hope that what we already have in Junio's tree is the final iteration
of this long series and that we can let it settle before making further
changes. 

> 
> Best Wishes
> 
> Phillip
> 
> On 23/07/2024 01:39, Rubén Justo wrote:
> > Rubén Justo (1):
> >    t3701: avoid one-shot export for shell functions
> >    pager: make wait_for_pager a no-op for "cat"
> > 
> >   pager.c                    | 3 +++
> >   t/t3701-add-interactive.sh | 6 +++++-
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > Range-diff against v1:
> > 1:  c3b8ebbae7 ! 1:  15fbf82fff t3701: avoid one-shot export for shell functions
> >      @@ Commit message
> >               VAR=VAL command args
> >      -    it's a common way to define one-shot variables within the scope of
> >      +    is a common way to set and export one-shot variables within the scope of
> >           executing a "command".
> >           However, when "command" is a function which in turn executes the
> >      @@ Commit message
> >               $ A=1 f
> >               A=
> >      +    Note that POSIX is not specific about this behavior:
> >      +
> >      +    http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01
> >      +
> >           One of our CI jobs on GitHub Actions uses Ubuntu 20.04 running dash
> >           0.5.10.2-6, so we failed the test t3701:51;  the "git add -p" being
> >           tested did not get our custom GIT_PAGER, which broke the test.
> > 2:  f45455f1ff ! 2:  b87c3d96e4 pager: make wait_for_pager a no-op for "cat"
> >      @@ Commit message
> >           "cat" [*2*], then we return from `setup_pager()` silently without doing
> >           anything, allowing the output to go directly to the normal stdout.
> >      -    Let's make the call to `wait_for_pager()` for these cases, or any other
> >      -    future optimizations that may occur, also exit silently without doing
> >      -    anything.
> >      +    If `setup_pager()` avoids forking a pager, then when the client calls
> >      +    the corresponding `wait_for_pager()`, we might fail trying to terminate
> >      +    a process that wasn't started.
> >      +
> >      +    One solution to avoid this problem could be to make the caller aware
> >      +    that `setup_pager()` did nothing, so it could avoid calling
> >      +    `wait_for_pager()`.
> >      +
> >      +    However, let's avoid shifting that responsibility to the caller and
> >      +    instead treat the call to `wait_for_pager()` as a no-op when we know we
> >      +    haven't forked a pager.
> >              1.- 402461aab1 (pager: do not fork a pager if PAGER is set to empty.,
> >                              2006-04-16)
