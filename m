Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66D6202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 17:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbdJSRs6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 13:48:58 -0400
Received: from mail-he1eur01on0110.outbound.protection.outlook.com ([104.47.0.110]:47358
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751882AbdJSRsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 13:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IrJQ0U61sJRmmMh7rrzzE1RqrrQAsg1CJs27tvnur8o=;
 b=E5lvPdZ+KYTzTyNIoX+cTvscUk2icK+IccP4+I2CVDtbCek+p2Qfz4AdiB41b+iaPm0nfM1kxTCe0oY7uoRFs4IqKbvSN1961mltxP6ywltnRCUAHevRnABgjBCMRgxk+tPjKak5GYnsvrXgBOS1FP9z9msFatu+NqICLCRkZoo=
Received: from AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22)
 by DB5PR07MB1286.eurprd07.prod.outlook.com (2a01:111:e400:599a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.156.2; Thu, 19
 Oct 2017 17:48:50 +0000
Received: from DB5EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by AM3PR07CA0112.outlook.office365.com
 (2603:10a6:207:7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.178.2 via Frontend
 Transport; Thu, 19 Oct 2017 17:48:49 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=list.nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of list.nokia.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 DB5EUR03FT055.mail.protection.outlook.com (10.152.21.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.77.10 via Frontend Transport; Thu, 19 Oct 2017 17:48:49 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v9JHm8Oe010472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2017 20:48:08 +0300
Received: from storageserver.lab.sk.alcatel-lucent.com ([135.243.195.245])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v9JHm7Zk010465;
        Thu, 19 Oct 2017 20:48:08 +0300
X-HPESVCS-Source-Ip: 135.243.195.245
Received: from skbrao195060.lab.sk.alcatel-lucent.com (unknown [135.243.195.60])
        by storageserver.lab.sk.alcatel-lucent.com (Postfix) with ESMTP id 23DBD2C01C3;
        Thu, 19 Oct 2017 19:48:08 +0200 (CEST)
Received: by skbrao195060.lab.sk.alcatel-lucent.com (Postfix, from userid 500)
        id 0C242280E1A; Thu, 19 Oct 2017 19:48:07 +0200 (CEST)
From:   Marius Paliga <marius.paliga@gmail.com>
To:     <gitster@pobox.com>
CC:     <christian.couder@gmail.com>, <git@vger.kernel.org>,
        <marius.paliga@gmail.com>, <peff@peff.net>, <sbeller@google.com>,
        <thais.dinizbraz@gmail.com>
Subject: [PATCH] builtin/push.c: add push.pushOption config
Date:   Thu, 19 Oct 2017 19:47:15 +0200
Message-ID: <20171019174715.6577-1-marius.paliga@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(376002)(346002)(2980300002)(438002)(189002)(199003)(8656005)(8656005)(2906002)(50226002)(5003940100001)(68736007)(189998001)(6250500002)(26826003)(76482006)(103686004)(478600001)(6666003)(22756006)(82202002)(6916009)(52956003)(90966002)(575784001)(5660300001)(42882006)(2950100002)(73392002)(33646002)(4326008)(316002)(53936002)(50466002)(8676002)(1076002)(55446002)(42186006)(2351001)(87572001)(16586007)(50986999)(76176999)(551934003)(106466001)(47776003)(61266001)(81156014)(97736004)(106002)(81442002)(46386002)(45336002)(8936002)(36756003)(39060400002)(81166006)(54906003)(6266002)(305945005)(356003)(48376002)(45356006);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1286;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT055;1:LfcnBXOr56yB7GBGJuKa45InPUrndihMxNe9PlxdCqK1N27zB0hl8+ab2ehZ9jVj/+GFOICDdEpKW0y/nherLcoSiP2YDDB6gMUF7EAH7lr0rcHw7Hig11Lp22kKijKG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015e253e-99f9-4477-a30e-08d51719a7b8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254172)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603199)(201703131423095);SRVR:DB5PR07MB1286;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1286;3:z7utccVEk/Bh+w0GnwglINoGmUylsI5UPq1el+onVle6jrNNPeVDdshn7RE62p+wjdesJBTddp3eb/xJyYbNWhZKbcB6v2BMbPm5zfJFutJVJHO9ws6OfQvzwTKWb6cfRX0scEp3ktaXPlqEjTqe7JqMttxB1QQJghj2LT8a5cMu+HDAHWFKGGWoXgFj9+KolWEiQKEjzgluNmtKywvUJeDirVkN9KtXhPVjAVX9SPiMxC5WOximHLj41B2lCcdG3knGWZkOLcZrBSE8/iMGhJogO+WbTWdar762X1Qu5sMHfOwVWhjG3unGyWy9VxwGIJ6d/XsXh5ahtHXWvwXLohtUIrFDAiYmc6TP336tF4A=;25:UdgvZm/9OiTSKxAQYYPHG/TehCMhk7tv5ttztCN+I93YNTW667EvUbAmurDGgkahQKpMggqyZ++iCEQDIJkKPG5mzc5wJ4/cFgBuO9GCYBzJyiOVFgW5YCEIhsHEESelzbHEOrkXBUD3coj+qER49RLDtkL2S3jiOXzBeJFHEulk8PAK9ry/65hlw+o1DysbInvlhP5QfMsQS4YWzqP7jZ/hLEDcMbpi890uQDIGk5a6vJ9OHprJbAi2O4oF5KvSwephfmbOTX+lweFbpDPqGqJi4ClOECCGd0GG88T0itWGKlm9QCe1LdrnkHH1pq4HcGMy1IYIeZJ+PWMxYMn2fA==
X-MS-TrafficTypeDiagnostic: DB5PR07MB1286:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1286;31:0MB2XyuozSVg1M/tbYu9c+igkLH49VECfPoGgJF6CQ2cjei/XLsHyPzFbiYLgow9iDmweotksUYqp1qloMbffLUZcJLgqcihTxJnLbvsPoVnbGN4O0WVlj93oAWaTV5Ftt7bN5MaNBLGCg3nvt8wBAZfpO/GPY5eBJbJc24zj0nP5hhwfD/0QN9YZvCGVecCLJwLuM3ezNHRk6DZFezjByrsQ5RH9vRfTrcjcrzzO7M=;20:jnozIXAtMkRSWklBR3lLBJ7t3pAXTO3jwH/pvY/gTdlaYab/stUhzId28ejX12lx3cVMlUqpyUSXnEbFTBOGjcYN6O5y7pg6Pf5cjNSjhoehHl3LfzlNJygk46k0oXg1cHMk1P5Fk8mcyONp+iFnQEbgv4CQbEX0iWcMmiRFfp5xtM1DSUOELEs6qyp5WLtiPSh9NOhfb0QrAhxUzHq+/TIoW2mcdMCltr7sn185aKG2cKSiUH0D/JLgzuIOSwpynahyeL1+ao0t5rk/8biXF8zDBIjKAQhmK1wXYyo+ZpSITLIxCtmPR23MEWnDlk/yjaYXatwdRMV3VjoNvROAceWt/ounkM/8NlF63CXy7X62wPgxWNytcpe14/prt/t2IklU1EbQAAIUPVq+PwMy65hAMfIhy51qocX+rDGXCj9gNDzUqqsgSR+qxbrzUM8dW/S1Gs7ylrKAkiAhc5mVvdI6ecpD59msiXaVvdy4gxYX3Ec4VGz7IJFVMfVN+9LpWA89UARH80mcobc1RMicD661ccZtYb84oilJ0EGKXAD9BXHrCCjEkTcT8RQBgBBF1u+DMd4N0QGft8BcDRN7oAEcsWvT0XhgHL3VRknpxfI=
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Microsoft-Antispam-PRVS: <DB5PR07MB12866A8609D0CB3FD644AF1197420@DB5PR07MB1286.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(93006095)(93004095)(100000703101)(100105400095)(10201501046)(3002001)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123560025)(20161123562025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DB5PR07MB1286;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DB5PR07MB1286;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1286;4:kIzzl0LyFGuIEqN4p/ptYimJPNI5rXTnGrA0bOq65mQWFDxQC+//ruZKm16hpqIJ4QgNGROot+xZCNONrIE6Q8W96F6S3okciOrfqIA6s/HHMhWvc5GHM9fr9nGYVVuUvAX/SpYX6NKmo9LSm2qAD6UnZ2m+LkoSwsiykvmr6gQDdTeKU5UE0vxHu3nBtqWAsaX/jcZpEk9l89vlX+gySdL/tMhblux5XTX/Gk6iXqm4Z3LZXuRTcnurQQnekV00+Ga3+hNesAksqB8sGuGuJQOjVM0Y8i8TJZFBVMHLu4o=
X-Forefront-PRVS: 0465429B7F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1286;23:X8ThX+7Scm3rQkj3CP9Qflee9w0Igf2UQ81sPEJ/B?=
 =?us-ascii?Q?wLUyEvnZIdra+ParNVanBfhln0q+/LgLcns+NH9Km53adyf+pwwawTo832Zq?=
 =?us-ascii?Q?U1td7g4UtfmVRD99nfnsX3kPFWp+F6ezs6DWXbpS7DVna16K/lUNC3jNj40y?=
 =?us-ascii?Q?1tLQDvuz4FtrYezwiwsmErdkrAbYs+CV0ExFoKbbLtS3+vlECLYTXjoiEaN6?=
 =?us-ascii?Q?BdPQ+HXkK3JQmgv6vMtiQ34YLAYMlVCoitsJ7Ni29DDTQhAUqeahV3EvQbR3?=
 =?us-ascii?Q?8fQp49uYAxOgmHXlDVwAvHQUPm2H8lWrMtRCLAnJPjFEHA8xpst81NrLYxZr?=
 =?us-ascii?Q?H5Np6Ld/7b3xIh3uVDKL9WZ+tZolygd7cWzkdi8pF9loAqCHISCf7YIOYWO7?=
 =?us-ascii?Q?Vso6FHvRKeXyt2CfhtbHNNqdX0KWeg0hJHUxVeXrq6wcyR74R0fqIv47VvrG?=
 =?us-ascii?Q?Sm6WyZ47oT6+8GrKVSWL2soezWamv1HXjLfC6GAiKjex8DXSMPV48zWhzfMZ?=
 =?us-ascii?Q?gxRFqAD0VqimWyXsPOQyxNG1i2BGqYg12NVPze6MAEY8+nI8OZxy5noBi2z5?=
 =?us-ascii?Q?xMzYYMyfZXtAZUOi6eTz4su1OZLOvHulnHG+/xR+iA/xzobXsQo5IqZpbOHX?=
 =?us-ascii?Q?072bOy0OLPyBprV/Pxu+3Dk7cWCjN71etoD0PZHXdFnzEkkPbrdBQaIisqW+?=
 =?us-ascii?Q?jmZcvqEycsm9CPg1WLSHV90dqxxR/2C6N5TMZ+cffvPK+mt38dCdFrd/zQJh?=
 =?us-ascii?Q?ZILWe+91p4MW2K18MP9WAyS2C0ZpVucbsEs4KS9w22fG7l79O29LcJQoo1Z+?=
 =?us-ascii?Q?w8JZ4uKgQUt/l0hOAAz6T7ima6JXAj8WUWuWdCc5s7TXidl+vFAE5xoiE7WK?=
 =?us-ascii?Q?aJ5dRWaIkw207B+EgaPDomy9GwisB1epsLpDnpjrlBYX8n9DyRbAkp7ddbzr?=
 =?us-ascii?Q?Sqx1pdJ41SKAovnHoGph3B61I3DbOX2q3d+MxAFC0xmFmriH0u/k24WSh9rz?=
 =?us-ascii?Q?RcHdGOhkRy/KeAMhUy0/AthJDEMrMn7nVK4QYHuFz80hV5iJE5Hk/iIu8rPZ?=
 =?us-ascii?Q?yhvQp6GA6L5NhK723CrISFGW8vWBRYrAflwDYWikeorYTy+tJsLNEOy51baU?=
 =?us-ascii?Q?7eN7dVBLKKLt2e6omCV83f25G2vYPkp25PLRZuO4VoQBQQz7F6P75swfB2iM?=
 =?us-ascii?Q?pNqdYCWYRkLK6xhKzl5MbKXU5HPXFC0jGFO1BHvhXR7N6TZALuhToxEPVEza?=
 =?us-ascii?Q?6FCpJPKpkVZ/XorsDs0yeJ9n1r87HBnFHEf3VZYt0EAryS6nWEM5T4P8//5r?=
 =?us-ascii?Q?c7Guq2Vadw7Q/VKyzJTePKSi/KFBGfOzQKMsIJWpC4+viGYhnIRCTQhrDegY?=
 =?us-ascii?Q?80ua4HUG5+zK+Es0jPvKzh91JIoKXWGrSGZH6gCM3KQvNpZOHpm0CpA9IHS7?=
 =?us-ascii?Q?PzpoBApY7576/aPcXGBu3BYeBZFNs42BTIRb1fNtvDaZtpfgsSHspDxshMg8?=
 =?us-ascii?Q?un2VQ6flWQb2wiTlxNYSa5JHGixBT0rpf4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1286;6:fNjMtGDAI0+SL0NXb3yy+NP/r7P2YOO8QuhDsGRy9xKvAk5Q/HCleC5no64CcUlXg4xDyzhjXSOY5SepJc67OSmQ0pyldf7D7bB++ApiwVxOHagCTaJq/rcAMEIXicP3KpDOPS8kTnLPETzJZMvkjvBqrYMB9MXszBJSccgnIdrtM0W2yK5UXQ3FQMxko9tnf9VgrQG/FVrb75aKrsEJaE8kkzwayhhK0SDwzd9rjKxRJtcOTWVNxhMKUspEmO3cCT/Bip0D4ZcZPREPplQmmJo+uHwidDg42dX67na8J3M/tzo2Kb2TosEXM3K1s+SME5yOoV12bjWua/spbeaK7w==;5:gg19PYYAZPetc4P/5ZXQoC9rNyaCj/C/hL/7NlC6wnbgcuuJ/tsVhrn6VVWrYkyCY9R9JWGC+b7c/BwQQYCmiKDZ9vWbphgZBiqDEwOEXp+DH/c2ixrm4+zu/q8X4NKFqt0+avd7Slo4n98+iedNVQ==;24:aKjftAHOTdNSZZ75MVYKFg6/jvtRcgvG5Ji9R8DPSNKpv2oBTjybROEda+xjWGT2FtI39pe+3/JpSSpGIdutSEoHCOLVa4HLZuAhUv+WVwM=;7:5yPT8G/vFg9uUH2Lj/D+Y1DTBe7liRUcV9rOgWv5y64w8en0nr7VzviDpkWyZsu59GzRcibDmWFvFEBQeXTvtHrKLpfH0IvvI5152Obj9AfnpH1vOyC//4B1iMOu4Ke3MFjZbfqHnV7mv6jYPtOQIoHmXwAOYhppEpTtexYKpMcEzJvRdW6RKZZRk19cf5VHKg7toYjVS8HZO73vEuqGzEsDoZVBBw+R7WqoCCK6yR8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: list.nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2017 17:48:49.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e253e-99f9-4477-a30e-08d51719a7b8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1286
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Push options need to be given explicitly, via the command line as "git
push --push-option <option>".  Add the config option push.pushOption,
which is a multi-valued option, containing push options that are sent
by default.

When push options are set in the lower-priority configulation file
(e.g. /etc/gitconfig, or $HOME/.gitconfig), they can be unset later in
the more specific repository config by the empty string.

Add tests and update documentation as well.

Signed-off-by: Marius Paliga <marius.paliga@gmail.com>
---
 Documentation/git-push.txt |  3 ++
 builtin/push.c             | 26 +++++++++++++---
 t/t5545-push-options.sh    | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..aa78057dc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -161,6 +161,9 @@ already exists on the remote side.
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
 	must not contain a NUL or LF character.
+	When no `--push-option <option>` is given from the command
+	line, the values of configuration variable `push.pushOption`
+	are used instead.
 
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
diff --git a/builtin/push.c b/builtin/push.c
index 2ac810422..1c28427d8 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -32,6 +32,8 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static struct string_list push_options_config = STRING_LIST_INIT_DUP;
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -503,6 +505,15 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		int val = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
 		recurse_submodules = val;
+	} else if (!strcmp(k, "push.pushoption")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else
+			if (!*v)
+				string_list_clear(&push_options_config, 0);
+			else
+				string_list_append(&push_options_config, v);
+		return 0;
 	}
 
 	return git_default_config(k, v, NULL);
@@ -515,7 +526,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
-	struct string_list push_options = STRING_LIST_INIT_DUP;
+	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
+	struct string_list *push_options;
 	const struct string_list_item *item;
 
 	struct option options[] = {
@@ -551,7 +563,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
-		OPT_STRING_LIST('o', "push-option", &push_options, N_("server-specific"), N_("option to transmit")),
+		OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("server-specific"), N_("option to transmit")),
 		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 				TRANSPORT_FAMILY_IPV4),
 		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -562,6 +574,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	push_options = (push_options_cmdline.nr
+		? &push_options_cmdline
+		: &push_options_config);
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
@@ -584,12 +599,13 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	for_each_string_list_item(item, &push_options)
+	for_each_string_list_item(item, push_options)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(repo, flags, &push_options);
-	string_list_clear(&push_options, 0);
+	rc = do_push(repo, flags, push_options);
+	string_list_clear(&push_options_cmdline, 0);
+	string_list_clear(&push_options_config, 0);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 90a4b0d2f..463783789 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -140,6 +140,83 @@ test_expect_success 'push options and submodules' '
 	test_cmp expect parent_upstream/.git/hooks/post-receive.push_options
 '
 
+test_expect_success 'default push option' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git -c push.pushOption=default push up master
+	) &&
+	test_refs master master &&
+	echo "default" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'two default push options' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git -c push.pushOption=default1 -c push.pushOption=default2 push up master
+	) &&
+	test_refs master master &&
+	printf "default1\ndefault2\n" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'push option from command line overrides from-config push option' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git -c push.pushOption=default push --push-option=manual up master
+	) &&
+	test_refs master master &&
+	echo "manual" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'empty value of push.pushOption in config clears the list' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git -c push.pushOption=default1 -c push.pushOption= -c push.pushOption=default2 push up master
+	) &&
+	test_refs master master &&
+	echo "default2" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'invalid push option in config' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions true &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		test_must_fail git -c push.pushOption push up master
+	) &&
+	test_refs master HEAD@{1}
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.14.1

