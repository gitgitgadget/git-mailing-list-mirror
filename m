Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2909B1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfIPTA5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:00:57 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:46806 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732867AbfIPTA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:00:57 -0400
Received: by mail-lf1-f47.google.com with SMTP id t8so776683lfc.13
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CgiWeZ3xLrTBK6SvmbN8GNtZu/96w1WtBI0fHu2DGu4=;
        b=GOIezQDIDNc9jA0G+pk3YQs60WeV+QfLeq22nlz2A/AWYw7Bl94V9o+Z0b0tztaDHr
         jofj3zoiCn/ZVAFSprAn/e1gPnnac2FFEIMlsf8iobdtA51fSSMOciqTcLyn+VRE+39T
         73Wh6E3GjQDIYxa7LWYtGyyIbXQ5gAQA+1atYhbesKzq8NJCaeIElVoYbP7cSKqgJxRw
         8kEaz113Ia5N+EaLuIZs0XsEF83UJxydp0F6dD3P3fd+KoyIJg+Cy06SBxxIFU7HZxVl
         e54SMGwQUcT9bubg9Q6uqoB5gGSMdWIw0MQAFNJkNW98UFQEb4jdW6iIbGE8WhEmAN2Z
         crkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgiWeZ3xLrTBK6SvmbN8GNtZu/96w1WtBI0fHu2DGu4=;
        b=eB2NhGIYYsIEikZCPLlzp7UfHTBc+rvIMz740I/PFq341QOKRmTGqQhwI8Wz2AW/RV
         BfAYnk/GMYA0S6FjBDOadxokKrDV5R6DtlAJcsA+AyyOgIgrdQ6VD7toody1Axef3gJX
         QEZ+bvk43/Db1AmwWu8E7FEzRbDuuEjI12YmHaLBNfrZqTiozqzpmfKbVSSpBwd5meDU
         zYi+MmEijGCk4qS5b+4Wg05qr1Abvqn04Zu1vVVPZGOsk/YY8JMX7WFiWVn9+EHXGYva
         8I2A3uysmXKnS8r5tLs54/y3RqT0OPIIe4mDDDvZWZMVEs9dy8eL+WZNfifmtvf7h5L/
         1GYQ==
X-Gm-Message-State: APjAAAUWKwqYcIG4fElxdktlNajnSPV/hVa9DwtpZabK40jSzeUhpcYA
        p/scciGLF7HeuvDCapyePtiLMKfq
X-Google-Smtp-Source: APXvYqzDR5Dj6/aUxIcN9GXmKKSy1Qtj7hOWOkAkhFSf3l8s3oUixjF5Mk6cSduMc42jE4FR+crMmA==
X-Received: by 2002:ac2:4149:: with SMTP id c9mr509102lfi.128.1568660454689;
        Mon, 16 Sep 2019 12:00:54 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id j28sm9127608lfh.57.2019.09.16.12.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 12:00:53 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] doc-diff: replace --cut-header-footer with --cut-footer
Date:   Mon, 16 Sep 2019 21:00:28 +0200
Message-Id: <e5a2e78886d9d23bcd25c03b461ec19b29979c6d.1568658269.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658269.git.martin.agren@gmail.com>
References: <cover.1567534373.git.martin.agren@gmail.com> <cover.1568658269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous commit, AsciiDoc and Asciidoctor render the manpage
headers identically, so we no longer need the "cut the header" part of
our `--cut-header-footer` option. We do still need the "cut the footer"
part, though. The previous commits improved the rendering of the footer
in Asciidoctor by quite a bit, but the two programs still disagree on
how to format the date in the footer: 01/01/1970 vs 1970-01-01.

We could keep using `--cut-header-footer`, but it would be nice if we
had a slightly smaller hammer `--cut-footer` that would be less likely
to hide regressions. Rather than simply adding such an option, let's
also drop `--cut-header-footer`, i.e., rework it to lose the "header"
part of its name and functionality.

`--cut-header-footer` is just a developer tool and it probably has no
more than a handful of users, so we can afford to be aggressive.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 3355be4798..88a9b20168 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -21,7 +21,7 @@ asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
-cut-header-footer	cut away header and footer
+cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -31,7 +31,7 @@ force=
 clean=
 from_program=
 to_program=
-cut_header_footer=
+cut_footer=
 while test $# -gt 0
 do
 	case "$1" in
@@ -55,8 +55,8 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
-	--cut-header-footer)
-		cut_header_footer=-cut-header-footer ;;
+	--cut-footer)
+		cut_footer=-cut-footer ;;
 	--)
 		shift; break ;;
 	*)
@@ -118,8 +118,8 @@ construct_makemanflags () {
 from_makemanflags=$(construct_makemanflags "$from_program") &&
 to_makemanflags=$(construct_makemanflags "$to_program") &&
 
-from_dir=$from_oid$from_program$cut_header_footer &&
-to_dir=$to_oid$to_program$cut_header_footer &&
+from_dir=$from_oid$from_program$cut_footer &&
+to_dir=$to_oid$to_program$cut_footer &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -169,12 +169,11 @@ render_tree () {
 		make -j$parallel -f - &&
 		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
 
-		if test "$cut_header_footer" = "-cut-header-footer"
+		if test "$cut_footer" = "-cut-footer"
 		then
 			for f in $(find "$tmp/rendered/$dname" -type f)
 			do
-				tail -n +3 "$f" | head -n -2 |
-				sed -e '1{/^$/d}' -e '${/^$/d}' >"$f+" &&
+				head -n -2 "$f" | sed -e '${/^$/d}' >"$f+" &&
 				mv "$f+" "$f" ||
 				return 1
 			done
-- 
2.23.0

