Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C90A927
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361658; cv=none; b=Vauxr1tiWaNa2omKBbdor+ypJFa0a8vM0Iiedadzc9mfZkxryYq0K3+gDPXUagVehotag804XlpQCBgR/qwOsQ17ZTs7RkArVonDzXKCKlYTz1LaEw86LN0kQ1NP8/V4kFXMAm9Cc1q+16ZLw8p7GvZafBQ7PZI93VBATLOqD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361658; c=relaxed/simple;
	bh=XkjkdBGtwc+e9tlFxtFgQb1JrXdOO1t3gWzz0Z7TogM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvUrkPAgQ5jLkSOla0HLCrWxsz1Ia/6WIn1uH+X1nZFUegSkVyh/lcNLW0qR7dpp7HVX6kp5VMYEHm+8t7pe10drsPIS3CzT3xqXqMCacH2QcvHg12rpF+NLueOI4I3rJ8aiZptNcXY3E0RObgigBsQNpw93HPCbaK7kfaDaTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR5dZnqg; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR5dZnqg"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8fd07da660so3058897276.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754361655; x=1754966455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psrbFWoIu98wX/fcvKjWKaci0/FZeJpobjHY6fNoubY=;
        b=mR5dZnqgItHP8/JQ9ap4Tiz9GwqMs3FPndH2PRxrbnIKIZjXeZpeNR0NyFDa2R1SwG
         BdRfN7WVTg5chP5O4PpoGkTGvVkQAZUoHdXNjzNChyNdNRL+tj9yLYbo4F14PS3oWGzN
         Ud3Qqq3IWUTWoWPCWJDAhYxhLqo+LYfsfCaQMWqaZoBofI24WwPgMFWj0ER1w9TQtduf
         OOj98wrQsdMw29yr9U+Jec9/p3/5T9LIbc4F6nN5+kfRooAOt8QCT623GElRNnS/PCqA
         4uxmAub1AIey08hxRvjm2npEp+p2cF0aEKgz1W8Z9Pbw1KHk625yTmXzVGVZjLmMThgV
         fhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754361655; x=1754966455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psrbFWoIu98wX/fcvKjWKaci0/FZeJpobjHY6fNoubY=;
        b=Zax3+c33nEvxWw3sIQzus6ipYi5rbQcyLC6w2BX7mDBG4c/DbDUKaB2hFuIEVhnLna
         n1e7XJNTT3aqZoZz/oTm8xFT4SlOkPe5qkfFfg67wxd9dfGozlhlXjKUJvn2d2xZ8x2s
         XompTQRpexyw6xYP5Ka2khSZOH3XroPsRabNlM7E75jWjtUcDZOeEHS8nOavZYIg6Q9T
         wDgT9Ra7LUXPUtWQv0Q7FnOsNSDqpC1HqMZ9lkFExyBZlCGKczlQHpAQalr6PrfkHWgQ
         TptVnu9XtOaVgGOSNG5RIEyz3PFXIDK4/mc2vgGnfk5g+1PsOC4AVb99ZqUbh58/eG1W
         0BJg==
X-Gm-Message-State: AOJu0YykiVECUz2uCNm8JtHsUNT/TREquC6McV87/uSBlHSamXZppQ+I
	9DA4caZoWBodtZuUIeBVgYIdRMGeCv+93V5y0daL2qK8d6OiovGl8bNCHn2BjKzd
X-Gm-Gg: ASbGnctafTrimCgmmfDmicwAnxSWLl1OE5y+0Pnt/k3/9UecyNg+rFiv4cJq1+JUW3g
	g8C5PSoMrZriLXRHLdr7X1ro+R7C3j4HCAC+GiKopSneqDvENa1LcmEJhJxFenI9gF3V80uJVlR
	TC8Aeek9HHipIQb3qPDD2+8Mx/O3at9GqyACmYJtH8xi89F0rlS/Hk20ftnbJ3/elusH+CbVViJ
	oHFSq7+a8j0WaXY4D5XUsSXi7Mpg/DqBgAyg/o5IRTiPBmRtDcCVblye/qEbESiTW4YoJUB+k3D
	lOg147crcK8Ikl2YbnIBpm1A/GQP3SMakEnzogfgfXeXGV5AmfZxPw3fZ1J7M39qkp68Cs2uV4s
	kim4gXjNeL4HU6Lu4fHjcGwi4bzuJek8UBIf8RAItyut3Bj5d/qyyX07Zmov2i1ff7Bx4XjlP
X-Google-Smtp-Source: AGHT+IHPktIDnGS9mBiRplQVuwjCDeTEXIcQu6XBHK51HZjKkVvpSbAe8pQLYwhjjowHKlBKvmVwHA==
X-Received: by 2002:a05:690c:660c:b0:71b:657c:5878 with SMTP id 00721157ae682-71b7ecdaafcmr135301377b3.4.1754361655198;
        Mon, 04 Aug 2025 19:40:55 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:f9db:16d6:17d4:7ce7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5ce7b5sm29895707b3.71.2025.08.04.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:40:54 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] clean up some code around editors
Date: Mon,  4 Aug 2025 22:40:39 -0400
Message-ID: <20250805024044.30024-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This "v2" of the previous exec-path series is simplified to contain only
the first 2 cleanup patches, which were largely acked by the list. Drop
the controversial and broken PATH munging.

Also, this version is based on a later master 112648dd6b (Merge branch
'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
original from May.

These patches clean up some old code in the editor tests and subsystem
that does not use our modern idioms. Patrick previously argued the test
cleanup doesn't go far enough, and he may be right, but I think the
preserving the semantics of the test for overrides /and/ automatically
resetting the environment is tricky, unless we can use a subshell for
the whole thing?

v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
Published-as: https://github.com/benknoble/tree/editor-cleanup

D. Ben Knoble (2):
  t7005: sanitize test environment for subsequent tests
  editor: use standard strvec API to receive environment for external
    editors

 builtin/commit.c  |  2 +-
 editor.c          | 10 +++++-----
 editor.h          |  7 ++++---
 t/t7005-editor.sh |  7 +++----
 4 files changed, 13 insertions(+), 13 deletions(-)

Diff-intervalle :
1:  da4fcc237b ! 1:  a37db65107 t7005: sanitize test environment for subsequent tests
    @@ Commit message
         Some of the editor tests manipulate the environment or config in ways
         that affect future tests (because they test a sequence of overrides),
         but those modifications are visible to future tests and create a footgun
    -    for them. Use test_config and undo environment modifications once
    -    finished.
    +    for them.
    +
    +    We can't make the environment-munging override tests undo their
    +    modifications because they rely on editor variables overriding other
    +    previously-set editor variables.
    +
    +    Use test_config and undo environment modifications once finished.
     
         Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     
2:  7b3b6b08f0 ! 2:  5450c99f59 editor: use standard strvec API to receive environment for external editors
    @@ Commit message
         Going back to the introduction of the env parameter for the editor in
         8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor as
         well., 2007-11-26), we pass a constant array of strings: as the
    -    surrounding APIs evolved to use strvecs, the editor code did not.
    +    surrounding APIs evolved to use strvecs (see 8d7aa4ba6a
    +    (builtin/commit.c: remove the PATH_MAX limitation via dynamic
    +    allocation, 2017-01-13) and later 46b225f153 (Merge branch 'jk/strvec',
    +    2020-08-10)), the editor code did not.
     
         There is only one caller of all 3 editor APIs that does not pass a NULL
         environment (the same caller for which this parameter was added), and
         it already has a strvec available to use.
     
    -    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
         Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     
      ## builtin/commit.c ##
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
3:  cb48533115 < -:  ---------- run-command: prep_childenv on all platforms
4:  d2e54fdf75 < -:  ---------- drop git_exec_path() from non-Git commands' PATH

base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be
-- 
2.48.1

