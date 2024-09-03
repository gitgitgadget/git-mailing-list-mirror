Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F751D5CF4
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405589; cv=none; b=iQ/Ys/WA2pMPa2i80B3L3po0n9nlQZtR2nGzWVWRf+FiJ3qROMT9cGG7hJQYDwmermqQ0KXE8ER3u5ENVtgzu+sodXP3Ay8RInMSj05pBRRr03KxvKb6qyzbSnZ6dNE6Gi55YfloqUCzNp/xHhDbtlIZif4r91VMHAk8E4wx4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405589; c=relaxed/simple;
	bh=92Q+F8CQ9KxB82Z6T1+zrXCbtL3P77QPayE5hUBemh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLQH8XnoKc7iCbFG6v380w9e27aGC/x1AN4d8H5xLMPsJ7e2q5e1X1DpfMW7JsTxrIt4i+3x9drEOMhXsyP3nVoqZpRCNVMmBcapBSMAo86mBRXCWOPgzSAxhx2zODyBlnpwac4GUUHBIB1gA5/Z46w3GLE2fDxHqXk81Pdg73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHSbexnN; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHSbexnN"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39e6a1e0079so23368945ab.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725405587; x=1726010387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5cVAHJkTVEmlztrXT/3im/ughDXMUt8CAsGgIDXivdk=;
        b=AHSbexnNmMYyZOiW6OWyi8TL7JHFY6ip6VeCPeARHt0UGcpsicoY1bmuZ7OAUAvNHP
         SHdeKKLOeLB89MgPNyyNMXpPX40vjbhoX+osINYoZFHaWoUOLnoP8HQEmQGZ2zZqLfot
         t6EYUbWZTST3UQo+e0xfE5ShTjzTWFFLVJyjuoZyB8cMfwEOea+HPoBGNEa/AaY8XavJ
         yjO5iKmoVlih5h1N+8UPU0ggJgly3cHEKnak1+1b7Z2Onmfvoq/MArVCWGGu38CLJdlo
         JbkZ94qMXz2uSeZCZqfYGo0m3oi9tiCER440iOBEOHojwiMwZ7ZwqjwINE4tCJVB+eJJ
         ghfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725405587; x=1726010387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cVAHJkTVEmlztrXT/3im/ughDXMUt8CAsGgIDXivdk=;
        b=thsqIYDFm1c2DF8HdgsZ+i9cv04uwO1LUQNvPZE3Mrv/KMfpMHdhAvO5+7srtcH1zU
         uQp6hOVf3+V8IDz/D2GkQiCdIbegvQdb8Hibunhvu+L2iGlGhqmNYKUxl6QzI3+0YI8W
         OP6f67mdLAAfbi1nOs2KOOiQrRS1pRnJacfyEwPi14pEKtgiM/oF9EQDImPod64QVQvU
         JxAedVegL8n4J1i2fccJn3ciXGsdTLx2fTptrc+LhAmS8rQ634PLF15ofZml+A+iZLmr
         GT525/xjspJwAHhsVlI4MGTzskCBhWWXRrdqXhtt4bXoB1pyFE2mMr9kW/tdAeQ2IRlb
         KDRQ==
X-Gm-Message-State: AOJu0YyHZWJLSkbO8T+yeHWBi2A8sQD7qWK6CFa9lUhw6KWYre/BKVQE
	TqPv9eR8YxBlDOv/Nf8EJC2YR5UiB6/SNWboXUnP9jIHEC9oEetjrvOJe38eHBJwWqitjaOy+/9
	z4hrU2M1EopLP4UCK7TzuaF+ergE=
X-Google-Smtp-Source: AGHT+IGEpgqD1l6JMAP+QXS2zvpZzyjkImne0Nqu9czsZSEoc9F2kASuqUP9m2xvmTXEhEahiWGFqZPb83wxZZwi+HU=
X-Received: by 2002:a05:6e02:1a2f:b0:39b:4dd4:4a0d with SMTP id
 e9e14a558f8ab-39f6d71c990mr44958355ab.5.1725405586832; Tue, 03 Sep 2024
 16:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRvtz=WOPpv54-22aEFsCPi_vwpFo_Q08vq31NjggOVsw@mail.gmail.com>
In-Reply-To: <CANrWfmRvtz=WOPpv54-22aEFsCPi_vwpFo_Q08vq31NjggOVsw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Sep 2024 16:19:00 -0700
Message-ID: <CABPp-BEwLYhfBN6esMdeTcby4=12zhFeSqrih-WPy8D+pW3sxQ@mail.gmail.com>
Subject: Re: `git merge --no-overwrite-ignore` overwrites ignored files when
 merge (i.e. not fast-forward)
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, Sep 1, 2024, 03:49 Han Jiang <jhcarl0814@gmail.com> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> (`git merge --no-overwrite-ignore` overwrites ignored files when merge
> with conflict.)
>
> (`git merge --no-overwrite-ignore` overwrites ignored files when merge
> without conflict.)


Yep, well-known issue that I've mentioned multiple times.  Somewhat
related to the "precious" concept that has come up on the list a few
times.  See e.g.

  * the "merge backends" section of
https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.com/
  * C2-C7 of https://lore.kernel.org/git/CABPp-BEg6vxiUp
  * affects cherry-pick too, with discussion of how merge is affected:
https://lore.kernel.org/git/CABPp-BG=pm8gfRZNW8Rk1V77s40Do1FZy0mxH6epubHbzF8U5w@mail.gmail.com/
  * merge and other shortcomings mentioned when fixing up default
handling of ignored files:
https://lore.kernel.org/git/b7fe354effff8da3de53bd9cc40a03b5fd455f67.1632760428.git.gitgitgadget@gmail.com/
  * wider discussion of correctly removing or keeping files (also
discussing merge), in a series fixing lots of bugs in the area:
https://lore.kernel.org/git/pull.1036.v3.git.1632760428.gitgitgadget@gmail.com/
