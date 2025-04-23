Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290512E1CD
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745384836; cv=none; b=G434UswF7BioONbCeIrbb7uo+AqluS7V2yUDFZEbz/mA0C50PBB4MJyABPJOCMmxivCFLLlaJ0K8ZAZ1DIDeN705bmlH2ab4LB4E9qJyQffzlNK7/viH0N+09ETQSJgHffMMdCwbacol/rZbgeiqMmpHrPJMA0cdVWF4TomUpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745384836; c=relaxed/simple;
	bh=YViFIjHn3fqSB6wv2hFvZAcTbnDuOjLZwALrUms3uIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNghQ4R+fD3Y6wYz9IALg9ERb4CsjzgJmD/Ar5RKMuObzz6PEdJevn8mrsZ9tqggx6iIS4Zb7A7yHTBEQjyVbl1kORunG7smRrOUTA+tDQcBa8zH4J9S9JYCXKTtk8bUcVhPelO7nbPdr6ANMppdFbCF3cnZtjgyTFqgFlauMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0SER7ml; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0SER7ml"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso3915a12.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745384833; x=1745989633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJZd9J/RpkBhvHl2DnMHOQjpwc0BbRJ1bdkZGkdkr80=;
        b=S0SER7ml1ZyYmiNQSOyMiwZ67ACdgPYK4avaEzqjPpjY/ZKy81772K401EWzQM8PVg
         a41cmUDH5C67zNsgCVKmO/76mbr2122r3+p0670kblYjbJWjqxOT+U7K8vpDK0R9NYvg
         8foAFDyVzX+SE/o8QJJRm6UJMAEAPonYzp7xG0cbm4ckXZHFArr98VNbMDuFf+pQrDOF
         PEYk6tT4nMrzmny1S0rc4uEt/BnDTm2v717x9OsMf9CcuBoMDWRSCRGJadwj8H/lDXiL
         ES7gH8Qwlwh9ZGYmSyySOKnpmdXMHKBYD9P6lqF9C95gStQQv0FUDy59nKnD+dNBL5Aa
         YE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745384833; x=1745989633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJZd9J/RpkBhvHl2DnMHOQjpwc0BbRJ1bdkZGkdkr80=;
        b=NzM+GfL6vhVEIRe3IqORxnl/wPI9H4NNAESxpjBH1DMu8nvQCVs4I3qL78GBsnwpvj
         7J58VbLEvHBRoZj4QdD/YgwI/J64EvUOJqaPRXdulLkDx6CMoZGzwSwYtnpTz/gtmkNk
         2BrqB2pEE2p3p54TODS+PRrgaX1F9HiAmXAjuTrIXyXRdny1IwgePwWkB8UF1NsRai40
         R9Ugra6KmD2TTT2hAqknRLBQAIP2h23g8qpgPWDT6b7i8Jh9FtjNZciklysNUjkMa67u
         oUZMx4uNXR4HBD+nyb7utgNp04BbQ5XmQRlcQhd6WCQTOzwxDoLsx3AEXQpRmPu96Q+U
         fkHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvcW/8elxTFl9ATDPbcKJDLfwVOSo0kzZGTMdsQjjNkl4sTK5gHmKWSQLrW4ef/YU6XzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QAnY4fIDJuaGtewIvA9exxPAd85ABm4h9Pg63dDLoPN/BlkH
	868lEmnMkYQ2jmvKUoXJfct9CMu29qwhTrVgP3tt5zg7rejws/F/e+9mq8e1Q5byHmfavyqGdah
	E3fyumGWq3xAmtkYzI5hOB7+/FOcqGRVTAhdx9IXJ1Fn9xICkEw==
X-Gm-Gg: ASbGncvw/s0xCn+xn1s5VQZxwgKcGrjkmbMEJAg/7EyMb6P1MRG9h4y51C6RTJBkfu4
	TLhumEpgD806+lB6Aewo6+3mVVE7bX/IIZIW/6Fi2r0jscrxDO3J9HMyS5CxUP5R0NNPMOCmUwJ
	9/M6HSS7hZUHKdM3f/0aETUg==
X-Google-Smtp-Source: AGHT+IEhuuEcDEvxpy4ehPdt42lgsHI70KcybUJXsBPCVU32itWI4XVIHPw4UcMdJlRAbOYUQhQQuEj0Aee0jg8JsKE=
X-Received: by 2002:a50:cccf:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5f6cac3c202mr55989a12.4.1745384832683; Tue, 22 Apr 2025
 22:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
In-Reply-To: <xmqq8qnr3jji.fsf@gitster.g>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Tue, 22 Apr 2025 22:07:01 -0700
X-Gm-Features: ATxdqUEhTJEZiefgi7pWx0opabX3NTK0PBoxTLKBifYJgsiTB5xxIj_HpoZo3S8
Message-ID: <CAESOdVDG_tfrWMvV6V_Ad76EqXU3Be+EpJDLvtgPcfCRHoJoYQ@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Junio C Hamano <gitster@pobox.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 15:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Remo Senekowitsch" <remo@buenzli.dev> writes:
>
> > Btw. since the thread was started, the implementation in Jujutsu has
> > been completed and I've been pushing commits with the change-id header
> > to various remotes for a while now. It works well. Forges can start
> > taking advantage of it. (I hope I find time to help work on that.)
>
> It should work well, until somebody finds your random is not random
> enough, right?  Unlike our object name that depends on the contents
> (hence a duplicate unless the cryptographic hash function collides
> means they are truly the same commit), there is no grabally unique
> ID assigner involved in your implementation, right?

A forge can decide to enforce that no two commits on the main branch
have the same change ID, for example.
