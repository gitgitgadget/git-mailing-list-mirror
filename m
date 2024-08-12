Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39517A5A3
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466081; cv=none; b=LFiwgUEAwbCKzhZAnnmLyye7/M/t4hqUSG9GI0q/a/JXMuWjTiGJggjycM0n15S5OAB7vqtO70EdWI9tbVla7VmMNIY6Ga1mWzRDWbdfeadxWj8+4OWtOF3l9bCvNPNXG4ahoWpQ2XO9MgeWZMxZn+MHdqj4d2RQdgx1gvoj55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466081; c=relaxed/simple;
	bh=e/Y+hIU+aYxRGBIXbv9DmfM5RQylKpC9ION+uI0BSGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1HWepht9TaqRBOlslmwrG6gO79mDDvaVHnrdnCqx9JDMDHfSDtqWlegZruPrqTD1un4wGl2zK+6rlhEx4aJ1UaagIJjCuhni86m06DuBTL7BoJIWrO30/5VvX6ubhVJg3Paeq1shmyUkBbY0UnATeC1Biq8W1O2Wp6aJHbIO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bXl+qxrw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bXl+qxrw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5549788eso38860855ad.1
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723466079; x=1724070879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbfYCuGW4Qk3IbZoAzZpMzC3F1iMgnnkcmXZNrhSNXw=;
        b=bXl+qxrwo07Ml2U+5UFRMcWpeHRBmhWQdPBXPkgRznL/fYUIzkhX/pVwfmc5nzzMcJ
         XqURVzOGNes++i/u9Uz9eiMKCpcvBCxO0tWm8vtogkpiAEh4uuAW0tuDaXY2C5+52aMA
         21XNr4l3TH14nQUrwwJws62h57+7Ox1jbYvZ6QMjYE0ujehKmM9j83zguqonDZbrlGWl
         j3StkCQcEM0fRMbE88zXnhRToYHKABDtxGDAmeMRbK5KK76nnlwVKTjOnGeTbuWuiwPn
         NJcVQy3RF/jqvwgcxK4arNxUuXfUc0ACcGGrOBM5kw3aDYvxbnpIbM8yIe6VKm12zTgA
         qeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723466079; x=1724070879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbfYCuGW4Qk3IbZoAzZpMzC3F1iMgnnkcmXZNrhSNXw=;
        b=ggk95JxI0J0Ney4DmPOPlnY1o09soc8lT8n0bnybIuj9bkmTzJp+ORz211vOdK7vRu
         5hyIN/2ixo5inIGE/M8HbpZb4uQwjPyIww6JvDBMAJsfytvGC3JR3NXm4GvttO3PJrKi
         2eXfxT/kkP8nc+A69mCUYkiJvxyvtmRISnhxgvuWGb9FZ4KIiN/xWzXE/HzVFlyvli5Y
         cW8Q8AFkdqqjkxpBZ2B0HEQQBClmmLu/htF9oTVevl3IbdB/VlnTGCBPSQgnRvdUfdKd
         A+W1W17AFYzWlrct/+06H+soEmQZPA9G121xFPKB2mN2XSFoL94hG6ZJ3/LzTUIwQkHd
         fdtA==
X-Gm-Message-State: AOJu0YyK5L0WwI+wNLz+2zmK39ScxHLNR8kmXXXNePCf3ebl/vSKyr88
	xhH7ir/dMeblz6DpUrKdcnZBu/brwKJPPlKJZmLodK6QI9w3AfIro/9GXmKcJNcK6C+C86TKQf2
	H1EhPDhSyih2D+TIno35KDkwMexnkBikYakjbmg==
X-Google-Smtp-Source: AGHT+IFO6V9h+3ikrqcD3xNsibC20UNzjMG7Kq/wP20BPw00UOok1JUIbaj32eBSLdNwwVmtF3lurFuPctV3P5F0Lj0=
X-Received: by 2002:a17:902:ce8e:b0:1fc:5fc9:84bc with SMTP id
 d9443c01a7336-201ca241755mr1217865ad.62.1723466079186; Mon, 12 Aug 2024
 05:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240802073143.56731-2-hanyang.tony@bytedance.com> <xmqq4j82euvr.fsf@gitster.g>
In-Reply-To: <xmqq4j82euvr.fsf@gitster.g>
From: =?UTF-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Date: Mon, 12 Aug 2024 20:34:27 +0800
Message-ID: <CAG1j3zEQh3xujrU3tGOftwvCZ+d9RjvMHw8v4W3dqd3DsiGCUQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] revision: don't set parents as
 uninteresting if exclude promisor objects
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, 
	Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 12:45=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> > diff --git a/revision.c b/revision.c
> > index 1c0192f522..eacb0c909d 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -1164,7 +1164,7 @@ static int process_parents(struct rev_info *revs,=
 struct commit *commit,
> >        * wasn't uninteresting), in which case we need
> >        * to mark its parents recursively too..
> >        */
> > -     if (commit->object.flags & UNINTERESTING) {
> > +     if (!revs->exclude_promisor_objects && commit->object.flags & UNI=
NTERESTING) {
> >               while (parent) {
> >                       struct commit *p =3D parent->item;
> >                       parent =3D parent->next;
>
> But if the iteration is over all objects in certain packfiles to
> mark them all uninteresting, shouldn't the caller avoid the call to
> process_parents() in the first place?  Letting process_parents() to
> do other things and only refrain from doing the "this commit is
> marked uninteresting" part does not quite match what you are trying
> to do, at least to me.

Thanks, I agree process_parents() isn't the right place to fix the issue.

> It apepars to me that its approach to exclude the objects that
> appear in the promisor packs may be sound, but the design and
> implementation of it is dubious.  Shouldn't it be getting the list
> of objects with get_object_list() WITHOUT paying any attention to
> --exclude-promisor-objects flag, and then filtering objects that
> appear in the promisor packs out of that list, without mucking with
> the object and commit traversal in revision.c at all?

The problem is --exclude-promisor-objects is an option in revision.c,
and this option is used by pack-objects, prune, midx-write and rev-list.
I see there are two ways to fix this issue, one is to remove the
--exclude-promisor-objects from revision.c, and filter objects in show_comm=
it
or show_objects functions. The other place to filter objects is probably
in revision walk, maybe in traverse_commit_list?

Thanks.
