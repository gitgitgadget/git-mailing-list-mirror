From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH v2 01/11] Documentation: document post-rewrite hook
Date: Wed, 17 Feb 2010 01:18:53 +0100
Message-ID: <201002170118.53639.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch> <8ee58b83a10dcb302a33136768039729fbebae53.1266361759.git.trast@student.ethz.ch> <7vd404zq88.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:19:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhXdA-0003aE-VO
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 01:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933697Ab0BQAS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 19:18:57 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:19480 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933399Ab0BQASz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 19:18:55 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 01:18:54 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 01:18:54 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <7vd404zq88.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140190>

On Wednesday 17 February 2010 00:59:51 Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > +rebase::
> > +	For the 'squash' and 'fixup' operation, all commits that were
> > +	squashed are listed as being rewritten to the squashed commit.
> > +	This means that there will be several lines sharing the same
> > +	'new-sha1'.
> 
> Similar to filter-branch being silent on dropped commits, I presume
> "rebase -i" will stay silent if a pick is removed, or rebase --skip is
> given.

Indeed.  Due to the way that rebase works, it would be a hassle to
report '00..00' (or so) for dropped commits, so I'm not too keen on
going there.  (My intended use-cases don't require it.  Do you have
one that does?)  Documenting this absence wouldn't hurt though.

> I wondered if squash/fixup case wants to distinguish the "primary" commit
> and "follow-up" fixup commits (not a complaint, but thinking-aloud), but I
> think the rebase command itself and this hook have the same amount of
> information needed to guess which one is the primary and which ones are
> the follow ups, so it probably is Ok.

That's what I put in the <extra-info> for :-)

> Is the order of input lines guaranteed in some way?  For example, if I run
> rebase to make A B C into A' and B+C, do we get these three lines:
> 
> 	A -> A'
>         B -> B+C
>         C -> B+C
> 
> in some known order?  If so, should we document that order?

Currently they're in the order that they were rewritten, but what
would the hook learn from that?

I left it unspecified because I wasn't sure we would always have the
list in a specific order (e.g., when reconstructed from a hash map of
rewritings, it's not) but then, keeping the list ordered isn't that
expensive either...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
