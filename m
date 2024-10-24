Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82C200BBE
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793332; cv=none; b=BpYci1Gjx7CcAS7UWvzMLfICH/TjNSSpd1tBGlzFGmrJryO3zG3lybzZy+j94leRF3zIWCMAfiC8kWMOI+bUb3evMm8EvjNZ5+lBiTu2VptEUqA2UdxC5GJLZjInTZrLcXVzTFw7z6yDZLNbG5V7Dg1LNIlki2ISi0EGwD8r6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793332; c=relaxed/simple;
	bh=Bwftl1ACaSF74aIpfmgweuSx5VWd4GQsTOzz3D4nDdg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cx9xfADoUS19Gk2/rwvu/r+9Wq8AtDqWauJ6VJ2uBkNkEzlJcPPJpL7gVsbt9+jtamKze38HTL1zBmg00BTZQJfYRVlRYb38/nm1FbjucWX9sGTQ2LJL26WTgipGYs9Lo7E0T3nxRSWpEC/lceceoqTs7Cim4Ak/b4awK2zo4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IPIdiilV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IPIdiilV"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293b3e014aso2126335276.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729793329; x=1730398129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3pqvLeIytKZh0Uw7pNRpRP3gOtBNrs+yvYoKX8eDmmM=;
        b=IPIdiilVmUQ7k30riKkPREGG49IRuhGQDECYFilq5NpzjIovDw8aLcdqOYBdKHpdVT
         nsfoEqtQ/qTq+G+rZEVHDThGS4eBcHovJKzpJnrunVWE7/vdNhBU6X8QJ781jP397DyU
         0rYX70m4tDWOGlUNKvxSawlsq6f+6N79oKhdzddkedkdoRe0tD3mfgmN4WFFRgtMRk1f
         0jiOwKzIKMZKNNTPYmGI+dOqtYq5S+iv4rF0vWV0FWXbgW+/qbm/kuAMUUrM/CkqavII
         6c5pYNZ3F5K0rPYawduwKDoZRYh7O6Yb1jQum20rfPAIm44AOK8vIaKHTHlMvKsb32oB
         bRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793329; x=1730398129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3pqvLeIytKZh0Uw7pNRpRP3gOtBNrs+yvYoKX8eDmmM=;
        b=oj1KM2tvq3/q3FqjI17BWtzthb7/sYV1oyn/Nk/jhVWOmy8X2OaDOzIXSJqiwcDBaI
         x1G4OOp4gwkCF84muMTBavw54Kzd8mbafsby5KrJ9pi7CtmmlEvnarzt6MZnHxnUBks3
         E+NmLbgIZVis1RyIe4BERKPvCx0z+xXjV+/luChQeJgeWm+6EinlpY+dmN6Y5xRNwlqH
         Y4Ag0IkSgFxcZmqbEZY1FJBr8OzOgLmb1twzR+/XhvRryHYAHJz90mW8XsFZOKhR4ZxM
         dLigdztjtH4ONj4ddzbJ8HTy4o9LSbBCSA8BaWNkn2STIuoVNylJ7fKboq0ACL2vRiw7
         oSfw==
X-Gm-Message-State: AOJu0Yyzv+YOqqGy13fuBxeybacKdCYe3yZW6OzR0haixqolzV0l/FBk
	qK8J0ux9zGW1hog0tVLhK2WdXkVFH6uticGYxh7tpbUzH2pGDjMlabGZVE+9dm3IiUMH4IYgG1V
	c/Qp2CVjuQi/q4j+2MCGqHr3Wrdcqz0nn4fdf3z+qaG0ECB3gPpFw1MFaXNuCwbaBBIAUntrG2l
	liofCJM46GPV8hwxrlw81J9D0K7y0CwQQJzO4vysXdc7f8tL9YcG5bittfNF5ES1KH7A==
X-Google-Smtp-Source: AGHT+IHqbOIgCUrYELGZFcQezA0w8I+95X/Wzwohj4CuDlJpIoMaaD/pmSx0staZm4EQON4p9y4aE1s3RbqIDbp01sVj
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3554:17cc:309d:28c9])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:531:b0:e29:74e3:616c with
 SMTP id 3f1490d57ef6-e2f22f1463cmr1426276.3.1729793329449; Thu, 24 Oct 2024
 11:08:49 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:08:39 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <cover.1729792911.git.jonathantanmy@google.com>
Subject: [PATCH 0/5] When fetching from a promisor remote, repack local
 objects referenced
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, calvinwan@google.com, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

This is a polished version of [1], also with all the test failures
debugged and addressed.

The first 4 patches are cleanups and addressing issues with tests, and
the last patch contains the actual change.

This aims to solve the same problem as [2]. Some issues with it have
been brought up in [3] (e.g. not being able to identify if an object is
missing due to repo corruption or legitimately missing because it's been
promised, and also GC not removing any local object); these patches do
not have those issues. (Admittedly, these patches may have other issues
- mainly, more work needs to be done during fetch, and that work may
result in duplicate objects on disk, but I think that both the work and
the disk space used will be minimal, and the extra disk space used will
go away after a GC.)

[1] https://lore.kernel.org/git/cover.1729549127.git.jonathantanmy@google.com/
[2] https://lore.kernel.org/git/20240925072021.77078-1-hanyang.tony@bytedance.com/
[3] https://lore.kernel.org/git/a5e3322d-4e63-4b8c-84af-6578fe257cad@gmail.com/

Jonathan Tan (5):
  pack-objects: make variable non-static
  t0410: make test description clearer
  t0410: use from-scratch server
  t5300: move --window clamp test next to unclamped
  index-pack: repack local links into promisor packs

 Documentation/git-index-pack.txt |   5 ++
 builtin/index-pack.c             | 110 ++++++++++++++++++++++++++++++-
 builtin/pack-objects.c           |  31 ++++++++-
 t/t0410-partial-clone.sh         |   6 +-
 t/t5300-pack-object.sh           |  10 +--
 t/t5616-partial-clone.sh         |  30 +++++++++
 6 files changed, 180 insertions(+), 12 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog

