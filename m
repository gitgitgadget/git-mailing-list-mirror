Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3DB10F4
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483211; cv=none; b=Y4VVrhPrkkIFO3oiK/LHduz4XRt/Xodbr9g/Y9JrjK3Vz6SRzxE/visASTN7hkaXZ8k2VGfayLM3lAdWW4VyoPFFW7D2z6TG08kwJKK3Odf+5JNsNuDV8AzGbqTSiVhOhK1kMVSEeaxELUsQnzdwnPbWUTvc961wS12SVOz4qQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483211; c=relaxed/simple;
	bh=ZKugPeTrsjvXBQLKk/V+q3m3NmYPBSUpFHMyAPYdhtk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KKMiKjrB+hyVK9m5wfEGNyAbf7prg+l2VCNrgAIap78Gyvg8ZGsAf0944sHV/TtmtrI6r4XIAtKMrpO6UQrrDAaNTIbWv6lT1uEIQuZTiyrPiHIKoo6gU01S8wNrClOW4fM3nr0SqJwayYjhaJ980yhrA2bZnelt5J+YUbkvWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnnJOVP1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnnJOVP1"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so4264346276.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730483209; x=1731088009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qUj5kTLlEpcuj5nONWXBCkZ3J866fcc0jKy/3yAj+E=;
        b=LnnJOVP1XLelGiJ1GoElh7+xKOyJ2E7ACseoC8zAKYwsuAVapzV5Vd1ouilyueh/x0
         CUMJ+De4zd4B1UKKYy+mUy2/ku8JK5Wqfdpc+3aFMDPEV0uvzcTYvj9EF0LhJmsp/Fav
         pW70SPCzLlEOKGSbXaIJ8tX9U/eoUoe9qTxL/+WnGZAQLMjsRk9uUBynbZGW42+Oh4ma
         dTm86QSLRxKmzsPCBx4EdxkvWvj72R0Ik2cBOh8a69+05TKPJFkpYhvBcqK3YgjiVRt1
         2qjkd/y9EFBj/Sa5wssrfk/CA5hqzxPRk180mdwZCwjGyp5j6SXO0+B4uwjVeX+wE941
         qagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483209; x=1731088009;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qUj5kTLlEpcuj5nONWXBCkZ3J866fcc0jKy/3yAj+E=;
        b=U8qMbvoqAtcWIGnM4fGKlWspltjF6oQWonK3UVimF82CbfSMjgiFtYtgCGMyZ1tcbO
         UslMKKQ7uaP4yCNxpWRNF6Xrh8zKynsf5iiNc/ZVspJHpg6AxVpBrjjr9iLY1Pi9Z3Vw
         Dm7vahduO7R4xQAI1meAOq+09TrAbPu62QBgmUgLoW8jkt525yE9nxfoXuFldz5ym4fp
         ySUr5fmkYrC7+HnVYKHl+J2N13sfvgam+je5rMyhHvaEk1/O2OeKRngyF9V/fow5HeT7
         RJK0c6IY83cEXQBFzFFcGE9X1A5gTGs9p/yp+bPcTr7b9eBT/LMiuQ8znOFoRywEmyXh
         WP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRd2JMZmuJTbeO+m1SrkUBPz/gI6gJiykffxoXt3WzskjsIRvxgihfW1Az7xGDHGpvpLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOjNz/dbFdmAIkrMNUO2a6TqsHuVwZUbJezkF4II0yORyJeoc
	4cxz+fN0V1QvikC6WodRvaoZi2G0cp2r68OWtBovtpUm0PaFiTA8EpSSGzWHtyrhnls+0ec8jJC
	6B1Z59GCfjL5s3VvKYOElXoiNCoPCkg==
X-Google-Smtp-Source: AGHT+IGSkwpVMgnBISQryQDiCBwYmXrS0QzDTJFBpgaY/SQRkCOvnxSFO8nbjw8OV/uEjrxQL/0e8DWgLwJEi+O8fotz
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d682:0:b0:e33:1794:4c53 with
 SMTP id 3f1490d57ef6-e3317944df7mr183276.11.1730483208915; Fri, 01 Nov 2024
 10:46:48 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:46:46 -0700
In-Reply-To: <CAKgqsWWo2r37nsxeYErXjEgrSepBgFpdde9bXuYDTfu4MC3+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101174646.685790-1-jonathantanmy@google.com>
Subject: Re: [External] Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph
 but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Han Xin <hanxin.hx@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	steadmon@google.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Han Xin <hanxin.hx@bytedance.com> writes:
> Although the scenario I faked in t/t5330-no-lazy-fetch-with-commit-graph.sh
> usually does not occur, if we are unfortunate enough to encounter this issue,
> I hope it can automatically fix the problem as much as possible without
> relying on me to take an extra action.
> 
> Thanks.

Note that unfortunately the user will still need to take an extra
action.

My goal at first was to try to teach Git to fetch the commit (in the
commit graph file but not in the object DB) anyway, so that (as you
said) the problem will fix itself, but that requires not only a change
in the part of the code that emits "want", but also the part that emits
"have" (the fetch negotiation code). At that point, I decided that it's
better to stop early and warn the user (it was not a fatal error in the
original version of the code, but I have changed it).
