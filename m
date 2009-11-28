From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] Mention of 1.7.0 transition plans in Release Notes to 1.6.6
Date: Sat, 28 Nov 2009 14:46:24 -0800
Message-ID: <7vfx7yfetb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 23:46:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEW41-0003fp-FR
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 23:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZK1Wq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 17:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbZK1Wq1
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 17:46:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZK1Wq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 17:46:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72EF983C28;
	Sat, 28 Nov 2009 17:46:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=1gKU
	Au27u5MCgw0KqpuwHafUKgg=; b=mScH0vv5sqq/9vaXFFre9J5sN4D+bHqpDQtQ
	72bLwM6S7RpPopB5BYrfDCIvKx5qeVBoS00YNvVOrJi6sLqNCpuF6c0ZYL5yOxGV
	xt7d+gkvopltJkAbcMmGn/If/9B6IaK/buXxPBO7prCc5Er2DZWSeqjlgq895hyI
	gKjKOxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=woD
	R70Q3Lc7zqqfZ/VHX55Q3q2WfOinHaMUHLMZSfpQuLXkqSaeN68D+2A6nCwvZoRy
	4juz+WhW4Dm3FRdcVgRlusn292073OTt34WvzQTDhhjBMg+8UbfyigJID5rshzED
	8pr/17RHJzQLS0Hf809+Ea6jlSfQeDshnAaH3Kzo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6183F83C27;
	Sat, 28 Nov 2009 17:46:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D77C83C25; Sat, 28 Nov
 2009 17:46:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEB6DC02-DC6F-11DE-BF3D-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133981>

I am attaching the first part of the current draft release notes to
request help from the developer community, so that we can avoid a fiasco
like we had at 1.6.0 when we switched from "git-foo" to "git foo".

The 1.6.0 change was widely advertised but the way it was introduced
allowed users to _ignore_ the issue until the last minute, and as the
consequence of having ignoring the issue, they were _forced_ to scramble
and adjust once their system administrator decided to install the new
version.

I think contributors who pushed for the updated safety valve for "git
push" did a lot better, learning from the bitter 1.6.0 experience, to
prevent users from ignoring the issue and instead prepare them for smooth
transition.  I wanted to make sure all the users who read Release Notes to
the upcoming release but otherwise do not follow this list regularly will
not be surprised when 1.7.0 happens, and I feel the text needs polishing
for that purpose.  We might want to deliver the announcement to a wider
audience than usual as well, and volunteers to help doing so are very
welcomed.

Two things and a half to note:

 - I do not think we have such an anti-procrastination measure for
   send-email's --[no-]chain-reply-to change.  We might want to have one
   before 1.6.6 ships; namely, if the code decided to use chain-reply-to
   behaviour by default because there was no sendemail.chainreplyto (or
   sendemail.$identity.chainreplyto) configured, nor --no-chain-reply-to
   or --chain-reply-to given from the command line, we issue a big fat
   warning just like we warn against unconfigured push.denyCurrentBranch
   when allowing pushing to a checked-out branch without being told.

 - I do not think of a sane way to cover "diff -b/-w" changes, as this is
   a "bugfix --- but there may be some scripts that have been relying on
   the bug", and a configuration option that retains the buggy behaviour
   does not make much sense.  But I may be mistaken and somebody can come
   up with an easy patch to allow both behaviour, in which case we should
   add similar anti-procrastination measure to this change.

 - Recent proposal to add "grep.fulltree" configuration variable may fall
   into the same category as sendemail.chainreplyto, as it is not about
   "buggy behaviour" nor "risky default that can easily hurt users" but is
   more about "there are two competing and equally sane defaults and it is
   purely an issue of user preference".  So if we were to decide flip the
   default in a far future, we may add such anti-procrastination measure
   there as well (but not before we decide we will flip it someday).

   This last item is obviously outside the scope of 1.7.0, though.

----------------------------------------------------------------

Git v1.6.6 Release Notes
========================

Notes on behaviour change
-------------------------

 * In this release, "git fsck" defaults to "git fsck --full" and
   checks packfiles, and because of this it will take much longer to
   complete than before.  If you prefer a quicker check only on loose
   objects (the old default), you can say "git fsck --no-full".  This
   has been supported by 1.5.4 and newer versions of git, so it is
   safe to write it in your script even if you use slightly older git
   on some of your machines.

Preparing yourselves for compatibility issues in 1.7.0
------------------------------------------------------

In git 1.7.0, which is planned to be the release after 1.6.6, there will
be a handful of behaviour changes that will break backward compatibility.

These changes were discussed long time ago and existing behaviours have
been identified as more problematic to the userbase than keeping them for
the sake of backward compatibility.

When necessary, transition strategy for existing users has been designed
not to force them running around setting configuration variables and
updating their scripts in order to keep the traditional behaviour on the
day their sysadmin decides to install the new version of git.  When we
switched from "git-foo" to "git foo" in 1.6.0, even though the change had
been advertised and the transition guide had been provided for a very long
time, the users procrastinated during the entire transtion period, and
ended up panicking on the day their sysadmins updated their git.

For changes decided to be in 1.7.0, we have been much louder to strongly
discourage such procrastination.  If you have been using recent versions
of git, you would have already seen warnings issued when you exercised
features whose behaviour will change, with the instruction on how to keep
the existing behaviour if you choose to.  You hopefully should be well
prepared already.

Of course, we have also given "this and that will change in 1.7.0; prepare
yourselves" warnings in the release notes and announcement messages.
Let's see how well users will fare this time.

 * "git push" into a branch that is currently checked out (i.e. pointed by
   HEAD in a repository that is not bare) will be refused by default.

   Similarly, "git push $there :$killed" to delete the branch $killed
   in a remote repository $there, when $killed branch is the current
   branch pointed at by its HEAD, will be refused by default.

   Setting the configuration variables receive.denyCurrentBranch and
   receive.denyDeleteCurrent to 'ignore' in the receiving repository
   can be used to override these safety features.  Versions of git
   since 1.6.2 have issued a loud warning when you tried to do them
   without setting the configuration, so repositories of people who
   still need to be able to perform such a push should already been
   future proofed.

   Please refer to:

   http://git.or.cz/gitwiki/GitFaq#non-bare
   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

   for more details on the reason why this change is needed and the
   transition process that already took place so far.

 * "git send-email" will not make deep threads by default when sending a
   patch series with more than two messages.  All messages will be sent as
   a reply to the first message, i.e. cover letter.  It has been possible
   to configure send-email to do this by setting sendemail.chainreplyto
   configuration variable to false.  The only thing the new release will
   do is to change the default when you haven't configured that variable.

 * "git status" will not be "git commit --dry-run".  This change does not
   affect you if you run the command without pathspec.

   Nobody sane found the current behaviour of "git status Makefile" useful
   nor meaningful, and it confused users.  "git commit --dry-run" has been
   provided as a way to get the current behaviour of this command since
   1.6.5.

 * "git diff" traditionally treated various "ignore whitespace" options
   only as a way to filter the patch output.  "git diff --exit-code -b"
   exited with non-zero status even if all changes were about changing the
   ammount of whitespace and nothing else.  and "git diff -b" showed the
   "diff --git" header line for such a change without patch text.

   In 1.7.0, the "ignore whitespaces" will affect the semantics of the
   diff operation itself.  A change that does not affect anything but
   whitespaces will be reported with zero exit status when run with
   --exit-code, and there will not be "diff --git" header for such a
   change.
