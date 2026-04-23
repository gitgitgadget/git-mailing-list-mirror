Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15B37CD2E
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963338; cv=none; b=gpbgFy7jcKkAashR/8f2z5M/kWwPNN214N0kBLq80HcofeRl6hH4eSptzongYVD6P2PZgjcfjyD4WtHzzAjlmsJDObs122PGAqJTBNQ1TXhj3UHzzYHDF9d3OcKIBgwt8569b1/pGvFluxC6X/XjTXj8zRjrkVlMnMoLX0P4/HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963338; c=relaxed/simple;
	bh=Ip/e/2PzG/LSmx0ls2hcWftMTStDog4p4BJyx72/n74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugEWbUFTtRu3YdyX4N8gNMoM9KmM9b3KrSayVrmHt4Cf/NaizkKewKzX09bhuyGELUkErgV3J39jTnYXLLkjAlEsmGPwTfkHyAWAs0rXn3pdz3iZjfq1H2SRzLTs1VL4h1rIJMmLaGULgZTp1dq8SmcifPxHu49OpDeoTy6w5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV839jU+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV839jU+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so61263915e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963335; x=1777568135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqlfPEgHy9vseFomLpH8d9Fdra0zHTVcHwONDF/YmBU=;
        b=eV839jU+mcolEjzPdmLpl0amKC5v+VMEhjSGuWVJeyPHGgMRHmwo3MJoO9pTKkBMRK
         R5/VKFgjOAzhzZy3osVI5t+nokraMSmojQqy7eaQLNT4s0aNcpimQ7Wo9L9sbsiMhtYh
         VJS832KzQ8nhK1EWllgagmXfOCVhk2PogxkCjOOcW0UFO6J2W+xp4XI3jrW3e+4eI5Y2
         sDlqEMCBZfpW9ym/7574C9GyyIbiEfzXGXuBJBBtm6SnXWPJGS8J22xpcFZERBLwFz0J
         dsFKiBeWqjjKTPAh2zPcM53oyi4ESGVIiWN2Kn/5wAM7TIqk9moiuWpblN4w9nQfwWGZ
         fMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963335; x=1777568135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqlfPEgHy9vseFomLpH8d9Fdra0zHTVcHwONDF/YmBU=;
        b=glpGWUzG6fvSFmM0smL6mYdXtUWnWUi3GN+EzlRqmUcKkzxUP0xFdpKUtAT1hwZlDt
         x9t4aa455enZRzBsmfpZWH4kdL+5OHyKJoq/xamq9McNNNCY4mI5ezrOgnIjhS+TWqfT
         dcsTfx6ILdz2KPGBHylmeMZxjqlWq2KJNeqhd8TMHbosVjkCtQ+QJxjk6k9Ja6H7mfrP
         mJhPW5w1CwPZcFibBGhDHPhHbXCejbknSVrXY0oManmgZCjS9xrqRcAacAiPLFSvm4Sv
         qI8sZvS3UfQyrdRsTGdnluw8eQcuAJkb+QqbzqJz8OzacsMreOYMH7MxZI4NYdJFBuVa
         YNwg==
X-Gm-Message-State: AOJu0YyHtwRirePN9p3FS6qYj7oaCE69SO6XOKHreNG+Ds8Qb4C1XB06
	At1elmNAq46wfCJag9qBOnL3TFuY0mG5DIiAEzNR3TW3/kAIZGBtI5SCVOqPy7df
X-Gm-Gg: AeBDiesKkYLvylX4+eforNP6TpmIGHmuyiqXojBq61Elq3DtL+CQ8eXo0Be9ROJz9F9
	zmbZfBQOMlktBirrt0DStyH2hrzJYBqwxkDq9VDh4BveQWovORgAoVlunFHhBtP/61XtLbGu3QC
	JJJkx4ej84Vt/nXr4JdfAwZC9L5M35Pd+GbhKR5bP7waPy6nTN65bJT1dyklqjepyLwlFxdpFaZ
	7DizcvHvxHrnuuJr8A2uEO5rkoEqBiWp+RM/1cagnyIdTuVw9K09XIUnucBZkFna5ThJqq6eyuL
	wiUetcM1O6rEpo+JFACZxeCeejBvAGVQFAkhhw6ndplC7oYb6YBRSegBX8t33q4gEDcqJCXjD9H
	taB1Fi7KVlcSk+0LpZjrHwqmVA6bI1RoSVn7YYd1Knqttvs3lZQXykYVJNdpepsvQFVnPWlT17l
	D5vjPxk4rzdx7zcsHwGgwB+DazRhusr0CyFpUrqpDVdx0dJCe9+64xCw+iVMq/NrZ261KO/Q==
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488fb785901mr442247365e9.22.1776963334421;
        Thu, 23 Apr 2026 09:55:34 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:33 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 0/8] environment: move core config globals into repo_config_values
Date: Thu, 23 Apr 2026 17:54:24 +0100
Message-ID: <20260423165432.143598-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series continues the effort to remove repository-dependent global
configuration state by moving several core.* configuration variables
into struct repo_config_values.

This ensures configuration values are tied to the repository from which
they were read, avoiding cross-repository state leakage in processes
handling multiple repositories, while preserving existing behavior.

All affected configuration values are eagerly parsed. Storing them in
repo_config_values preserves current semantics and avoids introducing
lazy parsing into runtime code paths.

This v3 addresses review feedback by explicitly clarifying the reason
these values belong in repo_config_values (eager parsing) and improving
commit message clarity.

Olamide Caleb Bello (8):
  environment: move "trust_ctime" into `struct repo_config_values`
  environment: move "check_stat" into `struct repo_config_values`
  environment: move `zlib_compression_level` into `struct
    repo_config_values`
  environment: move "pack_compression_level" into `struct
    repo_config_values`
  environment: move "precomposed_unicode" into `struct
    repo_config_values`
  env: move "core_sparse_checkout_cone" into `struct repo_config_values`
  env: move "sparse_expect_files_outside_of_patterns" into
    `repo_config_values`
  env: move "warn_on_object_refname_ambiguity" into `struct
    repo_config_values`

 builtin/cat-file.c        |  7 ++++---
 builtin/fast-import.c     |  8 +++++---
 builtin/index-pack.c      |  3 ++-
 builtin/mv.c              |  2 +-
 builtin/pack-objects.c    | 24 +++++++++++++----------
 builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
 compat/precompose_utf8.c  | 20 +++++++++++++-------
 diff.c                    |  3 ++-
 dir.c                     |  3 ++-
 entry.c                   |  3 ++-
 environment.c             | 40 +++++++++++++++++++++------------------
 environment.h             | 19 ++++++++++---------
 http-push.c               |  3 ++-
 object-file.c             |  6 ++++--
 object-name.c             |  3 ++-
 revision.c                |  7 ++++---
 sparse-index.c            |  4 ++--
 statinfo.c                | 12 +++++++-----
 submodule.c               |  7 ++++---
 upload-pack.c             |  3 ++-
 20 files changed, 126 insertions(+), 88 deletions(-)

-- 
2.53.0.155.g9f36b15afa

