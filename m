Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C601F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdBATTo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 14:19:44 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33223 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdBATTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 14:19:41 -0500
Received: by mail-pg0-f68.google.com with SMTP id 194so34982025pgd.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LSPopEz00NP6wjkj05HkjUxMenuCjDPD40Y2k+AzzGc=;
        b=bc1YhUkaypLrt4PEunWQiqJqqdyIDSFDJdn2MSA8J4teeq2oMxhfS7GcsUTy3MrRga
         gHd2XtOvoT+CutxLpk+hRSUVwLSIKGKYRwKkuXgHA9AAdr5USim8M30RUtq38/0oG0Z2
         QMWzSZiUB+cyynVzA5ajM2YMe3Gvo+KCOmgGbT8E2EPexVGIAvmSDzJ53L9q9xWsXiL0
         tvK0F2JX1Ji8TxjLgU1Qm2mKrMxIMSy8wQagaUhCY5LUmfwq2JHLZN/0tpB+JhpQl3/n
         3y41C+JB3GjFXgOrDwr+MZ1TROK9VUj9xA4Actbb6h6mNRCPm2Qs+i8iLXyCGTnthKSH
         Dccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LSPopEz00NP6wjkj05HkjUxMenuCjDPD40Y2k+AzzGc=;
        b=CZSiJLRMkZ50ZjounZFFCeRdGxsmiwp+MCO39nGEXij/yqM+uXXfabu5q6n5ga0fmy
         WfK0TmA2yhusp/22mVQ53c3y1ujjNY3QtYLANC4fS0/wbqtWK+dJq3xIT4Fi5YrTseGX
         QDBqOcjVt8ZY9DWD5flQoHihJGTEDeozRX/lyru+MXJIq4oHcaB9iP4Fz583SHxdPwgq
         J3yRD1wDBljQvGNQQkPut3tkegehoAbKb5su5E6TwfObJU89q7N9afiDLiCUGCbInqI/
         4/a4m4d+GUaZoSURr73vtEpC1223Zf34e3/VhOZ3zPz23RhYDDnZo17m9SuNRwHpulFS
         D/0A==
X-Gm-Message-State: AIkVDXLcSMjlL9rnynEgVMh0MhSb81o+LpBsgClXf/qMnFbhIJXVTwmUz/wQ9PhmKq3kpQ==
X-Received: by 10.98.194.153 with SMTP id w25mr5432207pfk.181.1485976781037;
        Wed, 01 Feb 2017 11:19:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id o18sm52142054pgn.36.2017.02.01.11.19.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 11:19:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
        <cover.1485950225.git.johannes.schindelin@gmx.de>
        <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de>
Date:   Wed, 01 Feb 2017 11:19:19 -0800
In-Reply-To: <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 1 Feb 2017 13:01:16 +0100
        (CET)")
Message-ID: <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> index 2734b9a1ca..7f1f802396 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -694,10 +694,14 @@ static const char *get_ssh_command(void)
>  static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
>  			      int *port_option, int *needs_batch)
>  {
> -	const char *variant;
> +	const char *variant = getenv("GIT_SSH_VARIANT");
>  	char *p = NULL;
>  
> -	if (!is_cmdline) {
> +	if (variant)
> +		; /* okay, fall through */
> +	else if (!git_config_get_string("ssh.variant", &p))
> +		variant = p;
> +	else if (!is_cmdline) {
>  		p = xstrdup(ssh_command);
>  		variant = basename(p);
>  	} else {
> @@ -717,7 +721,8 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
>  	}
>  
>  	if (!strcasecmp(variant, "plink") ||
> -	    !strcasecmp(variant, "plink.exe"))
> +	    !strcasecmp(variant, "plink.exe") ||
> +	    !strcasecmp(variant, "putty"))

This means that "putty" that appear as the first word of the command
line, not the value configured for ssh.variant or GIT_SSH_VARIANT,
will also trigger the option for "plink", no?

Worse, "plink.exe" configured as the value of "ssh.variant", is
anything other than 'ssh', 'plink', 'putty', or 'tortoiseplink', but
it is not treated as normal ssh, contrary to the documentation.

> +ssh.variant::
> +	Depending on the value of the environment variables `GIT_SSH` or
> +	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
> +	auto-detects whether to adjust its command-line parameters for use
> +	with plink or tortoiseplink, as opposed to the default (OpenSSH).
> ++
> +The config variable `ssh.variant` can be set to override this auto-detection;
> +valid values are `ssh`, `plink`, `putty` or `tortoiseplink`. Any other value
> +will be treated as normal ssh. This setting can be overridden via the
> +environment variable `GIT_SSH_VARIANT`.

I was hoping that the "rewrite that retains simplicity" was also
correct, but let's not go in this direction.  The more lines you
touch in a hurry, the worse the code will get, and that is to be
expected.

I'd suggest taking the documentation updates from this series, and
then minimally plug the leak introduced by the previous round,
perhaps like the attached SQUASH.  As I said, GIT_SSH_VARIANT and
ssh.variant are expected to be rare cases, and the case in which
they are set does not have to be optimized if it makes the necessary
change smaller and more likely to be correct.

I think restructuring along the line of 3/4 of this round is very
sensible in the longer term (if anything, handle_ssh_variant() now
really handles ssh variants in all cases, which makes it worthy of
its name, as opposed to the one in the previous round that only
reacts to the overrides).  But it seems that it will take longer to
get such a rewrite right, and my priority is seeing this topic to
add autodetection to GIT_SSH_COMMAND and other smaller topics in the
upcoming -rc0 in a serviceable and correct shape.

The restructuring done by 3/4 can come later after the dust settles,
if somebody cares deeply enough about performance in the rare cases.

 Documentation/config.txt | 14 +++++++++-----
 Documentation/git.txt    |  9 ++++-----
 connect.c                |  9 +++++----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f2c210f0a0..b88df57ab6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1950,11 +1950,15 @@ matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
 ssh.variant::
-	Override the autodetection of plink/tortoiseplink in the SSH
-	command that 'git fetch' and 'git push' use. It can be set to
-	either `ssh`, `plink`, `putty` or `tortoiseplink`. Any other
-	value will be treated as normal ssh. This is useful in case
-	that Git gets this wrong.
+	Depending on the value of the environment variables `GIT_SSH` or
+	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
+	auto-detects whether to adjust its command-line parameters for use
+	with plink or tortoiseplink, as opposed to the default (OpenSSH).
++
+The config variable `ssh.variant` can be set to override this auto-detection;
+valid values are `ssh`, `plink`, `putty` or `tortoiseplink`. Any other value
+will be treated as normal ssh. This setting can be overridden via the
+environment variable `GIT_SSH_VARIANT`.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
diff --git a/Documentation/git.txt b/Documentation/git.txt
index c322558aa7..a0c6728d1a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1021,11 +1021,10 @@ personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
 `GIT_SSH_VARIANT`::
-	If this environment variable is set, it overrides the autodetection
-	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
-	push' use. It can be set to either `ssh`, `plink`, `putty` or
-	`tortoiseplink`. Any other value will be treated as normal ssh. This
-	is useful in case that Git gets this wrong.
+	If this environment variable is set, it overrides Git's autodetection
+	whether `GIT_SSH`/`GIT_SSH_COMMAND`/`core.sshCommand` refer to OpenSSH,
+	plink or tortoiseplink. This variable overrides the config setting
+	`ssh.variant` that serves the same purpose.
 
 `GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
diff --git a/connect.c b/connect.c
index 7b4437578b..da51fef9ee 100644
--- a/connect.c
+++ b/connect.c
@@ -693,10 +693,11 @@ static const char *get_ssh_command(void)
 
 static int handle_ssh_variant(int *port_option, int *needs_batch)
 {
-	const char *variant;
+	char *variant;
 
-	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
-		git_config_get_string_const("ssh.variant", &variant))
+	variant = xstrdup_or_null(getenv("GIT_SSH_VARIANT"));
+	if (!variant &&
+	    git_config_get_string("ssh.variant", &variant))
 		return 0;
 
 	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
@@ -705,7 +706,7 @@ static int handle_ssh_variant(int *port_option, int *needs_batch)
 		*port_option = 'P';
 		*needs_batch = 1;
 	}
-
+	free(variant);
 	return 1;
 }
 
