From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: add a From: line to the email header
Date: Thu, 08 Nov 2007 01:55:03 -0800
Message-ID: <7vode52hag.fsf@gitster.siamese.dyndns.org>
References: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 10:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq46k-0001NA-3D
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 10:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbXKHJzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 04:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757686AbXKHJzL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 04:55:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41978 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725AbXKHJzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 04:55:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EDA182EF;
	Thu,  8 Nov 2007 04:55:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 720E092771;
	Thu,  8 Nov 2007 04:55:27 -0500 (EST)
In-Reply-To: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Thu, 8 Nov 2007 09:48:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63986>

Gerrit Pape <pape@smarden.org> writes:

> $committer is already extracted from the latest existing rev, so add the
> corresponding From: line to the email header.

You may fight this out with Andy if you want to, but I think I'd
side with the existing behaviour.

commit e6dc8d60fbd2c84900a26545c5d360b0e202d95b
Author: Andy Parkins <andyparkins@gmail.com>
Date:   Fri Sep 28 15:24:26 2007 +0100

    post-receive-hook: Remove the From field from the generated email header so that the pusher's name is used
    
    Using the name of the committer of the revision at the tip of the
    updated ref is not sensible.  That information is available in the email
    itself should it be wanted, and by supplying a "From", we were
    effectively hiding the person who performed the push - which is useful
    information in itself.
    
    Signed-off-by: Andy Parkins <andyparkins@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 1f88099..cbbd02f 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -177,7 +177,6 @@ generate_email_header()
 	# --- Email (all stdout will be the email)
 	# Generate header
 	cat <<-EOF
-	From: $committer
 	To: $recipients
 	Subject: ${EMAILPREFIX}$projectdesc $refname_type, $short_refname, ${change_type}d. $describe
 	X-Git-Refname: $refname
