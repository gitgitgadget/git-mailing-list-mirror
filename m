Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9B23C507
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630892; cv=none; b=NAgBjR0klK4SQSo02UwVxoFQeleymN3B9VtZEIx8uNeDqaSubPpTyG9GU0Jv9kLS1xWTysFtR5Z8oXrkIGMhu3fYcczQwNE1WvI+70bVjQ0XC5I606k61Td1sYgji3gEVDeO9p6tctsycxdtfacH2P+xwe1MTRAzC4a7ciFMTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630892; c=relaxed/simple;
	bh=gsD8QT+XOgn6S0/fIi5ojdwWE1TyP+92ArxuzS3+QO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym+6te1hdk6pMOlT6W99iIFlO7P7wjVD8sDLnCZE9COYDZ34Y42LuHUbK6q2DGBH3FmAziCZLWpH8meCNwxirXhIsNRqS0laCLDWkIkSi5vtzLfT6izY3JtbB2lpMc9qi2bzjLBWsVcU0hkKfJO6RDI334un6xuer3hlvxDhzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLuVm+fk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLuVm+fk"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad8826c05f2so1215823466b.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749630889; x=1750235689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsD8QT+XOgn6S0/fIi5ojdwWE1TyP+92ArxuzS3+QO4=;
        b=QLuVm+fkuPSWxzMFSB/Rr5/noJSGzTIhkmsIm3kItPVg9lWz3qFBEE7pgAQ01Z1uqR
         fVpzQG6SmcQA0FhVvIWiwF4FGFYiqyoi1JTu2pOyzyS56dBx3yfcA8tGzFTmqPiyjhzZ
         x95OieejESEfYFZmPJ4+0cr++tbjRWeK4cE5A9yxEGbzaf1FDEoNKmVH0vqMTZhG1Tck
         op/TL0pxRk1szbYqIpzfuwz30/8dF4K3Tji7pfGaba8j+4oGWZLN/xSiaZO3VGWE1Z4L
         0equXq+K4gtbeBm/OKT65sFjdmIh23cFFuwSP4Vo7gfQlvGGltdZHLW9yYtgqLbpYK4j
         +o5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630889; x=1750235689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsD8QT+XOgn6S0/fIi5ojdwWE1TyP+92ArxuzS3+QO4=;
        b=sQITh69Ddl9zEdcEStLNksIRkmO0Gz/x9n5fMYndsdCillbM0TaPXets+ZDBNS8cMT
         okgL9jg9NqZfbzarEeDWV4psbgoPcDgTYmLIZfFmsPF70BmREZMAr8rWDtdFYuHuXX0k
         paCdPeYfnWqq/Zi2di1F/7G7EacRY18Qo/GF2NOaV4gBlnDiBW8Ql3lndOCDT+36odai
         Q8rRhwpaQ4dUel6qCot/4muVl0ycx82yNQ0Q7N38SEUSAEsxYopOrCRx2clB1KsPrhmF
         8wFLFUyariMxpne/A6nSeo4kwcuF2zYWcqweSeaKmmrNxXnVXjLlE8EZUhKzdBtejGOt
         /k3w==
X-Forwarded-Encrypted: i=1; AJvYcCXnUDcDO5+60C42uhdHp9Olo5aXlBJiQPzo8yWM6SEQnu0h0MQ8jNF7FwGrXljYW2oyQP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ76ScQTrwYaqpQK78ojucCu4mt2q3Y8Sc34bGUZYAyQjDQM6Y
	bZD4IGAPxisLtILFlAZACv3uNjpm5culEffwiTQCfos8JzP2GC99YSD4r17GHjaKb01EuRVHC+f
	Rf7g3u/sdFUUkeOjz4EbnO6FvJrGuXsN++VWt
X-Gm-Gg: ASbGnct2rlU0uufYL92hW//gM48KXlEopX+nK9KIuIoHrjggJSPQvvE+E1cY2fUVs51
	Zou0Ex8L0Irm6xkRz3TuSFHipyfSLxt2EFkJGY/W5Q8pAZsxU5ANW8Q0U87lvwOH3FZaqtyiGUJ
	DzMo2JxTnl7RQw7VEqKxLoghZ7X1W2sSjNRDzLPM4aVg==
X-Google-Smtp-Source: AGHT+IEHJHYai5BvvMYQvNUmWMvGyF+9FtlN3yFIfOkuDNs6WRndIzPzZwt3SMjxjhPcpwYiKxlqb6sPeLAPPl05wnI=
X-Received: by 2002:a17:906:d551:b0:ad4:8ec1:8fc9 with SMTP id
 a640c23a62f3a-ade8c887cf2mr187019566b.42.1749630889170; Wed, 11 Jun 2025
 01:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
 <xmqq7c1jmgpq.fsf@gitster.g> <CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
 <xmqq4iwnktyv.fsf@gitster.g>
In-Reply-To: <xmqq4iwnktyv.fsf@gitster.g>
From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Date: Wed, 11 Jun 2025 10:34:38 +0200
X-Gm-Features: AX0GCFs8dZu6Dzg5JslUvQT6PYhqp32a9oicZ-7kDhayW152sHdhR17VmT3g2EY
Message-ID: <CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
Subject: Re: [PATCH] branch: move multiple branches in a single --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 11 giu 2025 alle ore 02:22 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:
>
> > This patch aims to make repointing multiple branches to the same commit-ish
> > easier, currently it needs a shell loop.
>
> Or "update-ref --stdin"?

I learned something new, but I'd still like to keep advocating for a syntax
like `branch --some-flag A B C X` instead of feeding by hand
update-ref commands.
