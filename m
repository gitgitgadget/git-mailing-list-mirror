From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 14:39:01 -0800
Message-ID: <20100203223901.GJ14799@spearce.org>
References: <20100203174041.GC14799@spearce.org> <1265230702.7429.54.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 23:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnsQ-0006Hb-SF
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab0BCWjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 17:39:10 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:53798 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab0BCWjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:39:05 -0500
Received: by gxk24 with SMTP id 24so2322187gxk.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 14:39:04 -0800 (PST)
Received: by 10.150.59.14 with SMTP id h14mr751539yba.299.1265236744280;
        Wed, 03 Feb 2010 14:39:04 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 5sm2647081yxd.35.2010.02.03.14.39.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 14:39:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265230702.7429.54.camel@ganieda>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138912>

Jelmer Vernooij <jelmer@samba.org> wrote:
> On Wed, 2010-02-03 at 09:40 -0800, Shawn O. Pearce wrote:
> > 
> > I haven't spoken with Jelmer Vernooij directly about it, but after
> > some indirect email through a 3rd party, it seems he might be under
> > the impression that this really is a bug in Dulwich, because "other
> > git implementations do it".
>
> If you have concerns like this in the future, please don't hesitate to
> contact me directly.

OK.

> I don't follow the git list because it's a
> high-volume list where pretty much all traffic is irrelevant to me. The
> only reason I became aware of this thread was because Sverre CC'ed me.

I probably should have CC'd you in from the beginning, sorry.

Its true, this is a high-volume list.  But we don't see much, if
anything, about Dulwich here.  Yet I for one like to see discussion
about other implementations here, to some extent, so its easier
to make sure everyone is staying close to the C implementation's
reference standard.

> Originally I was under the impression that custom headers would break
> (by reading the C Git source code) and so Dulwich made that assumption,
> but after hearing from several people (among whom Scott, see his reply)
> at Linux.Conf.Au that custom headers could be added and were ignored by
> C git I made this change.

Yes, apparently Scott didn't quite represent things accurately.
Oh well, it seems its been raised now, and beaten to death.
 
> Since Dulwich would blow up when it encountered custom headers that
> might be set by other Git implements and since (as I understand) C git
> ignores unknown headers, I called this a bug fix.

That's true, and I'm glad you have made that change to Dulwich.  It is
a good bug fix to skip over headers you don't recognize.

But, its a new incompatible feature to support writing extra headers.

> If this is indeed a misunderstanding, I'll happily make this
> datastructure with custom headers read-only.

Yes.  Please see the other messages in this thread, especially from
Nico and Junio.  Setting other headers is not a good idea, and you
shouldn't encourage it in Dulwich by making an API available.
 
> > Yes, there are many other Git implementations.  But I thought nearly
> > all of them were toys, and none of them were even close to serving
> > the kind of production volume that JGit serves, and JGit isn't even
> > considered a production library by most.  Yet JGit always tries to
> > conform to whatever standard is set by the C implementation.
>
> So does Dulwich. I've fixed issues in the compatibility with C Git when
> I've noticed them or have been made aware of them. Any incompatibilities
> are the result of ignorance on my part rather than malicious intent.

I'm glad to hear that.

See above about keeping discussion related to other Git implementations
here.  We're happy to help explain something that is perhaps vague or
poorly specified.  Not everyone has the answer right away, but usually
the list fills in everything.
 
> > We're starting to see a fork in the basic protocols happen.  Hell,
> > Dulwich 0.4.1 isn't even capable of speaking over the network to
> > C Git, but it does talk to itself, so its valid, right?  :-(
>
> I've been using Dulwich's client to talk to C Git servers for ages and
> haven't seen issues. I would appreciate hearing about
> incompatibilities. 

OK, I haven't actually looked at the Dulwich client code...  so I
don't know what its current state is.
 
> If you're talking about the server side - we know it's broken, at least
> dul-daemon. Nobody (except for API changes) has really cared about it
> since John Carr originally hacked it up. I'd be surprised if it even
> works with the Dulwich client.

OK, then you may be interested in some of the patches my friend
Dave worked up (he said he was going to send them to you).
Dave discovered the server wasn't playing nice with C git, and
asked me for some protocol help to get it going again.

I'm glad its only an issue of neglect (lack of time) and not
something else that has caused it to be incompatible.

-- 
Shawn.
