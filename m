Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664B18E1F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602668; cv=none; b=R3PSntyh19VF0JJr+DEXaTD13MCUY7yTkRIaV6vFnR+BD6zoI5kPw1eyRjEcBPujyTFFFXOLpO5kYPAfwPk1bZS9GtVneinxM5pMYzIEkD1SdUOwYH5bYHomdC1x9Yhr2MZfbhc1AxoWo73C+nLeIWlD8emTMxp2BTUFdCLtNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602668; c=relaxed/simple;
	bh=i1sh0H6rB1m7t36k0B7PpvZM4MWPNmG6F9H4aS0uny8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=URtvGhkyyG6T5St7MKwE5EU5rNzqFNUqBLSNIknceeNI1Jg2eFrNrHJYA67g9a3i6suP/aA454FToIlQl6tmyF3+xrQrQO84BjDxDc77lrscltFF95KopI75UIgMH+anMeexFFPc2JmiDpz2d484X6wC8aJdgPfsPIfKGQMEQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae4/q3GY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae4/q3GY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12448c4d404so1663301c88.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602664; x=1769207464; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtyxwnUd+s1dYAG3/MwYrwoeliMMGnk1zqFArH4RNos=;
        b=ae4/q3GYLwRkEimQZI8Uuvn/gte4JvYK3O6cj9oWEb8oVy4125wn1o7jrxFcNomgSh
         qQXL9KfwPUmA4ZiMwRLHpV+ECnkflQoBb9vnb+uFu8QGa4Tdqfnq3E8fnx17QDWu2F5T
         qgfkfPCSKsu8tI0Lp8TnoPM6EM2JAJW0Pss3TNHYN9N2roDQX1tTJch0MDNLCYBm5His
         T5G7pLvy+WHTbO/BRg3uBFKiYPqODNizNB2K0AJI4thzlFqfcKDvXErAYZ5Q5AV7sf1U
         k/ChhnXqhBcPX2u4W4+ur7bA5FrZtJCCdmhJoFyyFCjteFTsjuftgMcGCUVzZG6tg1R7
         2/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602664; x=1769207464;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZtyxwnUd+s1dYAG3/MwYrwoeliMMGnk1zqFArH4RNos=;
        b=dG+RQOOP88WyTxAB+/LIY/fbKYyTucjS4YVfFIJJln7cs9dvifRSump6uOomZVIeLW
         VxJkMMtarnCdEtDp8R19+Dxez1mkpU2DuH59gGKijgkaRDP1FxgJzwKZCZekPAD8mAAl
         cYqwH44c+S0L8zQrMIf6Aa01inzPRWhhFtF9ZHGSKkUHXQn3bOTN6vSZbIdFAlhzgl2c
         ZKZhmRdo31sUHAVGJKeMkR1fbm5ml5DJqnRw2r0huF4jclKY7/veAKiXgQmRoUZWoaxM
         ctIt7bYLHyVhbTxF4d56o0mkERXCJuD6q8JZGVpOEL73TqPG7yqQdN6kI7sWjKBFX1LM
         Wylg==
X-Gm-Message-State: AOJu0YxmN5na/q2uQgmad3SN1nGCQ2cAeYqRf1ROv2LsUd1TDGD1KtC7
	cRXIHcvHkGS4iBSDZQi+FnM/LvTsyL7qmm1heij5bWMCyqyjpPD/savgUgw6aw==
X-Gm-Gg: AY/fxX5JJ4hqaD9zZB242H6fLoJoyHU544U1djn/TMvmKV23mL80+2Bgs6p3n524Qbr
	5Q1YO/qWTO5sVzJec+kql9vqGEGn01syxHyUrDsylGnEZrCa5FAEgvpWaBDiXhlVtVevb7FcfU6
	1W6VYKHWNro5bJ0TJrB6Z6d7x7ZcfTWnx0W1JeBGhmSzzJw9DhMHd7OODMVus+cwVNoMoJMM/zI
	BNoUQ9AHs+JWPPzg44Fj8PdrgXyKPuAstPlCqNxuvK9Hf8zt9UjnnC4RDdzGHkDKtSsVo8H2bm9
	27mvwE8JenjN+Q5MsbkZ49VyNuAzVXYd45B3QfPxHsmXoDiHq6znEBllazDO9bAgqFQa6vWJACR
	NPOvqGU0w/FONq7ybLjH55UUT0RRpNVLuw2NZA7sYYFfwucXOKOIW945HHnrlOmA4Ajg2TgA+Vn
	Lj8TKTsdSTXZfT
X-Received: by 2002:a05:7300:5410:b0:2b0:4c33:8e4e with SMTP id 5a478bee46e88-2b6b40b33f9mr2873731eec.23.1768602664528;
        Fri, 16 Jan 2026 14:31:04 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a94sm3687886eec.20.2026.01.16.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:31:02 -0800 (PST)
Message-Id: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
References: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:30:59 +0000
Subject: [PATCH v4 0/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a merged
branch, we may endup with some shallows, that are behind the reachable ones.
Added test 'fetching deepen beyond merged branch' exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven fetches
result in all the correct shallows. That led to this proposal, which unifies
absolute and relative deepening in a way that the same get_shallow_commits()
call is used in both cases. The difference is only that depth is adapted for
relative deepening by measuring equivalent depth of current local shallow
commits in the current remote repo. Thus a new function get_shallows_depth()
has been added and the function get_reachable_list() became redundant /
removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of each
existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative deepening
anyway. That way we can allways summ 'data->deepen_relative' and 'depth'
values, because 'data->deepen_relative' is always 0 in absolute deepening.

Samo Pogačnik (2):
  shallow: free local object_array allocations
  shallow: handling fetch relative-deepen

 shallow.c             | 45 +++++++++++++++++--------
 shallow.h             |  1 +
 t/t5500-fetch-pack.sh | 23 +++++++++++++
 upload-pack.c         | 76 +++++--------------------------------------
 4 files changed, 64 insertions(+), 81 deletions(-)


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2121%2Fspog%2Ffix-fetch-deepen-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2121/spog/fix-fetch-deepen-v4
Pull-Request: https://github.com/git/git/pull/2121

Range-diff vs v3:

 1:  f8a8d077cd = 1:  f8a8d077cd shallow: free local object_array allocations
 2:  e79ab6b740 ! 2:  e9b20ae06f shallow: handling fetch relative-deepen
     @@ Commit message
          get_shallow_commits() function, but it focuses on counting depth of
          each existing shallow commit. The minimum result is stored as
          'data->deepen_relative', which is set not to be zero for relative
     -    deepening anyway. That way we can allways summ 'data->deepen_relative'
     +    deepening anyway. That way we can always sum 'data->deepen_relative'
          and 'depth' values, because 'data->deepen_relative' is always 0 in
          absolute deepening.
     +    To avoid duplicating logic between get_shallows_depth() and
     +    get_shallow_commits(), get_shallow_commits() was modified so that
     +    it is used by get_shallows_depth().
      
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      

-- 
gitgitgadget
