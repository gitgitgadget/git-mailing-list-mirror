Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F1F1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 19:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbdBATqq (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 14:46:46 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35084 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdBATqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 14:46:45 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so32502136pfa.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rqK7GXyQLDqDeTPUjNtnRQAr8MhmsEb0W0NDQlme1cM=;
        b=fpiXODkrIhzbX+whU6eSH+ETMNxJH0PczjbWJxuo3/6I3Ic8Qpj84eYJMWNoYShpt2
         whgbIANYpYt9bjumYg/SA+tBMKHg5Ft6ghmFJCdbfy7wZexxuiApUxcYJSjecfQ9zX1c
         HrWJUobLPFS/AR0UIAPhoP4UscxmfQlFKs2dig871CX9OMrx3Xzb5qbowpUXjHs7fmcg
         9ROefpVLDqitqgdEVXbQzIH+CZBQwge1U1YNydvT8SJbC+iwMPIE38ccJWQ8Zd1ZKCEA
         tz85wg3+wb4h88BKuNsJt9L9AjlVfHmMpGgGegDROgDKWKrUXXaEZlsC2ub/F4uEPL7S
         1olA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rqK7GXyQLDqDeTPUjNtnRQAr8MhmsEb0W0NDQlme1cM=;
        b=jF2I6adb6o2i8QLKAicdfKr/qaL2YHCYiTzklnr+oYw4WliZL6rracKLu7QV5XwS9o
         pvVuOTHoNfwvw4sVeQB71xFcVxy7aZNQF2xXMM0R1gMHV2nXUk24jY58tAXme3wOtDS2
         nOZ8/rgC0fclfXXZFxxxtNmWRpbyQjtl+nuXVeMNmshPVGcvecIg4v4jjFbhcE+/ZFC1
         cbbJowQLu+UDUT6If5eWH2dkJVEHmzqUyUWq/wMXxEcc5rJnafJEzZesr7T440r3EbvW
         VKv9mu4n1Ijf5O0oKWOgiU3RTpTQHpkx+xSz7AkvroKPvw5t27eQDZZR2ob4JoWEiKsz
         RmBA==
X-Gm-Message-State: AIkVDXKxLc31zX7e8dMJBz6m/09ZrEKMIpvssoWCEoR6ebLpfgKIoTyY9DiBWsfas/0ebQ==
X-Received: by 10.98.160.89 with SMTP id r86mr5604554pfe.170.1485978404273;
        Wed, 01 Feb 2017 11:46:44 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id f65sm51787101pfk.5.2017.02.01.11.46.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 11:46:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
        <cover.1485950225.git.johannes.schindelin@gmx.de>
        <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de>
        <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Feb 2017 11:46:41 -0800
In-Reply-To: <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Feb 2017 11:19:19 -0800")
Message-ID: <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think restructuring along the line of 3/4 of this round is very
> sensible in the longer term (if anything, handle_ssh_variant() now
> really handles ssh variants in all cases, which makes it worthy of
> its name, as opposed to the one in the previous round that only
> reacts to the overrides).  But it seems that it will take longer to
> get such a rewrite right, and my priority is seeing this topic to
> add autodetection to GIT_SSH_COMMAND and other smaller topics in the
> upcoming -rc0 in a serviceable and correct shape.
>
> The restructuring done by 3/4 can come later after the dust settles,
> if somebody cares deeply enough about performance in the rare cases.

Having said all that, because I like the patch 3/4 so much, here is
another way to fix this, and I think (of course I am biased, but...)
the result is easier to grok.  Not only it makes it clear that the
namespace for the actual command names on the command line and the
namespace for the supported values of the configuration are distinct,
it makes it clear that we do not do anything extra when the user
explicitly tells us which variant to use.

This is designed to be squashed into [4/4] of this latest round (as
opposed to the one in the message I am responding to, which is to be
squashed into the previous round).

 connect.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/connect.c b/connect.c
index 7f1f802396..12ad8d4c8b 100644
--- a/connect.c
+++ b/connect.c
@@ -691,17 +691,39 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
-static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
-			      int *port_option, int *needs_batch)
+static int override_ssh_variant(int *port_option, int *needs_batch)
 {
-	const char *variant = getenv("GIT_SSH_VARIANT");
+	char *variant;
+
+	variant = xstrdup_or_null(getenv("GIT_SSH_VARIANT"));
+	if (!variant &&
+	    git_config_get_string("ssh.variant", &variant))
+		return 0;
+
+	if (!strcmp(variant, "plink") || !strcmp(variant, "putty")) {
+		*port_option = 'P';
+		*needs_batch = 0;
+	} else if (!strcmp(variant, "tortoiseplink")) {
+		*port_option = 'P';
+		*needs_batch = 1;
+	} else {
+		*port_option = 'p';
+		*needs_batch = 0;
+	}
+	free(variant);
+	return 1;
+}
+
+static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
+			       int *port_option, int *needs_batch)
+{
+	const char *variant;
 	char *p = NULL;
 
-	if (variant)
-		; /* okay, fall through */
-	else if (!git_config_get_string("ssh.variant", &p))
-		variant = p;
-	else if (!is_cmdline) {
+	if (override_ssh_variant(port_option, needs_batch))
+		return;
+
+	if (!is_cmdline) {
 		p = xstrdup(ssh_command);
 		variant = basename(p);
 	} else {
@@ -717,7 +739,7 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 			 */
 			free(ssh_argv);
 		} else
-			return 0;
+			return;
 	}
 
 	if (!strcasecmp(variant, "plink") ||
@@ -730,8 +752,6 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 		*needs_batch = 1;
 	}
 	free(p);
-
-	return 1;
 }
 
 /*
