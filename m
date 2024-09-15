Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8714286
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409209; cv=none; b=knBqUQOfEhzZmvFebi++4iddfiYF+/JPoK9NV0jgPRDK2E1evbyBYxGJmt6v4P4neJQmG8K60z2/WlcqmZKAzHCa2FDRWn8C7lderzCS/gJQez8tbbfhjcQl5IYwW57j9qGwtP6AIWNjK5/hjgrSaXnH/187LFbjk8dSgiq3W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409209; c=relaxed/simple;
	bh=NOTxi/h4D2zlRjZnF8lbDbqvOVheadHlvDD66fqV0Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV3diVw7U+aa5ZwVmvR3RF2KgfTpCYOJVJ2GWuLZ+1BJDLvh/M+t4FiImghbUZNqzjoRVYaNWremNp/LkSV/qnkwEm3W5buSbO2clgEcyPH5XZvCQ4xiPaR9jIdEiH8O2TFCvs809TR2UfGuADVVhWxVu15YS82yS7jNQF36jCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKSf0hCy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKSf0hCy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso1677346a91.1
        for <git@vger.kernel.org>; Sun, 15 Sep 2024 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409207; x=1727014007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9/VN2lBTceQANZWhevStUbg1O32Ykn1YyF9ecBRHYA=;
        b=jKSf0hCymRFCq2sSfla9ZSwJN17eq7UmjltNsT63WOPLO57UjVfDEMfazd5P465vyK
         nqzDE7msPY7OMA2WqzFaQOI6phMQnfWQzNyGZFEw45tP06nHMyLTdEkSy11MbjsTCp1X
         0lp1V7ZH/lsKfAH04JWvdjzqerF1/zLfWNi4qEvDc/jSqrsYAmoDWqMvhVCiO5cfAicC
         VhCxdulMJ+WuwxKorTRoQTJuYPyWUXZPxxIA5kVCJVqVJ71IPASTCh9lMN+Y2zVtVE4K
         If8iaE83kqFWHwtnQ83wju6+ALEzixSwKQgLk8cy/JWT82Snmqw1h9muY7oZOobOzeaX
         ukOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409207; x=1727014007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9/VN2lBTceQANZWhevStUbg1O32Ykn1YyF9ecBRHYA=;
        b=Rki4iXx9qzTu5o348yXx+a/8Pa/6jzCNIsV5ubfm9gdR4fea+o1ybEy3Bgh0TBNgKB
         R+EU5rbnJEwq1iZq1xGVhDE0SZno+h04S3b8OVrAsLVIOz7AhW/tpTE6EPkpBNWjpeed
         TZ/iteC6kj4Kmu3TqFmCINr/IBG70Vo5R3gLTGOMx4yS4yJ4rPyA3O+RAd190gjGiiNn
         JgsIhEpfmzeihcXH2z00tlXfoHWLF5Vxnp/xl16Pjg5a0F+5VFBSvezYgrgRT/2qzpzq
         ioXRqnaKwvSKJKuyM5wmMYcrWajWgWMTWA9RFNCOzo12ScbIar4Tlap6AqEi91twxM8i
         jC7A==
X-Forwarded-Encrypted: i=1; AJvYcCVrndOBhCYTCDgPmQaGRqdUttDOZXWGru4/kFjJxH1hkStMGzLtxbH0gK8DplJ6CywC13w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxaap5IrHKhWqGQGy4kHsg3csyVzYGLAUtRvMugmY6q7brrq2D
	f7kcoRTxepUXfSCViF797tZAXLPiMPBxCAIpWZliYAk2AvwZaODKWG+JKIcfa0Ibz0ACCOvrLRV
	Fy3sRic0pSOWT8uqcLt5VJOx+ysU=
X-Google-Smtp-Source: AGHT+IFaqJLnzCGqlk/XR6vE6YB0s7KFYOvvGnIY2ouvzUED/eF8a/hGswtFJuZk7Aa9qCiCOtj8XK5uKQ34+TzFoYw=
X-Received: by 2002:a17:90b:4c05:b0:2d3:cf20:80bd with SMTP id
 98e67ed59e1d1-2dbb9e1cf4amr10193906a91.17.1726409207160; Sun, 15 Sep 2024
 07:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
 <xmqqzfogsrqo.fsf@gitster.g> <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
 <xmqq5xr4r818.fsf@gitster.g> <CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
 <xmqqplp7ze0h.fsf@gitster.g> <CAG=Um+2e7kSL8wGFJcJtFAJt8AxyNwpemJNnxDNfsrm1SVVw1Q@mail.gmail.com>
 <xmqqo74qro6f.fsf@gitster.g>
In-Reply-To: <xmqqo74qro6f.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Sun, 15 Sep 2024 19:36:11 +0530
Message-ID: <CAG=Um+2DiQswQr86zhT3_quO3eYH8EBpwVNQir_SvMWwAsPk5g@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 1:41=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> > If we're trying to determine if a pattern
> > (remote.<remote>.prefetchref) is a subset of another or not
> > (remote.<remote>.fetch) (to not accidentally expand the scope beyond
> > `fetch`),
> > we'd need a function that does that pattern-to-pattern. Are you aware
> > of any existing functions that do so?
>
> There is no such computation for this application.  Such a
> computation might become needed if you wanted to complain that the
> user gave .prefetchref pattern that would never match what .fetch
> patterns would allow to pass.  But there is no such need.
>
> You will first get the advertised refs from the remote.
>
> Existing logic filteres them down to what matches configured
> remote.$name.fetch variable.  filter_prefetch_refspec() may further
> reduces the result by removing those whose .src side begins with
> "refs/tags/".
>
> Now you only look at what survived the above existing filtering, and
> further narrow it down by picking only ones that match the prefetch
> condition.  If the refspec that survived the filtering by the fetch
> refspec (and existing logic in filter_prefetch_refspec()) does not
> satisfy the prefetch condition, it won't be prefetched.
>
> Since you are using .prefetch ONLY TO narrow the result down, by
> definition, you are not adding anything what .fetch configuration
> would not have fetched.
>
>

Ah I see =E2=80=94 I assumed you expected all filtering for `prefetch`
(existing & new) to happen inside `filter_prefetch_refspec`.
But that threw me off, because `filter_prefetch_refspec` doesn't deal
with advertised refs from remote, and only patterns.

Let me know if the diff in the following mail is closer to what you
were expecting?
