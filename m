From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What I miss from Cogito...
Date: Mon, 24 Mar 2008 02:40:30 +0100
Message-ID: <20080324014030.GA24695@atjola.homenet>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <20080323182102.GA22551@bit.office.eurotux.com> <87r6e1b6c8.fsf@mid.deneb.enyo.de> <20080324001617.GB24943@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Mar 24 02:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdbgp-0000i9-7T
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbYCXBke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 21:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754992AbYCXBke
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:40:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:40475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754712AbYCXBke (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:40:34 -0400
Received: (qmail invoked by alias); 24 Mar 2008 01:40:31 -0000
Received: from i577AC57D.versanet.de (EHLO atjola.local) [87.122.197.125]
  by mail.gmx.net (mp050) with SMTP; 24 Mar 2008 02:40:31 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1//NXAv+s7/2TQKtww4kPyqUreTsjzLEiTRCmuXif
	B2EW8DX5UeZ//V
Content-Disposition: inline
In-Reply-To: <20080324001617.GB24943@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77987>

On 2008.03.23 20:16:17 -0400, Theodore Tso wrote:
> On Sun, Mar 23, 2008 at 08:14:47PM +0100, Florian Weimer wrote:
> >=20
> > Personally, I'm not all that happy with the multiple different mean=
ings
> > of "git reset" and "git checkout", either.  Depending on the parame=
ters,
> > the two comments manipulate both the contents of the working copy, =
or
> > the location at which the working copy is hooked in the history.  I=
f we
> > need to have two separate commands for this, it would make more sen=
se to
> > draw distinction between the two aspects, and not the mess we have =
now.
> > OTOH, it's probably too late for that.
>=20
> Yeah, it's not at all intuitive.  I've been using git for quite some
> time and had *absolutely* *no* *idea* that "git checkout <treeish> --
> path" did what "bk revert" and "hg revert" does.  In fact, I'm pretty
> sure I remember asking for this functionality a while back, and being
> told the right answer was "git show HEAD:pathname > pathname", and I
> kept on typing it until I got sick and tired of it, and so I created
> my short-hand shell script.

There is a difference between "checkout HEAD -- $file" and "show
HEAD:$file > $file". The former will also update the index, while the
latter does not. Maybe you asked for not updating the index back then?
Just guessing...

> And the fact that Peter was using "git reset --hard -- pathname" is
> another hint that it isn't at *all* obvious that "git checkout" does
> two completely different things, and it's not something that you're
> likely to intuit from the name or looking at the top-level git man
> page (where the summary in the top-level git manpage is, "checkout an=
d
> switch to a branch").

Maybe it's just a misunderstanding on my side, but to me "checkout"
means as much as "get me something out of the repo". And git checkout
does exactly that. It can get you a branch (naturally switching your
HEAD to it), or it can get you trees or blobs. The latter can come from
either the index (default) or from a specific treeish. To say that you
want to revert your local changes is just the same as saying that you
want the file as it is in HEAD. And that's what git checkout gives you,
without introducing an extra command for that one special case.

> If we were going to separate the two commands out, I'd use the name
> "git revert-file", because that's what people who are coming from bk
> or hg are used to (where "revert" means to undo the local edits done
> to a particular file, as opposed to the git meaning of undoing a
> particular commit).

Nah, that would create confusion within git, because it does something
totally different from git revert. And checkout can also checkout a
whole tree, not just a file. So you would either need revert-tree as
well... Or add more confusion, because revert-file "reverting" a tree i=
s
not quite intuitive.

Bj=F6rn
