Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C55C29
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732158746; cv=none; b=tOa3RtSrQ18IaHesV+B+R5u82GbXvAjeAE969wk9ZIu0bc3YWsse/FAqJ1DkqGQH5xmsW1ogwzVWGTlRWtjUbXKERrbBWWcAThcg2JV0Zg3oY2BGD03KndrJCi1LXBZfFHeWgD3xrwc9OErX/r4bJkKa7aut7v3XQ0q5lxNsFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732158746; c=relaxed/simple;
	bh=c91FjpuMThJpVsJGipYKOvrxAr7LIvJ2H3y6fgoXgys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlO4xU2m4CgAiXo2L1Ci7Gix4Trv0AJ5PF5Qu1RDcG6cMQh+ujYRRvTh8UF7Cc9QKwglyooLdNib8ipTqB9l+tFyyeS7f+ZVz+M0+KtBt8+u4DJNqBYSarIwyVsbdFq02eJZv5/ruw4+EE0uPh6vrGgY8OhWypi0YXhgGP3BHKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gCqO5N7v; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gCqO5N7v"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e467c3996so375573b3a.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732158744; x=1732763544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVr0jtVvvwDyL0ha69CBPmo6UlAD4OIK+ncSnONr858=;
        b=gCqO5N7vKekE0yYyNRIFLmvZ2O8u94vjFpGKXz057zsrDJTBQ6vBP01a4xoE8M7YAx
         QNFhq/n589/dkP3xQCx4521lgyIxHPUIRHKxmjpwdRsphmJD+8G6p2BKwxSUf/X9STgf
         nj19D3IzAGO7iVTP9rckN+AVjLB+fP+tx1dNdnJlqdIHNUe8iGNCKwGMFvz9itP6rCj9
         nFRzGWo5TOkIb/MZtixkpJmQwMDbNJAV9UF5sG1CuOvvrtfXZlC3+F2XTrg+Begc7hww
         oGTsodDUkVGhukmQu9/caWaUr8DeZwP4sQODa9UiMyC5zjpACvtkAASfWJhvRJcF5KWJ
         NuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732158744; x=1732763544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVr0jtVvvwDyL0ha69CBPmo6UlAD4OIK+ncSnONr858=;
        b=mwoGnOnqryU3KVgfI1Erkz9ialA+80el1SCyY59yxzfzXcfLOU7kiXpxtnHW49dOLY
         YNf7tUxFcG4hdlN11eJuqJIETSteFSziE7NgVX6U44hbdm/TYwW1tWlUByvGNyyKV4nO
         yPn4+U5yze8yWXL7NlmsO1Jv+5mzpIvRH/SjkX1LZhTclJ778PNcfBxtAqQ28kEASvFA
         ck0ICMm8RCOZWXhLfAWPPIBPUAf7d3AvK5eqEDajEVSBYt3D0w623UAlddwomwaZyyMC
         G7ctWzKMa2w/Fp6NjfiWVhJvyy5Hu4JVRQ+HXCEGWOL0mWBTCZD/dTdR5c5TIhw24U9u
         HeEg==
X-Forwarded-Encrypted: i=1; AJvYcCWL/oGpY7MhYbQrdhcUNqjf1E7NcC7xktQr2ho4nL8GIb7O3efo7ZIwJwUZJpI74Beantc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDQ8SpNV2k0DyGgHMeQID6Nt4aYh2twGqDWplEw8IJpQ9H+ZS
	gmLyL3c86RAiCavivk+CkmOZvW5FVDNwNPllr5mRe8oNxD6Yh3NOnk5hJoQgd8PQBsjq9B34gQB
	iEyzF3AW2lMHOsSlMwdKwrY0GpDTp5K9SP1FBTL/tE0ZjH524Nug=
X-Gm-Gg: ASbGncv63ejPA2DSynJWc8ByFZmB7fQ+qOvwOtR95YNL5Z5tUM1TZYoBY9xj710JmLv
	OdGAwnS077av6YgjAzMBhLoDw940dxXPGQg==
X-Google-Smtp-Source: AGHT+IFTXjTSsOwC4AHuBLJsreDfQKDHDfl5AxG9TABaMalXcmiFShcGg7bTUVgmShzEgHimCAa3QfS1mrktDNFchuA=
X-Received: by 2002:a05:6a00:3d0c:b0:71e:5d1d:1aa7 with SMTP id
 d2e1a72fcca58-724bedf12f9mr6978842b3a.17.1732158743907; Wed, 20 Nov 2024
 19:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120185228.3204236-1-jonathantanmy@google.com> <xmqqikshikgz.fsf@gitster.g>
In-Reply-To: <xmqqikshikgz.fsf@gitster.g>
From: Han Young <hanyang.tony@bytedance.com>
Date: Thu, 21 Nov 2024 11:12:12 +0800
Message-ID: <CAG1j3zEEN5EJwTsM3q87gCSqXG4+=DZVvcQdDhoj5Epe-S0nPw@mail.gmail.com>
Subject: Re: [External] Re: git-blame extremely slow in partial clones due to
 serial object fetching
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Burke Libbey <burke.libbey@shopify.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:00=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> >  - We could also teach the server to "blame" a file for us and then
> >    teach the client to stitch together the server's result with the
> >    local findings, but this is more complicated.
>
> Your local lazy repository, if you have anything you have to "stitch
> together", would have your locally modified contents, and for you to
> be able to make such modifications, it would also have at least the
> blobs from HEAD, which you based your modifications on.  So you
> should be able to locally run "git blame @{u}.." to find lines that
> your locally modified contents are to be blamed, ask the other side
> to give you a blame for @{u}, and overlay the former on top of the
> latter.
>

In $DAY_JOB, we modified the server to run blame for the client.
To deal with changes not yet pushed to the server, we let client
pack the local only blobs for the blamed file, alone with the local
only commits that touch that file into one packfile and send a
'remote-blame' request to the server.

Server then unpack the relevant objects into memory
(by reusing code from git-unpack-objects), run the blame and return
the result back to the client. This way we avoided running blame both
twice and interleave the results.

It works quite well in very large repos, with result caching, the speed
can be even faster than locally blame on a full repo.
