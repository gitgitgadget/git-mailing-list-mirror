Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F12D1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeILE2P (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:28:15 -0400
Received: from mail-eopbgr680120.outbound.protection.outlook.com ([40.107.68.120]:1880
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbeILE2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ2R5f6NvG/OTK8XUo+j9/RcZScWOrKjKtOjZCTlPdU=;
 b=hRIgnyFGNrMiKfgF5aQdEfHa2nAORAiQ3q8E8Jz0wBLE2swCj9w8o26fT9MkKvhMupmB0yFwcNfbcuJSPWWR2I4bgO4/d9rfvZjY6n4xHyB2DJYL+a9qVwEko86LRaDtMgTfDEcthlv8+cq14CxGlFudIL6VrrpISDsxlx/JDcw=
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com (52.132.146.19) by
 MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Tue, 11 Sep 2018 23:26:36 +0000
Received: from MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7]) by MW2PR2101MB0970.namprd21.prod.outlook.com
 ([fe80::3c7b:f2aa:d871:8ae7%2]) with mapi id 15.20.1164.006; Tue, 11 Sep 2018
 23:26:36 +0000
From:   Ben Peart <benpeart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v4 1/5] eoie: add End of Index Entry (EOIE) extension
Thread-Topic: [PATCH v4 1/5] eoie: add End of Index Entry (EOIE) extension
Thread-Index: AQHUSibiISw9XElqA0+ymtlwz5sF5w==
Date:   Tue, 11 Sep 2018 23:26:36 +0000
Message-ID: <20180911232615.35904-2-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180911232615.35904-1-benpeart@microsoft.com>
In-Reply-To: <20180911232615.35904-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.18.0.windows.1
x-clientproxiedby: CY4PR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:910:72::34) To MW2PR2101MB0970.namprd21.prod.outlook.com
 (2603:10b6:302:4::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;6:Pgc/fpkTQ8Lf+KlTVY2uXdptLAiiinoM2nZ0PtKKjWHNbPtGWALeMlHOhXziTLekIttlik+6i2ZyYMS96LK2cSixMHmakYLaLlF6AHvNAVJm0re67JdzGHgDJ1je4RgSDrYLdZRG4cBG+KM8vX+rWCrsLh9pGLiY9W/OIOqvu1hyRXUcqZ51+LZaLr5EfpQNHDu7NkuSKGHuSP4T7IW3F2Rck1Y4zSJjPoJ5FVaa3XirllpIiFYouh8RtVTdHURF82xFnF71T2vxvU7o8+hErd5H5RgRF0gfvpw2OYMdjWo71vReLQukYmkVux4Vn9AnyH6NQpOBA6HFQ1JdS4e+sFdCPw7orLMQcRh7VdyARt85eytJ2G5hJkRdLPZrWJiBwrz8tb8u+pRIjIlMM4IWJFKqPmOoh0UXfLTfxrjKnnrYN7XLUzKrcEWA9WKjXT8wmNepCuw27nc9wt3yce2evA==;5:40ADR2bzdXCQy3zfXs4EHZLNMUztpEUmUn6dGYxy/AXIlXGrXWJhcfSpET43oEKOalL2V4XtFOp4E6mXyCpbxNDpp2wKTmZh1mpNJb0mkcnhNzNii3j/6N6R5bAoFZvZ8yewOfjH0e4c7bmFAS4pD6fmMQsc+e2eWOs2z95ODI8=;7:RMMYuDzJ48GQKQVxbUS0E72tZ+Urh8Gpy/V8Adi2y7sw67d2ERox3UZQqsFRQEbPJU98e246bWV8WM4Ml91m/0xwOX2P4m1nzTw3cVgQLK2xW4SnHH6IXQ5Fub0X3z2HT8gOhyfBkwaeX4A5PrO22aO/TrjqDPtqhxsNy92aADoSvyArrsPrKceShN9Z1mOhpI5E+tM8tM5xLnP33PlnSd8IXXeAmRa3gAV+SdOVxz/rPOW1rnrp16Hx8oUTWpCq
x-ms-office365-filtering-correlation-id: 3088cdc8-b9ac-4fa6-7f68-08d6183e042a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113B25E0C989CE7871E26ECF4040@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050)(76991037);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(386003)(6116002)(97736004)(6506007)(86612001)(7736002)(5640700003)(575784001)(81156014)(81166006)(26005)(2900100001)(102836004)(6436002)(1730700003)(6346003)(305945005)(11346002)(14444005)(446003)(2616005)(476003)(486006)(3846002)(256004)(36756003)(10090500001)(66066001)(186003)(53936002)(1076002)(106356001)(105586002)(2351001)(6512007)(316002)(4326008)(54906003)(2906002)(52116002)(25786009)(5660300001)(107886003)(68736007)(22452003)(76176011)(39060400002)(6916009)(50226002)(478600001)(2501003)(99286004)(72206003)(14454004)(5250100002)(8936002)(8676002)(10290500003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB0970.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: qe91Q64jdtwWb9rSlWkG4gDjZsnqURrg0GiT/8OEOPB5cp2EtGXj3ZPGbN3z8Ilenuu6N66IahBTP+mT+garVrIzn8PDARLa6xaXe4PH2YS/bM/4aBxszOQv36MMC1DIhOhZQJ7aiXJo+TeCRmi6j2Fw50Mx5VIn4B697aq3Zp9HAqjzgeodnlxjHi/aywDIK6GNssZ1vXLRoRZtUrdpD8BCJnl3JA6OmbXR1pA/JzTRJbHUAd5e2yB1g4Sq6T69D5ciNnoEuEq4KUUsvXbRfZ4xq8N1TvwPdMNoXtlkDCdTO9E5pL6FYXRyQGind+EacsQ2boBj9Msid1/3UybbgHcIYGeDXDQyJdMVup7w4Pg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3088cdc8-b9ac-4fa6-7f68-08d6183e042a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 23:26:36.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The End of Index Entry (EOIE) is used to locate the end of the variable
length index entries and the beginning of the extensions. Code can take
advantage of this to quickly locate the index extensions without having
to parse through all of the index entries.

Because it must be able to be loaded before the variable length cache
entries and other index extensions, this extension must be written last.
The signature for this extension is { 'E', 'O', 'I', 'E' }.

The extension consists of:

- 32-bit offset to the end of the index entries

- 160-bit SHA-1 over the extension types and their sizes (but not
their contents).  E.g. if we have "TREE" extension that is N-bytes
long, "REUC" extension that is M-bytes long, followed by "EOIE",
then the hash would be:

SHA-1("TREE" + <binary representation of N> +
	"REUC" + <binary representation of M>)

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 Documentation/technical/index-format.txt |  23 ++++
 read-cache.c                             | 154 +++++++++++++++++++++--
 2 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/techn=
ical/index-format.txt
index db3572626b..6bc2d90f7f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -314,3 +314,26 @@ The remaining data of each directory block is grouped =
by type:
=20
   - An ewah bitmap, the n-th bit indicates whether the n-th index entry
     is not CE_FSMONITOR_VALID.
+
+=3D=3D End of Index Entry
+
+  The End of Index Entry (EOIE) is used to locate the end of the variable
+  length index entries and the begining of the extensions. Code can take
+  advantage of this to quickly locate the index extensions without having
+  to parse through all of the index entries.
+
+  Because it must be able to be loaded before the variable length cache
+  entries and other index extensions, this extension must be written last.
+  The signature for this extension is { 'E', 'O', 'I', 'E' }.
+
+  The extension consists of:
+
+  - 32-bit offset to the end of the index entries
+
+  - 160-bit SHA-1 over the extension types and their sizes (but not
+	their contents).  E.g. if we have "TREE" extension that is N-bytes
+	long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	then the hash would be:
+
+	SHA-1("TREE" + <binary representation of N> +
+		"REUC" + <binary representation of M>)
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..2abac0a7a2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -43,6 +43,7 @@
 #define CACHE_EXT_LINK 0x6c696e6b	  /* "link" */
 #define CACHE_EXT_UNTRACKED 0x554E5452	  /* "UNTR" */
 #define CACHE_EXT_FSMONITOR 0x46534D4E	  /* "FSMN" */
+#define CACHE_EXT_ENDOFINDEXENTRIES 0x454F4945	/* "EOIE" */
=20
 /* changes that can be kept in $GIT_DIR/index (basically all extensions) *=
/
 #define EXTMASK (RESOLVE_UNDO_CHANGED | CACHE_TREE_CHANGED | \
@@ -1693,6 +1694,9 @@ static int read_index_extension(struct index_state *i=
state,
 	case CACHE_EXT_FSMONITOR:
 		read_fsmonitor_extension(istate, data, sz);
 		break;
+	case CACHE_EXT_ENDOFINDEXENTRIES:
+		/* already handled in do_read_index() */
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1889,6 +1893,11 @@ static size_t estimate_cache_size(size_t ondisk_size=
, unsigned int entries)
 	return ondisk_size + entries * per_entry;
 }
=20
+#ifndef NO_PTHREADS
+static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size);
+#endif
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset);
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_e=
xist)
 {
@@ -2198,11 +2207,15 @@ static int ce_write(git_hash_ctx *context, int fd, =
void *data, unsigned int len)
 	return 0;
 }
=20
-static int write_index_ext_header(git_hash_ctx *context, int fd,
-				  unsigned int ext, unsigned int sz)
+static int write_index_ext_header(git_hash_ctx *context, git_hash_ctx *eoi=
e_context,
+				  int fd, unsigned int ext, unsigned int sz)
 {
 	ext =3D htonl(ext);
 	sz =3D htonl(sz);
+	if (eoie_context) {
+		the_hash_algo->update_fn(eoie_context, &ext, 4);
+		the_hash_algo->update_fn(eoie_context, &sz, 4);
+	}
 	return ((ce_write(context, fd, &ext, 4) < 0) ||
 		(ce_write(context, fd, &sz, 4) < 0)) ? -1 : 0;
 }
@@ -2445,7 +2458,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 {
 	uint64_t start =3D getnanotime();
 	int newfd =3D tempfile->fd;
-	git_hash_ctx c;
+	git_hash_ctx c, eoie_c;
 	struct cache_header hdr;
 	int i, err =3D 0, removed, extended, hdr_version;
 	struct cache_entry **cache =3D istate->cache;
@@ -2454,6 +2467,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 	struct ondisk_cache_entry_extended ondisk;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
 	int drop_cache_tree =3D istate->drop_cache_tree;
+	unsigned long offset;
=20
 	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -2520,11 +2534,13 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
 		return err;
=20
 	/* Write extension data here */
+	offset =3D lseek(newfd, 0, SEEK_CUR) + write_buffer_len;
+	the_hash_algo->init_fn(&eoie_c);
 	if (!strip_extensions && istate->split_index) {
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		err =3D write_link_extension(&sb, istate) < 0 ||
-			write_index_ext_header(&c, newfd, CACHE_EXT_LINK,
+			write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_LINK,
 					       sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2535,7 +2551,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		cache_tree_write(&sb, istate->cache_tree);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_TREE, sb.le=
n) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2545,7 +2561,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		resolve_undo_write(&sb, istate->resolve_undo);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_RESOLVE_UND=
O,
 					     sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2556,7 +2572,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		write_untracked_extension(&sb, istate->untracked);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_UNTRACKED,
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_UNTRACKED,
 					     sb.len) < 0 ||
 			ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
@@ -2567,7 +2583,23 @@ static int do_write_index(struct index_state *istate=
, struct tempfile *tempfile,
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		write_fsmonitor_extension(&sb, istate);
-		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_FSMONITOR, sb.len) <=
 0
+		err =3D write_index_ext_header(&c, &eoie_c, newfd, CACHE_EXT_FSMONITOR, =
sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
+
+	/*
+	 * CACHE_EXT_ENDOFINDEXENTRIES must be written as the last entry before t=
he SHA1
+	 * so that it can be found and processed before all the index entries are
+	 * read.
+	 */
+	if (!strip_extensions && offset) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		write_eoie_extension(&sb, &eoie_c, offset);
+		err =3D write_index_ext_header(&c, NULL, newfd, CACHE_EXT_ENDOFINDEXENTR=
IES, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
 		strbuf_release(&sb);
 		if (err)
@@ -2978,3 +3010,109 @@ int should_validate_cache_entries(void)
=20
 	return validate_index_cache_entries;
 }
+
+#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash>=
 */
+#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + =
<4-byte length> + EOIE_SIZE */
+
+#ifndef NO_PTHREADS
+static unsigned long read_eoie_extension(void *mmap_, size_t mmap_size)
+{
+	/*
+	 * The end of index entries (EOIE) extension is guaranteed to be last
+	 * so that it can be found by scanning backwards from the EOF.
+	 *
+	 * "EOIE"
+	 * <4-byte length>
+	 * <4-byte offset>
+	 * <20-byte hash>
+	 */
+	const char *mmap =3D mmap_;
+	const char *index, *eoie;
+	uint32_t extsize;
+	unsigned long offset, src_offset;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	git_hash_ctx c;
+
+	/* ensure we have an index big enough to contain an EOIE extension */
+	if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the=
_hash_algo->rawsz)
+		return 0;
+
+	/* validate the extension signature */
+	index =3D eoie =3D mmap + mmap_size - EOIE_SIZE_WITH_HEADER - the_hash_al=
go->rawsz;
+	if (CACHE_EXT(index) !=3D CACHE_EXT_ENDOFINDEXENTRIES)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/* validate the extension size */
+	extsize =3D get_be32(index);
+	if (extsize !=3D EOIE_SIZE)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/*
+	 * Validate the offset we're going to look for the first extension
+	 * signature is after the index header and before the eoie extension.
+	 */
+	offset =3D get_be32(index);
+	if (mmap + offset < mmap + sizeof(struct cache_header))
+		return 0;
+	if (mmap + offset >=3D eoie)
+		return 0;
+	index +=3D sizeof(uint32_t);
+
+	/*
+	 * The hash is computed over extension types and their sizes (but not
+	 * their contents).  E.g. if we have "TREE" extension that is N-bytes
+	 * long, "REUC" extension that is M-bytes long, followed by "EOIE",
+	 * then the hash would be:
+	 *
+	 * SHA-1("TREE" + <binary representation of N> +
+	 *               "REUC" + <binary representation of M>)
+	 */
+	src_offset =3D offset;
+	the_hash_algo->init_fn(&c);
+	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEA=
DER) {
+		/* After an array of active_nr index entries,
+		 * there can be arbitrary number of extended
+		 * sections, each of which is prefixed with
+		 * extension name (4-byte) and section length
+		 * in 4-byte network byte order.
+		 */
+		uint32_t extsize;
+		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
+		extsize =3D ntohl(extsize);
+
+		/* verify the extension size isn't so large it will wrap around */
+		if (src_offset + 8 + extsize < src_offset)
+			return 0;
+
+		the_hash_algo->update_fn(&c, mmap + src_offset, 8);
+
+		src_offset +=3D 8;
+		src_offset +=3D extsize;
+	}
+	the_hash_algo->final_fn(hash, &c);
+	if (hashcmp(hash, (const unsigned char *)index))
+		return 0;
+
+	/* Validate that the extension offsets returned us back to the eoie exten=
sion. */
+	if (src_offset !=3D mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEA=
DER)
+		return 0;
+
+	return offset;
+}
+#endif
+
+static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_con=
text, unsigned long offset)
+{
+	uint32_t buffer;
+	unsigned char hash[GIT_MAX_RAWSZ];
+
+	/* offset */
+	put_be32(&buffer, offset);
+	strbuf_add(sb, &buffer, sizeof(uint32_t));
+
+	/* hash */
+	the_hash_algo->final_fn(hash, eoie_context);
+	strbuf_add(sb, hash, the_hash_algo->rawsz);
+}
--=20
2.18.0.windows.1

