From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: escape '~' in git revert
Date: Thu, 02 Dec 2010 11:23:50 -0800
Message-ID: <7vipzcq8qh.fsf@alter.siamese.dyndns.org>
References: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
 <20101202175013.GF3962@burratino> <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
 <20101202183257.GH3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Rabot <sylvain.rabot@f-secure.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POElG-0002df-E4
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186Ab0LBTYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:24:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LBTYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:24:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 752412A0E;
	Thu,  2 Dec 2010 14:24:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8nKXECP/pXcnpggz/oL24pkixK0=; b=Gkh/JA
	fWlpwF3pDKdlK6hrzPEYEYyhei2XyMSx9OHDTpEtDDfe8+hgK8+zWpX7gSQ1O8mJ
	QVAiLcUTpo7t6jCrcrKffqladUCxVg4oXJal8GTFFJa1YmE70RDMlwXYGkQHZe30
	eV5GXTUNGzqhzgWbGpDVTBJ25/vljO4JZRTaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mjrko0oDMf0Ln4cIO4ygN7W/J0FWPkqL
	/iGSY8m2mqhNo3onzJhUarDZa0N9toeXhqJBYJwEusXifqKqh5bl2leBmQaqD8OS
	qIgGEh4lPVjTBUI8tyH8hiGZRD584qdnOtf7EpeIK5+2uGfwaMFmVVifZVyV+5eq
	xiXhls/ayps=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 340952A0A;
	Thu,  2 Dec 2010 14:24:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0BDF2A08; Thu,  2 Dec 2010
 14:24:12 -0500 (EST)
In-Reply-To: <20101202183257.GH3962@burratino> (Jonathan Nieder's message of
 "Thu\, 2 Dec 2010 12\:32\:57 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C130EEAA-FE49-11DF-AFD6-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162738>

Jonathan Nieder <jrnieder@gmail.com> writes:

> FWIW I suspect those are both "literal" environments, thus governed
> by the rule described in v1.6.0-rc0~152 (git-format-patch(1): fix
> stray \ in output, 2008-07-02).
>
> Based on "git grep -e '~[^~].*~' -- Documentation/", I think you found
> them all, unless there are some examples span multiple lines.

Thanks.  I'll queue this on 'maint' then.

-- >8 --
Subject: [PATCH] Documentation: Fix mark-up of lines with more than one tilde

The manual pages of cherry-pick and revert had examples with two revisions
on the same line in the examples section, that looked like this:

    git cherry-pick master~4 master~2::

Unfortunately, this is taken as a mark-up to make the part between two
tildes, "4 master", subscript.  Use {tilde} to make it explicit that we
do want ~ characters in these places (backslash does not help).

Reported-by: Sylvain Rabot <sylvain.rabot@f-secure.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 3c96fa8..7300870 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -92,7 +92,7 @@ git cherry-pick ^HEAD master::
 	Apply the changes introduced by all commits that are ancestors
 	of master but not of HEAD to produce new commits.
 
-git cherry-pick master\~4 master~2::
+git cherry-pick master{tilde}4 master{tilde}2::
 
 	Apply the changes introduced by the fifth and third last
 	commits pointed to by master and create 2 new commits with
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f40984d..752fc88 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -87,7 +87,7 @@ git revert HEAD~3::
 	Revert the changes specified by the fourth last commit in HEAD
 	and create a new commit with the reverted changes.
 
-git revert -n master\~5..master~2::
+git revert -n master{tilde}5..master{tilde}2::
 
 	Revert the changes done by commits from the fifth last commit
 	in master (included) to the third last commit in master
-- 
1.7.3.2.642.g8b3da
