From: Jeff King <peff@peff.net>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Wed, 10 Feb 2010 00:29:02 -0500
Message-ID: <20100210052902.GA28832@coredump.intra.peff.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <2cfc40321002062136q64f832aesd979c9cb22f3612@mail.gmail.com>
 <20100207193320.GB3185@coredump.intra.peff.net>
 <7v8wb4aj4m.fsf@alter.siamese.dyndns.org>
 <20100210050902.GD28526@coredump.intra.peff.net>
 <7vvde5irzz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf59l-0004M5-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab0BJF3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:29:01 -0500
Received: from peff.net ([208.65.91.99]:40081 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab0BJF3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:29:00 -0500
Received: (qmail 31244 invoked by uid 107); 10 Feb 2010 05:29:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:29:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:29:02 -0500
Content-Disposition: inline
In-Reply-To: <7vvde5irzz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139489>

On Tue, Feb 09, 2010 at 09:23:12PM -0800, Junio C Hamano wrote:

> > Hmm. OK, I see the point of Jakub's message a bit more now. You want to
> > create a new view, inconsistent with that of either Alice or Bob (that
> > is, you have taken snippets of each's state, but you cannot in good
> > faith represent this as a history merge, because your state should not
> > supersede either of theirs).
> 
> In the message you are quoting, I am not interested in creating a narrowed
> view.  If I cannot resolve conflicts between Alice and Bob in a merge in
> the contents space, I would ask either of them (because they are more
> familiar with the area) to do the merge.  I however was unsure if asking
> the same for merges in the notes space is a reasonable thing to do.

No, I don't see a problem with asking them to do it. If you are all
collaborating as a group, it is something they will need to do
eventually anyway. If they are not, and you are an intermediary, you are
eventually going to share Alice's history with Bob and vice versa. So
you pull from Alice, then say to Bob: "I have some history but I'm not
sure of the correct merge. Pull from me and merge please". The only real
problem is if you _never_ want to share the history between the two of
them. In that case, I think you should keep two parallel branches of
history (refs/notes/alice and refs/notes/bob), and then squash the trees
at run-time (either concatenating them, or favoring one over the other
in the case of conflicts).

-Peff
