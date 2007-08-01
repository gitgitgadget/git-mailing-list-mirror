From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 01 Aug 2007 12:53:14 -0700
Message-ID: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
References: <86abtbnzpr.fsf@lola.quinscape.zz>
	<7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
	<85r6mnrs1z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGKG3-0000Os-FB
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762536AbXHATxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762585AbXHATxQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:53:16 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35064 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762481AbXHATxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 15:53:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801195314.DNMY23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 15:53:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WjtE1X00G1kojtg0000000; Wed, 01 Aug 2007 15:53:14 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54473>

David Kastrup <dak@gnu.org> writes:

> Well, I just checked the behavior with "less", "more", "mail" and
> "mailx", quite traditional commands that would not have a reason to
> complicate things by using "system" and quoting instead of exec.
> ...
> It turns out all three contestants still in the race apparently do a).
> If nobody has a sensible idea how to shell-quote generally enough...
> Under Unix, one has the option of using "..." and quoting the three of
> "$\ with \ or using '...' and replacing every contained ' with '\''.

Our scripts and C-level both tend to prefer using '\'' for its
simplicity (this also applies to rare case the user wants to
unquote it by hand).  Because it now is all in git-sh-setup, it
should be reasonably straightforward to implement the quoting of
the temporary file name and drop dq around ${EDITOR-VISUAL}.

Please make it so.
