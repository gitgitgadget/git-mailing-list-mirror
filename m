Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E384A3E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058827; cv=none; b=nBgQIA0qMC+HA4jjwUq5wlWvyRkJmYP4QJATFSxPVq8nXp7KPSkcunOB0ZsK6cMSh3klaXVqC4qwcT27ZKDaYJ0tPu5zBRj1TZecSQeX/v++RdXTaQHuGOU4/MyDvT29n/tfwEmWeChDY9njcWiAwI6oEbUleac84/+XxnA2KX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058827; c=relaxed/simple;
	bh=oMep99bHM2/LC1gQxSjA0KuImFL42133T21gpviqhbk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Eo5rXbUNjzSSTk6BbGYdhIR7vxSlNrS62ZWaNJ0HSIcmNxlSFDt6TIk8/W+yHh3q810zcLK6rvYiSvP3PwpxToNjihXJH4w+PZgbmoXFHOdlRq9jwk8vVUc2aZxDgtGCu9SL/Nq03B1c80Yn1+8a+oR7k0VI8TZHM/yGjtTpwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi0xHPUq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi0xHPUq"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-35e721ee868so5738981fa.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758058823; x=1758663623; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMep99bHM2/LC1gQxSjA0KuImFL42133T21gpviqhbk=;
        b=Pi0xHPUqGOtL8rVxDsRKU07861drOacaCWKPIb8LTzjP6VHzVUkyAzcLspJ0zrvchD
         2+RAgqvWo7gzuz7hYjDfdUFHbHjw+wq/qkTE57AKRgzeuEkC1DypNRLu5pAgW5U6y1wy
         QbDeDF/JDdav3bZdnB/jLFi1T4T9KZ0Zizewh5QJFk6La9STnhqwhOExLfXdsylnpJsg
         C7IlKSXVNbFA12CGcNMJ5kEQfn8WthsIJD2WDMiALhiQ2y0D2Raxh+L6imSfett+lg1c
         Hkj4UjDS6GgGYjGY3BFUtQeMWm+61dty2xB1h69waC9x19D+xFm5L0JZIYJvUs7qwf9f
         DIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058823; x=1758663623;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMep99bHM2/LC1gQxSjA0KuImFL42133T21gpviqhbk=;
        b=Dl9kjKUHgzvX7S3ptBc+eUIWUtn7gjggL4N2LlsD0uHgYOWSV99PmLes3ydTLDzzQV
         L1k/Ub7LEZutcajGvwU7Z5PCrEw/tXgEGIDgxF7eaIhvpeaA9kBYSDiXUFB22nQeO0mw
         p/ucCofO0H0EBsbH1BIM/zntZpAbeNK64sXeBtIFij7o90xVV+I/gI4gECauk8fMU6le
         XPGBNv8R8xQ873hyk1hC+A4BJ7Zg3RTUBylEfEjurLWU8MOJbR6eTxEGlwC/OS3wQ59U
         6WTob8VKjmP2cXUUuyg9kMfs+t4KAtt84As5JW4COct9vhElkMAWRds/2rfR0boTtcHX
         Ff9w==
X-Gm-Message-State: AOJu0YzzeeyUP7TH+0s/xP+JKnfKuXsXJCz7JaepEYwLJe52vYIJrdiM
	VVoLWhFJAbQoKPD7M/dvV055qxJU7c2009V02qtUgBRpMm2Z9ZoqX57wN3QXE+KeLgL4yMLfcOi
	w4x84t2mRWp62BmkjfjdIxsbXMNNHdEB4D4Yj
X-Gm-Gg: ASbGnctszphgQB2JJ+A6RRKcaAdJw4w1gOcwbdooZPlipSVyAipMlj4pAhfkW3rTxbv
	OZYNEzBLskZzugRu6EdnFwYit1VMYJSrp3N49g0l0F04HT/yQtDfDrrUPEv5c61GStl4pDsRK7V
	GlkT4ZMYBgTsjiw2F7db8V01qShQOmzZNumYBIpMQajYoalIn840KBmJl4rm8y+2T0oH36a273f
	E2y8w==
X-Google-Smtp-Source: AGHT+IFN3vZECPPK6+JL08/mW8VL0t/ZvJWB20kEGFqoy7dbzimiBVnRSIegiLeuRp7s9XTExPQ+p0+gqs8dVaDwuEM=
X-Received: by 2002:a05:651c:4404:20b0:32b:7472:c334 with SMTP id
 38308e7fff4ca-35f631125e9mr131731fa.16.1758058822763; Tue, 16 Sep 2025
 14:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antonio Mennillo <antoniomennillo87@gmail.com>
Date: Tue, 16 Sep 2025 23:39:46 +0200
X-Gm-Features: AS18NWBCQp3edPJnsaxHoJe0GnpTQBLRhtMgyUyLpXn12GNjP1Xfh8P3gXrY8O4
Message-ID: <CACEPZDXGGn0S_8PpEc=BVHhvyuZhWfiDmbxNOK7iPWJOj1jrXg@mail.gmail.com>
Subject: =?UTF-8?Q?=5BRFC=5D_git=2Drebase=2Dclean=3A_mitigating_a_=E2=80=9Csemantic_con?=
	=?UTF-8?Q?flict_cascade=E2=80=9D_during_rebase?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git community,

I=E2=80=99m Antonio Mennillo, a self-taught developer (6 years). I=E2=80=99=
d like to ask for
technical feedback on a workflow issue I=E2=80=99ve observed during rebase,=
 and share a
small userland tool I wrote to mitigate it.

Problem (observation, possibly a known limitation rather than a bug):
When rebasing feature branches whose commits are semantically interdependen=
t,
Git replays commits one by one. In practice this can trigger a
cascading conflict, similar to a loop. Example:

 - Commit 1: add interface IUserService
 - Commit 6: add UserServiceImpl (depends on 1)
 - Commit 11: change IUserService signature
 - Commits 12=E2=80=9315: update implementation/tests to match

During rebase, conflicts may appear at 1 and again at 6/11, forcing the use=
r to
remember prior resolutions and reconstruct intent across commits. If I=E2=
=80=99m
mischaracterizing the model, I=E2=80=99d appreciate a correction. I=E2=80=
=99m sharing this
humbly to verify whether this is expected behavior or if there is prior art=
 I
should be aware of.

Mitigation (userland workflow): I built `git-rebase-clean`, which
squashes the feature branch first and then rebases. This concentrates
conflict resolution into a single atomic step with the full final
context visible. The obvious trade-off is commit history granularity:
you lose individual commits but gain atomic conflict resolution. In my
experience this reduces repeated/conflicting resolutions across
dependent commits.

Usage (data points):
- 5+ months in develop/UAT, used in production environment today the first =
time
- 30-40 feature branches processed
- High reduction in conflict-resolution time
- Only incidents observed: some IDEs (e.g., IntelliJ) occasionally
fail to load all conflict markers when many conflicts concentrate in
the single squashed commit, requiring fallback to command-line
resolution

Repository: https://github.com/anthem87/clean-rebase
License: GNU AGPL-3.0-or-later for v2.x (earlier tags remain MIT for
historical reasons)

Questions:
1) Is this "semantic dependency" pain point considered an expected
limitation of git rebase, or perhaps an inherent trade-off in the
design?
2) Would you see value in documenting this squash-then-rebase pattern
in Git's guidance (or `contrib/`), as one possible workaround?
3) Are there existing internals, extensions, or directions you
recommend for handling dependent commits more gracefully?

Context note (authorship & licensing):
There has been growing interest around this tool after real-world use
within my company. To avoid misunderstandings about authorship and
usage rights, I transitioned new releases to GNU AGPL-3.0 while older
tags remain MIT; my goal is to preserve clear attribution and set
appropriate terms. If this licensing discussion is out of scope for
the list, please disregard this note.

I=E2=80=99m happy to adapt the tool to community standards if there is inte=
rest.
Thank you for Git and for your time.

Best regards,
Antonio Mennillo
Naples, Italy
