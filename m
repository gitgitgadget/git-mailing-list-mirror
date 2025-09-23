Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF12FF658
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656710; cv=none; b=KgLnkRUsUOrRr3cNQEwkwCjq1z9S3k+7az4AuzmYbPfz4709MMRhDKPMp4Nk3n2zOOIiRfvlSHpR180REPGQHpXqnx7UHRP8H/pKlim3Qzps7kvIpm/SyajYLbS2byTFG19em+yNIeXHc80yD3JF4eeA8XfKaOqdzuUfBK4oVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656710; c=relaxed/simple;
	bh=6tLV3As6bvaexGPnpR+N9o/8VElSQyUahH+T1E0E9vI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bSCau6qbIvSgCUyNt+I/rZGPOjR5u165t0kY55IfVoiZVpk8+WODx2+M1Z6B3NVljRnlo9iRczFlNyt2MECd5QlEZBx/HapMMWU3PiylKO45XWbdugp44UTZpjqcvZIzbnRiZHumrtpcM+U3539PSqGuTjbatSw6/aHqRqr3cHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+dhxMZ+; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+dhxMZ+"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88432e60eebso144431439f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758656707; x=1759261507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8jKVoEobn4VIzYmHrRsfN869hg5pPr2xLns9a5vn6o=;
        b=T+dhxMZ+AB1hvEqpLHNz6zTpaSjrGL8zigQXZDNxa+a90wPcpiMtWvf50YTf4To/Fe
         83Iq8lwY9sxmIbi5a6rTzLdpfr2HBEb3S9NNMrgZBsbZtZOgK0WfUs4Z/RyGkpbpTUa4
         ZUmGzYjkNzO/YW/6lmEZevfNt0RClGiM8t2MHsnmgpvUb9y0fyG8il/+WRLHNZCUxzZm
         GxF7B4AFJaERmnuXuEiHzjd2sQaQYBwl73mZeBrp3lFcPF9QasEIiOYJaRUDJ/QXIDIc
         8OKtoMUf4uZU8e8333O9pxmt7g6QQdfSknaQpcuJVjoqjahWuaFwZzPcKC7y9poYpTTd
         U3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758656707; x=1759261507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8jKVoEobn4VIzYmHrRsfN869hg5pPr2xLns9a5vn6o=;
        b=ufCyj1vH0uw89ME6uuhGrbaI4ruYz6mc+0hFfii7WorANPXSnZ+6zGlCnTMoLBg2zp
         7yQyKuyT9C/yWoqYNT79fSet031yim9hXMaEd+zNJgtK8AUSRIJv7H8euf5Y7WtcdXht
         fy9PuNuky6BIOPeXrhbC6n7afKOmU/D7ngfhVNKD6ESua3N/9qfQ2GvC6rgWARaUzVyn
         s2Hwca6YTs2FNOhvYoj5zHa3K3A2vzOjETjw83hsba1/94RnhuXheYKz7lOWC5mLDmyL
         50yodA19RZYjUo9sOr1EEpw6RYYLYMVxBcjHV4VjldGQxCauMoZ87oO9N9OF3A0M3CzO
         VPrg==
X-Gm-Message-State: AOJu0YxuM1XQx+Xf/ilaidEugr8Q4nLdzPgReA0CwNCZeh5uXhbGATDG
	zVEXX4s8BT0Zy+KJ0FT2y4hAZElBzgdIhgR8AFEl7VpiCQjQFdeXPaDJKN93bg==
X-Gm-Gg: ASbGncsWMClq7zmStl3op6/jvuAeQmsi8V9BDUknENhc5Cxip7/cRbGEIVOzAcBpt3Y
	tnig304Iu+prnamcNCpkXALmTZ9rkJPjfLRhGimRlMeYujHx4n8g640OfD0+z/DHqa3F41dfUQP
	f2uGMBRZMG585Zv2Q1lZRx/lE5K5+crAdLg08rzYs6h30SlSxIyKdGVsoxVFiGc8kt3T9CxzDkG
	p2GLRrc1o3p0HaOoFKMao0Mti2LZQloxuIhPny6MyTHqX6YRxPyKy4/lBsd1bn4z5ssOraK9RtQ
	N9J9XvpNNwrhDWft9SVjlnY5c3yNHxR6CnjeWFwnZPeRJC3AgDUDes+3him5KayKNd4O85Re2ar
	/mVbFZKY9XWQph1tEIzIP4lOWqQ==
X-Google-Smtp-Source: AGHT+IEN7xvTimORXTJkolHFZjTWDcsedGrjFYJ54OwwHtHI24Q+cf171GAUFQKMIo0UuMayFoJdxQ==
X-Received: by 2002:a05:6602:6016:b0:8e6:5e2a:b775 with SMTP id ca18e2360f4ac-8e65e3a015fmr517280039f.17.1758656707155;
        Tue, 23 Sep 2025 12:45:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.130.210])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a47d92024asm558472839f.13.2025.09.23.12.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:45:05 -0700 (PDT)
Message-Id: <f69d2e6fabbace9ae76cb3822b063a3f19622138.1758656702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 19:44:59 +0000
Subject: [PATCH 1/4] doc: git-pull: move <repository> and <refspec> params
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- it's confusing that we use both <branch> and <refspec> to refer to the
  second argument
- one user is not clear about what `refs/heads/*:refs/remotes/origin/*`
  is meant to be an example of ("is it like a path?")

The DESCRIPTION section is also doing a lot right now: it's trying to
describe both how the <repository> and <refspec> arguments work (which
is pretty complex, as seen in the DEFAULT BEHAVIOUR section)
as well as how `git pull` calls `git fetch` and merge/rebase/etc
depending on the arguments.

Handle this by moving the description of the <repository> and <refspec>
arguments to the OPTIONS section, so that we can focus on the
merge/rebase/etc behaviour in the DESCRIPTION section, and refer folks
to the later sections for details.

Use the term "upstream" instead of 'the "remote" and "merge"
configuration for the current branch' since users are more likely to
know what an "upstream" is.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 48e924a10a..50af7fde81 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -27,17 +27,6 @@ and then depending on configuration options or command line flags,
 will call either `git rebase` or `git merge` to reconcile diverging
 branches.
 
-<repository> should be the name of a remote repository as
-passed to linkgit:git-fetch[1].  <refspec> can name an
-arbitrary remote ref (for example, the name of a tag) or even
-a collection of refs with corresponding remote-tracking branches
-(e.g., refs/heads/{asterisk}:refs/remotes/origin/{asterisk}),
-but usually it is the name of a branch in the remote repository.
-
-Default values for <repository> and <branch> are read from the
-"remote" and "merge" configuration for the current branch
-as set by linkgit:git-branch[1] `--track`.
-
 Assume the following history exists and the current branch is
 "`master`":
 
@@ -77,6 +66,24 @@ pulling or stash them away with linkgit:git-stash[1].
 OPTIONS
 -------
 
+<repository>::
+	The "remote" repository to pull from.  This can be either
+	a URL (see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
++
+Defaults to the configured upstream for the current branch, or `origin`.
+See UPSTREAM BRANCHES below for more on how to configure upstreams.
+
+<refspec>::
+	Which branch or other reference(s) to fetch and integrate into the
+	current branch, for example `main` in `git pull origin main`.
+	Defaults to the configured upstream for the current branch.
++
+This can be a branch, tag, or other collection of reference(s).
+See <refspec> below under "Options related to fetching" for the full syntax,
+and DEFAULT BEHAVIOUR below for how `git pull` uses this argument to
+determine which remote branch to integrate.
+
 -q::
 --quiet::
 	This is passed to both underlying git-fetch to squelch reporting of
-- 
gitgitgadget

