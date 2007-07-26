From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in gitk search box
Date: Wed, 25 Jul 2007 22:49:35 -0700
Message-ID: <7v1wevbtow.fsf@assigned-by-dhcp.cox.net>
References: <20070725135621.GC21692@lavos.net>
	<18087.60033.676105.538784@cargo.ozlabs.ibm.com>
	<7vtzrrc1sb.fsf@assigned-by-dhcp.cox.net>
	<18088.10039.780711.708582@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bdowning@lavos.net (Brian Downing), git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwEG-0001hO-Nv
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbXGZFti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbXGZFti
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:49:38 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63505 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbXGZFth (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 01:49:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726054936.CKPD1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 26 Jul 2007 01:49:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U5pc1X0031kojtg0000000; Thu, 26 Jul 2007 01:49:36 -0400
In-Reply-To: <18088.10039.780711.708582@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Thu, 26 Jul 2007 14:46:47 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53773>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> There was a recent message from Linus on the list, stating that
>> NUL in -z format is inter-record separator, not after-record
>> terminator.
>
> OK, I'll have to change gitk then.  It looks like both Marco and I got
> tricked by this.  I suggest it's worth a mention in the documentation.

I think that is indeed necessary.  How about this?

---
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8216576..228ccaf 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -43,7 +43,9 @@
 	Synonym for "-p --stat".
 
 -z::
-	\0 line termination on output
+	NUL-line termination on output.  This affects the --raw
+	output field terminator.  Also output from commands such
+	as "git-log" will be delimited with NUL between commits.
 
 --name-only::
 	Show only names of changed files.
