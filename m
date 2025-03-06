Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F120A5CF
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260022; cv=none; b=ip3ZIvYWvvQ6/C4l63DAjN/9QjhbPueQUAVzegADBkLl6X7e3CcQEHF34G53PP83fZ5Z4BZKocZxd9Ja4iCIc0EXc+t7F18/dAFyTvH+I4ZnLWSytlzQNLgaf6sI1lLPAcnKLVRWskIowpJ9lucdzXvGb1fBHx+fTQcmAZ7tFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260022; c=relaxed/simple;
	bh=eUWNhBvjD2u2LXn2sXVRuUuLQylJvz6aqUI5oTQ8xu4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=o45Ik9gSkqpkdkv+34jo51SX9ABK50s2EOwUCkSYvIb7tqrLy1aEo215vppnMGNYuBRcnn7ufh/5OJ6k4REc2PgM8dzoN2DgtYoDjzbnmxCIg2etsJWU+YZJhe9OzyQ9QR30WvpNnfx/7hnkTl7v3HhMwto2KN+w7La3Pi0mIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOFHPqsR; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOFHPqsR"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso201661241.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 03:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741260019; x=1741864819; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDu34rgpExjMxaKdgogr+Wns9HzEKcqmJ58m0CnZ7kM=;
        b=UOFHPqsRE4mh1AqZUUxzSpflQ9wkRQd0y4HGBsm9EiNMth0tLbTjCRXXJb16NFnSvW
         cOd/L8WXsB3F3yj3drX6lyOvZcrSVDPaqFu/5FS0+CW1amxYCqXWViSFAStpebMvZcKL
         UJB9VU/QH26TDQee9HeoFFMMpeZDZrReruFLwizoMk2nInpK5t9srUbm5GZx0LhM+CUS
         npwpC24KIIrBX4bkRxrWBKgFjVBgPu8ADzRgXZNEDXfT31o7zJlf7ZGsega4V/GN4V0E
         wFaIjy+PmM3Om64duMOHV6m3CByxo1wHB+mL4BdBUnW8WzMajcw96SnlfkaP8qfgG5uW
         qhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260019; x=1741864819;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDu34rgpExjMxaKdgogr+Wns9HzEKcqmJ58m0CnZ7kM=;
        b=W3Ol58d934xbozQ1XlqN+37unA5/Me2K5Pjyi+yW1s1Ke3MA4zoEcHkr8Dilp0UOxg
         6gRlZ5QxxUHla4DfG9f3bjVp+EPIh0rcxYpMB33J4IZKNrnu50l7n5/Ow5kpoY02qa7q
         U4Q5s4gtEqa/8CEGHnquAGJ6I8nAMHgYUYWveGYgB230toIyf/rw6hlh/VemTN3fLgkF
         i1OVniRWa+2YELfA5P22JTPK1igcd6UKDh5V7E1Yv6UwLI7P8h83U4TEDafYUmFHxSEI
         mQRRMX20Si5bqb5QrjfuYPEVxEgqMPscv8sblKGQDo40UtgVSLCXbk6uH3t1WeEzBKfT
         SZqg==
X-Forwarded-Encrypted: i=1; AJvYcCVQwL+8FJPOdIQKl5pD84/AQSrYcs6/QHA1zL/mK+CkFqRnRDYx6igYoa5efnHgesmc1nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3LCGn2tWTfO8LX89YPqiLVqtZmD6w/DUOJOJ6c0xVHfZ2xjw
	W9eZbSCkzzE32Rw+jfkL0CVhI8mLf2cbIueImMl0sXqp6uUszpvPNlmPqXsgDmHQYqhLxEGhAYo
	pwxFTPM2/BkN0tz2iRXd/KBIqN5o=
X-Gm-Gg: ASbGncvjxV4sn7Uh36uMPSacdMQOneO57uVhDaTBNzsfXWM0xEJ43xZ/LwvK1ag7Dlr
	ZU/6PugG74+C+/mRTX2wGwa0VoGTPTO3xqVqxBKwuNpJfsoUvfcGz4gUm6tWycNW39GA9OWoMg1
	6ClVduhQAmUxYnDTEZ2Ar8rAwN
X-Google-Smtp-Source: AGHT+IHsS3ygFYDf6pOdoSa096hMkWCzuNYSQU2JysB9rAiBMgY2mKNZ3QHL9V6ymKOlHla90TwMJCLIR+szSahLitQ=
X-Received: by 2002:a05:6102:6e89:b0:4c3:43e:5227 with SMTP id
 ada2fe7eead31-4c3043e5486mr58162137.9.1741260019575; Thu, 06 Mar 2025
 03:20:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 03:20:19 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 03:20:19 -0800
X-Gm-Features: AQ5f1Jpz8tWKPakjro-sxD2nbIGXawuYC6fvPoj2qhmkGNX80w0-aaBf9Bd42ms
Message-ID: <CAOLa=ZR8x_7xPKTVf+9kxsCLFb2BN+GwqLkAOeXZfZyNk9cF+w@mail.gmail.com>
Subject: Re: [PATCH 00/12] Stop depending on `the_repository` in
 object-related subsystems
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000edcbd8062faab0cd"

--000000000000edcbd8062faab0cd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series is another step to remove our dependency on the global
> `the_repository` variable. The series focusses on subsystems related to
> objects.
>
> The intent here is to work towards libification of the whole subsystem
> so that we can start splitting out something like an object "backend".
> It is thus part of a set of refactorings aimed at allowing pluggable
> object databases eventually. I'm not discussing that bigger effort yet,
> mostly because it's still taking shape. So these patch series contains
> things that make sense standalone, even if pluggable ODBs never get to
> be a thing.
>
> Note that this patch series stop short of dropping `the_repository` in
> "object-file.c". This is a bigger undertaking, so I'm pushing that into
> the next patch series.
>
> The series is built on top of cb0ae672aea (A bit more post -rc0,
> 2025-02-27) with ps/path-sans-the-repository at 028f618658e (path:
> adjust last remaining users of `the_repository`, 2025-02-07) merged into
> it.
>
> Thanks!
>

Had a look at the series, I only had a small nit or two. Looking great
already!

Thanks

> Patrick
>
> ---
> Patrick Steinhardt (12):
>       csum-file: stop depending on `the_repository`
>       object: stop depending on `the_repository`
>       pack-write: stop depending on `the_repository` and `the_hash_algo`
>       environment: move access to "core.bigFileThreshold" into repo settings
>       pack-check: stop depending on `the_repository`
>       pack-revindex: stop depending on `the_repository`
>       pack-bitmap-write: stop depending on `the_repository`
>       object-file-convert: stop depending on `the_repository`
>       delta-islands: stop depending on `the_repository`
>       object-file: split out logic regarding hash algorithms
>       hash: fix "-Wsign-compare" warnings
>       hash: stop depending on `the_repository` in `null_oid()`
>
>  Makefile                                     |   1 +
>  archive.c                                    |   4 +-
>  blame.c                                      |   2 +-
>  branch.c                                     |   2 +-
>  builtin/checkout.c                           |   6 +-
>  builtin/clone.c                              |   2 +-
>  builtin/describe.c                           |   2 +-
>  builtin/diff.c                               |   5 +-
>  builtin/fast-export.c                        |  10 +-
>  builtin/fast-import.c                        |   8 +-
>  builtin/fsck.c                               |   6 +-
>  builtin/grep.c                               |   4 +-
>  builtin/index-pack.c                         |  16 +-
>  builtin/log.c                                |   2 +-
>  builtin/ls-files.c                           |   2 +-
>  builtin/name-rev.c                           |   4 +-
>  builtin/pack-objects.c                       |  17 +-
>  builtin/prune.c                              |   2 +-
>  builtin/rebase.c                             |   2 +-
>  builtin/receive-pack.c                       |   2 +-
>  builtin/submodule--helper.c                  |  36 ++--
>  builtin/tag.c                                |   2 +-
>  builtin/unpack-objects.c                     |   5 +-
>  builtin/update-ref.c                         |   2 +-
>  builtin/worktree.c                           |   2 +-
>  bulk-checkin.c                               |   4 +-
>  combine-diff.c                               |   2 +-
>  commit-graph.c                               |   9 +-
>  commit.c                                     |   2 +-
>  config.c                                     |   5 -
>  csum-file.c                                  |  28 +--
>  csum-file.h                                  |  12 +-
>  delta-islands.c                              |  14 +-
>  delta-islands.h                              |   2 +-
>  diff-lib.c                                   |  10 +-
>  diff-no-index.c                              |  28 +--
>  diff.c                                       |  14 +-
>  diff.h                                       |   2 +-
>  dir.c                                        |   2 +-
>  environment.c                                |   1 -
>  environment.h                                |   1 -
>  grep.c                                       |   2 +-
>  hash.c                                       | 277 +++++++++++++++++++++++++
>  hash.h                                       |   4 +-
>  log-tree.c                                   |   2 +-
>  merge-ort.c                                  |  26 +--
>  merge-recursive.c                            |  12 +-
>  meson.build                                  |   1 +
>  midx-write.c                                 |  12 +-
>  midx.c                                       |   3 +-
>  notes-merge.c                                |   2 +-
>  notes.c                                      |   2 +-
>  object-file-convert.c                        |  29 +--
>  object-file-convert.h                        |   3 +-
>  object-file.c                                | 292 +--------------------------
>  object.c                                     |  21 +-
>  object.h                                     |  10 +-
>  pack-bitmap-write.c                          |  36 ++--
>  pack-bitmap.c                                |  15 +-
>  pack-bitmap.h                                |   1 +
>  pack-check.c                                 |  12 +-
>  pack-revindex.c                              |  35 ++--
>  pack-write.c                                 |  55 +++--
>  pack.h                                       |  11 +-
>  parse-options-cb.c                           |   2 +-
>  range-diff.c                                 |   2 +-
>  reachable.c                                  |   6 +-
>  read-cache.c                                 |   4 +-
>  refs.c                                       |  12 +-
>  refs/debug.c                                 |   2 +-
>  refs/files-backend.c                         |   2 +-
>  repo-settings.c                              |  20 ++
>  repo-settings.h                              |   5 +
>  reset.c                                      |   2 +-
>  revision.c                                   |   3 +-
>  sequencer.c                                  |  10 +-
>  shallow.c                                    |  10 +-
>  streaming.c                                  |   3 +-
>  submodule-config.c                           |   2 +-
>  submodule.c                                  |  28 +--
>  t/helper/test-ref-store.c                    |   2 +-
>  t/helper/test-submodule-nested-repo-config.c |   2 +-
>  t/t1050-large.sh                             |   3 +-
>  tree-diff.c                                  |   4 +-
>  upload-pack.c                                |  14 +-
>  wt-status.c                                  |   4 +-
>  xdiff-interface.c                            |   2 +-
>  87 files changed, 676 insertions(+), 613 deletions(-)
>
>
> ---
> base-commit: e2cb568e11f4ceb427ba4205e6b8a4426d26be12
> change-id: 20250210-b4-pks-objects-without-the-repository-6ba8398f7cc0

--000000000000edcbd8062faab0cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: df42d76f6ad8aeb0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSmhQRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDhvQy85SWZuak0zWmlVZFB2K1VocjZqZkpBQW5jQQo1VjNXbTZKaDVV
a1ErWmlzZExGUFJBTFlHejRtbEkxREl5UnpsOWFNL2I3eCtYdEhpd2VNa0NUVEJnQk5mQytrCi9s
R2VVOHZiQXljUXBHMEw5TC84UVpwL2tFQUk1VkVWUGl4T1dDVzFBZ1hLTFFDK1gvdzhTY2lsdCsx
bmFQMTEKRDFpUVJmNVdVS1dxMi9TSjNxRERzdHJHbjBwTmlEVngvcjdKbWY4ZjNUYWdjaGttMkdM
eTN3L1dvclZrWjVXQQp3REhIU3JhZ2Yya2tsZ0Q3RHN2VXpmTzhEODJHaUUrL3NILy9pcGpqQXBL
cWFFZklJUHJReGl3cVRwS04yUUE2CmVHMTd5WGQvUDU1TGhJczJrakp0R2hTdC93N0R2eHhzSXN6
S1pWU0JaU3ZpSEhpMjU3MERXa0cyZ2Z6QzlNR1AKZEt1Q3JROTVCYXRYRFZVY2YyY2FXVVluSVl3
WFZXeFJhcnhvWlY3bWJTbjZTcmpLWldpY21Sai9CMUdEQ0FkcQo5N1VIdDBrck9UQ1g3OEd5RCtV
YVRBdndLdUtIN0QvTUdLZUVIM0JvZXMrdWh0TnptT3pQdFFlRmxHMFVPeWtDCnZwYmJHbzRBd1RR
VnBheDM3TnF1M25mTnQ0ZmwzZVU4cHI3b0t4UT0KPU5wbkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000edcbd8062faab0cd--
