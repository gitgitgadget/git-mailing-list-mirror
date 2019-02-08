Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BCB81F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBHLIo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 8 Feb 2019 06:08:44 -0500
Received: from elephants.elehost.com ([216.66.27.132]:46975 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:08:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18B8eRS056939
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 06:08:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
Subject: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Date:   Fri, 8 Feb 2019 06:08:33 -0500
Message-ID: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdS/nXlFYBSr13+2R2S5YaQNtjoAag==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

t5318 is rather problematic and I have no good way to fix this. There is no /dev/zero on the platform, and the corrupt_graph_and_verify hard-codes if=/dev/zero, which is a linux-specific pseudo device. Please provide a more platform independent way of testing this feature. Pretty much all subtests from 46 onward fail as a result.

expecting success:
        corrupt_graph_and_verify 0 "\0" \
                "graph signature"

1+0 records in
1+0 records out
1 byte copied, 0.002248 s, 0.4 kB/s
0+0 records in
0+0 records out
0 bytes copied, 0.001815 s, 0.0 kB/s
dd: failed to open '/dev/zero': No such file or directory
not ok 46 - detect bad signature
#
#               corrupt_graph_and_verify 0 "\0" \
#                       "graph signature"
#

Regards,
Randall

