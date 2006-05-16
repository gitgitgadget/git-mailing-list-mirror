From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport
Date: Tue, 16 May 2006 12:01:27 -0700
Message-ID: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 21:01:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg4na-00048r-7V
	for gcvg-git@gmane.org; Tue, 16 May 2006 21:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWEPTBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 15:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWEPTBb
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 15:01:31 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:32919 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1752002AbWEPTBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 15:01:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516190129.YUXY27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 15:01:29 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1bqtx6el6.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Tue, 16 May 2006 11:53:41 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20133>

ebiederm@xmission.com (Eric W. Biederman) writes:

>    Given the ugliness in -mm making it an error to have an
>    non-attributed patch would result in people specifying --author
>    when they really don't know who the author is, giving us much
>    less reliable information.
>
>    Possibly what we need is an option to not make it an error so that
>    people doing this kind of thing in their own trees have useful
>    information.

I agree it is probably a good way to error by default, optinally
allowing to say "don't care".  I do not think Linus would pull
from such a tree or trees branched from it into his official
tree, so I do not think we would need to worry about commits
with incomplete information propagating for this particular
"gitified mm" usage.  But as a general purpose tool to produce
"gitified quilt series" tree, we would.

It depends on the expected use of the resulting gitified mm
tree.

If it is for an individual developer to futz with and tweak
upon, and the end result from the work leaves such a "gitified
quilt series" repository only as a patch form, then not having
to figure out and specify authorship information to many patches
is probably a plus; the information will not be part of the
official history recorded elsewhere anyway.

However, if it is to produce a reference git tree to point
people at, (i.e. the quiltimport script is run once per a series
by somebody and the result is published for public use), I would
imagine we would want to have the attribution straight, so if
the tool has to "guess", it should either error out or go
interactive and ask.
