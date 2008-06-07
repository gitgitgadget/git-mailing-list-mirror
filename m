From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg pull/rebase
Date: Sat, 7 Jun 2008 21:08:48 +0200
Message-ID: <20080607190848.GA7853@diana.vm.bytemark.co.uk>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk> <m3y75hw3an.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 21:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K53nt-00018q-Ou
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 21:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbYFGTI5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYFGTI4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 15:08:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2003 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYFGTI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 15:08:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K53mS-0002EP-00; Sat, 07 Jun 2008 20:08:48 +0100
Content-Disposition: inline
In-Reply-To: <m3y75hw3an.fsf@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84224>

On 2008-06-07 10:41:41 -0700, Jakub Narebski wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> >   * Just one command, stg pull. stg rebase is removed.
>
> And I would have to learn to use other command (I use very
> frequently the following sequence: git remote update && stg rebase
> <branch>)? Not nice.

Right. We could keep "stg rebase" for backwards compatibility. (It
would mean stg pull --rebase.) I like to complain about the too-large
number of stg subcommands, but upset users are even less desirable ...
:-)

> I already have to use two commands: "stg refresh && stg edit" to
> make a change which affects how commit message is written, instead
> of simplier "stg refresh --edit".

Yes, sorry about that. You have pointed it out before, and I've been
meaning to fix it.

> >    2. Depending on the configuration (overridable by the
> >       --fast-forward, --rebase, and --merge options), one of these
> >       three things happen:
>
> Couldn't then "stg rebase" be 'internal alias' to "git pull
> --rebase"?

Absolutely.

> >   * The default action is to fast-forward, which is probably what
> >     most users want -- merge is very likely to do the wrong thing,
> >     and rebase can lose changes.
>
> Unless you want to rebase on top of different branch, for example
> moving stack from 'master' to 'next', or when you work on top of
> branch which doesn't fast-forward, like 'pu' in git repository.

Yes, definitely. rebase would stay a "first-class citizen". But I
really do think that having fast-forward as an option is nice; in many
cases you build on top of a non-rebasing branch, and having the tool
verify that you don't lose commits is a good thing.

And when the user says just "stg pull" (having configured nothing)
it's probably best to default to the simplest and safest of the three:
fast-forward. If the user wants "rebase", it'd be available either
with the command-line option or with a (per-branch) config file
setting.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
