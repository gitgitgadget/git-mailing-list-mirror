From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t9902 fails
Date: Fri, 18 Jan 2013 12:15:23 -0800
Message-ID: <7vmww6qmck.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <20130115232400.GA16147@sigill.intra.peff.net> <50F64597.2070100@web.de>
 <201301172347.50157.avila.jn@gmail.com> <20130118000454.GI13449@google.com>
 <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwILt-0001Ia-28
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 21:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab3ARUP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 15:15:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3ARUP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 15:15:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC72C52E;
	Fri, 18 Jan 2013 15:15:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CvSJXGJgBUbpZjmSwk2Thvq18hE=; b=c0f1Fc
	P9N74YHw+AbRFPRcatkx4W1cnGQsdvUtRqoUIoclLLSN2+A3Q2wnhQ5aeDz+XbLN
	VNSGhOnY/rylnl1zJaMEhDIcszDJRhddKZ/g1n6e0NgzTY+GL3h/3H/v4vRNYEI/
	jgymbNqa0jbdt1DqnUNOk5mANxfv7nDWP/YTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GhHTxnTAog00cUXem+NOWyw5bpFT6K1L
	XOz+PyMuLCcdG2Sm4GTlBUhfU09ITLESn1gKhIZ2fv7Al4HvEEn6EObsF2iuHbka
	ZOvVMbEpYoCeC76ALF8OqQ+70b1zYfy+9i2FJ2ePaBM46mpH95p39WkqKcIGXOL+
	2E2A6q5jepw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A90C52D;
	Fri, 18 Jan 2013 15:15:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6826AC52B; Fri, 18 Jan 2013
 15:15:25 -0500 (EST)
In-Reply-To: <7v8v7qsagd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 18 Jan 2013 08:49:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB69FBB0-61AB-11E2-9C9B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213932>

Junio C Hamano <gitster@pobox.com> writes:

> How about doing something like this and set that variable in the
> test instead?  If STD_ONLY is not set, you will get everything, but
> when STD_ONLY is set, we will stop reading from "help -a" when it
> starts listing additional stuff.
>
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index a4c48e1..415a078 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -534,7 +534,8 @@ __git_complete_strategy ()
>  __git_list_all_commands ()
>  {
>  	local i IFS=" "$'\n'
> -	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
> +	for i in $(LANG=C LC_ALL=C git help -a |
> +		   sed -n ${GIT_HELP_STD_ONLY+-e /^git.*elsewhere/q} -e '/^  [a-zA-Z0-9]/p')
>  	do
>  		case $i in
>  		*--*)             : helper pattern;;

Alternatively, we could do this and replace everything inside $()
with "git help --standard", but that requires the completion script
update to go in sync with the core update, which is a downside.

 builtin/help.c | 21 +++++++++++++++++----
 help.c         |  3 +++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index bd86253..e6b9b5f 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,11 +36,16 @@ enum help_format {
 
 static const char *html_path;
 
-static int show_all = 0;
+#define HELP_ALL 1
+#define HELP_STANDARD 2
+static int show_what;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
+	OPT_SET_INT('a', "all", &show_what, N_("print all available commands"),
+		    HELP_ALL),
+	OPT_SET_INT(0, "standard", &show_what, N_("list subcommands that comes with git"),
+		    HELP_STANDARD),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -436,19 +441,27 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
-	load_command_list("git-", &main_cmds, &other_cmds);
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
-	if (show_all) {
+	load_command_list("git-", &main_cmds,
+			  show_what == HELP_STANDARD ? NULL : &other_cmds);
+
+	if (show_what == HELP_ALL) {
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	}
+	if (show_what == HELP_STANDARD) {
+		int i;
+		for (i = 0; i < main_cmds.cnt; i++)
+			printf("%s\n", main_cmds.names[i]->name);
+		return 0;
+	}
 
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
diff --git a/help.c b/help.c
index 2a42ec6..3e6b04c 100644
--- a/help.c
+++ b/help.c
@@ -182,6 +182,9 @@ void load_command_list(const char *prefix,
 		uniq(main_cmds);
 	}
 
+	if (!other_cmds)
+		return;
+
 	if (env_path) {
 		char *paths, *path, *colon;
 		path = paths = xstrdup(env_path);
