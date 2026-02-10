Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D135957
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698584; cv=none; b=ZQU47yuhdOueX6B7VWmas+b1fIu2+i9UpjoSxkGGan68rfHmGCvFhE6OkLpW4MLmvD11OdjOSRlG2tAb1xh9BkW5x/kb+vyGJNNlaqN8AJFmvKGXkQxhiHeI9HT1UNd8hCuJGBmS+xnJ8xdR7RID/yepS/R0q806zyNU1f9QAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698584; c=relaxed/simple;
	bh=LejIqKooRFnZzKmLpsskwGN6gyTcVdoa0QGE8fPxN8I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jkXVE6EKvKEt+2Yxl/PzHTD6UhsQ88DP86zF6Uo4PWlBBm/rVoxa0wtsHw+8iTv3RHrUhtkyTIl/zxNuTld52c4DqpmDZGb9PxRVelYPi/EMdnIa2MjKRyF5IwNVXS+RfEOnHwgcIulrdpETPmeHTEkSfvQKgVOXfO+T4eSlEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io/M6q7N; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io/M6q7N"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f194e9a98so1547035b6e.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698582; x=1771303382; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DKNRA8X4EkDIjPgYxjwb0Kn3SmziucFt0vSwqLEBsnc=;
        b=Io/M6q7NQbFSGSIFBYr73hB+1/+iMF4TmXWoyGtc4jaxKkiIux0HNgjFnz/F/eHS0Z
         E4NsczAQSIkxBSLk3TjX2jj6fZCW2tj2C0zReaqhp8fUdwV+oKh2+Wtr27pZoMI1OGdG
         AZTwzN/C7TVZcovBdLhb+lUQTppmHSPDWmBA5PX6Hkk9/sY2F/VIgAyNZegkzVkYdjTr
         ddLdk5DYeyycXS9LqQ8gobmjh4ygvUoDBUfuO5KXHdVwGxTo6cJkVTOmkLUldrG0xqq4
         gt3ZUxmF/mEYhsaPLcuf2e/1htwWfWPx1cIram3Xbwc5qTsXNHITsV9NviQBhrbk3nB3
         XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698582; x=1771303382;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKNRA8X4EkDIjPgYxjwb0Kn3SmziucFt0vSwqLEBsnc=;
        b=WbpGd0+0POTkR3rJjSqUNMitDOPEnMNCh/1hTWRUq01EN4t5uvfM23C/eKb8wgyn3z
         aHuOxqcMClV8wZJjGgwXUV0JJbqoON9WUhOEL1f0UO1MNnfjCqSCbOnWZ2c4xD1dLmbj
         xCihptPBIFRspANVkrEclv9Vriq2qth6h7p0bLm49xWl8ilOOAMlIWUCHLqaJ9mGU65U
         gnPiX3PKU/dBXRBQCIIMzJ1+ob1Vh/YtucKsw/QVTuRzMjIUhXDyeR0LjaUVJJUQ1mWw
         cFGZvsI1mBhxCM2xaNxKNYqfqUWsXLJpuuqwXz1EvoDfUWHAPqMeSf9Nh4w+p/gpLq8a
         pJng==
X-Gm-Message-State: AOJu0YxvCxf50c/J2yos07Yol7WpHBWGxJjBXrKI1IwpMQq7+kDie/ic
	EEqbO3KnEHeCntFc0wCl8cCNdflr2T3szirt2zYlPdM4aJvKfG+R6S28oEFrwQ==
X-Gm-Gg: AZuq6aJR1O06/uA6nNudiCXj7/NIBLovE6WtFzcfvMtd2S6tJDZQVXNelj/LVuxdAkh
	aOAhvfkMjMpwsIGSR+e1gNzqqRhqaW8NhpgLzp/EJ9OmkcL4kpCgbJMHEyJPtEnUGpjC2ctVoFP
	M+d0GJPC19BJ1TkxbOt1XNxfbpzPFAkZJsV4vlOyf5JoJVAAnbC8eIr5Fusgk0lukAnsplC+M3d
	Y0j6uIug0izY09HlnWpEzs/46vjed7N93hYoszGo7lCsPyOTPYCy0NpfEzRAisEhjge8ZKbClH6
	hCHho38rGBH7CyXvrnDGd2Y/1yzT0K5U6fGASLOxNcsSnm6JvyLqMJgjGoEcdlx9TohfSN0hH40
	VccxYkrYxviz0D/gK8iM37ff+0cyqkMtnM+Q+BxXqpxf4KFBhE9c4o7eYYevoYMRKFpLtBfl7IM
	uV8WENWQ1arreM4sg20K3lYx9Q3g==
X-Received: by 2002:a05:6808:2212:b0:45e:e4c9:4915 with SMTP id 5614622812f47-46353ae146bmr410225b6e.35.1770698581968;
        Mon, 09 Feb 2026 20:43:01 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9df04esm7423787b6e.7.2026.02.09.20.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:00 -0800 (PST)
Message-Id: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:54 +0000
Subject: [PATCH 0/5] [RFC] Make 'git config list --type=' parse and filter types
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Derrick Stolee <stolee@gmail.com>

I started down this road based on feedback on my 'git config-batch' RFC [1].

[1]
https://lore.kernel.org/git/pull.2033.git.1770214803.gitgitgadget@gmail.com/

I had described my intention to use 'git config-batch' as a single process
to load multiple config values one-by-one. Brian mentioned that 'git config
list -z' would probably suffice, so I started experimenting in that
direction [2].

[2]
https://github.com/git-ecosystem/git-credential-manager/compare/main...derrickstolee:config-list

However, I ran into a problem: the most critical performance bottleneck is
related to path-formatted config values that are queried with 'git config
get --type=path -z'. It wasn't hard to update things to lazily load the full
list of config values by type [3], but I then noticed a big problem!

[3]
https://github.com/git-ecosystem/git-credential-manager/commit/d403c8e24ce6f37da920cce23842dd5a6cf6481d

Problem: 'git config list' doesn't respect --type=<X>!

This boils down to the fact that the iterator function show_all_config()
doesn't call format_config(), which includes the type-parsing code.

This wasn't super trivial to update:

 1. format_config() uses git_config_parse_*() methods, which die() on a bad
    parse.
 2. The path parsing code didn't have a gentle version.
 3. The two paths ('git config list' and 'git config --list') needed to
    standardize their display options to work with format_config().
 4. Finally, we need to filter out key-value pairs that don't match the
    given type.

This is marked as an RFC because I need to add some more tests and because
this is a behavior change! If there are any tools currently passing the
--type=<X> argument to git config list then they will have a change of
behavior with this series. It's an easy workaround: drop the --type argument
or add --no-type to go back to the previous behavior.

Thanks for any and all feedback, -Stolee

Derrick Stolee (5):
  config: move show_all_config()
  parse: add git_parse_maybe_pathname()
  config: allow format_config() to filter
  config: create special init for list mode
  config: make 'git config list --type=<X>' work

 Documentation/git-config.adoc |   3 +
 builtin/config.c              | 130 ++++++++++++++++++++++++----------
 config.c                      |  14 +---
 parse.c                       |  24 +++++++
 parse.h                       |   2 +
 t/t1300-config.sh             |  26 ++++++-
 6 files changed, 147 insertions(+), 52 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2044%2Fderrickstolee%2Fconfig-list-type-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2044/derrickstolee/config-list-type-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2044
-- 
gitgitgadget
