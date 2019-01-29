Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCA0D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfA2UfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:35:24 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:43320 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbfA2UfY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:35:24 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb9fa006222;
        Tue, 29 Jan 2019 11:39:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=CY6Lj83Du/X9ZjVXtvHHMGqMp/0daiRQ3es8KLCCxX8=;
 b=v6IW3j78ngdyRPTVED5+FlLjV/K+c6c526MesfC4GCIC+khdGkulzTN1vW7rgGRlft06
 H2LxrK6ApjfJ9ypctQDbN40rsbRCdyXOMKTTcpniqfpU9hcVuD/DVDg2GDvinmORWhEC
 R1do+whReRxKOO5E6e78ps5H0nqIKQmKPEj9GDdSjZ32D7o2KuYNMKJwATj87F9xZKiJ
 tpqDYOEJuxDp0iuCMcIbNXh2efvtVR3v59n6mXNvAdi6IcU5GfR+MiYzpaZua+0Oqa+b
 3vmHGgzYd7sIa4ZCzJI4L6fwR6bgdRuExWKV9/AiOSrYi4+QS0Pb01RzFU9FLNTEslAV ag== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2q9832j51y-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:36 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300G47YLXUYE0@ma1-mtap-s01.corp.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9PJK00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 0e5cfef7aac8346953b9adf4823fed9f
X-Va-R-CD: 75db5ea542c87c0de9a6cb261374d43a
X-Va-CD: 0
X-Va-ID: ae792ca6-b9c0-4379-8c3e-8ef19930bc51
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 0e5cfef7aac8346953b9adf4823fed9f
X-V-R-CD: 75db5ea542c87c0de9a6cb261374d43a
X-V-CD: 0
X-V-ID: afa53a10-1c1f-4bc5-8daf-5e82bb2e0f48
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:34 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH (Apple Git) 04/13] t4014: git --version can have SP in it
Date:   Tue, 29 Jan 2019 11:38:10 -0800
Message-id: <20190129193818.8645-5-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

480871e09e ("format-patch: show base info before email signature",
2016-09-07) added a helper function to recreate the signature at the end
of the e-mail, i.e. "-- " line followed by the version string of Git,
using output from "git --version" and stripping everything before the last
SP.

Because the default Git version string looks like "git version
2.10.0-1-g480871e09e", this was mostly OK, but people can change this
version string to arbitrary thing while compiling, which can break the
assumption if they had SP in it.  Notably, Apple ships modified Git with
" (Apple Git-xx)" appended to its version number.

Instead, come up with the version string by stripping the "git version "
from the beginning.

Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 909c743c13..414c56fcff 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -757,7 +757,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
-git_version="$(git --version | sed "s/.* //")"
+git_version="$(git --version | sed "s/git version //")"
 
 signature() {
 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
-- 
2.20.0 (Apple Git-115)

