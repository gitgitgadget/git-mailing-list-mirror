Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB699366
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478445; cv=none; b=fD2Px2a6nihmRZJlkj8h+jPLann+jv7XqIR35XXE93UPZOnK4cUSBpLZz2UkZdvizJd2ScVvg6/9vh3VMMMWJrvGlVXQGQ+5uaF8ClzaWmN5VM+MtID1h8gFlP5XWlYbBmQlynF1aDV5aEj4jjMwODaOO4IEJI5yMAjaEILvCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478445; c=relaxed/simple;
	bh=Yx5EqENN37kWhQ9ywI+sObAB/+BSm9PCC7ptqiuIqko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BukJbged7efmzK1r4xXPlQP5TAOztjsjmavKIPHGMRpkzCb/9rZvicSYtuC1c9olNzVgaNaE/XnzRMqrwONqiBxs3Y2tcxud06vKBNOw/EKp6uLUizmhzSliugmraU8IdJDIZzWHroHCQ++NMZqdCUoJ59VUVLPqmB8wITT9qJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWn9TJ4p; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWn9TJ4p"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41490cc034aso3710365e9.2
        for <git@vger.kernel.org>; Tue, 26 Mar 2024 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478442; x=1712083242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykPDZXJp9eJ1kq3nF2rWZYklUsor2+GUGVlMuG7fHXg=;
        b=mWn9TJ4pc8oUPt9bgWDQFnGgtxVBCGmdkPAYFJwn5FQ4RYs97MxENoSQKIh7DbeeZS
         pE+dB2zj3qUVa9QrikXfwoC6A0J+kcgJoOJ4lKm52PhJwLQdokpYcLFADi7ELHe/oZSi
         odyZmATY3aCayDyxqIDvaTAeiaT3E3D8DKNX00SRFI7HlxcE+2ELNguj4yzohm4cih80
         CZkSdXbXg1F3e04Qqd3wrkiCw2ATrW7QQL8BZsiPzustp+mHko6+Ay2/rAvvhndocxCs
         meDerHplC8/UBzkXXPp4q0i6Lk4IJwoPwpI3A6rrWXhRDgdDmIB3jcLQi9Y2vIWVfjhp
         sceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478442; x=1712083242;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykPDZXJp9eJ1kq3nF2rWZYklUsor2+GUGVlMuG7fHXg=;
        b=b4ZhrijM/oZN2eXCLKFMY3w2SbMp9uSuJZrphzOLUNSnuu/Bzbe7QZ0cYiYTomSx+g
         lpV+MD+BaV+/LRXJTdsVVj4BmJoFyOar+RcLUs42Hg6yDgmWKnxgBQOREyGGEhHUFeTX
         j3tS0lJ54kb+P2DsWYM1Ic5+9HGgkyS3QRI8ZKAEMPZ2r2xzzil2ZwKzliPTY1BH6/9P
         Kt9tlpI5R5aCUYfOBdLkiyB6IeH0tafAqhF4J/JH2uVMxeUQkYo28TJuhvPZLYUy//3B
         xKrcgXrw4UCMaX4h3CAqFrVi+k+mC0CQwxqVp0RtzkTx1Tpe4ApUI57Pwbg5ss65V14+
         ygKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDaUbZt5W59EilGt7BczGaSqIFE3E8IfIaDd5Vgr2NDd6VbtCRWbezUMBp01MzP7rWxYegctoPDEk6kf5dsvbvG7Le
X-Gm-Message-State: AOJu0Yw+PpcCyjStMlIJaFcjOfsv55eLvl7VvB53Df0gxX1NCripjQn3
	jOiKkvm7EVOYKCUHitlezVWMwM5q5soCWozAaum0VdbaQgozQphU
X-Google-Smtp-Source: AGHT+IGSlZMB76vb7HJn4odvSjMwtVCi2QS5WiNqxAQgox3q7I0kdAxXSKKDlIB5ARXkR5B+eso8kA==
X-Received: by 2002:a05:600c:3c8b:b0:414:610b:13c3 with SMTP id bg11-20020a05600c3c8b00b00414610b13c3mr1712265wmb.27.1711478441684;
        Tue, 26 Mar 2024 11:40:41 -0700 (PDT)
Received: from gmail.com (156.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.156])
        by smtp.gmail.com with ESMTPSA id fl12-20020a05600c0b8c00b004148f9c5822sm2213749wmb.22.2024.03.26.11.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:40:41 -0700 (PDT)
Message-ID: <e54ebc35-6946-4e63-a54f-fd73df0e89bc@gmail.com>
Date: Tue, 26 Mar 2024 19:40:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] add-patch: introduce 'p' in interactive-patch
To: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <34e027d3-c351-431b-97de-e15a2d5a9756@gmail.com>
 <13a9164b-6ff8-43d1-bbdd-032cd2581034@gmail.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <13a9164b-6ff8-43d1-bbdd-032cd2581034@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 26, 2024 at 02:38:02PM +0000, Phillip Wood wrote:

> > Let's introduce a new option to allow the user to explicitly request
> > the printing.
> 
> I wonder if we want to hide this option unless we've skipped rendering the
> hunk in the same way that we hide other options that are not relevant to the
> hunk being displayed.

You've got me scratching my head.  Do you see any cases where we
shouldn't offer the new option?

> I also wonder if 'r' for "re-display" would better
> convey the intent of this keybinding.

I'm more inclined towards the 'p' because the verb is 'print'.  Does
this reasoning make sense to you?

> 
> > diff --git a/add-patch.c b/add-patch.c
> > index 68f525b35c..444fd75b2a 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
> >      "/ - search for a hunk matching the given regex\n"
> >      "s - split the current hunk into smaller hunks\n"
> >      "e - manually edit the current hunk\n"
> > +   "p - print again the current hunk\n"
> 
> I think "print the hunk again" is clearer

The word 'current' is in my proposal because IMHO it adds value making
explicit what we're offering.  Maybe "print the current hunk again"?
What do you think?
