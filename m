Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404F18BC0A
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439704; cv=none; b=Ykz93McE2o1pV6pWm8v95x9oF/BGzLmw4Pc1Mu5NEcImYmGstHe7YOp3PBXHXwUAHSFl/H8rNHc8akCtCNrYeFdE3cocipV7AaaoWVODbMoyJPzklllSfkxI8W2lKNRNG6oneH02bre9I9dqV5+t48rExWIKY6XRTinHEfN9Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439704; c=relaxed/simple;
	bh=wxEgLl/LAJtGMzMhAtBM/aB0z2qLDKiydQlK8P7O6ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLKjki00Z25EvmTRaF+QagUnxFMp79VCYtM5pNqlS6EyIrJbbcmufI2FFZOe4/+l2zjLZt2IyI3re+dFx48BcWc2mLHFkmpcTj+Mj8kiVyJagKItS/yIhEknbS+l1PdVY0bklfvHJlBbt0WYvqDgR2YOqP/1elKvmJZ/bShHtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L61CPZjI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L61CPZjI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so184519a91.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727439701; x=1728044501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2QfJhRlgZTnixZUh9hSi9ORy2TV4zWtREtGol+iHuk=;
        b=L61CPZjIGd/8Jco887xoFzndI2n3Fq1LeSJjycS6zpGOY4Hz76uC09410FTRlhRzTL
         hk1OpyrfZPr+RzDWD3bgNwcrPlXEyZ+lHxCOnx7aQ6hWpxgIoxGbn/Ymma4XYGyPoZa7
         2i0X/9HDdoWuUuJbMyse6YNqeaP2q2Gu/5gXTlq3iWImExASpwNlmBNpTmE1H5TWvf6u
         KY2Nn6Up7Db5KzgBu3BI3P1fAlR+HvZaqIsdrPBMEBQPqfMMh3/4RUxUbZSp/iwldohw
         gA0UPI18NXkv0ulwlZY+jxSluvQXjsXr6DZ8U+fUu8Q5YQsOcPVd9b2LE5y1DZSJHCVU
         9D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439701; x=1728044501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2QfJhRlgZTnixZUh9hSi9ORy2TV4zWtREtGol+iHuk=;
        b=noNzkl4/uymLMDN/OzShzbRyINX2oEwwsnNT/ntpBHKKN3Hgltz/hN2XtuD43Paudk
         BA6UG02eDjKE67+sr2qY6UY62sCwcPYT0CX4qWnbOo+c7rpwSyY/bjB3feXwamIJHhHo
         R+0R/AJLgK/s+qxIG+N7/LAtVLFscXL5ZvKsTX1Ddp4hCHpb15XjuA7n6CCAv/fpcBwb
         RtypDzxh8ePsuRLyxircMmlPiMFMpBB8lDIKuk8BwhavwhJBtUE+1jcAYyzeJd5JrAtU
         3xIn3YMJ615n6H3h9fza/gzu8hfUPVrIMwoybU0rceUShAfm/DQ9FZh+21sB3HzSB/OY
         pA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3ENk1P4nIwzhHF1rot9hK1kLyR20BN/nFIHnXMVvep5KZGor094eultJc8ugs2jjT+mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObPvb1zn2ynGyaN0YTHsfowcD8eSRjSmYsCgg0Q5UobsQm3hm
	0uGEpKOadqqB3Hf/eRUYEuWe2SBtW1Pt7MuD1G+0jSjkGxUbheNwAZAvc21rRSwSJc4K/mBWTC2
	PRuy6xL8Ng7QMThUxFkFkIN9WfBc=
X-Google-Smtp-Source: AGHT+IGDcKPbECoNVE8LL8SpxPSK0UiCJsRTqb+lEwm5mBUNnMwyDss+NCKWfJck05i9sqzQdzogsowHjbr7z4pGF+U=
X-Received: by 2002:a17:90b:381:b0:2d3:c0ea:72b3 with SMTP id
 98e67ed59e1d1-2e0b8ede4b6mr3546070a91.34.1727439699525; Fri, 27 Sep 2024
 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726489647.git.ps@pks.im> <cover.1727158127.git.ps@pks.im>
 <f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
 <xmqqikulugwj.fsf@gitster.g> <ZvVPiIzzLTTb75b8@pks.im> <xmqqzfnul7fg.fsf@gitster.g>
 <ZvZCdcpifMpmKajx@pks.im>
In-Reply-To: <ZvZCdcpifMpmKajx@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Fri, 27 Sep 2024 14:21:27 +0200
Message-ID: <CAOw_e7YZNUa_Fu58C73kyc85f+_1Z1ew3p9=AekQGiqmXeQK5w@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in `reftable_calloc()`
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Edward Thomson <ethomson@edwardthomson.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>, Kyle Lippincott <spectral@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:31=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > The dependency to "strbuf" (just as an example) was added initially
> > fairly early.  Soon after 27f7ed2a (reftable: add LICENSE,
> > 2021-10-07) added the reftable/ hierarchy, e303bf22 (reftable:
> > (de)serialization for the polymorphic record type., 2021-10-07).  I

For historical understanding, these commits are meaningless because
they were a bulk import. You should look at
https://github.com/hanwen/reftable instead.

> > somehow had an impression that reftable "library" started without
> > any Git dependency and then use of our helper functions seemed
> > through from the shim layer, but it was pretty much part of the
> > library from day one, it seems.
>
> I think the history goes a bit different. Initially, the reftable
> library was developed completely outside of the Git tree in [1]. It did
> not have any external dependencies and didn't use any of the Git code.

Correct. strbuf was originally called 'slice', because it was a direct
translation of the []byte type in Go. I renamed it to avoid offending
the sensibilities of Git reviewers. See here
https://github.com/hanwen/reftable/commit/06d9728b4fedb9ed996ac1ae48343e387=
9114e1b
. It was a change that made me a little sad, because the strbuf type
only works with explicit initialization (STRBUF_INIT),
which means that every struct that transitively includes a strbuf must
now have a XXX_INIT macro. It just required 12 strbuf functions, but I
suppose more have crept in over time.

> The difference here is roughly 100 to 200 lines of code, which I don't
> think is much of a maintenance burden by itself. In fact, we'll even

I think Patrick's plan is sound. The amount of code to make reftable
work both standalone and in Git is small. It just needs some
discipline on both the Git and libgit2 side to not add additional
dependencies.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
