From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Fri, 07 Aug 2009 11:15:42 -0700
Message-ID: <7v4osj1odt.fsf@alter.siamese.dyndns.org>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Fri Aug 07 20:16:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZTz3-0007yz-Pv
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 20:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbZHGSPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbZHGSPt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 14:15:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbZHGSPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 14:15:49 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C64C156A;
	Fri,  7 Aug 2009 14:15:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A82C1567; Fri,  7 Aug
 2009 14:15:44 -0400 (EDT)
In-Reply-To: <4a7c3971.170d660a.3caa.20b3@mx.google.com> (Ori Avtalion's
 message of "Fri\, 7 Aug 2009 17\:24\:21 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 557C5524-837E-11DE-9F88-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125208>

Ori Avtalion <ori@avtalion.name> writes:

> Most of the docs and printouts refer to "commands".
> This patch changes the other terminology to be consistent.

Thanks, but not really.

> @@ -605,7 +605,7 @@ color.interactive.<slot>::
>  	Use customized color for 'git-add --interactive'
>  	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
>  	four distinct types of normal output from interactive
> -	programs.  The values of these variables may be specified as
> +	commands.  The values of these variables may be specified as

This is good.

>  color.pager::
> @@ -1113,7 +1113,7 @@ instaweb.port::
>  	linkgit:git-instaweb[1].
>  
>  interactive.singlekey::
> -	In interactive programs, allow the user to provide one-letter
> +	In interactive commands, allow the user to provide one-letter

This is good.

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index d313795..20bf512 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -1,7 +1,7 @@
>  -q::
>  --quiet::
>  	Pass --quiet to git-fetch-pack and silence any other internally
> -	used programs.
> +	used utilities.

This does not have much to do with what you claim to have done in the
commit log message nor the title.  Probably "utilities" is a slightly
better word than "programs" in this context but not by a wide margin.

> -'git-rev-list' is a very essential git program, since it
> +'git-rev-list' is a very essential git command, since it
>  provides the ability to build and traverse commit ancestry graphs. For
>  this reason, it has a lot of different options that enables it to be
>  used by commands as different as 'git-bisect' and

Ok, but probably we would want to say "git rev-list" here.

>  --exec-path::
> -	Path to wherever your core git programs are installed.
> +	Path to wherever your core git commands are installed.

I do not think this is a good change.

When you talk about git "command", e.g. "'git rev-list' is an essential
command", you are talking about an abstract concept.  In the reader's
world view, there is one single toplevel program called "git" and it has
various commands, one of which is 'rev-list'.  But this description is not
about an abstract concept of command, but is about a particular
implementation detail.  For every git command, there is a corresponding
git _program_ that implements that command, and --exec-path tells you (or
you use --exec-path to tell the git toplevel program) where they are.

You kept this intact in gitcore-tutorial:

    ... Also
    you need to make sure that you have the 'git-receive-pack'
    program on the `$PATH`.

and I think you did the right thing.  This is about a concrete instance of
a program.  If you really really want to say _command_, you would probably
want to do something like this instead:

 --exec-path::
-	Path to wherever your core git programs are installed.
+	Path to the directory that holds programs that implements git commands.

> @@ -327,7 +327,7 @@ Synching repositories
>  
>  include::cmds-synchingrepositories.txt[]
>  
> -The following are helper programs used by the above; end users
> +The following are helper commands used by the above; end users
>  typically do not use them directly.

Ok.

>  The attribute `merge` affects how three versions of a file is
>  merged when a file-level merge is necessary during `git merge`,
> -and other programs such as `git revert` and `git cherry-pick`.
> +and other commands such as `git revert` and `git cherry-pick`.

Ok.

> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index 7ba5e58..b3640c4 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -12,7 +12,7 @@ git *
>  DESCRIPTION
>  -----------
>  
> -This tutorial explains how to use the "core" git programs to set up and
> +This tutorial explains how to use the "core" git commands to set up and
>  work with a git repository.
>  
>  If you just need to use git as a revision control system you may prefer

Ok.

> @@ -1328,7 +1328,7 @@ into it later. Obviously, this repository creation needs to be
>  done only once.
>  
>  [NOTE]
> -'git-push' uses a pair of programs,
> +'git-push' uses a pair of commands,
>  'git-send-pack' on your local machine, and 'git-receive-pack'
>  on the remote machine. The communication between the two over
>  the network internally uses an SSH connection.

Ok.

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 0b88a51..67ebffa 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -4131,7 +4131,7 @@ What does this mean?
>  
>  `git rev-list` is the original version of the revision walker, which
>  _always_ printed a list of revisions to stdout.  It is still functional,
> -and needs to, since most new Git programs start out as scripts using
> +and needs to, since most new Git commands start out as scripts using
>  `git rev-list`.

Ok.

>  `git rev-parse` is not as important any more; it was only used to filter out
> diff --git a/help.c b/help.c
> index 6c46d8b..57a0e0e 100644
> --- a/help.c
> +++ b/help.c
> @@ -334,7 +334,7 @@ const char *help_unknown_cmd(const char *cmd)
>  		const char *assumed = main_cmds.names[0]->name;
>  		main_cmds.names[0] = NULL;
>  		clean_cmdnames(&main_cmds);
> -		fprintf(stderr, "WARNING: You called a Git program named '%s', "
> +		fprintf(stderr, "WARNING: You called a Git command named '%s', "
>  			"which does not exist.\n"
>  			"Continuing under the assumption that you meant '%s'\n",
>  			cmd, assumed);

Ok.
