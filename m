Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4A2F8EA3
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914390; cv=pass; b=ntzL0FSKDU9O11BriW78uMCguS9gAe8raTDRRI4lsix2h0wMLvkxIdhBjIfKHFlBhJfAdZMpD8yF17xBs4phKusazz+T9c1GubOFJtUn9GDN+u6HaDvReiQOJEpMTmvHCm1ixFYgIx5S6sXS83qMHgsPJY+Kpp9gB0T/fJmXqLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914390; c=relaxed/simple;
	bh=LBhh6L8zhjlfYc4VvUnk+lejFIbTOnsIOv8JqprEbhk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p79OGBEiTkL1My8wQNJMmUE2fO7L+tKCa8Qok44QB7e8EhOfMwgPbPu3BLYFdYrarx10GNtGaeFcThA80McR0nK4DV/vjRnEIbXJYWbYUwBIX/u4F2C3Ec5aFzTDd3S9gylRoJDWMkeWSuhtWK6cY491Oa/YWdQYE+dmVMhxFXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlAJAmCo; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlAJAmCo"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7e0so4345248a34.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 21:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790914388; cv=none;
        d=google.com; s=arc-20260327;
        b=oJy/xHnuanCZ8X0ihY/bnseKPVafOLSdABhgy6ewoMKbJnYL/2/HDeBTZ2o2BaICSr
         cJXUBtRqcvZKexz4LKsnYpvc6PtC0DGFnmsEdp/iABV8Qr+PQmY9ydEZFYY+gglg1QYL
         w/6tFINDycd6dSJJkSmMb8t+jLvADxUH1s4bwRLoCEGBDNMBKoz1AdeXLUmhqdcnjMcN
         qfu4TjuAX/ORhe3kRprq5OvsjTkkvuTfNV95IfxH4xsM2TnK8Q1JFkYTBnjwJJfFIfny
         jaeoBQHqOVkyl/uG9wsP0uAGLLTc+vNf+pskZ/Xw8M6+mhn6zVkkyLQhF/eCgb1hoQrr
         bMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JEwi1CJNwEnFExPp1FiHJN0yhxHYqDOMNXsRtupPPbA=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Z3MWhk11ltm2W6fBxXbhZF3rN87HituV4ZN4JWAcsqIAYPH7ysQ6tC4luF5SFni8lL
         9I5WCEoV53FUrWDKMWUyvR5Js29DC7FDRlD6+5mqbDbkApwcaYvwdq+im9xfesVsk5F2
         s8BI5Qm617gL04xaD9xPyAASK6BknUGdHt7s0dSm/1RrvzIhGevF2MEtx74zTnLymhNI
         kIo4lc3lsE7J8u1DP9+SFuK141++nH2oH6MNVJ+MPHeyXTLZNXYjyU1m7eXT+l0rt2NW
         o6EDl3I1Z3at0SiPf6NSWhYc+ZDKPsPrHBQ45zel9f6f0yZquGTQF8KJk2CjY/PAt9MV
         k/xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914388; x=1791519188; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JEwi1CJNwEnFExPp1FiHJN0yhxHYqDOMNXsRtupPPbA=;
        b=WlAJAmCocn2iDsC6CQkCBHRWL5MJ1nq+LTV/91VjSfPVvDNs49t8M11ciX1+7lyPaR
         nXiaPd9zN8paoNKVeBhGC+KpMe0CC4nkkHR4o1SZb6uS1YomgktxXUYHEbAEkaHiX+1K
         C4gjNkWuPc/Kz5f/DkoBUfmg3MDBJREDWJUtg0XWLm55jpkd2B0hSGnq8cKF8QK4/GpX
         gpKOlOvto3PznZnPnV76vhBNNhJnH47NbhKEgCMWkQB+tBRbZPWggQUJGBCCVe2M1+of
         jjBG9FYbavNNxi3w+NRFMfqCmQAhu3HT5MYYfZNAlDMZmGNCu4tohi1oqWePwwrX3WOb
         NIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914388; x=1791519188;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEwi1CJNwEnFExPp1FiHJN0yhxHYqDOMNXsRtupPPbA=;
        b=picSZLBoewWreskIy51rMXIynnCrHWavyc0e/6H/wRO6mwS4G5xPy/9LAl3SC6MZfx
         V1dVac+wE3kaQNcSIKr/U55AQA9AVLmanYFsRAjSrtpLsVt/wKvTZI4R8B0MoLYqniPJ
         tltGR+t+wifeCjvwwjWmqPP5ipm4ThP/Fr4kc7YenkG9PTHXZ12G4OjHCBq9gD75ZcjA
         MD11sThZtG1JegINKKkzn5M0V7b/aRO6woWlAHKpYBjwsghJrFKbEkWTcv1otGDVBk9j
         VkZRzmTRTS/30xTIED73N4++6lrbXL/HEYpbM6as71+3Ikpe1TIIO7kOHbskBvH4+oDf
         nHpA==
X-Gm-Message-State: AFuF++ntKWprO526n0b3437WN3KH2bOAJgCeTuVQJQ3+0+RCNIBLlqEn
	x03fdICNWVWVtcxykDpJqNTJ9R6VME/0DaLfpPlheix7QECb/4BhbIUfcKuH4QN404syjzo1b4H
	8M30rHnOmpIfhtR6xOBo7sZE1TuEnCsULMTdm+9XLew==
X-Gm-Gg: AYBFou0RoYgEMi8GdGS5Em4XEXjZme2ZjIJWNKlu7DscpZfjzwWI592ZSyGcMkiZD2o
	O41Lz6kL4HPlnRpupxTXqdKrxvx2ZO/UR87mGzu32p4xfF/XS5D5lgyCTO0+j6xeMuJj/WULb3Y
	ZQpqyn3ZMJbxYmBeHMfgqh+AWEGhiZn+p4HpqCPA/XbaMs4AlHOUQEURWG+WM+jtwYVMejLGHb5
	lNGVgkN4yWaEY7JDayWmGhqIU67AqkkbM82XdMDcO/NTZ3+yW+ubO0ibdPLFadtzJA+MWVDsCqX
	NdTwLT/j6tfn5Q7Ym563Zw1mDEz4DimC8FFK/A7NIDjhi9xU1dJ7rmusXKAVh2Df+lM9tI+xXx3
	f8uRvdwHJE79G1OsaiwtJK09B
X-Received: by 2002:a05:6808:1790:b0:4b5:5bfb:f25d with SMTP id
 5614622812f47-4f5290f6c0dmr1181861b6e.20.1790914388326; Thu, 01 Oct 2026
 21:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0J3QuNC60LjRgtCwINCf0L7QvdC40LrQsNGA0L7Qsg==?= <nick.ponikarov@gmail.com>
Date: Fri, 2 Oct 2026 07:12:55 +0300
X-Gm-Features: AclHuK-lmztzlgrYO3qSygC5SK5lbnU_C4KqdCvLH8HAPNZHd3BcTUXuBA23GHk
Message-ID: <CAPHjog3wuWOdZS3pHQd20hdZNwA5iXsQMkEfmSnp=NGhLBzuJg@mail.gmail.com>
Subject: [BUG] branch copy/rename update refs without running the
 reference-transaction hook
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

The report below was investigated and drafted by Claude in the process
of building a branch-protection tool; I've reviewed it and verified
the reproduction before sending. Happy to answer questions or test
patches.

---

githooks(5) says the reference-transaction hook "is invoked by any Git
command that performs reference updates". Some branch copy and rename
operations update a ref without invoking it.

Observed on git version 2.55.0.windows.5, with the hook registered both
in .git/hooks and as a config-defined hook (hook.<name>.event).

1. `git branch -C <src> <dst>` where <dst> exists and is not checked out
   anywhere: <dst> is overwritten with <src>'s value and the hook is not
   invoked in any phase. This happens on both the files and the reftable
   backend. With every documented hook event registered to a logging
   script, none of them fired, and a GIT_TRACE2_EVENT log showed no child
   process.

2. `git branch -c <src> <dst>` where <dst> does not exist: <dst> is
   created and the hook sees no line for it.

3. `git branch -m/-M <src> <dst>`:
   - files backend: the hook sees the deletion of <src> and a
     "0000... 0000... refs/heads/<dst>" line, but no line carrying
     <dst>'s new value;
   - reftable backend: no line names <dst> at all, and renaming a branch
     away deletes it without a line for it.

4. `git reflog delete --updateref --rewrite <branch>@{0}` rewinds the
   branch without invoking the hook, on both backends.

Reproduction (any POSIX shell):

  git init -q -b main t && cd t
  git commit -q --allow-empty -m one
  git branch other
  git commit -q --allow-empty -m two
  git switch -q other
  printf '#!/bin/sh\necho "hook $1" >>"$PWD/hook.log"\ncat
>/dev/null\n' >../h.sh
  git config hook.log.event reference-transaction
  git config hook.log.command "sh $(cd ..; pwd)/h.sh"
  : >hook.log
  git branch -C other main     # main now points at "one"
  cat hook.log                 # empty

Expected: the hook runs with a line updating refs/heads/main, as it does
for `git branch -f main other`. Tools that enforce policy through this
hook cannot otherwise see these updates.

Note that git already refuses -C/-M onto a branch checked out in any
worktree, so the gap is limited to branches that are not checked out.
