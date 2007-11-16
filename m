From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Fix per-directory exclude handing for "git add"
Date: Fri, 16 Nov 2007 13:50:29 +0000
Message-ID: <80y7cy2tay.fsf@tiny.isode.net>
References: <80ir431xny.fsf@tiny.isode.net>
            <alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
            <80ir43e04o.fsf@tiny.isode.net>
            <7vir4341ok.fsf@gitster.siamese.dyndns.org>
            <7vodduzh36.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 14:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It1as-0002U2-Jd
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 14:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338AbXKPNue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 08:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758217AbXKPNue
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 08:50:34 -0500
Received: from rufus.isode.com ([62.3.217.251]:38185 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757407AbXKPNud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 08:50:33 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rz2gJQBBVHAA@rufus.isode.com>; Fri, 16 Nov 2007 13:50:30 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 16 Nov 2007 13:50:29 +0000
X-Hashcash: 1:20:071116:gitster@pobox.com::J3Dbkzgv2AJYTiPF:0000000000000000000000000000000000000000000024Ij
X-Hashcash: 1:20:071116:torvalds@linux-foundation.org::r2Q8a1X9dQ7MvKRz:000000000000000000000000000000006O/F
X-Hashcash: 1:20:071116:git@vger.kernel.org::4g2z0kyWoQVvXkQx:0000000000000000000000000000000000000000001Ami
In-Reply-To: <7vodduzh36.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 16 Nov 2007 01\:15\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65227>

Junio C Hamano <gitster@pobox.com> writes:

[...]

> While read_directory_recursive() runs, calls to excluded() makes use
> the data in the exclusion elements, including this base string.  The
> caller of read_directory_recursive() is not supposed to free the
> buffer it gave to push_exclude_per_directory() earlier, until it
> returns.

Cool, that fixes the "git add" issue I was seeing.  (So Acked-by:
Bruce Stephens <bruce.stephens@isode.com>, for what it's worth.)

I guess really the output of "git status" (or "git runstatus") is more
significant since that's what we'd normally be running (that's
presumably what "git gui" and similar tools run, though perhaps they
use "git ls-files"---probably the underlying code's the same, I
guess).

However, that doesn't mean the issue with git add shouldn't be
resolved.

[...]
