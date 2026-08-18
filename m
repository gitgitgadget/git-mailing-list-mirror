Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7A330B15
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092451; cv=none; b=gtNQznUWJmvQvIrB0sXy9tj+nU6mcnsGLNE8wCl1pw3tuqWVnZgwcEMkI3ZMSIRjPD7WpKPCXkOXC/VvkkI/i6r5PbGMTZFlnWv177+7g35iG56pXMOqs98je5bVE2ROMIxRzU7DZSqt+x/Yx9G0Tdsc37SzF5CpeB6alnYD0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092451; c=relaxed/simple;
	bh=nqxlqs1MjyFAp/24JBtvop5n8sOHYcpSGkwMfhctiqE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aCzmbr8lF3GGddGL98L4hZXgUwFMvohNKSQAwucXzNcuJUoeCr7VKJT4R845PuFKfn2yVRkYk8iRWcfuY72WGiUmetPUxV3pQB0y4jkg5Aiv1Pt6dQPBmCeyY0pV42z4jbLr6pFUretaK3r2L8C/nUHn2G6vvIApqmXtXIeqnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKmuePYg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKmuePYg"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so234489a12.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787092449; x=1787697249; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pv8Qk/eVmkGLHuC4GGZAUl7+ozm0FkIbZjAtxT92LeQ=;
        b=sKmuePYgaNQS71up0Db+Sf+8ENI3pEoon6NLRK2F+35J4dHcS4GRPV4duVTwiCviQh
         EWOdR9cWY17LDAdmAMAxx38Jouz/MfYJBvOTULDRC4dzklOQY8g92iPncGot8kN9+LpW
         Ohx7IJ96pU2ot4k1EUZZTIP7NXyGd8FYYc3l0j6mSFU/mAqikirEroobUfHJloyKtqr0
         duuHmeLIhGLoxX2XGoL1oImvOHLcwhAwvp0kon2aftzJnNxbc0gYlmi5SAm+hNcRQHFP
         eH4BIp1kqKXSGZ5rZfTddwQlollIlow70xPesj1sH1sB2PSO/AIeIu2qC53Kc7yTcZC+
         5f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092449; x=1787697249;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pv8Qk/eVmkGLHuC4GGZAUl7+ozm0FkIbZjAtxT92LeQ=;
        b=qfdbXGIHLHr/QJXT/MygrJNKaR7uWdrlPOXvz2wFQDIyu9JV+WqPD7ZbheF/ndfLXt
         vfeQPN0+Yv85jzX0q5butK3ZC3dp57doETG+MQYVca6WTgA8C3XxQI0nXz/Bv0kp0HxC
         b4+9HrDNGuaUcpvdDB+V14knGHC64ywXQU+tyGWk+SOBJ+ZpLslxyTgxh/oYVoxmj+DP
         eq96PdBStBbL7Uaio4PT9RNO6M8XFHvrCx8Fu1L7gvtDFi6g61y8L805BumDl/l5nYUt
         vwF7RGAi08Y2zPzVXqHfnzDLtfERrJgizG8Ci57RgaMsC47rQyXJbCim1qWwDRkqSIOF
         2lvw==
X-Gm-Message-State: AOJu0YzS6G6y3lQK9U3wnAA+G5wfI7aVKrTc+UyrX/7liR/OHMRatcCa
	ShsDix5Zh6QcCnrMV7w1aQQPJnfV2tHOMIpN2Uj+OTIlcr8QoFVSiRGMJUNO1w==
X-Gm-Gg: AR+sD124o0FosLnAXUauqF40Dk0cKg4jbhpbImWpUlPLpQt1uI7ej/hUfUHielTfObW
	SOaQ1EXV5Ze/HU6AoE/JkftNfA16j7Yxf9wd4e9xgqL2AFRHW9gWQotow6vLYbX30e9MrVCCuZZ
	6D4YGM81ISX+zb+ZudmmtWzJVeO64QdR7NRDh3D7IN/cF6pzWEUNZZmsEfmzIztiaJlo39iJe7B
	tyzOKi0xiPBMXJ/bAPEnwc53sVIb2qTfEATLOPhQlpncY40NZzh0j4oANymNP5gDSirURsaxtzX
	SOTQ8Ngs6GgEDurAN64QIO8i+cfnjSUq/IPC3l5or37xCjiOrMD5yYRXcuQ1N9+db72TFwncXQ0
	1sy5MzCxvc6FMXIrcPbxMrU3q3lkq3AUXCJNbDfHWnoo149oeMzOMe7HtewCidClsIFIZfsPgzt
	2G/o06BEKWb40J2nfMa7GFgPBWH0fm8ZDg6iRgkJSTVs+M20+cG55y9PyJUiqjfGy99vahBpnE0
	lM=
X-Received: by 2002:a05:6a20:244d:b0:3b3:216b:2743 with SMTP id adf61e73a8af0-3cd00dc89aamr740994637.4.1787092448742;
        Tue, 18 Aug 2026 15:34:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77bfcsm275408eec.9.2026.08.18.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:34:08 -0700 (PDT)
Message-Id: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Aug 2026 22:34:04 +0000
Subject: [PATCH 0/2] Objects treated as missing despite being present, due to race with geometric
 repacking
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
Cc: Elijah Newren <newren@gmail.com>

When an object is found in multiple packs that are in a multi-pack-index,
and a subsequent geometric repacking creates a new multi-pack-index and
removes the pack that was considered the owner of the object in the old
multi-pack-index, then an already-running process that had opened the old
multi-pack-index and hadn't yet opened the removed packfile will not be able
to access the object -- lookups will return it as missing. Additionally,
replay has a separate bug where a missing object causes a SIGSEGV rather
than an error message.

This appears to affect a very small percentage of git operations in
production since it is a tiny window, but I've found evidence of it
occurring in at least eight distinct server-side operations, covering seven
different git commands:

git operation                        symptom
-----------------------------------  -----------------------------
git replay (server-side rebase)      SIGSEGV (this series, 1/2)
git merge-tree                       spurious read-miss failure
git diff (raw and tree-vs-tree)      spurious read-miss failure
git rev-list --count                 spurious read-miss failure
git merge-base                       spurious read-miss failure
object/rev resolution (rev-parse,    spurious read-miss failure
  cat-file)
repository repair (fsck/repack)      spurious read-miss failure


There are also commands that could be changing behavior without throwing an
error -- e.g. object negotiation thinking an object doesn't exist and
instead negotiating based on an older common commit, or cat-file --batch
reporting that some objects don't exist.

This series fixes the replay bug first, since it's simpler; investigating
it, together with my other recent repacking work, is what led me to the
underlying multi-pack-index issue that 2/2 addresses.

Elijah Newren (2):
  replay: fail gracefully when a merge input is unreadable
  packfile: recover when a multi-pack-index names a removed pack

 odb/source-packed.c         | 29 +++++++++++++++++++++++++++
 replay.c                    |  7 +++++++
 t/t3650-replay-basics.sh    | 35 ++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)


base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2207%2Fnewren%2Fmidx-removed-pack-recovery-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2207/newren/midx-removed-pack-recovery-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2207
-- 
gitgitgadget
