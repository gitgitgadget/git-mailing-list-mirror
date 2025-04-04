Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6431BEF87
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764173; cv=none; b=Rs+UA09W5eSc3W2QhqSaci0bNFoFxe0BS0FQihDcxkXGVTc477LbedgAyWtMxpNmc49z4X06NoVZpNIbYvLo7/8fIqk9t1jY2CY8+JGBaTGzScWRjGp8MqFCfQxwNhtM3PX7sFmxgBXjInFm/RNxAXePIHWeK4HhdpLEfjChNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764173; c=relaxed/simple;
	bh=IhrwcHzQlEXlbYyv5JBIgpS80AWgen1j4OOd1dgpDO0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pnkZNZuZ2Q8W5vkZdJPt1xRHIwm8SMAV3RGBl75e4xFsUH6eV+Y4zmkY0g3hwZe50fakXerzcknc9d0hGi7DhT3cASPPnB3R+a5XOaosMAbNHO+NkX+OJ12efl0T0TYlRBc5bB1gO/ghDcUcKFcxbZ3NzH2ug7nP0Svn3pyWSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lynxw4Fl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lynxw4Fl"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so1642386f8f.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743764169; x=1744368969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmahdcJ/4GRlHoZ4OkEZWYKAc9a4/zsiB9Xm4zc3XXI=;
        b=lynxw4FlHqNihZdDDtAl+5IdNnII5r8B1ddnmmdm/IvBnzavstSveqeVqGl4sE5nXW
         gEbTmkgiuAhfi53znGKmt9hSta659Uk5c3QmGohXIALG03jedbFccHHi/F01MTJR/DVp
         mhIxSHzrFdw5qaYVWXsGmraZ9jZmkF3SjoAxB3zMyr/leolgL6WTEJqYKtgj7U8VNYD3
         hH3JmFtvefMCVg/GW3OrQmq3eE/esmhWE6PmkYZQ5jSefOqWALaVPOaTOdguFADU9/oc
         B8KXV33VKMB0TUe6QUyC3ZcpR9epWH+VNzPGWokTJVPPhQzfBG9X93DlrKWfLHLqO0q3
         iPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743764169; x=1744368969;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmahdcJ/4GRlHoZ4OkEZWYKAc9a4/zsiB9Xm4zc3XXI=;
        b=RMHr3/AY9u330CHQPvxAMIxnL0C4nU8FTsaI+Y9JV9KFDKveYK4l/YA227p0Gjn4nl
         O3tYp5ktPRVRCj/HiJGzUcoa2mu5/r9x35qX7uMsH5+GLShz2DveN/3/qXtdj9IVwGuK
         JDgPoPH1tgS1oh4LuFBjpxOBl6hebovNlOKLkxbJX9+kUHXTiSyD+a2w1B0TUaWOWahz
         t2ruXl9m54PjHMcDfucMnmoyIkB3OySBJv1HhJuGn9t0mo1gc9VlGDfrEIQC315Zl4Yb
         pl2deL6GF15maTB3v+gJAJJK+plyNP1aNNVyjJ67ezNTnYOfb94IWj9fw+q5RA7lVdcf
         IBkQ==
X-Gm-Message-State: AOJu0YzItwP97qW7+W0ONyhUQ5TOjYtbFssHPSRpolzj8GrJ0pfz40kZ
	vkzWYgV3z9mKvlV+4ActNaPD7RP3YtVmwREBEQXNIZChfqB+Hk2ozmN7Pg==
X-Gm-Gg: ASbGncsu4YFbSIhBqjll2g+I6fx9KIrmTVutYg71ZDRvv5n30Sx3WMnKax+9JamtzuH
	nGoQKJK76czUiQKNjulAVG00pr1ETNCPFsp45kxRlC+cJiBVXemn/CZA78fTd7MZbt46CHdj+SZ
	qezRgZaZTqGdxEvqoEKXGh6ga5eDDlQ4KdZSoBxKPNL20tW3kec8OoGIkljRaHI7xHsmuB2je7D
	y14Fsa1nYm2gn05cIvI5iEnGphbMhve9MmF97rtJ8ZTIiPUA2vv7O+218yP37yJw2cT7R5ZIyHb
	AReoecjj+EQ1iTg91YzNHQQVU2rkR8drQ/UX1kwyx6wHoA==
X-Google-Smtp-Source: AGHT+IHFyQ1d5yvk2vf0aizscwmMPLuEff8UI10OkIJtV702g7VswfvqlYkLXANNwxWOGIzl84B0Ig==
X-Received: by 2002:a05:6000:250a:b0:39c:141b:904a with SMTP id ffacd0b85a97d-39d08833facmr2035007f8f.11.1743764169002;
        Fri, 04 Apr 2025 03:56:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364a0c7sm42464235e9.29.2025.04.04.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 03:56:08 -0700 (PDT)
Message-Id: <pull.1900.git.1743764167548.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Apr 2025 10:56:07 +0000
Subject: [PATCH] perf: do allow `GIT_PERF_*` to be overridden again
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A common way to run Git's performance benchmarks on repositories other
than Git's own repository (which is not exactly large when compared to
actually large repositories) is to run them like this:

	GIT_PERF_LARGE_REPO=/path/to/my/large/repo \
	./p1234-*.sh -ivx

Contrary to developers' common expectations, this failed to work when
Git was built with a different `GIT_PERF_LARGE_REPO` value specified at
build time: That build-time option would have been written to the
`GIT-BUILD-OPTIONS` file, which in turn would have been sourced by
`test-lib.sh`, which in turn would have been sourced by `perf-lib.sh`,
which in turn would have been sourced by the perf test script,
_overriding_ the environment variable specified in the way illustrated
above.

Since perf tests are not run as part of the build, this most likely
unintended behavior was not caught and certainly not fixed, as the
`GIT_PERF_*` values would have been empty at build-time.

However, in 4638e8806e3a (Makefile: use common template for
GIT-BUILD-OPTIONS, 2024-12-06), a subtle change of behavior was
introduced: Whereas before, a couple of build-time options (the
`GIT_PERF_*` ones included) were written to `GIT-BUILD-OPTIONS` only
when their values were non-empty. With this commit, they are also
written when they are empty.

The consequence is that above-mentioned way to run the perf tests will
not only fail to pick up the desired `GIT_PERF_*` settings when they
were specified differently while building Git, instead the desired
settings will be only respected when specified _while building_ Git.

Let's work around the original issue, i.e. let `GIT_PERF_*` environment
variables override what is recorded in `GIT-BUILD-OPTIONS`.

Note that this is just the tip of the iceberg, there are a couple of
`GIT_TEST_*` options that may want a similar fix in `test-lib.sh`. Due
to time constraints on my side, this here patch focuses exclusively on
the `GIT_PERF_*` settings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    perf: do allow GIT_PERF_* to be overridden again
    
    This issue was noticed when working on large-scale issues.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1900%2Fdscho%2Fsupport-ad-hoc-git-perf-settings-again-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1900/dscho/support-ad-hoc-git-perf-settings-again-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1900

 t/perf/perf-lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 8ab6d9c4694..39c37284452 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -25,7 +25,19 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
 
+# GIT-BUILD-OPTIONS, sourced by test-lib.sh, overwrites the `GIT_PERF_*`
+# values that are set by the user (if any). Let's stash them away as
+# `eval`-able assignments.
+git_perf_settings="$(env |
+	sed -n "/^GIT_PERF_/{
+		# escape all single-quotes in the value
+		s/'/'\\\\''/g
+		# turn this into an eval-able assignment
+		s/^\\([^=]*=\\)\\(.*\\)/\\1'\\2'/p
+	}")"
+
 . ../test-lib.sh
+eval "$git_perf_settings"
 
 unset GIT_CONFIG_NOSYSTEM
 GIT_CONFIG_SYSTEM="$TEST_DIRECTORY/perf/config"

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
