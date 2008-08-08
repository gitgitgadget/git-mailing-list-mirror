From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 03:15:43 -0700
Message-ID: <7v1w0zersg.fsf_-_@gitster.siamese.dyndns.org>
References: <489C145B.5090400@sneakemail.com>
 <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 12:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRP2T-0007e4-IP
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbYHHKPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792AbYHHKPu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:15:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbYHHKPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:15:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BC3FA47063;
	Fri,  8 Aug 2008 06:15:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2336E47061; Fri,  8 Aug 2008 06:15:46 -0400 (EDT)
In-Reply-To: <7vfxpfet8a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Aug 2008 02:44:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F8C7AB22-6532-11DD-9E5D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91647>

As this is not limited to diff command at all, let's do this instead.

-- >8 --
Document use of pager means you will see exit code from the pager

Whenever we run pager (either a subcommand that implies use of pager by
default, or by explicit request with "git -p cmd"), the main git process
becomes the upstream of the pipe that feed the pager, and the exit code
from the command as a whole comes from the pager.  Long time users may
have already got used to this without being documented, but it should be
documented.

We may be swapping the process ordering in the future so that the exit
code from the main git process is always exposed, and at that point this
comment should be removed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1cb972..d6ca400 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -150,7 +150,9 @@ help ...`.
 
 -p::
 --paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+	Pipe all output into 'less' (or if set, $PAGER).  Note that this
+	implies that the exit code you see from the command will be that
+	of the pager, not git.
 
 --no-pager::
 	Do not pipe git output into a pager.
