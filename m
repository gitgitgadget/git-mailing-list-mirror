From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes
 in detail
Date: Thu, 16 Jan 2014 21:02:22 +0000
Message-ID: <20140116210222.GG7608@serenity.lan>
References: <20140114224246.GA13271@book.hvoigt.net>
 <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
 <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
 <20140116205521.GY2647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 22:02:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3u5K-0007ui-M0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaAPVCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 16:02:39 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:59646 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaAPVCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 16:02:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E3F30CDA5D2;
	Thu, 16 Jan 2014 21:02:36 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlQUgc22qjXl; Thu, 16 Jan 2014 21:02:36 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 53F1FCDA58D;
	Thu, 16 Jan 2014 21:02:24 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20140116205521.GY2647@odin.tremily.us>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240532>

On Thu, Jan 16, 2014 at 12:55:21PM -0800, W. Trevor King wrote:
> On Thu, Jan 16, 2014 at 12:21:04PM -0800, Junio C Hamano wrote:
> > "W. Trevor King" <wking@tremily.us> writes:
> > > @@ -155,13 +155,31 @@ it contains local modifications.
> > > =20
> > >  update::
> > >  	Update the registered submodules, i.e. clone missing submodules=
 and
> > > -	checkout the commit specified in the index of the containing re=
pository.
> > > -	This will make the submodules HEAD be detached unless `--rebase=
` or
> > > -	`--merge` is specified or the key `submodule.$name.update` is s=
et to
> > > -	`rebase`, `merge` or `none`. `none` can be overridden by specif=
ying
> > > -	`--checkout`. Setting the key `submodule.$name.update` to `!com=
mand`
> > > -	will cause `command` to be run. `command` can be any arbitrary =
shell
> > > -	command that takes a single argument, namely the sha1 to update=
 to.
> > > +	checkout the commit specified in the index of the containing
> > > +	repository.  The update mode defaults to 'checkout', but be
> > > +	configured with the 'submodule.<name>.update' setting or the
> > > +	'--rebase', '--merge', or 'checkout' options.
> >=20
> > Not '--checkout'?
>=20
> Oops, will fix in v5.

Shouldn't this also be `--checkout` (backticks), according to
CodingGuidelines.  This applies to all this options in this patch I
think.

> > > ++
> > > +For updates that clone missing submodules, checkout-mode updates=
 will
> > > +create submodules with detached HEADs; all other modes will crea=
te
> > > +submodules with a local branch named after 'submodule.<path>.bra=
nch'.
> > > ++
> > > +For updates that do not clone missing submodules, the submodule'=
s HEAD
> >=20
> > That is, updates that update submodules that are already checked ou=
t?
>=20
> It's submodules for which $sm_path/.git does not exist.
>=20
> > > +is only touched when the remote reference does not match the
> > > +submodule's HEAD (for none-mode updates, the submodule is never
> > > +touched).  The remote reference is usually the gitlinked commit =
from
> > > +the superproject's tree, but with '--remote' it is the upstream
> > > +subproject's 'submodule.<name>.branch'.  This remote reference i=
s
> > > +integrated with the submodule's HEAD using the specified update =
mode.
> >=20
> > I think copying some motivation from the log message of 06b1abb5
> > (submodule update: add --remote for submodule's upstream changes,
> > 2012-12-19) would help the readers here.
>=20
> I think a brief reference to --remote is best here, mentioning that i=
t
> has something to do with the upstream subproject.  More detail on whe=
n
> you should use --remote should probably go under the docs for --remot=
e
> ;).
>=20
> > A na=C3=AFve expectation from a casual reader of the above would be=
 "The
> > superproject's tree ought to point at the same commit as the tip of
> > the branch used in the submodule (modulo mirroring delays and
> > somesuch),
>=20
> What is the branch used in the submodule?  The remote subproject's
> current submodule.<name>.branch?  The local submodule's
> submodule.<name>.branch (or localBranch) branch?  The submodule's
> current HEAD?
>=20
> > if the repository of the superproject and submodules are maintained
> > properly", which would lead to "when would any sane person need to
> > use --remote in the first place???".
>=20
> --remote is not for sane people (who will probably be pulling from
> withing the submodule itself).  --remote is for folks who track too
> many submodules to care about them as individuals, who just want to
> blindly update to whatever the upstream subproject maintainer has in
> submodule.<name>.branch.  For example, if you are a distribution with
> a hundred submodules tracking all the projects you package, and want
> to bump them all to a their current trunk tip in one fell swoop.
>=20
> > If I am reading 06b1abb5 correctly, the primary motivation behind
> > "--remote" seems to be that it is exactly to help the person who
> > wants to update superproject to satisify the "... are maintained
> > properly" part by fetching the latest in each of the submodules in
> > his superproject in preparation to 'git add .' them.  I still do no=
t
> > think "--remote" was a better way than the "foreach", but that is a
> > separate topic.
>=20
> I agree now ;), the problems with:
>=20
>   $ git submodule foreach 'git pull'
>=20
> are:
>=20
> 1. You may not be on the =E2=80=9Cright=E2=80=9D local branch to begi=
n with, and
> 2. You may not have out-of-tree submodule configs setting up the
>    =E2=80=9Cright=E2=80=9D upstream for that branch.
>=20
> 06b1abb did not address the former, and added a new .gitmodules-level
> submodule.<name>.branch to help with the latter.  I now think all of
> this would be easier if we had automatic submodule local-branch
> checkouts (fixing problem 1) and synchronized out-of-tree submodule
> configs (fixing problem 2).  Fixing problem 1 is all you need if you
> aren't interested in sharing your out-of-tree configs.
>=20
> I think 06b1abb was inspired by =E2=80=9Cwe already have a way to int=
egrate
> changes in the gitlinked commit, we should reuse those to integrate
> other changes=E2=80=9D.  In hindsight, changes in the gitlinked commi=
t are
> really a checkout-time issue, while changes in other places (like the
> remote subproject) are pull-time issues.  Mixing them together was
> more confusing than it was worth.
>=20
> Cheers,
> Trevor
>=20
> --=20
> This email may be signed or encrypted with GnuPG (http://www.gnupg.or=
g).
> For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Pr=
ivacy
