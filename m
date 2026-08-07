Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329753955C6
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110937; cv=none; b=JUNzDenrOCzj8vMOTbhsnvAxw1kVq6yA3GKtjTcJdeNZnswZJtH7nSWzWQUXwA2v3m+3KsFSKYqelqhZoFPcySgjgQQMPIgemSpjHM+lBocg/VHSZ9UD1tJ2DFIjcX0tbdPQ8CaC54Uqp5A0I9Z1hK8a58zjJGVrJvoK4BBbV0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110937; c=relaxed/simple;
	bh=hc0JXxr34WjItTOoB/SkVLhWAbrm7eJPRwzfmI2BzEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOHqKqncQirZJDoqcd+Ry8yj5LCQGndaYJ9a+E3Z1jD0JfJSPCzSERNmKuGvEj2g6iHJyk9geiTTw07JsniDZUrCRPuUVsvEMa3ojQTEu4/bhpKj2YyMrs2kFBuxTR90EpBlEZCCn0nLZfELhClFYnQEmhZMMSh1+otlzYN8Q9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAm2cygn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAm2cygn"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2886263f8f.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110928; x=1786715728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SjfwRpBReoybmIDZDU88AA7VOTdsLhdlPkiV/r8WhW8=;
        b=LAm2cygnb+ZRK6ipQ27QIoNaK1Vx55f0f20fJh4TM8el7eoxddOjREpIPwtDjp7j8O
         Cu4NjwgHgTVjIBUak67I/IzJ9tdTZwWBlPK2aru7OD0fELcS/NaFMFdh/ZKIZwpWm9mn
         3Nvkn0Zm+yUTTXg1Sb06QfI8oY8MVaASv1EkTDSfQHxTcFXh0uLUDkrP6/O9prXPG+HC
         wAvjwLnKxVeG6nkkZH8TbbGnMzOV7IaqJ1MBK16aHKZSMB8+UhHavvR5r2l+SEeP0xiF
         1BCZUiITVkyMh8ljLMfXsJEvd+s0AYoRD2Nsi9mjM03aYE/yTfB4wZjlkx7QXeVBUGwz
         yF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110928; x=1786715728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SjfwRpBReoybmIDZDU88AA7VOTdsLhdlPkiV/r8WhW8=;
        b=XUshfa8/VBQQ+ppLjBtSnxrCclFJdHxUNKn5iABmMQBtmQ+S7D1EbfAQ2SrqB4lfn7
         jBpxbG+lyrKqIWO57LOmtaoMzNC/pljhZ5fMkVdQI98mbz984nGRL2r+RsSoujn6Meuz
         WKDzVO6MXEyobc+FemJmBHMZwkDSxjhZQV0+6z2u12VVoTZjMTuSd4Qf9jejDiMYK6DC
         NVuSS+6c3y9RWbd3NyuIN0zE1piRePcLPl4cg6RnNjUvatjeWBsZUNrAP4WdyeEClemM
         DfXaB9lZhEjqgeUQl5ACzLVkvjwEX2CufT2yIusE31jUiu7fo11Q0ZMJPW71l30ocN+I
         FxiQ==
X-Gm-Message-State: AOJu0Yx8UQgNycAEFRwG41DhRRr4t/+ad+n4ZDEpP9Tutr3Aa0ihAu0Y
	0n6+hdVXtf2SLT8f3JlwIDj9l+ArJyALZelGtsn8zityyw1M3EcKjSmyyw4bfg==
X-Gm-Gg: AR+sD12itznWkoCFbNe01OsFTOSjCoUQumnjqCEiC17pmcPegL4604xCxh9NJzW2S9v
	npq87vMBdnaqv18J79oV0lH8f+GV/LYhed+4AVgZyiW+PU0q+JJBotD1qYdnSSm/nzODPTIJn3c
	ElZPh1fuB/G0YtD6uAxavAmUpzdifRTWZJ+dBFjAznpSyvvywxJrJVUt8g0l3HN5UrIoQBXOcDH
	ORAkqKItO/xLzuPlwogavFlCA1laG8m9w67biuwI8PvXAL9Xg6OlEVqLjqlEiO5nvGZ3MFzVg+u
	JCeMBxvQb1yl27xGiSDSgVaw59xIszcZujL1zg04/h5oDkcB1BWADY1AXzuKarn/FuXsNSveORc
	MsEakOyjvBchHPkzyXxbLTc7ZBVbre3PuQh0wM/caCywHB53ZI745P77HAfac4ExbfWWXcTdpvd
	upf/9nzwYlnephSIuFasneElMDbTjZnI1mtK+DP/ITa/fPnVdjWHcYMyZbo5Lw3aQxvpI8qlOr1
	YqikGiAv8EJueVVVDWuOhj/Q0ulC2OECqCEpspttk9vQHHwaySjjkdAMjuuIo/7lUlDfXnw2TD6
X-Received: by 2002:a05:6000:2989:20b0:47f:ece1:5d with SMTP id ffacd0b85a97d-47fece100b6mr30306614f8f.27.1786110927953;
        Fri, 07 Aug 2026 06:55:27 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:26 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/5] Introduce 'uploadpack.lazyFetchTrusted'
Date: Fri,  7 Aug 2026 15:55:06 +0200
Message-ID: <20260807135511.1818458-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260710085137.4171240-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they can
safely use.

The more servers use promisor remotes, the more it is important to
properly control if they can lazy fetch when responding to a clone or
fetch request from the client.

For example, in the context of large object promisors (see
"Documentation/technical/large-object-promisors.adoc"), if a client
clones with a filter set to 100kB while the server has moved all of
the blobs >= 10kB to a promisor remote, the server will not be able to
provide blobs between 10kB and 100kB to the client, which will make
the clone fail.

Even if the `--filter=auto` option is available since ef2f1845ec
(fetch-pack: wire up and enable auto filter logic, 2026-02-16) it's
still a good idea to provide more control over lazy fetching on the
server side to server operators, as lazy fetching on the server side
could be useful in corporate environments.

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is a boolean that is
set to 'true' by default when calling `git upload-pack` for security
reasons.

The main security issue on the server side is making sure the served
repo itself is also trusted, as lazily fetching runs `git fetch`,
which may execute arbitrary commands specified in the configuration
and hooks of the served repo. The operator of the server should decide
and mark that trust, not the served repo itself, nor the client.

This series introduces a new 'uploadpack.lazyFetchTrusted' protected
configuration variable similar to 'safe.directory' (see
"Documentation/config/safe.adoc") to mark trusted repos where lazy
fetching is allowed. As it is protected, this config variable will
only take effect if it is set in global or system scope, so only
server operators can control it.

Previous related work
=====================

A previous series called "Introduce a 'fromAccepted' option to
GIT_NO_LAZY_FETCH" [1] took a different approach as it wanted to make
it easier to allow lazy fetching from accepted promisor remotes. But
after brian replied that he didn't think it was a good idea, and after
thinking about this more, my opinion now is that some promisor remotes
being accepted or not is not really relevant to the issue.

In my reply to brian, I said:

"""
Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.
"""

So I decided to go with "an explicit way for operators to mark trusted
repos" and this series is an implementation of that.

Note that the feature developed in this series applies to protocol
v0/v1 as well as v2 while the previous one was only related to v2.

[1]: https://lore.kernel.org/git/CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com/

Overview of the patches
=======================

  - Patch 1/5 is the only patch saved from the "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series. It's not
    necessary for the rest of this series and its main feature to
    work, but I think it's a nice refactoring related to lazy
    fetching, so it might as well be part of this series. There is a
    small change in the commit message (to not mention following
    commits) compared to the version in the previous series.

  - Patches 2/5 and 3/5 extract and modify code used by the
    'safe.directory' config variable in a path_allowlist_apply()
    function, so that this function can be reused to process
    'uploadpack.lazyFetchTrusted' in the next patch.

  - Patch 4/5 actually uses path_allowlist_apply() from a new
    upload_pack_lazy_fetch_trusted() function to process
    'uploadpack.lazyFetchTrusted', but the result from that processing
    isn't actually used to have a practical effect.

  - Patch 5/5 wires up the new upload_pack_lazy_fetch_trusted()
    function to decide if lazy fetching can actually be enabled.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/31171494296

Range diff with previous series
===============================

The range diff with the previous ("Introduce a 'fromAccepted' option
to GIT_NO_LAZY_FETCH") series is not very interesting as only the
first patch has been saved, but anyway here it is:

1:  8dd67ddaca ! 1:  b5b0836d19 promisor-remote: factor out lazy_fetch_objects()
    @@ Commit message
         that could not be fetched are promisor objects.
     
         Let's refactor the lazy fetching logic out of these two functions
    -    into a new lazy_fetch_objects() function. This will make it easier
    -    to extend the lazy fetching logic in following commits.
    +    into a new lazy_fetch_objects() function.
     
         This is a pure refactoring with no intended behavior change. Two
         things shift in ways that are observably equivalent though:
2:  314c61cbbe < -:  ---------- promisor-remote: introduce enum allow_lazy_fetch
3:  cb2f5447e2 < -:  ---------- promisor-remote: teach 'fromAccepted' to GIT_NO_LAZY_FETCH
-:  ---------- > 2:  879e3a34e3 setup: extract path_allowlist_apply()
-:  ---------- > 3:  98431ab7b3 setup: add 'allow_dot' arg to path_allowlist_apply()
-:  ---------- > 4:  a46f4c1bb8 upload-pack: read uploadpack.lazyFetchTrusted
-:  ---------- > 5:  4063f233aa builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo


Christian Couder (5):
  promisor-remote: factor out lazy_fetch_objects()
  setup: extract path_allowlist_apply()
  setup: add 'allow_dot' arg to path_allowlist_apply()
  upload-pack: read uploadpack.lazyFetchTrusted
  builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo

 Documentation/config/uploadpack.adoc  |  42 ++++++++++
 Documentation/git-upload-pack.adoc    |   5 ++
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  11 +++
 promisor-remote.c                     |  76 ++++++++++--------
 setup.c                               | 108 ++++++++++++++------------
 setup.h                               |  28 +++++++
 t/t5710-promisor-remote-capability.sh |  70 +++++++++++++++++
 upload-pack.c                         |  37 +++++++++
 upload-pack.h                         |   3 +
 10 files changed, 304 insertions(+), 80 deletions(-)

-- 
2.55.0.530.gdb3615d990.dirty

