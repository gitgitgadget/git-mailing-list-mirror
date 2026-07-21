Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD53C0A01
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624310; cv=none; b=NZEvjh7lecM8NZpGKDzV9P9hdSqb9o4P0bNntq+UUnQy45WcjcVMjJ2dSuLCCcwSDmvDBtkdmLLwbBLOLuboQWFq0WMA3VF24PNVuVIQS+n8t1eXjRiCouxGssC2T52/PJAQjj7wkBXu9E8eBDBiRirV9zMX9Gjo4wk4HC7Fs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624310; c=relaxed/simple;
	bh=Hgel0qG4wfToSebU2f7REjh4/k6/VVN00+eAB/x6pZk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZKy1Ri/HABdsJXq5U0GZACoFXH8nJNbIia4y9mXcTwEnvyewGkkvXgqz0IHLfEUKEbT5BczDHKi7hwiZvgS5zYeIExA+cT5D9enW12ofDjPBXjxIB/WMIydwkXl7ls2uxD2pWJGVCeTXlsNzYliHQm7Fa4+McvgvCvXnB0CFMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvIiDez2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvIiDez2"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2803374a12.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624308; x=1785229108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9eCVAFRUNqgDukaDrNwfy09hkUlHRwU72oeyoKTnSM=;
        b=AvIiDez2fVKoqB8Hp+Tmf98MfhcuBZkZAV1zv2tAIdUH458RaZpMt+pw4b3XnLmsLL
         S/8hZoBPb+C33D769mxRt26o5+XnFGCunYtHqQ4vw5V2bOFVAThk3CBCAkzTjpbEInpI
         8MKxaRzZmMz5TDKR9q9yFxGTVeYNd+43rRYsNyQXEZydtum6sSpeQjhJebj9E4z7HAi1
         iqBolarAQGADR4qseO9CtU5yjhF0ZH4MeIKgV1gHMA2sOiIbI+YCga/H6x3krlLY6YoS
         frS8UjZdLHD2cYaW5BeuwOV+2By/CP0kJiyDCcB1SVm6MEtYnNLR6XXKYwA+5BD7oRVi
         gH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624308; x=1785229108;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9eCVAFRUNqgDukaDrNwfy09hkUlHRwU72oeyoKTnSM=;
        b=GRdc2EOI+I+aT7z6dmu3s+NGT5kgzc0TC/zqq2W2IIdZ8hKJ6g43KggHmiYj50HqQU
         w8vjyflEAoxJgpJ0kKLkmfYyMljak5vilgjUPBH9OEHMPzJKclY6ASVM6uMoRw/CMxsV
         yP2m68zb0RLTXM6u8yK9tCQuLwwlhs8JTK1wgNoNfp7O1jHWUHyqc3uF+a23mGmtzkl9
         Q3XZz6n4d7bO2mgbe0oGCDZH1No83XGFDSfkPwOHx50I5u2RHuOMttBbLHg764nmj4QO
         YTH15nPT6vy8u3qdC2uaPTsAcEwH1XOWYdPZstsmKIZ4iuXIdWVtxeTU9FmrVXuU6G5T
         m0VA==
X-Gm-Message-State: AOJu0Yy1bBKyV9slqtz21qaGJb8q0MkpqZ59ppA0qe9sJul4oZwUE2GD
	fJ4H2+M3tEzIfnqN3MWTBLLlnLhDsU6zccot9KTNvjuqUM7lA3jzp0/VAoLEHQ==
X-Gm-Gg: AfdE7ckY9DmQeNUIhmMuscHM5a4FC2UhGyvHuu4jm/C7xv/8GzUJXLiuI8SqfTYSpeH
	3Yo+O9HiXc01n9kPd1wzGVSkoHjkxf6mAwzbKa6XRLjQYoimDby69OKeqf2kemKz+gYzHgyTxfe
	kPqW74SMUGbqjxB4mCxckzZ/B4ZB2UpKKDBED+avL0odfjo+Q74DY+W2UBlKVPAyd04lZ0Vipm6
	zCpGlsyh9vbqxCGeJbEx27+ZNnOnvdjJtP64H7k1ZqplpCCxrh6ajZUXm3t/Q009/hukMjjYOh3
	stN9Y2aYcUYm1HCgecUgywA9HOL616J5282hwvl5ElEduB9CQODcJfh28N+ScFtXDlhGdms/+W6
	qhqFAWQIiFNDxccBtV0WKYzRUd3KTwO/x5aujA/A5k8GpkV7ki1DgFGjNe6PJra/AmoTGIENwli
	gQ3xaS/fs=
X-Received: by 2002:a05:6a21:d8c:b0:3c3:9c95:c0f1 with SMTP id adf61e73a8af0-3c3ad8ecbe0mr20198355637.41.1784624308307;
        Tue, 21 Jul 2026 01:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.152.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de32f8sm5769290a12.25.2026.07.21.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:58:27 -0700 (PDT)
Message-Id: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 08:58:24 +0000
Subject: [PATCH v2 0/2] remote: renamed remote push tracking
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Keep git status showing the push branch after remotes are renamed by finding
the configured remote with the same URL.

Changes in v3:

 * Revamp commit messages to clarify motivation.

Changes in v2:

 * Clarify that URL push destinations already work and that this change only
   restores their tracking information.
 * Document URL values for branch.<name>.pushRemote and their @{push}
   behavior.

Harald Nordgren (2):
  remote: pass repository to push tracking helper
  remote: find tracking branches for URL push destinations

 Documentation/config/branch.adoc |   2 +
 Documentation/revisions.adoc     |   3 +
 remote.c                         |  36 +++++++++--
 remote.h                         |   2 +
 t/t5505-remote.sh                | 104 +++++++++++++++++++++++++++++++
 transport.c                      |   5 +-
 6 files changed, 146 insertions(+), 6 deletions(-)


base-commit: 48bbf81c29ca9a4479ec7850fe206518682cdb2f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2358%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/HaraldNordgren/remote-resolve-url-push-tracking-v2
Pull-Request: https://github.com/git/git/pull/2358

Range-diff vs v1:

 1:  fc70895732 ! 1:  b1ac49de87 remote: pass repository to push tracking helper
     @@ Metadata
       ## Commit message ##
          remote: pass repository to push tracking helper
      
     -    The push tracking helper currently only needs the push remote. However,
     -    resolving a URL-valued remote requires access to the repository's list
     -    of configured remotes.
     +    The next commit needs tracking_for_push_dest() to inspect the
     +    repository's configured remotes. Pass the repository through the
     +    existing callers and mark the new parameter as unused.
      
     -    Pass the repository through the existing callers and mark the parameter
     -    as unused for now. This prepares the helper for that lookup without
     -    changing its behavior.
     +    No change in behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 2:  ff645b2159 ! 2:  6e924a7fec remote: resolve URL-valued push tracking remotes
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    remote: resolve URL-valued push tracking remotes
     +    remote: find tracking branches for URL push destinations
      
     -    A branch may name its push destination with a URL instead of a
     -    configured remote. This is useful in fork workflows, where the original
     -    remote is renamed to "upstream", the fork is added as "origin", and an
     -    existing branch.<name>.pushRemote continues to contain the fork URL.
     +    Git already accepts a repository URL as branch.<name>.pushRemote and
     +    can push to it. When a configured remote has the same URL, however,
     +    "git status" cannot show that remote's push branch.
      
     -    Git can still push through the anonymous remote created for that URL.
     -    However, the anonymous remote has no fetch refspec. Git therefore cannot
     -    resolve @{push} to origin/<branch> or update that remote-tracking branch
     -    after a push. The push can succeed, or report that everything is up to
     -    date, while status continues to compare against a stale tracking ref or
     -    cannot show the push branch at all.
     +    This can happen in fork workflows when the original remote is renamed
     +    to "upstream", the fork is added as "origin", and an existing
     +    pushRemote value still contains the fork URL. The URL still points to
     +    the right repository, so pushing works. However, @{push} is unavailable
     +    because Git does not connect the URL to "origin". As a result,
     +    "git status" cannot show the push branch, and an up-to-date push can
     +    leave its local tracking information stale.
      
     -    A uniquely matching configured remote already provides the missing
     -    mapping. Use its fetch refspec when resolving the push tracking branch
     -    and when updating tracking refs after a push. This changes neither the
     -    push destination nor configuration. Keep the existing behavior when no
     -    remote matches or multiple remotes share the URL, since either case is
     -    ambiguous.
     +    When exactly one configured remote has the URL as one of its
     +    remote.<name>.url values, use its fetch refspec to find and refresh the
     +    push branch. Keep the URL as the push destination so the configured
     +    remote's push settings do not change existing behavior. Keep the
     +    current behavior when no remote matches or multiple remotes match.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     + ## Documentation/config/branch.adoc ##
     +@@ Documentation/config/branch.adoc: This option defaults to `never`.
     + 	repository), you would want to set `remote.pushDefault` to
     + 	specify the remote to push to for all branches, and use this
     + 	option to override it for a specific branch.
     ++	The value may be the name of a configured remote or a repository
     ++	URL. A URL is used directly as the push destination.
     + 
     + `branch.<name>.merge`::
     + 	Defines, together with `branch.<name>.remote`, the upstream branch
     +
       ## Documentation/revisions.adoc ##
      @@ Documentation/revisions.adoc: some output processing may assume ref names in UTF-8.
         `git push` were run while `branchname` was checked out (or the current
         `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
         the remote-tracking branch that corresponds to that branch at the remote.
     -+  If the push remote is specified as a URL, the fetch refspec of a uniquely
     -+  matching configured remote is used to find and update the remote-tracking
     -+  branch.
     ++  If the push destination is a URL and exactly one configured remote has the
     ++  same `remote.<name>.url`, '@\{push}' reports the remote-tracking branch for
     ++  that remote.
       +
       Here's an example to make it more clear:
       +

-- 
gitgitgadget
