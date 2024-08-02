Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B44CE05
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632293; cv=none; b=qjGcq+/bJmJCLSvGo0kODm5X++3hiwzEagclopi7jpDXuWIcc6dp9vNmKrjkyjLYZNL2CCTXqiYoLQnecDuAn03OdSNYr0HSb5X3AFBfm+NTCjzhJ3EZdErKL02Qds2O4LNggrcy0hwdV8H7jU+AbGONG3J8d/X27WeO0dSmtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632293; c=relaxed/simple;
	bh=xvGOhozipAw8HLqyM/Mzub/A9gtjCJdT/a+DBazOxwY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aHd3Nu+8CcPdwhesREWY/JchrxB34WUE98373mCOmzZtVgZrHdcTHP8qpmuzHB3S1Xd99jJAMNHOSJnNlnW0OmT+x9zzHSqLAahbTgxQtGvm+6Z30q+V7vI9iLz1tihCmjwEkDeQuUBf6jmMPG9FfHXFLhkEq49ol2KX2aCkdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQCq87BW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQCq87BW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42803bbf842so76450845e9.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2024 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722632289; x=1723237089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I20ziSAJ7Q6Rb69mUzQN6s+GHd0go8g3/Sh7SJVa+2c=;
        b=NQCq87BWL3IPQCk5apVHUesmBykwlOsXdZ7uk2QVVdOCrY+QF9OlhbMxzd+Y36l2Z7
         1yDnkap3im2/7riaZTwxa8KTb/AubdTxpN9fdE3U//Wh5Bz7SfyVMROa+C1iBHoOOp6W
         4LS/GgszQL2vi2u7juGA1fZ+hDJfeYCdGyLhlix0VYlwW9N9mn9S9v79WwLTE4fZzCcA
         JVNESAZlIvW+45v44/hsHIpeRlpet5TWSSEY1GSFpTWDIs83csLqhbbkGvZnU+n7Yc6a
         VkD+h/G12J3nLa/dJPI2amSdC0lp48VGkUjGgi70H4JS/ycDk/PrxX3PqL5jlCPtP1F0
         Xkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722632289; x=1723237089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I20ziSAJ7Q6Rb69mUzQN6s+GHd0go8g3/Sh7SJVa+2c=;
        b=c1qC2c+rsNhde+1+iGALa2WfCoKYD+XSyiCqybweyUJRLKH12zwBxLuS6aPjG76Fzh
         pBw8SzCRjj3voQEdjhCUE8CPtDJamKwNYQ8hDsI0WkWBKDRmY12wYYEWqpqMXzXk2HMO
         y9LWsTYNmtiHmHKv3Y/mZ6DpublTs3jk5Lp7mqeaWwdEaUqTOC4wf6L6/mmoX5oFHBJU
         675q9mQOGhzj6xTiIOQkvvf9TpvK0mhrCOr/oYH9mEdXUk/Eo8lKpumOUvFwzzLp1rA0
         ZMef2MQp93V//cCcRRKaWaD/od3CBPArv7G38Eu5/x+A4vP9rFbpZUlP8NbBmvXUzDR4
         VzBQ==
X-Gm-Message-State: AOJu0YyoD83SKdcXDoVBNx60FHq+9PVDwL79lYBaqTmq+U8PCODd0kl4
	RFdF4hSsVzI0n+5rkb3a5QULxaoLrHOE7PuEdo8Pd4/wAfAxVVfvl1e36Q==
X-Google-Smtp-Source: AGHT+IGWOfZV9YQh+7m2nx21Co38NMfehahxIWLorzDEHj+VIA8877lb1ESVuASjepJbLn39RgcrYA==
X-Received: by 2002:a05:600c:4f55:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-428e6af268bmr44559785e9.8.1722632288868;
        Fri, 02 Aug 2024 13:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e7cbd2sm45009095e9.38.2024.08.02.13.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 13:58:08 -0700 (PDT)
Message-Id: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
References: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 20:58:04 +0000
Subject: [PATCH v2 0/3] Small fixes for issues detected during internal CI runs
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
    Kyle Lippincott <spectral@google.com>

I'm attempting to get the git test suite running automatically during our
weekly import. I have this mostly working, including with Address Sanitizer
and Memory Sanitizer, but ran into a few issues:

 * several tests were failing due to strbuf_getcwd not clearing errno on
   success after it internally looped due to the path being >128 bytes. This
   is resolved in depth; though either one of the commits alone would
   resolve our issues:
   * modify locations that call strtoX and check for ERANGE to set errno =
     0; prior to calling the conversion function. This is the typical way
     that these functions are invoked, and may indicate that we want
     compatibility helpers in git-compat-util.h to ensure that this happens
     correctly (and add these functions to the banned list).
   * have strbuf_getcwd set errno = 0; prior to a successful exit. This
     isn't very common for most functions in the codebase, but some other
     examples of this were found.
 * t6421-merge-partial-clone.sh had >10% flakiness. This is due to our build
   system using paths that contain a 64-hex-char hash, which had a 12.5%
   chance of containing the substring d0.

Kyle Lippincott (3):
  set errno=0 before strtoX calls
  strbuf: set errno to 0 after strbuf_getcwd
  t6421: fix test to work when repo dir contains d0

 builtin/get-tar-commit-id.c    |  1 +
 ref-filter.c                   |  1 +
 strbuf.c                       |  1 +
 t/helper/test-json-writer.c    |  2 ++
 t/helper/test-trace2.c         |  1 +
 t/t6421-merge-partial-clone.sh | 15 +++++++++------
 6 files changed, 15 insertions(+), 6 deletions(-)


base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1756%2Fspectral54%2Fstrbuf_getcwd-clear-errno-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1756/spectral54/strbuf_getcwd-clear-errno-v2
Pull-Request: https://github.com/git/git/pull/1756

Range-diff vs v1:

 1:  4dbd0bec40a = 1:  4dbd0bec40a set errno=0 before strtoX calls
 2:  0ed09e9abb8 = 2:  0ed09e9abb8 strbuf: set errno to 0 after strbuf_getcwd
 3:  6c08b8ceb2b ! 3:  818dc9e6b3e t6421: fix test to work when repo dir contains d0
     @@ Commit message
      
       ## t/t6421-merge-partial-clone.sh ##
      @@ t/t6421-merge-partial-clone.sh: test_expect_merge_algorithm failure success 'Objects downloaded for single relev
     + 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
       		test_cmp expect actual &&
       
     - 		# Check the number of fetch commands exec-ed
     +-		# Check the number of fetch commands exec-ed
      -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
     ++		# Check the number of fetch commands exec-ed by filtering trace to
     ++		# child_start events by the top-level program (2nd field == d0)
      +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
       		test_line_count = 2 fetches &&
       
       		git rev-list --objects --all --missing=print |
      @@ t/t6421-merge-partial-clone.sh: test_expect_merge_algorithm failure success 'Objects downloaded when a directory
     + 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
       		test_cmp expect actual &&
       
     - 		# Check the number of fetch commands exec-ed
     +-		# Check the number of fetch commands exec-ed
      -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
     ++		# Check the number of fetch commands exec-ed by filtering trace to
     ++		# child_start events by the top-level program (2nd field == d0)
      +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
       		test_line_count = 1 fetches &&
       
       		git rev-list --objects --all --missing=print |
      @@ t/t6421-merge-partial-clone.sh: test_expect_merge_algorithm failure success 'Objects downloaded with lots of ren
     + 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
       		test_cmp expect actual &&
       
     - 		# Check the number of fetch commands exec-ed
     +-		# Check the number of fetch commands exec-ed
      -		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
     ++		# Check the number of fetch commands exec-ed by filtering trace to
     ++		# child_start events by the top-level program (2nd field == d0)
      +		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
       		test_line_count = 4 fetches &&
       

-- 
gitgitgadget
