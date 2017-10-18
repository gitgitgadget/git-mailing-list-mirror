Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D901FF32
	for <e@80x24.org>; Wed, 18 Oct 2017 00:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758707AbdJRAyT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 20:54:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53845 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758702AbdJRAyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 20:54:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7D42A48CA;
        Tue, 17 Oct 2017 20:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lRoWMt866iJU2dR5GW1FMnbmmak=; b=W2qrd6
        jsPk2/wIBznESHtBVEQ+Q4yJMCmBMNTdxcR5MYQAotj0sxt77GCh9oEPoKDu6MGX
        Ek/1oHuElXYq/nFFQ/zZbejTf5yfYXKz/+HTYVygQghYZt7w98koZlJMq9xrM5vv
        wpJr1NPXqkP5+EeoTM1Ibk/cP/hnGaFURJO5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l6K7ImULoxca5xrcZcAwQAHF1McFzY97
        ZuXJ7S4le4HUhdNfPKsGLYX8X176H6a4Hs4FBHP0SUDnlYPh8ke2tN84ZhjEMbI2
        ySA5+mQJp25LKvapHFveGbEhfgXXW5fT/VPfQSzPHn4kb8wMZH+RWyVZ/6MWfVz2
        dgwF4dSmeZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF63CA48C9;
        Tue, 17 Oct 2017 20:54:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EB57A48C8;
        Tue, 17 Oct 2017 20:54:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Thais Diniz <thais.dinizbraz@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Added support for new configuration parameter push.pushOption
References: <CAK7vU=1LGTLrEkRYS=autkDHmJAeq9=qa5jfx=DE+acPLsCqTg@mail.gmail.com>
Date:   Wed, 18 Oct 2017 09:54:12 +0900
In-Reply-To: <CAK7vU=1LGTLrEkRYS=autkDHmJAeq9=qa5jfx=DE+acPLsCqTg@mail.gmail.com>
        (Marius Paliga's message of "Tue, 17 Oct 2017 08:32:40 +0200")
Message-ID: <xmqqvajdl1hn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC680C46-B39E-11E7-8362-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> builtin/push.c: add push.pushOption config

This is a good title for this change; it would be perfect if it were
on the Subject: header ;-)

> Currently push options need to be given explicitly, via
> the command line as "git push --push-option".
>
> The UX of Git would be enhanced if push options could be
> configured instead of given each time on the command line.
>
> Add the config option push.pushOption, which is a multi
> string option, containing push options that are sent by default.

s/Currently p/P/ would be sufficient; we describe the status quo in
present tense, and give an order to the codebase to "become like so"
(or command a patch monkey to "make the codebase like so") by using
imperative mood.

I think something shorter like this would be sufficient:

    Push options need to be given explicitly, via the command line as "git
    push --push-option <option>".  Add the config option push.pushOption,
    which is a multi-valued option, containing push options that are sent
    by default.

    When push options are set in the lower-priority configulation file
    (e.g. /etc/gitconfig, or $HOME/.gitconfig), they can be unset later in
    the more specific repository config by the empty string.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 3e76e99f3..da9b17624 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -161,6 +161,9 @@ already exists on the remote side.
>      Transmit the given string to the server, which passes them to
>      the pre-receive as well as the post-receive hook. The given string
>      must not contain a NUL or LF character.
> +    Default push options can also be specified with configuration
> +    variable `push.pushOption`. String(s) specified here will always
> +    be passed to the server without need to specify it using `--push-option`

"will always be passed" is not a "Default".  

If we really need to say it, say something like

	When no `--push-option <option>` is given from the command
	line, the values of this configuration variable are used
	instead.

But that is what "Default" means, so dropping the second sentence
altogether would be more concise and better.

> diff --git a/builtin/push.c b/builtin/push.c
> index 2ac810422..10e520c8f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -32,6 +32,8 @@ static const char **refspec;
>  static int refspec_nr;
>  static int refspec_alloc;
>
> +static struct string_list push_options_from_config = STRING_LIST_INIT_DUP;
> +
>  static void add_refspec(const char *ref)
>  {
>      refspec_nr++;
> @@ -503,6 +505,14 @@ static int git_push_config(const char *k, const
> char *v, void *cb)
>          int val = git_config_bool(k, v) ?
>              RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
>          recurse_submodules = val;
> +    } else if (!strcmp(k, "push.pushoption")) {
> +        if (v == NULL)
> +            return config_error_nonbool(k);
> +        else
> +            if (v[0] == '\0')

Make this "else if (!*v)" on a single line and dedent the remainder.

> +                string_list_clear(&push_options_from_config, 0);
> +            else
> +                string_list_append(&push_options_from_config, v);
>      }

> @@ -562,6 +572,8 @@ int cmd_push(int argc, const char **argv, const
> char *prefix)
>      packet_trace_identity("push");
>      git_config(git_push_config, &flags);
>      argc = parse_options(argc, argv, prefix, options, push_usage, 0);
> +    if (!push_options.nr)
> +        push_options = push_options_from_config;

We encourage our developers to think twice before doing a structure
assignment.

I think this is a bad idea, primarily because at the point where
string_list_clear() is later called on &push_options, it is unclear
how to release the resources held by push_options_from_config().  It
also is bad to depend on the implementation detail that overwriting
the structure do not leak push_options.item when push_options.nr is
zero, but it is conceivable that STRING_LIST_INIT_* could later be
modified to pre-allocate a small array, at which point this will
become a memory leak.

> diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
> index 90a4b0d2f..463783789 100755
> --- a/t/t5545-push-options.sh
> +++ b/t/t5545-push-options.sh
> @@ -140,6 +140,83 @@ test_expect_success 'push options and submodules' '
> ...
> +        git -c push.pushOption=default1 -c push.pushOption=default2
> push up master
> ...
> +test_expect_success 'push option from command line overrides
> from-config push option' '

It appears that your MUA is expanding tabs to spaces and wrapping
long lines in your patch?  Please double check and make sure that
will not happen.

I couldn't use your patch (because it was broken by your MUA) as a
base to show an incremental improvement, but here is how I would do
the "code" part.

 builtin/push.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 03846e8379..89ef029c67 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -32,6 +32,8 @@ static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
 
+static struct string_list push_options_config = STRING_LIST_INIT_DUP;
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -503,6 +505,13 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		int val = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON_DEMAND : RECURSE_SUBMODULES_OFF;
 		recurse_submodules = val;
+	} else if (!strcmp(k, "push.pushoption")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!*v)
+			string_list_clear(&push_options_config, 0);
+		else
+			string_list_append(&push_options_config, v);
 	}
 
 	return git_default_config(k, v, NULL);
@@ -515,7 +524,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int push_cert = -1;
 	int rc;
 	const char *repo = NULL;	/* default repository */
-	struct string_list push_options = STRING_LIST_INIT_DUP;
+	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
+	struct string_list *push_options;
 	const struct string_list_item *item;
 
 	struct option options[] = {
@@ -562,6 +572,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("push");
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	push_options = (push_options_cmdline.nr
+			? &push_options_cmdline
+			: &push_options_config);
 	set_push_cert_flags(&flags, push_cert);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
@@ -584,12 +597,13 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	for_each_string_list_item(item, &push_options)
+	for_each_string_list_item(item, push_options)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(repo, flags, &push_options);
-	string_list_clear(&push_options, 0);
+	rc = do_push(repo, flags, push_options);
+	string_list_clear(&push_options_cmdline, 0);
+	string_list_clear(&push_options_config, 0);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else

