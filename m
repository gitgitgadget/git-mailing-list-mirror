Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43797BA4D
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710003126; cv=none; b=QyLZgn5ssHmdkiqw+yNvIkcZ3Wk721awKAcN++gwVHN2slEcdBRCN4NvTT/Tn89HlJuCKzz6aQjkJfsmqnZksR6twkXBoLegwwsmX3SDMoskjEujoytbQ6m2Cz6dHXuhiP2Sn4kXGTFMV0bRWGsFIfjfAK0pwlZwO2vsbDnZDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710003126; c=relaxed/simple;
	bh=cvhaiQPUD8VuHnYPk9S5AxtGJ7A5vmaWDp5TXBzIzRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgNBJZLDye28lu8tGEGs0dXZcbM70c3cfZm1Wcc3AKI/xnt16pgdgmvJRcJ8OyHdacrUEVPCdB2qJyfqh9etPhbFiPcSkr2t6uHwK51W4w+P8taLvqIqbADmIC1kVPFH5xJc4jbPJ/KwQWMMJ03t+P1DYubj5W7PZmFJQHhQD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCFA8vk3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCFA8vk3"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51341a5aafbso3449291e87.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710003123; x=1710607923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvhaiQPUD8VuHnYPk9S5AxtGJ7A5vmaWDp5TXBzIzRc=;
        b=lCFA8vk3R2ZNGaY7zGL1MKrKUsWGfScapskU1qImcEq5YW6ArNifXqGOF5GImo79XI
         n7wcul+ggsOFlPKIPmKsEvxskeDL3lWRHqMes9SZR0pSY+sqEWKFqEqIY39By5TXq5eF
         RxOWcYDWeJ8dySzmm6AAc/hQJ6eYj+iLRtb+P5ZOXN9a/9AsSfAjTtq5i25U+sqt5r9w
         SSA1Nt8BAKdpszIeLeFefB+TVa28+OShaAfWwKUo8BOKUN8SmukvcWITEnh+AlyL4UFj
         LmOOKVJubWcIsQGGmA8mx0RAx7uX1ezJ5IbMOQaTFuASAFangPZ8m+rvgw8N72Vy1ljk
         JsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710003123; x=1710607923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvhaiQPUD8VuHnYPk9S5AxtGJ7A5vmaWDp5TXBzIzRc=;
        b=wLrV0gDdNplSo3fX3tZ8jjSF3sQ8rdqLIj3jrH82C1skjMmAveCbegcvTTkPjC+EtP
         iLPr98e45wTovG0/V6tFU2bCG0iJq6DRu/3m4rI/zdjAp11paPZYSmMXgIdLGYxqGzI5
         GOUfwjrx8DPESTSEpdcexOnE3sQU3Dhi2b2CQhsdB4khzTbOkG9CEA9Gw22GBbBx7AI2
         R7/O9wdRKAJLwG14HqUk4ok8KwdF3YG/wOFw0BacYw+s9UVyPLpaXgU3dXRp9tLrcXRR
         DUUzQomo2gfh4+Sl1H+9d+qbn/GS8Tgvoikxj9xPFi0ZdLO1hqJTyptdpg4dVyWBTxzE
         hBPw==
X-Gm-Message-State: AOJu0YyeCTOxqBl/HqNDNveTWz0NYLNkaWLyn9FY17jkcK36EwKgkNHJ
	cgNutekWw1pTANeUS0ewL5bXvwdwxbrwwns5fZX6d7ksAm0fEKvLn7GJ86LtcgYJsB1QwiupUQk
	nAx9T+SgpYV2lJBCSJflsK6vlUa0=
X-Google-Smtp-Source: AGHT+IEZMCDk5kOrBeDNsLXOlT8dAKYuWkdBbfU0eQGHHyUX53XdkMwBsYSSGy98cwgyi3lPmoLTrDDxeASr042BDKs=
X-Received: by 2002:a05:6512:54e:b0:513:1f28:dcda with SMTP id
 h14-20020a056512054e00b005131f28dcdamr1254233lfl.39.1710003123059; Sat, 09
 Mar 2024 08:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
In-Reply-To: <pull.1686.git.1709993397.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 9 Mar 2024 08:51:48 -0800
Message-ID: <CABPp-BFKciBPN0WAaGaK4tb8hXit22Up4LMoJNxo-+DqEspD+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] The merge-base logic vs missing commit objects (follow-up)
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Dirk Gouders <dirk@gouders.net>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 6:10=E2=80=AFAM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Jeff King reported that Coverity pointed out a problem in the patch serie=
s
> "The merge-base logic vs missing commit objects" (which made it into the
> next branch already): The return value of merge_submodules() is assigned =
to
> an unsigned, single-bit variable, which as a consequence is not able to h=
old
> a negative value indicating a non-recoverable error.
>
> I looked into this issue and am happy to report that there are no other
> instances of the same issue in that patch series. The first patch in this
> here patch series addresses that issue.
>
> While looking into this issue I also noticed that the merge_submodule()
> function did not even return negative values! This was an oversight on my
> part (which I attribute with a large amount of self-compassion to my utte=
r
> lack of enthusiasm for submodules as a Git feature), and the second patch=
 in
> this here patch series addresses that.
>
> This is a follow-up for
> https://lore.kernel.org/git/pull.1657.v4.git.1709113457.gitgitgadget@gmai=
l.com/,
> based on the js/merge-base-with-missing-commit branch.

This series looks good to me; thanks.
