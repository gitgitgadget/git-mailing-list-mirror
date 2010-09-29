From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH v3 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Wed, 29 Sep 2010 15:44:19 +0400
Message-ID: <20100929114419.GA11819@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru> <66d4603c7e21561557f612690d6196e7ae0b38f9.1285351816.git.kirr@landau.phys.spbu.ru> <7vsk0vyriw.fsf@alter.siamese.dyndns.org> <20100928120722.GA29525@landau.phys.spbu.ru> <7vlj6lubg1.fsf@alter.siamese.dyndns.org> <20100928155845.GA10271@sigill.intra.peff.net> <20100928161210.GA31036@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 13:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0v5g-0002bk-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 13:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0I2LoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 07:44:21 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:43619 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab0I2LoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 07:44:20 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 53FC9FF718; Wed, 29 Sep 2010 15:44:19 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100928161210.GA31036@landau.phys.spbu.ru>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157559>

On Tue, Sep 28, 2010 at 08:12:10PM +0400, Kirill Smelkov wrote:
> On Tue, Sep 28, 2010 at 11:58:45AM -0400, Jeff King wrote:
> > On Tue, Sep 28, 2010 at 08:36:46AM -0700, Junio C Hamano wrote:
> > 
> > > >> >  cat >helper <<'EOF'
> > > >> >  #!/bin/sh
> > > >> > -sed 's/^/converted: /' "$@" >helper.out
> > > >> > +grep -q '^bin: ' "$@" || { echo "E: $@ is not \"binary\" file" 1>&2; exit 1; }
> > > >>  ...
> > > > ...
> > > > I too think (1) is right. It was just that originally there was $@
> > > > (which I now understand was wrong).
> > > 
> > > Well, the original's use of "$@" is perfectly fine; it would do the right
> > > thing with one argument, of course, but it would do the right thing with
> > > more than one, too.  On the other hand, your use inside "echo" is not.
> > 
> > Moreover, the use of "grep" is wrong. Giving it two files, one of which
> > has "^bin: " and one of which doesn't, will silently accept the latter.
> > If it's going to handle multiple files, it must be a for-loop (or you
> > could invert "grep -qv", but I think that might be getting too clever to
> > remain readable).
> > 
> > Which is why I suggested just dropping the t4042 bit, which is the only
> > part that actually needs to handle multiple arguments. The other ones
> > can just switch to using "$1". The helper script is simple enough that
> > there is no need for them to share the same code.
> 
> Let's do whatever is appropriate. I just wanted to be consitent, but I'm
> doing mistakes becase I'm overworked and have time pressure on other
> tasks. (sorry).
> 
> If it would be more convenient to just drop t4042 - let's do it.

Update:

I've removed t4042 bits from this series, and also squashed $@ -> $1
conversion in the first patch. The whole thing is reposted as v5.

Sorry if maybe there are some bugs still left...
Kirill
