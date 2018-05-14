Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC391F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752616AbeENV56 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:58 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:52931 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeENV5z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:55 -0400
Received: by mail-it0-f73.google.com with SMTP id n83-v6so16052929itg.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lL0TWvITpNxFztoA4JlUlurYh2XA1UNXEvnoI/LK3LQ=;
        b=dSBWgIq7cTxIB9Y8FDoufwWFIqFsWRp3DJSV2MgaKhJUDX5gvvT9YJnTRvg/nMbntE
         vTY3z4T6q1eX0WYfvfknlgZFwBXv5bW/496tESMUphMcgkvyfLrOV0MehS0yoCAHbd4k
         ZGBUyU0ZqjKyWa3iOB8e93dwUcL9V8BHL1pxTorIy4+5mQrP1CJbrRKpW1i9NsY/p0iu
         h7Ai9nxXQG9d1qN8AqgRipJpYiUO94qYhEHMuxjZwdAJu9yAXiWmEmmxcJ/LGOhQjmEP
         4SfbXrFAbqK7BUu2udghPqI1XVHOM5sDofwovHrsPPhWy8qcy6RfiCXct6yWjg6nic6L
         95fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lL0TWvITpNxFztoA4JlUlurYh2XA1UNXEvnoI/LK3LQ=;
        b=f6rHr0DjMx65+NbwNiP8OE9KYWd52ATd2Eqi8iATCFzOzHyRJD+mbbI8QOXK4K27nA
         wBoqfEbZcd+FRHIkSfuxHoX0syVooV5jYlgxCIuyQz5LbuEdN8PjRXtm6j6iMy3cB9LC
         UAeMkrhAe4wiRlie1H4s460idgXUFJAjs+oVP8maHIu88TlK0qTHjN7gyPR4Dyr9oNyX
         L+6CTb4nyhbuFmmmsdHm3aANpqAEBgbvdBuo9xKNLO5fbun+s1cvNJwbCH7F+JykFQiT
         e9wmnbAv06RjC/zs1Z7glf1LpIlTT3C/GrR7jPUmPPUJ3m44qKXJEN9zF9aySRu+Qa5h
         t1pQ==
X-Gm-Message-State: ALKqPweTDeJUOGbe+gSGAr+Eo4FosQPxTW1T9z/fH0O0g3qrMNcuXolr
        BjIdO05nau4oAcRc48VTJ7KWrFhJLXTwAZldmzJmgVdy1deYQVLCtxMXxicwcOJKvYZihuzLBLJ
        MnKP/qGZKQa6ZCFaqAw17UkbugmFJLeOaT6ruNz9cOo6EPcAYtDtlQjdWwg==
X-Google-Smtp-Source: AB8JxZqvcKRksV3Dg9ryXY/mySfRhIjqXIBwEXzX2trLsXIlBQCVHQzOoIfDb4bUmabvXbiHK3c0gltnIqo=
MIME-Version: 1.0
X-Received: by 2002:a24:7a83:: with SMTP id a125-v6mr13707089itc.54.1526335074633;
 Mon, 14 May 2018 14:57:54 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:22 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-32-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 31/35] transport: remove transport_verify_remote_names
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove 'transprot_verify_remote_names()' because all callers have
migrated to using 'struct refspec' which performs the same checks in
'parse_refspec()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/send-pack.c |  2 --
 transport.c         | 24 ------------------------
 transport.h         |  2 --
 3 files changed, 28 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index ef512616f..7c34bf467 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -265,8 +265,6 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		BUG("unknown protocol version");
 	}
 
-	transport_verify_remote_names(rs.raw_nr, rs.raw);
-
 	local_refs = get_local_heads();
 
 	flags = MATCH_REFS_NONE;
diff --git a/transport.c b/transport.c
index a89f17744..fe96c0b80 100644
--- a/transport.c
+++ b/transport.c
@@ -619,29 +619,6 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	free(head);
 }
 
-void transport_verify_remote_names(int nr_heads, const char **heads)
-{
-	int i;
-
-	for (i = 0; i < nr_heads; i++) {
-		const char *local = heads[i];
-		const char *remote = strrchr(heads[i], ':');
-
-		if (*local == '+')
-			local++;
-
-		/* A matching refspec is okay.  */
-		if (remote == local && remote[1] == '\0')
-			continue;
-
-		remote = remote ? (remote + 1) : local;
-		if (check_refname_format(remote,
-				REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))
-			die("remote part of refspec is not a valid name in %s",
-				heads[i]);
-	}
-}
-
 static int git_transport_push(struct transport *transport, struct ref *remote_refs, int flags)
 {
 	struct git_transport_data *data = transport->data;
@@ -1097,7 +1074,6 @@ int transport_push(struct transport *transport,
 		   unsigned int *reject_reasons)
 {
 	*reject_reasons = 0;
-	transport_verify_remote_names(rs->raw_nr, rs->raw);
 
 	if (transport_color_config() < 0)
 		return -1;
diff --git a/transport.h b/transport.h
index e2c809af4..bac085ce0 100644
--- a/transport.h
+++ b/transport.h
@@ -227,8 +227,6 @@ int transport_helper_init(struct transport *transport, const char *name);
 int bidirectional_transfer_loop(int input, int output);
 
 /* common methods used by transport.c and builtin/send-pack.c */
-void transport_verify_remote_names(int nr_heads, const char **heads);
-
 void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose);
 
 int transport_refs_pushed(struct ref *ref);
-- 
2.17.0.441.gb46fe60e1d-goog

