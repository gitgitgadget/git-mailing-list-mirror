Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098C10F2
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734743888; cv=none; b=C8H4XMe3loEwXmFH+yLYtcJQiBPgrqVYPEQgETRc31ctGLADV9qG+wGTyqhuMeEsm1ntenosk2h+enMMmhIYT+193NYMfh2VQiNtHyLFjHHGtKZ1w2CaabUXjtGMzIeer/VfWmCjTE5LvdO/Zq0lsnWMI2VrcUk3WT5KCuArp84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734743888; c=relaxed/simple;
	bh=z47XMIMkM1qhgMw/7iBU/iBfeMstZvQACPA1wIttxW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT2sZf/JyVjb2ZbdR/9Up24kl0Y6+9M1aZvMFh4fYQtKx/9K9Z+rbYa74ClUakAyfYVhsSFNYsuBMpPyha83z2gMQYqtddNwR8OgyYtIBTKOEuwmXvNCAHTZwIaxP38Mr6UW92zYq4rTdbdAkXViastn2Py0gPZZxoeXHxCcAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3LHl7ij; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3LHl7ij"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728f1525565so3004758b3a.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 17:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734743887; x=1735348687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoAgQsRvmoHPYCujqi6jLDD7bi8x9oh2GMoHNovJ4T4=;
        b=H3LHl7ijOVNiJ9MRWf3/qat/BkifbaN5j4pvFtSfRIgA9iD82KkG8OMkQLNsmsQHig
         dnFQDU332wZh/H41Mw2jHW8tDs+kKXsRczOeFxu3akfyi9hc/r9mgIcTrolgT71NQYWo
         7nMGprWdq4Om3aSs3mRIfmmMuXjOG7Y6/HPdDKcODE38pFV/0nKkOnn9Axk0yqvcbugw
         CONkTbcaslk1Mqxqhs0NmJI7kozZ+Ws6+MDGa6iK3X+n2/skcPYYpXkiIrIMpOf8CfYx
         AQj0YYT5S0/WcCOqRFvx/x1Wy/NWEDT1mTt2ZcVo3+Nhk49EEMkSZ8P8JQ8xA0QFcaoJ
         qyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734743887; x=1735348687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoAgQsRvmoHPYCujqi6jLDD7bi8x9oh2GMoHNovJ4T4=;
        b=v6Qs7jR/95imZR8umYgeqSEkGjf7Td/kpP9usXQEjtBTXvT5or6FEoTnug8GqEhAu6
         +cRSqRRKBn5YLt3iGgfB7L7wo7wv8iLL8ikVJ8bHJxaYXZal7oMpq5lZ3Ouwafigrr42
         XS//5d3UBa6MFTdw9sD1BRaH917rqxRcibCy+Cjtb2XakfnVkaHFxa4mCAbOjJA+o1U5
         i9D34kKuG/By7w190UDPEYxKuvxEG8Vj98djw+GAT/orYWkIE4zk9+8oa20ssnJqy9sp
         SppdAfyVmyUOIk9Qrk8TvPB/WYJYQNwk80BZJgeWCG8YyuXgOZYxPY0OTmQeQqZp2uer
         i9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXann0jAPexR2bdPzcMpNsfmrj0qwTg/EXtHoxSW7s6QLqjM42R205zyAx2KBDk33E09Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzG//GNIINMfzlKPM8xPC+45Xs64/YYIUBc4Gd3H1KGjNUaZ/
	PpXbiIBJk99gPlCl7ZWI9S146iD/zqJmLZPYsbYQbJxGYLGzzviuOmY7eeldjizCH12kRYyDdxf
	B01ZRGRE48i1Ia4C0JjRkzQj2tCRntg==
X-Gm-Gg: ASbGnctBzHUleP1SHG7w7bpITuj2/V5VcZLBWSnSxOl04Xziid8dmABrKECUqC/I19k
	aGr6aX0/KmfV4QTUVrthP+XM1nRuThEqEdTCwYw==
X-Google-Smtp-Source: AGHT+IFTwKtQWi21r7EliOr4KYkyszQnyxEXgBXUfyNfWjbpQVIO79LksODSnU7aKCm7a1HP6hJYEl+eRgucpIUbXUs=
X-Received: by 2002:a05:6a00:410d:b0:727:3c37:d5fb with SMTP id
 d2e1a72fcca58-72abde8461bmr6858720b3a.16.1734743886626; Fri, 20 Dec 2024
 17:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADMKT2-vsUUi-23YGexvxbW9wj0Br+cQcv34eStnw-0EDRiKMw@mail.gmail.com>
 <20241219054222.GA2310556@coredump.intra.peff.net> <CADMKT28cZcdW8UJ59vZHoMa0WEbyAccx4A10-jk3MiBkhZLxEg@mail.gmail.com>
 <xmqqmsgrncr6.fsf@gitster.g> <20241220090533.GC133148@coredump.intra.peff.net>
In-Reply-To: <20241220090533.GC133148@coredump.intra.peff.net>
From: Boomman <boomman37@gmail.com>
Date: Fri, 20 Dec 2024 17:17:50 -0800
Message-ID: <CADMKT2_QonR_XbZ5297Df34FrrTpbJp04Qy5BGjPb_Ov=uFF4A@mail.gmail.com>
Subject: Re: git gc does not clean tmp_pack* files
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For me, two "git gc" on a same repo fail to run:
fatal: gc is already running on machine 'WIN-blah' pid 40304 (use
--force if not)

If you're already colliding on this, then I don't see why you can't
use a normal looking name without a randomized string like
"tmp_garbagecollecting", so that each execution would at least
overwrite the same location. In this case --force could append _1
probably.

-Vitaly


On Fri, Dec 20, 2024 at 1:05=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 19, 2024 at 03:17:01AM -0800, Junio C Hamano wrote:
>
> > Boomman <boomman37@gmail.com> writes:
> >
> > > Yes, if the behavior in case of running out of disk space is to just
> > > leave the malformed file there, it stands to reason that cleaning up
> > > those malformed files should be the first operation to do for gc.
> >
> > It is misleading to call them malformed, isn't it?  When a Git
> > process creates a packfile (or loose object file for that matter),
> > they are written under these tmp_* names.  When the processes die
> > without finalizing these (either removing or renaming into their
> > final names), they are left behind, and it would be better if we can
> > remove it _before_ another process wants to consume more disk space.
>
> We usually automatically clean up our tempfiles if we encounter an
> error, but don't do so for partially written packs. I think this is
> mostly historical, though occasionally it can be useful for debugging
> (e.g., indexing a pack coming over the network).
>
> It might make sense to register them as tempfiles in the usual way,
> possibly with an environment variable option to ask for them to be kept
> (for debugging).
>
> That's not foolproof, since a process can die without cleaning up after
> itself (e.g., on system crash). But it would mean that a repeatedly
> failing "git repack -ad" does not fill up the disk. And the decision of
> when to clean up tempfiles in git-gc is less important.
>
> > But the issue is how you tell which one of these "malformed" files
> > are still being written and will be finalized, and which ones are
> > leftover ones.  You want to remove the latter without molesting the
> > former.  And you want to do so in a portable way, possibly even
> > across the network file systems.
>
> Yeah, I think there are two issues being discussed in this thread:
>
>   - when to clean up leftover tempfiles
>
>   - how to decide which tempfiles are leftover
>
> The second one is what the OP mentioned for locking. But not only does
> that have portability questions, I'm not sure it is sufficient. Would we
> ever write tmp_pack_*, complete our process, and then expect our caller
> to do something with it (meaning there's a race where no process is
> holding the lock)?
>
> I'm not sure. We definitely write "tmp" packfiles via pack-objects and
> expect git-repack to move them to their final names. I think we use a
> slightly different name ("tmp-<pid>-pack-*"), but arguably we should
> consider cleaning up stale versions of those, too.
>
> -Peff
