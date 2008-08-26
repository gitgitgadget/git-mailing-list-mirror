From: Al Viro <viro@hera.kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 19:22:55 +0000
Message-ID: <20080826192255.GA16066@hera.kernel.org>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org> <20080826185548.GA7559@hera.kernel.org> <alpine.LFD.1.10.0808261202280.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:25:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4AB-0001SG-I1
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758114AbYHZTYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758121AbYHZTYD
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:24:03 -0400
Received: from hera.kernel.org ([140.211.167.34]:40226 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757458AbYHZTYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:24:01 -0400
Received: from hera.kernel.org (IDENT:U2FsdGVkX19q3hS8P5a8y8OrwE3bwBB78RfAhuZevvg@localhost [127.0.0.1])
	by hera.kernel.org (8.14.2/8.14.2) with ESMTP id m7QJMuRR020994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 19:22:57 GMT
Received: (from viro@localhost)
	by hera.kernel.org (8.14.2/8.13.1/Submit) id m7QJMtKW020972;
	Tue, 26 Aug 2008 19:22:55 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261202280.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.3/8093/Tue Aug 26 16:01:30 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (hera.kernel.org [127.0.0.1]); Tue, 26 Aug 2008 19:22:58 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93804>

On Tue, Aug 26, 2008 at 12:04:51PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 26 Aug 2008, Al Viro wrote:
> > 
> > Well, to be fair, "man git-add for git add is rather unconventional" is
> > a valid point...
> 
> On the other hand:
> 
>  - "man" simply cannot currently handle "man git add", even though there's 
>    been some noise to teach it.
> 
>  - you can use "git help add" instead, since git itself does understand 
>    this. It will just go "man git-add" for you, so that your fingers don't 
>    have to type that dash ;)

Yeah...  Actually, it all boils down to YAsrbBogosity.  Namely, rather
dumb conventions for $PATH; it would be much saner if the things worked
as for $CDPATH.  That is,
/<whatever> -> use that as-is
./<whatever> -> use that as-is
../<whatever> -> use that as-is
<anything else> -> try to use <path element>/<anything else> for each
path element.

The difference, of course, is that things like git/subcommand would end up
as /usr/bin/git/subcommand, nicely gathering related stuff together in
obvious place and keeping the size of /usr/bin down.  Without the holy
wars about irregular syntax, etc., etc.

Not that it had been the worst offense against the sanity and taste that
went into sh(1)...
