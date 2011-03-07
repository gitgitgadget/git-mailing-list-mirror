From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Mon, 07 Mar 2011 17:28:18 +0000
Message-ID: <1299518898.3024.10.camel@wpalmer.simply-domain>
References: <20110305195020.GA3089@sigill.intra.peff.net>
	 <20110305200010.GB32095@sigill.intra.peff.net>
	 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
	 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
	 <20110307161758.GB11934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 07 18:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PweEP-000582-C4
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 18:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab1CGR2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 12:28:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39466 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1CGR2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 12:28:23 -0500
Received: by wyg36 with SMTP id 36so4370304wyg.19
        for <git@vger.kernel.org>; Mon, 07 Mar 2011 09:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=g9ARPuSh/SYeFbx4ar5dgk6in2CMwGVBclHO2CoZ+Wg=;
        b=baDeSlvNT8ZpmEZElHFoUAu5pdtbuhyZdQwFmQWGrigYfXaykksaXxPM6B249SpQIv
         3d9B9O95I9t6xzD7wdESFF9GccIzv7x17kDW7dScUxPU/2Vic/tpb2pKYAl1F+tx/b0x
         cemJNlOOspHEIH9TxJpgt6WoNWB7Pl1JfPfcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Yk2bfEKXvJ7mDtmlDS04SgIb32c9Ylz6LDS/Nlvz3ZhiN9OFzDDLAHsGHoCvt9yNOL
         4y4zMLmR5ayfU2ejdf5tH0v7L2oqmEU3LD6Dyu8s5w7UwV7vR5JNQzTZIEjMPxa9a+lV
         j93Jjpq+cxeoBNAPbvTzyrjMS6FqXLYpPyapw=
Received: by 10.227.183.133 with SMTP id cg5mr2658377wbb.49.1299518902464;
        Mon, 07 Mar 2011 09:28:22 -0800 (PST)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id r80sm1378305wei.39.2011.03.07.09.28.20
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Mar 2011 09:28:21 -0800 (PST)
In-Reply-To: <20110307161758.GB11934@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168598>

On Mon, 2011-03-07 at 11:17 -0500, Jeff King wrote:
> On Sun, Mar 06, 2011 at 09:54:01PM +0000, Will Palmer wrote:
> 
> > On Sat, Mar 5, 2011 at 8:00 PM, Jeff King <peff@peff.net> wrote:
> > > You can now do "%ad(short)" or similar (using any format
> > > that works for --date). This makes some formats like %aD
> > > redundant (since you can do "%ad(rfc)"), but of course we
> > > keep them for compatibility.
> > >
> > 
> > The more I see long formats like this, the more I think it would make
> > sense to make formats %(likeThis), the way for-each-ref does.
> > Ideally, these formats could even be unified, at some point.
> 
> Yeah, I totally agree. One problem is that everytime an extended format
> comes up it gets bikeshedded to death as everybody mentions their
> favorite format and/or feature, and then nobody codes it.
> 
> > I tried this a long while ago, as part of my attempt to make all
> > pre-defined formats work in terms of format strings, but that turned
> > into too much of a bloated mess to bother submitting. I don't know
> > if there's enough interest in such a thing to justify trying again (or to
> > justify rebasing the bloated version, cleaning it up and submitting it
> > as-is, for that matter)
> 
> I think there is interest. I'd be curious to see what you have. A few
> days ago, when working on this series, I tried to make a
> minimally-invasive change to allow "%(ad)" to work alongside "%ad", with
> a generic arguments format like %(ad:flag:key=value). Which would allow
> existing shorthand, for-each-ref-style %(refname:short), and leave room
> for arbitrary extension of each placeholder (alongside more
> human-readable placeholder names).
> 
> The problem I ran into was the internal code interface. We parse the
> format string each time we expand it. This works OK for simple
> printf-like stuff. But ideally we can handle something like:
>   %(ad:key=embedded\:colon:key2=embedded\)paren)
> 
> It's hard to make a nice interface to that which doesn't involve copying
> the quoted string out into a non-quoted version. But we don't want to be
> doing a bunch of parsing and allocation per-expansion. It's slow, and
> this expansion happens inside a fairly tight loop in many cases (e.g.,
> during rev-list).

Exactly the problem I ran into.

> 
> So I think the whole thing needs to be factored into two phases: a
> parsing phase where we build some internal parse tree, and then an
> expansion phase where we walk the parse tree for each commit (or ref, or
> whatever is being expanded).

And exactly the solution I implemented.
At the time, it felt like needless bloat, but perhaps the problem has
gotten to the point where it's worth it.

I assume rebasing what I have right now would be problematic, but it
sounds like it's about time to give it another go.

The code was ever only in a "proof of concept" stage- I had it working
for single revisions, but in a way which wasn't yet compatible with any
of the other parts of log, iirc.

I'll try getting a rebase started tonight, but in the mean time
I /think/ the latest code is at 
https://github.com/wpalmer/git/tree/pretty/parse-format-poc

Warning: quite ugly.

If you have comments, I would not mind hearing them (though off-list
might be better)

> 
> > Point is: we're going to keep having more and more format options,
> > I think that's a given. At some point, these short mnemonics will just
> > stop making sense, and it makes sense to have an escape plan when
> > that happens.
> 
> Agreed. And I think it is possible to do it in a backwards-compatible
> way; support %(longname:options) for everything, and keep short-hands
> like %h and %ad for existing elements without options.
> 
> -Peff
