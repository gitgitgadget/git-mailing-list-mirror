From: james.moger@gitblit.com
Subject: Re: RFE: support change-id generation natively
Date: Mon, 21 Oct 2013 11:41:59 -0400
Message-ID: <1382370119.28365.36627953.50C0496E@webmail.messagingengine.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Mon Oct 21 17:42:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYHcM-0006Cq-ON
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 17:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab3JUPmB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Oct 2013 11:42:01 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60168 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329Ab3JUPmA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 11:42:00 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8305221583;
	Mon, 21 Oct 2013 11:41:59 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute3.internal (MEProxy); Mon, 21 Oct 2013 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gitblit.com; h=
	message-id:from:to:cc:mime-version:content-transfer-encoding
	:content-type:in-reply-to:references:subject:date; s=mesmtp; bh=
	jjGUvaZuLlsgjbHob68RdA5YTng=; b=DcK69XAtlm/kKYr6jAmj10zfd0r79g3Y
	CgK1yfqa+eQcogJO8kKhPlRy7zAFf8Fu2yzOcs5sfoiFTf0JvTXY7RJ3srr32n2P
	EPRFok1KVIgeEETa0OUrE785furir4k6DTf6G09nHhQ+xEtB/eEn7vZEZYY4HWvp
	xy/lclaOrk4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=smtpout; bh=jjGUvaZuLlsgjbHob68RdA5YTng=; b=Eyw
	xCFQoEh7HdsJf8tJpoE7FS0JiUrclEW7rZovPyTJp0Gk0IanKcdcgsHs2HaSDzLi
	ykL6FGzXp4SdB+ySnjK5EJrRfuW7NGphK5FDdtXJUmqf6fciPBR9GfDhAT16SB67
	XFr8pXlb7ZqRrO7yumlqrWWAxdPXDTMGjP0rC7QI=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 527F3A75D10; Mon, 21 Oct 2013 11:41:59 -0400 (EDT)
X-Sasl-Enc: IlQdSWuNIVF0LSaJGvaEXkWpKoweUMZV27kVFdeMOYc+ 1382370119
X-Mailer: MessagingEngine.com Webmail Interface - ajax-0cc2f9cc
In-Reply-To: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236431>

The change-id is exactly like a commit-id, it is an SHA-1 value, but it
is a constant embedded in the commit message.

Why does Gerrit need this value?
Gerrit is based on the concept of revising/polishing a commit or a
series of commits.

=46or clarity, consider the case of revising a proposed bug fix.

You checkout the current revision of a proposed bug fix commit that has
a change-id value in it's message.  You revise and _amend_ this commit,
preserving the change-id in the commit message.  Now your commit-id has
changed, but your change-id is still the same.  You then upload your
amended commit to Gerrit which links the amended commit with the
discussion/review.

Commit-ids change all the time because of amend; change-ids are constan=
t
and they are the key that links commit revisions to a discussion.

What I am requesting is a feature that generates and injects the
Change-Id value for the very first commit revision.  This commit is
special because it will create the discussion in Gerrit for the commit.=
=20
Gerrit relies on client-side change-id generation for this initial
commit.  This allows contributors to propose new ideas by implementing
that idea and pushing the proposed implementation to Gerrit.  Gerrit
intercepts this and automatically creates a discussion/review keyed by
the specified Change-Id value.  And now through the --amend process,
this commit can be revised and polished until it is blessed by a
reviewer for merging to some integration branch.

-J



On Mon, Oct 21, 2013, at 10:51 AM, Jeremy Rosen wrote:
> for those of us that are not using gerrit...
>=20
> what is a change-id (semantically, I got from your mail that it is so=
me
> sort
> of unit id set at commit time) and in what way is it different from t=
he=20
> commit-id ?
>=20
> Cordialement=20
>=20
> J=E9r=E9my Rosen=20
> +33 (0)1 42 68 28 04
>=20
> fight key loggers : write some perl using vim=20
>=20
>=20
> Open Wide Ingenierie
>=20
> 23, rue Daviel
> 75012 Paris - France
> www.openwide.fr
>=20
>=20
>=20
>=20
>=20
> ----- Mail original -----
> > Hello Git Community,
> >=20
> > TL;DR:
> > It would be a really nice enhancement if the commit command nativel=
y
> > supported _optionally_ injecting a "Change-Id: I000..." footer in t=
he
> > last paragraph of the commit message template and then substituting
> > the
> > "I000..." value, on commit, with a generated value _without_ having
> > to
> > rely on a per-repository, native hook or a global hook that affects
> > every local repository.
> >=20
> > Full Request:
> > Gerrit has established the change-id footer as a prominent and
> > wide-spread collaboration identifier.  For those contributing new
> > patches to a Gerrit server, it is required to either use EGit/JGit
> > (Eclipse) to generate commits [1] OR to use a commit hook script wi=
th
> > native git to insert a change-id footer during the commit process
> > [2].
> > This per-repository hook script requirement is an obstacle.  These
> > communities would be better served and it would lower the
> > contribution
> > barrier for many open source projects if native git supported
> > change-id
> > generation & injection.
> >=20
> > I acknowledge that not everyone uses nor wants to use Gerrit and th=
e
> > change-id footer.  That is fine, but it would be a _tremendous_
> > usability improvement for those contributing to open source project=
s
> > (myself included) if something like a "--change-id" flag  was
> > implemented and maybe even a config setting to always generate a
> > change-id on commit (EGit currently supports this as
> > "gerrit.createchangeid=3Dtrue").
> >=20
> > Sadly, my C skills are lacking as I live mostly in the world of
> > managed
> > code, but I'd be very happy to cheer for a change-id champion; I
> > suspect
> > there are some out there who might rally to this cause.
> >=20
> > Thanks for your consideration.
> > James Moger
> > gitblit.com
> >=20
> > [1]
> > https://git.eclipse.org/c/jgit/jgit.git/tree/org.eclipse.jgit/src/o=
rg/eclipse/jgit/api/CommitCommand.java?h=3Dstable-3.1#n288
> > [2]
> > http://gerrit-documentation.googlecode.com/svn/Documentation/2.0/cm=
d-hook-commit-msg.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
