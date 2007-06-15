From: linux@horizon.com
Subject: Re: git-repack made my pack 317x larger...
Date: 15 Jun 2007 10:54:33 -0400
Message-ID: <20070615145433.22970.qmail@science.horizon.com>
References: <alpine.LFD.0.99.0706150935530.5651@xanadu.home>
Cc: git@vger.kernel.org
To: linux@horizon.com, nico@cam.org
X-From: git-owner@vger.kernel.org Fri Jun 15 16:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDCD-0000Ey-IM
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 16:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbXFOOyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbXFOOyi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 10:54:38 -0400
Received: from science.horizon.com ([192.35.100.1]:17387 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754765AbXFOOyg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 10:54:36 -0400
Received: (qmail 22971 invoked by uid 1000); 15 Jun 2007 10:54:33 -0400
In-Reply-To: <alpine.LFD.0.99.0706150935530.5651@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50264>

>> Uh... what happened?  It's not a full kernel clone, but it's a lot more
>> objects than I expected.  Where did all the extra objects come from?

> Maybe you want to add -l as well to your git-repack invocation.

Ah.  Thank you.  Indeed, this is another example of git documentation
disease.  git-repack refers to git-pack-objects, which gives a very
technical explanation of what it does, but nowhere is it mentioned that
list of objects suppled to git-pack-object's stdin includes objects
borrowed from alternates.

Of course, reading the description of git-rev-list --objects, you might
get the impression, but it's not exactly hugely obvious.

Given that "git-repack -f" is a not uncommon command, could I suggest
that the default is wrong, and there should be a special flag for
"suck in alternates, so this repository is no longer dependent
on any others".

Mentally, git-repack is a "reduce space consumption" command, not an
increase one.  Having to remember that this repository uses alternates
and add an extra flag to avoid having a space explosion is distinctly
annoying.

(I might complan a little less if git-repack would take -adlf rather
than insisting on -a -d -l -f.  Is that a deliberate choice or has just
nobody stepped up to revamp the option parsing?)
