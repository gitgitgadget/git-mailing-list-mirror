From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] add a commit.verbose config variable
Date: Wed, 09 Mar 2016 22:21:54 +0100
Message-ID: <vpqlh5r9wjx.fsf@anie.imag.fr>
References: <010201535cb62b56-9aa72755-b730-478c-9244-41a1ee69e231-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 22:22:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adlYS-0002Cb-NB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 22:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934221AbcCIVWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 16:22:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36066 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504AbcCIVV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 16:21:59 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u29LLqpe011726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 9 Mar 2016 22:21:52 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u29LLs4H029320;
	Wed, 9 Mar 2016 22:21:54 +0100
In-Reply-To: <010201535cb62b56-9aa72755-b730-478c-9244-41a1ee69e231-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Wed, 9 Mar 2016 18:49:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Mar 2016 22:21:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u29LLqpe011726
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1458163313.83154@+4BY5xsF4qtEeAWGX1JHwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288576>

Hi,

This is v2, right? Then call it [PATCH v2] in the title, and summarize
the diff wrt v1. As much as possible, Cc people who participated in the
review of v1.

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Since many people always run the command with this option, and would
> prefer not to use the argument again and again but instead specify it in
> the configuration file.

"Since ... and ..." calls for a verb to end the sentence (already noted
by Eric with v1).

> +commit.verbose::
> +	A boolean to specify whether to always include the verbose option
> +	with `git commit`. See linkgit:git-commit[1]

Either say "See linkgit:git-commit[1]" between parenthesis, or add a
period (.) at the end of the sentence.

> +--override-verbose::
> +	Disable verbose for the commit if you have activated it
> +	permanently in the configuration variable `commit.verbose`.

The convention is to call this --no-verbose. --override-verbose is not a
good name for such option.

Look how other similar cases are managed (e.g. status.short,
status.branch, am.threeway)

> @@ -1654,6 +1656,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +
> +	if( !override_verbose )
> +		if( !verbose )

Style: spaces between if and (, but not inside ( ).

> +			git_config_get_bool("commit.verbose", &verbose);

This is a strange way to write the "cli takes precedence over config".
The usual way is to read from least precedence to highest precedence,
i.e. git_config_get_bool before calling parse_option.

You dropped the "RFC" tag from the subject line, but your patch still
lacks a test. It cannot be called final without.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
