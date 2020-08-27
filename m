Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44477C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0F2087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+KxZKtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgH0PqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH0Pp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:45:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4EC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u20so3831787pfn.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocwoZdLtsYlSuErxMWtv7Otb0EkR16z1cmC7CjTo/YE=;
        b=F+KxZKtx2884lXnFAbdgZlyjEGp+couZtYiKSqcP2lrp08B6UeemYXGwx+FaIrXbja
         q0EBrZDsolgmeJL7D6q4eXAhh8onOheXPT1zgwLDl6k9Tmgw3/xFPgXQ8h4lUK0TdUfa
         OHWGmN5sXdoGyrmeaACcBP0y97tA2eHL1i0PGlv7upU82nTyCZKkHQbt4WqSLs/DLQxV
         TpUs6+KeZqSYwXl64qna7EK0ukJAjG+fOzRGSiRx58DEAUqDaFGE9aqQ4gADn/g9RCvq
         2yaW877wmbRlAPZlCY8tPvM771yAy8s9HWRcQHMMWXCWt9z8sdxlak+ulHgtlKfN38qq
         /6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocwoZdLtsYlSuErxMWtv7Otb0EkR16z1cmC7CjTo/YE=;
        b=fIdgmmb7sp0e4yr5TKFJOmLUJ6rwy7NW1JcSNMmmjYmrH09psj6239FN/h+nyZT0sR
         hJynP4G9NZvJsodJjvE6aEAfjcv563gYrgL57vxGgihjOzFFmGU0UeI7Agd+yKVukHCR
         RFFtOacHR9gq+fde+H6Ppi5P93pl0j1i2/tZEOFXdvKECU3cTc4t25Z1LNyULd3B8XPq
         OAsNmxADwaOw1b9iKMq+DAsTr6klcx0VkD73qEa+iEwn8TEuMhnAEfwofbbjq/S3H6m0
         5C7/IsmdYKzSSf1cdLty/jo7gDktv/jX+awc1QkcNhqn8xIdeDCDC2R6KpYO4YyiEOks
         Zv9Q==
X-Gm-Message-State: AOAM5330c7eYXhefAICXAZ9LWK6XMDjLfc+e8LfpApvVK7OZdmuGJ4DM
        mn/wPj30JA82IEeAFfXAeqfLMYIUMwD7uA==
X-Google-Smtp-Source: ABdhPJxUoLj7l/Npy7ixfb7GXPHZwAeko781udauy183E6/wUA1YCDD7AzMB9A720tjiRQEnEEVsCg==
X-Received: by 2002:a05:6a00:2285:: with SMTP id f5mr17116552pfe.173.1598543155847;
        Thu, 27 Aug 2020 08:45:55 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x5sm3129218pfj.1.2020.08.27.08.45.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 08:45:55 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v19 00/10] New proc-receive hook for centralized workflow
Date:   Thu, 27 Aug 2020 11:45:41 -0400
Message-Id: <20200827154551.5966-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200824174202.11710-1-worldhello.net@gmail.com>
References: <20200824174202.11710-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v18

1. This series is based on "next" branch, in order to resolve a conflict
   with commit 95e7c38539 (refspec: make sure stack refspec_item
   variables are zeroed, 2020-08-14).  See patch 9/10.

2. Fix typos in patch 3/10, 6/10, 7/10.

3. Fix ABNF syntax for capability "report-status-v2" in patch 6/10.

4. Add more test cases in patch 7/10 to increase code coverage.


## Range diff

 1:  22a9252587 =  1:  96c6d41872 transport: not report a non-head push as a branch
 2:  5c3fd7eb7a =  2:  861507a38e t5411: add basic test cases for proc-receive hook
 3:  003a36b71f !  3:  4b6d00a671 receive-pack: add new proc-receive hook
    @@ Commit message
         The filter will check the prefix of the reference name, and if the
         command has a special reference name, the filter will turn a specific
         field (`run_proc_receive`) on for the command.  Commands with this filed
    -    turned on will be executed by a new handler (an hook named
    +    turned on will be executed by a new handler (a hook named
         "proc-receive") instead of the internal `execute_commands` function.
         We can use this "proc-receive" command to create pull requests or send
         emails for code review.
     
         Suggested by Junio, this "proc-receive" hook reads the commands,
         push-options (optional), and send result using a protocol in pkt-line
    -    format.  In the following example, The letter "S" stands for
    +    format.  In the following example, the letter "S" stands for
         "receive-pack" and letter "H" stands for the hook.
     
             # Version and features negotiation.
 4:  60b9157a8e =  4:  b3986f98eb receive-pack: feed report options to post-receive
 5:  4a9b7187af !  5:  882f391b4f New capability "report-status-v2" for git-push
    @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
      			strbuf_addstr(&cap, " atomic");
      		if (prefer_ofs_delta)
     @@ builtin/receive-pack.c: static struct command *read_head_info(struct packet_reader *reader,
    - 			const char *feature_list = reader->line + linelen + 1;
    + 			int len = 0;
      			if (parse_feature_request(feature_list, "report-status"))
      				report_status = 1;
     +			if (parse_feature_request(feature_list, "report-status-v2"))
 6:  940acbc406 !  6:  331bfd4697 doc: add document for capability report-status-v2
    @@ Documentation/technical/pack-protocol.txt: update was successful, or 'ng [refnam
        error-msg         = 1*(OCTET) ; where not "ok"
      ----
      
    -+New capability "report-status-v2" extends the protocol by adding new option
    ++The 'report-status-v2' capability extends the protocol by adding new option
     +lines in order to support reporting of reference rewritten by the
    -+"proc-receive" hook.  The "proc-receive" hook may handle a command for a
    ++'proc-receive' hook.  The 'proc-receive' hook may handle a command for a
     +pseudo-reference which may create or update one or more references, and each
     +reference may have different name, different new-oid, and different old-oid.
     +
    @@ Documentation/technical/pack-protocol.txt: update was successful, or 'ng [refnam
     +  unpack-status     = PKT-LINE("unpack" SP unpack-result)
     +  unpack-result     = "ok" / error-msg
     +
    -+  command-status-v2 = command-ok-v2 / command-fail-v2
    ++  command-status-v2 = command-ok-v2 / command-fail
     +  command-ok-v2     = command-ok
     +		      *option-line
    -+  command-fail-v2   = command-fail
    -+		      *option-line
     +
     +  command-ok        = PKT-LINE("ok" SP refname)
     +  command-fail      = PKT-LINE("ng" SP refname SP error-msg)
    @@ Documentation/technical/protocol-capabilities.txt: each reference was updated su
     +----------------
     +
     +Capability 'report-status-v2' extends capability 'report-status' by
    -+adding new option lines in order to support reference rewritten by
    -+the"proc-receive" hook.  The "proc-receive" hook may handle a command
    ++adding new "option" directives in order to support reference rewritten by
    ++the "proc-receive" hook.  The "proc-receive" hook may handle a command
     +for a pseudo-reference which may create or update a reference with
     +different name, new-oid, and old-oid.  While the capability
    -+"report-status" cannot report for such case.  See pack-protocol.txt
    ++'report-status' cannot report for such case.  See pack-protocol.txt
     +for details.
     +
      delete-refs
 7:  974a06e15e !  7:  d5465fc22b receive-pack: new config receive.procReceiveRefs
    @@ Commit message
         "proc-receive".
     
         Optional modifiers can be provided in the beginning of the value to
    -    filter commands for specific actions: create (a), mofify (m),
    +    filter commands for specific actions: create (a), modify (m),
         delete (d). A `!` can be included in the modifiers to negate the
         reference prefix entry. E.g.:
     
             git config --system --add receive.procReceiveRefs ad:refs/heads
    +        git config --system --add receive.procReceiveRefs !:refs/heads
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
    @@ Documentation/config/receive.txt: receive.hideRefs::
     +running the hook "proc-receive".
     ++
     +Optional modifiers can be provided in the beginning of the value to filter
    -+commands for specific actions: create (a), mofify (m), delete (d).
    ++commands for specific actions: create (a), modify (m), delete (d).
     +A `!` can be included in the modifiers to negate the reference prefix entry.
     +E.g.:
     ++
     +	git config --system --add receive.procReceiveRefs ad:refs/heads
    ++	git config --system --add receive.procReceiveRefs !:refs/heads
     +
      receive.updateServerInfo::
      	If set to true, git-receive-pack will run git-update-server-info
    @@ t/t5411/test-0041-process-all-refs--porcelain.sh (new)
     +	)
     +'
     
    - ## t/t5411/test-0050-proc-receive-refs.sh (new) ##
    + ## t/t5411/test-0050-proc-receive-refs-with-modifiers.sh (new) ##
     @@
     +test_expect_success "config receive.procReceiveRefs with modifiers ($PROTOCOL)" '
     +	(
    @@ t/t5411/test-0050-proc-receive-refs.sh (new)
     +# Refs of upstream : master(A)
     +# Refs of workbench: master(A)  tags/v123
     +test_expect_success "setup upstream: create tags/v123 ($PROTOCOL)" '
    ++	git -C "$upstream" update-ref refs/heads/topic $A &&
     +	git -C "$upstream" update-ref refs/tags/v123 $TAG &&
     +	git -C "$upstream" show-ref >out &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    ++	<COMMIT-A> refs/heads/topic
     +	<TAG-v123> refs/tags/v123
     +	EOF
     +	test_cmp expect actual
    @@ t/t5411/test-0050-proc-receive-refs.sh (new)
     +	EOF
     +'
     +
    -+# Refs of upstream : master(A)  tags/v123
    -+# Refs of workbench: master(A)  tags/v123
    -+# git push         : NULL       NULL       next(A)
    ++# Refs of upstream : master(A)  topic(A)  tags/v123
    ++# Refs of workbench: master(A)            tags/v123
    ++# git push         : NULL       topic(B)  NULL       next(A)
     +test_expect_success "proc-receive: create/delete branch, and delete tag ($PROTOCOL)" '
     +	git -C workbench push origin \
     +		:refs/heads/master \
    ++		$B:refs/heads/topic \
     +		$A:refs/heads/next \
     +		:refs/tags/v123 >out 2>&1 &&
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	remote: # pre-receive hook
     +	remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/master
    ++	remote: pre-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
     +	remote: pre-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
     +	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
     +	remote: # proc-receive hook
    @@ t/t5411/test-0050-proc-receive-refs.sh (new)
     +	remote: proc-receive> option new-oid <COMMIT-A>
     +	remote: # post-receive hook
     +	remote: post-receive< <COMMIT-A> <ZERO-OID> refs/pull/123/head
    ++	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/heads/topic
     +	remote: post-receive< <TAG-v123> <ZERO-OID> refs/tags/v123
     +	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/124/head
     +	To <URL/of/upstream.git>
     +	 - [deleted] refs/pull/123/head
    ++	 <OID-A>..<OID-B> <COMMIT-B> -> topic
     +	 - [deleted] v123
     +	 * [new reference] <COMMIT-A> -> refs/pull/124/head
     +	EOF
    @@ t/t5411/test-0050-proc-receive-refs.sh (new)
     +	make_user_friendly_and_stable_output <out >actual &&
     +	cat >expect <<-EOF &&
     +	<COMMIT-A> refs/heads/master
    ++	<COMMIT-B> refs/heads/topic
     +	EOF
     +	test_cmp expect actual
     +'
 8:  5b588f7926 =  8:  cd38e2ddf5 t5411: test updates of remote-tracking branches
 9:  7c707984e3 !  9:  342784222f transport: parse report options for tracking refs
    @@ transport.c: int transport_refs_pushed(struct ref *ref)
      }
      
     -void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
    -+static void update_tracking_ref(struct remote *remote, char *refname,
    -+				struct object_id *new_oid, int deletion,
    -+				int verbose)
    ++static void update_one_tracking_ref(struct remote *remote, char *refname,
    ++				    struct object_id *new_oid, int deletion,
    ++				    int verbose)
      {
      	struct refspec_item rs;
      
     -	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
     -		return;
     -
    + 	memset(&rs, 0, sizeof(rs));
     -	rs.src = ref->name;
     +	rs.src = refname;
      	rs.dst = NULL;
    --
    + 
      	if (!remote_find_tracking(remote, &rs)) {
      		if (verbose)
      			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
    @@ transport.c: int transport_refs_pushed(struct ref *ref)
      			delete_ref(NULL, rs.dst, NULL, 0);
     -		} else
     -			update_ref("update by push", rs.dst, &ref->new_oid,
    --				   NULL, 0, 0);
     +		else
     +			update_ref("update by push", rs.dst, new_oid,
    -+				NULL, 0, 0);
    + 				   NULL, 0, 0);
      		free(rs.dst);
      	}
      }
    @@ transport.c: int transport_refs_pushed(struct ref *ref)
     +
     +	report = ref->report;
     +	if (!report)
    -+		update_tracking_ref(remote, ref->name, &ref->new_oid,
    -+				    ref->deletion, verbose);
    ++		update_one_tracking_ref(remote, ref->name, &ref->new_oid,
    ++					ref->deletion, verbose);
     +	else
     +		for (; report; report = report->next) {
     +			refname = report->ref_name ? (char *)report->ref_name : ref->name;
     +			new_oid = report->new_oid ? report->new_oid : &ref->new_oid;
    -+			update_tracking_ref(remote, refname, new_oid,
    -+					    is_null_oid(new_oid), verbose);
    ++			update_one_tracking_ref(remote, refname, new_oid,
    ++						is_null_oid(new_oid), verbose);
     +		}
     +}
     +
10:  e66c7c3f51 ! 10:  a7268305e3 doc: add documentation for the proc-receive hook
    @@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
     +    H: PKT-LINE(ok <ref>)
     +    H: PKT-LINE(option fall-through)
     +    # OK, but has an alternate reference.  The alternate reference name
    -+    # and other status can be given in options
    ++    # and other status can be given in option directives.
     +    H: PKT-LINE(ok <ref>)
     +    H: PKT-LINE(option refname <refname>)
     +    H: PKT-LINE(option old-oid <old-oid>)
    @@ Documentation/githooks.txt: The default 'update' hook, when enabled--and with
     +may update an alternate reference and the alternate reference may exist
     +already with a non-zero old-oid.  For this case, this hook will use
     +"option" directives to report extended attributes for the reference given
    -+by the above "ok/ng" directive.
    ++by the leading "ok" directive.
     +
     +The report of the commands of this hook should have the same order as
     +the input.  The exit status of the 'proc-receive' hook only determines

---

Jiang Xin (10):
  transport: not report a non-head push as a branch
  t5411: add basic test cases for proc-receive hook
  receive-pack: add new proc-receive hook
  receive-pack: feed report options to post-receive
  New capability "report-status-v2" for git-push
  doc: add document for capability report-status-v2
  receive-pack: new config receive.procReceiveRefs
  t5411: test updates of remote-tracking branches
  transport: parse report options for tracking refs
  doc: add documentation for the proc-receive hook

 Documentation/config/receive.txt              |  22 +
 Documentation/githooks.txt                    |  62 +++
 Documentation/technical/pack-protocol.txt     |  41 +-
 .../technical/protocol-capabilities.txt       |  17 +-
 Makefile                                      |   1 +
 builtin/receive-pack.c                        | 472 +++++++++++++++++-
 builtin/send-pack.c                           |  19 +
 remote.h                                      |   9 +
 send-pack.c                                   | 101 +++-
 t/helper/test-proc-receive.c                  | 176 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t5411-proc-receive-hook.sh                  | 117 +++++
 t/t5411/common-functions.sh                   |  56 +++
 t/t5411/once-0010-report-status-v1.sh         |  94 ++++
 t/t5411/test-0000-standard-git-push.sh        | 143 ++++++
 .../test-0001-standard-git-push--porcelain.sh | 147 ++++++
 t/t5411/test-0002-pre-receive-declined.sh     |  33 ++
 ...st-0003-pre-receive-declined--porcelain.sh |  34 ++
 t/t5411/test-0010-proc-receive-settings.sh    |   7 +
 t/t5411/test-0011-no-hook-error.sh            |  64 +++
 t/t5411/test-0012-no-hook-error--porcelain.sh |  66 +++
 t/t5411/test-0013-bad-protocol.sh             | 217 ++++++++
 t/t5411/test-0014-bad-protocol--porcelain.sh  | 160 ++++++
 t/t5411/test-0020-report-ng.sh                |  67 +++
 t/t5411/test-0021-report-ng--porcelain.sh     |  69 +++
 t/t5411/test-0022-report-unexpect-ref.sh      |  45 ++
 ...est-0023-report-unexpect-ref--porcelain.sh |  46 ++
 t/t5411/test-0024-report-unknown-ref.sh       |  34 ++
 ...test-0025-report-unknown-ref--porcelain.sh |  35 ++
 t/t5411/test-0026-push-options.sh             |  79 +++
 t/t5411/test-0027-push-options--porcelain.sh  |  82 +++
 t/t5411/test-0030-report-ok.sh                |  35 ++
 t/t5411/test-0031-report-ok--porcelain.sh     |  36 ++
 t/t5411/test-0032-report-with-options.sh      | 256 ++++++++++
 ...est-0033-report-with-options--porcelain.sh | 265 ++++++++++
 t/t5411/test-0034-report-ft.sh                |  44 ++
 t/t5411/test-0035-report-ft--porcelain.sh     |  45 ++
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 227 +++++++++
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 172 +++++++
 t/t5411/test-0038-report-mixed-refs.sh        |  89 ++++
 .../test-0039-report-mixed-refs--porcelain.sh |  91 ++++
 t/t5411/test-0040-process-all-refs.sh         | 113 +++++
 .../test-0041-process-all-refs--porcelain.sh  | 114 +++++
 ...t-0050-proc-receive-refs-with-modifiers.sh | 135 +++++
 t/t5516-fetch-push.sh                         |   2 +-
 transport-helper.c                            | 128 +++--
 transport.c                                   | 156 ++++--
 48 files changed, 4325 insertions(+), 100 deletions(-)
 create mode 100644 t/helper/test-proc-receive.c
 create mode 100755 t/t5411-proc-receive-hook.sh
 create mode 100644 t/t5411/common-functions.sh
 create mode 100644 t/t5411/once-0010-report-status-v1.sh
 create mode 100644 t/t5411/test-0000-standard-git-push.sh
 create mode 100644 t/t5411/test-0001-standard-git-push--porcelain.sh
 create mode 100644 t/t5411/test-0002-pre-receive-declined.sh
 create mode 100644 t/t5411/test-0003-pre-receive-declined--porcelain.sh
 create mode 100644 t/t5411/test-0010-proc-receive-settings.sh
 create mode 100644 t/t5411/test-0011-no-hook-error.sh
 create mode 100644 t/t5411/test-0012-no-hook-error--porcelain.sh
 create mode 100644 t/t5411/test-0013-bad-protocol.sh
 create mode 100644 t/t5411/test-0014-bad-protocol--porcelain.sh
 create mode 100644 t/t5411/test-0020-report-ng.sh
 create mode 100644 t/t5411/test-0021-report-ng--porcelain.sh
 create mode 100644 t/t5411/test-0022-report-unexpect-ref.sh
 create mode 100644 t/t5411/test-0023-report-unexpect-ref--porcelain.sh
 create mode 100644 t/t5411/test-0024-report-unknown-ref.sh
 create mode 100644 t/t5411/test-0025-report-unknown-ref--porcelain.sh
 create mode 100644 t/t5411/test-0026-push-options.sh
 create mode 100644 t/t5411/test-0027-push-options--porcelain.sh
 create mode 100644 t/t5411/test-0030-report-ok.sh
 create mode 100644 t/t5411/test-0031-report-ok--porcelain.sh
 create mode 100644 t/t5411/test-0032-report-with-options.sh
 create mode 100644 t/t5411/test-0033-report-with-options--porcelain.sh
 create mode 100644 t/t5411/test-0034-report-ft.sh
 create mode 100644 t/t5411/test-0035-report-ft--porcelain.sh
 create mode 100644 t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
 create mode 100644 t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
 create mode 100644 t/t5411/test-0038-report-mixed-refs.sh
 create mode 100644 t/t5411/test-0039-report-mixed-refs--porcelain.sh
 create mode 100644 t/t5411/test-0040-process-all-refs.sh
 create mode 100644 t/t5411/test-0041-process-all-refs--porcelain.sh
 create mode 100644 t/t5411/test-0050-proc-receive-refs-with-modifiers.sh

-- 
2.26.2.543.g44b58e439b

