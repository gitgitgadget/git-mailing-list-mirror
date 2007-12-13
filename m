From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 13:28:41 -0500
Message-ID: <1197570521.28742.0.camel@hinata.boston.redhat.com>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	 <20071213090604.GA12398@artemis.madism.org>
	 <20071213091055.GA5674@coredump.intra.peff.net>
	 <20071213093536.GC12398@artemis.madism.org>
	 <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	 <20071213180347.GE1224@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:29:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2soo-0007J5-Fu
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 19:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756445AbXLMS3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 13:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbXLMS3f
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 13:29:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbXLMS3f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 13:29:35 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBDISlot031909;
	Thu, 13 Dec 2007 13:28:47 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBDISluE009565;
	Thu, 13 Dec 2007 13:28:47 -0500
Received: from [192.168.1.100] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBDISkSC017446;
	Thu, 13 Dec 2007 13:28:46 -0500
In-Reply-To: <20071213180347.GE1224@artemis.madism.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68183>

On Thu, 2007-12-13 at 19:03 +0100, Pierre Habouzit wrote:
> On Thu, Dec 13, 2007 at 05:40:23PM +0000, Junio C Hamano wrote:
> > Pierre Habouzit <madcoder@debian.org> writes:
> > 
> > > In fact we have kind of the issue for every single optional argument out
> > > there:
> > >
> > > $ git describe --abbrev HEAD
> > > error: option `abbrev' expects a numerical value
> > > [...]
> > >
> > >   *ouch*
> > >
> > > So I believe that with optional arguments we must change the way we do
> > > things, and that we _must_ enforce the argument to be sticked in that
> > > case.
> > 
> > I think "Must" is a bit too strong an expression.
> > 
> > 	git describe --abbrev 7 HEAD
> >         git describe --abbrev HEAD
> >         git describe --abbrev=HEAD
> > 	git describe --abbrev=7 HEAD
> > 	git describe --abbrev
> > 
> > The --abbrev parser in this case could be asked with this question: "You
> > are on the command line.  There is a token after you.  Is it your
> > parameter?".
> 
>   I thought of that, but it's really convoluted and can definitely lead
> to very subtle issues. The number of git commands with optional
> arguments is quite low, mostly due to legacy, I don't expect _new_
> commands to take optional arguments. I don't really like the ambiguity
> it creates, and in some cases you just won't be able to disambiguate at
> all. Here it looks nice because --abbrev takes an integer argument, and
> it's likely that no branch nor reference names will be only made of
> digits. Though for commands taking an optional string[0] argument this is
> way more fishy.

My 
