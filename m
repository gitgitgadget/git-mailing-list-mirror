From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Wed, 16 Jul 2008 09:05:33 -0700
Message-ID: <7vej5tu84y.fsf@gitster.siamese.dyndns.org>
References: <g5jj21$bsp$1@ger.gmane.org>
 <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
 <7vr69tu91e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: namsh@posdata.co.kr, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 16 18:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ9Wn-0001xO-T6
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 18:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020AbYGPQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757992AbYGPQFq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 12:05:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757949AbYGPQFq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 12:05:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 55C702EBC0;
	Wed, 16 Jul 2008 12:05:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F2252EBBD; Wed, 16 Jul 2008 12:05:35 -0400 (EDT)
In-Reply-To: <7vr69tu91e.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 16 Jul 2008 08:46:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B063338-5351-11DD-8E74-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88694>

Junio C Hamano <gitster@pobox.com> writes:

> It wants to make sure that the shell specified from the toplevel Makefile
> (or from make command line) is used to run the aggregation script.  It is
> often necessary when platform /bin/sh is not quite POSIX (e.g. the script
> in question uses arithmetic expansion "$(( $var1 + $var2 ))").
>
> Just saying "Use specified shell to run shell scripts" on the title line
> would be sufficient, but I wonder if this is the only remaining place...

People on funny platforms might find this one useful, which is consistent
with the way the patch under discussion called the shell.  This lets you
to say

	SHELL_PATH = /Program Files/GNU/Bash

or something silly like that ;-)

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9b52071..a2b2627 100644
--- a/Makefile
+++ b/Makefile
@@ -153,7 +153,7 @@ all::
 # broken, or spawning external process is slower than built-in grep git has).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@'$(SHELL_PATH_SQ)' ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
