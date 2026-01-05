Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411F33372E
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627301; cv=none; b=M+u+UBm5h9QHka5fEWB/MRjbsI2yr/T8d7AIbqssPaPCqsZ/RS9drbMwVOXx3gCkwlm0ysc1Ya4pNE20Kv/146GcD7SLORy66Yvata9GwcLkUFyPV0YPzoZecI7stZ0kOlW4qqWs01EaVriayajbU077sXOQ5ediTbAXv8qVv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627301; c=relaxed/simple;
	bh=h2N6Vs1L35Q64apKCcmxVx67ltM+flKq8+j5GLjQdt0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ugK6VcS/GTPaJ/D16WeprubMW+I5SJcds5pVUkzrTsoiZPEiY9WwenX85oKV9KUgEp0r6kUG2Tf5HTjM6DKqKJ5VJVs0sZnj9d89DxqgjPs2aSFBhLydYwrqGO8wTStGW+u8vZbQ+08yiKWD8Ht+16XbERUNDLWb4+pxqnwkeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWIPJYD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWIPJYD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0834769f0so54675ad.2
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767627297; x=1768232097; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaFi9kNJXnTwe1f6kdbwu2miF9ZTsLL1ZmMk7wMKNU0=;
        b=QEWIPJYD9kYGgAayzD4N/j4oz73hg2L7LD8A5BqPl8q2+gNdjSt00tRA5YaHqX8HqE
         fcCiJ7P+yKeRZIqZQvZOQof60x4WnS+FuaXdORbklZQKI8qXXdNsDA9IwggbeKQi499Q
         wQMVflnCaoB/XmHdmL5XQbnv7uqV/3sVYOen6Z7cJNoxxAFrpTek989ccxfXMlRulmzr
         8eI2rbZQu3qZGMol6cfErlekjRM3eMflECrptxfyNFMOvhbYJeg8DALtTtOJKjrN6K7u
         ERhylbW3hoD5TCeXxhpK5Coc6iyqzMhUk3AIyyqb4mMDhC6Z6gSgThOIWpjB+y6BKJ8P
         0rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767627297; x=1768232097;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaFi9kNJXnTwe1f6kdbwu2miF9ZTsLL1ZmMk7wMKNU0=;
        b=QGpBnAPurvKhMMnEp+xUYYg4bqFgoSKjpejNTI8q4NbT+XSgUNMZjpwG98l5BysZtr
         U2WO77cheyuAJTefQKt1SoCmso7Yr5+Al9HanVq02a/k5CajxfSGLi9fo8o11vdulc4h
         CXq/E6hOz2E0Hj3hrkIEOUQ+ZeoVWSaeLxlPxPicgD33UalfbI10VB6P0BJm2zhHP9bR
         9BnAIy3J/OZdSCT+u/C3aUJ0KmtJKWFc84pPTwFJ2lkgaseVVRzOQ0sIHyMPkkjxZRLN
         22sXfdbUXIuUVy+p7QIniecyBv8lsIYrNIeMBErc5uAy8jh6U3zlsKGrOhdOA+zBvUNm
         3x9w==
X-Gm-Message-State: AOJu0YzXQ7I5gnQicjuyUrtzhBi7XYfIKEhl6Kq1Un53Y/wrcq4PLeqZ
	ti7SCCqLPwNC+V0IJ0tXs2h/c5FoVhLnQi4khx9UYOOkBQ8LZBmzQA7+H7SYb2iiRnV5RYSdhVB
	YbUaO4CZ0zbJ8vEifiM7jBGiHKaicEYPoNQh5xQFElw==
X-Gm-Gg: AY/fxX40ctkO0xCeWNIYAmj79nqWhn0dQV7AO51mYS4+Fvyx+zQHxnjm79spUYJ8RDS
	WrXekpD8C0eFXfm4vdKHb2RWH8aXkGxYitNPu8kmX9OsEvorI8s9JelZugi7CY1RtoTggxgnLTM
	tGLZlwxpIBBQqJKPG+uuEOnC0/0G6RS4n9ziSAKk2fQ3tH5O1XpTTgkvDjmxghex3TTGMvb0GSA
	TLcBbL5FLrrw9j22HD+78vFyoSTh55VCPsn5E/qBpRmKuIIDJahbft4kO57R4PJS1tHQxFP3w==
X-Google-Smtp-Source: AGHT+IH077SjT1L6aCT2Xk1kUVni/jzjogh3yd0sflMDfmptJs9sc4GshBpAK2iLYVEen3Z7Nrm2yEzR+HxoRTdw/ws=
X-Received: by 2002:a17:90b:3849:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-34e921be35fmr37833438a91.23.1767627296736; Mon, 05 Jan 2026
 07:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Son Luong Ngoc <sluongng@gmail.com>
Date: Mon, 5 Jan 2026 16:34:45 +0100
X-Gm-Features: AQt7F2o-l1t4M5SOZJhj98MAslDMJzy9qjhhZsoWjqIuQl3GxUnaTBjqyelOyiA
Message-ID: <CAL3xRKfeij_3OUzVPv6Mr4bXjwkB_m7DZt6cbisL-VD473QLpQ@mail.gmail.com>
Subject: contrib/bazel interest check
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

  Hi folks,

  For my personal use case, I have bootstrapped building libgit and git
  using Bazel, an open-sourced build tool by Google (1).  Currently, the
  code is squashed into a giant commit (2) in my repo at
  github.com/sluongng/git in the branch sluongng/next-bazel.  The commit
  is based on the 'next' branch from upstream.

  Similar to Meson, Bazel requires fine-grained BUILD files to be
  sprinkled throughout the repo.  So it's fairly invasive to try to get
  this merged.

  I also won't have the capacity to maintain this setup for every new
  upstream topic that comes up.  Though I am willing to spend the effort
  to maintain it for major releases.

  I want to send this as an interest check to see if there are folks who
  are willing to co-maintain this with me in-tree style inside git.git.
  Otherwise, I plan to send this to the Bazel Central Registry (3), the
  public package registry for the Bazel ecosystem, in overlay mode.  The
  overlay shall be applied on top of the checkout copy before Bazel
  starts the build.

  Although the patch is currently unpolished and only supports Linux, it
  can already run most of the unit and integration tests under t/ dir to
  verify libgit and git.  MacOS and Windows support can be added as we
  mature the setup over time.

  (1): https://github.com/bazelbuild/bazel
  (2): https://github.com/sluongng/git/commit/04c5a9ec4c3634469b2b7eafd8ba21e09ec3b326
  (3): https://github.com/bazelbuild/bazel-central-registry
