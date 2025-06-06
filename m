Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA020330
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209987; cv=none; b=lqPTL6UeGcFrynN6T7qnD5x/HX0meyFqtLwhMHliEqAmXaLwoRMEdXXR8i58meUFYs4x7OWGV1tFqQzSa/OXW5BgV9a92EAAHhqZDiaRy/AdMsQBK34MzOJxqS/v3OImEX3ntgn0fI62DqmZumN9t4QDbv2mpuXHwEGybTc1QSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209987; c=relaxed/simple;
	bh=CjlJ4y6SmOGdHGR1cddTWklpzazU5WWa52H11bgGnhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+f7we72UOszP6fLyJaYhl3avDmAnogUmkJ4R4C16TMEJldlkac8KbvMxTvkf9deRalbOajk0HaBiHMwUh94TXGAsKy+ERsKWMGCor2dYQBrkxkSiLUQmmLE/vvLAw0+8o8rjUJbOiUz0kP2AQ90ZMT/j7vqV4rf9aKdiWsBeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEQLx7ar; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEQLx7ar"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a365a6804eso1350271f8f.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749209983; x=1749814783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPhT50UUSj92j9C6wio6eminnSq1QuCyyQQGtxTAwwE=;
        b=GEQLx7ar9l8HQt3LcUnpMp17LqFH3oSJM5j0jLjyMpmZ86D4BhcwHEtXaL+klfunY+
         1t3oVmZRqX4tn1ZN1RawDioIbPcniTebw1QxSPHNc1he/PFRNQuIvxJ/I+9dlbE6ADtN
         CSnDl1XZnqWL1XCHdgsOZtpIBSXDTBhv5M3+CY+KU+LtrumoggWkM4z4plKlt9ChmSeR
         qx2ahCkOJ00w2yw6C8v03FznqspqcFroPfjQKgCijs4Net6iqv6y2Cd2QSA9Uh7mvNg9
         1fX9KyhRLo+y3G+cvAOjQAD0k55JHlxDXOKkExsnjdmi1H9N45SmTMCQKgqNuoJwqrsd
         6fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749209983; x=1749814783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPhT50UUSj92j9C6wio6eminnSq1QuCyyQQGtxTAwwE=;
        b=mVswMYJIr6LJjgszCWZ7HC4UQ8xjtrt4gGZR6EZnO2q3LRqBKpov4w4JNrbZcJQPI5
         +nJpyq3C/o18PlGB/x8FOg3kT/6ofydBfECw0C9JxL9UvmirOe/td+4gsvcCeIkd+wZz
         pgecbGcjuahxXN/v2SXcy9tdXmshJHF1GVAaX4OfZSVG8hTuf8yRqK28KQ1nQDb/2Y70
         5+3bwlXJXpPf/jbkJIsMZx8hX7e9u8sihnE9we8G+mtO9POeAc4KRujTtTwzEf4z4vnW
         Fh7yvD1A4SArFjodjLA4HO9RS2mPiXViQBaYT8Of7F4SwXODyTwI7OlA15iY75aukd9y
         7Nyw==
X-Forwarded-Encrypted: i=1; AJvYcCUIPSbRi9Iiw0ni20ZosltBOcJRnE4zaMwsMSVoiHNVQGJKoNFCwl+oA5qVcn2pQD3vKHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzpZu5gO79Mrxm2U/2REManXhNXkndElnfzFM6AePodbzQDLvb
	e0zt17q4xIoh/vnpkyxJUt9VyX7pdUH2kpz6ZqwO2QyZgcL1e/WsOd+qxx40rsl5mW40PZLHRnX
	ZyUzD1rVgw2blXoRf97FE5BAf9OqbkEM=
X-Gm-Gg: ASbGncumHVWqEm+pyA8WDFtdQOdT9cL5NvpikcCpRdE85VSmvzhklcH5xBWYxtrkTwW
	5YwG/pgwV2ucW3GUebvzBmEaTIqEV5yMhcgWs6+pQLOaxTOXFyWFlA4IWZ5AsEur9Wzd2i7gQv0
	Wo1W6XU+X/9ozmJvTofOoJOJ2w+zBlPBvz0g==
X-Google-Smtp-Source: AGHT+IEPyNsVoSaTFUKmFGKVz7YSeOJb3oE72xe7aRxt1K1sA6mvoNYJmYGbZJrbNBDEdqrlms7ekmZHkSS+OQAE6jY=
X-Received: by 2002:a05:6000:2512:b0:3a4:d53d:be20 with SMTP id
 ffacd0b85a97d-3a531ca669cmr2643673f8f.18.1749209983346; Fri, 06 Jun 2025
 04:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1747733203.git.phillip.wood@dunelm.org.uk> <xmqqcybkh3wg.fsf@gitster.g>
In-Reply-To: <xmqqcybkh3wg.fsf@gitster.g>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Fri, 6 Jun 2025 13:39:31 +0200
X-Gm-Features: AX0GCFvV9q2FBSm527l-OEHa_e9YKvQ_vB9b3CKIxYeoIkumnu4pw7PE-aRTKQs
Message-ID: <CAN0heSpRWoiPh-c9y27unLgx18VNiHwJvnPiUERM_KSiP-39=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] stash: fix and improve "git stash -p <pathspec>"
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 00:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> > Phillip Wood (2):
> >   stash: allow "git stash -p <pathspec>" to assume push again
> >   stash: allow "git stash [<options>] --patch <pathspec>" to assume push
>
> Are other people interested in this work?  I haven't seen any
> comments other than a few nitpicky one form mine, and want to (1)
> gauge the interest in the fix, and (2) see how well reviewed it is
> (and my review or reading over the patches again would not count all
> that much here).

On reading the patches, I realized that I have some interest in this. I
left some comments. Most of them amount to thinking out loud, but I do
think that the new test could do a bit better at proving that the
(fixed/improved) implementation actually ends up picking up `-p` at all.

A nice, pleasant read. The series has a well-defined focus.

Martin
