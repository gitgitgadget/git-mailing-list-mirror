Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1E344DBE
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866435; cv=none; b=WYpGi4D1dmqX1/JqVvMKwNPomsHSgjOZSwg/lKERy0h+folwprAcAc5CoA2cXusAfWTzS/FybWarUlqRmm8oaOO7fA0ncxbtCReMfR+RyPhJOg28ViSgwOVAF9lk8hTUV7C4g99naW0rw+ayJfUuGfs4Lo4pSGE2v0cdqVaQTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866435; c=relaxed/simple;
	bh=6HVyZHWQKg+DNB3FpS0J/DvRlPx7Sv+DB45j7sdaShc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pnl4BufDEhy0B/dRGBtXGCO8pLlYNnfnKb0kmnKqGkw71g6tpX0w2GnliH1UimJ8F4kAGaWRjMmDxddL5lK5YuXhiRlc+QkH2hP/fAKeDjoX1ND1j7PmO4TT1XfkIH+UEnMDjVqAo76Ap5VBSPGF//2fuqa0yYM9rdyYcBB0jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhsD9viV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhsD9viV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829a9d08644so226864b3a.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773866434; x=1774471234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCxs5Esb39xyiJmzHIqAjVwgudnwopR30d9NGve/76s=;
        b=bhsD9viVgfh9zDrgopRZCvyIaggGfURSnVDvvb0B5PLHct8A5wZeutVaPDtwfxo54R
         hzxtVNHMSPcQRZxlP0yF33E257UVwefWvfMeJsX1VaVbu5jFth4l3kpKYKSx0MuY8ipp
         vTnF8j4Ql9VCq0y+yE0GBTl1kvHJo2IVXRcTLBOAEdcywIuVzBDGp8qbPBi5pZwi7Hxp
         puokXCqVOu/fGuV953VQ/avBxNBnvZPAhaCGWjDibktOmnLbJriChUlwEUzUFtNNjZ0N
         hLNQ18TGdh6PUfeefNWgsaj2iF0uRFoNVs/dFknpofO57QggYEWAsRX2ixkIBMf5o2c8
         RmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866434; x=1774471234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCxs5Esb39xyiJmzHIqAjVwgudnwopR30d9NGve/76s=;
        b=oAkBlSdJvnJ1ZLeloNSKsbDMd4dFxN7kBOGhowxc0n1b9N0mWHe8FMWyjnxUEy4NNW
         tEmmpdoxGA7ry6M/XaQ8id8WJvszC+V8VTrbLtiqYFZZofI2Pxrs8UObFR+em0btVG7j
         om0K481akJ/GvHBk8Z2uk3sZ4oqc/Q1iU11K0tdpTOJHUUSOGeDakTcFzHE/K+ZUO7su
         jdkRx1kNsYo8hKdGsqxFWLWXIWvKvPl30Gun0jeR7SIR5hqTORDAeflAr8vPdUJ9byQ6
         ZgMQupzOodpXzEUpzyXDIT58/NXhR3P+FeKtoWVETofn85KJ8KAqynTFwZikuZtcdGsw
         3bLw==
X-Gm-Message-State: AOJu0Yxod/A89YwcDrBKiesK/9Vkg18QS7JWP4wPcGdgYDHbh+s9hnAc
	wtDmnnFJyCSSvfHmGXq50P/L5XjvHqRiH49vFqdtIFMRyoLb500r8T59fSzw+UP7
X-Gm-Gg: ATEYQzw+Omc3pIlVP/bwNvfkhqZ098veHmq6sk0Fl9c34UKtqq9n5v0CTzQ1bTx2hqp
	CajMFTVgvqAvAak6Y4iwhbedbymjMzG668CYgWcyNvliBiwSZyvbfyvyqc/JhlNb7uCiGE+SRGS
	8smjLxxVgUqEaXOyvZsRSuY17A4vkntj0AN2Z2Wa12Yo2WRsWy3rGsmCFmWFe8A61zwbnycdx5z
	5CyGef33Tmb67GZ8HkZGBkYVYpN8cf7o6iuZPEWALKb1TIaAS9GBcPSQT7RTt8cVr2Fprb7ikq/
	q/msFw4pXPfV4Ny35CD5bxN9wmPI3Nrh9UEj1UFFf2l3JWT6TT3S9YlmP6aQUq0bgttA0FfgtmC
	7yZzcj5UOjLo9FzHNZUhXrCUqt35pckArbeUwFtDzN5L0RAjuWJ6YzqCmQmGJEs/HS375gU69Qe
	K9s0iTd3cqqxAQjo04oyoImYhlQiXWCGRBWW6LdnGx1hUYfPBIyABPHoQ5M+Q=
X-Received: by 2002:a05:6a00:14d3:b0:829:942e:76c3 with SMTP id d2e1a72fcca58-82a6ac83acemr4839304b3a.25.1773866433443;
        Wed, 18 Mar 2026 13:40:33 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb96e4sm4428567b3a.35.2026.03.18.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:40:32 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v2 0/2] push: add support for pushing to remote groups
Date: Thu, 19 Mar 2026 02:10:26 +0530
Message-ID: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds support for `git push` to accept a remote group
name (as configured via `remotes.<name>` in config) in addition to a
single remote name, mirroring the behaviour that `git fetch` has
supported for some time.

A user with multiple remotes configured as a group can now do:

    git push all-remotes

instead of pushing to each remote individually, in the same way that:

    git fetch all-remotes

already works.

The series is split into two patches:

  - Patch 1 moves `get_remote_group`, `add_remote_or_group`, and the
    `remote_group_data` struct out of builtin/fetch.c and into
    remote.c/remote.h, making them part of the public remote API.

  - Patch 2 extends builtin/push.c to use the newly public
    `add_remote_or_group()` to resolve the repository argument as
    either a single remote or a group, and pushes to each member of
    the group in turn.

RFC notes and open questions:

  - The current implementation pushes to group members sequentially.
    A follow-up could add push.parallel (mirroring fetch.parallel) to
    allow parallel pushes to group members via run_processes_parallel(),
    the same mechanism fetch uses. Feedback on whether this is
    desirable for push is welcome.

  - push.default = simple interacts poorly with group pushes when the
    current branch has no upstream set, since setup_default_push_refspecs()
    will die on the first remote that is not the upstream. Users should
    use push.default = current or explicit refspecs for group pushes.
    It is worth discussing whether the group push path should automatically
    imply push.default = current, or whether a clear error message
    directing the user to configure this would be sufficient.

  - force-with-lease semantics across a group push are currently
    unmodified — the same CAS constraints are forwarded to every remote
    in the group. Whether this is the right behaviour or whether
    per-remote lease tracking is needed is an open question.

  - I will also add the tests and documentations in the next iterations

Changes in v2:
  - Remove UNUSED from the declaration in remote.h (patch 1).
  - Drop the persistent `remote` variable from cmd_push entirely
    (patch 2). Following Junio's suggestion, the default remote
    case now folds into remote_group so the single-remote and
    group cases are handled by a single unified loop. There is
    no longer any structural difference between pushing to one
    remote and pushing to a group — a singleton is just a group
    of one.
  - Move the --mirror+refspec and --all+refspec conflict checks
    inside the loop so they are evaluated per remote.
  - Add a URL/path fallback so that direct path arguments like
      git push /tmp/foo.git
    continue to work correctly after the remote resolution
    change.
  - Add a test script t5528-push-group.sh covering the new
    group push behaviour.
  - Update Documentation/git-push.adoc: DESCRIPTION, the
    <repository> argument description, and a new REMOTE GROUPS
    section documenting the defining principle that
      git push <options> all-remotes <args>
    is exactly equivalent to running git push <options> r$i <args>
    for each member remote independently.


Usman Akinyemi (2):
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 Documentation/git-push.adoc |  76 +++++++++++++++++++---
 builtin/fetch.c             |  42 ------------
 builtin/push.c              | 124 ++++++++++++++++++++++++++----------
 remote.c                    |  37 +++++++++++
 remote.h                    |  12 ++++
 t/meson.build               |   1 +
 t/t5566-push-group.sh       |  95 +++++++++++++++++++++++++++
 7 files changed, 303 insertions(+), 84 deletions(-)
 create mode 100755 t/t5566-push-group.sh

-- 
2.53.0

