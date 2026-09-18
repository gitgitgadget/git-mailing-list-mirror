Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0B3A9638
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736544; cv=none; b=N74dZ5bHS+bin5FgdKPoelkOf4Qua3BAIIV1uS9EMWU4Ejj4HNrahD02pjsv2aOz+igg96DR+i+sUJLMVIEa+sBqZs/jh+eLWs3xX4sl2BF7EykIlMqA8o/BrZYLmBcydAKy7uRTJdr0bs9XvyqQOAJnJiJlnAM8F8iiAgDBup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736544; c=relaxed/simple;
	bh=5igJnPFZ5HVMTivG8lSBUsxPf58uYkxseab1G6f+NsU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LIPBmVXiR84z0HqZpxmBS7iWFltTILSYMc0ON+CdV2uPxn3cdfWTT3hQkAvERXBfrRnGrfF91xSYq5gzOkOvBv0kgfbXAdhnDseEdbemSos4/7SKezKi/PbShP+aijC/E1vPrMvSUja+4WG9thWMP1m74LKSfVwmYQgm3RbnIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6iykcdm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6iykcdm"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso715223a91.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789736543; x=1790341343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ooLtbzfQYjgnQUI/6w75JqmNTb0zUjct5qjjeTEdYvo=;
        b=l6iykcdmIxZrMA/vvFrl7BXDjfIMAOiBGNhZq+Q/85Qmblpw30fZ55muMYZgqdAIY0
         mmsLxsSuZUD26Yoc0vsrQ8H1kkcIygN0M8eNNU445RWJeiS4m/eO24u1hV+vOwhAB3V/
         geBP/NUyCU0Bi3YUtD/BIx4xlchh9zdmC35N5+cb5dYzoRropYZuXEsmAQwr5lpMM6eh
         uXGv6mPXcKyRP19ZsFBf4jBSTr2L59ZpdBe5akNn0Te1bD0FcfBmJWWFR0XvQ4dcdXBn
         whuzJgFVXD3RQ+Zn7j1OM+Pac7gUXPFUAlRu3wo4soidlyV0VQgt2cywsF2kPXMBs8S5
         +cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736543; x=1790341343;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ooLtbzfQYjgnQUI/6w75JqmNTb0zUjct5qjjeTEdYvo=;
        b=vWhi/l33Dx9eCWfLxhCmz8XR4NvwGvTMK/NkYNqIJWzleJKqzJycm56leMDn1pdAeh
         j9vNDNaqfrb6xCW/DAdPnBj8+PjaDt4zAtPHCUZn97XmUPVX/my7Zu3tWpUsfgoOFv3a
         rYTAQ4nbOC/s+QUzvqwfjnz5q0zVXX+YyEDMiltLPGol3BdINzk+uj81w6DTcgepggZG
         ZCZ9IZFttntF7BLUHp9yETGdtoyBc53ASoEQSFc8KYJ9xtn/HJhfb1l5U6JzVJr6zN6K
         fUh6n0MwG1qAQOgvCL2nWoaUxoh1CuNQ8di9VSO+9GH3dCKqNtKRhHE+IXsHO0U3gkFj
         JlBA==
X-Gm-Message-State: AFuF++n3uy6dX2LzPelaVzCQsCzZVTjXfhT7FyuCgVMxJL1mzodOoGjI
	kuMNcUQDtqs81WkmNqIoEOXBqBuUu/Lrfv2ZK4h2iS0ZUGZtv/K7z10mSMq23A==
X-Gm-Gg: AYBFou1UKGYhuM+7T/eim2S22VpQ6JxIF3nAW12GPYgueY1tuocURhHQMvPlOqgXh8R
	EuAA6p91U7QtnaK9amV6Kya2a7kVNOzZM78uHscRZRaM6AXJqjECzxEmJrs/TlVc2RsvYTpIiJ5
	k8SDux7xZDFMO4IaI0QypSbIUpkhS/i6cjdT56V3s2lD+mqQeNKawHl2ZG789F67GeiWHkKNqsG
	pKb6AYgLGvQOyxVJO27UCqx/Vo7PMSBJYeGN1ZpZbi5wztdJ2wsZstba0KxP6+eH25CUfKqWzle
	Jcn2SpU/GMYYoZ+3mQgp5NLlAw+ne8DWB1vZv30yi2AgVCHk8rs1ljyNZgkXZJuurFxQfuefNTm
	gmFgqP/8pj+1qM/Jjvqxir7Gqyz3xBjLIzZoL8w6Z2f28IlqoqH40Cgwr20ZcL3BdKQGoQ2CH2I
	QtuA/Runn0pVl5k78j3vSeccHgC0O1kF3emRyXHif6Vp1j3mTQbfwmUqQxqiWuO6PgBzbdcgw3
X-Received: by 2002:a17:90b:4c50:b0:39d:fd60:caba with SMTP id 98e67ed59e1d1-39e54d21a31mr5279950a91.14.1789736542191;
        Fri, 18 Sep 2026 06:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.95.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36116920sm10789124a91.5.2026.09.18.06.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:02:21 -0700 (PDT)
Message-Id: <pull.2230.git.1789736540.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 13:02:14 +0000
Subject: [PATCH 0/6] [RFC] Create a 'safe' strbuf API
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    peff@peff.net,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

This is based on ds/trace2-tolerate-failed-timestamps [1] [2].

[1]
https://lore.kernel.org/git/pull.2178.v3.git.1788197143.gitgitgadget@gmail.com/

[2] https://github.com/gitgitgadget/git/pull/2178

While investigating the fact that the trace2 API can trigger recursive die()
loops if allocation fails, Peff pointed out [3] that trace2 uses json-writer
which in turn uses the strbuf API. If a strbuf fails to allocate, grow, or
otherwise mutate the given strings, then trace2 can hit this problem!

[3]
https://lore.kernel.org/git/20260901050129.GB1075462@coredump.intra.peff.net/

The goal of this short RFC, such as it is, is to get some feedback on
whether this is a worthwhile direction to pursue or if I should abandon this
idea of having this definition of "safe" for some APIs. This decision may
also determine if we should abandon ds/trace2-tolerate-failed-timestamps or
leave the existing behavior as-is.

I had discussed earlier that what we'd really need is a guarantee that we
can't transitively reach die() from any "safe" API. The eventual goal would
be to include json-writer.c and the trace2 code files into the "safe"
bucket, but for now I'm making sure that strbuf-safe.c satisfies this CodeQL
query:

import cpp

class SafeFunction extends Function {
  SafeFunction() {
    getFile().getRelativePath() = "strbuf-safe.c"
  }
}

predicate directlyCalls(Function caller, Function callee) {
  exists(FunctionCall call |
    call.getEnclosingFunction() = caller and
    call.getTarget() = callee
  )
}


from SafeFunction source, Function sink
where
  (sink.getName() = "die" or sink.getName() = "exit") and
  directlyCalls+(source, sink)
select source,
  "This safe function can transitively reach " + sink.getName() + "()."


If we went with this approach, then I'd explore how to make this a
build-time requirement during CI.

In regards to the structure of this RFC:

 1. The safe API needs the same structures, but shouldn't import more than
    necessary. Some movement of structs across headers is done before
    anything else.
 2. In order to make even the smallest safe method work, we first need to
    figure out how to handle GIT_ALLOC_LIMIT, which is an undocumented
    environment variable. I explain that I think this should be
    GIT_TEST_ALLOC_LIMIT, but maybe the ship has sailed due to Hyrum's Law.
    So I make an effort to document it but also to initialize it proactively
    within the process startup instead of implicitly at the lowest level.
    This allows us to avoid a die() when checking the environment variable.
 3. Thus, we get a 'safe' version of a memory allocation size check. This is
    our first example of creating a safe version that is then called by the
    non-safe version to prevent repeated code.
 4. We can then create our first safe strbuf method: sstrbuf_grow(). I
    explain why I prepend with s instead of appending _gently in the commit.
 5. Some trace2 code implicitly depends on strbuf.h through json-writer.h,
    so we drop that in favor of strbuf-safe.h to keep the dependence on the
    full struct definition without forever having the non-safe methods
    reachable. The goal eventually is to drop the strbuf.h include from
    json-writer.c, but that isn't accomplished in this RFC.
 6. Finally, create safe init and release methods and use them in
    json-writer.c. This does show some of the "transition risk" where some
    json-writer methods become "safe" but I haven't done the hard work to
    make sure the callers of those methods respond to the new return values.
    If we proceed with the RFC, then I'd split this into a creation of the
    safe strbuf methods and then the refactoring required to respond
    correctly to errors in json-writer.c

Thanks in advance for your thoughts!

Thanks, -Stolee

Derrick Stolee (6):
  strbuf: add header for 'safe' API
  wrapper: initialize GIT_ALLOC_LIMIT proactively
  wrapper: create safe_memory_limit_check()
  strbuf-safe: add sstrbuf_grow()
  json-writer: include strbuf-safe.h
  strbuf-safe: add init and release methods

 Documentation/git.adoc |  6 +++
 Makefile               |  1 +
 common-init.c          |  2 +
 environment.h          |  1 +
 json-writer.c          | 32 ++++++++------
 json-writer.h          |  7 +--
 meson.build            |  1 +
 strbuf-safe.c          | 52 ++++++++++++++++++++++
 strbuf-safe.h          | 97 ++++++++++++++++++++++++++++++++++++++++++
 strbuf.c               | 23 ++++------
 strbuf.h               | 74 ++------------------------------
 trace2/tr2_tgt_event.c |  1 +
 trace2/tr2_tgt_perf.c  |  1 +
 wrapper.c              | 67 ++++++++++++++++++++---------
 wrapper.h              |  9 ++++
 15 files changed, 253 insertions(+), 121 deletions(-)
 create mode 100644 strbuf-safe.c
 create mode 100644 strbuf-safe.h


base-commit: a80c36bda0e5aff1c9945d08f43079a6aa85ccad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2230%2Fderrickstolee%2Fstrbuf-safe-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2230/derrickstolee/strbuf-safe-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2230
-- 
gitgitgadget
