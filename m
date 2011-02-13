From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 11:31:56 +0100
Message-ID: <20110213103156.GB4202@atjola.homenet>
References: <4D578B6D.9090803@inria.fr>
 <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Imbert <matthieu.imbert@inria.fr>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoZFX-0001Jl-D1
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab1BMKcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 05:32:11 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:46649 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754266Ab1BMKcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:32:09 -0500
Received: (qmail invoked by alias); 13 Feb 2011 10:32:07 -0000
Received: from i59F55C89.versanet.de (EHLO atjola.homenet) [89.245.92.137]
  by mail.gmx.net (mp066) with SMTP; 13 Feb 2011 11:32:07 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+hI31hcnahtymcGoxfksNpC2LrTsnYfbMV09XUnF
	vYNeE1bmDEoJYa
Content-Disposition: inline
In-Reply-To: <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166660>

On 2011.02.13 10:17:48 +0100, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> Also because you specified --tags you're only getting the tags on "gi=
t
> fetch"

That looks like a bug to me.

It's ok for fetch to treat --tags like a refspec and to have it overrid=
e
the defaults from the config when the user manually specifies it on the
command line. But when it is part of the default configuration it shoul=
d
add to remote.<name>.fetch, not override it.

IOW with this configuration:
remote.foo.url =3D git://host/repo.git
remote.foo.fetch =3D +refs/heads/*:refs/remotes/foo/*
remote.foo.tagopt =3D --tags

"git fetch foo" acts like:

git fetch --tags git://host/repo.git

instead of

git fetch --tags git://host/repo.git +refs/heads/*:refs/remotes/foo/*

And I'd argue that the latter makes a lot more sense. Also because the
former could always be achieved by dropping the remote.foo.fetch config
setting.

Thoughts?

Bj=F6rn
