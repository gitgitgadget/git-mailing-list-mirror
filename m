From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
 backward compatibility.
Date: Thu, 04 Sep 2008 12:12:40 -0700
Message-ID: <7vd4jj3etz.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
 <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
 <20080904123046.GX10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKHQ-0007bQ-5x
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYIDTMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbYIDTMt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:12:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYIDTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:12:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E48A874E02;
	Thu,  4 Sep 2008 15:12:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E513E74E00; Thu,  4 Sep 2008 15:12:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75752522-7AB5-11DD-A9E6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94950>

Petr Baudis <pasky@suse.cz> writes:

> I'm also curious about
>
>                 if (suspect->commit->object.flags & UNINTERESTING) {
>                         if (blank_boundary)
>                                 memset(hex, ' ', length);
>                         else if (!cmd_is_annotate) {
>                                 length--;
>                                 putchar('^');
>                         }
>                 }
>
> in builtin-blame.c. Junio, you introduced this in e68989a739d - why
> do you use a separate flag instead of OUTPUT_ANNOTATE_COMPAT? The fact
> that git annotate == git blame -c does not hold true because of this
> (admittedly obscure case).

I do not recall the context of this change, but I do not think this is a
deliberate omission.  The breakage the quoted commit fixed was about
cvsserver that does run "git-annotate" not "git-blame -c" and that must be
the reason this has been unnoticed for a long time.

Oh, by the way, somebody should update cvsserver to run "git annotate" and
send in a tested patch, please?
