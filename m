Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC53570AF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629701; cv=none; b=I6k/Rc1VnpsHNA4cFoPfwaF4t88Kg/quD6PqkFK2jVYNSpjmeXflAy21AYxtxeRP7MOMyzg5lB9w6C8I4CWaj4zBlXEX1Sc5so01PcBzz8x17y4SZhttFJheWlGv/XoT46NMx+BKq1e44ZW26RztVYZjf7vNSf0vaCfXnl7se+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629701; c=relaxed/simple;
	bh=VtUxZhDlVWTG1NmrQO/rIjX3GsX9igVu+UB+Ow+SRq8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jRjcLIUNRaKf2m6HBB57cOOp7I5FX+4ABDexIF6OSBNmmUx6heLi1WBJHMS3myw9FOwzdnn+BF0m3vDq8tJ6FX2ZMjA7RVK9H2w3iA0dLx+TgPsVZbvwjLuzUb0oFkB76nG/+vivOzMx4qy5PxM8UCotl4OT0+B0G1/ohnGgS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyLH/A+J; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyLH/A+J"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87a092251eeso40503886d6.0
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629698; x=1761234498; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm5vTnJBclrOotlqGoNLll0QF/O/mEIoNa3y8iDKXGY=;
        b=lyLH/A+Jm8cV0TQbgnqFaWvWh0fquCned2+vWqWvcEbJz+x8Jd65B+wyETB79v2MZ6
         EiYwqRAoegXMz4jYCEU2RsZTcJFHC0sLGnvzZ1h8KiWmJlXbhDJnaEYD/+3l5O6LhiN0
         r9fNIkmCLB9OjgIhTQWDrCpuVGOJDQh/4tkHRyWx4PHPfoQhyR5jLrqNV5M/4Oq6wrDg
         OaBukw0dUdk4m0t86riHpyEYfe1rPLOLR8x6fOVED6+3USWKpwkRC3BkRZC6Hour4Ex1
         1f/xYBuM+ZlBvvJjg/txFBHbcObeBEoNONj6q/sr18i38YeYZqWdHmp24c4pyktuj4+A
         LsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629698; x=1761234498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm5vTnJBclrOotlqGoNLll0QF/O/mEIoNa3y8iDKXGY=;
        b=o5WeKE9pSd5I86o1kKhWV5iK5ldlHYkXUi23UYCHYci8REpcVLcub4OvdutVbhrdPN
         i6Wa/dHaaBM2LIipOPTSgn55TuGdxurAC5ezipW9HxkzLPRvUYUPhK+pNakW4+1AdbSU
         1qUV+g+W9w3NFdPQXVvRXk4/3EKdYCRhS90EjFP8qtujXAdmIxG6Vwqlza4O9qtilKpy
         h+/BcW/Ljpf/5y/9q+h/FhtQFK3AX4XsXItpoW8EUEPq57gHLAFo1U4xfcgGoMK3Co3c
         eh+u5PnK4R51xH1O0tp4qhm/FoPPQLTAKTMC+fhWnyM15rUHFIz10LHLTZKUy36CaEC9
         h6FQ==
X-Gm-Message-State: AOJu0YzYZZZHW2kRvk37RbdIokPKFq30ihUK30lOiG2gYRXzrlatWcwy
	OXKzYmSBOAyUqa59rbk72Zg+Or3+l0JkeoSsMTWh/eL8ZvNSFRz03JfnBr4CZw==
X-Gm-Gg: ASbGncuS1xNvaq/JPRVolUCFPMp4m2SI4GkUggLuCck4aZUSYBX7f14iO3AAXgaNugW
	Hn0VmlMLL0/esfNSwiE3kUqOWx+HZLkVe8ju/x3E/qPx5Rmmisn1n/Oa0AYVj+/KEjp5LQyXGux
	o4rK4ySKzbpt3xgb7KEuQeWgGyqbTKRgqbUPsTXW6CjK0BLuK1n3nPmSQgAVYz/CzLNxUOL1f8k
	fyJ3/zk8IeoXOUaodgW6rjQLknfdHvbVGzfWsQB04YhFhrRwCNAiv8PFQWam1EiXiTTCsawftM+
	p9nh+na4i7uXJYq7d0XX2ZY+Y7flfQep1OL9VDE/TyCFl8c4PIbND5qlAH1IQaw1e0oDDq8+S77
	Z+VF2ozue0wiqueR99D3YFF3R5hOC04CZPAyg7SFWTBON6z8PLGGncjzbrJfPP/Gymc8/i5GDMF
	boURM8XC/iQ46M
X-Google-Smtp-Source: AGHT+IFmzrnK77hjn98BDImEvjD4b9QrJ+gJHWvHGEQlpQcPvyEkyNC1TqFdoIj+7dTAXhN4xHFG7A==
X-Received: by 2002:a05:622a:e:b0:4b7:aa1a:eb1b with SMTP id d75a77b69052e-4e890db0cd9mr65362941cf.2.1760629698110;
        Thu, 16 Oct 2025 08:48:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e885f1bf3dsm38251101cf.24.2025.10.16.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:48:17 -0700 (PDT)
Message-Id: <76cac127d936b27e1679b292f12fd79e18dd7fbb.1760629692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
References: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 15:48:12 +0000
Subject: [PATCH 4/4] build(deps): bump actions/github-script from 7 to 8
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Bumps [actions/github-script](https://github.com/actions/github-script)
from 7 to 8.
- [Release notes](https://github.com/actions/github-script/releases)
- [Commits](https://github.com/actions/github-script/compare/v7...v8)

---
updated-dependencies:
- dependency-name: actions/github-script
  dependency-version: '8'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 4cdb1dcb5c..3622fec742 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,7 +63,7 @@ jobs:
           echo "skip_concurrent=$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v7
+        uses: actions/github-script@v8
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
-- 
gitgitgadget
