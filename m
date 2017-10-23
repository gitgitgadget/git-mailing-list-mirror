Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772151FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 11:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbdJWLqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 07:46:18 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com ([40.107.3.91]:27149
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751593AbdJWLqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 07:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VbHSi0jmor7ElaydTkVhXiE9T0kytAFEU5l/iruo41I=;
 b=MPC8ClxlxCTQcJ3NCW3YdrBRs+2HcXnuWSnsgdKhuDt1/9PrZEwoFKf7Ppt444eIV9NqGxvZRg/Ia83H9YKdn8heZ2hgFWgJDHFTNT2KG2GyGv+3JFyuynCyqFMJMhpklHarMgGvcke7ZgQWlpC+eVhNATOXana4q3elNEqPVDg=
Received: from HE1PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:7:67::34) by
 AM5PR0701MB2962.eurprd07.prod.outlook.com (2603:10a6:203:48::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.178.3; Mon, 23
 Oct 2017 11:46:14 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by HE1PR07CA0024.outlook.office365.com
 (2603:10a6:7:67::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.178.3 via Frontend
 Transport; Mon, 23 Oct 2017 11:46:14 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=list.nokia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of list.nokia.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.156.4 via Frontend Transport; Mon, 23 Oct 2017 11:46:13 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v9NBj2Gr024651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2017 14:45:02 +0300
Received: from storageserver.lab.sk.alcatel-lucent.com ([135.243.195.245])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id v9NBj1hC024535;
        Mon, 23 Oct 2017 14:45:01 +0300
X-HPESVCS-Source-Ip: 135.243.195.245
Received: from skbrao195060.lab.sk.alcatel-lucent.com (skbrao195060.lab.sk.alcatel-lucent.com [135.243.195.60])
        by storageserver.lab.sk.alcatel-lucent.com (Postfix) with ESMTP id 3207E2C01F4;
        Mon, 23 Oct 2017 13:45:02 +0200 (CEST)
Received: by skbrao195060.lab.sk.alcatel-lucent.com (Postfix, from userid 500)
        id 887CE280C5B; Mon, 23 Oct 2017 13:45:01 +0200 (CEST)
From:   Marius Paliga <marius.paliga@gmail.com>
To:     <gitster@pobox.com>
CC:     <christian.couder@gmail.com>, <git@vger.kernel.org>,
        <marius.paliga@gmail.com>, <peff@peff.net>, <sbeller@google.com>,
        <thais.dinizbraz@gmail.com>
Subject: [PATCH] builtin/push.c: add push.pushOption config
Date:   Mon, 23 Oct 2017 13:44:49 +0200
Message-ID: <20171023114449.11902-1-marius.paliga@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <xmqqfuadgtcu.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuadgtcu.fsf@gitster.mtv.corp.google.com>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(2980300002)(438002)(189002)(199003)(316002)(33646002)(551934003)(48376002)(50466002)(61266001)(47776003)(73392002)(8936002)(106002)(478600001)(68736007)(1076002)(81156014)(6266002)(53936002)(2351001)(4326008)(39060400002)(22756006)(42186006)(103686004)(76482006)(356003)(26826003)(8676002)(81166006)(54906003)(106466001)(16586007)(90966002)(50226002)(5660300001)(305945005)(6666003)(82202002)(81442002)(2906002)(36756003)(55446002)(189998001)(76176999)(6250500002)(50986999)(46386002)(5003940100001)(45336002)(87572001)(97736004)(8656005)(52956003)(8656005)(42882006)(6916009)(575784001)(2950100002)(45356006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0701MB2962;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;MX:1;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT047;1:nmLRZ/wfPdG1lrSP5hybcAcoOMvqaXy27ejEOtbSLUWEcsNJ5uz2opOkSDcyEiPs47pYqEUIQGtFIQo1Uvx7FDphCskhR87FgQRXIXQTAKkqPoXvZNmztx328xBes1O9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a0584f-28c2-42c7-c5c2-08d51a0ba9d1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603199);SRVR:AM5PR0701MB2962;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2962;3:NO4ej1T9XpC/2P8KpW7ldNx30zkPXk2errFuNdXMAP0H7nxv4tH7GK7riqGf8GcgvQIdEdcQvj89KjxvTClChb+LvGJBrkvbpBqKqo/57t94HAyc9saO6MrfX+dLFHfmZ/C6PAgX1uRAn59XIFIyogbPM7GRiE7ZnlmQvL+b1bGjJRkjXM3VPfbLIoV+AQEy+ijhiu/lVSiQEo8f5Gxm3lIElZoU2UcreTEC7/1lFG50Z28HFbTDXu9PDNV8IyRAfgsArMLInaWG978yz2EbjOUCGMoIcDPXdgoFXrNzrmLqbIjyxE27dbMEqMUxkMcEeid1IAHrVCyeh/RVL3pXkj+FNKRVo/wO1+DnRRreU/g=;25:OFDrDs77RTs/6jUlNo4MPK7rf+peGYFx9aFXLLDjGAgYb3uPM2261p/bmN+bi/HiAxDwNUFH1qUqBODWs+0b1eQY3DVaXXgxnvZ8oAFY0ySvO65Gu8a9WXcJk7wwzKKox0SO4qE2P4wiJbDDSt8mQcRW+hBG4inW7cFNjSli+V+rzYqVp/KbUfq8bCpHszgB7pYTlDZpvQJ8xeLdVn4wxHfv8DU37hA+zegQr6NOregEA7Veb01ZNLbKHvauN1aUonZsPMhX5gTraXEJeg+HLn7h8paMa8rjvTXxq97v3Ltg/USqb1xU+RVQ+ET5cV5PU/m68BVCkBokylHFf1IsC/QvOapg6/kQrKhuWZbAN9o=
X-MS-TrafficTypeDiagnostic: AM5PR0701MB2962:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2962;31:rZEbrOvAgv79wHZvLUI6hE+vs2yoQbgbldXSR5tiMdMoC1gZDtGtnvXoK8ik5LOeL0sG4AyiTogpsWzZ9ei8jg5SNV1kh35zagShgV/AetxrDxZr2IWgc9r8BIk1Yn/KKm3HB62OIE6OU0wIBDGivs10ZQsxhRMgGkF1GzoBCXRjNvPVMAsHZMWnVDfG4GRIwhouqK275KANX53SlqVag/T6YrtDgb3t0OcliAJGtdM=;20:bjSsBoJeSv5YNqYVBbV78tfLoLcBewHeg91p01qJzpbOMB0N5OP22RioUi+AZ2kmsOnOX6e1PHOzZV0l/nYb7H8gaBsu15tjNgVssNUyTjzVdtc+vobko7H4NJCRsJovSL/oVYUOW9FTbTQmvVArQyGr4+Pz8I38GdhjxBvSVQCrbH/bqMleRZeNlYsIU/A2+7x23gOyX38fqOe0V5glL0lOcSRl3dOqkTjd+lmdZf8TfLtahV81g15Dr09WiD9O9Ge5E4DwEnB5ZE8PoXk/G9McgPDq3gJYj/lg97aiNxxaZrCzttY65JVWw71QT7zRrTcw8jutx0KT5pXbYJGTTBV45T5/8bHdYCN1GC56TnSx63+ZJOd8BIz5O3dC23EqTArc7zCsXpQIEYXjoJZtzR4VqTCWLD5IrcwMGNJkmbyg/1hBtFBWoJGH+VmsqCrNk7lePaP1CywGVl6WAV9vKau40o7EHytcXcab2HaXT0BtZe7iydH+dKf9UkmI2OXJyM14/d7RX3zA8OQC/u+6CN3HRmAdwdksZO/ztIfilPt3BVdlVk+UEbq50TP5Nue9W7/BtvgYxmdrGaztin+T+3AO7YTWEwfez8B4sSC8Xo4=
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-Microsoft-Antispam-PRVS: <AM5PR0701MB29624F9F005C4DBB5975D41F97460@AM5PR0701MB2962.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93004095)(100000703101)(100105400095)(3231020)(3002001)(10201501046)(6055026)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123560025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:AM5PR0701MB2962;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:AM5PR0701MB2962;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2962;4:UZjajNYVglblcjlFIxIm4swUVgse/4dOjvMX1HWTjANggZq3EUZkVdsa1LGb16LFi2AEwLamZLkUIT6KJJ2WrsP7DmJ39elahNT+EEvtujUVStWlit0F+Gzj1ThQzHgIdWoeB7BMv7T/PMTbA+9yMXR05B0Cng4ViknMskbQCyapvvDsiiZFOt1syzqTd8B5A3zQ1WXlVuKcHha+FRi5ka2ByblfrsRv01VONgh9x67QPClu6V+pXY0FP4YQOOAgi5G14uXAHnkOqC237BB36hlnaBCBLt5h9DeKjC51SiLj/U276uVFuzgHBs3HMWXz
X-Forefront-PRVS: 046985391D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0701MB2962;23:coDDu5HA/qq+a4lV+20q19VBKRBTrKaCh3/otNp?=
 =?us-ascii?Q?ltVOqv2cy3B8usOWUqAX8MsvKu364xHABj8X9dt/fIguzc7HVZsquRb31laR?=
 =?us-ascii?Q?FgQYG0MypYQOnG6aFWKtk+UMrn0FZgVzJ03idQ9nJPCWv8ZAUbwjCMmpRXGU?=
 =?us-ascii?Q?RuQ/Vki5FvXSn0a76X1jvjmE9iyjHL8t7A4QHc5S+PUw5qprB05fG139pbId?=
 =?us-ascii?Q?uUWRoVG4/uR5T2lMEq4aBpAwHn4xXHFTmU1WwAFmrOg2l7UVQXK8O4ma7zGi?=
 =?us-ascii?Q?KFR8O2eL24N4VzwHl0kmloAkpN0CD+G2XzGyI+EUr31iINrpdPlSCYFjJvTo?=
 =?us-ascii?Q?twHmz8RYOdHegdx5K4sij3lf4qGikNGzD7rclPwCEOLJ1pK664huVcj5zi7J?=
 =?us-ascii?Q?zwLiBGwG39x0/pXS7JzgEqxo630KVcdX5h/6pWFSjMnoouySayoxLhjtnAOR?=
 =?us-ascii?Q?vrOPh01tGlBH6PwN6WPkFA19JaAL4BXZx4iLqs2hGYoMkEsFgNO2kJLEfrM2?=
 =?us-ascii?Q?KlBiKIve+7uc7lPecAQ1jYxU4scaYWWaDLKUQ6TMXbO5snJClORHIOyp+QFz?=
 =?us-ascii?Q?3hQSXvDV+Hm0AztT7zwRg/bcI49AD7AnxW8IKLlzMSTH7xZR2HrvLYTV6s69?=
 =?us-ascii?Q?FZvVPdHZVDwJS3OcGQOd4mjX29YUOtgWb0P3vPckHPRza7leXGPXlzNjYjpG?=
 =?us-ascii?Q?mJJ8KKY3VoEdX4+TAPXYtSV9pLWctfXJ0FBJXjmGimF0qwUXEgXJ8xicM8QY?=
 =?us-ascii?Q?iw7V1UK2eVv/aLMqrgTcNMjhCItCttAi3/kIDT5aSCJlr7uB4fIQJ8VGHYLK?=
 =?us-ascii?Q?eR90zc6DjoKCqui1TgjKXRimltioyOJ9jqnKCOEdPPg/AL69PIz535QVHtAM?=
 =?us-ascii?Q?ZBZWqVoMkrbrB2+3YR983xs3e6UeP2t8Xwdzt3XY+EC9YIMSDKc7kNB7/l9Y?=
 =?us-ascii?Q?nu1s/vzZ0AFBDtrp66kFke4q0JxD7WmCft58YCqMQVbLTAcxqC+k4+1+Znje?=
 =?us-ascii?Q?TCSRLWYSwrMKl3y2czdoKHh0W24T+lZatVu2HBNCv6Q1MYyI+HrfHypGoNUY?=
 =?us-ascii?Q?2yvGe5sYYh47i6Q2FtgOQYXD8I8tYPsj4CxwilFBB5vRnxN8MGoK5fZa+z/8?=
 =?us-ascii?Q?6S+FNFN68i1HqErLwRzDGFzWjj3ejx1qBEPkQENI10XqvnSiUNIOZ39Vgc8L?=
 =?us-ascii?Q?WQJLZZqtzD4pgZaU0dHRaXu7YMde0winGwGhEhvWfhalD1YIIHV6KxzOmFFu?=
 =?us-ascii?Q?dbU7SXpqEU+C2ksWZipS4li++BVQxACZ8MH9TRldHjQA5U2edvIbCChdOYb9?=
 =?us-ascii?Q?TDiIs3IMhyoPqEvXA3X//brABqYraCEtm0gj88zwI5GVtFIYMau3YzRCHidz?=
 =?us-ascii?Q?r441mxGGY2XaZRxNWuSeWzOo6LbeoY2LLoCG/ToquOozjXtwf5pvtZzrhHXP?=
 =?us-ascii?Q?GF6pNLYy3mYq3sgpuTPx6Eae9HwJokVRMdiz7l9XnXT0dO708o9ZnlnNbzky?=
 =?us-ascii?Q?lucCvDPSdG0kbritGhfhPSMd4vItmQgVE/no=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0701MB2962;6:ybqou+BRcfBVOaV2MqAA/M3MvzZebCJK6+QIYsuhl9s7jg3AD2yj9+QilIYjixuHF7dT8+QBbyMTgOujLoJqTNOoUokrK8ppmkEI487Sa3C4CG5KVTGQtz1TGPgKM0FQp9x+KOzZEaZi6LvZO9zrsuJidhQGnl5xNX0OiyICte9IAWjF1goHF7NGaBW4Y6m4ryqatpoTUzimasiLOlSIEAUZ5oj1RfpR5TkMDeMZPq7RnrCIZwrUBQsrOcKN92DeViExPhmvQmfnCz5YFslIE7yekIEiGjxy5H6l92zolARfqbwn9fcsWmvsROAU5RPYgNx5WWD/EZ23jB/mIv5CIQEELulwgSlkWEzqfSsC/EU=;5:bVr3KMFvOj9jE1GUOYbXlwqJYiDnzQKN3Fe6A9NQyarFY+131hbv9hQJJ51vQkajo2sXRG4KAA8EB4oy1eFAV3xgYu5qAqb3GJGRF2zlLSdFbcfypzvidkjccXpZ3SceHlVyV1NW0kY5jf0QRohhjLUMzMNHDZ74SI2zzeA+y+Y=;24:MJkvEDtEWOPvaPJHcKKuMM4kNye81ahka05PUYf3+8j1m9wqGKe7fTdWcBASlnk+xFYy0nD00vthSbOgKBN97sWKOXsjiaxiPaBxmQij064=;7:pZCg5lq6hIe7kvuxInQQXcZqCmx0C0aX68MilC4bmIaXgJbT55PBPiaE3Znzp7HyzaLi92tKDH4Puk+Vg27WQXXZ97Ia/aBatXpU/MnjM3eQWWEVfG2Aa6g3PgMSqTakC3QPEpcj0zcXfHKENovpInZ5Y4vTqRP9TepU6RQb5ssWIbxqNcOhzQsVjKsdCEKhy2vzQfeEQJkx9Inaj9UP5Bld+Fedb9bzGMrLIcZCB9KwvndIYt6nc/LY5UcmiGfg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: list.nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2017 11:46:13.6352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a0584f-28c2-42c7-c5c2-08d51a0ba9d1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0701MB2962
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
 Documentation/config.txt   | 29 +++++++++++++++++
 Documentation/git-push.txt | 10 ++++--
 builtin/push.c             | 26 +++++++++++++---
 t/t5545-push-options.sh    | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6ad..0bd46a6ab 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2621,6 +2621,35 @@ push.gpgSign::
 	override a value from a lower-priority config file. An explicit
 	command-line flag always overrides this config option.
 
+push.pushOption::
+	When no `--push-option=<option>` argument is given from the
+	command line, `git push` behaves as if each <value> of
+	this variable is given as `--push-option=<value>`.
++
+This is a multi-valued variable, and an empty value can be used in a
+higher priority cofiguration file (e.g. `.git/config` in a
+repository) to clear the values inherited from a lower priority
+configuration files (e.g. `$HOME/.gitconfig`).
++
+--
+
+Example:
+
+/etc/gitconfig
+  push.pushoption = a
+  push.pushoption = b
+
+~/.gitconfig
+  push.pushoption = c
+
+repo/.git/config
+  push.pushoption =
+  push.pushoption = b
+
+This will result in only b (a and c are cleared).
+
+--
+
 push.recurseSubmodules::
 	Make sure all submodule commits used by the revisions to be pushed
 	are available on a remote-tracking branch. If the value is 'check'
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3e76e99f3..5b08302fc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -156,11 +156,17 @@ already exists on the remote side.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
--o::
---push-option::
+-o <option>::
+--push-option=<option>::
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
 	must not contain a NUL or LF character.
+	When multiple `--push-option=<option>` are given, they are
+	all sent to the other side in the order listed on the
+	command line.
+	When no `--push-option=<option>` is given from the command
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

