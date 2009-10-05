From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing git pull error message
Date: Mon, 05 Oct 2009 12:36:05 -0700
Message-ID: <7vd451ab16.fsf@alter.siamese.dyndns.org>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org> <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
 <20091005191257.GA24305@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MutND-0003iR-0R
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZJEThB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbZJEThB
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:37:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbZJEThA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:37:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 250314DC60;
	Mon,  5 Oct 2009 15:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XLVSYGw1HABLDc9xT3iOZY41/gM=; b=g6fPiR
	IoZWsE0ZfR5aY/5UYhbYx54e0RvilijpfoIHM+ubYUayTDsSrb/nLbofTk8fm7ao
	/wBJOHRDkJLd6JlcDqt6uh7cjOojqQ6Wd5bUamRjSloP7wUu9OYFtbahDj/uNpTv
	WKfVNOP5BzzyfvdGpPOtKNQTmBOla+je8WJ6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbcL6CRhevNXfyY8NQ72Om7aV2llRJKc
	NcaFu1qGO4odUANd3d4/MhfFr+HW5xC9D4UcCIVbJ8vmKc6edyL+43Elwhlbp2eg
	vGkliJVJbeHgh12jkQ0WT2727OqDoukwzgabVS+2oaHyQITDpqzNg75J4i4F9Gf1
	hBOA3Oms4fE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD35E4DC5D;
	Mon,  5 Oct 2009 15:36:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1A134DC55; Mon,  5 Oct
 2009 15:36:07 -0400 (EDT)
In-Reply-To: <20091005191257.GA24305@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 5 Oct 2009 15\:12\:57 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57A2A858-B1E6-11DE-AB8F-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129581>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 05, 2009 at 12:08:38PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So I think we need something like this. I wasn't able to figure out a
>> > test case to trigger the first code path below, though. It may not be
>> > possible; if we give a refspec on the command line, either it will be a
>> > candidate for merging or, if it does not exist, fetch will barf. So it
>> > may be that we can just collapse it down to a single case.
>> 
>> I think you are right.
>
> Nope, I'm not. I figured out one more case that it needs to handle.
> Revised patch coming up in a few minutes.
>
>> By the way, I think the other case arms in the case statement that has the
>> sole caller of this function are never reached, no?
>> 
>> Back when you added the check in a74b170 (git-pull: disallow implicit
>> merging to detached HEAD, 2007-01-15), $? referred to the error status of
>> reading HEAD as a symbolic-ref so the check did make sense, but cd67e4d
>> (Teach 'git pull' about --rebase, 2007-11-28) made a stupid mistake that
>> nobody noticed.
>
> Hmm. I'm not sure. I don't see how $? could not be zero, though, because
> the last thing we run is a subshell with sed and tr. But beyond that, we
> actually handle the detached case in error_on_no_merge_candidates
> already. So I think that case statement can simply be collapsed to the
> first case.
>
> -Peff

-- >8 --
Subject: [PATCH] git-pull: dead code removal

Back when a74b170 (git-pull: disallow implicit merging to detached HEAD,
2007-01-15) added this check, $? referred to the error status of reading
HEAD as a symbolic-ref; but cd67e4d (Teach 'git pull' about --rebase,
2007-11-28) moved the command away from where the check is, and nobody
noticed the breakage.  Ever since, $? has always been 0 (tr at the end of
the pipe to find merge_head never fails) and other case arms were never
reached.

These days, error_on_no_merge_candidates function is prepared to handle a
detached HEAD case, which was what the code this patch removes used to
handle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-pull.sh |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index edf3ce3..66d73eb 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -182,14 +182,7 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	case $? in
-	0) error_on_no_merge_candidates "$@";;
-	1) echo >&2 "You are not currently on a branch; you must explicitly"
-	   echo >&2 "specify which branch you wish to merge:"
-	   echo >&2 "  git pull <remote> <branch>"
-	   exit 1;;
-	*) exit $?;;
-	esac
+	error_on_no_merge_candidates "$@"
 	;;
 ?*' '?*)
 	if test -z "$orig_head"
-- 
1.6.5.rc2.77.g2ea4a
