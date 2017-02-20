Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C391B201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 09:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbdBTJ6N (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 04:58:13 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35065 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdBTJ6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 04:58:11 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so5064515pgz.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 01:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sNv8UyBtXBo8nInawRmyf6YjbFI04j1eBhZ0DX9kDms=;
        b=ESDQhBTSRxvap7mfPqO6JgV8qCNVr28lPpy8ZVf+SlvO4nZTnOigi6J6gvsxKhq0jD
         h5JDUdliW5skG7XdEPVdEFGLOlh+0qVN5ugn+xOVuzZPIv1Ad3BV7UR6/mjlk2zqF5ER
         /j0wzUTbOsHNVUsr9ZuMoaUHTcJYAMfAdRuYVYsOouruJaZfxxwA3IhOmlwp7TBREWOH
         VojjijEcmaeowLf26lVZfLRvaw31V5dv+p0PUdruiWJWt5cNPNxiEJCHN/+f1VOPmTrN
         2G9bRfOiQ8Z401c9cxVb5gqttzH7LM6shJWf/ed00g/Uum2GKM6PvPUCA8AZudMB4A9v
         4jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sNv8UyBtXBo8nInawRmyf6YjbFI04j1eBhZ0DX9kDms=;
        b=DDjFKESOb8d1V4dLyd2u5HoV+fSFM8TMbo4/ZXzEitFOtaV5gWI1tn1WlfvjdtVa+E
         7ke3dhvZJxrnvoL6C0WZa5jJVBGCOEncGF5cI7046Prsf+FFKOXxZdlBporVL3gORUzC
         I/E7/TrUwJlEld7LeFAzpwz0se0BpTH1WSBe3Gv0J5M+neCXHiBUgMV5kHV1RHtHVeuH
         ZI+/HGpI56bA4MLqTH8SDLg1jad+602um8RwR53mad3yKZoL7WCLDJySa6ALasWP6qod
         9pyZ+2MRx9l09xJD5O1fYBkw3r4P3i4rZu12CA7L4eAWE8BtsNMUPQ1lwga7Qbrwtujg
         ZORw==
X-Gm-Message-State: AMke39mCZwY+0DrQgeLH2eyFXVM3F4OU1CyQWBtFbqG+UxO23Qq8PdR8kKpPHq1IW5ZZjA==
X-Received: by 10.98.61.209 with SMTP id x78mr377188pfj.88.1487584690182;
        Mon, 20 Feb 2017 01:58:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id w18sm33938455pfa.127.2017.02.20.01.58.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 01:58:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] config: preserve <subsection> case for one-shot config on the command line
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 20 Feb 2017 01:58:07 -0800
In-Reply-To: <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Feb 2017 17:25:35 -0800")
Message-ID: <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I still haven't queued any of the variants I posted (and I do not
> think other people sent their own versions, either).  I need to pick
> one and queue, with a test or two.  Perhaps after -rc2.  
>
> Others are welcome to work on it while I cut -rc2 tomorrow, so that
> by the time I see their patch all that is left for me to do is to
> apply it ;-)

Since nothing seems to have happened in the meantime, here is what
I'll queue so that we won't forget for now.  Lars's tests based on
how the scripted "git submodule" uses "git config" may still be
valid, but it is somewhat a roundabout way to demonstrate the
breakage and not very effective way to protect the fix, so I added a
new test that directly tests "git -c <var>=<val> <command>".

I am not sure if this updated one is worth doing, or the previous
"strchr and strrchr" I originally wrote was easier to understand.

One thing I noticed is that "git config --get X" will correctly
diagnose that a dot-less X is not a valid variable name, but we do
not seem to diagnose "git -c X=V <cmd>" as invalid.

Perhaps we should, but it is not the focus of this topic.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 15 Feb 2017 15:48:44 -0800
Subject: [PATCH] config: preserve <subsection> case for one-shot config on the
 command line

The "git -c <var>=<val> cmd" mechanism is to pretend that a
configuration variable <var> is set to <val> while the cmd is
running.  The code to do so however downcased <var> in its entirety,
which is wrong for a three-level <section>.<subsection>.<variable>.

The <subsection> part needs to stay as-is.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Diagnosed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c                  | 30 ++++++++++++++++++++++++++++-
 t/t1351-config-cmdline.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100755 t/t1351-config-cmdline.sh

diff --git a/config.c b/config.c
index 0dfed682b8..ba9a5911b0 100644
--- a/config.c
+++ b/config.c
@@ -199,6 +199,34 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
+/*
+ * downcase the <section> and <variable> in <section>.<variable> or
+ * <section>.<subsection>.<variable> and do so in place.  <subsection>
+ * is left intact.
+ */
+static void canonicalize_config_variable_name(char *varname)
+{
+	char *cp, *last_dot;
+
+	/* downcase the first segment */
+	for (cp = varname; *cp; cp++) {
+		if (*cp == '.')
+			break;
+		*cp = tolower(*cp);
+	}
+	if (!*cp)
+		return;
+
+	/* scan for the last dot */
+	for (last_dot = cp; *cp; cp++)
+		if (*cp == '.')
+			last_dot = cp;
+
+	/* downcase the last segment */
+	for (cp = last_dot; *cp; cp++)
+		*cp = tolower(*cp);
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
@@ -221,7 +249,7 @@ int git_config_parse_parameter(const char *text,
 		strbuf_list_free(pair);
 		return error("bogus config parameter: %s", text);
 	}
-	strbuf_tolower(pair[0]);
+	canonicalize_config_variable_name(pair[0]->buf);
 	if (fn(pair[0]->buf, value, data) < 0) {
 		strbuf_list_free(pair);
 		return -1;
diff --git a/t/t1351-config-cmdline.sh b/t/t1351-config-cmdline.sh
new file mode 100755
index 0000000000..acb8dc3b15
--- /dev/null
+++ b/t/t1351-config-cmdline.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='git -c var=val'
+
+. ./test-lib.sh
+
+test_expect_success 'last one wins: two level vars' '
+	echo VAL >expect &&
+
+	# sec.var and sec.VAR are the same variable, as the first
+	# and the last level of a configuration variable name is
+	# case insensitive.  Test both setting and querying.
+
+	git -c sec.var=val -c sec.VAR=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.var >actual &&
+	test_cmp expect actual &&
+
+	git -c sec.var=val -c sec.VAR=VAL config --get SEC.var >actual &&
+	test_cmp expect actual &&
+	git -c SEC.var=val -c sec.var=VAL config --get sec.VAR >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'last one wins: three level vars' '
+	echo val >expect &&
+
+	# v.a.r and v.A.r are not the same variable, as the middle
+	# level of a three-level configuration variable name is
+	# case sensitive.  Test both setting and querying.
+
+	git -c v.a.r=val -c v.A.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.A.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+
+	echo VAL >expect &&
+	git -c v.a.r=val -c v.a.R=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get v.a.r >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c v.a.R=VAL config --get V.a.R >actual &&
+	test_cmp expect actual &&
+	git -c v.a.r=val -c V.a.r=VAL config --get V.a.R >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.12.0-rc2-221-g8fa194a99f

