Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3165D1F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeAFAtA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:49:00 -0500
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:46925
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753477AbeAFAs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=u+1qZsArnEH0GclzRyyTGbNmHeqquGMg1SGV4edyTY8=;
 b=D5E86BCGXy0c23PrM9LafRdl8blFx7fnAPVoak5v3txwnLA4pYFiogt/YzaPrsg64pyrduzLci8IuZB1IDnrD6WLy7zVBAOxLaD0LW8j1FF9LTvhespzxmj8TCUYgWjKStjMXkrZySMUGz2ZlAK5IgVg46Gn7b1SIRLkZxgk8xk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:53 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 6/7] convert: add support for 'checkout-encoding' attribute
Date:   Sat,  6 Jan 2018 01:48:07 +0100
Message-Id: <20180106004808.77513-7-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f2e3072-42af-4a20-96c8-08d5549f43b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:BV57lJjEH7dcJLrmN97MmKTiqDFi4DnmLEEadCmwA6Qgj5X1O0J0UflApszhB4SWirtI31aK+kUiLeJf5Q/0MrAo+jpGygPpRKxu6jrKaqsuxk4e9+nP/WN5pp3iXtvCoaLL7t5X00zbnEP5wEzN9639PQ6N+6Fr37KWYieNvJYLL72ir3Zax1fYshpTFa8bdgmqkjhNdUYoC7UR4YOSaVwLfDq6Cn1+nfGOfTr7v5CsqNXZAcq+0jGdI8KtWW6q;25:TjGlMC34CcIhkpbuCVK/aiGZnWVhaZhDnB2OVIrD6TDrY36hqrQAuQZY11wurvJ/0yGysCbdLaqQwALjDsP3ndT5Fx9UrmjuCdqtPALFrVd75LRzhDX61fB6ndUa6d5b4ZiUWca24Cxr0vsu/nTRMz/GB9bX8Ax/iagwIHKejCrsD8re3do5Aw0TWcfPLzG3E4Z4n9wyRdzHDKxORvQkUW4q/LOsezB6WoPio1RQB9anWY6xQIXoGDD7cCt0OJhBPPYQGpwT7oPZ9R4wa6B9cX40H10S54Aq3gFoaX3ozaAr5/Elf1sMK5lGx5Ot/qIOz1NcyRrnTrrztjRM7BwYzw==;31:Ym4Rtn+HERpQ5+nN0sCoJPSdfW0BnW9cCX1wbaupnZvcxeOmNaCnCfwHcBM5NgqOAGIGqC8upH8Ea6xC1QrRX2bdbMaUBsj+UIcn6aaqX5AHyJOQWeoOVhOE+y3KDoFAzTRS68z50QC1jPrykJLNW30smX+lK6r4rb+/c7+rnycrUbR1cRT5GnbnhMLabAZfVdRp7NCi6FhQkO9Jfb+q3W/gG24BpYJ/r1od+X6fQC8=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:8gThrd29tnWou4WCzkF9gBAWpoEejM4LE2et6th6I1kniUtQnawgjK0+FFrgdqPPIvdsj829P7ML4qVLxkLS7oer31zXhsyHkEjaVvGwNlB0j1WlkBrVJfcpaVvIXFumM/Bp6ESKrvxAeXgvtdkgJmadx/zUaA7RHBOita8cvjMV7jtOfdNBMqR3XDOA/jif57XnbcipB1bZOZg6X0uj7ej482FpJtfcDeXeRskmXt6eatbnrS1ChPWhfvkMLMhubOxaBHWUF9Ht0N7rYYAi811oWT8bUx8y71hBLZLPllmoOePDsGh6r3D8HEWQOecI7+o0gWg5x3mAW5WsptSRpRaAIwnDkXXPZwSMvMGkB+PI/KokVXo+jN8rqQeJfT36NsNUUayNPus/e699woqI+X4bWiTeUBY/SDJkRA3XR9DsRep5kcJqlsjpE+hYU4UFUu4SXtkL89bO5Yi1KbwGBvlNtEv0RJF7qzgDWSxVSXz631v99fxJbZrEfHw59JCZRtq/X+Dth7ukE0bL0+EGioL+pl0lBNtuLu4s5+B7qPmmr+hoHuwHCDzed+fq5xLvCTIU8sePgiNT/8ZsXCFDnXxpDHmx5DWBhq26rImtwCg=;4:ahNtGBe5WlXVAd9j2hAvGQT31HPfNGD51pZKYIl88sGO3GG2jzzFKnd6aCqt+m2o2HSEJN/dSiovBBHKWu+i9vm13+T4C4nbdwdMBZ/UZ1Z40d/FojoJ0HfcfdJcf9LGEVbKaq4da7Xa1TM9/mTxhoKdEOV+S8iFq9VeWB9QBseEqjWBW4S9/KK9vqR7w1FsKhtv6DDeMUkdiBSM6iy8cO+oBOT86qS5XhETnnX+8/BUpbgEGsEY96ZVNL3dGuHxPdqOa9oWIUkHOPqAt704Pw==
X-Microsoft-Antispam-PRVS: <CY4P136MB002137CEC67D05B80902C91CE81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(5660300001)(2950100002)(5890100001)(575784001)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(6306002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(966005)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(59450400001)(81156014)(36756003)(53376002)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:eXg2u7sRkH0oXFpSvDxPmpvxKE8acNE4iHEUWvaYZ?=
 =?us-ascii?Q?+SMQyNnqu/dhcQSJgblzFiYSvGPnvn/AtDhHI1ZU6KewQSZJ96Xbe2wSsstw?=
 =?us-ascii?Q?i/xo63PUWXziCHiunRB3VvVr2RPAmnALRwR46khE6pG0k4WJsvHVmUOiabr3?=
 =?us-ascii?Q?4QGbyEHm9lB+rfa7WkEtXbvBw9rMxJlpJbdf3JuwZz8fbVGVHrDI/XJeepcd?=
 =?us-ascii?Q?OJ4LP8Goa2nRGk0wFyW9CbXUar44G8ho2j4N53/mRJTsxa6HQh+AfEy6M+9n?=
 =?us-ascii?Q?PLFm2YTtP3xMFMT2Jb9jJ20fzHYFyMRdst3z16fOTLfd3tObOchVvDqscsQ6?=
 =?us-ascii?Q?/YZ0rOQNC5E7ygYVTK47OnbvR9kWSYE1entZq0o6gN1IeOK5qIJkfRL80HCV?=
 =?us-ascii?Q?bhZpz2GoJ9+meGw5T5RjVBF/s2wOkrtLui7Nmc1zV5vs1tCjCxYBJWQbKOj+?=
 =?us-ascii?Q?zHP6NpyCDk6ndX3OTNdQceRK05zaGJFUXCPjzR6LkbMCPuxcfSNVmkH8iB5E?=
 =?us-ascii?Q?k+ISLTK4b1GnnpQfDlucZep5oHxDyP+9iRCI916HH05d4PCZX7yMRk8u5PGP?=
 =?us-ascii?Q?VpWu1elNDr1vL9n1p4FP7iGp8L1CB7TvxVSNZJzcEuVpMSEPfZyACxNNlejm?=
 =?us-ascii?Q?+UalCQUPk10fBtWnqCim7wOUwOXvnFhMLgtAFPh5mLT00DumUDN0TLgnjAku?=
 =?us-ascii?Q?eFKMw6fO5rb2812jS0h9r72RbVSbmSn0j5YVP/cNUe1CkibDF7d9AsYn3+ux?=
 =?us-ascii?Q?nNekBbChCLNZm5AdDlceqmEVeQ7of6+cE4/PUeYwwZv+iXeStj4j2xbKjb9E?=
 =?us-ascii?Q?XQN4W2qjuvvPsKs7pgijegOtM+9/GjFnANWnfVbvidXbsAJGTDmaij/R7clI?=
 =?us-ascii?Q?Lrs1sSPxiH/l9xb1SMXiOZ9ng9ySYrkvi3ujv8b245/I9ZAaS7t3j4fRwkmu?=
 =?us-ascii?Q?wZlHQnMZpjL+Hzpsad44gJ09qGMRB9mH8zPaxyMiLMnhM2wMEi6jWsrCNjYS?=
 =?us-ascii?Q?SzwrlfXrO6PgfGsmggiyt1BsbkhvU9DxfkB4hUTB5CDj/m40xS0nYohUjN9a?=
 =?us-ascii?Q?A9uoZjlvp/jpY0iumQ4QXqGoioUrYWh8nazjtwGdCP1ODG+P5DulnK6KrBGn?=
 =?us-ascii?Q?viJBgrmySWC7MKPPIqtV415jmICvZNDm8QUNpTuodTiviuDYpWsmwYrnU+bB?=
 =?us-ascii?Q?XJyHN58Z6b67AS6v8zi0jlrVqmtuVhyaLEHtXoO3D4OAckDeqD9vrtQo+BJQ?=
 =?us-ascii?Q?9cShe6Tz+pXcjvZwiamh6174XHqlSXp3wE14uDgoZfRXUnopfVu0Rxs8WI8f?=
 =?us-ascii?Q?nxYdH6Lze+xfr1ILkEMro+sMwEwtcFpby+5yojh+eJq6D6hOrQGA76rmLQxN?=
 =?us-ascii?Q?yp74A93759upL4i+H0tt+LrSq7MNhP3m5czg5/81ETOccZXYOFRhSA6ibfv2?=
 =?us-ascii?Q?WJTyclovhS356Xz5aly/puDGLQIeWs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:g/ogzxMW58Sx8MgeB/nyrJsZab6vFe2kJ1M/S0LdTe1SY9bwsTuiSzde6GlwlGywtoPjRp/0aV1Y/M+ypad6Zl5XnPU/d5Emc8yWRfGKLHilOhjHHSACSOBZJ+TYA/FONMjZUWGL2+PzBs7BJkvmVmEjyGd0LTaNjOWBChlXrke8hHAa2uc3+9vfWcdlDOSoO/ju/XR+2K9mNO1h1b6rHfLfHFN2vo2HkDSNX0Pjv61D9MVdVtZZcANZxoCytKwQUQCTbCuCCtSmmwcxLAowFkduAjP5Sg/31o3xNw+6+8XSc/c/vxjghZFhxsppvJIXap//lh/ev0PvR8GTgG+VfMEeUGd4ucFvK7o7xK/epvk=;5:CimBCny16ztIfaCas2IijMU4L4wXrOlK1Lt0MlWaCib+Ju53dmWl5czvdDgA+FmQSlH7ohQ55wrHNSDMU6bkHNK1E2xMC0JioAURSRhzNwHQAg5EbHYz6JlDvOdbds3VONnLjXXmg4wHUzffjIGFVcO6DtWqNXEH1RITDqvR2bs=;24:NeT4xq1Wckn81Korn+Ga+HRORn6vl0GTUOPF9Bbr2Ehi7tErZJF4JALwCVP0Lk3BC+xY5nFVftK0uNcB2ngwBltaXNEBQrpmCyHcUySK/gc=;7:LYwEY85hN1lmVwYZeRa1x38QsqImNasBwB3zY8WR060QH3DAROdBObjmeIKf+Eqg5VNNCV4GaEGDvGBjhGntz716/cDmU5VPZ14RGSHjgNnBZNC3jaU3aznExyMwmOjfODvFf3TEI4aRYrLut/cGXN35gj62/s/YEeBw6J8RGkgWC3LPnBBuznSBk4K0pLrXtKNqGQC0nHfrWhFDnyHwv8nsi7HhAv7YtPTod6YE4gSt+in9IzCeIWVkTVZcyGcp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:53.0663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2e3072-42af-4a20-96c8-08d5549f43b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Git recognizes files encoded with ASCII or one of its supersets (e.g.
UTF-8 or ISO-8859-1) as text files. All other encodings are usually
interpreted as binary and consequently built-in Git text processing
tools (e.g. 'git diff') as well as most Git web front ends do not
visualize the content.

Add an attribute to teach Git what encoding the user has defined for a
given file. If the content is added to the index, then Git converts the
content to a canonical UTF-8 representation. On checkout Git will
reverse the conversion.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt |  60 ++++++++++++
 convert.c                       | 190 +++++++++++++++++++++++++++++++++++++-
 convert.h                       |   1 +
 t/t0028-checkout-encoding.sh    | 196 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 446 insertions(+), 1 deletion(-)
 create mode 100755 t/t0028-checkout-encoding.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 30687de81a..1bc03e69cb 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -272,6 +272,66 @@ few exceptions.  Even though...
   catch potential problems early, safety triggers.
 
 
+`checkout-encoding`
+^^^^^^^^^^^^^^^^^^^
+
+Git recognizes files encoded with ASCII or one of its supersets (e.g.
+UTF-8 or ISO-8859-1) as text files.  All other encodings are usually
+interpreted as binary and consequently built-in Git text processing
+tools (e.g. 'git diff') as well as most Git web front ends do not
+visualize the content.
+
+In these cases you can teach Git the encoding of a file in the working
+directory with the `checkout-encoding` attribute. If a file with this
+attributes is added to Git, then Git reencodes the content from the
+specified encoding to UTF-8 and stores the result in its internal data
+structure (called "the index"). On checkout the content is encoded
+back to the specified encoding.
+
+Please note that using the `checkout-encoding` attribute may have a
+number of pitfalls:
+
+- Git clients that do not support the `checkout-encoding` attribute
+  will checkout the respective files UTF-8 encoded and not in the
+  expected encoding. Consequently, these files will appear different
+  which typically causes trouble. This is in particular the case for
+  older Git versions and alternative Git implementations such as JGit
+  or libgit2 (as of January 2018).
+
+- Reencoding content to non-UTF encodings (e.g. SHIFT-JIS) can cause
+  errors as the conversion might not be round trip safe.
+
+- Reencoding content requires resources that might slow down certain
+  Git operations (e.g 'git checkout' or 'git add').
+
+Use the `checkout-encoding` attribute only if you cannot store a file in
+UTF-8 encoding and if you want Git to be able to process the content as
+text.
+
+Use the following attributes if your '*.txt' files are UTF-16 encoded
+with byte order mark (BOM) and you want Git to perform automatic line
+ending conversion based on your platform.
+
+------------------------
+*.txt		text checkout-encoding=UTF-16
+------------------------
+
+Use the following attributes if your '*.txt' files are UTF-16 little
+endian encoded without BOM and you want Git to use Windows line endings
+in the working directory.
+
+------------------------
+*.txt 		checkout-encoding=UTF-16LE text eol=CRLF
+------------------------
+
+You can get a list of all available encodings on your platform with the
+following command:
+
+------------------------
+iconv --list
+------------------------
+
+
 `ident`
 ^^^^^^^
 
diff --git a/convert.c b/convert.c
index f39150cde9..13f766d2a2 100644
--- a/convert.c
+++ b/convert.c
@@ -7,6 +7,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "utf8.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -256,6 +257,147 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 
 }
 
+static struct encoding {
+	const char *name;
+	struct encoding *next;
+} *encoding, **encoding_tail;
+static const char *default_encoding = "UTF-8";
+
+static int encode_to_git(const char *path, const char *src, size_t src_len,
+			 struct strbuf *buf, struct encoding *enc, int conv_flags)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	/*
+	 * Looks like we got called from "would_convert_to_git()".
+	 * This means Git wants to know if it would encode (= modify!)
+	 * the content. Let's answer with "yes", since an encoding was
+	 * specified.
+	 */
+	if (!buf && !src)
+		return 1;
+
+	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is prohibited for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is prohibited with this encoding. Either use "
+			"%.6s as checkout encoding or remove the BOM from the "
+			"file.");
+
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+
+
+	} else if (has_missing_utf_bom(enc->name, src, src_len)) {
+		const char *error_msg = _(
+			"BOM is required for '%s' if encoded as %s");
+		const char *advise_msg = _(
+			"You told Git to treat '%s' as %s. A byte order mark "
+			"(BOM) is required with this encoding. Either use "
+			"%sBE/%sLE as checkout encoding or add a BOM to the "
+			"file.");
+		advise(advise_msg, path, enc->name, enc->name, enc->name);
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(error_msg, path, enc->name);
+		else
+			error(error_msg, path, enc->name);
+	}
+
+	dst = reencode_string_len(src, src_len, default_encoding, enc->name,
+				  &dst_len);
+	if (!dst) {
+		/*
+		 * We could add the blob "as-is" to Git. However, on checkout
+		 * we would try to reencode to the original encoding. This
+		 * would fail and we would leave the user with a messed-up
+		 * working tree. Let's try to avoid this by screaming loud.
+		 */
+		const char* msg = _("failed to encode '%s' from %s to %s");
+		if (conv_flags & CONV_WRITE_OBJECT)
+			die(msg, path, enc->name, default_encoding);
+		else
+			error(msg, path, enc->name, default_encoding);
+	}
+
+	/*
+	 * UTF supports lossless round tripping [1]. UTF to other encoding are
+	 * mostly round trip safe as Unicode aims to be a superset of all other
+	 * character encodings. However, the SHIFT-JIS (Japanese character set)
+	 * is an exception as some codes are not round trip safe [2].
+	 *
+	 * Reverse the transformation of 'dst' and check the result with 'src'
+	 * if content is written to Git. This ensures no information is lost
+	 * during conversion to/from UTF-8.
+	 *
+	 * Please note, the code below is not tested because I was not able to
+	 * generate a faulty round trip without iconv error.
+	 *
+	 * [1] http://unicode.org/faq/utf_bom.html#gen2
+	 * [2] https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-between-shift-jis-and-unicode
+	 */
+	if ((conv_flags & CONV_WRITE_OBJECT) && !strcmp(enc->name, "SHIFT-JIS")) {
+		char *re_src;
+		int re_src_len;
+
+		re_src = reencode_string_len(dst, dst_len,
+					     enc->name, default_encoding,
+					     &re_src_len);
+
+		if (!re_src || src_len != re_src_len ||
+		    memcmp(src, re_src, src_len)) {
+			const char* msg = _("encoding '%s' from %s to %s and "
+					    "back is not the same");
+			if (conv_flags & CONV_WRITE_OBJECT)
+				die(msg, path, enc->name, default_encoding);
+			else
+				error(msg, path, enc->name, default_encoding);
+		}
+
+		free(re_src);
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
+static int encode_to_worktree(const char *path, const char *src, size_t src_len,
+			      struct strbuf *buf, struct encoding *enc)
+{
+	char *dst;
+	int dst_len;
+
+	/*
+	 * No encoding is specified or there is nothing to encode.
+	 * Tell the caller that the content was not modified.
+	 */
+	if (!enc || (src && !src_len))
+		return 0;
+
+	dst = reencode_string_len(src, src_len, enc->name, default_encoding,
+				  &dst_len);
+	if (!dst) {
+		error("failed to encode '%s' from %s to %s",
+			path, enc->name, default_encoding);
+		return 0;
+	}
+
+	strbuf_attach(buf, dst, dst_len, dst_len + 1);
+	return 1;
+}
+
 static int crlf_to_git(const struct index_state *istate,
 		       const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
@@ -969,6 +1111,31 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
+static struct encoding *git_path_check_encoding(struct attr_check_item *check)
+{
+	const char *value = check->value;
+	struct encoding *enc;
+
+	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
+	    !strlen(value))
+		return NULL;
+
+	for (enc = encoding; enc; enc = enc->next)
+		if (!strcasecmp(value, enc->name))
+			return enc;
+
+	/* Don't encode to the default encoding */
+	if (!strcasecmp(value, default_encoding))
+		return NULL;
+
+	enc = xcalloc(1, sizeof(struct convert_driver));
+	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
+	*encoding_tail = enc;
+	encoding_tail = &(enc->next);
+
+	return enc;
+}
+
 static enum crlf_action git_path_check_crlf(struct attr_check_item *check)
 {
 	const char *value = check->value;
@@ -1024,6 +1191,7 @@ struct conv_attrs {
 	enum crlf_action attr_action; /* What attr says */
 	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
 	int ident;
+	struct encoding *checkout_encoding; /* Supported encoding or default encoding if NULL */
 };
 
 static void convert_attrs(struct conv_attrs *ca, const char *path)
@@ -1032,8 +1200,10 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", NULL);
+					 "eol", "text", "checkout-encoding",
+					 NULL);
 		user_convert_tail = &user_convert;
+		encoding_tail = &encoding;
 		git_config(read_convert_config, NULL);
 	}
 
@@ -1055,6 +1225,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 			else if (eol_attr == EOL_CRLF)
 				ca->crlf_action = CRLF_TEXT_CRLF;
 		}
+		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
 		ca->drv = NULL;
 		ca->crlf_action = CRLF_UNDEFINED;
@@ -1135,6 +1306,13 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
+
+	ret |= encode_to_git(path, src, len, dst, ca.checkout_encoding, conv_flags);
+	if (ret && dst) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	if (!(conv_flags & CONV_EOL_KEEP_CRLF)) {
 		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, conv_flags);
 		if (ret && dst) {
@@ -1158,6 +1336,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);
 
+	encode_to_git(path, dst->buf, dst->len, dst, ca.checkout_encoding, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
 }
@@ -1189,6 +1368,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}
 
+	ret |= encode_to_worktree(path, src, len, dst, ca.checkout_encoding);
+	if (ret) {
+		src = dst->buf;
+		len = dst->len;
+	}
+
 	ret_filter = apply_filter(
 		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
@@ -1655,6 +1840,9 @@ struct stream_filter *get_stream_filter(const char *path, const unsigned char *s
 	if (ca.drv && (ca.drv->process || ca.drv->smudge || ca.drv->clean))
 		return NULL;
 
+	if (ca.checkout_encoding)
+		return NULL;
+
 	if (ca.crlf_action == CRLF_AUTO || ca.crlf_action == CRLF_AUTO_CRLF)
 		return NULL;
 
diff --git a/convert.h b/convert.h
index 65ab3e5167..1d9539ed0b 100644
--- a/convert.h
+++ b/convert.h
@@ -12,6 +12,7 @@ struct index_state;
 #define CONV_EOL_RNDTRP_WARN  (1<<1) /* Warn if CRLF to LF to CRLF is different */
 #define CONV_EOL_RENORMALIZE  (1<<2) /* Convert CRLF to LF */
 #define CONV_EOL_KEEP_CRLF    (1<<3) /* Keep CRLF line endings as is */
+#define CONV_WRITE_OBJECT     (1<<4) /* Content is written to the index */
 
 extern int global_conv_flags_eol;
 
diff --git a/t/t0028-checkout-encoding.sh b/t/t0028-checkout-encoding.sh
new file mode 100755
index 0000000000..3a9951fdf3
--- /dev/null
+++ b/t/t0028-checkout-encoding.sh
@@ -0,0 +1,196 @@
+#!/bin/sh
+
+test_description='checkout-encoding conversion via gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test repo' '
+	git config core.eol lf &&
+
+	text="hallo there!\ncan you read me?" &&
+	echo "*.utf16 text checkout-encoding=utf-16" >.gitattributes &&
+	printf "$text" >test.utf8.raw &&
+	printf "$text" | iconv -f UTF-8 -t UTF-16 >test.utf16.raw &&
+	cp test.utf16.raw test.utf16 &&
+
+	git add .gitattributes test.utf16 &&
+	git commit -m initial
+'
+
+test_expect_success 'ensure UTF-8 is stored in Git' '
+	git cat-file -p :test.utf16 >test.utf16.git &&
+	test_cmp_bin test.utf8.raw test.utf16.git &&
+	rm test.utf8.raw test.utf16.git
+'
+
+test_expect_success 're-encode to UTF-16 on checkout' '
+	rm test.utf16 &&
+	git checkout test.utf16 &&
+	test_cmp_bin test.utf16.raw test.utf16 &&
+
+	# cleanup
+	rm test.utf16.raw
+'
+
+test_expect_success 'check prohibited UTF BOM' '
+	printf "\0a\0b\0c"                         >nobom.utf16be.raw &&
+	printf "a\0b\0c\0"                         >nobom.utf16le.raw &&
+	printf "\376\777\0a\0b\0c"                 >bebom.utf16be.raw &&
+	printf "\777\376a\0b\0c\0"                 >lebom.utf16le.raw &&
+
+	printf "\0\0\0a\0\0\0b\0\0\0c"             >nobom.utf32be.raw &&
+	printf "a\0\0\0b\0\0\0c\0\0\0"             >nobom.utf32le.raw &&
+	printf "\0\0\376\777\0\0\0a\0\0\0b\0\0\0c" >bebom.utf32be.raw &&
+	printf "\777\376\0\0a\0\0\0b\0\0\0c\0\0\0" >lebom.utf32le.raw &&
+
+	echo "*.utf16be text checkout-encoding=utf-16be" >>.gitattributes &&
+	echo "*.utf16le text checkout-encoding=utf-16le" >>.gitattributes &&
+	echo "*.utf32be text checkout-encoding=utf-32be" >>.gitattributes &&
+	echo "*.utf32le text checkout-encoding=utf-32le" >>.gitattributes &&
+
+	# Here we add a UTF-16 files with BOM (big-endian and little-endian)
+	# but we tell Git to treat it as UTF-16BE/UTF-16LE. In these cases
+	# the BOM is prohibited.
+	cp bebom.utf16be.raw bebom.utf16be &&
+	test_must_fail git add bebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16be &&
+	test_must_fail git add lebom.utf16be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16BE" err.out &&
+
+	cp bebom.utf16be.raw bebom.utf16le &&
+	test_must_fail git add bebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	cp lebom.utf16le.raw lebom.utf16le &&
+	test_must_fail git add lebom.utf16le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-16LE" err.out &&
+
+	# ... and the same for UTF-32
+	cp bebom.utf32be.raw bebom.utf32be &&
+	test_must_fail git add bebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32be &&
+	test_must_fail git add lebom.utf32be 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32BE" err.out &&
+
+	cp bebom.utf32be.raw bebom.utf32le &&
+	test_must_fail git add bebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	cp lebom.utf32le.raw lebom.utf32le &&
+	test_must_fail git add lebom.utf32le 2>err.out &&
+	test_i18ngrep "fatal: BOM is prohibited .* UTF-32LE" err.out &&
+
+	# cleanup
+	git reset --hard HEAD
+'
+
+test_expect_success 'check required UTF BOM' '
+	echo "*.utf32 text checkout-encoding=utf-32" >>.gitattributes &&
+
+	cp nobom.utf16be.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf16le.raw nobom.utf16 &&
+	test_must_fail git add nobom.utf16 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-16" err.out &&
+
+	cp nobom.utf32be.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	cp nobom.utf32le.raw nobom.utf32 &&
+	test_must_fail git add nobom.utf32 2>err.out &&
+	test_i18ngrep "fatal: BOM is required .* UTF-32" err.out &&
+
+	# cleanup
+	rm nobom.utf16 nobom.utf32 &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'eol conversion for UTF-16 encoded files on checkout' '
+	printf "one\ntwo\nthree\n" >lf.utf8.raw &&
+	printf "one\r\ntwo\r\nthree\r\n" >crlf.utf8.raw &&
+
+	cat lf.utf8.raw | iconv -f UTF-8 -t UTF-16 >lf.utf16.raw &&
+	cat crlf.utf8.raw | iconv -f UTF-8 -t UTF-16 >crlf.utf16.raw &&
+	cp crlf.utf16.raw eol.utf16 &&
+
+	git add eol.utf16 &&
+	git commit -m eol &&
+
+	# UTF-16 with CRLF (Windows line endings)
+	rm eol.utf16 &&
+	git -c core.eol=crlf checkout eol.utf16 &&
+	test_cmp_bin crlf.utf16.raw eol.utf16 &&
+
+	# UTF-16 with LF (Unix line endings)
+	rm eol.utf16 &&
+	git -c core.eol=lf checkout eol.utf16 &&
+	test_cmp_bin lf.utf16.raw eol.utf16 &&
+
+	rm crlf.utf16.raw crlf.utf8.raw lf.utf16.raw lf.utf8.raw &&
+
+	# cleanup
+	git reset --hard HEAD^
+'
+
+test_expect_success 'check unsupported encodings' '
+
+	echo "*.nothing text checkout-encoding=" >>.gitattributes &&
+	printf "nothing" >t.nothing &&
+	git add t.nothing &&
+
+	echo "*.garbage text checkout-encoding=garbage" >>.gitattributes &&
+	printf "garbage" >t.garbage &&
+	test_must_fail git add t.garbage 2>err.out &&
+	test_i18ngrep "fatal: failed to encode" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'error if encoding round trip is not the same during refresh' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	echo "hallo" >nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	test_must_fail git checkout HEAD^ 2>err.out &&
+	test_i18ngrep "error: .* overwritten by checkout:" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_expect_success 'error if encoding garbage is already in Git' '
+	BEFORE_STATE=$(git rev-parse HEAD) &&
+
+	# Skip the UTF-16 filter for the added file
+	# This simulates a Git version that has no checkoutEncoding support
+	cp nobom.utf16be.raw nonsense.utf16 &&
+	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16) &&
+	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16 &&
+	COMMIT=$(git commit-tree -p $(git rev-parse HEAD) -m "plain commit" $(git write-tree)) &&
+	git update-ref refs/heads/master $COMMIT &&
+
+	git diff 2>err.out &&
+	test_i18ngrep "error: BOM is required" err.out &&
+
+	# cleanup
+	rm err.out &&
+	git reset --hard $BEFORE_STATE
+'
+
+test_done
-- 
2.15.1

