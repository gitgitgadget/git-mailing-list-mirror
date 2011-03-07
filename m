From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Mon, 07 Mar 2011 18:50:34 +0000
Message-ID: <1299523834.1835.17.camel@walleee>
References: <20110305195020.GA3089@sigill.intra.peff.net>
	 <20110305200010.GB32095@sigill.intra.peff.net>
	 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
	 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
	 <20110307161758.GB11934@sigill.intra.peff.net>
	 <1299518898.3024.10.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 19:50:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwfWB-0006eZ-AH
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 19:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab1CGSuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 13:50:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51338 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1CGSut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 13:50:49 -0500
Received: by wyg36 with SMTP id 36so4452025wyg.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=2AtdNvS9qxSO1ZeP45LjRYHda55Gr+jBP95SVqLqqzg=;
        b=L7pjXCBHV93s6J1/yUFDsU/pWPxcz5gePSzWSS2csM6jx6iY0AZoCiw4jLLsDaEeYc
         tROU7fnaTTtgC2RXcREVj7aJ64kP4T1QgMPQ0mpwqLDEm4wzW6GYi67Njma69Epx6XsB
         7UoOJEzRFSZuQAkD9LF5mCYu8q2olAUvD7+MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=T8wNsUHIXTWDKnN+3wll3PjNgStxE5i5He4Z68fdPP2bz7qyIf99Gt/v62/2Nz/IvJ
         wgM0H5EXMIHzLOUcCYJ7yYujujRsy59r3LankMoYVP9k04T0EkkizKjL00RUAGnxt7Nr
         5BFpvcB/yPHhXvLQ3sYNpvGRkiz3q0DEX8VLw=
Received: by 10.227.147.20 with SMTP id j20mr3758253wbv.159.1299523847710;
        Mon, 07 Mar 2011 10:50:47 -0800 (PST)
Received: from [192.168.0.2] (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id t5sm1416169wes.9.2011.03.07.10.50.44
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 10:50:45 -0800 (PST)
In-Reply-To: <1299518898.3024.10.camel@wpalmer.simply-domain>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168602>

On Mon, 2011-03-07 at 17:28 +0000, Will Palmer wrote:
> On Mon, 2011-03-07 at 11:17 -0500, Jeff King wrote:
> > On Sun, Mar 06, 2011 at 09:54:01PM +0000, Will Palmer wrote:
> > 
> > > On Sat, Mar 5, 2011 at 8:00 PM, Jeff King <peff@peff.net> wrote:
> > > > You can now do "%ad(short)" or similar (using any format
> > > > that works for --date). This makes some formats like %aD
> > > > redundant (since you can do "%ad(rfc)"), but of course we
> > > > keep them for compatibility.
> > > >
> > > 
> > > The more I see long formats like this, the more I think it would make
> > > sense to make formats %(likeThis), the way for-each-ref does.
> > > Ideally, these formats could even be unified, at some point.
> > 
> > Yeah, I totally agree. One problem is that everytime an extended format
> > comes up it gets bikeshedded to death as everybody mentions their
> > favorite format and/or feature, and then nobody codes it.
> > 
> > > I tried this a long while ago, as part of my attempt to make all
> > > pre-defined formats work in terms of format strings, but that turned
> > > into too much of a bloated mess to bother submitting. I don't know
> > > if there's enough interest in such a thing to justify trying again (or to
> > > justify rebasing the bloated version, cleaning it up and submitting it
> > > as-is, for that matter)
> > 
> > I think there is interest. I'd be curious to see what you have. A few
> > days ago, when working on this series, I tried to make a
> > minimally-invasive change to allow "%(ad)" to work alongside "%ad", with
> > a generic arguments format like %(ad:flag:key=value). Which would allow
> > existing shorthand, for-each-ref-style %(refname:short), and leave room
> > for arbitrary extension of each placeholder (alongside more
> > human-readable placeholder names).
> > 
> > The problem I ran into was the internal code interface. We parse the
> > format string each time we expand it. This works OK for simple
> > printf-like stuff. But ideally we can handle something like:
> >   %(ad:key=embedded\:colon:key2=embedded\)paren)
> > 
> > It's hard to make a nice interface to that which doesn't involve copying
> > the quoted string out into a non-quoted version. But we don't want to be
> > doing a bunch of parsing and allocation per-expansion. It's slow, and
> > this expansion happens inside a fairly tight loop in many cases (e.g.,
> > during rev-list).
> 
> Exactly the problem I ran into.
> 
> > 
> > So I think the whole thing needs to be factored into two phases: a
> > parsing phase where we build some internal parse tree, and then an
> > expansion phase where we walk the parse tree for each commit (or ref, or
> > whatever is being expanded).
> 
> And exactly the solution I implemented.
> At the time, it felt like needless bloat, but perhaps the problem has
> gotten to the point where it's worth it.
> 
> I assume rebasing what I have right now would be problematic, but it
> sounds like it's about time to give it another go.
> 
> The code was ever only in a "proof of concept" stage- I had it working
> for single revisions, but in a way which wasn't yet compatible with any
> of the other parts of log, iirc.
> 
> I'll try getting a rebase started tonight, but in the mean time
> I /think/ the latest code is at 
> https://github.com/wpalmer/git/tree/pretty/parse-format-poc
> 

I'm home now, and apparently that should have been:
https://github.com/wpalmer/git/tree/pretty/parse-format

I assume the code is very hard to follow, as it was pretty much written
with the mindset of "get it done now, fix it later". Looking into it
again, I see that part of the reason I abandoned it was not being able
to determine a good way to split things into logical commits. It's
almost entirely an "everything works or nothing works" change.

There was of course one section of it that I managed to split out, which
is the "format aliases" code, already merged. I assume that this code
has absolutely never been used since inclusion, as what it was actually
intended to support was never finished.

To see it in action, try:
 ./git log --pretty='%h%(opt-color ? %Cred) foo'

uncommenting the //parts_debug(parsed, 0);    line in pretty.c will show
off the built format tree.

> Warning: quite ugly.
> 
> If you have comments, I would not mind hearing them (though off-list
> might be better)
> 
> > 
> > > Point is: we're going to keep having more and more format options,
> > > I think that's a given. At some point, these short mnemonics will just
> > > stop making sense, and it makes sense to have an escape plan when
> > > that happens.
> > 
> > Agreed. And I think it is possible to do it in a backwards-compatible
> > way; support %(longname:options) for everything, and keep short-hands
> > like %h and %ad for existing elements without options.
> > 
> > -Peff
> 
> 
