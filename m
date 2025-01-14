Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96D232458
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878777; cv=none; b=CA8UOwhwPa6Q5a15y0Oug0H/7ToXv42IN8/ke1vbgvDzRqPxuiI0D0g4w/hJlIdOLwle6jHXHUrxVqaE1nmXo4JLEoMznLtC+UWGi2fxjFIvbSNpSPJwv0wrA5zYywT1cwZISI1yB3zuOvq+qfgpxDdxBtYIbYkb+YGMR8764s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878777; c=relaxed/simple;
	bh=GPm1WQr1tFPfrQKjOmsHg/LHLez+DPEGKOxLPlB4h+Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lIvwavyRKldv24SYLo4kuVXofnejwp4hS27IDHBIjTA+sRl4yFzpA/xdnLITFwYZJ4RzIarjLRLnDnp4CxRcKQg3n21zVBDAD7UdoGH2UNYYaTdK5n1GBNDWeQ4Uej9T28IQKiN0p2rT0En4+grbfPVzBb9KqmJvcjEJCv7Sq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtwP/eWu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtwP/eWu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3863c36a731so4300679f8f.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736878774; x=1737483574; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yHVxZps+7w2UZ7B5Q2wGTjbrKeE24cfeetz/UW/pcdA=;
        b=gtwP/eWuz81xil5o9NC/rz1bq0xIdleXSSxLwduz2W3TTxGNiGWis2rOOLzeOsuB/k
         pxSr+LrBZaH+rMK1lh0bJ0AgzA0yLF4VUdyPvLHpHr8gp3HhtAn5/41IXg/uenlchi3+
         TA8htoHHc7B17bY7FYK4Jiinuu6zvoSsQkXwCfl4UEHIRFXEQMcQxkura2znM9G5p/Cf
         gYdE45YeZ8kYSX4ulZf/H6uXICU0kDyxpcLrkCOawAXjeb0cALjDpH6uBbZvYh4NeOzn
         G0xxE9o1PUEimlao+qoXtNFLek6qgmL+/XfTc0TyYkJ4s6xkXwqFTJXi31dXW0oO+qan
         j2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878774; x=1737483574;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHVxZps+7w2UZ7B5Q2wGTjbrKeE24cfeetz/UW/pcdA=;
        b=qhkgKBGdAvNOmi8wCwhpGfBXmLyLeziemI2yQ4y8n2IcLQyfjWqXgvKo4M0jwvdEki
         YSLPEX05eDNlF5XgUDjLbnsOIsB0aCm9HK70nGs+5uMoEbT/zcnPb/kmiPYR9OLokZjM
         /ifU7noGpmGHpHm8MmOM2VTQz60D5XanSKdzqLmsFVfHjLLwa4yzgL8sinYig9nfZakn
         Zp3coBhnSW47I5kBOtLnoak8Yj5SBqHfynTD3mWFjfdIYcMo/0qWOqZDuO3P0I19Dg2R
         RMimhHudWqjc5Rn88ij2kfWFLOXHGeDL7eQ7koVqz56hq+Fw61fmdWoXtutnUQKScIVz
         yxqg==
X-Gm-Message-State: AOJu0Yye0BdHkJp4bWT03R7VV5MllEJmcJ3iNPqg4y/rVz77GZCihM4Y
	eAUQN23T2LxTLt+vyV4SXoIUkb5i2QPF0ine5QFwCYP1acRpCZbGE0YQuA==
X-Gm-Gg: ASbGncuNsWNlLvU5EZp7tPEZ+NBPYu7b3A/znzigQAJ92Zo7jkzN093aQ8/zntbbicB
	JOejIh0RWT/SDS/VfwXGOE8Uo2FsNl5varoyh6+1r4PXHfYFi3sZ4fqCo6Jvpifm3QTB/6vTkcf
	8XrWcbuwKrug4pcDt0W6SD+l3Pb9YZDs34/IbgHYxlinaRYjWw5QYRGx8OlZlQCPG+zzPyIqtJS
	n0NALd6szVHRjTfXfl2m3JCHGHUbSJ2W1+eIk8X9dQuBOAWyjXfDqKo0Q==
X-Google-Smtp-Source: AGHT+IHkEom8Dv3ld+acdHR9NmqOOSDeAQub78ICOeMl3KZD+znKFVnfDkPMUeCqIKvr86mVGuJX3A==
X-Received: by 2002:a5d:6d84:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-38a873140f6mr24148214f8f.33.1736878773751;
        Tue, 14 Jan 2025 10:19:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e3834a6sm15404927f8f.28.2025.01.14.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:19:33 -0800 (PST)
Message-Id: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 18:19:29 +0000
Subject: [PATCH 0/3] Sanitize sideband channel messages
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

When a clone fails, users naturally turn to the output of the git
clone command. To assist in such scenarios, the output includes the messages
from the remote git pack-objects process, delivered via what Git calls the
"sideband channel."

Given that the remote server is, by nature, remote, there is no guarantee
that it runs an unmodified Git version. This exposes Git to ANSI escape
sequence injection (see
CWE-150, https://cwe.mitre.org/data/definitions/150.html), which can corrupt
terminal state, hide information, and even insert characters into the input
buffer (as if the user had typed those characters).

This patch series addresses this vulnerability by sanitizing the sideband
channel.

It is important to note that the lack of sanitization in the sideband
channel is already "exploited" by the Git user community, albeit in
well-intentioned ways. For instance, certain server-side hooks use ANSI
color sequences in error messages to make them more noticeable during
intentional failed fetches, e.g. as seen at
https://github.com/kikeonline/githook-explode and
https://github.com/arosien/bart/blob/HEAD/hooks/post-receive.php

To accommodate such use cases, Git will allow ANSI color sequences to pass
through by default, while presenting all other ASCII control characters in a
common form (e.g., presenting the ESC character as ^[).

This vulnerability was reported to the Git security mailing list in early
November, along with these fixes, as part of an iteration of the patches
that led to the coordinated security release on Tuesday, January 14th, 2025.

While Git for Windows included these fixes in v2.47.1(2), the consensus,
apart from one reviewer, was not to include them in Git's embargoed
versions. The risk was considered too high to disrupt existing scenarios
that depend on control characters received via the sideband channel being
sent verbatim to the user's terminal emulator.

Several reviewers suggested advising terminal emulator writers about these
"quality of implementation issues" instead. I was quite surprised by this
approach, as it seems overly optimistic to assume that terminal emulators
could distinguish between control characters intentionally sent by Git and
those unintentionally relayed from the remote server.

Please note that this patch series applies cleanly on top of v2.47.2. To
apply it cleanly on top of v2.40.4 (the oldest of the most recently serviced
security releases), the calls to test_grep need to be replaced with calls
to test_i18ngrep, and the calls to git_config_get_string_tmp() need to be
replaced with calls to git_config_get_string().

Johannes Schindelin (3):
  sideband: mask control characters
  sideband: introduce an "escape hatch" to allow control characters
  sideband: do allow ANSI color sequences by default

 Documentation/config.txt            |  2 +
 Documentation/config/sideband.txt   | 16 ++++++
 sideband.c                          | 78 ++++++++++++++++++++++++++++-
 t/t5409-colorize-remote-messages.sh | 30 +++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/sideband.txt


base-commit: e1fbebe347426ef7974dc2198f8a277b7c31c8fe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsanitize-sideband-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1853/dscho/sanitize-sideband-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1853
-- 
gitgitgadget
