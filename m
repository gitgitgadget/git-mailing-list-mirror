Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5795E20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLIKp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34024 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLIKpV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so7105526ljd.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGP0eLASAJG1xA6Db+bc8VXHjgDBeabX+EW52NPM5qc=;
        b=uEyllG44HmzVqZB+2blXrbjP85siHRxm2YE66oGFptICklT5ziLeA1Rzn4+VFvdPzX
         QWWCeq8FfiUilLjKiXKSF8l3wIh5GW3QykHyOK8XsItlBpYp1gOIyq1Oo1/WzYlLcUpm
         2z2ZBY5KvndJXUCV7YLivpA9YoZu+BcHzyxj0nhYiuSMiuHQIEUF18C+XSQiGSzTfZbb
         7SAwZDKuw2qTM8gV634KE1zDmTisnKGF2P2UCXrhKb/cD6Cnu0XKM2CAMYhA8DrQU3Ff
         xoDe7g3HEEVmyf2wzwpAj5ItL4K6pSag2WFOS55iIIg0cw/ndegg5B+HFxOMHtQlAHdu
         ArTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGP0eLASAJG1xA6Db+bc8VXHjgDBeabX+EW52NPM5qc=;
        b=tT78lTQ4vkrUqQzNzx4iDNHL3RFuGEwhBsXhQdDZHw8QsxV/kDgJ/uELV4dOiaiGkM
         TOBam4ZOE7dMLP19EkpdFNn3a0wzghPp+sx4IG6AHUUoQ3kjuNBDeW8Q0wvwcu975DCa
         h/DWVodq8/7iVqrfuR+rfkZrb4I9zzt9Ur0ItRG2LTpVUBL6KP4FvXgei8GsloMCDwMe
         ljM3jDi7YbRqE1CyvJtwyomvgKKj9qajZONmObldzTbID7mJ5o/Zjy7JYXDWqv9RrZTa
         VyhSpJLLoUjv9TuENZkuVkFgflWzdmdmhUSCzPNWW+i4iyE4+S5T/Tuo/TaXflSOMypD
         FAvA==
X-Gm-Message-State: AA+aEWaVygXkp3s+8dcx2QWEhEJkt/Gx49+p64k8bZdjDorPpjijqbns
        bw2C/fGaaAoonuIVsgcaZ2f57yNB
X-Google-Smtp-Source: AFSGD/UHfQ44BYfojE8Izb5mBRt3Bg5edz/rXq4QgMmje71chNnriFFT0VJbkT7vrlflpZGBusrPQg==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr4840666ljb.126.1544352318758;
        Sun, 09 Dec 2018 02:45:18 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:18 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/24] sha1-file.c: let index_path() accept NULL istate
Date:   Sun,  9 Dec 2018 11:44:11 +0100
Message-Id: <20181209104419.12639-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

istate is needed for content conversion. Allow to pass NULL istate
(which implies that the caller does not care at all about file content
conversion).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 5bd11c85bc..214d62f3b5 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1829,7 +1829,8 @@ static int index_mem(struct index_state *istate,
 	 */
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
-		if (convert_to_git(istate, path, buf, size, &nbuf,
+		if (istate &&
+		    convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
@@ -1957,12 +1958,13 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	 * Call xsize_t() only when needed to avoid potentially unnecessary
 	 * die() for large files.
 	 */
-	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
+	if (type == OBJ_BLOB && path && istate &&
+	    would_convert_to_git_filter_fd(istate, path))
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(istate, oid, fd, type, path, flags);
 	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
-		 (path && would_convert_to_git(istate, path)))
+		 (path && istate && would_convert_to_git(istate, path)))
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	else
-- 
2.20.0.rc2.486.g9832c05c3d

