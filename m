Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFBDF1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeCIRhC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:37:02 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932478AbeCIRhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=zsYt24Pah2DfLj1Aga+8xVRHSLz1wERlB0w7s/LUHZw=;
 b=Yh1pAYfjiwtmKgB5Y+701plaxwskqfawhc7QkjpS5hE8GQTHMWe3Bej/hxW0VlKpqMxenF9lfFb9sxQ44/ELltBIaWuYQMA5J6e3ykKToKboL2N4yD8zdOmfUwkl/6IrhDkf6IxbOrBkGrm0GS79TtUBaJnG/f4nvkMnOLLvnqE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:36:18 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 08/10] convert: advise canonical UTF encoding names
Date:   Fri,  9 Mar 2018 18:35:34 +0100
Message-Id: <20180309173536.62012-9-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309173536.62012-1-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce4cf775-aab3-4b88-c35c-08d585e44583
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:CWf9mvVFOo3NnEr+fGZ9yCFd8Z1amANRGiNXebgRj2rHwVUkk/T+49RJorwM1qgZ9FVyWk8UrA5TKDQDC9gjFtTYhOxGSIsYdF8mkC5xDi8Z5Jl7AgSWUo7TwXviEgg1SuFJdud/uY1jXwkbEpOdJ8EXcW9ckbGe5jGSlpDrXtIkVsubWfPuY32sEyQXOgf4FcwdyKHwOqLeLd9DTJookpoqmYHLbRoG91OCUlyEYaNKt7OZN0kTdS7O0ibrIPoF;25:F+lreHFoEE6TveyrMTfztGPith7LecF0gGEOQPoDPi18aqdEQeWFUbhGIKe25tbwBR+2IZgW9hqtzgbWOA3bxVKP6ANjHQaY4MD43db7CcF+G9ASBWq1ZW019XJ8RCkvWPN4WmzmbqFw5ATVBROPHZfoyfLl+03utju5XreAHlpukRjpPgsMe2eeaUZDFturwou0jW4S309xWIRfOg+dPeh90nlM8i3q5i591sVI/uomrmBYOYTBLoCgWAqR/hzpqjghJTGjsGc1NDQJhgWN9JXFT5ba+ly1jOZoZSoCS+BDiJVbCzMwTa3JOvjYxh4vLol5vUrqjYtT0Ru9k3sG4g==;31:7PBg7YareDgmdDeNbfU6uJ7wlKcrylktFCmhCzQQVgHvRTihkFRRTP2e4y5Wn8ZFpUFytebe0DlubAm0N4E6sXuhBOQsF5WIq6iq8e3KEJ6Z97/VVjkI2fKfguHv2/au1uG70nlVPmFfWCXcrAktaQcEEtYNkHV64euJBkNP0C9ciph0D+uJQDqn9tR0LqBRhnFW6rYhYvbJKCcX0SSYDdYcNB4EwsQdt8FxEKxMT4w=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:O1PIRoza+0a9v3hMm8OD+PkQUomrKF3ih4HsNPbqKl9fNFD0Q8lzEAsrVRPETagDSyUnCPiJGw9r4ytPYcLes3f8Nr0VxWGkK6mSv77oLuEQ5QKA9SXacmphsqZ9XD/nC07AkuIEhW5oW6pRxqqYnEQPoCqPKKRtQc0Vb/rWyKDLEbno1CYyqt/Y0elwkT3VEYw1HWTSurlI4GBBnXhZosO4v2i2mll3wdNWecrapuhe7V1v4my8uQjxQjD7XWRanN5iak6+2UJ2EVXTYuBDxnPgfAFkUrIY6F0Q0Wrv62hf4efSWInnLalX5J+vkZNwC0WLnthsgLxcPDYIjbwL64DNmRDWkpJfycmetELIhiGrsE0xeBwqpefp7UdgRF331TrGJs14KNMRPsR4lwLq2rpefKptgXwyOdJbrB7tLFzpi5SDjVLO+gMjCZrgu3ni2kebz8c761r965ONTgmIwzw86zHhIyUCLFP1B2JKMCfSbaZwKk2ll/ULehbzHlI1RuIDxy1DM79AuDfqeNwZ7mG0XTJLsRBlridFIOOC71x7JdtxsOHcbEbTOW2IUPLwxvwhLyEJHD2Uy47ym5xoG4yXMFl9kBlLYVUxjVwWd+Y=;4:8AHR3O0bBCys/uyYSQ0WXWGPTX9IRfQ0bhbxAiYfV1w/Ibr7txd4ZVroQeYB7ziIfq0Jiu2Pisvif2WN0SXPrOWtXtLMiV1Ypp7MGbxiga8/MpyVg1CTpz/eOztSnZGzNb+sCm0N1861t2EjT66OltmFv783XsCeFqZ/HJrubvyN14zxzAKdSgzhzxH/sDN2Bj5MxjPw/aJ5GpPhgkW/UGEcP7VKVygD+BfkpvzEabUzXdiQd8fQqFLNXWPWS8iMtZLqOmgkMqRuQsDdc435Gdf0p6cvL8TTdQsCLs9rhzhe1h2a20pL4ItWf3nKYs1Y
X-Microsoft-Antispam-PRVS: <MWHP136MB001577FF32913A4C5CEE4AB7E8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(50226002)(76176011)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(26005)(3846002)(85782001)(316002)(9686003)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(2950100002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:o5G5CBRbipPCrMO3bFWjn5hQnnxLS1pQs1n0Dp0SR?=
 =?us-ascii?Q?OYVueY8401gwnKJbTPz7NX7nSlM0X84RkY8ssAu4Nn+LVsBY9mspS5hF6zH4?=
 =?us-ascii?Q?dW3hMCJwFnlLpEshQfP0KvZzu9gfb8wULfPoMgGS9ReJdBj6HvohDp6JMOe0?=
 =?us-ascii?Q?FDLNfsMyD8isKVzw6M3cH707j4AuMXUMGnCvIJJKA83Me0J6gqNctrruVEmp?=
 =?us-ascii?Q?qKbYBtrSlIWELvEnYm5z/MfrS3pFXhSsQwjiMJWNUJuLLpslgB28bejcxxGS?=
 =?us-ascii?Q?vtVoUoCOA7PaYIslIxj+FkwDhSW3rzqxQiKPQ+PH4dbtuedXRc7CTr0foj2o?=
 =?us-ascii?Q?HsFwIoREm3KGoFZzurmd24ZKtY8G058QmP4HfkJBOuKXgLgT/oSGri0djTIL?=
 =?us-ascii?Q?wJMakKPnL3nZH4Y+n8hS0Yr5MuDZYHUsIqZ4OpLLJSfW4gFZMWvcC3jyivCh?=
 =?us-ascii?Q?SkHwxEOOgrHJAe0gAKXg+0GsJsy1xAFuuCYiU2L5pUjJnCYH4aYkw6atz8NR?=
 =?us-ascii?Q?QyUvl+RD5cxS8R8z70DmVQjZLtpIcBI08HysdwqGbsLhb5dLGuF5wMTQIh+E?=
 =?us-ascii?Q?hWvxLrgCU4hwD3JTg0yriV0m72tLXpYoRWwkPhMT8Yo6Lk9lTzZY/hxyBpUK?=
 =?us-ascii?Q?zen02OLRjxyq8w8maTRd7UcoEJoQkkJLeB8LkVNd41ash9jkFQHSjbnnKcum?=
 =?us-ascii?Q?JHt8rNrqrGF8E5kjGhaUlnuv6K4P5lGtJZ0cHCSiDAWFdcFQEJN/4IjNYOHX?=
 =?us-ascii?Q?Kv8CY85ld4AICNIhwGNGmQBNI9fUkUn9CTdbSw9d18/lJJv4rvvwHwcFxRVb?=
 =?us-ascii?Q?eC4mGFnZ0RKGUEkdjqatIfmJhpEceZBK9SqpKGqKkxScDh04FlRvJFhTGXIF?=
 =?us-ascii?Q?V6fm+WyzsX85+smSNMFzAkDcYFgbOzv39Xh9n+kSa7teyrrQt1+rN34/Goqe?=
 =?us-ascii?Q?RMFbWf7ivxsYHObjs4/tnW8LI0IHcUcbfk28OiAlzcJBrMQ4CQfCJJ0E2zyh?=
 =?us-ascii?Q?T5MbRAStJoAKGbDRR+r3iXrjKBgk/o9WYSylo3SO9M6Zu+RsZQTCYduXuSso?=
 =?us-ascii?Q?0GgWyNuXZIA5t2PLgkZaqRe3ungER26AF/HjgVychpHCj++64Yl+oTuSFWQ3?=
 =?us-ascii?Q?7AHxPKh7fTHxh2mIIRzgQ5kXlakf4+/oZJhx/xHRArpPWK2lPm0lJmg8SajH?=
 =?us-ascii?Q?ZaRtZjlQA2Mgvuvk4rxQp2Y8e+/8xYq5UNGPRot5N4Nnpy4v7bFlzud9JbTh?=
 =?us-ascii?Q?Wn4nspQ+HTmqToQXJL0C25Bh4tZyFi4GE3lc9MyJ7G7Fr1U1N/rc4ViqqLi7?=
 =?us-ascii?Q?xl2GVnHJI8MBC5m3SMcT14=3D?=
X-Microsoft-Antispam-Message-Info: I335THL1VL3JKrQ+MT0GRtZVcg0rLOj70FO77gFlj/28C0mOqUKHhTeNShhYk404hm3wNx3PN6e1KkU364YtnIuNJmPhcp6AemuSIdCFi/AwTdXADB2plRoj1YwQdACCtu+IHN9wxieMejzFML4wJwsWJ7suN6lWtj1oIFpbiLUF34K+OjvaL8M3vJHufgD4
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:rquFjyPV4XyRnKciDxvJOED/Lb0THtxRAg2RiHYccV+BEcov2mEQN7I0tU8OOj/FBfI1KwsY522dffM3+Qt0yIoKd+f89IroUP3kcn752JcCMFNCouuPKUTCVDUyfPqgIWBt/RcoHM4yVu7MLZSevhvdo4B9wimUja+vybL6J3JDVv1gbBrhbh0A8Cx96r09SrRSXER1nlIt3hdtFKX19zudCpS4bRHdCfCzxkjgkDKbpfepdgQKH5RaTVtsbqmkmaOi+nGsCn4dcVB9xUTB5n/WB7U3pJprNn5MFimtMc+lXEgAkS5/qurTSZJnY5ZgezK4ZqQ2hxp4s00veYkekVOm47PMJPWE6NT2vQGCgww=;5:Bnb3ZEBXi5cwVNt9mvXp7f9jWinmFJEgD6fZWd0bErgwKebnbTKgFQU8cMFZt882SyYiB/U9qMS4U75ZdOwWMYNGT95hvoni30iPwNRDbD7o+3wUfd5W8dwBS7OuSp29sXg4TDS7DLM9ln+6cs5JTTeMJ1AMwVLzFvVwU2Hv4X0=;24:PK88zWCYS131kXKAuzNjrXJSPa40PVvEIh2Jnr21O1mHXCYH+bqlNRQCJ55IJ8sNPy1LKPiFzgV/5XfAEZ1b4glP2KGeMkSMMYs+SR9zoC8=;7:XLU4aQ8a+mLshTw9RkGcIMz4YHRFNPlT4kICBIEXyqUslvRMdvi6XqtShwNw5bwj2w03Olo6Od1f9Gp/EdI1WlIC9bffWknhXaegXfLV38+GnS1QZvHMgHPgNuCXPbqaAadn0UO7VK1qNVaS7ugV/g5o4CyAClXTNVJruv/6zl4Vu1/cbdCmTvnDKo+ZS7jw0TSnbBVeNZZAu5fjEjudKmKVdYcsTn/0ZFadnX/1Qfw442Ql8DXQ8exZESxLKXxj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:36:18.2625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4cf775-aab3-4b88-c35c-08d585e44583
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The canonical name of an UTF encoding has the format UTF, dash, number,
and an optionally byte order in upper case (e.g. UTF-8 or UTF-16BE).
Some iconv versions support alternative names without a dash or with
lower case characters.

To avoid problems between different iconv version always suggest the
canonical UTF names in advise messages.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c                        | 21 +++++++++++++++++----
 t/t0028-working-tree-encoding.sh | 10 ++++++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/convert.c b/convert.c
index b80d666a6b..9a3ae7cce1 100644
--- a/convert.c
+++ b/convert.c
@@ -279,12 +279,20 @@ static int validate_encoding(const char *path, const char *enc,
 				"BOM is prohibited in '%s' if encoded as %s");
 			/*
 			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
+			 * We cut off the last two characters of the encoding name
+			 # to generate the encoding name suitable for BOMs.
 			 */
 			const char *advise_msg = _(
 				"The file '%s' contains a byte order "
-				"mark (BOM). Please use %.6s as "
+				"mark (BOM). Please use UTF-%s as "
 				"working-tree-encoding.");
-			advise(advise_msg, path, enc);
+			const char *stripped = "";
+			char *upper = xstrdup_toupper(enc);
+			upper[strlen(upper)-2] = '\0';
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped);
+			free(upper);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
@@ -296,10 +304,15 @@ static int validate_encoding(const char *path, const char *enc,
 				"BOM is required in '%s' if encoded as %s");
 			const char *advise_msg = _(
 				"The file '%s' is missing a byte order "
-				"mark (BOM). Please use %sBE or %sLE "
+				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
 				"(depending on the byte order) as "
 				"working-tree-encoding.");
-			advise(advise_msg, path, enc, enc);
+			const char *stripped = "";
+			char *upper = xstrdup_toupper(enc);
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped, stripped);
+			free(upper);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index e8408dfe5c..1bee7b9f71 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -74,18 +74,22 @@ do
 		cp bebom.utf${i}be.raw bebom.utf${i}be &&
 		test_must_fail git add bebom.utf${i}be 2>err.out &&
 		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
 
 		cp lebom.utf${i}le.raw lebom.utf${i}be &&
 		test_must_fail git add lebom.utf${i}be 2>err.out &&
 		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
 
 		cp bebom.utf${i}be.raw bebom.utf${i}le &&
 		test_must_fail git add bebom.utf${i}le 2>err.out &&
 		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
 
 		cp lebom.utf${i}le.raw lebom.utf${i}le &&
 		test_must_fail git add lebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out
 	'
 
 	test_expect_success "check required UTF-${i} BOM" '
@@ -96,10 +100,12 @@ do
 		cp nobom.utf${i}be.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
 		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out &&
 
 		cp nobom.utf${i}le.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
-		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out
+		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out
 	'
 
 	test_expect_success "eol conversion for UTF-${i} encoded files on checkout" '
-- 
2.16.2

