From: Florian Weimer <fw@deneb.enyo.de>
Subject: Feature request: git-svn dcommit should send deltas upstream
Date: Tue, 26 Aug 2008 12:54:36 +0200
Message-ID: <87myj0f3mb.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 13:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXwez-00040E-UN
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYHZLXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYHZLXZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:23:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:43201 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYHZLXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:23:24 -0400
X-Greylist: delayed 1727 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2008 07:23:24 EDT
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1KXwC4-0007LX-Cw
	for git@vger.kernel.org; Tue, 26 Aug 2008 12:54:36 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1KXwC4-0003nY-25
	for git@vger.kernel.org; Tue, 26 Aug 2008 12:54:36 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93736>

Looking at my network traffic and the Perl code, it seems to me that
git-svn fails to create a diff (delta) before sending data to the
server.  As a result, a few changes in a multi-megabyte file lead to a
large upload (similar to the situation with CVS).  git-svn should be
able to compute this diff in all cases because it has got an up-to-date
copy of the current revision in the Subversion repository.

As far as I can tell, this can't be fixed with a one-liner; some handles
need to be passed down to the code that actually handles the upload.
