Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4E2918EF
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396144; cv=none; b=Uwc8/rPwEWTK/FTshP5SA9KmyRUi2VdJy08LuMALR/FLDdCrs0+g1xVTQj5D/SSWzKWaZq+G/DFwaMNnC44LFmd04+6dQsBrsocEde3Gyw8jq5EPJYAqtLNHR5hbBctYiFcW8r6l0d2vIC/uEgfth43qcnXLXZR9C4NH3+C+omU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396144; c=relaxed/simple;
	bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkE6TtxFwlCo4sargRyFbAK/A/kWbX4FY3yw61LAljRDPqEiA/DOW1utkS75vz6FD+HqHJ8/LVhi3YvOGzdwB1WqzW5SgR8XCa7cj3tLBi9FkzGLKpFwosQlVCuo2g7d9o+zD7LSKpayUkZn/3H5BNZF766hIysFzdvpbqwevY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjy8eUMx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjy8eUMx"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb39c45b4eso894321166b.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745396140; x=1746000940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=bjy8eUMxHNqPV4eRLR1kapmg7SPZy70tuj2cndoHkfegiodhoPZhbMECf1EXzufPwE
         0NGfNvcp/QMRvrsyT6aahfCmW4tzik9GrmunPdTnhhjv/2t2gMCq90XuHA5RCsemn3uf
         TYHJtLp2DGw8crCab7c9TzVb5+z6fCrC7gUH+hR6EwK0utIC36fkg876zQJM59LFhPI5
         tODsuMK5iKENDbJM3oJbN26LQa+qeq/njTDtidCTAQD01gI/4B8UzC+mdo7JiOGrNA/+
         un3/mXaI1MvKYrBNQn5tagutCqkglBdBEwk6awTtEAyzhRhy3yCREDmNGMPTxxlNAL7R
         FKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396140; x=1746000940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=F0lusIZVyugOOD5WQA8a9h/3CPFO5lsdnH3y+vaGwy4RVHD+woFKu7SuNY7aNgh61g
         5kT7ecPQGlVHq1VcLtzDKr/+z+2L/Udvhn7+55jCSgUH09zUA6WPZ2GZQyIfNQpVfRHf
         06GWxSZPiiajRVq9bOqET46fE6jzsUGAfhWgkHwJ/6w6tzBTTwZoVWYt9k6NU+Z36/4t
         nQ8OwbOKyMtKO0fsn+04M/No5dUQAwcYptSN8H1B1+7RNevJz6DIWUxJ7w7PwqC4iQAj
         OxSImUbcg5T9rxDV8Fw5pP86H1SkdeckSDVlIvfa0ghbF2Nk8dhZ57osJ3tBZQ8xKpqB
         aD3A==
X-Gm-Message-State: AOJu0Yzy5sgbItCymoP/GIUm9KNOaA+9nllD0kJESe64VRr4+oEXcuIx
	6PBmDHzyBADASh7bTtE1A3zmtfl+WLWcPeZoF4puBCDPuhDS22CJMVMOHw==
X-Gm-Gg: ASbGncsWyKl5to8WLvMWTYF7Z/5XiD5Cl2zF98lYOZzbQW/B1uVUUBLtpLHZ5d90BCC
	+IK/2PGki9JTQFaPqjHv3C/YMUDL9UnvZAnlnYMlXmibjeWHzXuu8jQ3/9IOe5BdVo7dfD/FHZl
	4+NNYxtOwp5BWRqX6IfQN9o6qudllrnj4da6YVCQrDqtY1t1dqCqwLaSkY9LKiJgv6708zPjxkc
	ndoNu8m3cvDiT8RP5RnMPvF15VXifLaAxHaMOKo5zKZQ4x9cStdjBj8L/TxtHOy5HaW/iHrFAS6
	sW3Wo8yIthia+PH3/Sxl+j+1+5186TEg/Zit8PMxiICeTsE=
X-Google-Smtp-Source: AGHT+IEF5fcfl6IxEK5BSRI/TUNNbSjKZVzU7R1Y87yN4pN0S51lgVq+6MugBNp+fVio6fNlhewdgQ==
X-Received: by 2002:a17:906:6a13:b0:ac7:9835:995 with SMTP id a640c23a62f3a-acb74ada8abmr1380303866b.5.1745396139854;
        Wed, 23 Apr 2025 01:15:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8764:66c7:f630:d3a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm766577266b.27.2025.04.23.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:15:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 23 Apr 2025 10:15:35 +0200
Subject: [PATCH v5 2/6] coccinelle: meson: rename variables to be more
 specific
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-505-wire-up-sparse-via-meson-v5-2-d1e2be4b2078@gmail.com>
References: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
In-Reply-To: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgIoaiXcAgVsJRPHiayVfbuEn8myAqdSK7kP
 ScWP45Vahe/f4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoCKGoAAoJED7VnySO
 Rox/pwwL/iYns3i4i3o1jXBqRPPLO5F0WfXWwUC+J3O7NA4WgD4bMsNLoKHNoVvDG6JjT7Y26oR
 I9FXFeOyFhu7W5fEhnBOLzCo3Tc3l4Scu9CfJRJ7S5r200RMTfkllJY+E4ceV1W3lNyhsbnalKy
 M7h7mqNRtJHTq7SZgLqoOphWYe0C8Md77G+zS3x4Zs78nuT2DGW4RrvPKce53mJ6AM5FSCLG4t7
 ep0TL2TMZdAsVhdpZ58YJWk5T2kh8IQbZDpdb1jdB+a/UvWE93WgMq6GwhrNHKrIOHFwOC3JTzy
 eWP6cP1flUDv1jZAV1q/Y/KZvop6qoGNyqWbpDFJOXlW9UDCiIk61w1PYD/ijfCEdZMK5uoJDua
 FH7lNA56YyB4cJC4Edw0twSI0nJYYUVMZ0bL1Lu/rVp2WJwtleEUwBrRtg7d+1fbVlyFsjTe9XB
 HV8ebR/bb4FD+K84jaL9qa3asDn2UelX/3SsHGEMpfudGvJlCUdWtgETsQTgMlmwLwspgUGI/l5
 xk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Meson, included subdirs export their variables to top level Meson
builds. In 'contrib/coccinelle/meson.build', we define two such
variables `sources` and `headers`. While these variables are specific to
the checks in the 'contrib/coccinelle/' directory, they also pollute the
top level 'meson.build'.

Rename them to be more specific, this ensures that they aren't
mistakenly used in the upper levels and avoid variable name collisions.

While here, change the empty list denotation to be consistent with other
places.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index ea054c924f..03ce52d752 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -55,18 +55,18 @@ concatenated_rules = custom_target(
   capture: true,
 )
 
-sources = [ ]
+coccinelle_sources = []
 foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
-  sources += source
+  coccinelle_sources += source
 endforeach
 
-headers = [ ]
+coccinelle_headers = []
 foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
-  headers += meson.project_source_root() / header
+  coccinelle_headers += meson.project_source_root() / header
 endforeach
 
 patches = [ ]
-foreach source : sources
+foreach source : coccinelle_sources
   patches += custom_target(
     command: [
       spatch,
@@ -78,7 +78,7 @@ foreach source : sources
     input: meson.project_source_root() / source,
     output: source.underscorify() + '.patch',
     capture: true,
-    depend_files: headers,
+    depend_files: coccinelle_headers,
   )
 endforeach
 

-- 
2.48.1

