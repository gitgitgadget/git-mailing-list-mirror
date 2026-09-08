Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACF4968EF
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906097; cv=none; b=n60VQ2c4U5RDr7xVfh0FAQr4l1nbPg7UBlLpgxGrb3huHl1IBTB9mdsdu/B+22qbTvgTBWsyeJKTpx7umR/jFlf6ZgHsLPa0ewwyvTAaNtDWCPZ5zMVx0s3FN/Aei3vGJNQCO97x+aSsx1wdq605dhy57/3ny+o+XV19croQ+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906097; c=relaxed/simple;
	bh=9UBl3lEe1U93JlWex4zrp/b8SpE+mZ0wd+m/46M7JJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIkszEfankFNdNURvpFrCKWryOFkNvHjqQjTY5+KEr+R6s3Qp+zZnwTHyUuxagsJzdzWEDiuJlYH5DydArlE6KR9n7bcT1KI5IGLis547G77KuS1fwPASljjB6vVyLoZHul1v/BNbw0btEU50svAgLUfsNv5U8Z+eB2PRJn14Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=klWcJaze; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="klWcJaze"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b1fcd3b1a9so2138810b6e.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1788906094; x=1789510894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8xjpxV9ikputy37RA7rJnisKL75u2Jk1RS2sB+UT65k=;
        b=klWcJazeziIWAamiFrOvB+6+ZDzy/yQoQQEvn8uALRhGRhjC4rFpq2RwiLxpNgXowq
         nBYwKH3VKlMlgzltWEf6/cXsEUNQdhhUCUPjeQ3jxIdjI3v5pYe9eyrK/iiAAKkk8p+A
         NDQLi7mRUywIuzwt1mtsqHI8lmvgQt1hjql2v+HkH0nMaLiLVd7TJxA2vcl9AneFNZFt
         D8WvxY4DDYfKC537YPBNHBU+fZGWmLy2dOqB1G+VRBdHyrEHcA9iElNmwc9HciYdAacX
         NwY2cr9sxOpbF/nba0cFse0DiPTUlZBvPVK8u1lQSYf7gU5RaZ1DthrHAw7QdalqJ22T
         T8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906094; x=1789510894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8xjpxV9ikputy37RA7rJnisKL75u2Jk1RS2sB+UT65k=;
        b=R3jYmXiqCYT0IRV4g5JSQ8ZiXb7L4380HvNoP5u+f7LEt5QmUcnZzQ6LkTGfVsln6R
         9ZMN7VS0r/7BGEwV6RFfWHvkxeDxK+z/sLhdCGOfK0GH6gmkV7wpLI+jozX30zwAQq6V
         5l2lfww+tP1lXQ0ZfTBjNlFVRm+jFW55U1BZZfQhpljmEpxYEzjbuuxdoFj4JqaYjZLg
         0pGjHi1um4txCaxPgwgDzNgEvzHBVat5lp0oWjs0ytRVJCMJvGSzDpGq58khEg2N/XZ8
         hneWM97k7ToBQHzY2yatfJ1DkiCRvXY9/bahfx+zF5R2WUp6xjiawpC3p2nR0nUiIer9
         vwSg==
X-Gm-Message-State: AFuF++lZd4o7pUakW52BGWO1Js/mX4KJFj3YPxHJVkOd0dCSyzTFAp3/
	VVDvWlrGWp1+YiASTH0rEqoJrdnI09JOMH/KV+olu1fFQelbqpXhw5xcZAt5m+et8oxk6+hgguC
	2TT3HxXk=
X-Gm-Gg: AYBFou3XKqKJOF6Dej6lYUmmwgN74ZlxWWHrPAj2Mp3ojHLFTOYbXDYexuVc5EQB13L
	MKFShs69Lx5J4xzw3oDyjOUGtYMCbkjra5YZmGD8jDYCgmkTcbNxw+1iU+XmtI5CzsFbqJwQ42e
	ojSIFe8Qzl83b19O4Y8THifXX7W1aqskcManUfp0Ntyly0rSyPNAhZItLGVI+7mcRUZLbL0rQtP
	unwblWxHiCVB+VgxUIFfghLuql27VcYboLL78LRFPSTLXFviUEg7l5x2Ma8P8jty01NbSMJeNOC
	3z6csTNFRTxOZ55lo6RVNHM9QtN6+ziqcbCgP5L6TxXZPJMSiJTfsM9KeS0RVcAvGFhTj4hKfKh
	UtgUyv02PaSHN/sDVyW/s3QorIXuZ4lqVqyC86Jy62Qt/3B5VHIxt0vqzXiL0bLZCJWUOWMQmvJ
	6RcZmnmXNVwxEzQGTHFkO/VTs+7NBJgfDwXHsItxd10PHwe4TEQnC2jQx6KiO5
X-Received: by 2002:a05:6808:4f4a:b0:4b3:7b31:8df0 with SMTP id 5614622812f47-4b960eac998mr22950561b6e.10.1788906094511;
        Tue, 08 Sep 2026 15:21:34 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4b971c8ed6asm14864519b6e.17.2026.09.08.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:21:33 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v2 0/2] push: fix --force-if-includes consulting wrong ref
Date: Tue,  8 Sep 2026 16:20:54 -0600
Message-ID: <20260908222056.1150748-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:

- Clarify in log message 1/2 that --force-if-includes will reject a
  detached HEAD today (when the same-named local branch lacks the remote
  tip). And note that this change makes it explicit to always reject
  the detached HEAD case.

--force-if-includes has been checking the reflog of the local branch named
after the destination branch regardless of what's being pushed. This can cause
false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
               false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local branch
contains the remote tip but you --force-if-includes push an unrelated branch,
clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test cases
fail against maint, but pass with patches applied.

Existing tests covered refspecs with different names for --force-with-lease,
but missed --force-if-includes. New patches cover:

- allow forced-update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch lacking
  branch tip
- reject same as above using HEAD
- reject detached HEAD

Resolved question: the detached HEAD case; HEAD's reflog was considered
and rejected as too broad for purpose in the original review. cf. [2]

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>

Tyler Cipriani (2):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes detached HEAD advice

 Documentation/config/advice.adoc |  4 ++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 15 +++++++
 builtin/send-pack.c              |  5 +++
 remote.c                         | 27 +++++++++++-
 remote.h                         | 10 +++--
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              | 70 +++++++++++++++++++++++++++++++-
 transport-helper.c               |  5 +++
 transport.c                      |  8 ++++
 transport.h                      |  1 +
 12 files changed, 143 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  5e866b883e ! 1:  da27c421ed push: check pushed ref for --force-if-includes
    @@ Commit message
         the remote main.
     
         Find local reflog using ref->peer_ref. When using a refspec like
    -    HEAD:refs/heads/main, we resolve HEAD to a branch and use that reflog.
    -    In a detached HEAD state, the reflog cannot tell us if the history
    -    being pushed includes the tip of the remote, so the push is rejected.
    +    HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, use that
    +    branch's reflog.
    +
    +    But if HEAD does not resolve to a branch (i.e. a detached HEAD), then we
    +    reject the push. HEAD's reflog is too broad to tell us if the history
    +    being pushed includes the tip of the remote. Rejecting a detached HEAD
    +    already happens today (if the same-named local branch lacks the remote
    +    tip); now the detached HEAD state is explicitly rejected.
     
         Skip deletions:
     
2:  4ae40db7fe = 2:  e07d16d53e push: fix --force-if-includes detached HEAD advice

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.47.3

