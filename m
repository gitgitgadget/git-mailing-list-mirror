Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1001F803
	for <e@80x24.org>; Mon,  7 Jan 2019 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfAGQsJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 11:48:09 -0500
Received: from mout.web.de ([212.227.17.12]:45367 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGQsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 11:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546879683;
        bh=TUCCgmJu/P2GG73x8H3JRtYIKELigLuuJVs308FFgMU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=asPaiDl6I/jWLvWSsLudEjmdbrI7mspbxavo/wgJ1lUIf6C3R+hSkorb4l7i1Mvjl
         VKe4qQnQqz2BEpi1yx9nWWULefN2DM7E0e0T9hiJKV8TdT5S1v4fPQInxC6/OeUEZh
         O9/03n3sjBRA/68ZIblBaA2iNc1K9UuZUYqYWIEc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqlWY-1hAfpJ30yY-00eJsR; Mon, 07
 Jan 2019 17:48:03 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1-file: close fd of empty file in map_sha1_file_1()
Message-ID: <1136813c-2f14-042a-858e-2bca1aba990f@web.de>
Date:   Mon, 7 Jan 2019 17:48:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n2LPOA+DOqf2Jw9Ji0F72i/w2+OyO0APRgV+dJLT4pwLMjYXbc6
 bmI+1trQIkqTjMX3W0M6uMVWfbiDJF7s2BZhE855WIccXkRjdT3cQ08gDiLsj9/6pKlSwfN
 n/5CTSTUYnLWNFfxT1wvo4JmBgBsxQ5zJPMP5FInfVnzxZVb0uetdWNNTH7TxS5w4BzJumk
 aAkIsw2ju8LUVn0YKjjxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WKJHqtq1hFs=:DPd0duqUBWBvZz0msewHf8
 zaMDzyGGhgGiQywra/vOWxrzDTwNgCXfzDwZzjTvR2WQJp5/JtCi2U87b/lumBSSzvx6D0AW0
 V6xHQ4fAlcojmPcW9+KLHGsVwp9jgh/qLkcJLrVNofri8Eqr2tlUyzZjn8drTGIyM5lMDZ3QC
 /THoJSYd3Fz1cOSCGMBEieoCep8rXqs4QPFxuCrks2QRqHNMu7KN3i9aC+4XMNfjetHH+e73b
 71K2eKpbosABKazLYBvGKR2lRnHzm9gCpGyp4qpin3G9cwIwCIYKvbrVKwqkwoYs7dQSsZvl+
 7Wap5kPnH73EpOCbMP/LIq2U2VFKwknJn2oXelViUYNQTrrEhqLAGFfcVzjkNjUadl3gExKxx
 A2HI/3L3Bmdhr27SDRT0xz92IUZsDjS0VA77FS6ooSPmIjr4XZ7cRAdK3oRsJ49N1BuZlXbuc
 6ktGLehUwR1uK5y9UB4/Rl95GDw3BvYig2SPpoz4dj506vTbDG1WvQR//mN1yXhZF2vftf6wj
 LCjsH5z8yrhx7xihxjzGL2E0JN8YUJvRh5r3tkASXyifPj/INmAmudD8sI8c+NKqE/Q4ZQOJV
 AFQZgFHvIaJAZxTWUPwAAgZ9xqGuBNIawcyLPF+h9JGgK8UagLt3Bzfehc8Gbd2B4m6jkMTeI
 Fq3vMTDxGYdRSDi5Uv5PfRlnbtQmBUWu9Nd/TNgYUZRlQAiG824b2KAuJxGVY1gmAcrhW0MRX
 txxlr0vkxuf3jC2aH7cfodzytDO9j5O0sC42rexN1n0YtQjuSB6Tw3PSCRkhTr6k0KOrA4osG
 DWkIUGDTAGKGA6zOq+YRJfopII6Yl+rlYv3wE54c6lLNki5dYhnVANg7jInAiioBAs4wPyUam
 HtjGsuIUrRHREMHnGl4qliUVIU7bbnS9bb2ungucIO/ryI9p/DLFSn2klGQWmv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

map_sha1_file_1() checks if the file it is about to mmap() is empty and
errors out in that case and explains the situation in an error message.
It leaks the private handle to that empty file, though.

Have the function clean up after itself and close the file descriptor
before exiting early.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Patch generated with --function-context for easier review.

 sha1-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1-file.c b/sha1-file.c
index 5a272f70de..bfa7a2e121 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -942,31 +942,32 @@ static int quick_has_loose(struct repository *r,
 /*
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
 static void *map_sha1_file_1(struct repository *r, const char *path,
 			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
 
 	if (path)
 		fd = git_open(path);
 	else
 		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
 
 		if (!fstat(fd, &st)) {
 			*size = xsize_t(st.st_size);
 			if (!*size) {
 				/* mmap() is forbidden on empty files */
 				error(_("object file %s is empty"), path);
+				close(fd);
 				return NULL;
 			}
 			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
 		}
 		close(fd);
 	}
 	return map;
 }
-- 
2.20.1
