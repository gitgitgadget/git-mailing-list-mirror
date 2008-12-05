From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-am: propagate -C<n>, -p<n> options as well
Date: Fri, 05 Dec 2008 11:18:43 -0800
Message-ID: <7v7i6e1ld8.fsf@gitster.siamese.dyndns.org>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com>
 <1228443780-3386-2-git-send-email-gitster@pobox.com>
 <1228443780-3386-3-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0812051320170.7062@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8gDm-0003DO-2N
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 20:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYLETSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 14:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYLETSv
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 14:18:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbYLETSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 14:18:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A97E1825F;
	Fri,  5 Dec 2008 14:18:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1D39818279; Fri, 
 5 Dec 2008 14:18:45 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812051320170.7062@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri, 5 Dec 2008 13:21:43 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B90D88A-C301-11DD-982A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102407>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 4 Dec 2008, Junio C Hamano wrote:
>
>> -	echo " $ws" >"$dotest/whitespace"
>> +	echo " $git_apply_opt" >"$dotest/apply_opt_extra"
>
>>From the other scripts, it appears we have sort of a convention to use 
> dashes instead of underscores for file names (see e.g. 
> $dotest/patch-merge-tmp-dir).

You are right.  And there is no reason to call it "extra" either.


 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/git-am.sh w/git-am.sh
index 13c02d6..4b157fe 100755
--- c/git-am.sh
+++ w/git-am.sh
@@ -250,7 +250,7 @@ else
 	# -s, -u, -k, --whitespace, -3, -C and -p flags are kept
 	# for the resuming session after a patch failure.
 	# -i can and must be given when resuming.
-	echo " $git_apply_opt" >"$dotest/apply_opt_extra"
+	echo " $git_apply_opt" >"$dotest/apply-opt"
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
@@ -288,7 +288,7 @@ if test "$(cat "$dotest/threeway")" = t
 then
 	threeway=t
 fi
-git_apply_opt=$(cat "$dotest/apply_opt_extra")
+git_apply_opt=$(cat "$dotest/apply-opt")
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
