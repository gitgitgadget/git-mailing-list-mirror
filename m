Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1A78F2F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500535; cv=none; b=HEdeLqYOCyiSJ+oyLyZsZAINzrsMc1GggSahX9bjmjN1VwscxBAdUW+tU9io6LgOPIlejkfLB3gPw8FMhAz5cDeNf5IYvb+Vp2aUBFrCPJBIFUBP3ab44rwXav1s5jUg2sUOgfS+unrG307lzrKxq5PUgfG5Ea1goBnIT2etarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500535; c=relaxed/simple;
	bh=mVLiOrD4OhJYEUXcFe3qF/AFplpxW9+u/NMIZjr8/7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WX6yqZcdrw0uHCEU8vrEX0e7G55RUDkQUXeFYqIGnPAX7iXAWfAugPfdJn125iUR2SiFaFdTYLBW5yHKrupIbglfQ7V/rzH7WsYhOyXP+lJPsanrz21dbMFnr5FkO1ZyQEfQY/BrRll/Mn+xKlIz9xC8zAN5ZfUxf8xGyjG+N34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NCQg+WeW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NCQg+WeW"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-808cdfc2d34so21886667b3.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500532; x=1783105332; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2i8Gp3sHUDjcGxMSl94/i1uGkJREDNkH26qLZpTTkec=;
        b=NCQg+WeWpGL7zYC6CfRdIX97/z4Y7cA1wf1ymvvG5skaJf9A7QA2auErGd7caXV3pN
         ETe0mkifYYOTTrm0U1RD99OnDh0TCziy+AYuWojm1dI2OB5IRenV48p5eiWcxwXCA/Yd
         4aoezkjwau6AJZLqkNmqKBOtKdCciBc83gjc/lFSB9AIvP+yhACZ9mQIEfz1kbseCd9+
         L31gb++GGzpseDnwOpxndcsET20BZYaGTq06mz/c4Xxy09n8Ca+k9lgecLbfCp2Hw7Fv
         +cGZFLcMbzG3/Rqhud+RMROfReuZN02zQWuwcc5FRCs9xea42uPPr/G881HGOvcO8qPz
         zMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500532; x=1783105332;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i8Gp3sHUDjcGxMSl94/i1uGkJREDNkH26qLZpTTkec=;
        b=rTr6d/CTiFK4grKFLUTzsdUb5GB5a+lOwn+7YxLYhKmtTlFje1C3AemY20Pm3emlE/
         7P2RMIf2RGblmxfz5VoYUIDU3stFbGaQOL2YibJGLuc+3d/tSDk2+3Yy+d+nK2Rh33S4
         dVFljjFgsVKwJp3kNUVNbv9FzD3daXd/+9uUbVpuLhXbI/0AUMD+RqcC9k5jyWX3CDw0
         9IYqKQlNhbYsQMMqNyWxTXhK1pB1FqxocnhfMNOfVuYfOgy09HPCjD3is1+xQTZ6KFLB
         LifUW/PuCdp+iopgi61j6KNqNSBo/5HN1VvwYJNby3bxXmnNJxvP7IchkKmIau4xhYok
         Y8Ng==
X-Gm-Message-State: AOJu0Yy/nfehW9R6W+IMHPN1xKo944RLv+vsOu1epTD0F6YkKM7K3XgS
	1vIhDKV7RVjvHrPmab0k2dU6W93IJ7m/VntoFlC7E4D8ZIssV7vVrIJC6yKGSUFMddyf7zoZaCl
	jCTqgUtQsEg==
X-Gm-Gg: AfdE7cnSNO7OWC8gwXKHcZXcf5eY3MttAT3qwDtv0mLZJNlYTvAByzUzORJ/Hi58tqF
	25reKzebsBS0q53kl/9TXY5TflRVsqls8ggNkIWM3iUmg+ezfg9hIGMZXlNWD9EqULKzEdZ26iw
	vvYUzGPpY4aC7Q1YX48DQlUrRCRtQyP/hlkldPFAu0SwwvrAIrHzob5AILUKnTBHCDwwRmzU2ig
	O9JLFgdSYUFuk9qgHSLcwr1DlUgO0mLMTg27X+6APqHqYJdEA0Twvd7pMy2ABl3gT+k/R/9LxK/
	IqhpgypJZ+yauglAriSu0lQqv0ZfNlTNuid9gbCyqaHDOfvSP+rRCHRCQfYYmzDofCLrktI7BRK
	uCu9gbbHYzv6lM6+18l9qT7BoClBMpOGd0WcRilH0CHuAuGp+XOzMDKUF1vwXtpds0BI4B+Y89O
	4H1s/IabK5ssBskUOWCpRh2O/rTnayNZJhMp/h2S2uOGPe+l7BPxNoKusCNX/fj4mMz+0NFzazE
	7KIBKAZrNjkp8jB2YQP4wZGE6aipTeH44Z2GalNneXRKykYyKPJJ0shxJq/U5Dxj/ws31NCrsBI
	V1QGxQ==
X-Received: by 2002:a05:690c:7343:b0:7f8:7e50:638d with SMTP id 00721157ae682-80c745e84b9mr19061587b3.47.1782500531842;
        Fri, 26 Jun 2026 12:02:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8096af28592sm34045707b3.22.2026.06.26.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:10 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 00/10] repack: combine '--geometric' and '--cruft'
Message-ID: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

First, a short note. This series is an RFC because I have not had the
chance to review and test it as thoroughly as I normally would, and
because we are deep in the -rc phase.

I wanted to get this series off my backlog since I have decided to leave
GitHub at the end of the month for a new role. I will still be
contributing to Git in my new role (which I will start in the early part
of July), but wanted to get this off my backlog nonetheless.

This series teaches `git repack` how to combine `--geometric` and
`--cruft`.

Today these two modes are mutually exclusive, since `--cruft` implies
`-a`, and `-a` is fundamentally incompatible with `--geometric`. As a
result, repositories have to choose between keeping reachable objects in
a geometric progression of packs and collecting unreachable objects into
cruft packs.

The goal of this series is to to be able to do both simultaneously. When
both options are given, 'git repack' rolls up the selected non-cruft
packs as usual while collecting unreachable objects separately into a
cruft pack. That means a command like

    $ git repack -d --geometric=2 --cruft --combine-cruft-below-size=1G

will keep reachable non-cruft packs in a geometric progression, while
combining sufficiently-small cruft packs (along with newly-discovered
unreachable objects) into a fresh cruft pack.

The series is structured roughly as follows:

 * The first two patches prepare the cruft pack machinery for the later
   changes by making non-kept pack exclusion unconditional and
   extracting a helper for looking up packs in an `existing_packs` list.

 * The next four patches route geometric pack deletion through the
   common `existing_packs` machinery. They mark packs above the
   geometric split as retained, teach incremental-MIDX retention not to
   keep packs that are being rolled up, switch geometric repacks over to
   the common deletion path, and then remove the old geometry-specific
   deletion helper.

 * The next three patches teach `pack-objects` the new pieces needed by
   this mode. The main addition is `--stdin-packs=follow-reachable`,
   which walks from reference tips and includes only reachable objects
   from the selected packs, while still allowing traversal through
   excluded-open packs and stopping at excluded-closed ones. The
   following patch teaches that mode to use `--refs-snapshot`, so that
   `pack-objects` and the MIDX bitmap writer can agree on the same set
   of tips.

 * The final patch wires everything together in `git repack`, including
   teaching the cruft writer how to interpret the geometric split when
   choosing which packs to include or exclude.

Thanks in advance for your review!

Taylor Blau (10):
  repack: unconditionally exclude non-kept packs
  repack: extract `locate_existing_pack()` helper
  repack: mark geometric progression of packs as retained
  repack: teach MIDX retention about geometric rollups
  repack: delete geometric packs via existing_packs
  repack-geometry: drop unused redundant-pack removal
  pack-objects: extract `stdin_packs_add_all_pack_entries()`
  pack-objects: introduce '--stdin-packs=follow-reachable'
  pack-objects: support '--refs-snapshot' with 'follow-reachable'
  repack: support combining '--geometric' with '--cruft'

 Documentation/git-pack-objects.adoc |  25 +++
 Documentation/git-repack.adoc       |  11 ++
 builtin/pack-objects.c              | 276 ++++++++++++++++++++++++----
 builtin/repack.c                    |  38 ++--
 repack-cruft.c                      |  29 ++-
 repack-geometry.c                   |  44 -----
 repack.c                            | 101 +++++++++-
 repack.h                            |  15 +-
 t/t5331-pack-objects-stdin.sh       | 201 ++++++++++++++++++++
 t/t7704-repack-cruft.sh             | 251 +++++++++++++++++++++++++
 10 files changed, 878 insertions(+), 113 deletions(-)


base-commit: ab776a62a78576513ee121424adb19597fbb7613
-- 
2.55.0.rc2.10.g29e31820dce
