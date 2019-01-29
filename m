Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016D31F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfA2Uhp (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:37:45 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:53578 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbfA2Uhp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:37:45 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJb83h031166;
        Tue, 29 Jan 2019 11:39:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=76sBK2d5nQwrL8X9Ccghhd8b2CwGGIrgBF0cw/ur6z0=;
 b=PEVm9ZsjBKxOkz38dLruEjGMUhtcMfFt7Gzx30Qzi3USPCZ4mdc328fD46ec2pCb+N2Y
 i/1on4nShFsGN6cT3k5Z/ZWGacUocb0MqjAGKI0Zy4sYdPky96BE7F2FWpyykosUKKK2
 vco8uFiNHleCH4Mjg5QmbkxE81E16ScrhqThU7266JC7IvZOh0TtVdr1zFmBxKmIGWq4
 F2TWybXE3mgOQk8y5q1PSehnUwHC2Ldzw1omek4kVbff8IEjRHSbxfn8lB76OdrANGX0
 CVPW/3jDDGU++/4U6ppGySoX6FzzN8O/ZyfJwp6x/AMi0IxXBsOPJQsVb0a301sRCD4n qg== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9d8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:39 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300AIKYLYUZD0@mr2-mtap-s03.rno.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9OJL00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 4385a352db838a1666258bb2a9b0434d
X-Va-R-CD: ab960f9f96e5e8ef6750ffad1d7d3984
X-Va-CD: 0
X-Va-ID: b8aa9927-f456-4ed2-a40e-b833c7240c4e
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 4385a352db838a1666258bb2a9b0434d
X-V-R-CD: ab960f9f96e5e8ef6750ffad1d7d3984
X-V-CD: 0
X-V-ID: 294e4061-9ec2-4e0f-a971-3d73fd25278e
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300100YK85D00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 07/13] HTML documentation is not provided with
 Apple's git. Make the error message more on point.
Date:   Tue, 29 Jan 2019 11:38:13 -0800
Message-id: <20190129193818.8645-8-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 builtin/help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 7739a5c155..e001b6157c 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -383,7 +383,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	if (!strstr(html_path, "://")) {
 		if (stat(mkpath("%s/git.html", html_path), &st)
 		    || !S_ISREG(st.st_mode))
-			die("'%s': not a documentation directory.", html_path);
+			die("HTML documentation is not provided by this distribution of git.");
 	}
 
 	strbuf_init(page_path, 0);
-- 
2.20.0 (Apple Git-115)

