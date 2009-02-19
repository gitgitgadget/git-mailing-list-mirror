From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Modify description file to say what this file is
Date: Thu, 19 Feb 2009 02:11:08 -0800
Message-ID: <7vy6w2n3cz.fsf@gitster.siamese.dyndns.org>
References: <200902190736.00462.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5tc-0001Sh-7r
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZBSKLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZBSKLQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:11:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZBSKLP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:11:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1805E9B320;
	Thu, 19 Feb 2009 05:11:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 02D3C9B31D; Thu,
 19 Feb 2009 05:11:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A39BA656-FE6D-11DD-94AC-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110663>

[PATCH 1/6] Modify description file to say what this file is

Looks good.

[PATCH 2/6] Google has renamed the imap folder

Jeff already pointed out an obvious thinko; I could fix-up locally (just
ask).

[PATCH 3/6] Improve error message for branching an existing branch

The extra sentence is useless noise to annoy users and make them shout
"none of your business!" back to git.

I would probably get this error message "already exists." more from
forgetting to say "-f" in this sequence:

    $ git branch -f pu next
    $ git checkout pu
    $ sh rebuild-pu-script

to rebuild pu on top of updated next, and "did you mean to checkout?"
misses the mark by a kilometer.

[PATCH 4/6] Improve error message for git-filter-branch

Looks good, with Sverre's rewording would be better, which I could locally
squash in.  Needs signoff, which I could locally forge (just ask to fix-up
and forge).

[PATCH 5/6] Change output "error: " to "Error: " etc

Jeff is right, and the patch is wrong.

[PATCH 6/6] Mention to the user that they can reorder commits

The placement of the new message does not feel right, as adding anything
near "If you remove ... WILL BE LOST" will cloud out that message which is
more important.

I think it should come near or perhaps even before Commands, if we were to
add anything here.

But I am afraid that the proposed new message will hurt the clueless users
more than it would help them.

The cheat-sheet at the top is not for learning what the command can do for
the first time.  It is there to remind people (who already have general
idea on what can be done) how exactly the commands are spelled.  If
somebody does not even know that the purpose of rebase-i is to amend and
resequence, he will more likely destroy his history by blindly using the
command without knowing what is going on, than making a lucky guess.

For that reason, a more appropriate line to add, if we were to add
anything, might be:

 #  s, squash = use commit, but meld into previous commit
 #
+# If you do not know what is going on, remove everything and exit the editor!
+#
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
