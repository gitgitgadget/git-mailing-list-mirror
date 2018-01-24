Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2411F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeAXLOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:35 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:43867 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933331AbeAXLOc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:32 -0500
X-AuditID: 12074413-cf5ff70000000aec-be-5a686a96cb9d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AE.93.02796.69A686A5; Wed, 24 Jan 2018 06:14:30 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIi9004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:28 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] load_contents(): don't try to mmap an empty file
Date:   Wed, 24 Jan 2018 12:14:15 +0100
Message-Id: <f06611f06a8b01843bd71cd9fedec0f1eb0ee551.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqDstKyPKoGettkXXlW4mi4beK8wW
        /cu72CwOds5ktbi9Yj6zxY+WHmYHNo+/7z8weXz4GOfRd2QNo8ez3j2MHhcvKXt83iQXwBbF
        ZZOSmpNZllqkb5fAlbGs8x5zwQH+ik/f9rA0MB7h6WLk5JAQMJF4NPMLexcjF4eQwA4miaVb
        prNBOJeYJJYcmsoOUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngNKPErv3LWEASwgKuEs3PzjOD
        2CwCqhJTp+8Aa+AViJL40djGDrFOXuL9gvuMIDangINE945LbCC2kIC9RPe1Q0C9HEBxC4nL
        i7RATCEBc4k7/3gmMPItYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRES
        esI7GHedlDvEKMDBqMTDe8MiPUqINbGsuDL3EKMkB5OSKG9+UEaUEF9SfkplRmJxRnxRaU5q
        8SFGCQ5mJRHePFagct6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwGB4dA75rV
        FxilWPLy81KVJHjPZgItECxKTU+tSMvMKUEoZeLgBFnEA7RoQwZQDW9xQWJucWY6RP4Uoy7H
        jRev25iFwAZJifNWgAwSACnKKM2DmwNLJa8YxYFeFOZdDFLFA0xDcJNeAS1hAlpyoyYVZElJ
        IkJKqoGxoCooXu3wnfuPbQ23bz2h7lO3KuXxqQeuav/qvsTaXb6vdnfVstwfDDez+VQjQ1SS
        14nf0Frz6OvHu21N/9Omf325peLbU+GoDV/viZguY/vYv+1WhfGyuwcC7J9b2egvyZ3Qm8/c
        e/aAhBVbxT6BaR/yxTIu936L372R7aidSuR74ZOf107wVGIpzkg01GIuKk4EACoFoCsAAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually create zero-length `packed-refs` files, but they are
valid and we should handle them correctly. The old code `xmmap()`ed
such files, which led to an error when `munmap()` was called. So, if
the `packed-refs` file is empty, leave the snapshot at its zero values
and return 0 without trying to read or mmap the file.

Returning 0 also makes `create_snapshot()` exit early, which avoids
the technically undefined comparison `NULL < NULL`.

Reported-by: Kim Gybels <kgybels@infogroep.be>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 988c45402b..e829cf206d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -461,7 +461,8 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
- * existed and was read, or 0 if the file was absent. Die on errors.
+ * existed and was read, or 0 if the file was absent or empty. Die on
+ * errors.
  */
 static int load_contents(struct snapshot *snapshot)
 {
@@ -492,19 +493,17 @@ static int load_contents(struct snapshot *snapshot)
 		die_errno("couldn't stat %s", snapshot->refs->path);
 	size = xsize_t(st.st_size);
 
-	switch (mmap_strategy) {
-	case MMAP_NONE:
+	if (!size) {
+		return 0;
+	} else if (mmap_strategy == MMAP_NONE) {
 		snapshot->buf = xmalloc(size);
 		bytes_read = read_in_full(fd, snapshot->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
 			die_errno("couldn't read %s", snapshot->refs->path);
 		snapshot->mmapped = 0;
-		break;
-	case MMAP_TEMPORARY:
-	case MMAP_OK:
+	} else {
 		snapshot->buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 		snapshot->mmapped = 1;
-		break;
 	}
 	close(fd);
 
-- 
2.14.2

