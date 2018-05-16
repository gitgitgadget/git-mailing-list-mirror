Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD571F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeEPW7g (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:36 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:57014 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbeEPW7O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:14 -0400
Received: by mail-yb0-f202.google.com with SMTP id p7-v6so1220592ybo.23
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=tiXISNPFv6Dl+OBx2Rtw3lwJYidLp+ckB7O8qpUELRA=;
        b=XUZwpMtWmgryBRXQXiHjlvvH1X0zKyAQuoSJpOYkTIgt/97rmM004FJQk5ffAyx2To
         nctA/mkltwbAHot4lKj6fHPM4XtHDwYI00BbwRmq0hG9XkkKiHmc5uBcDWsrLg54hkG9
         CeI1egX2TbGlUeZ1x68xYHMEkxPnfy8gyIWVKRTfXff+AxxogUNEHcqYRhqNxwDy7e9M
         MzMrGeSseXIOhwyOMZahe04uERnjS7jN5XvoZjQ7rTtNF1oM4tvINz8T4QWXmsrUYRqs
         suwCkdmX1NKUm8uYnZUS+VGC7qSK5svgjIYrLR4muMX38kyL1uzTSE2RVYV2YLJ+3kLY
         JkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=tiXISNPFv6Dl+OBx2Rtw3lwJYidLp+ckB7O8qpUELRA=;
        b=S+KAeJ+YUHYUjQFPSudqN8ZAyBwwI5B26xkRUQJVoyyoI3AmjaFG5wxDvXwqUBsIls
         qrJtvWOMzSYzzUuEe4O124Josi7rGnj9pCYh4K4DxsgNaqlkmmdMDoxeEN4ndwpm9j0x
         ddOYyUXfcgX8f1QKmBNx2s0nCY+WCnZAnugqWZIki/xL5SNPl+ZjICCf3mJLGOJJOrPm
         mLB5EbaY6pMVeM9W3zVFRgoUiqpDMRFqIVFKFSdLiTzAZUzOX7LcjB0d7DN7UGIQ6VaG
         zsPg24+Vfh1WhAb+LqQtLkw/xCaIFCyIbUjOEE53itBZ4lZZXFJ6wSJsf2NTTyFmonb3
         u/3w==
X-Gm-Message-State: ALKqPwcwx6c9Kl7gABQDq00lfgSGzgHQfUy/wgZGQWVA4IOibxdniOGf
        yYneNt43hmRDYHISXaUnrnrPUvqs6Fcnw/jY1QXRqmJEY4KMNkRRZGtlFUNxxzgMSCmVxbrW9eR
        kkCVEwkn2s0SSnBbOTzGtOxqquJ+ETSoFkHduSUcUin238VhUpcQMAjN7BA==
X-Google-Smtp-Source: AB8JxZoVKZS6aAT/yZ4d/YUF79Y9hjuclLhaIk1jj+L+Y8e5ButWRhnyfZGSjc6qjDpip9Rc71EQluTMFbg=
MIME-Version: 1.0
X-Received: by 2002:a25:7244:: with SMTP id n65-v6mr971308ybc.44.1526511554261;
 Wed, 16 May 2018 15:59:14 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:02 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-16-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 15/36] remote: remove add_prune_tags_to_fetch_refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove 'add_prune_tags_to_fetch_refspec()' function and instead have the
only caller directly add the tag refspec using 'refspec_append()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 2 +-
 remote.c        | 5 -----
 remote.h        | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 30083d4bc..7a1637d35 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1392,7 +1392,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 
 	maybe_prune_tags = prune_tags_ok && prune_tags;
 	if (maybe_prune_tags && remote_via_config)
-		add_prune_tags_to_fetch_refspec(remote);
+		refspec_append(&remote->fetch, TAG_REFSPEC);
 
 	if (argc > 0 || (maybe_prune_tags && !remote_via_config)) {
 		size_t nr_alloc = st_add3(argc, maybe_prune_tags, 1);
diff --git a/remote.c b/remote.c
index 26842ce37..4a9bddf0d 100644
--- a/remote.c
+++ b/remote.c
@@ -77,11 +77,6 @@ static const char *alias_url(const char *url, struct rewrites *r)
 	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
 }
 
-void add_prune_tags_to_fetch_refspec(struct remote *remote)
-{
-	refspec_append(&remote->fetch, TAG_REFSPEC);
-}
-
 static void add_url(struct remote *remote, const char *url)
 {
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
diff --git a/remote.h b/remote.h
index e7d00fe2a..4ffbc0082 100644
--- a/remote.h
+++ b/remote.h
@@ -290,6 +290,4 @@ extern int parseopt_push_cas_option(const struct option *, const char *arg, int
 extern int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
-void add_prune_tags_to_fetch_refspec(struct remote *remote);
-
 #endif
-- 
2.17.0.441.gb46fe60e1d-goog

