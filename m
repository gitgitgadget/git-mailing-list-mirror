From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 22:47:18 -0800
Message-ID: <7vd4tdhgnd.fsf@gitster.siamese.dyndns.org>
References: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<20071210234941.GE22254@coredump.intra.peff.net>
	<7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
	<7vzlwhhli5.fsf@gitster.siamese.dyndns.org>
	<20071211063941.GB21718@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:47:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yuF-00040u-1i
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbXLKGra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXLKGra
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:47:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXLKGr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:47:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B144BD8;
	Tue, 11 Dec 2007 01:47:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 117784BD6;
	Tue, 11 Dec 2007 01:47:20 -0500 (EST)
In-Reply-To: <20071211063941.GB21718@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Dec 2007 01:39:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67806>

Jeff King <peff@peff.net> writes:

> We are duplicating the "!shown && ..." conditional branch from
> log_tree_commit, which calls show_log. Why are we not calling show_log
> instead of pretty_print_commit (I understand that show_log should end up
> calling pretty_print_commit, but it is not immediately obvious that all
> of the extra code in show_log is going to be ignored).

Exactly.  I think show_log() has become too complex, and when we want a
oneline userformat, pretty-print-commit is more appropriate to use.
Actually, when I re-review the code, I think the part should use
format_commit_message() which is more to the point without any of the
other "more generic" parameter pretty-print-commit takes.
