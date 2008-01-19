From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_commit_buffer: don't parse invalid commits
Date: Sat, 19 Jan 2008 11:52:47 -0800
Message-ID: <7vprvx8ueo.fsf@gitster.siamese.dyndns.org>
References: <1200764123283-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGJkq-0006pS-Cy
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 20:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbYASTwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYASTwz
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 14:52:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbYASTwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 14:52:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 348FF71C0;
	Sat, 19 Jan 2008 14:52:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F7171BE;
	Sat, 19 Jan 2008 14:52:50 -0500 (EST)
In-Reply-To: <1200764123283-git-send-email-mkoegler@auto.tuwien.ac.at> (Martin
	Koegler's message of "Sat, 19 Jan 2008 18:35:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71128>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> * check, that the tree line ends with \n

Ok.

> * prevent parse_commit_date from reading beyond the buffer,
>   - if author line does not end with \n
>   - if committer line does not contain >

"even if" would be nicer, I think.

> * verify in parse_commit_date, that the commiter line ends with \n

Perhaps an additional note to leave for people who will later be
tempted to touch this part of the code is needed; otherwise the
time spent on the thread goes wasted.

 * keep the existing behaviour to return a commit object even
   when non-structural fields such as committer and author are
   malformed, so that tools that need to look at commits to
   clean up a history with such broken commits can still get at
   the structural data (i.e. the parents chain and the tree
   object).

No need to resend if you allow me to amend the patch along the
above lines (please just say so), or you could resend with
improvements on your own.

Thanks.
