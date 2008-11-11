From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 10 Nov 2008 20:22:10 -0500
Message-ID: <20081111012210.GA26920@coredump.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com> <7vljvr2hjn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Symonds <dsymonds@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 02:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzhyb-0001Yd-5v
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 02:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbYKKBWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYKKBWN
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 20:22:13 -0500
Received: from peff.net ([208.65.91.99]:2236 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461AbYKKBWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 20:22:13 -0500
Received: (qmail 10062 invoked by uid 111); 11 Nov 2008 01:22:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Nov 2008 20:22:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 20:22:10 -0500
Content-Disposition: inline
In-Reply-To: <7vljvr2hjn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100609>

On Mon, Nov 10, 2008 at 05:11:08PM -0800, Junio C Hamano wrote:

> I doubt "Is there any further discussion on THIS ONE ALONE?" is a valid
> question to ask.  What are the other command options we are introducing
> synonyms for?  There is no need for two variants of staged for "diff" (you
> don't have --staged-too option but instead you give a committish argument,
> e.g. HEAD), so --staged-only can be abbreviated to --staged without
> risking any ambiguity.  But at least a fully-spelled-out --staged-only
> should also be accepted, shouldn't it?

I'm not sure that "staged-only" really makes sense here. In modification
commands like "apply", it is about "do this one thing to the working
tree, to both the index and the working tree, or to just the index".

But here, you are selecting two points for comparison. So while it is
tempting to say "the default for diff just happens to work on the index
and the working tree, so we don't need --staged-too", I don't think that
is right. Doing "--staged-only" is _not_ about saying "do the thing we
would have done to the working tree and the index to just the index." It
is about "use HEAD as one of the points instead of the working tree
(and reverse the order of points :) )".

To me, what is really being asked with "git diff --staged" (or "git
diff --cached" for that matter), is "what is staged?" That is, diff is
not about an operation on a data location (like HEAD, index, or working
tree), but rather an operatoin on a data _relationship_. So you ask for
"what is not staged" (the relationship between index and working tree),
"what is staged" (the relationship between HEAD and index), "what is
different between the working tree and HEAD", or "what is different
between these two trees".

-Peff
