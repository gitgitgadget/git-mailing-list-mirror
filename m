Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813F1BA293
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890217; cv=none; b=Zr1uzkY8fLxcOn5WmFOKIcUrUHVNR/c4DMlMMeW8A0nkTfRet9b4brNfNzJ5iteYpgi0Iv5MBa0FF/j1DUZNtJU20lh5Vixmk0izxQlfz+ci0s06CJEfZlsrRZaHz0lycnfONNdGxwrAEoKnLJOceWmtX9zjQ0w2UDWQ0ZruEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890217; c=relaxed/simple;
	bh=pzaF4XHFvBVKAEnPNbH34BOpPfZ+cTspej7PG+jK/B4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eL7rZg1KbR8hmVNxRDJOvpYTfUoOcstJfqDeXFV0oT20NDvhov0wZEUP6Zn3mqnHl6wwaStNJzMvGRrlW8NdE0f2ip+dCFmevJ5m8KZE2OfM78DZ+L8XRfPcjlEOyz9Xb+QsAZZLmmeS27naRkkGd1FdIBh21mfVFvUxSO9dQYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb1EXtvi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb1EXtvi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c26b5f1ea6so5266787a12.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890213; x=1726495013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRtekIB1uC3N0fmTxgsSJHR85MQX5PEuS0nRl9luxG4=;
        b=Lb1EXtviBnv1y8sYQlDD0I4uXU6HOvxW20jF9+1ujEvcnNTA31uTILtUy5xCaxvevD
         3WeT5eRsZa6RoLl5t1EB7EIcZzpTgAaXfgFGQLmX0Ggpkvr7/Gfm3vEkxPu73oR3ho/u
         aAI/badUk9yjmHIKuDl1JOOCJRnavl5ZJfh/1XQmQMpoSOrz5VsosYBTMeWQ4h2tjzb1
         7kuH2KsITLoaaPi6S/VqapGJmEGfb/xMOXutgFXR9ef0pc9zRKXsYNBM0JlCA2bEhaGV
         CWsvzODA//OdtVzdYdo1/qoomBNvJibyJS/etW4yIK4xgWyGvY5FCnMJW/+FEBclaYaW
         YqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890213; x=1726495013;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRtekIB1uC3N0fmTxgsSJHR85MQX5PEuS0nRl9luxG4=;
        b=skAvDPRSQgC/FORvHJINmuQP5cVkneWFqaz19lBUiICBE2R3xCWwZSOxqRA5LhG0xV
         toY7nVvlApb1gj0cPjsEbQWLhMIs06J0RtlHa3nz2orcHsmu83AtpipX1Ab6vZkza6qr
         HV2MGmUvmgMnU6j5/zqVbw8UjqyM0QmVks7EPpiK/cLfk6ZIs4JxQEou9IQfzIhrApIo
         jrxZ0bUYGTeTBeWDBPC7MI50v99CAYGoYWCxc+2KAhmIKVAret/0m+sX6xFcEHZWbb6S
         2/QIRmJFxhiL3Qf+oxsM1pAxDAHcIiXPVDIPhcqZ47DjJsboVZDV080fAFJ79fFrUvPE
         awcA==
X-Gm-Message-State: AOJu0YwYcRPDfF11tgPTw4YU7nAjd/urlqn9fXELckzwj9vtPYOHB9r0
	iG7KiNHexhkpBBMqagQWHMz2eKAB+iFvwvzHcHDzKUbeNWQAWnNEv4/6rA==
X-Google-Smtp-Source: AGHT+IGFJwrU6O2wo2+j63dH1yQ+KA8jGjEWOfBWfmIFHGS0gu1w1RrdwAEdQAe5j3h6Fdf9F4YKdQ==
X-Received: by 2002:a17:907:1c2a:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a8d29b7ef32mr413020766b.13.1725890212291;
        Mon, 09 Sep 2024 06:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72ea5sm346967366b.99.2024.09.09.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:56:51 -0700 (PDT)
Message-Id: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 13:56:46 +0000
Subject: [PATCH 0/4] pack-objects: create new name-hash algorithm
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>

I've been focused recently on understanding and mitigating the growth of a
few internal repositories. Some of these are growing much larger than
expected for the number of contributors, and there are multiple aspects to
why this growth is so large.

I will be submitting an RFC with my deep dive into the many aspects of this
issue, but the very last thing I discovered in this space is actually the
easiest change to make.

The main issue plaguing these repositories is that deltas are not being
computed against objects that appear at the same path. While the size of
these files at tip is one aspect of growth that would prevent this issue,
the changes to these files are reasonable and should result in good delta
compression. However, Git is not discovering the connections across
different versions of the same file.

One way to find some improvement in these repositories is to increase the
window size, which was an initial indicator that the delta compression could
be improved, but was not a clear indicator. After some digging (and
prototyping some analysis tools) the main discovery was that the current
name-hash algorithm only considers the last 16 characters in the path name
and has some naturally-occurring collisions within that scope.

This series introduces a new name-hash algorithm, but does not replace the
existing one. There are cases, such as packing a single snapshot of a
repository, where the existing algorithm outperforms the new one.

However, my findings show that when a repository has many versions of files
at the same path (and especially when there are many name-hash collisions)
then there are significant gains to be made using the new algorithm.

Repo Standard Repack With --full-name-hash fluentui 438 MB 168 MB Repo B
6,255 MB 829 MB Repo C 37,737 MB 7,125 MB Repo D 130,049 MB 6,190 MB

The main change in this series is in patch 1, which adds the algorithm and
the option to 'git pack-objects' and 'git repack'. The remaining patches are
focused on creating more evidence around the value of the new name-hash
algorithm and its effects on the packfiles created with it.

I will also try to make clear that I've been focused on client-side
performance and size concerns. I do not know if using this option will have
issues with advanced server-side repacking features, such as delta islands,
reachability bitmaps, or serving clones and fetches from the resulting
packfile. My educated guess is that the name-hash value does not affect
these features in any direct way, but I'll leave the testing of the server
scenarios to the experts.

Thanks, -Stolee

Derrick Stolee (4):
  pack-objects: add --full-name-hash option
  git-repack: update usage to match docs
  p5313: add size comparison test
  p5314: add a size test for name-hash collisions

 Documentation/git-pack-objects.txt |  3 +-
 Documentation/git-repack.txt       |  4 +-
 Makefile                           |  1 +
 builtin/pack-objects.c             | 20 ++++++---
 builtin/repack.c                   |  9 +++-
 pack-objects.h                     | 20 +++++++++
 t/helper/test-name-hash.c          | 23 ++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p5313-pack-objects.sh       | 71 ++++++++++++++++++++++++++++++
 t/perf/p5314-name-hash.sh          | 41 +++++++++++++++++
 t/t0450/txt-help-mismatches        |  1 -
 12 files changed, 186 insertions(+), 9 deletions(-)
 create mode 100644 t/helper/test-name-hash.c
 create mode 100755 t/perf/p5313-pack-objects.sh
 create mode 100755 t/perf/p5314-name-hash.sh


base-commit: 4c42d5ff284067fa32837421408bebfef996bf81
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1785%2Fderrickstolee%2Ffull-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1785/derrickstolee/full-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1785
-- 
gitgitgadget
