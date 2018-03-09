Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249FC1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCIRgy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:36:54 -0500
Received: from mail-bn3nam01on0118.outbound.protection.outlook.com ([104.47.33.118]:2112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932327AbeCIRgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/yU3bfSHK4UkHJEA8CBwmg5oAwaX4FjKzU5sObGsELY=;
 b=h7HzQr4emtKSL5i+B3KH5rVwJNNZfb+Pft1lqHN7ozBychOkKl02wF1OmYpYb85XZmxCPPsR8oAy6PRn4ckINjqRkhp59H3M/CcsXtWPdMm2QuONB9zsG5LDZ/0KR0B4G3z3IZMq91ShZOZkn6MldrrdDgVpL4lq7EEBeEPQRx4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remr90mpm73.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Fri, 9
 Mar 2018 17:35:46 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 00/10] convert: add support for different encodings
Date:   Fri,  9 Mar 2018 18:35:26 +0100
Message-Id: <20180309173536.62012-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO2PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:104:7::21) To MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 463c7fe9-d810-4172-857a-08d585e4328d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;3:PjiyCVA6C+PCJxuvh9Wj2VvPbGJvyawGId4cRGZrXbpy+v2EyP7pbKlGs2MjKsj8eVJFgkH6Zq8/93aUJb0ircoWcs5E5RLdF5G9ccaony1B8jhxvcvTpv33al/YgKzR8Lzz8alcJTvJUNV+Vtzba5PtMJiXeRl4C3OCCke1MfWQ3sMsWFidjG/xXBR4n9e/As8a/9bS8GvBImROJNmmx2kIcyQb0gBVqw7u4oEw/pngxS7U8NuJ6ihQtOB6NnA8;25:Mc0Y7sgbM89hqCF2ROFueb3SJ2ce3uCn+kPFD01fxUP5aPgVNUqMglbkbwzT+zS+kR3rMcogk3Cxn5/fheCDu61rQH0DA/VRh0B8VvioFuGYi9HMjSqJTXO4UlCPwS6YY7CYZoWBtGWUhGzl48UEEO9D8PBUBcPg6UOiaYR1ktTOoI4bSfV2EKcW/cqHzHr4xFpiuIZam/MFI2jtA9jDHhuCekn4Ds9KdrL7kkGVOoJd1nyxGylM+vg3nQFzWNOZfr+2ph8i4EIcmcK59deEE0CJsWbGnjw36hK/i1dhORdlUqITIsOSBqsWS0HVFSbhhtKZu9DB4VhWxt1Qe5w5QQ==;31:CUU8W1OB4RKbJ4rz8KvdtS0zxJH1y3nGGY5yS0vDTE1oJGuRXfzpCQdk7D/6Ck5PV3YWtwE4C9ECBsMUzikb9PMbbL7jB+ioZaZjpAPiubfYnn+h1LfnjRtzy3/qJjc0j+tsaBMx9wJxYmxn7gxZoIp0SGNtn1O8/PsqtDxoe9h1RqTswtIb262cz/YhwtgOlFm7jxaMoaltlsksXZ2bsTfEVUB33v/TQBenxBjagK4=
X-MS-TrafficTypeDiagnostic: MWHP136MB0015:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;20:tgtkeZCNCP8m887NAJamETv/Vj0l3SWZsI1QFLyY6qit9Bnt1kP462ebiZWxaMcJXNFkBVVyBG16YF4L0+DSdb8FHNJT6h/v8r1LhqeRvpy1NRSycwhyioAhZo9rOWfB33RUsdVnWhClbRcB6OU/cQis8chPiXbUi17nBRZXr+YpVRrxrkvlbcHYnNF8q5ADeyEfig5hs3d1uJp/o0qimFGkRAsAuC9DtzRGlk7RbCYRybLoHOm2r3jXjeniUKMq0ESWoQqDGei8+JcyIZcfWmErydDSSWQEFJSbcS+V+/872gPWlop6/DJqFLUz6jVINhe7ZhayBCtnDSGBwcWgXdX1OqgrkP3oLndax8jFs5a+3FWOPJIYlzU+/UXPQmDFAYdhi6G8GG4cdS9G+Nr6I+bauvNqxd72DD4X1pPuEgWXlYNxlq9K6ygQCg3G2o8r/huNscHmmMjvnpchWCBgyr8GaL3wk2k8uyVlwP76Im8W/I4uXLGiPzabfSp2X8MUq9EGi6zwak5gglsTnmblLT0XUoW9/w529W2ojsLYJ0kiGt92L432WYdJ2w116z9oe+RPFU6jXvwTZKU+9pZl8X1rvc/WffTekmauXaLbkO8=
X-Microsoft-Antispam-PRVS: <MWHP136MB0015BECA0FD8EFED06DF6EACE8DE0@MWHP136MB0015.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(85827821059158)(245156298449039)(61196332173343);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHP136MB0015;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0015;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;4:IBTfM0dCIRSCro82K5vjVdDeBsbDi0aLLlSXBkdOsK+wbhaST/i1rigck5kwDzdKyNiDGgYvBrKVcPxWReM/dNCOw4KxJmVQBZPic5ej7zor/aUdqy+QO9mxYeao3NlabJe4d8bqjbquHQ1IdZXzBB+R/prAwYlGcdLoiY0EGh6FeF6gDpX5zcWz5VLRINYs1iYDuOgpIrU2Ox2CGQyezoT7s3L4eTYHmXSZbzHfWGmqiDXFcig8BLuJu7TKwJCl8JtelR4S5qr6li3PrOVerni8QK5wB3V5U0Vb3Xwv3FOOQA3g+Ho3SMXrW+0hWCmEgjWF2IpzJnJlwA0lYQq66vVOE16WWd+LkjkR+5Hw4gyjRgUO3dSmytC4cGV10iPS/TGZ8n1S+NIkFaawYz/i+CmoNTL2AFDLZrV7t1iNaJo=
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(366004)(39380400002)(346002)(189003)(199004)(377424004)(50226002)(8656006)(7416002)(25786009)(106356001)(51416003)(8676002)(2351001)(6486002)(2361001)(386003)(105586002)(68736007)(8936002)(5660300001)(39060400002)(7696005)(52116002)(59450400001)(4326008)(50466002)(2906002)(48376002)(81156014)(81166006)(16586007)(6116002)(86362001)(575784001)(26005)(3846002)(85782001)(316002)(9686003)(6306002)(186003)(97736004)(16526019)(8666007)(1076002)(53936002)(36756003)(6666003)(305945005)(47776003)(6916009)(478600001)(7736002)(966005)(66066001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0015;H:remr90mpm73.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0015;23:DrgxEHtaPJrBhj84LLdQDNues5ksgZpSfM8Eeo//u?=
 =?us-ascii?Q?sI1yedyUfSax7RzXPiwggpEM/eOcjvBbQr49WYlkPx2B0Jl2gCPx5seK0QB3?=
 =?us-ascii?Q?uRLTrJRKrpEK7ZKR1TtRpNyrvmo6nSaBl6agImbH0urp7AHj2lzIWiIScNXu?=
 =?us-ascii?Q?YtkFYT/T/S2/p9GNvGZkFA9jTV82iUsoFP6RvkDv6cjEk8Kg9AmXZw8V49Da?=
 =?us-ascii?Q?cGYXndU2QdZgc9aClWS6U4T6agoZIrF2FzqNJd/l6K6OHBF4aAu7t+hyZikn?=
 =?us-ascii?Q?Jb8rVrxm1pPKoNsk4R5BayZQd9z0fZE9m3W7lSVENHFx7Jkiw/qca9SqziBt?=
 =?us-ascii?Q?AAw+cmH385eGbL2daM7JGSQrL3nztvVVsi0AlE7i389PQlxligMr3SXXpo0L?=
 =?us-ascii?Q?10dAdzq+fvKTYN5gfJXxbKViYlFmCrtqV739cqPfP+CQwVK6RGjZ3Qr1w116?=
 =?us-ascii?Q?s5uauUTDoH16JNqYVfv4MM8SC9Xht4tyiYioesRELDNIaHzvDmJqq/urjQgt?=
 =?us-ascii?Q?VRNYi7d1z/3N/HKDpO535tVlgN9eVVQhFxjLKzFg/XGY9J+ydRoWM3zsyM7c?=
 =?us-ascii?Q?AYabMeHSX/RG6mwvTl3IEYg7fEXrxzJV/p5O7n70QW24Ed4IeYQd8C+DbQLt?=
 =?us-ascii?Q?69OThqzch7X1ODfwuUv3hPl/IRasPwnxmSBChI+gOm1K8CDDeTALTmy+2J4N?=
 =?us-ascii?Q?kq+5czlJa2ah1Sk1jd8GfvDqYBLybV9qHKf/dsADX6rwtVO5ngOQYRJYfpFQ?=
 =?us-ascii?Q?HQ1yqxQB2AwdwQ+xCcHnSH89tY5szPyJFBOzLeZfBjU+3XbxEMzdXFJP8Jda?=
 =?us-ascii?Q?KJn6GtP5C/B28+4IDsFIr2hNqw7X+TyCckmi5xPFVbxifqrmAkmFKax106Ib?=
 =?us-ascii?Q?IUzQvB5Cs2mxU50OsJPOmOTR9/rbqjDPy0Ayaw0eXy9EmAgor+sXdCbq4rec?=
 =?us-ascii?Q?nD7LtN9s5TX3cZUQlk6XlsUGp6VGwDxMY2RRzdszb4ohuQpAbyHt/yugPx7r?=
 =?us-ascii?Q?dL7e+9L35WECQFO5BBvbwBGa1W1nlj9tsOdhmE3/uWKJ0DH/r+8DUrcekUqM?=
 =?us-ascii?Q?k8KucrISDPLhAAZXnXK2ZvD6MqNQoT63EtffjA32tZTJfs1kC9TWjpm5xxne?=
 =?us-ascii?Q?XoQGolhzbKpJSJNSNZJAm98kYI3Ha8GIDqSocsT+pS+FQGwmdThmFrlZ44QP?=
 =?us-ascii?Q?7CgBbKEandz6YoCXTBfe0EGEZVI6U3hXV2htvTWk6a0Nvd61J6WQ4X7ekDx3?=
 =?us-ascii?Q?PURktf2viKk+LfL92YVigHOBFQu8UM1QEKq0xFFsprdl3ZDd7phXYbOqVE1j?=
 =?us-ascii?Q?EZuY+xPtMXkF8CoxUc/aGmqkB3roG+zpy3HYLpAoTp03qf9BfgGVjaf8Mu8s?=
 =?us-ascii?Q?vZIfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: sRazt+I0Jin/JWYqH5VxsPWo9vVL1vf6rjF1j7/dh6AQLeKjqHOkqaQJks2MTidZyfzxC36cc6Y4AgxkSlleBHzuTlyPHLqZHELN5ypT0qx1eYcXQWb15ZgmFa6PVNKFWatzvY37FTZhQYPbp+Fp3VnqrmlMghypH82V3zaiRz8izCfrD3P7OJnOFqQGzmw4
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0015;6:pINpAUTkwWjy1Q58MwBEXJks+/Qz5BQFYFgaJ8BE7v7Uh/Nb8cNZSI3W3BNLYC97KHkVaipw59kToo8Sl91cGpkxhQTMcITWxiXhKc0afO636n4caWTMoWJs0mml2sD9vNKeUQWtj1nHpdV/x5/21xaYiAkmjcsjJKIzYsCP0DlpaQLWqStv7oKLop4ZWq5nI8a86EtKaVBR22hpJ2Foa6iW6y2ceifDJktNpNcymb3Uv6pghJSUXTS+3y3KJjR3G4qSpgYj7XUz1H2I0EyJ0u3lo0qNxeU+C/2htrK6CpdMULxYzRYxMufB++5TcG7Sy85XUkh4au7ZaXy4jeapnwrksX7WJpRU2wYvVahAA6U=;5:zFiHsLoxKUjs1pNyWtRKKrrkHJX4Hnw6eviSDXWVl/QcQf/Foxlunber2iaKlIMaOqEvTnjbKFdJHs4FKqHMRP0CZQnG8KVduyLqvvwUdZVN8I+dKaHCUExPJPK71UC8KPVLAqt9txZ5cGHa7VjBUSYmfgmu2fuHM0i2C7REHP4=;24:4rofbFuTcb+RbzzdN2O7hANY9aIW4Y66Z3LPgP9V1D5so6EMFP9+KFo4I8DHOoVl+4Txa1lJeLkAI0/2//Aqlxy+hF9u2A6BLZ+djO/uOGU=;7:GDg1l5m7NIShS4dEflYehaQHGfviGMAfwgdcj2F3yvnvha0yTZT3F4fg8sFZhV+4covbv9DQrIrqlhMQzY9oxol6sdRPyu3fLRjqECpJnh4Rxvn24T9uGZqZCpOsyDhPjPjt7lOrfJDU1A+qqOdfqa80Aan8c+7xWPrJ/PyJNAO6X2of5JxYjY2TigJqNjP7jpL9sAxo3l1bl1/2cfoC8KAtDfUUjHZKCVfSze9+zA5G/CqFmbiGaOvxB72HGAO3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 17:35:46.4497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c7fe9-d810-4172-857a-08d585e4328d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Hi,

Patches 1-5,9 are preparation and helper functions.
Patch 6-8,10 are the actual change. Patch 8 is new.

This series depends on Torsten's 8462ff43e4 (convert_to_git():
safe_crlf/checksafe becomes int conv_flags, 2018-01-13) which is
already in master.

Changes since v10:

* rename startscase_with() to istarts_with() (Duy)
* validate_encoding() advises the canonical form of the UTF
  encoding name to the user (Junio)
  --> I added it this as a separate commit that you could be dropped
      if desired by the reviewers.
* fix documentation for roundtrip check (Junio)
* use isspace() to check whitespace/tab delimiter
  in core.checkRoundtripEncoding (Junio)
* remove dead code in roundtrip check (Junio)
* fix invalid # in comment (Eric)
* detect UTF8 and UTF-8 as default encoding (Eric)
* make asterisk stick to the variable, not type (Junio)
* print an error if "w-t-e" does not have a proper value (Junio)
  --> BTW: I noticed that the attribute is not set to "git_attr__false"
      even if I define "-working-tree-encoding". I haven't investigated
      further yet. Might that be a bug? If yes, then this should be
      addresses in a separate patch series.

Thanks,
Lars


  RFC: https://public-inbox.org/git/BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com/
   v1: https://public-inbox.org/git/20171211155023.1405-1-lars.schneider@autodesk.com/
   v2: https://public-inbox.org/git/20171229152222.39680-1-lars.schneider@autodesk.com/
   v3: https://public-inbox.org/git/20180106004808.77513-1-lars.schneider@autodesk.com/
   v4: https://public-inbox.org/git/20180120152418.52859-1-lars.schneider@autodesk.com/
   v5: https://public-inbox.org/git/20180129201855.9182-1-tboegi@web.de/
   v6: https://public-inbox.org/git/20180209132830.55385-1-lars.schneider@autodesk.com/
   v7: https://public-inbox.org/git/20180215152711.158-1-lars.schneider@autodesk.com/
   v8: https://public-inbox.org/git/20180224162801.98860-1-lars.schneider@autodesk.com/
   v9: https://public-inbox.org/git/20180304201418.60958-1-lars.schneider@autodesk.com/
  v10: https://public-inbox.org/git/20180307173026.30058-1-lars.schneider@autodesk.com/

Base Ref:
Web-Diff: https://github.com/larsxschneider/git/commit/afc02ce2e0
Checkout: git fetch https://github.com/larsxschneider/git encoding-v11 && git checkout afc02ce2e0


### Interdiff (v10..v11):

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d7a56054a5..7dcac9b540 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -531,10 +531,10 @@ core.autocrlf::
 	in which case no output conversion is performed.

 core.checkRoundtripEncoding::
-	A comma separated list of encodings that Git performs UTF-8 round
-	trip checks on if they are used in an `working-tree-encoding`
-	attribute (see linkgit:gitattributes[5]). The default value is
-	`SHIFT-JIS`.
+	A comma and/or whitespace separated list of encodings that Git
+	performs UTF-8 round trip checks on if they are used in an
+	`working-tree-encoding` attribute (see linkgit:gitattributes[5]).
+	The default value is `SHIFT-JIS`.

 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
diff --git a/convert.c b/convert.c
index e861f1abbc..c2d24882c1 100644
--- a/convert.c
+++ b/convert.c
@@ -270,7 +270,7 @@ static int validate_encoding(const char *path, const char *enc,
 		      const char *data, size_t len, int die_on_error)
 {
 	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
-	if (startscase_with(enc, "UTF")) {
+	if (istarts_with(enc, "UTF")) {
 		/*
 		 * Check for detectable errors in UTF encodings
 		 */
@@ -284,12 +284,15 @@ static int validate_encoding(const char *path, const char *enc,
 			 */
 			const char *advise_msg = _(
 				"The file '%s' contains a byte order "
-				"mark (BOM). Please use %s as "
+				"mark (BOM). Please use UTF-%s as "
 				"working-tree-encoding.");
-			char *upper_enc = xstrdup_toupper(enc);
-			upper_enc[strlen(upper_enc)-2] = '\0';
-			advise(advise_msg, path, upper_enc);
-			free(upper_enc);
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
@@ -301,12 +304,15 @@ static int validate_encoding(const char *path, const char *enc,
 				"BOM is required in '%s' if encoded as %s");
 			const char *advise_msg = _(
 				"The file '%s' is missing a byte order "
-				"mark (BOM). Please use %sBE or %sLE "
+				"mark (BOM). Please use UTF-%sBE or UTF-%sLE "
 				"(depending on the byte order) as "
 				"working-tree-encoding.");
-			char *upper_enc = xstrdup_toupper(enc);
-			advise(advise_msg, path, upper_enc, upper_enc);
-			free(upper_enc);
+			const char *stripped = "";
+			char *upper = xstrdup_toupper(enc);
+			if (!skip_prefix(upper, "UTF-", &stripped))
+				skip_prefix(stripped, "UTF", &stripped);
+			advise(advise_msg, path, stripped, stripped);
+			free(upper);
 			if (die_on_error)
 				die(error_msg, path, enc);
 			else {
@@ -344,8 +350,8 @@ static void trace_encoding(const char *context, const char *path,
 static int check_roundtrip(const char *enc_name)
 {
 	/*
-	 * check_roundtrip_encoding contains a string of space and/or
-	 * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * check_roundtrip_encoding contains a string of comma and/or
+	 * space separated encodings (eg. "UTF-16, ASCII, CP1125").
 	 * Search for the given encoding in that string.
 	 */
 	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
@@ -362,8 +368,7 @@ static int check_roundtrip(const char* enc_name)
 			 * that it is prefixed with a space or comma
 			 */
 			found == check_roundtrip_encoding || (
-				found > check_roundtrip_encoding &&
-				(*(found-1) == ' ' || *(found-1) == ',')
+				(isspace(found[-1]) || found[-1] == ',')
 			)
 		) && (
 			/*
@@ -373,7 +378,7 @@ static int check_roundtrip(const char* enc_name)
 			 */
 			next == check_roundtrip_encoding + len || (
 				next < check_roundtrip_encoding + len &&
-				(*next == ' ' || *next == ',')
+				(isspace(next[0]) || next[0] == ',')
 			)
 		));
 }
@@ -1213,12 +1218,16 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
 {
 	const char *value = check->value;

-	if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value) ||
-	    !strlen(value))
+	if (ATTR_UNSET(value) || !strlen(value))
 		return NULL;

+	if (ATTR_TRUE(value) || ATTR_FALSE(value)) {
+		error(_("working-tree-encoding attribute requires a value"));
+		return NULL;
+	}
+
 	/* Don't encode to the default encoding */
-	if (!strcasecmp(value, default_encoding))
+	if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
 		return NULL;

 	return value;
diff --git a/git-compat-util.h b/git-compat-util.h
index f648da0c11..95c9b34832 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -455,7 +455,7 @@ extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));

 extern int starts_with(const char *str, const char *prefix);
-extern int startscase_with(const char *str, const char *prefix);
+extern int istarts_with(const char *str, const char *prefix);

 /*
  * If the string "str" begins with the string found in "prefix", return 1.
diff --git a/strbuf.c b/strbuf.c
index 5779a2d591..99812b8488 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -11,7 +11,7 @@ int starts_with(const char *str, const char *prefix)
 			return 0;
 }

-int startscase_with(const char *str, const char *prefix)
+int istarts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
 		if (!*prefix)
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 7cff41a350..07089bba2e 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -68,7 +68,7 @@ do
 		test_when_finished "git reset --hard HEAD" &&

 		echo "*.utf${i}be text working-tree-encoding=utf-${i}be" >>.gitattributes &&
-		echo "*.utf${i}le text working-tree-encoding=utf-${i}le" >>.gitattributes &&
+		echo "*.utf${i}le text working-tree-encoding=utf-${i}LE" >>.gitattributes &&

 		# Here we add a UTF-16 (resp. UTF-32) files with BOM (big/little-endian)
 		# but we tell Git to treat it as UTF-16BE/UTF-16LE (resp. UTF-32).
@@ -76,18 +76,22 @@ do
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
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out &&
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&

 		cp lebom.utf${i}le.raw lebom.utf${i}le &&
 		test_must_fail git add lebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}le" err.out
+		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out
 	'

 	test_expect_success "check required UTF-${i} BOM" '
@@ -98,10 +102,12 @@ do
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
@@ -143,9 +149,20 @@ done
 test_expect_success 'check unsupported encodings' '
 	test_when_finished "git reset --hard HEAD" &&

-	echo "*.nothing text working-tree-encoding=" >>.gitattributes &&
-	printf "nothing" >t.nothing &&
-	git add t.nothing &&
+	echo "*.set text working-tree-encoding" >>.gitattributes &&
+	printf "set" >t.set &&
+	git add t.set 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+
+	echo "*.unset text -working-tree-encoding" >>.gitattributes &&
+	printf "unset" >t.unset &&
+	git add t.unset 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&
+
+	echo "*.empty text working-tree-encoding=" >>.gitattributes &&
+	printf "empty" >t.empty &&
+	git add t.empty 2>err.out &&
+	test_i18ngrep "error: working-tree-encoding attribute requires a value" err.out &&

 	echo "*.garbage text working-tree-encoding=garbage" >>.gitattributes &&
 	printf "garbage" >t.garbage &&


### Patches

Lars Schneider (10):
  strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
  strbuf: add xstrdup_toupper()
  strbuf: add a case insensitive starts_with()
  utf8: add function to detect prohibited UTF-16/32 BOM
  utf8: add function to detect a missing UTF-16/32 BOM
  convert: add 'working-tree-encoding' attribute
  convert: check for detectable errors in UTF encodings
  convert: advise canonical UTF encoding names
  convert: add tracing for 'working-tree-encoding' attribute
  convert: add round trip check based on 'core.checkRoundtripEncoding'

 Documentation/config.txt         |   6 +
 Documentation/gitattributes.txt  |  88 +++++++++++++
 config.c                         |   5 +
 convert.c                        | 277 ++++++++++++++++++++++++++++++++++++++-
 convert.h                        |   2 +
 environment.c                    |   1 +
 git-compat-util.h                |   1 +
 sha1_file.c                      |   2 +-
 strbuf.c                         |  22 +++-
 strbuf.h                         |   1 +
 t/t0028-working-tree-encoding.sh | 247 ++++++++++++++++++++++++++++++++++
 utf8.c                           |  39 ++++++
 utf8.h                           |  28 ++++
 13 files changed, 716 insertions(+), 3 deletions(-)
 create mode 100755 t/t0028-working-tree-encoding.sh


base-commit: 8a2f0888555ce46ac87452b194dec5cb66fb1417
--
2.16.2

