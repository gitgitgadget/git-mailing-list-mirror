From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: squashing patches
Date: Mon, 9 Jun 2008 22:43:27 +0200
Message-ID: <20080609204327.GD8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <7vprqqh06j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:44:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oEE-0002cq-Gr
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbYFIUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbYFIUnd
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:43:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:43488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751440AbYFIUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:43:32 -0400
Received: (qmail invoked by alias); 09 Jun 2008 20:43:31 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 09 Jun 2008 22:43:31 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+ko7YarqCkd9hmF/3rHsGXZ9Sg7JwvqD9INdWlS5
	oPdIpJDBK0DaBx
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5oD9-00084Y-B0; Mon, 09 Jun 2008 22:43:27 +0200
Content-Disposition: inline
In-Reply-To: <7vprqqh06j.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84425>

> > Comments? Opinions? Ideas?
> 
> I actually expected that the primitive command sequence the backward
> compatible "edit" would expand to would be a pair, "pick" followed by
> "pause".

Something "like" this was my veeeery first approach: "edit" with commit
was the backwards-compatible "edit" and without arguments was your
"pause".
Example:
	pick ea7beef
	edit		# or "pause" as you suggested
After a little discussion this became:
	pick --edit ea7beef

And I can't objectively say what's better

> Whenever the sequencer sees "pause", it does not do anything but
> reports the current HEAD and gives the control back to the user, so that
> the user can do amend or whatever before telling you to --continue.

Yes.

> Similarly, I expected the backward-compatible "squash" to expand to a
> pair, "pick" followed by "zucchini 2".  Whenever the sequencer sees
> "zucchini <n>", it prepares a commit log to describe the top <n> commits,
> resets HEAD back by <n> commits, and gives control to your editor.

That's right.  See the RFC/PATCH about git-squash mail or its parent
mail[1] ;-)

 1. http://article.gmane.org/gmane.comp.version-control.git/84391 2) ff.
    and
    http://article.gmane.org/gmane.comp.version-control.git/84420

The open question is, if we should do this by a natural number <n> or
by a commit.
The natural number approach seems easier, but imagine someone pauses
and does some commits (not --amend)... Here the behavior of these
approaches differs. ;-)

> About the other parts in your original message:
> 
>  - The "tag" command looked a little out of place;

Eh, why?

>  - I would have called your "file" command "patch" (we might want to have
>    another file related operation later).

Ok. "file" and "patch" were both choices to me. Don't know, why I
decided for "file".

>  - The --author option presumably would be to lie about the authorship but
>    without taking it from an existing commit.  (1) Don't you need to have
>    an option similar to -C option of "git-commit"?  (2) Don't you need to
>    also be able to lie about the author timestamp?

Right. ;)

Regards and thanks,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
