From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: RE: Updating Files
Date: Wed, 09 Nov 2011 20:08:04 -0500
Message-ID: <1320887258-sup-7544@pinkfloyd.chass.utoronto.ca>
References: <338A71EC3E356A47BF5279971E4EF72A04D860D7F6@WESMSG51.nordsoncorp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: greg.brand@nordsonasymtek.com
X-From: git-owner@vger.kernel.org Thu Nov 10 02:08:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROJ7k-0004xg-5l
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 02:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756913Ab1KJBIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 20:08:07 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:41384 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab1KJBIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 20:08:06 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:41320 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1ROJ7c-0000Nk-Fa; Wed, 09 Nov 2011 20:08:04 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1ROJ7c-000284-Ec; Wed, 09 Nov 2011 20:08:04 -0500
In-reply-to: <338A71EC3E356A47BF5279971E4EF72A04D860D7F6@WESMSG51.nordsoncorp.local>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185182>

Excerpts from Brand, Greg's message of Wed Nov 09 19:54:34 -0500 2011:

Hi Greg,

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .<filename>.revision =C2=A0=C2=A0 ~ Does GIT have the s=
ame, or
> similar options???=C2=A0 I understand with the distributed nature of =
GIT,
> there may be several ways to accomplish this. It is nice, though, to
> be able to get a clean version without losing changes you may (or
> may not) want to keep.

You've got at least two options to store changes you want to keep but
have them kept out of the way.

1. Commit the change on a branch and leave that branch sitting there.
2. Stash the change with a descriptive note.

If you're on branch master and want to save this change but not have
it 'live' you could do:

git checkout -b save_my_change
git add modified_file
git commit -m 'saving this for later, just in case'
git checkout master

The master branch will not have the change but the save_my_change
branch will.  You can see the commit with a command like:

git show save_my_change

That looks up the sha1 for the ref that save_my_change refers to and
then shows the commit object.  To re-apply this later, you could merge
the branch to master or cherry pick the sha1 to master (or any other
branch).

The second option, stashing, is likely nicer for this type of thing
but ymmv.  In your working tree, with the modified file(s), do:

git stash save -m 'something potentially useful, but maybe not'

Your working tree is now clean and you can see stashes with:

git stash list

You can later get at a stash with git stash apply.


The real gurus may point out something nicer that I didn't think of
too...

Hope this helps.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
