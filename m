From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Make numstat machine friendly also for renames (and copies)
Date: Mon, 10 Dec 2007 15:00:25 -0800
Message-ID: <7vir36jgty.fsf@gitster.siamese.dyndns.org>
References: <200712102332.53114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 00:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rcT-00049p-Nh
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 00:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbXLJXAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXLJXAl
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 18:00:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbXLJXAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 18:00:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2F52A39;
	Mon, 10 Dec 2007 18:00:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 455772A37;
	Mon, 10 Dec 2007 18:00:32 -0500 (EST)
In-Reply-To: <200712102332.53114.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 10 Dec 2007 23:32:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67768>

Jakub Narebski <jnareb@gmail.com> writes:

> "git diff --numstat" used the same format as "git diff --stat" for
> renamed (and copied) files, except that filenames were not shortened
> when they didn't fit in the column width.  This format is suitable for
> human consumption, but it cannot be unambiguously parsed.

Agreed about the (un)parsability, and --numstat is all about parsability
so I would not object.  A fix is really needed there.

I do not have time to look at the patch right now, but if the changed
output is in line with what --name-status would show, that would be
great.  I'd call that "the format that should have been from day one".

I.e. no '=>' rename marker, but show two names c-quoted (unless -z is
used) and separated with inter_name_termination).  IIRC, that is how
rename/copy is shown with --name-status.
