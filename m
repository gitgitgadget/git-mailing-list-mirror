From: Junio C Hamano <junkio@cox.net>
Subject: Re: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 10:31:05 -0800
Message-ID: <7vd5kkvd3q.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 19:34:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egnn0-0003Fc-B4
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 19:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVK1SbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVK1SbJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 13:31:09 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:56045 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932156AbVK1SbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 13:31:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128183035.GAYY15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 13:30:35 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12896>

Alex Riesen <raa.lkml@gmail.com> writes:

> Activision's Perl generates CRLF unless STDOUT is binmoded, which is
> inconsistent with other output of git-status.

I do not think this is a kind of patch that I should accept to
apply to the generic part of the codepath, even if on sane
platforms binmode() could be a no-op.

You should not have to say binmode() when you are emitting plain
text (otherwise you have to say that everywhere which is
madness).  I presume the Cygwin version uses Perl from Cygwin
and would not have this problem?

If that is the case, maybe this patch should be maintained out
of tree by the maintainer of Windows port of git that does _not_
use Cygwin but ActiveState.
