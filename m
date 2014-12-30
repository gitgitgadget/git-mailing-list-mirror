From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase documentation: explain the exit code of custom commands
Date: Tue, 30 Dec 2014 09:33:16 -0800
Message-ID: <xmqqr3vhrqjn.fsf@gitster.dls.corp.google.com>
References: <1419892207-26687-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 18:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y60ff-0007eM-1x
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 18:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbaL3RdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 12:33:22 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751459AbaL3RdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 12:33:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE89029BD4;
	Tue, 30 Dec 2014 12:33:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=liWeh+JP4sjUOS2j/uvWQBpMQy0=; b=GeqV/b
	bo4qbTKVgGqGT58G8IoPXF5+QEWqoymkLrp0aaLzEQ4x+edD+PF5vASUyHj5mp+K
	dZ3Qvg9lYg3zVnsgNZ9bRifDwJBduXCtqA/LbMQDfTbYHzEDwt1WBSSpN+65zrLD
	4g/mFlGmMt8X0E9thGt5GBcZ2JdUk+VbCWkYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PbC4WVvMAQlh7tmuAokfUs8X8MU/djSB
	fXDUhqaMwpatkr4JV+x4uYmQx1CuNxuBYzB+bCeq2KwIyzoAgX3Umnw3BOgGWmc4
	pNPbnlPIWSg6+nqKfU6Mm2kYYZ7TQGWDObMs4saLEr4TMfzgjWDJ9zsKoY+4lH4j
	qfpjgUbzj2s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E553A29BD3;
	Tue, 30 Dec 2014 12:33:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2A8129BC8;
	Tue, 30 Dec 2014 12:33:17 -0500 (EST)
In-Reply-To: <1419892207-26687-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 29 Dec 2014 14:30:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0FCEF80-9049-11E4-8AD5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261927>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-rebase.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 924827d..ffadb0b 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -372,7 +372,8 @@ idea unless you know what you are doing (see BUGS below).
>  --exec <cmd>::
>  	Append "exec <cmd>" after each line creating a commit in the
>  	final history. <cmd> will be interpreted as one or more shell
> -	commands.
> +	commands. Rebasing will stop for manual inspection if the command
> +	returns a non zero exit code.
>  +
>  This option can only be used with the `--interactive` option
>  (see INTERACTIVE MODE below).

This is not wrong per-se, but I wonder if it belongs here, or
"INTERACTIVE MODE below" may be a better place for it.

In fact, I notice that "INTERACTIVE MODE below" already touches it,
like this:

    Reordering and editing commits usually creates untested intermediate
    steps.  You may want to check that your history editing did not break
    anything by running a test, or at least recompiling at intermediate
    points in history by using the "exec" command (shortcut "x").  You may
    do so by creating a todo list like this one:

    -------------------------------------------
    pick deadbee Implement feature XXX
    fixup f1a5c00 Fix to feature XXX
    exec make
    pick c0ffeee The oneline of the next commit
    edit deadbab The oneline of the commit after
    exec cd subdir; make test
    ...
    -------------------------------------------

    The interactive rebase will stop when a command fails (i.e. exits with
    non-0 status) to give you an opportunity to fix the problem. You can
    continue with `git rebase --continue`.

I further notice that this section mentions various insns you can
use in prose, but does not have a list of vocabulary.  A new user,
when using "rebase -i" for the first time, will only see a series of
"pick"s; there needs to be a short list of the available insns and
what each of them do somewhere in the documentation, organized in a
way similar to how command line options are listed and explained.

As a starting point, here is what I came up with.  I am not
committing this to anywhere in my tree yet---this is primarily for
discussion.

One thing that I find a bit troublesome is that we overuse the word
"command" to mean three different things.  In general, when we say
"The command does X" in a documentation for individual subcommand,
we mean that subcommand (i.e. "git rebase" in this case).  "Replace
the command 'pick' with Y" here however refers to an instruction
taken from the vocabulary the new list presents here with the word.
And "exec stops when the command fails" refers to whatever shell
scriptlet you give 'exec' insn with the same word.  This (not just
the new text I am introducing, which follows the usage of the words
in the existing text, but the way we refer to "command" and mean
three different things in the entire text) needs to be cleaned up.



 Documentation/git-rebase.txt | 56 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 924827d..718300c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -509,20 +509,52 @@ By replacing the command "pick" with the command "edit", you can tell
 the files and/or the commit message, amend the commit, and continue
 rebasing.
 
-If you just want to edit the commit message for a commit, replace the
-command "pick" with the command "reword".
-
+Here are the commands that can appear in the instruction sheet and
+their explanations.
+
+pick <commit> <subject>::
+	Replay the named commit on top of the current state.
+
+edit <commit> <subject>::
+	Replay the named commit and then stop, so that the user can
+	edit the working tree files and "git rebase --continue" to
+	record the modified changes made to the working tree files
+	while tweaking the log message.
+
+reword <commit> <subject>::
+	Replay the named commit and then open the editor to tweak
+	the log message (i.e. without modifying the changes made to
+	the working tree contents).
+
+squash <commit> <subject>::
+	Modify the current commit by squashing the change made by
+	the named commit, and then open the editor to modify the log
+	message using existing messages from the current commit and
+	the named commit.  The authorship of the resulting commit is
+	taken from the current commit.
+	See `--autosquash`.
+
+fixup <commit> <subject>::
+	Modify the current commit by squashing the change made by
+	the named commit, without updating the log message.  The
+	authorship of the resulting commit is taken from the
+	current commit.
+	See `--autosquash`.
+
+exec <command>::
+	Run named command under a shell and stop if it exited with a
+	non-zero status.
+	See `--exec`.
+
+For example, if you just want to edit the commit message for a
+commit, replace the command "pick" with the command "reword".
 If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
-If the commits had different authors, the folded commit will be
-attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
-
-'git rebase' will stop when "pick" has been replaced with "edit" or
-when a command fails due to merge errors. When you are done editing
-and/or resolving conflicts you can continue with `git rebase --continue`.
+
+In addition to the cases where the list above says the command will
+stop, it will stop when a merge conflict needs to be resolved
+manually.  When you are done editing and/or resolving conflicts,
+continue with `git rebase --continue`.
 
 For example, if you want to reorder the last 5 commits, such that what
 was HEAD~4 becomes the new HEAD. To achieve that, you would call
