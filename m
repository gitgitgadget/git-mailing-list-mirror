From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Sat, 15 Aug 2009 12:04:35 +0200
Message-ID: <200908151204.36709.trast@student.ethz.ch>
References: <200908101136.34660.trast@student.ethz.ch> <cover.1250164190.git.trast@student.ethz.ch> <20090815065125.GA23068@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 12:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McG8W-0004ZN-Qf
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 12:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbZHOKFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbZHOKFK
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 06:05:10 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:36137 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbZHOKFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 06:05:09 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 12:05:07 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 15 Aug
 2009 12:04:50 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090815065125.GA23068@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125988>

Jeff King wrote:
> > reset -p other		Apply this hunk to index? (**)
> 
> This doesn't make sense to me. For example:
[...]
> The hunk is _already_ in the index. You are really asking to remove it
> from the index. So shouldn't it say something like "Unstage this hunk"
> or "Remove this hunk from the index"?
> 
> Or did you intend to reverse the diff, as with "checkout -p" below?

Yes, sorry :-(  I apparently managed to forget the reversing here and
never noticed.  I'll make a fixed patch 4/6 today.

> > checkout -p HEAD	Discard this hunk from index and worktree? (**)
> 
> Good. I like how it clarifies what is being touched.
> 
> > checkout -p other	Apply this hunk to index and worktree? (**)
> 
> I really expected this to just be the same as the "HEAD" case. That is,
> with "git checkout -p HEAD", you are saying "I'm not interested in these
> bits, discard to return back to HEAD". So if I do "git checkout -p
> HEAD^", that is conceptually the same thing, except going back further
> in time.
> 
> But I guess you are thinking of it as "pull these changes out of
> 'other'", in which case showing the reverse diff makes sense.
> 
> I think this may be a situation where the user has one of two mental
> models in issuing the command, and we don't necessarily know which. So I
> guess what you have is fine, but I wanted to register my surprise.

Well, as I said earlier in the thread I'd hate to reverse the
direction of plain "{reset,checkout,stash} -p" because I want them to
show hunks that match visually.

But then my mental model of "checkout other -- file" is already of the
sort "fetch me the contents of 'file' from 'other'", and I think I use
it about as frequently in a forward as in a backward application.  And
I just felt it would be easier to mentally go over the consequences if
it shoed the diff the other way.

(I'm sufficiently confused about which way is back that I think I'll
just stop saying "backward"...)

> > stash -p		Stash this hunk?
> 
> Getting greedy, is there a reason not to have "stash apply -p" as well?

Should be doable, I'll look at it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
