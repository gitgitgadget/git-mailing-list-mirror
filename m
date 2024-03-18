Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537350251
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775077; cv=none; b=i6nC9a79AcnsmoBIDPZc48S7Re2CvnVm+juoZEubdM0cnqEDMKd7OtlPH9uCJthS6iDA2hXoBcVFVdShKgXarnUeJdap7FIg9cSssCDo4XJIKneBOjyhdUSsTUslMQW6Q4/svHtL/TAxlw0/fyt4mpegik/h/ZO6aRqMgvlYeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775077; c=relaxed/simple;
	bh=22sMZ+QC/TBhlZ+GCFTA9dmPAv2p+PUO9SUQl5NRbYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOCL4N0Zbd2++1tMyc0xzpStc73fUHGCMBzxxVFIJZI5XYF8GYkaGmDJXr80cPm/W+CY3R/Mj3RBaxlW//eKrS6dKpMUqpQmviIwsqd55S7FA3dY1Mlul4cykH4nsyfmxaGNTFLZARcJv5QbkRiYEWYLpDphp1dYwwtvfgFw3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=DbyJpIJD; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="DbyJpIJD"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id D9344602E9;
	Mon, 18 Mar 2024 16:17:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocZS4h1d9puN0KkDFHiEFjLOzjn7MTNjmGGNmcKalX4=;
	b=DbyJpIJDWtIoB8iSY04glQBrQGJQgf+5j0/+ushXsHbudiHGhWrScWxFckqjmNgSvrWQIL
	akLljUB53PEs17IENn2Ew7yucv1imVZdYBh6krnqlFKBea62Zc8lKiqW1u73ZleDVoV+IB
	jO3LL0SmfEm6FH0BCdGt2xliv9kil+ekEKbpGuIykr5o4LH+B8eN9ZmHeEqeaPPEBElibu
	89bbj1iXSF976zd3aOXdRyXk8cTQPHM5l8uc9FOsfuG1OuPL8bFwR0wBGOhf6qnGnLImfP
	52Tm7XiaDJIfhMwMGIR8GrRUbKu0o4a3Vebo/dtJm3+EaQYkWCkMJKgRD28mCA==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 4/5] maintenance: update systemd scheduler docs
Date: Mon, 18 Mar 2024 16:07:22 +0100
Message-ID: <20240318151701.26644-6-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318151701.26644-2-mg@max.gautier.name>
References: <20240318151701.26644-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 Documentation/git-maintenance.txt | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 51d0f7e94b..6511c3f3f1 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -304,10 +304,9 @@ distributions, systemd timers are superseding it.
 If user systemd timers are available, they will be used as a replacement
 of `cron`.
 
-In this case, `git maintenance start` will create user systemd timer units
-and start the timers. The current list of user-scheduled tasks can be found
-by running `systemctl --user list-timers`. The timers written by `git
-maintenance start` are similar to this:
+In this case, `git maintenance start` will enable user systemd timer units
+and start them. The current list of user-scheduled tasks can be found by
+running `systemctl --user list-timers`. These timers are similar to this:
 
 -----------------------------------------------------------------------
 $ systemctl --user list-timers
@@ -317,25 +316,25 @@ Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago
 Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
 -----------------------------------------------------------------------
 
-One timer is registered for each `--schedule=<frequency>` option.
+One timer instance is enabled for each `--schedule=<frequency>` option.
 
-The definition of the systemd units can be inspected in the following files:
+The definition of the systemd units can be inspected this way:
 
 -----------------------------------------------------------------------
-~/.config/systemd/user/git-maintenance@.timer
-~/.config/systemd/user/git-maintenance@.service
-~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
-~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
-~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
+$ systemctl cat --user git-maintenance@.timer
+$ systemctl cat --user git-maintenance@.service
 -----------------------------------------------------------------------
 
-`git maintenance start` will overwrite these files and start the timer
-again with `systemctl --user`, so any customization should be done by
-creating a drop-in file, i.e. a `.conf` suffixed file in the
-`~/.config/systemd/user/git-maintenance@.service.d` directory.
+Customization of the timer or service can be performed with the usual systemd
+tooling:
+-----------------------------------------------------------------------
+$ systemctl edit --user git-maintenance@.timer # all the timers
+$ systemctl edit --user git-maintenance@hourly.timer # the hourly timer
+$ systemctl edit --user git-maintenance@.service # all the services
+$ systemctl edit --user git-maintenance@hourly.service # the hourly run
+-----------------------------------------------------------------------
 
-`git maintenance stop` will stop the user systemd timers and delete
-the above mentioned files.
+`git maintenance stop` will disable and stop the user systemd timers.
 
 For more details, see `systemd.timer(5)`.
 
-- 
2.44.0

