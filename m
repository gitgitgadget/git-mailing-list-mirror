Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158314F90
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703820; cv=none; b=ixi12a3dRF0AxSvjyD5MalFWI+luJx3o0IYgVm45rwSH4T0dQP7eaRs8m+DMXhdust2NQCQnFwnYnEbb2pJ3VsxU5KxKrwHcBFTYj2p0EwvaimKlzCkQwOdG76QUYDOAPmgr7bkXBi2SJPIY5u2qNfq1I4IqLKgiQz4W4yo7xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703820; c=relaxed/simple;
	bh=t8+MktNRIvBTLeyAUNSkHadYwIBnqXgtnF6rlZjhlIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDlppOaapXhnHn4cCDx2N7pHVkmdNMWoLtD8Nhl5qY5g9WOJPON1QohcOGxk2KnGIXiSABtHVuqKtFjFKEyZjuei5SZzvlJl/BZ8gzNZ/zi2Wr8q+QtSgd1myrhlsHRSHAes7YE0buXvFIg7zqqDv/4DwTi8UEnROcSJ8LAepZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LmajdkRl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LmajdkRl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c803787abso18119335ad.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728703818; x=1729308618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8+MktNRIvBTLeyAUNSkHadYwIBnqXgtnF6rlZjhlIA=;
        b=LmajdkRlojlGYvceVddPFsd8nyLAvi9eqpj74tspiKdu6qPk8ENWHmBSjsckXowkB0
         PwUeu6ntz8u2FlD0WWMElE6HCt9rVDEl1+9TDBBNCstHJ2TDM1UfeQ9rND6yG7M8WbfW
         P+rRKFrvNsT46lbPpa9u+5yeaAoXDTK5H7Jrc/ebMuwLkfC/qy3okaEd7NQV/Q55DudT
         FhKDMDLGdJ6bjzQivwgdwlBDiaUrUuu264Mto0UGE5jqt6eI86ZLNmZBejy7tr4upRdt
         CepNq+flerLw94KjAZ0wO3nA+0dTsBtyJmiY+OlgMYK01tMvzVgZOcALiMDZyuxo008/
         Q/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728703818; x=1729308618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8+MktNRIvBTLeyAUNSkHadYwIBnqXgtnF6rlZjhlIA=;
        b=iflbUJBZFH9IAIxxpM5Dbiw5AbQeiJbGZZCIAIH1mokwyZj8uLa/m2uKXAcbFI69/I
         G48DixNNECbt7YHA3Dn+uqjoDswEhEdaLm3ka6vZT1EyPfZCMCTOE/w9CBfQ9ZgXiJ9h
         ddqW8ZxiGkkL5SA0umc/w0uSs9MlFabSQiB7eFStZ/28TbcMaNFw0PTpMWdW2aAdINcd
         AoEr2mABxT4BvMxdaAwDK59VJYvnyt7cV0o9Csm92zNEPu5MXPiMG75f+blXQbDc9XM+
         WRCDq2A2ErCGdbqpYl9hx2x7JcxwmpiLgXmnMfDZjixHX0EkO6SWPziMy9xnndlheEmG
         MOUw==
X-Forwarded-Encrypted: i=1; AJvYcCW/baClfnNjQYcjAScJ2KYF8DUudsmC8PXv/U/BtGpEs0jbjhGoXAV9uDjzicbuePvuWu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0BqoOHnm60Kaxw9lqmvJiX7WRioX/JvVk9P3jn15QdLa7A26v
	cgPesFWmIV6Yr4rlQC7TlmTrzpR+LNdKCByF9muxDwbtUs4WI7UKrF0A1e1ccRvCKWdk0sGhE1L
	3BYFPsCnN7L4bWztxnPDw74vFFAnbIZsh8VsmiA==
X-Google-Smtp-Source: AGHT+IG99n9sFJi+P8I5FKlPVAb3881fZ0FHjvGw24wuWub6ANfe1Nu3plOFdqQMJBJqWwLgYH2uRiU+LMGDQImGfcQ=
X-Received: by 2002:a17:903:1104:b0:20c:5990:897c with SMTP id
 d9443c01a7336-20c8051483bmr139677725ad.27.1728703817958; Fri, 11 Oct 2024
 20:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009183455.164222-1-jonathantanmy@google.com> <20241012020512.217383-1-jonathantanmy@google.com>
In-Reply-To: <20241012020512.217383-1-jonathantanmy@google.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Sat, 12 Oct 2024 11:30:06 +0800
Message-ID: <CAG1j3zFFYcwYg7b9_xGRGHAOHm+qTHY=WpngqtJCrmDznhD+HA@mail.gmail.com>
Subject: Re: [External] Re: Missing Promisor Objects in Partial Repo Design Doc
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 10:05=E2=80=AFAM Jonathan Tan <jonathantanmy@google=
.com> wrote:
> So I think we'll need to use do_not_die_on_missing_objects. It does have
> the weakness that if the object is not supposed to be missing, we don't
> inform the user, but perhaps this is OK here because we know that all
> objects we encounter on this object walk are promisor objects, so if
> it's missing, it's OK.

And I think users would prefer the git command to succeed if possible,
rather than die on the first (noncritical) error. Maybe show a warning
and swallow the error?

> In addition to do_not_die_on_missing_objects, we'll also need the actual
> code that stops iteration through objects that pass our "best effort"
> promisor object check. Probably the best place is in get_revision_1()
> after the NULL check

get_revision_1() only does commit limiting though. Some callers of rev-list
also do tree walking on commits, in a (corrupted) partial repo, tree could
also be missing. There isn't a central place we can stop tree walking,
callers using this feature would have to implement "tree walking early
termination" themself.
