From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 14:16:39 -0700
Message-ID: <7v7hw2pmtk.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:16:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwRM-0006af-6s
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbZIMVQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbZIMVQq
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:16:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbZIMVQp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:16:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 970414F950;
	Sun, 13 Sep 2009 17:16:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GdHEFoDK/LobRPQGTqcnCZdbMiY=; b=Sgdd0N
	+KWOUt9ACRUG0pLJb7fwfXtekAelrP0uVznuTweXcEdMrCbMF9GFQZERaRuL5rUS
	U3BGIPt3rQuoWvaqkY5DQNOLoTAIuqkevfHcouO10nudEnpxFH84k9+0JzxxhUMD
	t8Rqxyn/EJckjyoFYH8/i7RqYM2Xtjngt/olA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mV3CGQd4vrSSLiR7iYaySujVHRmwYI8f
	A3r7C7vjBJwpv/RXcPKi2GwW85neuUAbL09Jqyu80NyV2iwAEpjiF6nTiOqfmkCZ
	Y0mPwGjRnga50Po0O61rMAhAdBzdbYdYfdshE6twg4txjvsrMto1oIkPq0xcz45u
	ISG8BXZ5fkI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69F014F94D;
	Sun, 13 Sep 2009 17:16:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B54304F94A; Sun, 13 Sep 2009
 17:16:40 -0400 (EDT)
In-Reply-To: <20090913204231.GA8654@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 13 Sep 2009 16\:42\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD9E8ACA-A0AA-11DE-A1BF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128415>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 13, 2009 at 01:38:48PM -0700, Junio C Hamano wrote:
>
>> I saw some discussion on improving the wording.  Here is what I plan to
>> commit.
>
> Thanks for picking this up, I meant to re-post with improvements.

I am _not_ going to commit the following patch, because it will interfere
with this clarification effort, but I think we want to do something along
this line after the "clarification" settles.

An observation I'd like to make is that this is way too ugly:

	[advice]
        	pullNoMergeFound = false
                pushNonFastForward = false
                statusHints = false

than

	[IKnowWhatIAmDoingThankYouVeryMuch]
        	pullNoMergeFound
                pushNonFastForward
                statusHints

but this feature is for people who know what they are doing, so I guess
the current set-up would be fine.

 git-pull.sh |   78 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0bbd5bf..101545e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -76,14 +76,64 @@ do
 	shift
 done
 
+advice_tags_only () {
+	if test -z "$1"
+	then
+		echo "Fetching tags only."
+		return
+	fi
+	echo "Fetching tags only, you probably meant:"
+	echo "  git fetch --tags"
+}
+
+advice_detached_head () {
+	if test -z "$1"
+	then
+		echo "No default merge candidate on a detached HEAD."
+		return
+	fi
+	echo "You are not currently on a branch, so I cannot use any"
+	echo "'branch.<branchname>.merge' in your configuration file."
+	echo "Please specify which branch you want to merge on the command"
+	echo "line and try again (e.g. 'git pull <repository> <refspec>')."
+	echo "See git-pull(1) for details."
+}
+
+advice_no_merge_candidates () {
+	if test -z "$1"
+	then
+		echo "No merge candidate for the current branch fetched."
+		return
+	fi
+	cat <<EOF
+You asked me to pull without telling me which branch you
+want to merge with, and 'branch.$2.merge' in
+your configuration file does not tell me either.  Please
+specify which branch you want to merge on the command line and
+try again (e.g. 'git pull <repository> <refspec>').
+See git-pull(1) for details.
+
+If you often merge with the same branch, you may want to
+configure the following variables in your configuration
+file:
+
+    branch.$2.remote = <nickname>
+    branch.$2.merge = <remote-ref>
+    remote.<nickname>.url = <url>"
+    remote.<nickname>.fetch = <refspec>
+
+See git-config(1) for details.
+EOF
+}
+
 error_on_no_merge_candidates () {
 	exec >&2
+	advice=$(git config --bool advice.pullNoMergeFound)
 	for opt
 	do
 		case "$opt" in
 		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
-			echo "  git fetch --tags"
+			advice_tags_only "$advice"
 			exit 1
 		esac
 	done
@@ -91,29 +141,9 @@ error_on_no_merge_candidates () {
 	curr_branch=${curr_branch#refs/heads/}
 
 	if [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which branch you want to merge on the command"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
+		advice_detached_head "$advice"
 	else
-		echo "You asked me to pull without telling me which branch you"
-		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me either.	Please"
-		echo "specify which branch you want to merge on the command line and"
-		echo "try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-		echo
-		echo "If you often merge with the same branch, you may want to"
-		echo "configure the following variables in your configuration"
-		echo "file:"
-		echo
-		echo "    branch.${curr_branch}.remote = <nickname>"
-		echo "    branch.${curr_branch}.merge = <remote-ref>"
-		echo "    remote.<nickname>.url = <url>"
-		echo "    remote.<nickname>.fetch = <refspec>"
-		echo
-		echo "See git-config(1) for details."
+		advice_no_merge_candidate "$advice" "$curr_branch"
 	fi
 	exit 1
 }
