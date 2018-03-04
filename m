Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA651F404
	for <e@80x24.org>; Sun,  4 Mar 2018 20:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbeCDUPw (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 15:15:52 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:61501
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752008AbeCDUPp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 15:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0FhNnc8vDSDGItH1ynWJkeHjAoBB3b49PCehSQPXGUw=;
 b=PK7MSdkuDAnILMKotQwK1XTd0kTgVsnXULqMecN3Jfy6nDyvsWpzl5A++YENKyycXYFvtsVRonUG+7LYv/2YbnFyinUygLG3HVPzJg1NTxQDyM1FdiAu6eRkDmbQLXRomsV6jbil3J1j3xIQTnmfjDy/tff7BVgztM7cFqJs8d8=
Received: from far8gsqyz1.ads.autodesk.com (132.188.32.100) by
 DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM (2603:10b6:23:8::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Sun, 4
 Mar 2018 20:14:42 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 2/8] strbuf: add xstrdup_toupper()
Date:   Sun,  4 Mar 2018 21:14:12 +0100
Message-Id: <20180304201418.60958-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304201418.60958-1-lars.schneider@autodesk.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0113.namprd15.prod.outlook.com
 (2603:10b6:101:21::33) To DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:23:8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 484a9ddb-66e9-40ad-7d5d-08d5820c927a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5P136MB0009;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;3:1KGuMlhtamwUFrhVKsLaa5D7vjyuebQgY8mvvJTorc8FHx/zm1dxpEncXvdDG3ZTnYqb+OsV+CuLeAoLdp096XrsG/Ee7lBQ3jSL/miGq1fVkNm+GQX8T3rUviRlkEmjvTp/V2jNzwceyNPHeQM2EolI75WY3rFhOxWeQgOA0We+NVqnwxo9DME8yDo3gm4osarivzHayGTkxg0Qh47j9H368wqa9Vw9Q8XML+zJA71SoGSPM2FpXP54ePOUlEny;25:pg5gwjjQjMqy1mphArdcTo8ShRwQA+U1HwGiBYhTtTwzV2MAN6TC4FOcVnj/Y/zPS0LI3IaozEraGbnLXDf4GJqiefzmN/PuZ2bq7S/h13gs/c1F2Q9h7u/hcx2fQLwW0cCIinKCmnNSO6bYLnk24e9R8TByP8IhP6yEVOZYSAosiEHAe0dzL4fKnIA91o/TRM1GWmECOh5hiD49/+EFzF38i4dBFSZJuIFfdq3HpuYQJ+mjiMVqf87JWYmFd2IcMPlXM4z3gJxhQHJQlu/1MoX8Cbmwu286T2MIOTuw/Iatzr3OQqF/yP3M/l5HMFMEPsTckckoXUXz+WDuZYPL/A==;31:snaTfSyrBFP5924MWCadNrmrfaZHBwU6JHylP0RnZsoUBdgY+ZyyvxCPw7c75KqL1sFezRMYnnVH6icViiQ68+wWX1Txj1ZLb/P7nubQTsanh/acNwCOkbBFl4yJ4tIhQDpAWCpcvQE1DKOUyLB5FTkh95k6lcqIa6nsdsnSNyzuI/XKpoTi9qx2u03dk69Gbaih8lyHnowBeURIYBrbyFQhMOatOuMUKMHfmgGQfC4=
X-MS-TrafficTypeDiagnostic: DM5P136MB0009:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;20:zqItvr18dUoMYv23RIQjYLVRyRaBZdRg1tSkPIidAxzzg6bMS3aHnWDgW+pXLfpbc1QB7iLrSCb5KYweYYM8u07kixshJ74w8/qV+2IObwJtgeOvF4JkbjzGPuY7beiCnfnvbcpFODrTgkyjhUKWo88jXhMmMyH28hAiZCFVEV8p/Xd4VkcQMvUcVLk/YLg1sv8Eu5b+Ld82V/5wT0tN/twZKrB7T84hdv261FftRIVMkVn+emo7A3GQzF+kkjlwY5HxSSYgnOxeU/DMvtimkfP540/Y1yR93kSToAc6Mj9XUTJVhSe6RpDMDngizxpwzoYVZupJ6e3ReXAvIad+y0B5mZl5RhDFCJGXmrbEggUnolKsJYCrtou/Od5IxRCzfU6GVvYcgP/QESS8x1MSsiBc53xKmZf7XI10v0UddUsJZwUcq/lYy3nupbr2Msu3HlD6SolboHJ3arisQyS6h18a9k/8JXbj0fuEgX5wLL+oPeDwg5C1ZwsXgU7RwFc26FYtRtr5Y3anF4mlLWKdsdlAlaViK5RwSa02sxW/tHP7J4ViTvWbXTVS2UQ6rpo2ZjEL+u2d3wJxWya2mQY4grl9Gr9Dm5ZuEcGTK19T778=;4:4ao0UZ92URbEx3A8dImdvJc/422S/htLyEnZpKsLXBVAEiXyKeQV8XFJGEdBJENGCoTJC6BiMXYe52DnFswukMA8FNi/gENa0hTclB4GJUepLQvC2cgFYKGDYxgqNySKrzJyB9u7dGVHwSM4ScDHOVO0zlQKI9B64kB7rCea5JbvtP4TCUnrF6tB/3embr9j8rL+QN5c0YX8omnwNj9/C+XhCVUkEgw+yELhaNeunVc9fyPMkFX5SxSSPxMZa1GmHAkFxFWQmNVVKLJvyYfvjh5RH4yrqHTmnK9zn1d/9p2Hq0aUxRrhS7hJWHPyUgls
X-Microsoft-Antispam-PRVS: <DM5P136MB0009F078BD141B64F70CD78AE8DB0@DM5P136MB0009.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5P136MB0009;BCL:0;PCL:0;RULEID:;SRVR:DM5P136MB0009;
X-Forefront-PRVS: 060166847D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(39380400002)(396003)(189003)(199004)(316002)(1076002)(8656006)(2361001)(16586007)(66066001)(2906002)(68736007)(7696005)(85782001)(52116002)(97736004)(105586002)(51416003)(575784001)(76176011)(106356001)(86362001)(2351001)(47776003)(6116002)(3846002)(48376002)(8666007)(25786009)(6346003)(39060400002)(26005)(4326008)(50226002)(9686003)(305945005)(386003)(6486002)(53936002)(36756003)(6666003)(2950100002)(6916009)(81156014)(478600001)(8936002)(50466002)(7736002)(186003)(16526019)(5660300001)(81166006)(8676002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0009;H:far8gsqyz1.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0009;23:RLYYLKbyLtWK1eFZJ5MXt6VXANr9xsjDhU2bIFsgj?=
 =?us-ascii?Q?J5+91AppI/TRhU4oO4/U5bs9BjSvgus73uv1dAkD8upwV1GNmjTmYrP4DoQZ?=
 =?us-ascii?Q?N3//aduF5E8G/dyo6Ymn2yR2ii1GZV2y9ENZC/QN5wRU5NaxzMsagWcXUkBh?=
 =?us-ascii?Q?jzZNCIh/Lqbi7U0347OfBRVNxtpEwwzBjojnL891uL31Wz/5C24LpLSLu4VT?=
 =?us-ascii?Q?d3uIo4HbUyq/0Wwlhx6Di86YsobPWyDCIlqtJW0OS9ZHJX4KyL9LT25mFPNZ?=
 =?us-ascii?Q?TmumfsRl9k4FfmRgz5hyvSz4ujr2zCFddNe1+MDWmPf1WkKERWIk4u7qtslH?=
 =?us-ascii?Q?V0538z+q3rWiUYIqDLKAF5Oir7xNFAt4UHovospXtSp7fOdFQDoduB9tEmIZ?=
 =?us-ascii?Q?0s3U7ocgraOjfxuqmiXEFFU8+1N491oWsEdMMusMydhrbgs/WrLUr+zqRLy3?=
 =?us-ascii?Q?V6jdHNWOujjX0yddr2B/JJjjCIZK0+Gm52Pv9BbLzyZZH03dizHfwPp2lS87?=
 =?us-ascii?Q?T9YZKbXXd2A+MqkD4wEt9fOOZG5z0nsArwD69D0iCcKXn12fZ5xqp2gy69Mc?=
 =?us-ascii?Q?qE3/mBTeiUFCIIHnQ2tJEy6v8z1092EdSqHlYFIczE3XOKqhmnjCM0BtSR+O?=
 =?us-ascii?Q?PcZSAzanHAwhv9QSn+/rUUw0zisEMXklZVmCUs9kuo98SIJf+gtfFritjjBy?=
 =?us-ascii?Q?NwdhXn61kp+jMtdsuPFFaxK3ezCYoWvuemj4IrbyaAsoRpGZ2fc17+ta9Z1K?=
 =?us-ascii?Q?y8xnED7omvUjUSpR+nbMQlgJL9ZWUnbjsEOEli6ZrXvIB4KqrWvPsfeDRNvp?=
 =?us-ascii?Q?3G1v4z0ELFPqYDwxId+LbLsNW/WzePwlv4rAfUMIlD6UnpIGm5M+j7I86wsF?=
 =?us-ascii?Q?h4Ctoyyxr7p3aGRkZi6DxT7gaW53xJKvO0VyESRm5ExMeAy964VNlcAqI8Eu?=
 =?us-ascii?Q?ZWVNaW3nUaZK+ipUURWJlFGhVYuTcVA5+6yUKebwP/OEX7/Pbz5UpZVmcmHs?=
 =?us-ascii?Q?nSVhkc992PJe0qjw4pXj7TTYjro6B8bD/HxN9CnJXKOmPvPQpAY3suYx2gao?=
 =?us-ascii?Q?G4L3Pe9p7N/bV1Kjl0VRMnOClppAEGqfYeDtteCZ2JFVtTzrzHKzHY+dFrLw?=
 =?us-ascii?Q?PE/oNvVFPX2L6SlSmXCn97J04679Bt7Qtq5lZcAhvrQBMuxjAq1XVTIDmdGT?=
 =?us-ascii?Q?hzWSRZ9820pSinKBraFhsWTgGs6VQ/QZV3JwzT/a+NrqtS7bLSjNkJwQI/du?=
 =?us-ascii?Q?wdNpSTEax2YfAVNMfM6yJNMOgOq84ydDSAfLzl3P+pi9/JP6+TrbzW4MXynu?=
 =?us-ascii?Q?dWasxUhFQQIZ8LL2csW2F4=3D?=
X-Microsoft-Antispam-Message-Info: mgrLP9XcnVrbNq9UXuo43VzVQaFNpoXDsF63D003F8xyAuer9eWvXNnehwEVcF4zeFN68y9mvlsnGXybCh66WyuL9ArrEkbZvQVTyJqrZRsnWMbNN6oVeR6WMmH42aEfXTKL2rWjsoPodEY1nEZMWKZYv2Q7V2JPfxZ8vZGvOLYMjXgFgAoAhDT+OqeVAzzq
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0009;6:a3UxBTe0dHc5a3wvbTUSmsceqo9WVbFXb63/wTn/fq+30vcRP+2iHh4VHXTOTzPA80+cygRDCEFIgd0nWWegrNstDxLQhhMnFzZastk+b9X86cqQDhLfwlImkPXiBTT+Yisaho6xT5X3lP9LlQgIq9dgIkaNc+AqLdD1l1dIDEV3jEXR6MbW18De8dprQMX4Rr/VN3RMqXDnVfh8jihKlzg13dYpHxZhmFt49a9cshhuOsxXLBkWFFlz3TLBtWHTF+ApBrEt2SPCrmMzw6mhGDd06NcX3ive1gn4Iep+560KBqKENmlpKZqMQ71D4+oU1VJwobQaH3frBp+oGFYYs0fNLiu30H9Dg3dRkWRm7pI=;5:w0FJS4dzNd5eNSK8kVJckOe/PJ4T+nfVLld9Vb5IrhPD24k1SaRJ1z8tCynxvYlZg4Ynzkj2f+49eyS6EgWDJnXpZwJHStA+6vnn8RJyO9qO2uZlSYhI2JbeIXJjGeTQqKtddYQRfB+7g1lYuco3j1AJE92pCmYd8SwClz1nkCM=;24:b2KZmJgOI0hLHiN4VZGg2xydYqwtunHLvMK7JozBKm4p8iibAg/xQT8rSjAI6cMdrCdeNhfdypA1LYyUhyGUX4mUyq5t+h/90XRqbElLLJQ=;7:ARt4qQx1nKAq391i1d9ECTu2BMAKPPgsgxX+GUUy6u+uioFQcNZYHnOLLkk9aiQljPG3tTQNg9n9H09EVja0+O5hxO975LjW2wUEzb3twtCwBaV8025RdLRAA+GqnXB1qu6rpJ1bjxverGKwjLBEdHcWujGz2sEqcpVtGqd7TUtKulinOywnaubgKlXkx+L9s3qGktTHdFN6yhjA+T3XQ+BMODuIlW2cGfEafzvx6Z/48CpQS0qdsfdszSTLWMsk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2018 20:14:42.3699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 484a9ddb-66e9-40ad-7d5d-08d5820c927a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0009
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.2

