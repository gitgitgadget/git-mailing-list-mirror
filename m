Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77292313522
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046315; cv=none; b=M/nPbzI/zyyvVt+z5Oq8P9gmITXhVRtnigHIs6IOe+pcQ9mE9ttv2vJi/+KkHcqCIejHSlTKWAQR1agq1/92afrFOJKIJw8Pfm48D/lun6NUx0VpZ/vtErD00PymJbHFB21ripU78kD+sFbFiJ7w1Ol16OPpDIFnorP6AoZYAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046315; c=relaxed/simple;
	bh=t9f0RTqEVJhIL8CjErtO2YNk3u1EtHTpVWpjjPKLWB0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dIEbyPn1ckG+Zs0evCahv8CS+XECL5kinhu6vLNOCGklNMSh7tWDzRqHS9p7r51fjyU71TVoghQc/zevlmQ6TiwHjGcA9+yGH1FMs0pyAwGF5LpCz4ySShM7LAppbZFlXw8RvP/zg+hwrzKBcgdfXjJBxkfk/OyMb0fPYKZ2bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnnx14fJ; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnnx14fJ"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-567543b8989so57268e0c.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 11:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772046313; x=1772651113; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5hPaVe20F37K9oFCshWcjF7ZuLpr99cpYxuVeD2i58=;
        b=Bnnx14fJbc7SkyZxh0HXmqAR4fdpzI1MyttTNJHMsX2cFHjXPaMcKQYje/lcFN0gXh
         Hj0ekb9t8ydnhePLxjTluKsfE+SbSJdG0HCrG6j1jIwK+WOpfB5bXNkYZ/3iAA0AoXpH
         SC83lGhcVxGHN6LDjomnavqfH7ZCueiZLBm47ZQqm/jrzsTdtBkhPmBPk93nsmibazTl
         JXRfok3NoEVFHy6rvnzWp/ETegJ8Zizf+RExq/3Bfg/29EjY7RY2Ds0KZITrl6gInXk4
         LFq391rU+NnLagO58nVA2OaSkwT3TY+Sy7dg7Jotpj17tfzpMpPkzOrMNUoUDLEnx4z7
         IY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046313; x=1772651113;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5hPaVe20F37K9oFCshWcjF7ZuLpr99cpYxuVeD2i58=;
        b=pSNRNV0qhff2m4A8yZwsvgnGSB7I3lcToH9UDUi/HJbRlFwu40m4xwxAVTmzy9nB9P
         v9GNkSbNod6PGDgxEv4E7YSM8N3+ZZgpvMG/5T9jX/5Mfp1tGd+tP5seW95bcDV2JY+T
         rMx47tG8fioGRqkaNK2MauLTl0Y/7yjFkG468WQKAGqIl5QW59UPPBFR7q7y6kIwgDs4
         qe2ByUPiggzIwoAX8hjNosdSnhgzRK3tex+NrPM2Rh07QWV0WfjEELcBklYOuvcGgq5d
         qfG4/gS7kvxC4TcxuXVfnIRdlf75Q0Ksq4XWXqJ5o0z908iZWBvh4spN94rdkDV8L7Wj
         XxZA==
X-Gm-Message-State: AOJu0YxUMjuTZAQqgyhDzBwn8GVXjamlQx4R6ngSHfuPqQVL3o7OzlvM
	eFSWl2Ja4gFACTrar4/Fl9pUArIJNqFxtRCsTG1ePQy2LoZ5qi8QmcWu
X-Gm-Gg: ATEYQzwoocUzCwKjJxoaKRI4sWL9wW05CdqiU9pD2iRfFi1Mn6yWKxfgop9ZGcyudEu
	A4zR9IzAjBAMumInkuyP2StqBkL7U++vLhH7KsOGLiyHXAG9u+bnDqkT3Eu+zFwSSWXaXrp3He0
	8NY0RD6xC+yy0ckuwvfl/BsLR8dk+m6uPoalb/9HrrifyeD2Ze+EqtvQQsEgOFxPa5N4vTumSnw
	UVV59G/nVBilxFxQC/D4jAumKQUhRXjCACLSBx23r8gbN1QJsg5s2VjJE7UbOmYHATIdZdJ+Oll
	jZTWPx/voM1qsrkOalEZWuOMuRDucShQqdC3lEXYKFUJz8MgofbntXuR1rLcfK4as67Ff0jeiuV
	+cl0DhniYLORxjm6ckWyv7K/G1EJmms04zfJQbvmDtXBl69NbOUwSUOkRxlLBcxzNGPk5IVco7S
	DbC9ZUSAQElm5dAuUlTtJdo2Vxb0E2xLUZsLd+bO9+JamoWM7pWF1OHw==
X-Received: by 2002:a05:6122:1d54:b0:566:eb31:4715 with SMTP id 71dfb90a1353d-568e47c487dmr7111561e0c.8.1772046313340;
        Wed, 25 Feb 2026 11:05:13 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da899b566sm13226927241.1.2026.02.25.11.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2026 11:05:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] t7605: use test_path_is_file instead of test -f
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <pull.2050.git.1771911268805.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 16:04:59 -0300
Cc: git@vger.kernel.org,
 Mansi Singh <mansimaanu8627@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2C345ED6-BE80-4947-A1B9-4065CB54086C@gmail.com>
References: <pull.2050.git.1771911268805.gitgitgadget@gmail.com>
To: Mansi Singh via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)

Hi, Mansi!

> Replace old-style 'test -f' path checks with the modern
> test_path_is_file helper in the merge_c1_to_c2_cmds block.
> 
> The helper provides clearer failure messages and is the
> established convention in Git's test suite.
> 
> These instances were found using:
>  grep -rn "test -[efd]" t/ --include="*.sh"

I don't think this information is relevant to be placed in
the commit description. Perhaps it would better placed after
the scissors mark (the --- after the message) which is sent
to the mailing list but ignored in the final commit.

Btw, since we're in Git we can use Git's special powers to
do that. This is equivalent to your command line:

   $ git grep 'test -[efd]' -- 't/*.sh'

And this may be more useful, separating the output per file
and using pathspecs to filter the tests (files that begin with
"t") from other helper scripts inside t/:

   $ git grep --heading --break 'test -[efd]' -- 't/t*.sh'

I wrote a blog post about git-grep and other tools [1] that
may be useful for you.

> - test -f c0.c &&
> - test -f c1.c &&
> - test -f c2.c &&
> + test_path_is_file c0.c &&
> + test_path_is_file c1.c &&
> + test_path_is_file c2.c &&

The code itself looks good to me!

[1] https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/#git-grep
