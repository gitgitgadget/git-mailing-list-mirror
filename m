From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Sat, 19 Jul 2008 14:52:14 -0700
Message-ID: <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882454D.2080500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sat Jul 19 23:53:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKKMq-0007WB-QF
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 23:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYGSVw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 17:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151AbYGSVw3
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 17:52:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbYGSVw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 17:52:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7AF33379CE;
	Sat, 19 Jul 2008 17:52:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 97069379CB; Sat, 19 Jul 2008 17:52:16 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9E8670E-55DC-11DD-A4FF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89136>

Olivier Marin <dkr+ml.git@free.fr> writes:

> It tries to apply patches even on a dirty tree which makes difficult
> to automatically do a "git reset --hard" with --skip or --abort and
> forces the user to clean the index by hand if last patch failed with
> unmerged files.
>
> So, do some people still use "git am" with a dirty tree or will a
> patch that make it work like "git rebase" be accepted?

Anything that changes "am" to require a clean working tree will NEVER be
accepted.  I personally rely on the ability for it to run in a dirty tree,
so does Linus.

	Side note.  Anything that changes "merge" to require a clean
	working tree is also unacceptable.  Cf.

	http://thread.gmane.org/gmane.comp.version-control.git/9073/focus=9089

	Linus talks about "patch" in the paragraph second to the last one
	in the message; back then he was talking about "git-applymbox" but
	the same argument there applies to its newer incarnation "git-am".

	Side note #2.  It would have been nice if "rebase" were also
	written in such a way that it can work in a dirty tree as long as
	local changes did not interfere with the operation, but it is a
	lot more involved.

When I looked at the "am --abort" patch briefly, I had an impression (by
reading its test case) that it correctly refrained from doing the
destructive "reset --hard".
