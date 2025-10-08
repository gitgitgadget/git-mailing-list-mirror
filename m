Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276734BA38
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951540; cv=none; b=Hq2qgQqcuDlkJoDQLJbYn7B9bKFOgijT6yWT0kfsfxj2O+xVfLSrcZW9CWKHly+Hj+Hpa0QeE74V8LLcI2rP+VznjXhCutaRLXUKqatQo1dHKQfNntie4WXBbWL/Ek8jmYfoSMiJb4uVvDTkyVuirnK8U8iYH7/I8/5NiLfnH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951540; c=relaxed/simple;
	bh=NUf5xpk5rkB0DRKHzK1ADOntGF5jI2Nbuf/FxMkb5nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NswYKrV+DENWXhDLUroNK/yysN1v2qHdyMIKESNeqf+07sAwpNIlQ6wYV7wGzdCNQxBjcF+jIZe5MSXzXuu6Dnm0oFt6Ii6pp1kL2FMcwsEBNCH4fyWbQ3UjEu54fI7WEsdsVkDfsArDgSPfQcQQBg0u0ZK6eZTrs/Tkm7D2atE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me1VNlfF; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me1VNlfF"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55517e74e3so149584a12.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 12:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759951538; x=1760556338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHwiCc3iGoccDMzLE1v8yIcAIp1cB3mAsagx5iqfFac=;
        b=Me1VNlfFl6tumiIlaGRi3jRYXs1C3S8ppc9cTH7xM3PNx58Ub8GoBt67JCz1W72DQx
         bKq8lnlro9MtggOYr6jm0mYXqiJHXF09mcMm97i8xP30sIdFxOMUhJdFYzlw3MjU8wMW
         9cN87cfCIVKT2O2kt0GO4FpS2Crtn0GasQ/dKVaUtHbDHl9fQN0uMGcxOkdkVXNSTRif
         ZaqoZeJmJuxe/mSSdjEDheg1sMcID5dMoEi6+7DYr9APgxXTwhmKF49OJipHqB0hY/fI
         B+bPR/8CIsBnggg29GlboPpKshCUpAgvjZvOTQsXSeEhwnRro95JeGTxuyisimRRhnRl
         sxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759951538; x=1760556338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHwiCc3iGoccDMzLE1v8yIcAIp1cB3mAsagx5iqfFac=;
        b=JGkNz3s/5sIBAz6actfs2kl6GG5rvCO61rsguTx5VtXJXJyu5YNxhTLaVJW5e9u84F
         5f+3eRXv3lkjfDCKPN1ix8I7PcyB30fzeURSjh5jrXDw6zlevLB16de/P9qm1I+oGy6V
         RWQNKFms578rbWxlFfJxkuoyaTbM4bW12G/7K6avnf3EgSEZVIWcVbIJ5JXhdld/s6fn
         x8HyT1/3ZY9psPx8hy+7rrYl1FdVpd+B4FUiivC6FzodY+bt1nedTkdL2+nXtS9A4z2p
         5pYoJHLpe015CEYo/cUnvTAkTzIOtVPuTJfJyNTJExdGWN2ZWYCowhwhl31kJYXL7gm6
         U1PA==
X-Gm-Message-State: AOJu0Yy73ohlrKuMGPBEPZPrSnrD+qbea48QB5yKgxQdDj+6UwRFwto8
	oXVrbo7ZvCQBVYjT41VISCKtS3JpwB7EGgjGQDn3wZVdoTCj0meStfpK86EOmQ==
X-Gm-Gg: ASbGncuTNtYWz0jruJ8bWB5qJhJ2MmpCevZrPH2fgb83nhvNSpNOILTLKWLlUCS5hGw
	VqCMQUC3UszudvipRm29cSW+WEPZoInzt2QFcUpdEBMyrpw/J5BVA+STQNdpv3+VHz7Rv/+l9YI
	AXu0RrkX9PSnDq6lhuqIUL3L7k2/OIfWNdFUBqzwOv7Bf31vgJvKikVUGTd8G9YAEPIhDuHVzn5
	p7ZJxX7rOrREnmIg1PvWuCG4OjOj47/yTBkI8tbUzrlQL+Brt8nF3oviKvjw19vw6ZRS7JOZyBt
	yautcHoLBZuv1ygbNEqGs1iC/8F+mZVo4ZZb9rNK8dzDa9rMQFF28F+TXCKa9qO33K4He/bF4MV
	GQjNktHeR2nN+ksJV56QuGJg/Nmyyt8IBorFHxitD9f0KiCU5ZBA=
X-Google-Smtp-Source: AGHT+IEPXUP96jztMMNbTUowTWHu4Q8KtSVb5H9v4qxIiZ0gDHXOl7+xpRsOxt/dX3YEixmAod/JHQ==
X-Received: by 2002:a17:903:1b64:b0:262:9ac8:610f with SMTP id d9443c01a7336-29027374b16mr55504885ad.22.1759951537664;
        Wed, 08 Oct 2025 12:25:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e44ef9sm5089875ad.52.2025.10.08.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:25:37 -0700 (PDT)
Message-Id: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Oct 2025 19:25:32 +0000
Subject: [PATCH v2 0/4] doc: git-pull: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Julia Evans <julia@jvns.ca>

I got feedback from 15 Git users on the current git pull man page, using
this tool: https://text-feedback.wizardzines.com/git-pull.

My goals here are to be clear about the relationship between git pull and
fetch/merge/rebase etc, make sure users know the current default for git
pull (--ff-only) since some folks still remember the old default, and to
help users quickly figure out what command they need to run to
merge/rebase/squash/etc.

I've taken a pretty aggressive approach because I think it's possible to
have a pretty short and focused DESCRIPTION section here while keeping the
most important info. Open to hearing that I've removed too much.

This references the UPSTREAM BRANCHES section from
https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com/
, so if that isn't merged I'll need to revisit the approach here.

changes in v2:

 * Add "(excluding merge options)" to clarify which options are passed to
   git fetch (from Chris's review)
 * Say that git pull will by default merge the upstream branch. (from
   Chris's review)
 * Add some links to the UPSTREAM BRANCHES section, and to the <refspec>
   section in git fetch, to make it easier to navigate in the HTML version
   of the docs at least. The situation where we repeat the <repository> part
   in git fetch is weird but I don't have a better idea for how to handle it
   right now. The UPSTREAM BRANCHES links are currently failing the
   documentation tests, but should pass once the patch series that adds that
   is merged. (from Ben's review)

Julia Evans (4):
  doc: git-pull: move <repository> and <refspec> params
  doc: git-pull: clarify options for integrating remote branch
  doc: git-pull: delete the example
  doc: git-pull: clarify how to exit a conflicted merge

 Documentation/git-pull.adoc         | 92 ++++++++++++-----------------
 Documentation/pull-fetch-param.adoc |  1 +
 2 files changed, 40 insertions(+), 53 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1976%2Fjvns%2Fclarify-pull-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1976/jvns/clarify-pull-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1976

Range-diff vs v1:

 1:  f69d2e6fab ! 1:  4cc87ec354 doc: git-pull: move <repository> and <refspec> params
     @@ Documentation/git-pull.adoc: pulling or stash them away with linkgit:git-stash[1
      +	of a remote (see the section <<REMOTES,REMOTES>> below).
      ++
      +Defaults to the configured upstream for the current branch, or `origin`.
     -+See UPSTREAM BRANCHES below for more on how to configure upstreams.
     ++See <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> below for more on how to
     ++configure upstreams.
      +
      +<refspec>::
      +	Which branch or other reference(s) to fetch and integrate into the
     @@ Documentation/git-pull.adoc: pulling or stash them away with linkgit:git-stash[1
      +	Defaults to the configured upstream for the current branch.
      ++
      +This can be a branch, tag, or other collection of reference(s).
     -+See <refspec> below under "Options related to fetching" for the full syntax,
     -+and DEFAULT BEHAVIOUR below for how `git pull` uses this argument to
     -+determine which remote branch to integrate.
     ++See <<fetch-refspec,<refspec>>> below under "Options related to fetching"
     ++for the full syntax, and <<DEFAULT-BEHAVIOUR,DEFAULT BEHAVIOUR>> below
     ++for how `git pull` uses this argument to determine which remote branch
     ++to integrate.
      +
       -q::
       --quiet::
       	This is passed to both underlying git-fetch to squelch reporting of
     +@@ Documentation/git-pull.adoc: include::urls-remotes.adoc[]
     + 
     + include::merge-strategies.adoc[]
     + 
     ++[[DEFAULT-BEHAVIOUR]]
     + DEFAULT BEHAVIOUR
     + -----------------
     + 
     +
     + ## Documentation/pull-fetch-param.adoc ##
     +@@ Documentation/pull-fetch-param.adoc: ifndef::git-pull[]
     + 	(See linkgit:git-config[1]).
     + endif::git-pull[]
     + 
     ++[[fetch-refspec]]
     + <refspec>::
     + 	Specifies which refs to fetch and which local refs to update.
     + 	When no <refspec>s appear on the command line, the refs to fetch
 2:  ffbb9d7c6a ! 2:  122774d4cc doc: git-pull: clarify options for integrating remote branch
     @@ Documentation/git-pull.adoc: SYNOPSIS
      -branches.
      +Integrate changes from a remote repository into the current branch.
      +
     -+First, `git pull` runs `git fetch` with the same arguments to fetch
     -+remote branch(es). Then it integrates the remote branch into the current
     -+branch. There are 4 main options for integrating the remote branch:
     ++First, `git pull` runs `git fetch` with the same arguments
     ++(excluding merge options) to fetch remote branch(es).
     ++Then it decides which remote branch to integrate: if you run `git pull`
     ++with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
     ++for the current branch.
     ++Then it integrates that branch into the current branch.
     ++
     ++There are 4 main options for integrating the remote branch:
      +
      +1. `git pull --ff-only` will only do "fast-forward" updates: it
      +   fails if the remote branch has diverged. This is the default.
 3:  76dc2c19fb ! 3:  323e81f2fd doc: git-pull: delete the example
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-pull.adoc ##
     -@@ Documentation/git-pull.adoc: branch. There are 4 main options for integrating the remote branch:
     +@@ Documentation/git-pull.adoc: There are 4 main options for integrating the remote branch:
       You can also set the configuration options `pull.rebase`, `pull.squash`,
       or `pull.ff` with your preferred behaviour.
       
 4:  c7f09c2bd3 ! 4:  999dfba156 doc: git-pull: clarify how to exit a conflicted merge
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-pull.adoc ##
     -@@ Documentation/git-pull.adoc: branch. There are 4 main options for integrating the remote branch:
     +@@ Documentation/git-pull.adoc: There are 4 main options for integrating the remote branch:
       You can also set the configuration options `pull.rebase`, `pull.squash`,
       or `pull.ff` with your preferred behaviour.
       

-- 
gitgitgadget
