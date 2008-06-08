From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Sun, 08 Jun 2008 00:45:33 -0700
Message-ID: <7vy75gl68y.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com>
 <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
 <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com>
 <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806062015440.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062316270.19665@iabervon.org>
 <Pine.LNX.4.64.0806072143230.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 09:47:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5FcP-0000Ef-Ab
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 09:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbYFHHpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 03:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbYFHHpv
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 03:45:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204AbYFHHpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 03:45:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C70521CD8;
	Sun,  8 Jun 2008 03:45:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1043E1CD7; Sun,  8 Jun 2008 03:45:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E897E1EC-352E-11DD-90E0-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84256>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> So I should have
> ... (deleted)

More like this:

    From: Boyd Lynn Gerber <gerberb@zenez.com>
    Subject: [PATCH] Port to other 12 platforms
    Date: Sat, 7 Jun 2008 21:46:48 -0600
    To: git@vger.kernel.org
    Cc: gitster@pobox.com

    This adds support to compile git on 12 platforms (<<whichever one you
    ported including UnixWare, SCO,... are listed here.>>).

    __USLC__ indicates UNIX System Labs Corperation (USLC), or a 
    Novell-derived compiler and/or some SysV based OS's.  __M_UNIX indicates
    XENIX/SCO UNIX/OpenServer before 5.0.7 and prior  release of and SCO OS.
    Like Apple and BSD, both of these do not want _XOPEN_SOURCE defined to
    allow use of <<the symbols that is hidden if you have _XOPEN_SOURCE
    defined>>.

    Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
    ---
    << "git diff --stat -p" output for the patch here >>

without removal of dynamic-sized array from progress.c, which is not really
part of specific port to these 12 platforms, but is a more generic
"portability fix", which might read like this:

    From: Boyd Lynn Gerber <gerberb@zenez.com>
    Subject: [PATCH] progress.c: avoid use of dynamic-sized array
    Date: Sat, 7 Jun 2008 21:46:48 -0600
    To: git@vger.kernel.org
    Cc: gitster@pobox.com

    Dynamically sized arrays are gcc and C99 construct.  It sometimes is
    nice to use them but hurts portability to older compilers.  This
    removes the only use of the construct in stop_progress_msg(); the
    function is about writing out a single line of message, and the
    existing callers of this function feed messages of only bounded size
    anyway, so use of dynamic array is simply overkill.

    Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
    ---
    << "git diff --stat -p" output for the patch here >>
