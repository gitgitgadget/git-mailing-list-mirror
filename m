Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F281F404
	for <e@80x24.org>; Mon, 22 Jan 2018 18:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeAVSBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 13:01:10 -0500
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:26944
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751085AbeAVSBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 13:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WHGmMMTIgtoShaDVdT1Ig/txjHjhjPSliKPSWbxyvEo=;
 b=nErxSBZE6os5g2a5ZwVleBC5QtbUsMG3cd7AvgulVUH9Z4oTb99PioiPHTlYcJA//od+WgrQJehYh4/K38Fqq9whpR5H9jmtMSHIpslf9Cdm5cArRTLvoq2is8Fo7YES3G8MRok+U1jgIU2F20L4pJnCktNs2GLUwIn1Z8fTjdc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.428.21; Mon, 22 Jan 2018 18:01:05 +0000
From:   lars.schneider@autodesk.com
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        simon@ruderich.org, j6t@kdbg.org, larsxschneider@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        sunshine@sunshineco.com, tboegi@web.de
Subject: SQUASH convert: add tracing for 'working-tree-encoding' attribute
Date:   Mon, 22 Jan 2018 19:00:42 +0100
Message-Id: <20180122180042.70101-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180120152418.52859-6-lars.schneider@autodesk.com>
References: <20180120152418.52859-6-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM (10.166.227.152) To
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef2849d-1325-4cd3-0b37-08d561c21c02
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534125)(4602075)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:zJCnaeKtx397Haaq1yduQmULyjbgddLMRxUVKRqegz7OT6wz01zzg7bsZ/btJAnVDGzrT+M6E4qTX9HHBR+FYdHzBDLG4rMP9p0mgVrm3xHnaFsTpelWWzXSZs/jSSTeW85cR9hSyMYY6bbEhdEcUoONiQlbVKXLLy5fKm3VuIayjGrcIWgGKLRqlCZu8x/m6YaDTwFkFxUmqV1KoAI/ln3zVn+KqLadLFGD5OI8ULE+MM2nvPz917ajJs/Ru1jP;25:wDdI0S47WIQugRAbaI+RRgIcR+9Xn5XT78HQVlV2ys8+oNw31iJnGDt1wEvW92r+uQQtw3XsTmWiWV3RQg+5T0DQWmnaY3JXx4NxFFfAW8/53Y6bx+I4iU+/PvSdWr62QN80Q2E1SU07lwX6or4OTSaehCPYWQ35wHjrv53q5ozh5C7iR+J3FtNtiSV0PlmFKv5t7Q3+/Aum9kFv832stLAQooSpyd7iFCwlAfksBmT68EdojrCbJLs3D71ERciGE7ukbsmpVu+y2VIobdvqpWHfS0Niv9miwfFWEGqpMrt36W+R/ojxsYcovX+kXJVM9pugCRqHbxu/X9LK4RiJxQ==;31:CSTaqacB/E1Q2uwgJTSLWXLM3Mtz2CNR9FkdtRmsu3GXVRrdjwTd+Yh6RvDzLQY2huTOnIZ1+nyFfTZwfSV1byYUYatLyAnGVrMlUZJ2hfYYZu5YPZcBi7uMOFNi23JzM4wkid5MIl8UZiF56TPBxgBo5hxfbxnq5Ge4Sx4j8zP2LO5wtuYN9gCHRJJXvV+1Iv3J8rzKyX8v31i7YsMxbDzX1ELjPdAaMGOQE1PEcy4=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:xT3FkZvWhlEgtGvJWWnaQ2m2mmMsVNQh8wmNkHKDE//lpH2iYeOIpYdK+LGNqyUJj8465FfTjS7d9ejUDaQMQ55MJOG6+tpUJ13xDcf28dN/5axo2uYY/ngtfbHAoOl3IkItKDsn7AYMWPi0JBu7WJOgOGIeGSvF3qyl/IhihrbnKJ+jOvvN6oxHa9J29hK7A5362cCsVfm/vP4e9T1dKx10ZP+x5zeQFcIecM00Rohx2FDSBfdh+g4eNCdC9z0QC7K31wocXgOPLivcHb9+JjK4aSMTNsc7e9HRJL9e5iV5NR64Nc46fnTonfGAeZHb6QILUE28lK5o7MPXSHJzXptOGhLCf3gU3jIlJN8dOCjm32ms9HZTbP3Z9WQDmtt06oOptoSKYjcmAwSCIhg1l3nTBWndy3t7MdEj5KxdAOdmsTcZWsyN+dWj681P4eMPIRGWp84mygnrtSPLQ3l4EQyJpidBBmVQmBWg/ixFcNF/OtFVq08+cVsf2UybK0dSa01SSZxy3ibhGJH1+7VRk0YiOGXeTO72V1m66ITk3KxiZC7nenD4LdVsUTnly3/8okHsvm6iTFdnX3CPA5hPAuFJlJ1P+Xu/oMJVNNs947Y=
X-Microsoft-Antispam-PRVS: <BN6P136MB00172D9B3C6C8347B2A5A376E8EC0@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231023)(2400081)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;4:5hS9Y6mtAncFBSxU66yAuAcTRhfNhk31PnyFBQqO2YEmDchPgb0kr/FgVNR4kYteASRjAj91BLGlMjjY3yzzYz1KAVyNiGMyn6GJ4Mx0jvP55GeZU9JNe4ZgX7xBZsZItaRmPZLeGbwItXkwkqWy9PaulS6lYp//xLi+LQ3hgjBlbo4Uv/RikzpmdKYHkNmmDigq4YYwx8EDatMqUqrol8V48n8mCGz6iCaqYE4EIsDqH/LEqaq6rAgz2KgDws3WFSmLr5WOXVl7asJeRgItWZZm3FQ9/nDa2p5mj9K9Bv9r5v/ZY4PqwfKPjO6yLBM1dCyQ5i1CjGXc1X3i8Granbli+JDuP14G9HZ5GwgOZKk=
X-Forefront-PRVS: 0560A2214D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(39380400002)(396003)(199004)(189003)(4326008)(25786009)(47776003)(66066001)(6916009)(2950100002)(7736002)(85782001)(106356001)(478600001)(97736004)(86362001)(575784001)(5660300001)(36756003)(6666003)(2351001)(39060400002)(230783001)(26005)(3846002)(8936002)(6116002)(50226002)(81166006)(966005)(50466002)(8676002)(8656006)(81156014)(386003)(105586002)(16526018)(5890100001)(6486002)(305945005)(53936002)(7416002)(2906002)(316002)(16586007)(52116002)(48376002)(8666007)(1076002)(9686003)(6306002)(51416003)(2361001)(76176011)(7696005)(68736007)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:SFbjQZ3IDIOsLTa7GKkvPWIP9XcNTLmaVqa2WsJpU?=
 =?us-ascii?Q?ypkrW8YzE+tx4cAdg8Viw4zwPn6AM6G8V1f9k0za8Rlh/FZyJFrvnOrho7/p?=
 =?us-ascii?Q?vX/Ryo9JLSt6f5T8ZxO3x0mFvKJTxGcKzFEl0XC4Oiwqk/RohH0ZzFhrTdcj?=
 =?us-ascii?Q?GCrIZCCrOq+C13UzUL580sa8Mm+/PyDv4T6B/7Z/HZw8xfOcU+5Ox7qqtpdK?=
 =?us-ascii?Q?mvhpBExCky2paF3PvgvA7XE5KRnZuHs8jpdwO1hniwPD+Z+e9XnjyqrFr5Rd?=
 =?us-ascii?Q?Be+WL1Wss/oN83ZLEyf7/EGv5WU82qH+M3yLvQvuGLc75bPX5aQPfbMhAioi?=
 =?us-ascii?Q?9oAmWaHMlGF2jjEaD3I8eJEgfk2/Tg36ihjOsAOdWpJRDOd/8tZMXipWYUsc?=
 =?us-ascii?Q?myNAW04DehYl6Yzjgcbc+/iGzaI1x2Yui5OMEiZ3gghG7cmAPLOPpOotCpMF?=
 =?us-ascii?Q?5cgCJv9C+4mCa3PF/4YEcRsq/Zgg18tdsKe1+pjDAYmJd2vNLJCJMdVmXLPV?=
 =?us-ascii?Q?ssb8MJy1oewbJCVNj/HKckxa2JwWOt4DPZ1pLUrFfibqGaDQT5gUnuDpr2BY?=
 =?us-ascii?Q?toCq+1JoMeEtXHC5odeGlbyfyQccQzHkEEa0P1EvewplV5p5bGdQAueIDH1n?=
 =?us-ascii?Q?547D0BCs4Hoa7IOVDx+DixtybjS0kBZ988sd/+nvoiIDWJZtKxVBI0IDWik2?=
 =?us-ascii?Q?jTm+mZIa+iyh6wX06H6fTpQKTx76wZ36+/5PRqH+Tc9iXHgPkoRHx6QerN6J?=
 =?us-ascii?Q?1OlLKQx9QWWDWm49hFtfLPSaEPb5Y7eSomAkDbDKL2OqrsZhE2RFD91hUuNu?=
 =?us-ascii?Q?dhqZj8DCeZeJEzHLElFFKB4g0NRFLWUBcH8aeUAUXZ47qLQ81gPR+qzbDcgx?=
 =?us-ascii?Q?IgbShHxtZamDUFis6tfU8PYRf6vnnYwQDxuYnl5GGHfqQH6B221WrpDjR3E7?=
 =?us-ascii?Q?PsYCWa9oHhF9SEmCmXNkPVJuJ0N16a2yXci9TrAqPnGK0y9R5dplq86oqYXH?=
 =?us-ascii?Q?fsVu44jIjxRp9g/11IsJ2Jrhr5D44Y5th9ylUwHxqA0lC852qU1YcOThS9Dc?=
 =?us-ascii?Q?2mXrw/+SbE+/1KVdteGhWSO0BQANVIWn4mxyrKJGI1/FEo/nHmtEAC5aUy2N?=
 =?us-ascii?Q?bXfjoWVgAOGirb1a0yHKA/aocRgqjrc27Few5nic8mEGJE7wgkAJd9TLSDR9?=
 =?us-ascii?Q?iEncQPlD3UqTUR56FqZdV0evWUvPN4tM0CjYAJQJxs9N3Qjyd+59OOtBItUG?=
 =?us-ascii?Q?uUckd0FtOHs8z6YJF7aTNjHxRAWotxB+Gy//WLghYdPaYzFDFWLBvnGvy5Xg?=
 =?us-ascii?Q?RqtGKrDYiKDPi1Rf4bdXtpVB5BG9lxxBVJGbE08iQkUHGyT8FWrlyJxHsYxW?=
 =?us-ascii?Q?zq1LffuaZSgrRyvZFCPezU/1ME=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:jphOt5Ci8w0opLZPbps1NWEch3U0RKg7sK2bVnX73ujH3zYVBYTWYmIE4IyvuvXIoXD81Z3E/MTV00cVeqotzBFiOVfbSZRtFxohXV6UkMKXmkKn5zNgw4JzrahvB4rhivPiJJtD+JqoZghQZahYr8wU/0ExFb0ZvdRFP3xjUCzqf7NxG2OP3s3cBrB23R2EIjyizzH+jnK+bSjJEsIzlkkQnsFR1tImPOez44ek4Sl3rm9vc0grZU+2JweiH9a13jRurwLwVIuJJaudGxzH2kJaefzf40bEAbD3+veMIQ312vgLNQLIyx02DgHpB9B5AhiZkdLq/27ykvXeB4zWRqQGQgXn0eurm+sEMULeL7I=;5:mlJI1in9MEah24eWUBXp0DsGTxmrvxl9fMGSP3kl08ncCGfvd3/V+rJ9WQl5TUmLhdzl1I3BDlaOFJRzY4+QjeuLFocGVaVZbssVikLIwM9kEggLzHaTrwUfWsGnVdqosYDVsR5ZEvTtJNIcl5B2VQ1IJRo1bPW/5RHYkV9sQ6k=;24:9KwkmflxBg02rVt8tbB3ckO8/BbUI7tmFag6dcw55HtqyCubaXxtQ/YE77qWHPS6i2V8d5GniPL+mk60go+PHSi4UhWJODFN8M8mVoBY7YY=;7:nhPU4HtbiNKRZOEp3KPiowprFp12ppG5YG/R1PV+4wIVJGvifadsOaIIbJXPpZEn+/FOgOYljUmhVMdZ+9nWZdVC8tK1cW6Wyn3pxoK4ekmEFAn19Tfix3fRTNtWvntN2o8KCs071kq0NghFJaOtzBADl5ZHCHffU3I3hndOqIvm3npkMVL84lEKZHjTgqTl1Xwj99971DfbuKXh76ylLHbw4SH6Ap0qEy/BKvs/8tpsgdnmT21QZQ6mFr1Zitvr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2018 18:01:05.1425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef2849d-1325-4cd3-0b37-08d561c21c02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi Junio,

this attached patch addresses Simon's review comments.

Can you squash the patch if you apply "[PATCH v4 5/6] convert: add
'working-tree-encoding' attribute"?

https://public-inbox.org/git/20180120152418.52859-6-lars.schneider@autodesk.com/

Thanks,
Lars


 convert.c                        | 5 +++--
 t/t0028-working-tree-encoding.sh | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 13fad490ce..f5e0cfc352 100644
--- a/convert.c
+++ b/convert.c
@@ -1165,8 +1165,9 @@ static struct encoding *git_path_check_encoding(struct attr_check_item *check)
 	if (!strcasecmp(value, default_encoding))
 		return NULL;

-	enc = xcalloc(1, sizeof(struct convert_driver));
-	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	enc = xcalloc(1, sizeof(*enc));
+	/* Aways use upper case names to simplify subsequent string comparison. */
+	enc->name = xstrdup_toupper(value);
 	*encoding_tail = enc;
 	encoding_tail = &(enc->next);

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 0f36d4990a..a6da61280d 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -22,6 +22,8 @@ test_expect_success 'setup test repo' '
 test_expect_success 'ensure UTF-8 is stored in Git' '
 	git cat-file -p :test.utf16 >test.utf16.git &&
 	test_cmp_bin test.utf8.raw test.utf16.git &&
+
+	# cleanup
 	rm test.utf8.raw test.utf16.git
 '


base-commit: 21f4dac5aba07a6109285c57a0478bf502e09009
--
2.16.0

