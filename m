From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: Add --recurse-submodules
Date: Tue, 11 Feb 2014 11:18:22 -0800
Message-ID: <xmqqtxc5pif5.fsf@gitster.dls.corp.google.com>
References: <1391956531-6039-1-git-send-email-ch3cooli@gmail.com>
	<874n466fyo.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sup Yut Sum <ch3cooli@gmail.com>
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 20:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDIqq-0003Zf-UU
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 20:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbaBKTSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 14:18:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbaBKTS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 14:18:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48384697CA;
	Tue, 11 Feb 2014 14:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iXhv2sP0uEsCwII5Hf10pLeCBvY=; b=ShIOdt
	5b3Io5rlaoo+Xp1y0Yv/C1GRi+sMFthJOzWA5SIun1UpLz5FRWCJdlrDUujA6cnm
	zM6rgdSiT4aMeurj25PjPHvqgO4lF/Au5nDLN9mLHha7pV+fEHFysuCayyGFeD8U
	lEDSSwzt7xkTNKGMbMqWutmKD6pP0ENrhBcwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O6UIHtZTukCQ61qI0LRFmiJAuoYPM4ln
	DxYRP4fJpfp2BAWiID19mHeZg8L/+DmG6napf/VXL3lLDogz4xFTeJlY8kLsHRYJ
	jkK8QttWUwsa8mimMAwhNTzQu+4LNm7aiFoLLlpMJtPTdoCRwfn26Klhy9k2Er4B
	nkmb+gOwNoM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B63697C8;
	Tue, 11 Feb 2014 14:18:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E6C1697C0;
	Tue, 11 Feb 2014 14:18:26 -0500 (EST)
In-Reply-To: <874n466fyo.fsf@gmail.com> (Keshav Kini's message of "Mon, 10 Feb
	2014 11:21:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 482F6D2E-9351-11E3-A7F2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241954>

Keshav Kini <keshav.kini@gmail.com> writes:

> Sup Yut Sum <ch3cooli@gmail.com> writes:
>
>> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> Aren't you missing a commit message?

The title itself is almost sufficient, I would think.  It may need
to mention that this is only for fetch, pull and push.  I'll
tentatively queue the following.

Stripping the leftmost constant string with ${var##constant} looks
somewhat strange (why wouldn't a single # work?), but that is not a
new problem this patch introduces, and can be cleaned up separately
if/when somebody wants to.

-- >8 --
From: Sup Yut Sum <ch3cooli@gmail.com>
Date: Sun, 9 Feb 2014 22:35:31 +0800
Subject: [PATCH] completion: teach --recurse-submodules to fetch, pull and push

Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8aaf214..c044a68 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1221,14 +1221,20 @@ _git_difftool ()
 	__git_complete_revlist_file
 }
 
+__git_fetch_recurse_submodules="yes on-demand no"
+
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
-	--tags --no-tags --all --prune --dry-run
+	--tags --no-tags --all --prune --dry-run --recurse-submodules=
 "
 
 _git_fetch ()
 {
 	case "$cur" in
+	--recurse-submodules=*)
+		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "$__git_fetch_options"
 		return
@@ -1577,6 +1583,10 @@ _git_pull ()
 	__git_complete_strategy && return
 
 	case "$cur" in
+	--recurse-submodules=*)
+		__gitcomp "$__git_fetch_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--rebase --no-rebase
@@ -1589,6 +1599,8 @@ _git_pull ()
 	__git_complete_remote_or_refspec
 }
 
+__git_push_recurse_submodules="check on-demand"
+
 _git_push ()
 {
 	case "$prev" in
@@ -1601,10 +1613,15 @@ _git_push ()
 		__gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
 		return
 		;;
+	--recurse-submodules=*)
+		__gitcomp "$__git_push_recurse_submodules" "" "${cur##--recurse-submodules=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			--all --mirror --tags --dry-run --force --verbose
 			--receive-pack= --repo= --set-upstream
+			--recurse-submodules=
 		"
 		return
 		;;
-- 
1.9.0-rc3-244-g3497008
