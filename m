From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] contrib: add 'git difftool' for launching common merge tools
Date: Sun, 18 Jan 2009 20:25:23 +0100
Message-ID: <200901182025.24045.markus.heidelberg@web.de>
References: <1232092802-30838-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:31:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdMS-0006sc-1S
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZART3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZART3o
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:29:44 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:59393 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbZART3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:29:43 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 016DAF6B5326;
	Sun, 18 Jan 2009 20:29:42 +0100 (CET)
Received: from [89.59.120.98] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LOdG7-0003bd-00; Sun, 18 Jan 2009 20:24:35 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1232092802-30838-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106267>

David Aguilar, 16.01.2009:

> diff --git a/contrib/difftool/git-difftool b/contrib/difftool/git-difftool
> new file mode 100755
> index 0000000..1fc087c
> --- /dev/null
> +++ b/contrib/difftool/git-difftool
> @@ -0,0 +1,74 @@
> +#!/usr/bin/env perl
> +# Copyright (c) 2009 David Aguilar
> +#
> +# This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
> +# git-difftool-helper script.  This script exports
> +# GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
> +# GIT_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.

GIT_DIFFTOOL_NO_PROMPT

> +sub usage
> +{
> +	print << 'USAGE';
> +

Why the leading empty line?

> +usage: git difftool [--no-prompt] [--tool=tool] ["git diff" options]

--tool=<tool>

Swap the order of --no-prompt and --tool for consistency with
git-difftool.txt and git-mergetool.

> diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
> new file mode 100755
> index 0000000..0b266e3
> --- /dev/null
> +++ b/contrib/difftool/git-difftool-helper

> +	meld|vimdiff)
> +		"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		;;
> +
> +	gvimdiff)
> +		"$merge_tool_path" -f "$LOCAL" "$REMOTE"
> +		;;

Maybe use '-c "wincmd l"' for Vim as in my patch for git-mergetool to
automatically place the cursor in the editable file? Useful for editing,
if git-difftool is used to diff a file from the working tree.

See http://thread.gmane.org/gmane.comp.version-control.git/106109

> diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
> new file mode 100644
> index 0000000..3940c70
> --- /dev/null
> +++ b/contrib/difftool/git-difftool.txt

You have deleted all the '-' chars from git-command, but when using it as the
name I think it's the preferred method, only when used as command then without
slash.

> +DESCRIPTION
> +-----------
> +'git difftool' is a git command that allows you to compare and edit files

If for example 'git difftool' is used as the name of the tool and not
the command, I think the dash should be kept.

> +between revisions using common merge tools.  At its most basic level,
> +'git difftool' does what 'git mergetool' does but its use is for non-merge

Keep the dash.

> +situations such as when preparing commits or comparing changes against
> +the index.
> +
> +'git difftool' is a frontend to 'git diff' and accepts the same

Keep the dash.

> +arguments and options.
> +
> +See linkgit:git-diff[7] for the full list of supported options.

[1]

> +
> +OPTIONS
> +-------
> +-t <tool>::
> +--tool=<tool>::
> +	Use the merge resolution program specified by <tool>.
> +	Valid merge tools are:
> +	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
> ++
> +If a merge resolution program is not specified, 'git difftool'

Keep the dash.

> +situations such as when preparing commits or comparing changes against
> +will use the configuration variable `merge.tool`.  If the
> +configuration variable `merge.tool` is not set, 'git difftool'

Keep the dash.

> +situations such as when preparing commits or comparing changes against
> +will pick a suitable default.
> ++
> +You can explicitly provide a full path to the tool by setting the
> +configuration variable `mergetool.<tool>.path`. For example, you
> +can configure the absolute path to kdiff3 by setting
> +`mergetool.kdiff3.path`. Otherwise, 'git difftool' assumes the

Keep the dash.

> +situations such as when preparing commits or comparing changes against
> +tool is available in PATH.
> ++
> +Instead of running one of the known merge tool programs,
> +'git difftool' can be customized to run an alternative program

Keep the dash.

> +situations such as when preparing commits or comparing changes against
> +by specifying the command line to invoke in a configuration
> +variable `mergetool.<tool>.cmd`.
> ++
> +When 'git difftool' is invoked with this tool (either through the

Keep the dash.

> +--no-prompt::
> +	Do not prompt before launching a merge tool.

the diff tool

> +SEE ALSO
> +--------
> +linkgit:git-diff[7]::

[1]

> +	 Show changes between commits, commit and working tree, etc
> +
> +linkgit:git-mergetool[1]::
> +	Run merge conflict resolution tools to resolve merge conflicts
> +
> +linkgit:git-config[7]::

[1]


Works fine for me, thanks.

Markus
