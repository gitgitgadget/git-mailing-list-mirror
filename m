Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FC920A04
	for <e@80x24.org>; Fri, 26 May 2017 10:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761823AbdEZKES (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 06:04:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34910 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756588AbdEZKEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 06:04:15 -0400
Received: by mail-lf0-f67.google.com with SMTP id 99so577275lfu.2
        for <git@vger.kernel.org>; Fri, 26 May 2017 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXVkIE18qmVC5pPWqlaVWqJFqXVEN8mjtqatS4RZPyw=;
        b=ONMquJLUrjMWcG6bgWnhAPEA8pJPbJh6uF+9xJ3+ErEoQlKmIonhYj9XSzcnQ9swWN
         XP8q2PvFYX63p8jjlqQidyvTxaJXrsp5V0Lli31UHRYI0fl7NaO1bmnl6v7EnA++KDDZ
         5DpN0Hl4Df4nq3ZzhUEvg/7pGf1Zkw+GjugV82ym55sTeqHM6OvG4jutH1xihKcwrWTP
         XejZX0grXvfAu7zJTY/x1RcjUbPXHnvhqJVUqVAe3WUWdn+IeqKZqcwuZfL94JAgtqXk
         6tWoZ2dGRAWXwk/PbPKClGiBCDZ9RXasTUCWyo2S9tcN/yLaPhCEmuuRzsl9XrbOQ4ta
         e52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXVkIE18qmVC5pPWqlaVWqJFqXVEN8mjtqatS4RZPyw=;
        b=pEEGYpOR3rU1bp0VN3BsGYLNsXBghYphtjdDxyUzr1mtB+O4bYsBJjzPq1iKnpOt00
         OPDr50duslrJDQAiPcmSqqNqcS17TsFHYfv/voSaQr0+LNEixvMeOTotFizAVDlqeTMd
         cFIgqNn+n+T1F5N88f3DmOLDHAjRdRKYueVNO9js8anJkf5ijbeBB7/Vb+TdbliA5eOM
         bBbxnmwp9YZeDBXYxjkOEHK9jyjBeEJxK5Zmo6p+qCT/5r0TcaBtDDOoAj3Sx+mYZi89
         LFxiNZlA4C+XMEXUCccMEZhDYRwhND3alOyWTzj59qjvYyUCOfmGsT/ZxlyQv0FS/ncO
         DoTA==
X-Gm-Message-State: AODbwcCUAYce9B7zmc22YTRwqZEvGgqXHlTr0wdxP/4yjDKG/4F3ATyC
        cmATyFh0aj/U1Q==
X-Received: by 10.80.163.131 with SMTP id s3mr1692775edb.156.1495793053663;
        Fri, 26 May 2017 03:04:13 -0700 (PDT)
Received: from localhost.localdomain (x4db25c3a.dyn.telefonica.de. [77.178.92.58])
        by smtp.gmail.com with ESMTPSA id c12sm502412eda.55.2017.05.26.03.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 May 2017 03:04:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch refspecs during initial fetch
Date:   Fri, 26 May 2017 12:04:03 +0200
Message-Id: <20170526100403.19270-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.35.g14b6294b1
In-Reply-To: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 1:07 AM, Jeff King <peff@peff.net> wrote:
>> @@ -989,6 +994,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>>       strbuf_reset(&value);
>>
>>       remote = remote_get(option_origin);
>> +     REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr + 1);
>> +     memcpy(remote->fetch+remote->fetch_refspec_nr, refspec,
>> +            sizeof(*refspec));
>
> Here we append to remote->fetch. We are assuming then that
> remote->fetch_refspec has already been parsed into remote->fetch. Which
> I think it always is by remote_get(),

Right.

> but given that it lazy-parses in
> some cases, it feels a little dangerous.

I'm not sure about lazy parsing.
remote_get() returns a fully-parsed, cached struct remote instance
without re-reading the configuration, so all fields directly
corresponding to configuration variables stay the same.  However, it
does parse fetch and push refspecs on every invocation.  So if it were
to be called to return the origin remote more than once during
cloning, then the default refspec would get lost on subsequent
invocations.  Is this what you meant with dangerous?

(Sidenote: and it would leak some memory, too, because it re-parses
the refspecs without free()ing the results of the previous
invocation.)

Your proposed function to add a refspec as a string would eliminate
this danger.

> I think in the earlier discussion you mentioned there are some
> ordering
> problems with writing out the new on-disk config. But could we add
> it to
> the temporary environment, like:
>
>   strbuf_addf(&key, "remote.%s.fetch=%s", option_origin,
>   refspec_pattern);
>   git_config_push_parameter(key.buf);
>
> ?

> If all that's correct, then I think the push_parameter() thing would
> work. It does feel like a round-a-bout way to solve the problem, but
> it's at least manipulating solid, public APIs.

It certainly looks better, see the patch below the scissors for
reference, and I thought it works because until last night I only run
the corresponding test script (t5611-clone-config), though I know very
well that "Thou shalt always run the full test suite!" :)

Unfortunately, putting the default refspec into this temporary
configuration environment breaks a few submodule tests
(t5614-clone-submodules or t5614-clone-submodules-shallow (it's got
renamed between this topic and master), t7407-submodule-foreach,
t7410-submodule-checkout-to), because it "leaks" to the submodule
environment.


 -- >8 --

Subject: [PATCH] clone: respect additional configured fetch refspecs during
 initial fetch

The initial fetch during a clone doesn't transfer refs matching
additional fetch refspecs given on the command line as configuration
variables.  This contradicts the documentation stating that
configuration variables specified via 'git clone -c <key>=<value> ...'
"take effect immediately after the repository is initialized, but
before the remote history is fetched" and the given example
specifically mentions "adding additional fetch refspecs to the origin
remote".  Furthermore, one-shot configuration variables specified via
'git -c <key>=<value> clone ...', though not written to the newly
created repository's config file, live during the lifetime of the
'clone' command, including the initial fetch.  All this implies that
any fetch refspecs specified this way should already be taken into
account during the initial fetch.

The reason for this is that the initial fetch is not a fully fledged
'git fetch' but a bunch of direct calls into the fetch/transport
machinery with clone's own refs-to-refspec matching logic, which
bypasses parts of 'git fetch' processing configured fetch refspecs.
This logic only considers a single default refspec, potentially
influenced by options like '--single-branch' and '--mirror'.  The
configured refspecs are, however, already read and parsed properly
when clone calls remote.c:remote_get(), but it never looks at the
parsed refspecs in the resulting 'struct remote'.

Modify clone to take the configured fetch refspecs into account to
retrieve all matching refs during the initial fetch.  Note that the
configuration at that point only includes the fetch refspecs specified
by the user, but it doesn't include the default fetch refspec.
To keep the code simple and parsing and memory management of the
refspecs in one place, add the default fetch refspec to the temporary
configuration environment, so remote_get() can parse it along with all
other refspecs that might have been specified on the command line.

Add tests to check that refspecs given both via 'git clone -c ...' and
'git -c ... clone' retrieve all refs matching either the default or
the additional refspecs, and that it works even when the user
specifies an alternative remote name via '--origin=<name>'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c         | 32 ++++++++++++++++----------------
 t/t5611-clone-config.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a35d62293..40f4a327b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -520,7 +520,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, unsigned int refspec_nr)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -541,13 +541,18 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			unsigned int i;
+			for (i = 0; i < refspec_nr; i++)
+				get_fetch_map(remote_head, &refspec[i], &tail, 0);
 
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		unsigned int i;
+		for (i = 0; i < refspec_nr; i++)
+			get_fetch_map(refs, &refspec[i], &tail, 0);
+	}
 
 	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -848,16 +853,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *our_head_points_at;
 	struct ref *mapped_refs;
 	const struct ref *ref;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
+	struct strbuf key = STRBUF_INIT, default_refspec_config = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 
-	struct refspec *refspec;
-	const char *fetch_pattern;
-
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -975,7 +977,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&branch_top, "refs/remotes/%s/", option_origin);
 	}
 
-	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -983,10 +984,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
+	strbuf_addf(&default_refspec_config, "remote.%s.fetch=+%s*:%s*",
+		    option_origin, src_ref_prefix, branch_top.buf);
+	git_config_push_parameter(default_refspec_config.buf);
 
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
@@ -1029,7 +1029,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, remote->fetch,
+					       remote->fetch_refspec_nr);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1107,9 +1108,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
 	strbuf_release(&key);
-	strbuf_release(&value);
+	strbuf_release(&default_refspec_config);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
 	return err;
 }
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778..114b53920 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -37,6 +37,50 @@ test_expect_success 'clone -c config is available during clone' '
 	test_cmp expect child/file
 '
 
+test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
+	rm -rf child &&
+	git update-ref refs/grab/it refs/heads/master &&
+	git update-ref refs/leave/out refs/heads/master &&
+	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
+	rm -rf child &&
+	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
+	rm -rf child &&
+	git clone --origin=upstream \
+		-c "remote.upstream.fetch=+refs/grab/*:refs/grab/*" \
+		-c "remote.origin.fetch=+refs/leave/*:refs/leave/*" \
+		. child &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-EOF &&
+	refs/grab/it
+	refs/heads/master
+	refs/remotes/upstream/HEAD
+	refs/remotes/upstream/master
+	EOF
+	test_cmp expect actual
+'
+
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-- 
2.13.0.35.g14b6294b1

