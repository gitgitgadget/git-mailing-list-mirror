Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783F81F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeASRei (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:38 -0500
Received: from sonic302-7.consmr.mail.bf2.yahoo.com ([74.6.135.46]:43698 "EHLO
        sonic302-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932520AbeASReW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383261; bh=dAbIFWWJOQ6bDhflaakXdetZgkqdMP+FU0nJijOASx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UwduEba6Sg/PP9jXT2Nhod0dtUklLln+beiy0+GOavPeLRkDThSUlbWf5/RS6ZmeVmFzzdPB4Xqwte5oyFOscJNZK1zycphAb9hxp2GU0Flg6Y3K/bRPPlEhxjEh72spVW1Dz4OBmshfdJ99FauKd/G1cI4RbTVnv1e2PLYj1Bj1X0YRBXXDVFiTcI+1r6PUIynDBy4AhzqxuBo9RfVWGGfZnt1a/BNNRTBS53+b0beCSU34z/z7/yikutyuWYHcemeJRVXxJI0BS4Wkg3UdciFJDFAVKsYJUN/LBu77mgH+HiNUvpquOu6ehELwyp7nh/MnvtSVJKICMpzdkRUTQg==
X-YMail-OSG: fvF.eHkVM1npPHnVI2_6v4nuNmGAZKw1AtU7Id66ZRGKrNiaUwpAg6N0AVt1N75
 dFPnjUwxjHhJ8JP4pnZWc9WEdcI_D6f_JjWX3sDS07IRPc7jBvtJ1vS47zp_LwaEFQmHNdBbDldv
 P_UCtjT3SORbiFE4_mMwRN6vnMRtlXH_sITGHzRYnDfhKqqklyxKE_XXRHwtyhjm3uwYragA1XEP
 9jKMGg2oj1q27DCT1YguXHikBfFN9wTZHfleABCEhf8O2opGu87OQ_Bg2SOBVeJX6FMszAld.C1H
 4X6iaytT_XBDyM6TjpWCliOpy_y1EE0CwQKzi4lK.THPNXMsrfRCsiVI.iHRUmC_CFaTsfuZQP3V
 .gE2rQIYszxy8qq0E.E1oozrSPVH480r2nLsVu5QZI33krNWa4tsVhn6QDzscR_qlLpT6pjwQ8Yn
 zVACfLpZ_cgsdyEVzdeaKVL4742c3cs7GW7WmYaiOB3T9BprDRnpgzawBMTIpzyHAZrcZfSzsDMr
 6mE_MKR5pjPC8fl6ucBc2TEqE_YsfxL43EmqOQpRr_wWt_ENYyQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:21 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:20 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 4/6] Force test suite traps to be cleared for NonStop ksh
Date:   Fri, 19 Jan 2018 12:34:04 -0500
Message-Id: <20180119173406.13324-6-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* t/lib-git-daemon.sh: fix incompatibilities with ksh traps not being
  cleared automatically on platform. This caused tests to seem to fail
  while actually succeeding.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/lib-git-daemon.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 987d40680..955beecd9 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -68,6 +68,7 @@ start_git_daemon() {
 		test_skip_or_die $GIT_TEST_GIT_DAEMON \
 			"git daemon failed to start"
 	fi
+	trap '' EXIT
 }
 
 stop_git_daemon() {
@@ -89,4 +90,6 @@ stop_git_daemon() {
 	fi
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output
+
+	trap '' EXIT
 }
-- 
2.16.0.31.gf1a482c

