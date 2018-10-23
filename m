Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C341F453
	for <e@80x24.org>; Tue, 23 Oct 2018 16:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeJXAfL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:35:11 -0400
Received: from mout.web.de ([212.227.15.14]:47455 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeJXAfL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:35:11 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpqx-1g8eZH1FHb-00WqUO; Tue, 23
 Oct 2018 18:11:08 +0200
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpqx-1g8eZH1FHb-00WqUO; Tue, 23
 Oct 2018 18:11:08 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v2 1/1] Use off_t instead of size_t for functions dealing with streamed checkin
Date:   Tue, 23 Oct 2018 18:11:06 +0200
Message-Id: <20181023161106.10097-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <20181018191140.23318-1-tboegi@web.de>
References: <20181018191140.23318-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:874QmUxCTmvJ3Ws1MSuXU1goilSW414K5Ab+q/0icaaIyrMDz3Y
 SF+ASXLJuJtaJIhXGIGC6U6aEjv4w3a/tnKW39mxmx9ZKjIYMd7r0vc9qj6su8A1hjie4O/
 jm1xmAudYTKw5lwkoCT2HFxJ2pV0dZn4Vtl3cpUS//ULiA9ZYewS7dk+Q7L+V2mGfEoiEHl
 tvgp6dLHVjs3VGEQKO+OQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ceDwjIv/Jk8=:yYfxPyRImD0kEK8epwb7BN
 +SxFBw8/X6DbAIGD6CEd6zGJSKB43nAWop+zOnAoItaV9SNBodNVA7LNWJpvaosKI2K+b8Y+0
 otBF+T1t9EIEsyz+HHGlfaXkxYa+QhmVIjXzIW0XM7E2sQdDuxEHUekDrFg1FMxoozLPQcWTs
 dO+YzLTIjGqzIZTjoqa7OVWV7PIEGMBcdyMNBANS0rLWHuBAxVqld+9ZQKv7uvedvKV3rVnVJ
 QEnXaz8Yybg+zG1cQN68J1LUB9d1RvqS3lgPzCXglWySr636jKpV1QrEnN3zDgbjWkAwpU1YB
 lCfpNGe4fnIC75AVimk2REhu8jfGgx8EdYglld/MZpWPLiZY8rsJkQlOIRIYePcxVK1PGnJr5
 Bycabdw0HGvQYDOqNS5WVrzbXoWPMAAC5sf119p0ugRMEo7gSRNoAv/ZZEatnkrEfHgguYCzS
 1Ex0tsMoE601mPuz8XvQY/hSX/DFSA9ZEFVi83T50O2ES6a3xf0bOlSO9+haYCf7bmM3wx+4w
 nkaQi6jezaWQb3QfLhNfnbLxPGfjrRU2ROZqp479UFElitgsNi6s9fT/JkWoRE3avvb9LC/ta
 SAj9YLmK0OYDT6h5vut6vuHeTNZYPT/o7GeMOg2JK+XZKUQHXrE5s4Iclr0SV03BRbRs2r7BY
 S08qYe9vHeO2DdVgXCe+UWENWhYeFfa+ApGt6XJlCwQwOGwsugMnJ7tAewXDSecFriHaHSj0X
 TbAi85Z3DWeCMBpP5oqKveebW09jhnGYuAPv/y159dCTI261ldrZB59maNfjmPPBu3bMit6Cb
 HApfvnMtfCFiB3KxCgH0+6pCjcASJaqCjF31HrrfHmqZh96OkM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When streaming data from disk into a blob, it should be possible to commit
a file with a file size > 4 GiB using the streaming functionality in Git.
Because of the streaming there is no need to load the whole data into
memory at once.
Today this is not possible on e.g. a 32 bit Linux system.
There is no good reason to limit the length of the file by using a size_t
in the code, which is a 32 bit value.
Loosen this restriction and use off_t instead of size_t in the call chain.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This is a suggestion for V2, changing even sha1-file.c,
so that the whole patch makes more sense.
The initial commit of a >4Gib file was tested on a 32 bit system

I didn't remove the wrapper functions, as I don't know
what their purpose is.

And: The commit message may need some tweaking, though

bulk-checkin.c | 6 +++---
 bulk-checkin.h | 2 +-
 sha1-file.c    | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 409ecb566b..34dbf5c4ea 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -96,7 +96,7 @@ static int already_written(struct bulk_checkin_state *state, struct object_id *o
  */
 static int stream_to_pack(struct bulk_checkin_state *state,
 			  git_hash_ctx *ctx, off_t *already_hashed_to,
-			  int fd, size_t size, enum object_type type,
+			  int fd, off_t size, enum object_type type,
 			  const char *path, unsigned flags)
 {
 	git_zstream s;
@@ -189,7 +189,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 
 static int deflate_to_pack(struct bulk_checkin_state *state,
 			   struct object_id *result_oid,
-			   int fd, size_t size,
+			   int fd, off_t size,
 			   enum object_type type, const char *path,
 			   unsigned flags)
 {
@@ -258,7 +258,7 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 }
 
 int index_bulk_checkin(struct object_id *oid,
-		       int fd, size_t size, enum object_type type,
+		       int fd, off_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
 	int status = deflate_to_pack(&state, oid, fd, size, type,
diff --git a/bulk-checkin.h b/bulk-checkin.h
index f438f93811..09b2affdf3 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -7,7 +7,7 @@
 #include "cache.h"
 
 extern int index_bulk_checkin(struct object_id *oid,
-			      int fd, size_t size, enum object_type type,
+			      int fd, off_t size, enum object_type type,
 			      const char *path, unsigned flags);
 
 extern void plug_bulk_checkin(void);
diff --git a/sha1-file.c b/sha1-file.c
index a4367b8f04..98d0f50ffa 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1934,7 +1934,7 @@ static int index_core(struct object_id *oid, int fd, size_t size,
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_stream(struct object_id *oid, int fd, size_t size,
+static int index_stream(struct object_id *oid, int fd, off_t size,
 			enum object_type type, const char *path,
 			unsigned flags)
 {
@@ -1959,8 +1959,7 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 		ret = index_core(oid, fd, xsize_t(st->st_size), type, path,
 				 flags);
 	else
-		ret = index_stream(oid, fd, xsize_t(st->st_size), type, path,
-				   flags);
+		ret = index_stream(oid, fd, st->st_size, type, path, flags);
 	close(fd);
 	return ret;
 }
-- 
2.11.0

