Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41AB1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeEPW76 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:58 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:40622 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeEPW7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:54 -0400
Received: by mail-yw0-f201.google.com with SMTP id g126-v6so1090041ywb.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=lL0TWvITpNxFztoA4JlUlurYh2XA1UNXEvnoI/LK3LQ=;
        b=lFv47xQvlcYJhd4WuWYUB34WaMjoBeCDdY4ln0Y7yw2F9xd8Gw20AggiKagD4Y2nok
         rsrVoJ3DFml4h/BrspSbV5uYw4E9VpYae+G6UlhCuZCf2Cu8KCq2j3vHcRVcINw65NIc
         s0d03hK4X25DnYBf2bVZluSoFG2ReLBzwSuS6ZvME951zyCHoTtIqAqrfFGt0+bDbB5f
         5jedjVWUeu/hB4ARDSk/LLnRHaS6U1qS0wluLyYv4pCOqZAvng56N7pAvPHi1lmIfuH5
         osyDXhVdeFA/Q+hswvYnHX6AeuQ6yxSamX15QiFIMdUBgaWCmN9+2hGiaIKIYmawBnhl
         ZDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=lL0TWvITpNxFztoA4JlUlurYh2XA1UNXEvnoI/LK3LQ=;
        b=jPA7oyzJqCHrgb1T34JwVlWumvk8nAsfMCgS4rgB4fJAn4dJg9V9+fay/KRBeSfBfq
         ru8X7thX4eV5eVuNEVnAjdbVeRjcmwVGKIasPNWiYRCHM/cD/VEcu04xDwinI7o50Oc3
         3nYS0ueF5VvAqtFusrVX2LjufM/irHkz4FYTgIf/QflFkfDQnPRPbK/xtLNoaYOcNOiQ
         lzXj60CAI6/+MG4Bt01zi+Ie4Sh4ZJrxxJoEKtZx47XddUIEzSWhctW+5npM7iIVywbE
         zAI4LAZaBGx1dHefceSCEjIGK5sVC+Ol9xfg5pi8N98ROlvv4B0OQX3+k+AlT6+f3mdW
         TxHg==
X-Gm-Message-State: ALKqPwcPUwDdRcJdizjZSvEm5FbJDRu68ZdJOD9F0DayVoW5siEXYzF5
        w3QQXR4U/GB608egSD74KEp2hfU1bVajeQ3xryIbHPjQzu/PiK5VCbPaywB4/eXPE4t/J/Brw10
        XHv7Y+106Y0jMbk9wJsE/NJ8FL8Hk/PWgOfZxi8H5p39SJJQQ8dUOuhhKQg==
X-Google-Smtp-Source: AB8JxZqPy+xXZrP506JpwLQcpM1vLJMtRL3tLHZKmijQz/CzxG3KZfq2CPpfEN/6je4TOWRSv4TkD/atPvk=
MIME-Version: 1.0
X-Received: by 2002:a0d:f404:: with SMTP id d4-v6mr963437ywf.76.1526511594030;
 Wed, 16 May 2018 15:59:54 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:19 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-33-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 32/36] transport: remove transport_verify_remote_names
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

