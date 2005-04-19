From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 16:21:56 -0700
Organization: http://madrabbit.org/
Message-ID: <1113952916.29444.60.camel@orca.madrabbit.org>
References: <20050418210436.23935.qmail@science.horizon.com>
	<1113869248.23938.94.camel@orca.madrabbit.org>
	<42645969.2090609@qualitycode.com>
	<1113874931.23938.111.camel@orca.madrabbit.org>
	<4264677A.9090003@qualitycode.com>
	<1113950442.29444.31.camel@orca.madrabbit.org>
	<42658D95.7020404@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Kevin Smith <yarcs@qualitycode.com>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 20 01:18:39 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1yx-0002nM-1d
	for gcvdd-darcs-devel@m.gmane.org; Wed, 20 Apr 2005 01:18:15 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DO22a-0004f8-4t; Tue, 19 Apr 2005 19:22:00 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]
	helo=madrabbit.org) by abridgegame.org with esmtp (Exim 4.50)
	id 1DO22X-0004X2-M2
	for darcs-devel@darcs.net; Tue, 19 Apr 2005 19:21:57 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id A3BD44C0A1B; Tue, 19 Apr 2005 16:21:57 -0700 (PDT)
To: Tupshin Harper <tupshin@tupshin.com>
In-Reply-To: <42658D95.7020404@tupshin.com>
X-Mailer: Evolution 2.2.1.1 
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

On Tue, 2005-04-19 at 16:00 -0700, Tupshin Harper wrote:
> Ray Lee wrote:
> 
> >Here's where we disagree. If you checkpoint your tree before the
> >replace, and immediately after, the only differences in the
> >source-controlled files would be due to the replace.
> >
> This is assuming that you only have one replace and no other operations 
> recorded in the patch. If you have multiple replaces or a replace and a 
> traditional diff  recorded in the same patch, then this is not true.

I had a precondition on my argument (not quoted), that the code was
checkpointed before and after. Obviously, a large set of changes in one
patch is a problem. However, a darcs replace is (effectively) a commit
on its own, so I was limiting myself to the same situation under a
different system.

> A more fundamental problem comes back to intent. If I have a file
> "foo" before:
> a1
> a2
> and after:
> b1
> b2
> is that a "replace [_a-zA-Z0-9] a b foo" patch, or is that a
> -a1
> -a2
> +b1
> +b2
> patch?

Okay, so in reading the online darcs manual (yet) again, I now see that
it allows regular expressions for the match and replace, which means
multiple unique tokens could change atomically. (Does anyone actually
*use* regexes? Sounds like a cannon that'd be hard to aim.)

Regardless, I only care about code, not free text. If it's in a language
that doesn't do some use-'em-as-you-need-'em duck typing spiel
(<cough>python</cough), then the context of your patch (namely, the
file) already has those tokens somewhere in them. And I bet that if
*you* looked at that file, you could tell if it was a replace or a mere
textual diff. Am I wrong?

> Note that this comes down to heuristics, and no matter what you 
> use, you will be wrong sometimes,  *and* the choice that is made can 
> substantively affect the contents of the repository after additional 
> patches are applied.

Unless I'm missing something, the darcs replace patch can already do the
wrong thing. If I do a replace patch on a variable introduced in a local
tree, then do a darcs replace on it before committing it to a shared
repository, and coder B introduces a variable of the same original name
in my copy, then there's a chance that the replace patch will
incorrectly apply upon his newly introduced variable. No?

> It's provable that you can not.

I'm still not seeing the problem, at least when it comes to ANSI C.

Ray
