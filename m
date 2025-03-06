Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81038DFC
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240690; cv=none; b=qdW9kHOxNSRBPOuAO2sdzJ8g1OyFScOdnNwMbLgQnHMrocS2PmSy2h+XmhecVOsWyoRzTXZQTbRQOsxejBh2/UFKjrCgboS8IrcMJqSVQ0K+0ntKRf1xtJCe/Ktm+mrnZGxVZeBllI9uX4LePsdCMme/tfeIZiw174ybqISgsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240690; c=relaxed/simple;
	bh=tDys19jwkyvyl1UvoEX1rSM2yCrf/3jpY10SEGHRpEs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JHUrsZCbhLRR8x4wEke5HyYR3b084l5+u3j3Aek2f+9DpKJs6OgTWY7DtbE23vZzC2PUir6c13hUEmVqhrYmHCy2r89ZiYaLjkPXuFrNbM48nsXVw950k+5/JAU3Md7juxb53upxqwoYLUGMvalO2+KImjzmUtrCrs2cZtTxcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU7uzt/5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU7uzt/5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so136445f8f.3
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 21:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741240686; x=1741845486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld8LpgBue6X6ew27E1DfexG5odB46uw9eCzx8usM13Y=;
        b=RU7uzt/5jcMzLQo486f0bq83Fu27iSThOxmdn3/jfVvi1GD71tK/MXAEz5gyXVLiok
         9Sk0QkP5uQZoILpzZUnWsvsusFIxJ1yUA6TV2TMsVwNGFl+ZiFyQOBj4ufhBWbduIP4K
         C0hnkvRonYAqHsvOLnSSI0NjirismABwFLn1qzISsufTNeZu0/y/+MK3A6p+vmr+45q7
         N4bVPA98GfZqV/yQxOrrB8V0/mRQToyhNEbo3xXwLO6YZOIziz0wswU6ms3yfhvoQwYd
         MCArd/IalDLhziUcj3e0jcbdR4VOF8oX55x6OOHdxqYjbPUfv139up5KSma290323qZb
         Qlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741240686; x=1741845486;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ld8LpgBue6X6ew27E1DfexG5odB46uw9eCzx8usM13Y=;
        b=ZZxE8skfIj9xp27BMENAVB84AIB3Idbjn2bI8KWeqiwCvumW6IbCL0gsP+NwLFb7NP
         tkXoy4tlHkybzBVsSlYpkB1J/KtzMvBDRt1oOuxmpn0/hiXHBCV+MFGCbf7ud1wTsFTw
         HAeuO2vT6jDXeF/RX83HeL71Ph8l0rwKUcjXu6zjpTnh3BTbZqUwR1/eOG+em9I0mnbN
         mbSZzx2fTLxHF1Z+of/rS8aA4XPpuYg3rz0htmzSBaLyllqt2m207iajb4XaNzpJ+VV+
         2YPJfeiKqnSBa7t/OY/t354rptewea/T2bi82QSYWSlDY0VdRhwAgs5kvNRKwr5jEpSd
         oevg==
X-Gm-Message-State: AOJu0YzzTxVNKhhXUzQmI+HPMzy/ZKPzxt113Q0k5TzFopCn7lcAgQJ9
	MSyzO2zGE/QlSqK6j0wI07NDNbWKMIZGYm4+j3Njj/HB6PLq7HngVZRkdA==
X-Gm-Gg: ASbGncvLlCDPS6+Hq58AX4WY1Hwh4ldb0uy3tXLvtlQaNOqBvhbQ+bsyqjgMBamb/e5
	0ox7hdWVo+brVoFFsc60rIi78xiWBpsuY/TVYPMuZMNtQuucELXLGU+/azRVedBb7D7mBBIrVBO
	7y5Oey+6yTn3fQrtUNO7WQVeFJNKkvuAx8ySxV6tPiQy4gIQeT0ecICzgiKHd6YoXAQdD/ZJIQ1
	mpGm7oM9I/AK0TMN+RgSRo5gVrDR440HbHGwb77RtBL+uRLLwIVp3681VdI2HL3HF32Kd1enot7
	zQPIAwFgydj7JFuRoaRL/CU7ZzWvWN+cdH9CPC/O92gNCg==
X-Google-Smtp-Source: AGHT+IFXCJywLhxqRbreuCnNvksVVrMZxHT2/qv3uFrcMsmO6GchwLWeU2o8Rg1Z/OcBq48u3fWvYw==
X-Received: by 2002:a5d:59a7:0:b0:391:2d8f:dd59 with SMTP id ffacd0b85a97d-3912d8fe099mr265635f8f.24.1741240686168;
        Wed, 05 Mar 2025 21:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm861357f8f.35.2025.03.05.21.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:58:05 -0800 (PST)
Message-Id: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
From: "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 05:58:03 +0000
Subject: [PATCH 0/2] describe and diff: implement --no-optional-locks
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
Cc: Benjamin Woodruff <github@benjam.info>

git describe and git diff may update the index in the background for similar
performance reasons to git-status. These patches implement the
--no-optional-locks option for these commands, which allows scripts to
bypass this behavior.

I'm implementing this as a solution to a stale lockfile issue we've
sporadically encountered due to a build script that runs git describe. We're
mitigating this issue by using libgit2 in our build script, which does not
have the same background update behavior for its git_describe_workdir
implementation, but it would be nice to have this option supported in the
git CLI.

Tests and documentation changes are included!

Benjamin Woodruff (2):
  describe: implement --no-optional-locks
  diff: implement --no-optional-locks

 Documentation/config/diff.adoc     |  4 ++-
 Documentation/git-describe.adoc    | 12 ++++++++
 Documentation/git.adoc             |  4 ++-
 builtin/describe.c                 | 12 ++++----
 builtin/diff.c                     |  4 +++
 t/meson.build                      |  1 +
 t/t4070-diff-auto-refresh-index.sh | 46 ++++++++++++++++++++++++++++++
 t/t6120-describe.sh                |  8 ++++++
 8 files changed, 84 insertions(+), 7 deletions(-)
 create mode 100755 t/t4070-diff-auto-refresh-index.sh


base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1872%2Fbgw%2Fbgw%2Fdiff-describe-optional-locks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1872/bgw/bgw/diff-describe-optional-locks-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1872
-- 
gitgitgadget
