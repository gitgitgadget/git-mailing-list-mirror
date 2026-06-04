Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A0E38B7C4
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567668; cv=none; b=liRjdDcMtrFOSxeIGBGQ+ADqKWdIi6CLjc1L3Bum54nsexMZRxoD4+4spiJNWgD9pjQqpd347oAB7Tt/WKnutWm4109hZuPM4byxRL0BqwecCU09PtjiT6o4WzzYza6OwuwXUFxzsrrHjRcIX5Pmx3HAFRau8ZasucqRvBn9kuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567668; c=relaxed/simple;
	bh=Za0rpKbI5UnnydOnxLCS4/fIkmtX51xULZpg5+lBUDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSHLn5ZQKvZavUUnV1x6BWT0pGwOxuePT2YN+CvjklRx5i4OQYjis46TvLtnmYq5AE7ksI6CVZebcdj05HeIUuxX50/A+39s1o3rhSeUKgZJnpU4aY9p5PGAC94QNzwk+lO7B3ds+AlV/8fxMlMmE6+liYCKt3dqwr+9h9AhFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dN6IeFem; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjfGRLFs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dN6IeFem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjfGRLFs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B1DC14000F1;
	Thu,  4 Jun 2026 06:07:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 06:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567666;
	 x=1780654066; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=
	dN6IeFem7iR5K7pwPAAKIVXzkNJXzkQMwfR16JG/SPUjuOdpsrELgPuq/oMw3y+E
	WFYz7d7fNUp5D8O8QvGmAlPNN3ooVeM7l00jnWnOlvtenM4d7sLArFh0ICWP3Gm4
	6zb2lbu4NW5etjc1/3H4nUOFmvrH9ln8HPoOabpl8SlJxivrE88WOgXzeedMQwf3
	9CoHnGdMz8lYWVMQ1x47IhsoP2sdZL/UNrjPTxwhHR3v1Hwq7fuF0Crf+sz8/Hc3
	2BQjGnEVLXwpYBXFGzDQspJ7Gb72MlwGQZMb1zcWvSWsd8F6enNxfIaZP6Y8dt0q
	htXHQs8fPVBsWuMeerduzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567666; x=
	1780654066; bh=QGAx4F6tne9nETImDhMq1D8rCxR8er16xDO8t/8ER10=; b=C
	jfGRLFsEieR/yMXgGgnw4vqfxyXPOcqw1WmAZ54zx3jI+hjA/6rfJKVI+g7wQFf3
	tILSNC4iwwtSzOUAhbD/4VTPbWWYg1iD6L4HKFI0HNVw4UM4yZ2axvM0W+7yms1V
	+41MhSF3th+r2Vc2t1apUkV21WUOqubK3I1Lc0MjJ+C/hGnS7LlEJoJ33uv8tFnA
	dv78Tweth4BlHonw0tU8bQc9GFeSON2Aj112Bj0C85GTvaVCM0xOhO5lSRKKvfs4
	CU8cghWh6HloNsB84BGfhLJ4q1vzMZrd11d/MFXxUP6RIIlvxY8Wob/gWvPaBALd
	RFUviySP1v2paVeINPiHQ==
X-ME-Sender: <xms:ck4hag5tGgXCTxUUzXN_Qq84Jqi3cTjmOKj-pjvLTDvhhEsWF4dMgw>
    <xme:ck4hapX69EjsbGVWSMzIorg5UEfSCrP9JSNzbD_vAJ8lnTi5ziPm6tDE3sZfwDD9M
    Vnvaaw4aDmwAFiLpDQYW-_ZpuaHb2hunQfucEVtRKogU-xk22htxQ>
X-ME-Received: <xmr:ck4has2XSpVtVJSh8gCYC8IyycBK1FmXIVgEO_jpJ_g1_g5z9jY3sVqNrR2Fgr2FXDBWrM6SzI4kNZUREs8yymV-hLULVgx5bdYGYlGEJ3Y>
X-ME-Proxy-Cause: dmFkZTGMbu7/w/ZaywpulTbV6q029k+4CRvBefE38zDB+oDDpe7/ZuzFboKkGddDMpC6H8
    Q65cMH2hqNVIApiwywAi1d3oCMuupua5C6XrHnnITffKfmMRVwTdI5GHkudmJ7ZKEZrrYX
    CKOmv9t1NwRbtoOICGlQGTcGJ1FFYgaEdOYRqLfZqhIlP1ZWNMKv3dVVS2jOfp6CH85ck+
    X+GJZjSuAt4gnXgZR2jlgA8pvi0autxCCmFsaQ4hwO4cz1AmajGgQcBQ3nWLBS5d6EXh4c
    RYSw2h7nb13kcCW4tZMqTZU+tBdbJ81eaW33xVcSzp0LPE+7+IuXs8Di5knqCnrNht8gst
    6CGfbWnrwJ/rbrard+diZ1POiZV8oQkdpSE5PfqhYVuDRAsKvHyF0AHZXvQ0tj1mW2hkqF
    s0vsBHhhUqwGRAPzgmFTJBg8lFXFCFnrETAszvoPWrtbFZFToL7u5sdaU0tSnMvRrAh+cI
    AayybBkBW927ZlnkmjmBHpVqayXPRrEhEU32BXWhEyOFjMtDMlR2s+ag3/9RzfJJVmykXK
    9XJZQcIMfHl96KAadxuDOH35Ov7KvTWd7DR8QcvCRY20lcBEu0hFHVQKAqYLIcwTgXoL5W
    rJQMxj1vlVw1KGx8khPcQ7HoBqnCdALqu/qwZxhAErVb/8AMWTxoAw/0W5fg
X-ME-Proxy: <xmx:ck4hau1T6zQxSsxr4EQGaLmiTxEB2bQ91aCCdqeI0sdwmLyV2pWj-A>
    <xmx:ck4han8ld0Q9WCtSOW3sdRD9egarv7m3kiLgSKR5Srad2GPHmbFCOA>
    <xmx:ck4haj2SEPA9gYAlIQGxi2b2YesAkd_anUxd-Te4Xb3PZNrzzpVjTg>
    <xmx:ck4has8bgD4YcqD_AvWwzWOySy0piOUzumD0uhXrBWEubL41WYyzzg>
    <xmx:ck4hagHXl4ky691G8MBk_b1uM37kZEJnikkSfwyYy1dfslSDihT0A7Cf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41be2173 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:34 +0200
Subject: [PATCH v3 4/8] t7527: fix broken TAP output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-4-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Before running the tests in t7527 we first verify whether the fsmonitor
even works, which seems to depend on the actual filesystem that is in
use. The verification executes outside of any prerequisite or test body,
so its stdout/stderr is not being redirected.

The consequence of this is that any command that prints to stdout/stderr
may break the TAP specification by printing invalid lines. And in fact
we already do that, as git-init(1) prints the path to the created Git
repository by default.

Fix this issue by moving the logic into a lazy prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7527-builtin-fsmonitor.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index b63c162f9b..d881e27466 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -25,7 +25,8 @@ maybe_timeout () {
 		"$@"
 	fi
 }
-verify_fsmonitor_works () {
+
+test_lazy_prereq FSMONITOR_WORKS '
 	git init test_fsmonitor_smoke || return 1
 
 	GIT_TRACE_FSMONITOR="$PWD/smoke.trace" &&
@@ -50,9 +51,9 @@ verify_fsmonitor_works () {
 	ret=$?
 	rm -rf test_fsmonitor_smoke smoke.trace
 	return $ret
-}
+'
 
-if ! verify_fsmonitor_works
+if ! test_have_prereq FSMONITOR_WORKS
 then
 	skip_all="filesystem does not deliver fsmonitor events (container/overlayfs?)"
 	test_done

-- 
2.54.0.1064.gd145956f57.dirty

