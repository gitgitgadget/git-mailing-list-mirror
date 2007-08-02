From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] gitweb: Add an option to show size of blobs in the tree view
Date: Wed, 01 Aug 2007 17:47:17 -0700
Message-ID: <7vps263gq2.fsf@assigned-by-dhcp.cox.net>
References: <1185880790812-git-send-email-jnareb@gmail.com>
	<200708011505.02078.jnareb@gmail.com>
	<7v3az24zo6.fsf@assigned-by-dhcp.cox.net>
	<200708020158.50343.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 02:47:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGOqY-0008I9-KY
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 02:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbXHBArT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 20:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXHBArT
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 20:47:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63356 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbXHBArS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 20:47:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802004718.DKIW11888.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 20:47:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WonH1X00Q1kojtg0000000; Wed, 01 Aug 2007 20:47:18 -0400
In-Reply-To: <200708020158.50343.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 2 Aug 2007 01:58:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54506>

Jakub Narebski <jnareb@gmail.com> writes:

> So you think that ";opt=-l" would be required to have 'tree' view with 
> blob (file) sizes, and it would be allowed only if 
> gitweb_check_feature('ls-tree-size') is true (or something like that).
> Should we return "Permission denied" or simply ignore "-l" extra option 
> if it is prohivited by the config?

I would say we should make config show-tree-entry-size (or
whatever name) unconditionally give the object size of the tree
entry, and drop ";opt=-l in URL" support from the code.  In
other words, if the site/repo owner wants to show it, it is
shown to everybody, otherwise nothing is shown.

Keeping the URL clean and without needless variations would help
caching; I do not see major advantage of this feature one way or
the other, so if we can keep a tree view of the same object from
the same repository the same by removing one user preference,
that would be better.
