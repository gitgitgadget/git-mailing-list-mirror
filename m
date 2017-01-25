Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911211F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbdAYWfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:35:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59389 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752366AbdAYWfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:35:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA98A6401F;
        Wed, 25 Jan 2017 17:35:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P4xYqluh+bVJH1z16gcZkwsOER8=; b=WnUO/1
        KxMG0bjEu4EZQJ89vHEfFEi+CKvYuRGN1AKZCp8YXbfCfiLwQBDBuIwG/DO2G+oc
        oQihFWA3ep0WnD+u1N4EtSrjQb354zWtHJWA8nTrnk0lEb6dFx3RR2O140BujnZf
        4rZfbAtZfwGjDLbHF+d6jAki7JzdcECEsgbtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FDodawXdlS1ufTxfEmKbi/2ojy3Zl5Dc
        iar75s4bTxODAmWn2+VR8mDkGzTK4UvzkFkacihnPo0nNaTvqRWxu/wuURJ3nO3N
        WScYhbZDuQLXy0AKga/+IwUBVHPehSvA1KseYP3uF+ymrT+iZyjn6bOfO3vD/7Ff
        1HLumSbCrtM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1F486401E;
        Wed, 25 Jan 2017 17:35:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12E046401D;
        Wed, 25 Jan 2017 17:35:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <xmqqy3ym1dsc.fsf@gitster.mtv.corp.google.com>
        <xmqq4m1911mf.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090825510.3469@virtualbox>
        <xmqqh958y44c.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701091207480.3469@virtualbox>
        <xmqqmvf0wc2h.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701251327090.3469@virtualbox>
Date:   Wed, 25 Jan 2017 14:35:36 -0800
In-Reply-To: <alpine.DEB.2.20.1701251327090.3469@virtualbox> (Johannes
        Schindelin's message of "Wed, 25 Jan 2017 13:34:21 +0100 (CET)")
Message-ID: <xmqqinp2939j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98259AF6-E34E-11E6-BDF5-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, with the patch in question (without the follow-up, which I would like
> to ask you to ignore, just like you did so far), Git would not figure out
> that your script calls PuTTY eventually. The work-around? Easy:
>
> 	DUMMY=/plink.exe /path/to/junio-is-a-superstar.sh

Think about how you would explain that to an end-user in our
document?  You'll need to explain how exactly the auto-detection
works, so that the user can "exploit" the loophole to do that.  And
what maintenance burden does it add when auto-detection is updated?

I think I know you well enough that you know well enough that it is
too ugly to live, and I suspect that the above is a tongue-in-cheek
"arguing for the sake of argument" and would not need a serious
response, but just in case...

> ...
> Of course, given our discussion I think all of this should be documented
> in the commit message as well as in the man page.

Yes.  Here is what comes on an obvious clean-up patch (which will be
sent as a follow-up to this message).

-- >8 --
Subject: [PATCH] connect: core.sshvariant to correct misidentification

While the logic we have been using to guess which variant of SSH
implementation is in use by looking at the name of the program has
been robust enough for GIT_SSH (which does not go through the shell,
hence it can only spell the name the SSH program and nothing else),
extending it to GIT_SSH_COMMAND and core.sshcommand opens it for
larger chance of misidentification, because these can specify
arbitrary shell command, and a simple "the first word on the line
must be the command name" heuristic may not even look at the command
name at all.

As any effort to improve the heuristic will give us only diminishing
returns, and especially given that most of the users are expected to
have a command line for which the heuristic would work correctly,
give an explicit escape hatch to override a misidentification, just
in case one happens.

It is arguably bad to add this new variable to the core.* set, in
the sense that you'll never see this variable if you do not interact
with other repositories over ssh, but core.sshcommand is already
there for some reason, so let's match it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 13 +++++++++++++
 connect.c                | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4cc02..8ea1db49c6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -455,6 +455,19 @@ core.sshCommand::
 	the `GIT_SSH_COMMAND` environment variable and is overridden
 	when the environment variable is set.
 
+core.sshVariant::
+	SSH implementations used by Git when running `git fetch`,
+	`git clone`, and `git push` use slightly different command
+	line options (e.g. PuTTY and TortoisePlink use `-P <port>`
+	while OpenSSH uses `-p <port>` to specify the port number.
+	TortoisePlink in addition requires `-batch` option to be
+	passed).  Git guesses which variant is in use correctly from
+	the name of the ssh command used (see `core.sshCommand`
+	configuration variable and also `GIT_SSH_COMMAND`
+	environment variable) most of the time.  You can set this
+	variable to 'putty', 'tortoiseplink', or 'ssh' to correct it
+	when Git makes an incorrect guess.
+
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
 	changed by setting the "assume-unchanged" bit for those tracked files
diff --git a/connect.c b/connect.c
index aa51b33bfc..358e9c06f0 100644
--- a/connect.c
+++ b/connect.c
@@ -691,6 +691,29 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
+static void override_ssh_variant(int *port_option, int *needs_batch)
+{
+	const char *variant;
+
+	if (git_config_get_string_const("core.sshvariant", &variant))
+		return;
+	if (!strcmp(variant, "tortoiseplink")) {
+		*port_option = 'P';
+		*needs_batch = 1;
+	} else if (!strcmp(variant, "putty")) {
+		*port_option = 'P';
+		*needs_batch = 0;
+	} else {
+		/* default */
+		if (strcmp(variant, "ssh")) {
+			warning(_("core.sshvariant: unknown value '%s'"), variant);
+			warning(_("using OpenSSH compatible behaviour"));
+		}
+		*port_option = 'p';
+		*needs_batch = 0;
+	}
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -836,6 +859,9 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, "-4");
 			else if (flags & CONNECT_IPV6)
 				argv_array_push(&conn->args, "-6");
+
+			override_ssh_variant(&port_option, &needs_batch);
+
 			if (needs_batch)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
-- 
2.11.0-699-ga1f1475476



