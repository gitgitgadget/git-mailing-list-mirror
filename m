Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160F64A
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982902; cv=none; b=I/wJIyatvUIrnRrqx/HRuGvWwUFlONKIn/L67FRlfblAJqLxoGenM1UAdaF/o4g/OPTbzj2QOpRBMzxUH18DifRkao2yAUGKRbzaoJLnA0u97VNIfXso8B8p62ECuvcQUV5C6VDYKkhTAgjDDG7ktp+woqmog9QnJe5sipcLCtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982902; c=relaxed/simple;
	bh=X9QSKEpwZaiCFsj1B5VZNpxoPQZKs2vVOsV4ZOENg94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONuRgFI807wgyWmUpSt4nwkx431G/ls1yPJI9ouYUYehLLRUURPBZw1dxqUy30japS0y9oixbIlEh8H95314XfPzB8YY0WoXiwZGL6x1ayD4UaWyDhtwbmX6WTegxqobfCONxVOsZ1TJ1rpb2n8jvQuT7s0luBJ2UtJWqkR29BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLj1eNMs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLj1eNMs"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-561f78f1ba1so549895a12.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 23:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707982899; x=1708587699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ere+cnH/eLmqMrJFjA+95D7N50oh1pwMQe+JIvy4nLI=;
        b=eLj1eNMsw2a8a94eE2qISFtDxYtDKsaNRl/k6wDOFWFLoj2OaMuOqcjSBABYD83plV
         HMe/4Dt+IJW4LTVUCb0JYUDtBvJZdiPN61UZa2lKbHT0RaZYU0S1rMy1dfZX3/aFe2S1
         cxyCciPXJECJgYn74V9PAHmq34mPdc3FZ6iRQ2ciaWYaQBlO4Z/S1wW6kYVVHX3e16Qr
         aTz3oej2Q+QFTUEiofW2pXA4FcE53B6QQ4VfcoKfCC9mnKE6UlTTp+5zR7UvpnWvDGsk
         46CaY72rLcGA5Kckd5247hMqYsbMG0e4tNYZTsUtx9N4CaYfAJmGKF5brA6bNX++aXoH
         4lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707982899; x=1708587699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ere+cnH/eLmqMrJFjA+95D7N50oh1pwMQe+JIvy4nLI=;
        b=uWzYPWPeihr5Yzpb3SnjujYbu6ljqKxQM/LvCZCR71dD0RfXamj7DZGzqcr6Reek23
         0B57/6LrV9a0/3sVunrDMcK3Zi2O5A6iqL0KSDOOPCknWacjmXLutlVp9ibUH9D+PpTM
         md4uqg3pJPgeCp+DMeQetuPldfuOtUPPxOH19TqYYOjlCkLPGYYvC2Sm5mixJr4++UZU
         doxnN4Y2ozgXHjlqHxm7BpReTruWIME7NxK4evQZhdBZMBB8SpY0nqA297yInmCk5fIi
         FSrUJU+zWNi6g0cCMoq307yucAizKopsvalSq5brGHO8k9OS+PZCL55Snkc89vxdwogA
         Xlrw==
X-Gm-Message-State: AOJu0Yw/jZk8BqlPi4YtpVUr+202DxD+cC+1NQDuB35Wx76+uANZO8uz
	zVQaJ5j1+USx9vyd9Ccagwb/Rt1YmENig8lHcXs/DwcQnIVjH+jJVFSeQPiAT5GdqFhe+DSjZpI
	l8Cg9YiFszDGOMGh5dcicmVMFZMs=
X-Google-Smtp-Source: AGHT+IHF7cl9eSlC0mHAyNcIwsszCaZt4bNMLNwTWjz6gdKx6vK60aHBTf2rwbyUiEkzPaPHmZrTaUxVFH19czRT2f0=
X-Received: by 2002:a05:6402:12d0:b0:55f:a309:172f with SMTP id
 k16-20020a05640212d000b0055fa309172fmr860025edx.15.1707982898865; Wed, 14 Feb
 2024 23:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl> <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com> <xmqqy1bxiiop.fsf@gitster.g>
In-Reply-To: <xmqqy1bxiiop.fsf@gitster.g>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Thu, 15 Feb 2024 08:41:22 +0100
Message-ID: <CA+CvcKSpjB6Js3H49yvjNves53STj0keW3BvoREhdnDHzZ7VjQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Op di 6 feb 2024 om 18:52 schreef Junio C Hamano <gitster@pobox.com>:
> Maarten Bosmans <mkbosmans@gmail.com> writes:
> > That is also a cool idea. That would probably use the functionality of
> > the cat-file batch mode, right?
>
> Not really.  I was hoping that "git show" that can take multiple
> objects from its command line would directly be used, or with a new
> option that gives a separator between these objects.

OK, I need some guidance here. Should I submit a new version of the
patch that addresses the comments about the code, or should I this
approach of making a single `git notes show` faster altogether?
In my view it is worthwhile to eliminate the extra `git show`
subprocess launch (while still accounting for non-text blob notes, but
not non-blob notes) and focus on batching later.

Maarten
