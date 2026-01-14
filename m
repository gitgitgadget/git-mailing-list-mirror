Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F752E401
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357366; cv=none; b=J8Awcz2KsuQmCRSrxujpz0OZNLYUmQS1vjsioDUanNa5HgotLEN9ZBpklQBYg+1Um9MXRkl3EHlZMWYyucIWtcgfKW74N4mGLpMbKH7SZqQ3rUBghwgtt3PcOYKZ/AbxpScCbLWVE6WH/B2tbQq8EOr2EYxGWU8VOqBQN+1ck+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357366; c=relaxed/simple;
	bh=25EpRtnSKRqyLCSyVaFbPPCuwa+Bv7cftRspctCoxlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoiGPN4iXmVsjRvPjGPiCg1hFLPEwPhbgBu4IFOF+pEwYG1MPIFWfuCe+KWVLdiOhDzleQWRw9TKSq8E63LGqksZ8BrGXNBLEMy/AlP1ro/Jpd2plLt6m4ud5rgUGgJNldSnXYiMsFnGCxbYmqa9BpoK4ritr9AMhsGet1r9Fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWqf25O5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWqf25O5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09757004cso74673365ad.3
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768357364; x=1768962164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR2do9NcGVS5wdZSzmbsBQgJ3m8geOYVsR9eWHULBmk=;
        b=XWqf25O5N6ujfLVTFWSv20u8/yy/5/6L7CN2sD4dZUijZy1Y0/8VjzUKWfgzBNlo6h
         XLF2Av+k9PJiJBV4B/LM6Pn+WedFMLoIbqCY37MshuW+bIuzjDCohyl/zW2UNQtx4+ZG
         +uhqrERvSEZskzDScTpOCHKQk082UeikntjEahNfluPo7fT0o+JoQ5dLQ5d8Sljppuxk
         q6uoba1WO3u9dUKr42VIL8f5X4m/A4EKE5k/6ASDbZHY+ymVBNyffJvLixz0YEJLv75z
         5QpD0egzc8SLxLsrup0AAOdA4LRIf+CAEkus9HNqQzBrIN8AsCs+XJK6QhG/rpIakl6r
         vjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768357364; x=1768962164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OR2do9NcGVS5wdZSzmbsBQgJ3m8geOYVsR9eWHULBmk=;
        b=K6r7bbBKKioNMDtbo5O1GUUTaEJwFHq619XDP/rZgRaTFJyR+llPEhDaSlrXuyG3Ll
         IgwgTKnsXhnT2nZdwyJ5nT30e+aPIrDRPskpiWgppGzHhfoDsXMVPxOrCiuliQucNpnb
         ll+E9Bhx+62VdpLTxZrvm0l0ii/DrjQDGPIQJGhKApL4mVXfN/9pO4EcEn36At9nfk3s
         lGnU4sBEOYWZ2k5jiq15UmDmqSc5VjCw5f4VKZjyydBUWRD2gjUtR563dfqRMGD0uXnl
         +7WxDSNg9t5ShtRdRlfcDC+ZoaHJIyGu90MtMmxmyuacro79/weulcqjv1mmq/Fj/IzO
         ZBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz/tFpgPfHrtjGczw/S+E3N36OI1I5U9v67piD3F+aKN6nrNJW3fEqJxhvsWvOOPXTmK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEIoz/KSOvcMQ7ypmWe4xrIwbvymc4KAeUy8jWMHU6mDmTm/8
	FnFsCHBCOXdrodeffSDopqlv59Nd8bUcTQ11iW62QE2J+w2lMctHqJRYJZm8rB+gzWhUT/QfLNd
	Bo2KVYRpJw0KgZ8t/SHiuHz2W+d6ggROvyVxt
X-Gm-Gg: AY/fxX7MWFmp9gE1Kab9nIEtYf2nJQtltWtlCx1VGtV843ZjPiAa68Iv24qL34LwrsC
	XtSo7KLPHh6JQV0+DIGFDSddW0pSiPAq5NaaaJBBvYs8EsLkz8udi3J5K7gxD8ti6uYOYKBz9lF
	Cw0D2lAPt17uhr+EE9n44M4BKWgHAq7xgNqtziFJkC9ZgL04NiT8xiCh5Lo2jnTPXqSRjNGJsuF
	N4ksrqYPisFCTdprQgozX+zkIgqvT5VyiFLxUn23Qm20HjT+2GSKsK79OyYf+0X2iW/m3cRNIzd
	x6NqX70OsKDCD4nmZcWGQgvcYtgCzMFD4J5E5qIw6iJTQVwnqPb72aukTMaMk6YZ0bxjq45MR/8
	3aLDj7JkLjwMxoKY=
X-Received: by 2002:a17:903:230d:b0:2a0:de4f:ca7 with SMTP id
 d9443c01a7336-2a59bb17305mr4720135ad.1.1768357364529; Tue, 13 Jan 2026
 18:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113214059.GC288857@coredump.intra.peff.net> <20260113230107.16728-1-haraldnordgren@gmail.com>
In-Reply-To: <20260113230107.16728-1-haraldnordgren@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 13 Jan 2026 21:22:27 -0500
X-Gm-Features: AZwV_QhtHnDBCBciKGA7NFHlckk2VSpiQb-HyE8ObGWg49iRbOqGRud3lZ6OF6w
Message-ID: <CALnO6CAnfmDfCFJY55J81TTeRCYqeHq=dVapeanF0d0Z_yg=tw@mail.gmail.com>
Subject: Re: Triangular workflow
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: peff@peff.net, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 6:01=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> Hi Jeff!
>
> I'm very happy that your responded respectfully despite me basically
> saying that you were using Git wrong. It's nice to see how some of the pr=
os
> do it!
>
> I'm wondering if since you are scripting this anyway, if you really need =
a
> push branch at all? Can't you just as easily switch to doing this in the
> script:
>
>     git config push.default upstream
>     git push github jk/some-topic

The script is doing the "moral equivalent of" "git push -f github
refs/heads/jk/*", so I'm not sure I follow the suggestion here.

> As a note, before I started working on this feature, I don't realize
> that there was such a thing as a push branch (i.e. something different fr=
om
> the tracking branch). So I had the habit of checking out and pushing like
> this:
>
>     git branch --set-upstream-to upstream/master
>     git push origin $(git rev-parse --abbrev-ref HEAD)
>
> I worked really well for me. The only issue was missing the status info
> from my own branch -- which is why I started writing this feature.
>
>
> Harald

My workflow is different from Peff's, but it is similar along at least
one line: it's really convenient to have "git push" with no further
arguments (only possibly flags) to push my branch to a remote mirror.

--=20
D. Ben Knoble
