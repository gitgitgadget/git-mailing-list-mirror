From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git format-patch' on older commits, and mailinglist
Date: Tue, 10 Jun 2008 15:37:40 -0700
Message-ID: <7vfxrkdih7.fsf@gitster.siamese.dyndns.org>
References: <484E52DE.1070100@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CUG-0003mT-Ez
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYFJWhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYFJWhu
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:37:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYFJWht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 18:37:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B4A724A1;
	Tue, 10 Jun 2008 18:37:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 89A1824A0; Tue, 10 Jun 2008 18:37:42 -0400 (EDT)
In-Reply-To: <484E52DE.1070100@trolltech.com> (Marius Storm-Olsen's message
 of "Tue, 10 Jun 2008 12:09:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9902540-373D-11DD-A688-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84555>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Recently, I sent out patches which were fixed up with --amend on older
> commits. When I sent them out, the patches contained
>     Date: <more than 2 days old datestamp>
> in the headers. Now, sending these mails is fine, and mail clients
> generally handles it perfectly fine. However, after doing this I got
> an email from postmaster@vger.kernel.org, basically telling me to not
> do this, since they get a lot of bounces where the return is marked
> with
>     Diagnostic Code: smtp; 550 (4.5 DATE_IN_PAST_48_96 Date: is 48 to
> 96 hours before Received: date)
>
> This is understandable. The question is, do we fix the tools to handle
> this, so that emails are always generated with now() date, and the
> commit content contains a tag for the original commit; or do we simply
> say, always send patches to the mailing list with a current timestamp?

I think the right solution would be for send-email to move Date: to the
beginning of the body part, just like it adds an extra From: there when
the sender is different from the author, and not lie about the mail
transmission date.

Then we won't lose the authorship date information in the resulting commit
and will still keep the mailpath happy.
