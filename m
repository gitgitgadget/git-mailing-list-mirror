From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: format-patch: numbered patches from a patch list?
Date: Tue, 21 Jul 2009 20:47:30 -0600
Message-ID: <auto-000020035969@sci.utah.edu>
References: <auto-000020035874@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 04:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTRqR-0000BA-8n
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbZGVCqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZGVCqH
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:46:07 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:53584 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751511AbZGVCqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:46:06 -0400
Received: from dummy.name; Tue, 21 Jul 2009 20:46:06 -0600
In-Reply-To: Your message of "Tue, 21 Jul 2009 20:25:52 MDT."
             <auto-000020035874@sci.utah.edu> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123736>

Answering my own question.

tom fogal <tfogal@alumni.unh.edu> writes:
> I have a need to generate a numbered sequence of patches from
> a sparse sprinkling of patches on a branch.  Is there a way to
> accomplish this?

Yep.  Duh.

Just generate the patches as I did in my my first mail.  Then use
mtime.sh:

    #!/bin/sh

    for patch in $@ ; do
      commitdate=$(head -n 5 ${patch} | \
                   grep "^Date" | \
                   cut -d: -f 2-)
      touch -d "${commitdate}" ${patch}
      shortfn=$(echo "${patch}" | cut -b 1-30)
      echo "Changed ${shortfn} to ${commitdate}"
    done

to change the modification time of every patch I care about.  Now I can
list the files by modification time, achieving exactly what I want.

I really love a full posix environment sometimes.


Sorry for the noise,

-tom
