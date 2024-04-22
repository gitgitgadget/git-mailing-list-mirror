Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA11474D3
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811319; cv=none; b=snbNXbsgvtBcm9vpO9acSzzEJFVd1iqArlwyYpWSXvlMJFyjIqpLyS9wtzLL/C0zq6ngkxKwyQRcls3J8SPlKJaX0YBIFGvXy52KXp/wKL7TUxSi0MHoTjY6QJLcB1gQwliulvY2sK5mdziJiaC3P72U0xtt/4sF3tACDA0rJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811319; c=relaxed/simple;
	bh=dsWQGTg9FcByUyUI7EcCYzChq5R9YFjf6Pj8+TeU+so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdQ0BMrNZueoB5y9/ZRYEunOLFpHnhsdEtlh48yXrlSccQD9J4M2QS6sE5d+Dlwq+APSmFgWCk+gAAGaNPe1iOG6z3mlzFBzEVW3hcI0rE9Z6qSfDad95OQAc/yltUkTsNCOwE2D5iR0kjg877Xl39M1xG+V/U0uFPoNa+rDt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/KSZZ6/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/KSZZ6/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-436ed871225so52431cf.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713811317; x=1714416117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FBS5UhkErh5d6Kbx8kxEFRPnMsnoBkNSSqfe+fuXdU=;
        b=f/KSZZ6/Pwz6vYgw/Tonly9cOJFQlIOCYxXY8xkYVePT2CICnx/CI6vbb0+b/vFDAs
         5UY7oWlVXyqdHpHmlj0xUnGmO90LPZB4xPiHuLD/A09nhW26w8gMvvviQwdHcvYUGRcn
         7FFlyIpske94c+XB/fJaOzr0QYtddJ8s6UXpVRPuvu5maGNmBJLCnMULVHIxUJGhdEMO
         mFAvDGmmHRTVqOTFRvXFfucvuVOvUx8gdkNS0dCjiDO2HIDB+UZ+ImoWguN7Hj3sZbW8
         Ciwn/MwOArxZLcWezFaoKHMAnf3JGVIAQkFA1DF9l1kGp9PnnyuEUJKxz7ovWfflhxNS
         KD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713811317; x=1714416117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FBS5UhkErh5d6Kbx8kxEFRPnMsnoBkNSSqfe+fuXdU=;
        b=aUEfP9u94Opx+1zN9SMt1kanEWtBbesKoWMtls5aCMJ25Nug312IY9umyWobnsZ479
         C6PsIHyHi8PS0UnsU9zkVSjmD/rR5FdhwhFamukriPe+DRAP0bxxcVAbGAIdhuXv8SmO
         oCrlKFeoPaLZjCHtJavGzTNmMVqNozjCykMbZPaZZOWR6eDCm9S3XkVH6HixdwmAZcO+
         Ji9WojeJIeg29DKfCl88NDlZaU2mBcQyLD4RjgaPbaP4dZnGO9aCl8IWnZiyPtKwJzGf
         QH/nbs1bdXRYcH9r8mLUJ4k5fDB221omEfsjfA8sS8XtenFy4AQ1jscOXa/xKSi5rp4u
         eSNg==
X-Gm-Message-State: AOJu0YwzUc/N+n24fXmFOcyf0m4M4V1wXigv3sKWyJKcedKZUuEVsVAv
	9A7Ah+l7covtOL/v9ZMGVAZO+dFhleTL6F/tUzSxz1YJczueH7PXNoozafsmu8K5huI5a4t+t3f
	4h5rKjGIIz+FYtiiUzR1KMKc0fqTM+6QgLZBmJ2l3TBArulLKyefw
X-Google-Smtp-Source: AGHT+IEhgMY7ImonCk95cun4sSgNcT0PXKCS/HUMMQZzzhu0F6gIVURpn/13haKJGnDbak8dJACioKmWXI6avDN69Wo=
X-Received: by 2002:a05:622a:1a12:b0:437:a232:295 with SMTP id
 f18-20020a05622a1a1200b00437a2320295mr37218qtb.10.1713811316439; Mon, 22 Apr
 2024 11:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 22 Apr 2024 11:41:43 -0700
Message-ID: <CAJoAoZmOqEd9HcHMrOUwSXNJi2a8DLeO_11gW1h_HuaK79WEVg@mail.gmail.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com, 
	gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:20=E2=80=AFPM Josh Steadmon <steadmon@google.com>=
 wrote:
>
> The Git project currently operates according to informal, unstated norms
> when it comes to making bigger-picture decisions (above and beyond
> individual patches and patch series). Document these norms so that
> newcomers to the project can learn what to expect.
>
> This document explicitly does not aim to impose a formal process to
> decision-making, nor to change pre-existing norms. Its only aim is to
> describe how the project currently operates today.

Thanks for writing this. I, for one, would love to see the process
evolve a little to account for the scale of work coming through the
list on any given day. However, that's a discussion that will be
easier to have once we have the status quo written and checked in.

Last week I attended Open Source Summit North America, and one
recurring theme I heard at many of the talks about project governance
and scalability was that every type of governance comes with cost
attached; one of the costs of a model as informal as ours is that it
takes time to explain over and over how we make decisions, as long as
it's not documented. I actually see this quite often, when we have
someone write in to the list or the Discord asking for permission to
implement a feature, or whether a given change would be welcome.

So, if nobody disagrees with the content of this document, I think we
should absolutely merge it. It will be great for newbies to see what
they're getting into, and for me to send to my boss to explain why my
predictions for my team's patches landing are so broad.

>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

See review below. I had a few small nits, but with or without those
changes, it looks good to me.

Reviewed-by: Emily Shaffer <nasamuffin@google.com>

> ---
> This doc represents my impression of how the community operates. I have
> obviously not been around as long as many other community members, so I
> would welcome feedback if you feel that this misses or misrepresents any
> aspect of how we make decisions.
>
> One particular blind spot for me is how the Project Leadership Committee
> operates, or if that's even relevant to this doc.
>
> Unfortunately, I will be away from the list for a few days for $LIFE
> reasons, but I will try to address feedback promptly once I get back.
>
>  Documentation/DecisionMaking.txt | 58 ++++++++++++++++++++++++++++++++
>  Documentation/Makefile           |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/DecisionMaking.txt
>
> diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMak=
ing.txt
> new file mode 100644
> index 0000000000..80fc732551
> --- /dev/null
> +++ b/Documentation/DecisionMaking.txt
> @@ -0,0 +1,58 @@
> +Decision-Making Process in the Git Project
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +------------
> +This doc aims to describe the current decision-making process in the Git
> +project. It is a descriptive rather than prescriptive doc; that is, we w=
ant to
> +describe how things work in practice rather than explicitly recommending=
 any
> +particular process or changes to the current process.
> +
> +We want to describe how the project makes larger-scale decisions. We won=
't be
> +discussing how decisions are made for individual patches or patch series=
,
> +although the process is similar at a high level.

Nit: "We want to" still sounds like something that goes in the patch
description. If I imagine this doc checked in, I'd rather it says
"that is, it describes how..." or "This doc attempts to describe
how..."

As you mentioned elsewhere, it seems like the process isn't so
different between smaller patches and large-scale designs - does that
mean it makes more sense to take out the large-scale disclaimer and
leave notes on which steps you can omit for simpler proposals?

> +
> +Starting a Discussion
> +---------------------
> +Proposals are made on the mailing list. Because members of the Git commu=
nity
> +have a wide variety of experience, backgrounds, and values, proposals ar=
e
> +expected to include as much context as possible.

Could it be worth making this more explicit? Or pointing to similar
guidelines from SubmittingPatches? For example, I think we like to
understand where the need is coming from - is there a user base in
mind for this large-scale thing? Is it solving a scaling problem for
you somehow? These are things we ask for from cover letters, too.

> +
> +If the proposer is aware of individuals with an interest in the topic be=
ing
> +discussed, it is polite to CC them on the proposal to make sure they are=
 aware
> +of the discussion.

What about "it is a good idea to CC them on the proposal to make sure
they're aware of the discussion, and let them know you're interested
in their thoughts"? Or some other way to point out that CCing people
this way also increases the chance of a lively discussion?

For later,

> +
> +Engaging in Discussion
> +----------------------
> +Once a proposal has been made, the community will discuss it on-list. Wh=
ile the
> +maintainer will often participate in discussions, it is not the maintain=
er's
> +responsibility to guide discussion; the proposer and any other intereste=
d
> +parties are expected to stay engaged in the discussion and ensure progre=
ss is
> +made.

Yes, I like very much that this is called out. I don't think this is
something someone would expect - not all project maintainers operate
this way, so we should document it for our project.

> +
> +Anyone with an interest in the topic is welcome to discuss the matter. I=
t is
> +expected that all discussion will adhere to the Code of Conduct rules.

I wouldn't mind seeing an explicit link to the CoC in our source tree from =
here.

> +
> +Other Discussion Venues
> +~~~~~~~~~~~~~~~~~~~~~~~
> +Occasionally decision proposals are presented off-list, e.g. at the semi=
-regular
> +Contributors' Summit. While higher-bandwidth face-to-face discussion is =
often
> +useful for quickly reaching consensus among attendees, generally we expe=
ct to
> +summarize the discussion in notes that can later be presented on-list, s=
o that
> +the full community has opportunity to engage in discussion.

Could you say why? Between the lines and with my experience with the
project I can understand that that's because the mailing list is The
place for communication, and all official decisionmaking happens here.
But since we're documenting how decisions happen, it seems worth
calling out explicitly that they must happen on this list.

It could also be nice to link to one of the great note writeups from
contributor summits past as an example.

> +
> +Finalizing a Decision
> +---------------------
> +After a suitable period of time has passed, the maintainer will judge wh=
ether or
> +not consensus has been reached. If so, the consensus decision will be
> +implemented. Otherwise, discussion may continue, or the proposal may be
> +abandoned.

I think this captures the status quo. But I'm also left saying,
"indefinitely?! how do we tell people 'thanks, but no thanks'?" Maybe
something we can discuss after this patch lands :)

> +
> +In general, it is not the maintainer's responsibility to implement any
> +particular decision. For decisions that require code changes, it is ofte=
n the
> +case that the original proposer will make the necessary changes to imple=
ment the
> +decision, although it is also common for other interested parties to pro=
vide an
> +implementation.
> +
> +For non-technical decisions such as community norms or processes, it is =
up to
> +the community as a whole to implement and sustain agreed-upon changes.
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 3f2383a12c..a04da672c6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -103,6 +103,7 @@ SP_ARTICLES +=3D howto/coordinate-embargoed-releases
>  API_DOCS =3D $(patsubst %.txt,%,$(filter-out technical/api-index-skel.tx=
t technical/api-index.txt, $(wildcard technical/api-*.txt)))
>  SP_ARTICLES +=3D $(API_DOCS)
>
> +TECH_DOCS +=3D DecisionMaking
>  TECH_DOCS +=3D ReviewingGuidelines
>  TECH_DOCS +=3D MyFirstContribution
>  TECH_DOCS +=3D MyFirstObjectWalk
>
> base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
> --
> 2.44.0.683.g7961c838ac-goog
>
>
