Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6080604
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444789; cv=none; b=ZJYmBTMDHX/pOAJkgWTdF7268BQ9c3T9rKkzIPncmeeRxURxdFLS1d58pG+6zgw94DqDnB0HFPU8cpJn9rk4GZx55Z4g2mSPwryBaMHgkUgCpQEYlBmW3U27t0n1ENFSbcZGTjkWZ+NhqU0OQ83VhCCRL4Lccb1gjwJiiDV5JFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444789; c=relaxed/simple;
	bh=8QbosqFGGzSE+u9cDj4014cRfEs79aWAK5Ha+LzB35A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k7gyi7VBCbDhDyYEF//BEXLY4EONwoVQLDl0CTJDS0GFa5/kjh7B/ZIn7F+mKO089N3dcf4pfWs10jHtqKtGnneIWlKJXc4ieFrd8GW6W8x3xx2c4niCwKMpgH/Ek0BHu0+5srIiHtT6XqS+XIFAO0kaImg9tglhUzaKZT8X6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB09Ml/c; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB09Ml/c"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so1222137a12.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713444786; x=1714049586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVpjCCrQW+yK1HtZP5Ejve8quqWCou5xy4d7lWIPOTY=;
        b=AB09Ml/c91XyfsbFF1fSRKTUucGfcshK1lNTHsvRlagfX/2qtaq8TLkzb5gTQmtsLq
         JpZN9fl7RR0curFe/ouNX+1fTyeUwXWb4N0Xjd/P9TZejBhWmrErgTqbMul91j6EjNLM
         d6pakMkNKyQPmuVbqBk8WYH8wHpeAjQJywq5fcmEWI63HWWjuZNWPGXonNStS8KKXMee
         YvkxRJPi/OJEz/SpGG41WHSvcgGwT6kapvNOjt2dF7EeMNkKa2KwGkewqGug/nNLhQS7
         ZkpP3znxAsz5Q2dXQytAUy9FZjnZAydCE4C6FDPZqhBo6AmQ1XcRj2Jiv9AhqpMlQnqx
         3dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444786; x=1714049586;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVpjCCrQW+yK1HtZP5Ejve8quqWCou5xy4d7lWIPOTY=;
        b=k4VVbgLh1RkttG4uAAQ5wqsy8z1o/alvPVArjQ8cEHDdbLO0xrJDj32A7KPTReacSF
         Pfg2v0l3Og7XFaUp1+eA/WdHZ/gaQ/vvgbNTuhZnsNllH4efQYP6s2mRH4NJnWUC7alV
         CPc1oNTdKdGJ+J0UUQPE/krj5vmzs3ik74+ZjaBO6FCUY2btGnmg1Q4dE0SM7niyIiek
         c9+FWm3amz7tjTHcdqylBF1IHdJzahNcFG3vv6o4ccG3vGoq62pz1HZEZ0ymRsR0IMu2
         aTLk3G+FlqO4CnPFUT+MB0eH70PTfumhEBOsXnGOX+GQXDZTahuRJyp0vY6AOOfv98JL
         1GvQ==
X-Gm-Message-State: AOJu0Yw0u1WTAGSazjyuAO3WlRFGKijtvvPhSWHl0JTsjYFd20zYRzyq
	Mnn/KHszguzqvPzvvvxsN/imU+QY0X3FvpGBmdbi8TARHuF7C6jRlAb2Bg==
X-Google-Smtp-Source: AGHT+IEHu91BEgRTnxAC3fPfHECVozMRUfxbm4KqmLcoF8axanoJgeggzfXIg/WjNOVTuwiM/aRwyw==
X-Received: by 2002:a50:f68e:0:b0:570:377:850a with SMTP id d14-20020a50f68e000000b005700377850amr2225675edn.32.1713444785427;
        Thu, 18 Apr 2024 05:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3-20020aa7c303000000b005702fc1f92asm835853edq.53.2024.04.18.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:53:04 -0700 (PDT)
Message-Id: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 12:53:01 +0000
Subject: [PATCH v2 0/2] Use a "best effort" strategy in scheduled maintenance
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Over in https://github.com/microsoft/git/issues/623, it was pointed out that
scheduled maintenance will error out when it encounters a missing
repository. The scheduled maintenance should exit with an error, all right,
but what about the remaining repositories for which maintenance was
scheduled, and that may not be missing?

This patch series addresses this by introducing a new for-each-repo option
and then using it in the command that is run via scheduled maintenance.

Changes since v1 (thanks Eric!):

 * Changed the option's documentation to reflect the current state (instead
   of the original design)
 * Fixed grammar issues

Johannes Schindelin (2):
  for-each-repo: optionally keep going on an error
  maintenance: running maintenance should not stop on errors

 Documentation/git-for-each-repo.txt |  4 ++++
 builtin/for-each-repo.c             |  8 ++++++--
 builtin/gc.c                        |  7 ++++---
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 t/t7900-maintenance.sh              |  6 +++---
 5 files changed, 33 insertions(+), 8 deletions(-)


base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1719%2Fdscho%2Ffor-each-repo-stop-on-error-2.44-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1719/dscho/for-each-repo-stop-on-error-2.44-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1719

Range-diff vs v1:

 1:  6721e3ada5d ! 1:  abd796894c8 for-each-repo: optionally keep going on an error
     @@ Commit message
      
          This is undesirable, and points out a gap in the design of `git
          for-each-repo`: We need a mode where that command does not stop on an
     -    error, but continues to try the running the specified command with the
     -    other repositories.
     +    error, but continues to try running the specified command with the other
     +    repositories.
      
          Imitating the `--keep-going` option of GNU make, this commit teaches
          `for-each-repo` the same trick: to continue with the operation on all
          the remaining repositories in case there was a problem with one
          repository, still setting the exit code to indicate an error occurred.
      
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/git-for-each-repo.txt ##
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
       		OPT_STRING(0, "config", &config_key, N_("config"),
       			   N_("config key storing a list of repository paths")),
      +		OPT_BOOL(0, "keep-going", &keep_going,
     -+			 N_("stop at the first repository where the operation failed")),
     ++			 N_("keep going even if command fails in a repository")),
       		OPT_END()
       	};
       
 2:  a86bcf2e1a0 = 2:  1ae11553052 maintenance: running maintenance should not stop on errors

-- 
gitgitgadget
