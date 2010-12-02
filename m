From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: escape '~' in git revert
Date: Thu, 02 Dec 2010 10:23:18 -0800
Message-ID: <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
References: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
 <20101202175013.GF3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Rabot <sylvain.rabot@f-secure.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODob-0006b1-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756979Ab0LBSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 13:23:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab0LBSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 13:23:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43AC13FCA;
	Thu,  2 Dec 2010 13:23:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gGgs6S1h5xsBXVcjcasYUEosno=; b=b0avLW
	1nMs/Ya1wIZzIPgfxlOsk8qW/Ofrga/beaAKEuW6/14/iyiSiRQQtWvwYy7FMiWf
	NifEUZknWjPvlru4ykBPgPVBXxEhJ9gBbuar+yUqOtaCzsnZWJiZSxPBXvB3cyZD
	O6L0DTzTKsu9o2mbr4nHFNhaQNZOfPQWNXj9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wB9+DSrcc7SZCSXGawpgAW/4D8rwKMnA
	sRnYSEyCOhB8x1XZvnqJSGAAJFI6v3jD2BYkzwkRGwctnNXPUgLCzHneGaND07a9
	22nq02PzKE0K7DoIS2L0yjl17ihM+SX8Cq/ZF5OK66MC3OgEoWIOUFTcf8uUjmpm
	mEhaZMevL2c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 11DCE3FC9;
	Thu,  2 Dec 2010 13:23:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C944D3FC3; Thu,  2 Dec 2010
 13:23:40 -0500 (EST)
In-Reply-To: <20101202175013.GF3962@burratino> (Jonathan Nieder's message of
 "Thu\, 2 Dec 2010 11\:50\:13 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4C44DDB6-FE41-11DF-9D7B-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162726>

Here is what I have right now, identified by

    $ git grep -e '~[0-9].*~.*::$' Documentation/

There is one funny I do not understand (oh, well, I admit that I do not
understand many funnies around AsciiDoc).  The two extra lines you would
find if you drop "::$" from the above, namely,

    git-rebase.txt:    git rebase --onto topicA~5 topicA~3 topicA
    user-manual.txt:$ git merge-file hello.c~2 hello.c~1 hello.c~3

do not seem to suffer from this issue.  IOW, it seems to affect only the
enumeration head items.

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
