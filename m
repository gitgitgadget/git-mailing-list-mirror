Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71032BDC26
	for <git@vger.kernel.org>; Sat,  9 Aug 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754751908; cv=none; b=UyxzNxWRa58ju7BUtjmq0mff0xllsqyUsP1ETrg3f3MzzGOBSXu7SgBZNFNOJEu95p74ui220VZDVda2WtLXfTIvb9m2qXVeuTmqjoQZ/xQC99pBG9xGN8n0SrRQAFN5s+1X3qcTkGPSADgCHgrQsQGFeKww19YCYCEeq1HGhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754751908; c=relaxed/simple;
	bh=I0d5qNaf3QVelCZ6A5ZG1HS7jeCTPBo3LUfDxJ/pchk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqbhE+nZFATnu/WoD7JadIZ6E1sJY3uFvLIgPQ1y3dEm3oXiHSdEmpFkYyu5g0dSw61WR1w0aH73S7gPo1PAzm1b6ZVLWXuFfKqcbaWhbPwepJDLbVAqLuWKN5j0g26zKqyrkao50f47W7DXzhpfiYHBmK2IJEy3HTDBZdI5ibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+6YtIpj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+6YtIpj"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so6530243a12.0
        for <git@vger.kernel.org>; Sat, 09 Aug 2025 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754751904; x=1755356704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ86fHAmy/pkORBf2WsaWhcyY+3awL1dyKac+ZzVI0Y=;
        b=Q+6YtIpjZVIhIpMhvw3fnRT94VUrFGiFNO9j6fEEnSJxJIouwoqz4wxNbwzNGKCWUu
         5sFB3RHuq1Fp9rkiK0LY0PddLldjVoTi+8JJIrWaDrUUDNwp30j1CJO5hWGwlzl0yPTb
         CLlh70pK8ZgtOywOUbe/LOh30X8Dw3H9e966eHuyHxpNNI+wfLntb4msfngDtboNZv7U
         eqDmBT5b2NazFZZ+LTaxYz6+Xm/GvrbbixQq7hiPnY87Nu0UozuOf0dVjqTwU10MMYEI
         PAFThU6o/Ckz+D/OqMtvuhuXEPJSleQ28l5EmrXng0yFbt/pNGYJd8i5+QAyURtuLSnl
         Ypkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754751904; x=1755356704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ86fHAmy/pkORBf2WsaWhcyY+3awL1dyKac+ZzVI0Y=;
        b=dZ7ibWISE2zal8yCXPiXNZy0wiVgRF5c5MlMYBjhLR/3fIDuubU7UsKIjTIK4EONgd
         M6Vpimtc9ALwujNxgIhiOXuJ4mhQCb+SmVN51o1Jq0Hf7y0bpPD+5k3y1gGKOk2JY6RP
         zziIpQ+ngr5q3steaj9utUjvvaeYCLYAa7RgAS+AMzWdCz3lCoxsgbNoKZ6weUIcZLKD
         AuHGxQ5SZ4GsnKGzFTk0ZSlLKsuOkMxumFvvxBeYgVgQ189+z84LKs7zoG6t7hRtx4X4
         pq/+6r8e2ed7KQ2GL/Dx/y8uzUc4gisJucWm/3ux2u4IAhFzrS13+cB7nkxKcnDmaajY
         ihNA==
X-Gm-Message-State: AOJu0YxDdj2SqAzjPoA8jAfcYCU5mzk817MpI2g+A2CdsE4xAdHOlIuK
	k6FhhxrogJmSzevbSL6bEC8JcCRh8y8rRJ+OWU29ZfpLeHuhJcmL/6n6gshgvhBXTs23NAoH6sD
	JeF8F+WEyJpoi0cjLDc2lE4MZwqjWLFQkCySGkYg=
X-Gm-Gg: ASbGnct2j7b05YC3YFB2VcOKMmeGCVYAu719qRDGD8qYYpP3vMH+7aeafakv+EqCIfs
	+kwkC7CPE0LLz2mdkvG4TASnP4QhVu5EKLg+fqi3iV6Xkx5NSPmee9RF/BoQ/hrg1AGNJWQUlS6
	UnurBh+hGh7fNa2nG+XT+JrLVKo0cqbNxAz4H9W3A195KXClAwPGF7fwsOz/1vQ62p/0bijn61R
	ZIy09BLxo9z9Mj0bJj+qAOTvQBm5nFxhNwrz3/2VMoZFuSUb7ti
X-Google-Smtp-Source: AGHT+IFaK3s3rUKTG+HPr+HFJCUPjfUqFpfbjzgrcQEB4pYQ5EJcG/Lagtc8s23VKBnO2AJ6rdzE2R6H+GZnZNGKTM8=
X-Received: by 2002:a17:907:7e9d:b0:af8:fded:6bad with SMTP id
 a640c23a62f3a-af9a3e3e611mr1180304366b.18.1754751904033; Sat, 09 Aug 2025
 08:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com> <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 9 Aug 2025 11:04:52 -0400
X-Gm-Features: Ac12FXwPPMsHoxIiuzqEI9TO1P6dVXr2RZwT9Z5AYzuVHBUbbrC3jzMCDm_atVE
Message-ID: <CALnO6CAmC8bviFJeZeRpD_6OJoA6=N8HOR4EkWUN--2rjifTAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:15=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks for the review comments, here are the new changes which:
>
>  * make the intro to the man page less dry, with the suggested wording
>  * clarify the merge conflict resolution explanation & fix the HTML
>    formatting issues
>  * move the explanation of the git rebase <upstream> <branch> syntax up i=
nto
>    the intro
>
> I'm still curious about the intention for the git rebase master topic
> syntax, since I'd never heard of it before. Is it just to save on typing,
> since it's fewer characters than git switch topic and then git rebase
> master? I ask because someone mentioned to me on Mastodon
> (https://hachyderm.io/@simontatham/114988051822317920) that they sometime=
s
> use git rebase HEAD main as part of their workflow, which is not equivale=
nt
> to git checkout main && git rebase HEAD. That made me think that there mi=
ght
> be some broader intent to enable rebases that wouldn't otherwise be possi=
ble
> without that syntax.

I think the intent really is "shortcut." It's existed since the first
version of rebase (59e6b23ace ([PATCH] git-rebase-script: rebase local
commits to new upstream head., 2005-06-25),
https://lore.kernel.org/git/7v4qboejp6.fsf_-_@assigned-by-dhcp.cox.net/).
I didn't look too closely at that mailing list thread for any
justification of the shortcut, though.

The example mentioned on Mastodon is still a shortcut, it's just more
like a function than a macro (that is, the arguments are evaluated
first, then the shortcut applied):

    git rebase HEAD main

becomes (in shell syntax)

    head=3D$(git rev-parse HEAD)
    git switch --detach main
    git rebase $head

rather than

    git switch --detach main
    git rebase HEAD # too late, HEAD has changed
