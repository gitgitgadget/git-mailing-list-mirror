From: tom fogal <tfogal@alumni.unh.edu>
Subject: format-patch: numbered patches from a patch list?
Date: Tue, 21 Jul 2009 20:25:52 -0600
Message-ID: <auto-000020035874@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 04:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRVr-0003dT-2J
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZGVCY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZGVCY3
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:24:29 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:53521 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755864AbZGVCY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:24:29 -0400
Received: from dummy.name; Tue, 21 Jul 2009 20:24:28 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123732>

I have a need to generate a numbered sequence of patches from a sparse
sprinkling of patches on a branch.  Is there a way to accomplish this?

Basically I want to say, `for the patches at the heads of these sha1s,
give me a numbered sequence.'  Currently I take the list of shas that I
want, throw them in a file, and loop over each entry:

  for sha in $(cat patches) ; do git format-patch -o a/ ${sha}^..${sha} ; done

This is undesirable because each patch is the first patch in a series,
e.g. "0001-...".  A desirable interface would be specifying multiple
disconnected ranges via some separator, say ",".

To hammer it home; given:

   ... -- A -- B -- C -- D -- E -- F -- G

I'd like a command / line or two of shell which could get me:

  the patch that created A: 0001
  the patch that created B: 0002
  the patch that created E: 0003
  the patch that created G: 0004

etc.  It'd get confusing if I specified multiple branches.  Fortunately
I don't need that use case, and anyway I think just providing a raw
ordering based on timestamp (ignoring branches) would be sufficient for
any (of my) future needs.


The use case for all of this is disconnected repositories that really
shouldn't be.  We do `special' merging in subversion, so I do a lot of
trunk work via git-svn, and then I have backporting sessions where I
identify commits which should go on our release branches and put them
there.

Thanks for any ideas,

-tom
