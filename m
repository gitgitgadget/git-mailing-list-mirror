From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: handle stray $dotest directory
Date: Fri, 14 Jun 2013 12:00:26 -0700
Message-ID: <7vbo78o6ut.fsf@alter.siamese.dyndns.org>
References: <1371196058-23948-1-git-send-email-artagnon@gmail.com>
	<1371196058-23948-2-git-send-email-artagnon@gmail.com>
	<7vli6crau5.fsf@alter.siamese.dyndns.org>
	<7v61xgraba.fsf@alter.siamese.dyndns.org>
	<CALkWK0m6iiDAmbxG9wrpgxJ3=nM816U7RM519Mu62qSgDwJbaQ@mail.gmail.com>
	<7vip1gpqjp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 21:00:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZEh-0007qw-5u
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab3FNTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 15:00:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406Ab3FNTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:00:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C9A727059;
	Fri, 14 Jun 2013 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zItGfQA3I6E+yf3YmsyL8FkU1c4=; b=nKnCDb
	fnTiMT+lhNN5Wnmv/LFMlKrRMla+UP/ImQ/wVogC6JRWX8cQf28chKHaOc5BkWBL
	QGow4UuCYWiVpOKqMHOVrng9/cz63jc8sYFTJxWqyg1g6i17dPJRAbkZJ3f6y+ZD
	DiKZVM77mCoLKJ3t5CzClPtTIcHMKuKVZv63k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jYJ4GWYGPXDASnzJ0baBSQ0cSCynVZM5
	WOovrDNNHT2cuEZ6GCC77aHzTFgmLSePPG/a0UnZXOCPBe6ftc5sxwKr23dT0ZCM
	cdbHoe1KoxihQTPpKrejjTa6BPVcOkKD5FWzmEg8DuMXJ8MgvWkQy13Lr/BaLum9
	6Zvuw0VMHCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2491027057;
	Fri, 14 Jun 2013 19:00:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A7E32704E;
	Fri, 14 Jun 2013 19:00:28 +0000 (UTC)
In-Reply-To: <7vip1gpqjp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Jun 2013 10:09:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADBF84D0-D524-11E2-A76C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227911>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> And then the message triggers at the second test in t3420 when
>>> applied on top of 587947750bd7 (rebase: implement --[no-]autostash
>>> and rebase.autostash, 2013-05-12) or 45acb7592825 (Merge branch
>>> 'rr/rebase-autostash', 2013-06-11).
>>
>> What was triggered?  (I didn't understand what you said)
>
> The patch applied on top of either of these commits will *BREAK* the
> second test in t3420.

Here is how "sh -x t3420-*.sh -i" ends:

    ...
    ++ git rebase unrelated-onto-branch
    Created autostash: cdca6ca
    HEAD is now at 0c4d2f1 third commit
    First, rewinding head to replay your work on top of it...
    Stray /srv/project/git/git.git/t/trash
    directory.t3420-rebase-autostash/.git/rebase-apply directory found.
    Use "git am --abort" to remove it.
    + eval_ret=1
    + test -z t
    + test 1 = 0
    + test -n ''
    + test t = t
    + test -n ''
    + return 1
    + test_failure_ 'rebase: dirty worktree, non-conflicting rebase' '
    ...

I _think_ the new check you added may be too loose.

A fix-up may look like this.


 git-am.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 37edfae..3f89cf6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -505,9 +505,9 @@ then
 		exit ;;
 	esac
 	rm -f "$dotest/dirtyindex"
-else
-	# Possible stray $dotest directory
-	if test -d "$dotest"; then
+elif test -d "$dotest" && ! test -f "$dotest/autostash"
+then
+	# stray $dotest directory
 	case "$skip,$resolved,$abort" in
 	,,t)
 		rm -fr "$dotest"
@@ -518,8 +518,7 @@ else
 Use \"git am --abort\" to remove it.")"
 		;;
 	esac
-	fi
-
+else
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" = "" ||
 		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
