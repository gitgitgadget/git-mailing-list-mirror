Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B029E116
	for <git@vger.kernel.org>; Sun,  3 May 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822452; cv=none; b=uV89M/Nej/zb6DWkDRMG2NMmjUJhHMoSnGX2d61fdtoWL7w1wEYKSp91/FpU3I6IaTM5vBUNQTRx9H7Ck6c1tRDfUYPyQSihrtI5Hv/F5ULztDNyUyhsysxps26JbG560PvoepEokYiJw90e/5DwqJeWV/C9aLkb7MsMIsWm1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822452; c=relaxed/simple;
	bh=vo1Co20LyMBJI8m0D4/8W3XwqP+EfKU0qxcV1DHn78w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5yIeC9ST19+FwkxPfjBHi5kDkEXhJqtW+PC7zugHtMLJWmqRu7NDjaFcpg/i6vcW8ZyCpoCmHC4SRdRH8v4uanql55RNYafec7M2ZTnklM5aJzKgRHhHV+Fsz0BzcaA9hjoaBaUaCPqAqT8KKoQCM82ZvNt7AkaUMLs04RNzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQpzBpdB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQpzBpdB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso29309495ad.2
        for <git@vger.kernel.org>; Sun, 03 May 2026 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822449; x=1778427249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDlcX3iGxxASyEV+X1aZt9jSZv4Hs3OCvox3rGYsnhg=;
        b=kQpzBpdB+sJ9/kBKgJCLExX71o3V9a+IqPT0h9sKTIhhZpfWOzKP+4W/yMXZk1DfA5
         P3Apv3Z5aYRGD8nyICFuWKv7kNGEeINTJm/ou/CZH76rgxax89Z419NsjuxIXWItcFTF
         YQauKwziZU2/dc6htpefJg3Q6R3CQ5nvEwESakWnR3BO/8SRuD7BXAsmZTQtSoaRDwlp
         jzCI8Zn4X+3N1R97nQuW4Zzz45kXEe3q4BeQh7EwgFbwAWa3XLz1OqhGRorI/YZH5YII
         bgrdThyPAWwZcW5QnxM8eoVPdrSFt7Ev8yfiZVrEFFdmCnFCiAnJjhqARzEVQmGQtnZU
         SHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822449; x=1778427249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QDlcX3iGxxASyEV+X1aZt9jSZv4Hs3OCvox3rGYsnhg=;
        b=s4hXaCDRfYhacdCmaCzi/JiEICHrPM1aX/cXqdKzAognvYoxKx/v8aqiVVOuCbUJkZ
         j/Hzqvf9klE3y0LMbVLOE/ayGC6i7zsPHfbQmrLADke8+uLsnM8HQtAi+H4V326E83jM
         IMxe16DYHKQ+28N6qX7SXW0Dcswmkp+GimlnE2vFJa0Tb0UpAlP9XXzyW5T3rGqsmpnV
         2GvqXhaLoYalZ9wy4iuO+ItUSb8dpYNSD240S7GhQTVr2eKdwSCHbZ8O6vlETKwhq3kt
         Xp/o9ByK4YgX2LsdybWZEiZtWgREerDynayGYSxpL/jy4aE9u71HjQ7R+zWBWnPq33Z2
         gEgw==
X-Forwarded-Encrypted: i=1; AFNElJ9UR09cMLJDUrRvSNGR8e9d2+oc9JSj00OgCmg9z4FBhb9Wof9NsNaAy8mDUMhv1WfRXN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSRdcQk2a+gQDsEZjnDtm7tfSlZBo8vkA8IvPSA3ykNapIJfh
	M4cVm+frJWNfKR21JNnzg7k1Do/MGCUyyABX6NguKt0ZRuwjCKWVt8JY9C9N0xzqeQk=
X-Gm-Gg: AeBDieumY898XMy82XpV8F1+aFzxmsbUZmln0KHbPJvB1K2KsKP7AWGMFJ++hUCSeL8
	w0FufuxSPuMsghxnZ7tOlk/qg/9XmHX3frBoXzs8VpDTy856zEuzvr2xjpYHZKJ8Z64yRf8Rd8+
	DCbxRRkeCA8BrtFPPlo3WNB/znP/+faoSPiJMYyXUDhLvAGwpFC5NENJ8NmL6IN2TARrzA+GjR/
	IcudVFG4b8eb2UFpy2bHTQJnM4ZUrAfXiBkiZ0hTfiMhJU014mEucRFuisFIIRPQf/6mKiLaCLn
	CvG5VdajIGwJdCHmtavN+0CttvS4t2YZhDHEw7xMPiA73vlvy9tgXTG8W074NyGmS+bIRaLCQK+
	Ph1UJ9L1RI4IhVLSe+aoIX8aNlDHmeaCF11zlAfpMiLaRK9/7oir4PRXIUHON6oiJXRlF3Zens6
	19N1sU7quCtTZPd6U1a8L7Qv/+CxoOmhVR3HQC8+YoL9KDFzRICEgD2iOKRoRkgEvj6mQ9QlKl
X-Received: by 2002:a17:902:c406:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2b9f2830796mr66515465ad.40.1777822449112;
        Sun, 03 May 2026 08:34:09 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f0acsm74618375ad.38.2026.05.03.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:34:08 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v5 0/3] push: add support for pushing to remote groups
Date: Sun,  3 May 2026 21:03:59 +0530
Message-ID: <20260503153402.1333220-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
References: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
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

Changes in v5:
- fixed the -Werror=sign-compare in builtin/push.c complaints and also added
  a new commit that fix the remote.h

Range-diff v4 -> v5:
-:  ---------- > 1:  e01126890c remote: fix sign-compare warnings in push_cas_option
1:  20ed79546f = 2:  adbce652e6 remote: move remote group resolution to remote.c
2:  964694e587 ! 3:  a8d5f4b7bd push: support pushing to a remote group
    @@ builtin/push.c: static int git_push_config(const char *k, const char *v,
     +			 const char **refspecs,
     +			 int refspec_nr)
     +{
    -+	int i, result = 0;
    ++	int result = 0;
    ++	size_t i;
     +	struct strvec argv = STRVEC_INIT;
     +
     +	strvec_push(&argv, "push");

Usman Akinyemi (3):
  remote: fix sign-compare warnings in push_cas_option
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 Documentation/git-push.adoc |  80 ++++++++++--
 builtin/fetch.c             |  42 ------
 builtin/push.c              | 251 +++++++++++++++++++++++++++++++-----
 remote.c                    |  37 ++++++
 remote.h                    |  16 ++-
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 160 +++++++++++++++++++++++
 7 files changed, 502 insertions(+), 85 deletions(-)
 create mode 100755 t/t5566-push-group.sh

-- 
2.53.0

