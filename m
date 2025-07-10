Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594ADF49
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109530; cv=none; b=ru6mkIlqK/w6XlYREGWYOizYFXrG7/qVIqa+Gpmr0lLnPwJ3iqKim4faZ+c5GD4cemB+oFpBvsLyT2F5GDXZTYgslduh1tmL2tr23+6EYzqOcM7xjm+xLv9PClhfZ69UNIWojPS7CgQKaqOoXptN+OSUcXzLZBHsSDYjDHYVdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109530; c=relaxed/simple;
	bh=3tHWvtOt0A/e/TKdahPjfh+/pqG4HJHNzUjzyVOlx/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee63uik6ArK45R56vVIgMz27IvwMkTwehlS5kXGu6iyi0Q2vqZWfPvT12UDM0z6yRC4zV33nLpr05npN007t299RI5qF0pPVAOv5JchMVcOu6L/x1ehYLIoXQpj9+7XcvhIaoFTfDW14TAyOEz2aXDb5lXcbTZM+b7lX0D0HPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwWsGjj9; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwWsGjj9"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2e7cdc64so3786415ab.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752109528; x=1752714328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCbrJu2JSOjBJ87rFvbAvRgssc52IQDpdMnyH7DemaY=;
        b=cwWsGjj9K2dP5H9FXyf5bqJ27WerKhrFVjUV/b4NY1yyd3/F3mkUhHoRhebPBDzO7G
         fprQXVKEXZJhEE/1C/1NxwwJ1OlmjPbIVG9ryLzau82BAX/R4oH8h4tWfYlLKllDyERu
         W/H2U3RBskTaSPNECAnn4Hh59OvBgjN/JG8L85GLOYxhq3BiOXS30u7HYAB7BaxlVm/t
         b9MvGqpjyFzcReD33+OAYynwDFqVzPz40KqnlGahg1qp04ukIQx5D510Y2+aP5al1blx
         zk9nY6GGROvV6UqPOYAOIEz5VPmF5jc5O1hyA6e5uBhCzls0CvyQWMeNDS9pLmiqdM0+
         kmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752109528; x=1752714328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCbrJu2JSOjBJ87rFvbAvRgssc52IQDpdMnyH7DemaY=;
        b=PZ+FWFROw2dpq2aU/TYJ4vSTUnTqI1K4EORBuKGwzKdfjhZtC/a/d6RAeOZHT3SU65
         UVlCMtljlu2AbjOZpMG8Dlj8FguT0HgqrBjJnkOgA29ybmZSI7UGm5hi3JnebkXrTk1x
         5UxXvkCifEAudn+MlgdxPL+0df9/jWyBGiAn7P+2TVER+Lkd5Tjrf9VRipbqUTG9R7DK
         /yACYNN4KqNZWhmrcCoxZzfEi9mPA6JJ4Q4dIozpQNlOxRNr6Y1Fv9BwUzRs1RE3Lyws
         lqRIT8NI36msuDtkWBF3ucxhDfoEkTKGq9uM6yBUJzpvjIMd6Z4NHJHKNMAy0TvsuV4D
         HNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlP6m3BDta00r6qsQpiQ/sm6PxERDfvXKt7tGDM3ZeqjvD2viSCfDzeLW2z8ZUhaF7r9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygd7QfwXrTozFqA/RO1Ld71G33E2J9nWlFZhjHWr29j2muxw8t
	AZRcvT7jdkwYqyEhuQA0JgtM/eKGHO0EvvkTVJCUIERe6e2JGv0UktXccy0UTEccpvy39ghnE1X
	Gi6YY4GtMBp8LW4myS5O8fKOeusmfJa67zg==
X-Gm-Gg: ASbGncu2V/ejrL0Z8tNMgTDR09XffmL0K2WJISloG+zwfP85E7jSVUdzuyCL8+uLhMb
	ZGyALb4QoH9cZb3jeVIaIsZkSYq70xnF0l7zAzwgZwpFtM3Qzywq3w9s44WGxwYEyq0fXQya8B2
	QWtGRcA1KYxxsLMxxwCkOztEaPvKf+Fe5d9FCaObYQTjuyF/vbaEluV3B+/2nh0Bu/svYBvvFqp
	I0=
X-Google-Smtp-Source: AGHT+IHqovRI5wSbCqv1Pl60jJLdRqJIocLzUZS5CA6q9v6Q3ViFZL3lruhbXjKGxGHXUAxDiY0koqkmASirrgdtcMU=
X-Received: by 2002:a05:6e02:16cc:b0:3df:3b77:1ed8 with SMTP id
 e9e14a558f8ab-3e167018cc6mr55463535ab.7.1752109527899; Wed, 09 Jul 2025
 18:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqplebzgm7.fsf@gitster.g> <aG6A19ZgxwpdJuow@nand.local> <xmqqecuoap89.fsf@gitster.g>
In-Reply-To: <xmqqecuoap89.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Jul 2025 18:05:16 -0700
X-Gm-Features: Ac12FXypJoov-5jh6SqbYBPAS52t6dyMUEhL8CLzkGuanScn_LkpcU5pQX4oioI
Message-ID: <CABPp-BHRf52jD31ioiDj_j9eOkZk0sHxPUi1ew=m3UPd+N57OQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> * tb/midx-avoid-cruft-packs (2025-06-23) 9 commits
> >>  - repack: exclude cruft pack(s) from the MIDX where possible
> >>  - pack-objects: introduce '--stdin-packs=3Dfollow'
> >>  - pack-objects: swap 'show_{object,commit}_pack_hint'
> >>  - pack-objects: fix typo in 'show_object_pack_hint()'
> >>  - pack-objects: perform name-hash traversal for unpacked objects
> >>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
> >>  - pack-objects: factor out handling '--stdin-packs'
> >>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
> >>  - pack-objects: use standard option incompatibility functions
> >>
> >>  "pack-objects" has been taught to avoid pointing into objects in
> >>  cruft packs from midx.
> >>
> >>  Will merge to 'next'?
> >>  source: <cover.1750717921.git.me@ttaylorr.com>
> >
> > I think that this one is ready to go. Since Elijah and Peff last
> > reviewed it, it hasn't changed substantially (other than a few
> > bugfix-related changes that were discovered while rolling this out at
> > GitHub).
> >
> > The series has been running on GitHub's production infrastructure for
> > the last month or two without issue, so I think this is good from a
> > stability perspective.
> >
> > I've CC'd Elijah and Peff here, since they were the last two to review
> > the series, but I don't think that they have any objections to this
> > moving along.
>
> OK.  As they both seem to be active, let me wait for a bit and then
> mark it for 'next' unless we hear anything unexpected.
>
> Thanks.

Yep, I think this version is good to merge to next; thanks.
