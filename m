From: Guillaume Desmottes <guillaume.desmottes@collabora.co.uk>
Subject: [BUG] git rebase is confuse if conflict resolution doesn't produce
	diff
Date: Fri, 15 Aug 2008 18:00:43 +0100
Message-ID: <1218819643.6345.57.camel@cass-lpt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 19:34:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU3By-0000hr-U3
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760829AbYHORdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 13:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbYHORdB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 13:33:01 -0400
Received: from bhuna.collabora.co.uk ([195.10.223.82]:47813 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760768AbYHORdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 13:33:00 -0400
X-Greylist: delayed 1916 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Aug 2008 13:33:00 EDT
Received: from [10.0.0.172] (madras.collabora.co.uk [88.97.242.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bhuna.collabora.co.uk (Postfix) with ESMTP id 8E33010219C
	for <git@vger.kernel.org>; Fri, 15 Aug 2008 18:00:42 +0100 (BST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92494>

To reproduce:
- Rebase a branch "foo" on a branch "bar" in a way that there is a
conflict that you have to manually resolve.
- Run git diff and see the conflict
- Edit the conflicted file and remove all the conflicting bits (that
could be a valid resolution of the conflict)
- Now git diff produces an empty diff
- git add $CONFLICTED_FILE  as you have resolve the conflict
- git rebase --continue

You get the following error:
No changes - did you forget to use 'git add'?

git status is empty as the conflict was resolved.

A simple workaround is to add a dummy blank line in the conflicted file
so the diff is not empty.


	G.
