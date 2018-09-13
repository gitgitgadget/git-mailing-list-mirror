Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105B51F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIMX2a (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:28:30 -0400
Received: from mail-sn1nam02on0107.outbound.protection.outlook.com ([104.47.36.107]:6240
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbeIMX2a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYAc2JbDEJRgBB8n0VgRyPGBz7rB3WLJttfYbaW59Rc=;
 b=ojE7tLQr04jZxoKrVNxc6le04AUsOa4ClUWz3Bp1Q4lG5YuOphFe2w0ho/rUw/ivsuk7VRgodjtCDRE/2m3YPqdfNp8PRZtzCzrJLoVkhvFNtt9CJ3TagAJpzQt+9mAIkaKrjC49ZEliA5WhMNjbN14qSaMALycGGJ7f5ycN3nU=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB0908.namprd21.prod.outlook.com (52.132.152.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Thu, 13 Sep 2018 18:17:48 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.008; Thu, 13 Sep 2018
 18:17:48 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Topic: [PATCH v2] read-cache: update TEST_GIT_INDEX_VERSION support
Thread-Index: AQHUS44TFuTMiKk2R0qWgzAdJ39f7A==
Date:   Thu, 13 Sep 2018 18:17:48 +0000
Message-ID: <20180913181730.33472-1-benpeart@microsoft.com>
References: <20180912212544.33624-1-benpeart@microsoft.com>
In-Reply-To: <20180912212544.33624-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CO2PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:102:2::46) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0908;6:g9RdDSAuIdTPgAI4xwjq1e/HuYznJBnlzNZbNArjkn+8V4ongbAaZoofvku3LVxv1WOLWc/anxWzNXLULJngVoVpp907ZOm2oisbwXu05JkNLddzCfYTCYWvvUZqHsJFItBxmS03Z/sNyssMqtIGcx2PGRKP2tN0/IDKMXrwCZ6Kw8heQMDMfPsZ/+ZsoMOFwO0PXIs3yETUS0HA41j/JW9vsldXPCkOdxdndlb7Nf+5xEXRISxrStevH/bX3OTVTlXfH4JD13SY1M6hy9kSJHSLDOYSA6myolrezzsOduSi0rhqkeHzYeKECNy/T48pFz9PCCSvHimRgTXlvDUsU6RWDbAOOLaTB2va0AaYtdQi/i6Rs9BkJ0hN8ZPS9kWeA99OSDqT3WVs3Nl6XDHl8AVuFUY9E94lN0KTpAcyrIhxD730ZEvqbZFX0jgrI+3ws1A1fbnivGuyhlGOSr2tyg==;5:JsAk8Sb96L9ObS/blyqpnJ3mcyVvC+Y6OD59AReFWvB1LJ/ShZTVQFsSV0pgGGvHhZmkUl5ZSFaIBcrrv6JgwDP7j0wn7n5W30IgTo/RPhnBo6azA7q7MIhd4x64t6kC2dl9MPdkuEA2OErpHauySEUXka3VGTotRIAy2TXX5Ns=;7:y1+2J24DxvkcmU739r1fBUfQrxScDAWv7Ns6PpNpt8NJV68rKa1wURlNR6m8elXgxMGfK0qCHDxGKpihl6aDpUf30iAH6fQ+E/VfRveO64Dogc8IRbKnvtQiarfKUWQ1HxHt5YhYHkrtF8rccVgZ2Hj6+H5ZwlaYmXeABdTRyeNfWNvD+08GrC7dtD/BBgsbbzoJBg2WtGEludcCeaBOcWwMlvljWpjv7LJV3smJjtEth+keGVWt2Mhhs3/8adN0
x-ms-office365-filtering-correlation-id: fe699bf3-0426-451c-85f8-08d619a535a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB0908;
x-ms-traffictypediagnostic: MW2PR2101MB0908:
x-microsoft-antispam-prvs: <MW2PR2101MB090872E5055B8F5538B543CBF41A0@MW2PR2101MB0908.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:MW2PR2101MB0908;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0908;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(7736002)(1076002)(6346003)(102836004)(386003)(105586002)(6506007)(26005)(6862004)(6636002)(5660300001)(6116002)(3846002)(22452003)(53936002)(72206003)(10290500003)(966005)(81166006)(66066001)(25786009)(478600001)(99286004)(1511001)(305945005)(106356001)(81156014)(8676002)(86612001)(37006003)(14454004)(6512007)(6306002)(54906003)(68736007)(50226002)(76176011)(52116002)(316002)(2900100001)(8936002)(36756003)(10090500001)(2906002)(4326008)(6486002)(97736004)(14444005)(5250100002)(446003)(2616005)(256004)(486006)(575784001)(476003)(11346002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0908;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: HqBEcFxCx1qgxpZNbFT6BTqYPSJtrq4Uu96XoFOF0XChzSfTHm3icF4Yt0y6oyxqfX43gYW/TC4lhEeoVTVTc7NYcX2v39Lt8lc8BjsixwnNtjwjNCfr5G1X8DHjPU84FKKbWCQ+4u/IIyBRI75nkXKy5QLUIrW7tbEci+9MFWiIZ7/ZqjD8Z7V2d7qMeBDCRZNJUgq81oWnTZfcEmiBQp4KBAfwS1+G3bax6a6M8zrPEXxiR6LUHenJQhXqxlZchhFW6GBbWGSKV223ZanViiFB18oiRYywPaHz97NFrjzP9KTqizH+fO7BklsdDZ3Pc2JVdUZm4L6qhVIAUfQt3K2MBptzbyy9ZDHiw+3sIzk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe699bf3-0426-451c-85f8-08d619a535a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 18:17:48.6470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0908
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename TEST_GIT_INDEX_VERSION to GIT_TEST_INDEX_VERSION for consistency wit=
h
the other GIT_TEST_ special setups and properly document its use.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---

Notes:
    Base Ref: v2.19.0
    Web-Diff: https://github.com/benpeart/git/commit/e26ccb9004
    Checkout: git fetch https://github.com/benpeart/git git-test-index-vers=
ion-v2 && git checkout e26ccb9004
   =20
    ### Interdiff (v1..v2):
   =20
    diff --git a/Makefile b/Makefile
    index 5a969f5830..9e84ef02f7 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -400,7 +400,7 @@ all::
     # (defaults to "man") if you want to have a different default when
     # "git help" is called without a parameter specifying the format.
     #
    -# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
    +# Define GIT_TEST_INDEX_VERSION to 2, 3 or 4 to run the test suite
     # with a different indexfile format version.  If it isn't set the inde=
x
     # file format used is index-v[23].
     #
    @@ -2599,8 +2599,8 @@ endif
     ifdef GIT_INTEROP_MAKE_OPTS
     	@echo GIT_INTEROP_MAKE_OPTS=3D\''$(subst ','\'',$(subst ','\'',$(GIT_=
INTEROP_MAKE_OPTS)))'\' >>$@+
     endif
    -ifdef TEST_GIT_INDEX_VERSION
    -	@echo TEST_GIT_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(TES=
T_GIT_INDEX_VERSION)))'\' >>$@+
    +ifdef GIT_TEST_INDEX_VERSION
    +	@echo GIT_TEST_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(GIT=
_TEST_INDEX_VERSION)))'\' >>$@+
     endif
     	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
   =20
    diff --git a/read-cache.c b/read-cache.c
    index d140ce9989..7b1354d759 100644
    --- a/read-cache.c
    +++ b/read-cache.c
    @@ -1570,45 +1570,26 @@ static unsigned int get_index_format_default(vo=
id)
     	char *envversion =3D getenv("GIT_INDEX_VERSION");
     	char *endp;
     	int value;
    -	unsigned int version =3D -1;
    +	unsigned int version =3D INDEX_FORMAT_DEFAULT;
   =20
    -	if (envversion) {
    -		version =3D strtoul(envversion, &endp, 10);
    -		if (*endp ||
    -			version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
    -			warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
    -				"Using version %i"), INDEX_FORMAT_DEFAULT);
    -			version =3D INDEX_FORMAT_DEFAULT;
    -		}
    -	}
    -
    -	if (version =3D=3D -1) {
    -		if (!git_config_get_int("index.version", &value)) {
    +	if (!envversion) {
    +		if (!git_config_get_int("index.version", &value))
     			version =3D value;
     		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
     			warning(_("index.version set, but the value is invalid.\n"
     				  "Using version %i"), INDEX_FORMAT_DEFAULT);
    -				version =3D INDEX_FORMAT_DEFAULT;
    -			}
    +			return INDEX_FORMAT_DEFAULT;
     		}
    +		return version;
     	}
   =20
    -	if (version =3D=3D -1) {
    -		envversion =3D getenv("GIT_TEST_INDEX_VERSION");
    -		if (envversion) {
     	version =3D strtoul(envversion, &endp, 10);
     	if (*endp ||
     	    version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
    -				warning(_("GIT_TEST_INDEX_VERSION set, but the value is invalid.\n=
"
    +		warning(_("GIT_INDEX_VERSION set, but the value is invalid.\n"
     			  "Using version %i"), INDEX_FORMAT_DEFAULT);
     		version =3D INDEX_FORMAT_DEFAULT;
     	}
    -		}
    -	}
    -
    -	if (version =3D=3D -1)
    -		version =3D INDEX_FORMAT_DEFAULT;
    -
     	return version;
     }
   =20
    diff --git a/t/README b/t/README
    index f872638a78..fb6359b17b 100644
    --- a/t/README
    +++ b/t/README
    @@ -320,8 +320,7 @@ path where deltas larger than this limit require ex=
tra memory
     allocation for bookkeeping.
   =20
     GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/write code path
    -for the index version specified.  Can be set to any valid version
    -but the non-default version 4 is probably the most beneficial.
    +for the index version specified.  Can be set to any valid version.
   =20
     Naming Tests
     ------------
    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index 44288cbb59..31698c01c4 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -134,9 +134,9 @@ export EDITOR
     GIT_TRACE_BARE=3D1
     export GIT_TRACE_BARE
   =20
    -if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
    +if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
     then
    -	GIT_INDEX_VERSION=3D"$TEST_GIT_INDEX_VERSION"
    +	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
     	export GIT_INDEX_VERSION
     fi
   =20
    ### Patches

 Makefile      | 6 +++---
 t/README      | 5 ++++-
 t/test-lib.sh | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 5a969f5830..9e84ef02f7 100644
--- a/Makefile
+++ b/Makefile
@@ -400,7 +400,7 @@ all::
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
 #
-# Define TEST_GIT_INDEX_VERSION to 2, 3 or 4 to run the test suite
+# Define GIT_TEST_INDEX_VERSION to 2, 3 or 4 to run the test suite
 # with a different indexfile format version.  If it isn't set the index
 # file format used is index-v[23].
 #
@@ -2599,8 +2599,8 @@ endif
 ifdef GIT_INTEROP_MAKE_OPTS
 	@echo GIT_INTEROP_MAKE_OPTS=3D\''$(subst ','\'',$(subst ','\'',$(GIT_INTE=
ROP_MAKE_OPTS)))'\' >>$@+
 endif
-ifdef TEST_GIT_INDEX_VERSION
-	@echo TEST_GIT_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(TEST_GI=
T_INDEX_VERSION)))'\' >>$@+
+ifdef GIT_TEST_INDEX_VERSION
+	@echo GIT_TEST_INDEX_VERSION=3D\''$(subst ','\'',$(subst ','\'',$(GIT_TES=
T_INDEX_VERSION)))'\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
=20
diff --git a/t/README b/t/README
index 9028b47d92..fb6359b17b 100644
--- a/t/README
+++ b/t/README
@@ -315,10 +315,13 @@ packs on demand. This normally only happens when the =
object size is
 over 2GB. This variable forces the code path on any object larger than
 <n> bytes.
=20
-GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncomon pack-objects code
+GIT_TEST_OE_DELTA_SIZE=3D<n> exercises the uncommon pack-objects code
 path where deltas larger than this limit require extra memory
 allocation for bookkeeping.
=20
+GIT_TEST_INDEX_VERSION=3D<n> exercises the index read/write code path
+for the index version specified.  Can be set to any valid version.
+
 Naming Tests
 ------------
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 44288cbb59..31698c01c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,9 +134,9 @@ export EDITOR
 GIT_TRACE_BARE=3D1
 export GIT_TRACE_BARE
=20
-if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
 then
-	GIT_INDEX_VERSION=3D"$TEST_GIT_INDEX_VERSION"
+	GIT_INDEX_VERSION=3D"$GIT_TEST_INDEX_VERSION"
 	export GIT_INDEX_VERSION
 fi
=20

base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
--=20
2.18.0.windows.1

