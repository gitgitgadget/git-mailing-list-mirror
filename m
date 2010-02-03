From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 14:48:35 -0800
Message-ID: <20100203224835.GK14799@spearce.org>
References: <20100203174041.GC14799@spearce.org> <d411cc4a1002031158k3e50db30l3f7d73d49e3dad23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nco1c-0002aP-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab0BCWsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 17:48:40 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:60882 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab0BCWsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:48:39 -0500
Received: by yxe27 with SMTP id 27so1632794yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 14:48:38 -0800 (PST)
Received: by 10.101.166.27 with SMTP id t27mr311731ano.172.1265237318408;
        Wed, 03 Feb 2010 14:48:38 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 22sm2638928yxe.39.2010.02.03.14.48.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 14:48:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <d411cc4a1002031158k3e50db30l3f7d73d49e3dad23@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138913>

Scott Chacon <schacon@gmail.com> wrote:
> On Wed, Feb 3, 2010 at 9:40 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Today I came across this "bug fix" [1,2] in Dulwich, which is
> > claiming to be a pure-Python implementation of Git.
> >
> > I haven't spoken with Jelmer Vernooij directly about it, but after
> > some indirect email through a 3rd party, it seems he might be under
> > the impression that this really is a bug in Dulwich, because "other
> > git implementations do it".
> 
> At the risk of pissing you off for the second time in as many days,
> this is entirely my fault.

Apparently, s**t happens is a good phrase.  One I need to learn.

> I was having a beer with Jelmer in Wellington a few weeks ago

And... beer doesn't promote clear thinking.

All is forgiven.  As is yesterday's remark about not telling me
sooner about a JGit bug.  You really didn't do anything bad, I
just woke up on the wrong side of the bed the past couple of days,
and sort of went off...

Sorry.  :-\

> Anyhow, I was saying that _technically_ you can artificially write
> extra headers into the commit object (though at the time Dulwich
> didn't support reading them because of how it parsed commit objects -
> I believe it would actually explode if it saw something it didn't
> expect).  I said I was still going to keep the metadata in my
> implementation in the message, but he was very interested in hiding
> his in the commit headers.

Yea, everyone wants to hide that extra metadata.  I never get why.
Even in SVN.  Why wouldn't I want to see the bug(s) fixed by
a commit?  Difference of opinion.  I also happen to prefer the
color blue.  Dammit, everyone should prefer blue.

> To my defense, we (you and I, Shawn)
> talked about this at the GitTogether this year and you and a few
> others told me that CGit would not blow up but would just ignore them,
> which is fine for his purposes.  I certainly did not get the
> impression from that short discussion that this was something to be
> absolutely avoided, but rather that it just wasn't really encouraged
> or explicitly supported.

Sorry.  I've held this same opinion as Junio and Nico have expressed
in this thread, that although we ignore extra headers, its only to
leave us an escape hatch in case we add something like "encoding"
in the future.  Adding encoding was almost a nightmare because we
didn't have that escape hatch.

I also hold the opinion that the C implementation is correct,
and everyone else is wrong.  Even JGit.  Unless its a bug in the
C implementation, in which case the bug fix is correct.  :-)

Which in this case means, if the C implementation doesn't give
the user plumbing to do something (aside from using git mkobject),
you really should think twice before doing it.

So I apologize if I gave you the wrong impression at the GitTogether.
I claim stupidity as my only defense.

> Sorry.  So, for future reference, though CGit _can_ handle it, don't?

C Git won't choke if there are extra headers.

But we _really_ don't want them.  And C Git won't be writing any new
headers anytime soon.  I think we're more likely to shift the entire
hashing scheme to SHA-512 or something before we add a new header.

-- 
Shawn.
