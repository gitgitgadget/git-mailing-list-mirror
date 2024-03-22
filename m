Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8354481A5
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119640; cv=none; b=NQDuMbJ6WI5h9D5VZW0IVjf0qsRY8Z6CfckV5ptxYUlF+njhowLeNMiRrM0lmSJTFD1qMWtOfiuHWf6VkgLXNg4ZkIJwkzSXZHeeQ3L5SN8pIpCGSXPjqYD+HqTIdWtJd0BNAhe4uv1lR8k3Uxf3hdXaV+KqlAwpj2L//Cy/kcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119640; c=relaxed/simple;
	bh=IKMLrPjS283tPxO1AsI3PkeAzUuYJn5JV3G7Y+la1aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJdlpVZR459vNDMpIQXgFIHfR3X/dqhvzz9A80j1gmH4gUQB2kKWBujluqV30nrrawgwTVc03YoGstzCnR2AJ7EVjkCdDWhlnniEGj3NcSW2Qk7E65hMJIIrj0Cotd/X9SCdG0+JMI8+JToDTHwDVXz3zCJDWvWBhkVgarSK7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPkga9Vn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPkga9Vn"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2821239a12.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711119637; x=1711724437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=359nC69eJdHXtkhtlss7/ULhRY/LvM8z5/TKTYttt7w=;
        b=lPkga9Vn3tXgeSaSt2XShYtyuEl/xzEkYyvpT2kyIfVTFJ8qz1YC1vYQaDttVP7OGx
         i4TIYajzKXbBpg7yAkCgLg2l/n9WlzRuVRBgnNMeNSJX890siMiBR+pEgcP24+fA3vAM
         7P8HfK3A/UNVVFkH3gYKJpgES5Tbeu5ymgjVZatRgcSAE7Ph0CaLdivOY3jIeVmSPi+D
         JZuU7NAMdHyIYeuaVjGbyNNNAOivfHhBKSioi9U3UWhl4oSqB5y/wOIyW3C7L4d3EWTu
         ivFKY1z6MklmMbh8UeqdCgrz2FV3YW9lHogjX5RsDdcqDD4Qs0Rcrd4LjP6ZDTXFHE4h
         LWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119637; x=1711724437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=359nC69eJdHXtkhtlss7/ULhRY/LvM8z5/TKTYttt7w=;
        b=DmAziKnh1ZIrKmXHCO8nRMR9VnEcsHc/T8SqET8raFzHxYZVckFTtlXoOT7vk0C/uE
         nzfSpRSo9XjQnnNyi7CfrS4eMC031ozxk7PUp1HInbwoLvUYym58oh8hMt+0+P53WlOG
         G2KDgqRayfaCDMUmISlZVbIkj/g5/i7RgUNSU726Iyc4GTHQCmJavXzO0hKFja1d9kGL
         Bbzl4Pmx8Zz8sLbep/SR/W9mJJWNE+OP3V4Hm0rbGWlnppE/zpNK9WyqW2a7LwKnAn/M
         BqOaHMOKXaDcBeGvhTlDAG4b/pPMoIfEqR9wd3R/u+L2TIrPUjAA3mKupaxbiu/VtvSl
         WecA==
X-Forwarded-Encrypted: i=1; AJvYcCU7SXk9MmPcfefYbDkNBDuz7qG1vVd8cEtS7mhpb8TKtNAgMJdYU2bu+dvJj9OCQ8ADTtQvU4qxmEmpYYuBY1w10REt
X-Gm-Message-State: AOJu0YxgyUsEVs/u57/VEgyTT5xaM2FkXRb8j7wx7vXkeJy5mbNIhmrS
	tNCoQhYTBk+cjrDNZk+eNQVZzY5D7yrNYW3y8sfoQhalGoQiCX7Ln3R0z2FFsL12DudvWRyx2i9
	T+togDbHg0plJQDpyqxz328qlDy4=
X-Google-Smtp-Source: AGHT+IEYYw/tyMazCjjTXeGQNIl7D2WjOghu0bXy5gHvrqeiZhODzCUzza6w6/xFmiMGf0sCopFdhYgpDd2NDAGcbDE=
X-Received: by 2002:a17:907:70c1:b0:a45:270e:3617 with SMTP id
 yk1-20020a17090770c100b00a45270e3617mr1862404ejb.27.1711119636845; Fri, 22
 Mar 2024 08:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqs=ULaHwttY1jRaW4ZT0tGeSW2S_gcEw=tMrY+i26Jy1gA@mail.gmail.com>
 <xmqq5xxf8k9r.fsf@gitster.g>
In-Reply-To: <xmqq5xxf8k9r.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Fri, 22 Mar 2024 15:00:00 +0000
Message-ID: <CAGJzqskywQhaaG+HPWiLDqtrUE3+Zb0XuGdheJaHJMS7LqJ9xA@mail.gmail.com>
Subject: Re: Feature request: status could list ref names after "HEAD detached"
To: Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 19:20, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> > I frequently run `git status`. Sometimes HEAD is detached:
> >
> >     HEAD detached at ea601b57e
> >
> > It would be neat to include ref names here, similar to git log:
> >
> >     HEAD detached at ea601b57e (origin/main, origin/HEAD, main)
> >
> > This gives me more information before I create a new branch or switch branch.
>
> This has already moved away from the original "I want to know on
> which branch other worktrees are working" feature, but while we are
> expanding the edges...
>
> I wonder what you want to see when a detached HEAD deviated from its
> initial position (i.e., when we say "HEAD detached from", not "HEAD
> detached at", in "git status" output).  Would we still want to show
> the "--decorate" list of existing refs for the original position?
>
>     $ git checkout --detach master
>     $ git status | head -n1
>     HEAD detached at 3bd955d269
>     $ git checkout --allow-empty -m empty
>     $ git status | head -n1
>     HEAD detached from 3bd955d269
>     $ git reset --hard HEAD^
>     $ git status | head -n1
>     HEAD detached at 3bd955d269
>
> If we add "(master)" after 3bd955d269 in the above illustration, I
> wonder if it makes it too misleading.

Interesting. I hadn't appreciated the difference between "HEAD
detached at" and "HEAD detached from". In the 'from' case, it'd be
informative to see some measure of distance from the original
position:

HEAD detached from 3bd955d269 (HEAD~1)
HEAD detached [ahead 1] from 3bd955d269

Decorated with refs:

HEAD detached from 3bd955d269 (HEAD~1, master)
HEAD detached [ahead 1] from 3bd955d269 (master)
