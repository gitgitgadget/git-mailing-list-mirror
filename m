Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9522DAFDA
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476303; cv=none; b=aonE5kTvFAb5la0n+s+5PBEGp2YZH5WR6/VSbQX83+JsgCxwRSDgf08BjpdUD2BM9fZbIeOdWCYfNjq6/6p0u/opS7Uofs85OJ8BzQKi/K+X11/mNhJCxkplRRrjQ/35d5LT+4OgU7Hgor1Zt1kEFkqFdvfFUH16VCOYaKhRy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476303; c=relaxed/simple;
	bh=XodtadURkTtVbdZvEQ+Igr3qGiP2g977cdiP+KmUSWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0+axorE2uVXmep6vKIV6BjhkLXHNM906LAuX96Gv2lXTJQ7+k/r9I9y2wcA3ldG5Er8rgjJqqxrYT5grM4GJYgKGkG9RnoExtnyN29Rqjn+M3mBZNG75E5UcejGMd9UBsnNKH/1uOYme5lLm12VbgHcxJlvs3BMFYcXlThXPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDsjYqsf; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDsjYqsf"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso32752685e9.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476301; x=1771081101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tC73URbZH8c0CyGpPTaTaMVrhnWp7aTpi+o7PuLHSE=;
        b=eDsjYqsf03PuUdhYdB3ZA96KrekNYa4zkNnJmMfpWoX50kSHpC3l18t/68LI8TvWwR
         /d8g2HzXex6w+O+ANgRPQRDJNgFVQdg1k7jVUfzjLpP1den/Xm7oDRldxuZGByJLT6BB
         dWtruLSq9zN2gi/wp183FsIm/y3Ol/fMbtaGUJJPR0ZoQhXuydxemVKaaTbiU6EC3iV1
         XNQPVu6vbEtVEnfYbmzk8em/5q4UgnGAJLbE1wuIPHn8OydYakUWU+jxyR/8RhY4F2vT
         CGCkhKZ3j0Wdcp2hl15DpsYY6ogv6ziEibgjJ6kEoWm4xOVHJOcBhp3a3ZAc9ZLfE+5t
         O7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476302; x=1771081102;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tC73URbZH8c0CyGpPTaTaMVrhnWp7aTpi+o7PuLHSE=;
        b=d1ZA+zdN1YZxsomUHayeggiebpksd5wqFbXNHGPuzqEExsDf7ajEbPILDS1E795X2V
         OrUEqDy5IN1o9Z6ZM4myDAjnSkRrIhZmyNNmeLyvoS2ZR+Tx6Sk6SZUbRzzoCNhvXP7j
         lrtJ1LST4nfutuHGTdXTqRSRK4UMwqRnKTNjEa3lGiFdxiRR5MfziBtBEZAGzXBxgPPQ
         HSbchnrmvckycTQuhmChAdzhTbB+cGhAq1BcGtma1oBH09NhyyRzI45eiOmMWJ8aUgmC
         PLO8v8Jol/v6+sDDsPZXBWJeJKWT7GeD/Rd/Ar7QGqTbZr/dalj6veiGKAIDCzHXcpwE
         6plQ==
X-Gm-Message-State: AOJu0YxQG9j/hfgI/ZgkPhWq24kW5BCfK7bi98ghOJIfHZx7pdUyr/Ic
	VB2noYwhcLEQdFNbs8D0fdeVYj0PlSEbElU0f8LKYXZB8GjkBiySiwAQXX2WDpMr
X-Gm-Gg: AZuq6aJvAIUq7ZOf3NdqIMJ7vOXmCtPEpAjh66DCUfr2qD6m8xidAI8997v0jT53dn8
	faqbNFaP8mQwSoiBGy+itgmPrcKauUpTlcpvJBt7lxPJdZ7yFNf76/jgtrN9C3vSCJL2drVHrzH
	b6M6I4uQx2MsQ40cx+s92iCdDRcNJadfyt20FBLAsISggbCDuoQNQXri1pjWjqptTMgjFdsN0gp
	X45Kzy2bWAzRB/bfwAfnU6WZEX/pzyWsMtcQe1yTjmQyIfvIDdgZ4TKLK41zCJMEpfsWpyBUFgw
	WTgs1beMXBb1vj30mBvfXoBCYmUa1biUpItri3AI8WNkGOrrThKhWYl0s6voFOEdIU8o5rG5a7r
	2GgRgRXF3pP/p/ivz+6VmslfReNIbg29DgaEZrMpAWXAzxsaz8GNIy9rSI8xzZN6rPcnFJilKbh
	drzX34zlJArCZrITo=
X-Received: by 2002:a05:600c:1388:b0:483:a21:774c with SMTP id 5b1f17b1804b1-4832097808dmr82090885e9.25.1770476301359;
        Sat, 07 Feb 2026 06:58:21 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm13780317f8f.11.2026.02.07.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 06:58:20 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com
Subject: [PATCH 0/3] commit-msg.sample: reject messages that would confuse "git am"
Date: Sat,  7 Feb 2026 14:57:59 +0000
Message-ID: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <20260206090358.GA2761602@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On 06/02/2026 09:03, Jeff King wrote:
> I don't think there is a way to unambiguously parse the single-stream
> output that format-patch produces. This is a reasonably well-known
> gotcha (at least around here). E.g., some earlier discussions:
>
>    2024:https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
>    2022:https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
>    2015:https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/

If we cannot improve "git am" perhaps we should update our sample
"commit-msg" hook to reject messages that will cause problems. Here
are some patches to do that.

We could perhaps think about adding a more prominent warning to the
"git am" and "git format-patch" documentation. The docs for "git am"
mention that it splits the message on a line starting with "diff -"
but maybe we should spell out what that means for commit messages that
include a diff. In principle "git format-patch" could also warn or
error out if it creates a mail that "git am" cannot import verbatim,
I don't know how hard that would be in implement.

Base-Commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fsample-commit-msg-reject-diff%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/b2826b52e...83c100a73
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/sample-commit-msg-reject-diff/v1


Phillip Wood (3):
  templates: add .gitattributes entry for sample hooks
  templates: detect commit messages containing diffs
  templates: detect messages that contain a separator line

 .editorconfig                     |  2 +-
 .gitattributes                    |  1 +
 templates/hooks/commit-msg.sample | 38 +++++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.52.0.362.g884e03848a9

