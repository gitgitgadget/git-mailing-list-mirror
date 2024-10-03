Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24514F90
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917800; cv=none; b=YKCyP0+Rix/IMpK4OpgHU1Jla7wknLln8Im1j1HYBLRwN2i+1Wmf6yHJ77lz/NWpj9390mDKPlGrl2EIKjOehaCzy6avJoeyp3tmkutJyk3ok3O9ZVk9c67KApsrnSVbiTEEU2c02hwSVHnGSublgwj3+jry3hgV1lnVfD0Vn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917800; c=relaxed/simple;
	bh=LDaTYDJfscQOu6QT0Y2ajazbUbvKtsojKQibfWlAx2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AylpzZ1yom64uvAGNTm4PlKJmSiwa4FrttnjeEm99e79ZS6Svcfxi+dlWdOf+yOXHzieWJhQNX4p7iRqEREofe9IZrNr2ngQKfvCjlndVW1TK6XnUeo8WKm+/mIudPLPKyeUyEvUwOuskkBPgzw8YZsqfM4W8vmhorEVz1zYSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2sg8l85X; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2sg8l85X"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28833f1c31so121368276.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 18:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727917797; x=1728522597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gjNaeGR7DuR3SH/0gLHuECHD9YSb2Gqcq5uIsWUH4Q=;
        b=2sg8l85XFhyV/yaPZIt8BqTL//2vEwfXbGBaGyK3fLb65qzzafH7WtdK5ScBEgCz0Q
         r9WdoAtCsx0hLlRjmhUq7Ahf22Rt4DH5EHS0u5bqp7VcCCXubBgSnYTZeMc/6E6XYhw9
         duh6BSJ9oDzu0L2zBkTer1KUKylL3eh8HaNuul+DD96/ZOhMlwhefX3OmPveeqCI7xo3
         d3Lwz83IFiz+cVkWGP5PdHdNEdpG6+hnPFs8l+kaB9uKezgxNzQStj2dOgaQHGvIAXm8
         4SC9AW86FLgNxisWxjZukuhn6t1AUpeszsM9YS/Gx4zZimCj8WizmfP0kxu0ow9Hco+O
         1yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917797; x=1728522597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gjNaeGR7DuR3SH/0gLHuECHD9YSb2Gqcq5uIsWUH4Q=;
        b=CDLhntNajMWJcBDcWObltgRk6hCE6LmMKQTFyi4dD0jiZiaBrIHyuFuAysDVgdp7Tr
         QBOd3peji01ZiYjWPc6M6JWkp14o7QdEJuXt7i5U+koNA6/NRJtOQR3oxKsAYCQe6A7y
         ztz369m/ChO1Cs9EeXWeaZoVJl3I0kJbow5NcTvSJLvxp6AAGzI5+Ur1zI+WgIMy3Ggp
         v3DfxOuvN2J/D/5UozaSldiYqfpoSXS6rrsMUFUv8OsMEFAGuoCsV0D7wUpHFOYfhNK6
         xkSnahNm3g8sbxqz25X896JVYNADXet5vXx3jHafxqomI3oDkepdg6L5mwoZQmrC9o2e
         5VTA==
X-Gm-Message-State: AOJu0YxwKNnAY5F+M68WhkJfi9MqUMV9OgaAvXcEH3gVw2R6b/7XK52p
	tnpx50hPhVAmriC/kIi7leHik1Imw4WN/+bkxvFfEWcop3f1OcJ7DlMFOnc8RZJEGeOaUVMVWiJ
	UhGA=
X-Google-Smtp-Source: AGHT+IGKqwQD/qw/PO3m+TmmyYnMTO1+HHKmgGuqeCy2ckca/IpV9z8V7yv5/5cTZNIOCO5sNYBdSg==
X-Received: by 2002:a05:6902:1b13:b0:e25:c640:bc3d with SMTP id 3f1490d57ef6-e286f818bd1mr1360087276.13.1727917797590;
        Wed, 02 Oct 2024 18:09:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885eb23e3sm51267276.44.2024.10.02.18.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:09:57 -0700 (PDT)
Date: Wed, 2 Oct 2024 21:09:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH v3] Documentation: mention the amlog in howto/maintain-git.txt
Message-ID: <88a13b9f2b6e7fbed517a7e268e4e371d84a9a10.1727917792.git.me@ttaylorr.com>
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>

Part of the maintainer's job is to keep up-to-date and publish the
'amlog' which stores a mapping between a patch's 'Message-Id' e-mail
header and the commit generated by applying said patch.

But our Documentation/howto/maintain-git.txt does not mention the amlog,
or the scripts which exist to help the maintainer keep the amlog
up-to-date.

(This bit me during the first integration round I did as interim
maintainer[1] involved a lot of manual clean-up. More recently it has
come up as part of a research effort to better understand a patch's
lifecycle on the list[2].)

Address this gap by briefly documenting the existence and purpose of the
'post-applypatch' hook in maintaining the amlog entries.

[1]: https://lore.kernel.org/git/Y19dnb2M+yObnftj@nand.local/
[2]: https://lore.kernel.org/git/CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com/

Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/howto/maintain-git.txt | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index da31332f113..f52f32eda93 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -122,6 +122,13 @@ Note that before v1.9.0 release, the version numbers used to be
 structured slightly differently.  vX.Y.Z were feature releases while
 vX.Y.Z.W were maintenance releases for vX.Y.Z.
 
+Because most of the lines of code in Git are written by individual
+contributors, and contributions come in the form of e-mailed patches
+published on the mailing list, the project maintains a mapping from
+individual commits to the Message-Id of the e-mail that resulted in
+the commit, to help tracking the origin of the changes. The notes
+in "refs/notes/amlog" are used for this purpose, and are published
+along with the broken-out branches to the maintainer's repository.
 
 A Typical Git Day
 -----------------
@@ -165,6 +172,43 @@ by doing the following:
    In practice, almost no patch directly goes to 'master' or
    'maint'.
 
+   Applying the e-mailed patches using "git am" automatically records
+   the mappings from 'Message-Id' to the applied commit in the "amlog"
+   notes. Periodically check that this is working with "git show -s
+   --notes=amlog $commit".
+
+   This mapping is maintained with the aid of the "post-applypatch"
+   hook found in the 'todo' branch. That hook should be installed
+   before applying patches. It is also helpful to carry forward any
+   relevant amlog entries when rebasing, so the following config may
+   be useful:
+
+      [notes]
+        rewriteRef = refs/notes/amlog
+
+   Avoid "cherry-pick", as it does not propagate notes by design. Use
+   either "git commit --amend" or "git rebase" to make corrections to
+   an existing commit, even for a single-patch topic.
+
+   Make sure that a push refspec for 'refs/notes/amlog' is in the
+   remote configuration for publishing repositories. A few sample
+   configurations look like the following:
+
+      [remote "github"]
+        url = https://github.com/gitster/git
+        pushurl = github.com:gitster/git.git
+        mirror
+
+      [remote "github2"]
+        url = https://github.com/git/git
+        fetch = +refs/heads/*:refs/remotes/github2/*
+        pushurl = github.com:git/git.git
+        push = refs/heads/maint:refs/heads/maint
+        push = refs/heads/master:refs/heads/master
+        push = refs/notes/next:refs/notes/next
+        push = +refs/heads/seen:refs/heads/seen
+        push = +refs/notes/amlog
+
  - Review the last issue of "What's cooking" message, review the
    topics ready for merging (topic->master and topic->maint).  Use
    "Meta/cook -w" script (where Meta/ contains a checkout of the

Range-diff against v2:
1:  5cc8e2bcb88 ! 1:  88a13b9f2b6 Documentation: mention the amlog in howto/maintain-git.txt
    @@ Documentation/howto/maintain-git.txt: by doing the following:
         In practice, almost no patch directly goes to 'master' or
         'maint'.
      
    -+   The maintainer is expected to update refs/notes/amlog with a
    -+   mapping between the applied commit and the 'Message-Id'
    -+   corresponding to the e-mail which carried the patch.
    ++   Applying the e-mailed patches using "git am" automatically records
    ++   the mappings from 'Message-Id' to the applied commit in the "amlog"
    ++   notes. Periodically check that this is working with "git show -s
    ++   --notes=amlog $commit".
     +
    -+   This mapping is created with the aid of the "post-applypatch" hook
    -+   found in the 'todo' branch. That hook should be installed before
    -+   applying patches. It is also helpful to carry forward any relevant
    -+   amlog entries when rebasing, so the following config may be useful:
    ++   This mapping is maintained with the aid of the "post-applypatch"
    ++   hook found in the 'todo' branch. That hook should be installed
    ++   before applying patches. It is also helpful to carry forward any
    ++   relevant amlog entries when rebasing, so the following config may
    ++   be useful:
     +
     +      [notes]
     +        rewriteRef = refs/notes/amlog
     +
    -+   (note that this configuration is not read by 'cherry-pick').
    ++   Avoid "cherry-pick", as it does not propagate notes by design. Use
    ++   either "git commit --amend" or "git rebase" to make corrections to
    ++   an existing commit, even for a single-patch topic.
     +
    -+   Finally, take care that the amlog entries are pushed out during
    -+   integration cycles since external tools and contributors (in
    -+   addition to internal scripts) may rely on them.
    ++   Make sure that a push refspec for 'refs/notes/amlog' is in the
    ++   remote configuration for publishing repositories. A few sample
    ++   configurations look like the following:
    ++
    ++      [remote "github"]
    ++        url = https://github.com/gitster/git
    ++        pushurl = github.com:gitster/git.git
    ++        mirror
    ++
    ++      [remote "github2"]
    ++        url = https://github.com/git/git
    ++        fetch = +refs/heads/*:refs/remotes/github2/*
    ++        pushurl = github.com:git/git.git
    ++        push = refs/heads/maint:refs/heads/maint
    ++        push = refs/heads/master:refs/heads/master
    ++        push = refs/notes/next:refs/notes/next
    ++        push = +refs/heads/seen:refs/heads/seen
    ++        push = +refs/notes/amlog
     +
       - Review the last issue of "What's cooking" message, review the
         topics ready for merging (topic->master and topic->maint).  Use

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
-- 
2.47.0.rc0.8.g9a975e77790
