From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Thu, 8 Oct 2009 19:10:07 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20091008151007.GA15098@tugrik.mns.mnsspb.ru>
References: <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 17:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvukC-00029n-Ql
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 17:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbZJHPLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Oct 2009 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbZJHPLh
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 11:11:37 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:60462 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbZJHPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 11:11:36 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1Mvudp-0005qC-3B; Thu, 08 Oct 2009 19:10:53 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1Mvud5-0003vo-Ob; Thu, 08 Oct 2009 19:10:07 +0400
Content-Disposition: inline
In-Reply-To: <20091008150206.GD9261@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129695>

On Thu, Oct 08, 2009 at 08:02:06AM -0700, Shawn O. Pearce wrote:
> Kirill Smelkov <kirr@mns.spb.ru> wrote:
> > diff --git a/contrib/completion/Makefile b/contrib/completion/Makef=
ile
> > new file mode 100644
> > index 0000000..a0fbb66
> > --- /dev/null
> > +++ b/contrib/completion/Makefile
> > @@ -0,0 +1,11 @@
> > +all	: git-completion.bash
> > +
> > +
> > +git-completion.bash: git-completion.bash.in git-completion.bash.ge=
nerate
> > +	# Generate completions for binaries we have just built
> > +	PATH=3D"$(shell pwd)/..:$$PATH" ./git-completion.bash.generate
>=20
> Is only one .. enough?  Isn't that putting us into the contrib
> directory, and therefore not finding the 'git' we just compiled?
>=20
> I'm also concerned that git-completion.bash.generate requires
> bash to compile the completion for bash.  IMHO, if we are building
> this code at compile time we shouldn't assume bash is available.
> What if this is a sandboxed build environment using another shell
> and /bin/bash isn't installed?
>=20
> I think the git-completion.bash.generate code needs to be a bit
> more sh agnostic than the completion routines themselves are.
>=20
> > +# pregenerated stuff (to save load time)
> > +__git_merge_strategylist=3D__GIT_MERGE_STRATEGYLIST
> > +__git_all_commandlist=3D__GIT_ALL_COMMANDLIST
> > +__git_porcelain_commandlist=3D__GIT_PORCELAIN_COMMANDLIST
>=20
> This also makes testing the completion a bit more difficult, now
> we have to build it before we can load it, making the testing cycle
> actually be:
>=20
>   make && . git-completion.bash
>=20
> We probably should place a quick comment here to remind folks that
> they need to build the script in order to test it properly.

Agree with everything and thanks. Will reroll tommorow.

=D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB
