Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3AA18E370
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153584; cv=none; b=u5+rrKPB0P9VlfWWd3yNou9cC7V4BvmK1yk5HtN0t6K8VyaKcUYuCv1CUagXwzntZc98gGAOvBDw65l0bfJaBZm56N2qFiPk5PuHxPpQz0Alt16ayeatgNL8JbfZsonolFXUbUpHCS32VO39CCb8yklLiNMhXyu9pazbFXink2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153584; c=relaxed/simple;
	bh=BhxC+Tv/4JB2qV1GqxEWeTiMLrDqFK+087poazCHumM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9N6oxANFRUeyzj8bBGzbn8JfAn8j2zwPxFL1I+T9MPmckJPtgyo4+9KfZvsJLUE3xFvYYE6216gV2WEAvAvYxuRSDxZLTHAEXTfy0ACdj78jpcv3gtjSOePmtigKWr7Vxy7cIJMedqeBQEeBa1mZbHnG/WYDfFykrs1dkvqxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjpcheVl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjpcheVl"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf6dedbfe1so31831116d6.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 04:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153581; x=1724758381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhxC+Tv/4JB2qV1GqxEWeTiMLrDqFK+087poazCHumM=;
        b=MjpcheVlFvb3m92a3B9Wtx6VAPish4C+oxLcMWr1mgUghOEGs1p/NlBQDNYMSwBABO
         HVne8joeYUYl0/jZIWujOmrzRf4js42T4bnbtR5rHXkJXkzqhhH8kqaG/gcj9udBf01T
         DZdanEJATptvUnP+mS+QWIbDMSFq3Vdxzhxcdm2+rHWIwD1fZu7aw1v6+Iw1M4wIKX55
         C7uSd1g0TCi4cxD7rGqY46yXpnN4EN/AY46aEjqc00w3HzwgECo7Uct9Jq01K+F0/fQz
         5s5G2RSi3BxRjmB4YJr+tzO/9728zG98BzzIyAP6FuuDLbWAWVly5PMci3ypAQrUL3Bg
         l+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153581; x=1724758381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhxC+Tv/4JB2qV1GqxEWeTiMLrDqFK+087poazCHumM=;
        b=MB9Cq4HkegrK8g4xuWNSPyegTfuD9F22uDf9LExpyKwdzCvooeH+z7Q+X/f4HTZHNI
         nyUBkA/c5kHySbXqTf3jKFAMtXwoDGeVI4okRtUvEwZvOOA5TxdDHTap/nUxKD3tGm8Z
         U2TD9tmDbg8e5ZuCc7PLDPfi6itQcS9a88h4S7L+H/18Xkga7I81GV5Tpvp4CEhycu5L
         UAJRIK0SlB/CwVz6ybDjb+JeP8KDsAhKa9Q3v34Eru9al1RKNDbBvRBC+BBzAtd8XIog
         x1EAgGM930mSOVWf+PoCR3O5dc1/Z7mIqcV5hm0Vnyuyc3tViOj4WDVxkc+2JezhGKhY
         6DPA==
X-Gm-Message-State: AOJu0YwUCDoA6m+vd/LI9y/BKS9Om2qAR3m6XJvpck+EveNK7eYI6Ut+
	4K+NwcPXsk5lHt0hA0+5QEYkg3LGpwtSYizZMsqvr4rXT9zh+JBZ2x7fXONBlNpa+7OWP3oKiPm
	Qmmt0DlCYcFW7aDx0hVPGNN5A1Ak=
X-Google-Smtp-Source: AGHT+IHqVq+cVooKZAk04fJsfgsnX+/tFC0/Jm/0Hn8EfexQYbryOUsff8JspRmSkDsTtsTzdpwvW2EqG4VrJwx72dw=
X-Received: by 2002:a05:6214:4498:b0:6bf:78ad:ebc8 with SMTP id
 6a1803df08f44-6bf7cdc657cmr232058956d6.24.1724153581422; Tue, 20 Aug 2024
 04:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <Zqpa8/aLpgtzoBH2@nand.local>
In-Reply-To: <Zqpa8/aLpgtzoBH2@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 13:32:48 +0200
Message-ID: <CAP8UFD04M2m0_Y5uVpau2BTsJWLq85fvBCVz2VYEcx902dXWBA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:40=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> > By default, or if "promisor.advertise" is set to 'false', a server S wi=
ll
> > advertise only the "promisor-remote" capability without passing any
> > argument through this capability. This means that S supports the new
> > capability but doesn't wish any client C to directly access any promiso=
r
> > remote X S might use.
>
> Even if the server supports this new capability, is there a reason to
> advertise it to the client if the server knows ahead of time that it has
> no promisor remotes to advertise?

I think it could be useful at least in some cases for C to know that S
has the capability to advertise promisor remotes but decided not to
advertise any. For example, if C knows that the repo has a lot of very
large files, it might realize that S is likely not a good mirror of
the repo if it doesn't have the 'promisor-remote' capability.

I agree that it's more useful the other way though. That is for a
server to know that the client has the capability but might not want
to use it.

For example, when C clones without using X directly, it can be a
burden for S to have to fetch large objects from X (as it would use
precious disk space on S, and unnecessarily duplicate large objects).
So S might want to say "please use a newer or different client that
has the 'promisor-remote' capability" if it knows that the client
doesn't have this capability. If S knows that C has the capability but
didn't configure it or doesn't want to use it, it could instead say
something like "please consider activating the 'promisor-remote'
capability by doing this and that to avoid burdening this server and
get a faster clone".

Note that the client might not be 'git'. It might be a "compatible"
implementation (libgit2, gix, JGit, etc), so using the version passed
in the "agent" protocol capability is not a good way to detect if the
client has the capability or not.

In the end, as it looks very useful for S to know if C has the
capability or not, and as it seems natural that S and C behave the
same regarding advertising the capability, I think the choice of
always advertising the capability, even when not using it, is the
right one.

> I am not sure what action the client would take if it knows the server
> supports this capability, but does not actually have any promisor
> remotes to advertise. I would suggest that setting promisor.advertise to
> false indeed prevents advertising it as a capability in the first place.

It could, in some cases, help C realize that S is likely using old or
unoptimized server software for the repo, and C could decide based on
this to use a different mirror repo. For example if C wants to clone
some well known open source AI repo that has a lot of very large files
and is mirrored on many common repo hosting platforms (GitHub, GitLab,
etc), C might be happy to get a clue of how likely the different
mirrors are to be optimized to serve that repo.

I agree that it might not be a very good reason right now, but I think
it might be in the future. Anyway the main reason for such a behavior
is (as I said above) that it is very useful for S to know if C has the
'promisor-remote' capability or not.

> Selfishly, it prevents some issues that I have when rolling out new Git
> versions within GitHub's infrastructure, since our push proxy layer
> picks a single replica to replay the capabilities from, but obviously
> replays the client's response to all replicas. So if only some replicas
> understand the new 'promisor-remote' capability, we can run into issues.

I understand the problem, but I think it might be worked around by
first deploying on a single replica with the new 'promisor-remote'
capability disabled in the config, which is the default. Yeah, that
replica might behave a bit differently than the others, but the client
behavior shouldn't change much. And when things work well with a
single replica with the capability disabled, then more replicas with
that capability disabled can be rolled out until they all have it.

More issues are likely to happen when actually enabling the
capability, but this is independent of the fact that the
'promisor-remote' capability is advertised even if it is not enabled.

> I'm not sure if the client even bothers to send back promisor-remote if
> the server did not send any such remotes to begin with,

If S sends 'promisor-remote' even without sending any remote
information then C should reply using 'promisor-remote' too. I think
it can help S decide if setting up promisor remotes is worth it or
not, if S can easily know if many of its clients could use them or
not.


> but between that
> and what I wrote in the second paragraph here, I don't see a reason to
> advertise the capability when promisor.advertise is false.
