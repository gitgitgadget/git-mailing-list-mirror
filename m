From: David Kastrup <dak@gnu.org>
Subject: Marking commits as transitory for git bisect?
Date: Wed, 02 Dec 2009 10:32:02 +0100
Message-ID: <871vjdyb59.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 10:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFlZA-00084Z-Qb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 10:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZLBJb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 04:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbZLBJb5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 04:31:57 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:40232 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZLBJb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 04:31:56 -0500
Received: from localhost ([127.0.0.1]:55445 helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.67)
	(envelope-from <dak@gnu.org>)
	id 1NFlZ4-0001UX-QA
	for git@vger.kernel.org; Wed, 02 Dec 2009 04:32:03 -0500
Received: by lola.goethe.zz (Postfix, from userid 1000)
	id 42BC2248DE; Wed,  2 Dec 2009 10:32:02 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134317>


Hi,

sometimes there are changes which would seem better to restructure into
more than one commit, with a non-operative intermediate state.

What I am thinking of is something like

a) change an API (small but highly intricate patch warranting thorough
   line-by-line review to make sure it's fine)
b) adapt all existing callers (really large but utterly trivial patch)

Substructuring this change into two commits may be quite nicer for
reviewing and following it.

Except that it breaks git bisect.  If there was a way to mark a commit
as non-interesting, something which does not necessarily need any new
repo features but just a convention like automatically skipping commits
that contain the literal string [skip bisect] in the commit message,
that would be one way to implement basic functionality like that.

A more thorough approach might also warn against partial cherrypicks or
rebases or merges applying just part of one such a combined change.

But the main point is the ability to keep git bisect working on commit
combinations with deliberately non-operative transitory stage.

-- 
David Kastrup
