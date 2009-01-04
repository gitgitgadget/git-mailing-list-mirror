From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-rev-parse --symbolic-abbrev-name [was Re: git-branch --print-current]
Date: Sun, 04 Jan 2009 04:34:06 -0800
Message-ID: <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
	<402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
	<quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
	<20090104033839.GD21154@genesis.frugalware.org>
	<quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
	<7vzli73b1g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJSCZ-0008Cp-1q
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbZADMeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbZADMeJ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:34:09 -0500
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:36640 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbZADMeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:34:08 -0500
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 281DE3448D; Sun,  4 Jan 2009 04:34:06 -0800 (PST)
X-Quack-Archive: 1
In-Reply-To: <7vzli73b1g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 03 Jan 2009 21\:17\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104511>

>>>>> On 2009-01-03 21:17 PST, Junio C Hamano writes:

    Junio> That is a good point about user education, and is a
    Junio> demonstration why a new option to cover a very
    Junio> narrow-special case to symbolic-ref will not help the
    Junio> situation.  People will add their own embellishments
    Junio> around the name of the branch anyway, and the most
    Junio> generic symbolic-ref output is just as useful as a
    Junio> special case option to show without refs/heads/.

That's arguable :) you really think "branchfoo" instead of
"refs/heads/branchfoo" is a narrow special case?  Seems like a
common case for everyone except plumbing tools.

Here's a more general idea you might like better:

    git symbolic-ref --abbrev BLAH
or even
    git rev-parse --symbolic-abbrev-name BLAH

This would be like git-rev-parse --symbolic-full-name, but strips
the "refs/x/" iff the result is unambiguous.  Since it's much more
work for a script to check whether the stripped version is
ambiguous, this functionality is appropriate as a builtin option.

(Hmm, I guess to be able to specify a ref it has to already be
unambiguous, so the main use that --symbolic doesn't already cover
is for symbolic refs such as HEAD.)

    Junio> What you quoted are all inferior implementations of
    Junio> showing the name of the current branch in the bash
    Junio> prompt.

Yup, that was the point - it's so ugly seeing all these things
floating around, but that's where things stand right now.

    Junio> ... __git_ps1 shell function is defined to be used for
    Junio> this exact purpose and is documented in the completion
    Junio> script.

Thanks for the detailed explanation.  I actually use zsh rather
than of bash and I did already find git-completion.bash.  But
obviously all those people posting on blogs don't know about it :)
