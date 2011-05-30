From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How would Git chapter look like in "The Architecture of Open Source Applications"?
Date: Mon, 30 May 2011 12:30:10 +0200
Message-ID: <201105301230.11772.jnareb@gmail.com>
References: <201105281417.39883.jnareb@gmail.com> <20110530034044.GC27691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 30 12:30:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQzjw-0002iw-8p
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 12:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab1E3KaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 06:30:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47838 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab1E3KaW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 06:30:22 -0400
Received: by bwz15 with SMTP id 15so2757952bwz.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=T70z7MG/Ee+ANty3j+yVHCie/8CAy5qSzI7cVNcyolw=;
        b=Xa52oqcOQL4GANx4+Uy+jcdN1mueisxIxGTKvpgiWwKSi5O3nUxKGOPstUMspeBNft
         4D+EjD/9sEgq/LArFEeIn2fK3Ya65y0tvjbOmMFialgfcrWf7xwN5hO+TOC4tCOQc3mV
         MYeK9ywZKpLcGQd4yYElYa+CU0bEueVXEeqJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=BUiIqVqAw8+fEqusq2JQIii/F6nq1V75wRR5ldjtb/BfLgUzGxNSnNvR4/MUGQbvcy
         B4zEYLKxlwb7gU0yx9yCdpHRUm4ScTWpVVE8NIXYJ0S3FncLAyfjcqrT8j3JWcWpFjCz
         qij3wnWyYeJrSyNe8uqUZgDa6KW7trm4bIq4U=
Received: by 10.204.172.66 with SMTP id k2mr4180969bkz.125.1306751420662;
        Mon, 30 May 2011 03:30:20 -0700 (PDT)
Received: from [192.168.1.13] (abvg56.neoplus.adsl.tpnet.pl [83.8.204.56])
        by mx.google.com with ESMTPS id k16sm3297957bks.1.2011.05.30.03.30.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 May 2011 03:30:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110530034044.GC27691@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174736>

On Mon, 30 May 2011, Jeff King <peff@peff.org> wrote:
> On Sat, May 28, 2011 at 02:17:38PM +0200, Jakub Narebski wrote:
> 
> > Among covered programs is Mercurial (chapter by Dirkjan Ochtman)...
> > but unfortunately no Git (they probably thought that one DVCS is enough).
> > 
> > How would such chapter on Git look like?  Authors of this book
> > encourage (among others) to write new chapters.
> 
> I just skimmed the Mercurial chapter, but they do cover a fair bit of
> general DVCS architecture. For git, I would guess a good approach would
> be to describe the data structures (i.e., content-addressable object
> database, DAG of commits, refs storing branches and tags), as everything
> else falls out from there. Most of the basic commands can be explained
> as "do some simple operation to the history graph or object db" and the
> more complex commands are compositions of the simple ones. So the
> architecture is really about having a data structure that represents the
> problem, exposing it to the user, and then building some niceties around
> the basic data structure operations.

The repository model that Git uses is quite well described in "Pro Git",
in "Discussion" section of git(1) manpage, in "Git concepts" section of
Git User's Manual and in gitcore-tutorial(7).

What I am more interested in is design *goals*, i.e. what's behind
choosing this and not other architecture.  

The chapter on Mercurial, in '12.2. Data Structures > 12.2.1. Challenges'
subsection says about limiting technology factors (quoting [Mac06]):
 * speed: CPU
 * capacity: disk and memory
 * bandwidth: memory, LAN, disk, and WAN
 * disk seek rate

This was for Mercurial; from what I remember from KernelTrap articles,
which covered beginnings of Git development quite well, and from other
sources, the main limiting factor considered was __speed__.  

Not disk space.  At first Git had only 'loose' format -- do you remember
"disk space is cheap" comment by Linus?  Admittedly Git used zlib
compression from very beginning (which works well for text).  IIRC at
first when _model_ that Git uses for repository was being drafted
LAN/WAN bandwidth wasn't consideration; AFAIK first transport that Git
used was nowadays deprecated rsync:// (UNIX philosophy of prototyping
and developing using existing ready tools, see [TAOUP], [Ben86]).

I think it was assumed that operating system would be good enough that
we don't have to worry about seek rates: Git is optimized for "hot cache"
case.  Note however that adoption of 'packed' format as on-disk format
was driven by speed (disk seek rate) as well as disk capacity i.e. 
reducing repository size.  Well, at least from what I remember.


The Mercurial's '12.2.1. Challenges' subsection continues from:

  The paper [i.e. [Mac06]] goes on to review common scenarios or
  criteria for evaluating the performance of such a system at
  the file level:

    * Storage compression: what kind of compression is best suited
      to save the file history on disk? Effectively, what algorithm
      makes the most out of the I/O performance while preventing
      CPU time from becoming a bottleneck?
    * Retrieving arbitrary file revisions: a number of version control
      systems will store a given revision in such a way that a large
      number of older revisions must be read to reconstruct the newer
      one (using deltas). We want to control this to make sure that
      retrieving old revisions is still fast.
    * Adding file revisions: we regularly add new revisions. We don't
      want to rewrite old revisions every time we add a new one, because
      that would become too slow when there are many revisions.
    * Showing file history: we want to be able to review a history of
      all changesets that touched a certain file. This also allows us
      to do annotations (which used to be called `blame` in CVS but was
      renamed to `annotate` in some later systems to remove the negative
      connotation): reviewing the originating changeset for each line
      currently in a file.

>From what *I* understand Linus approached the problem of DVCS design
from different direction: he is maintainer rather than ordinary developer,
and (from what he said) filesystem designer at heart, and not version
control developer.  Thus the common scenarios or criteria were different:

 * Merging and applying patches
 * Showing _subsystem_ history
 * ???

That is what I am interested in.


Some of Git history, and I think of motivations behind design, can be
found in "Git Chronicle" slides by Junio from GitTogether.

> Of course that's just my perspective. Linus might have written something
> totally different. :)

Well, only Linus can be definitive source of initial *design goals*
(behind core design of Git)...


References:
~~~~~~~~~~~
[Mac06]: Matt Mackall: "Towards a Better SCM: Revlog and Mercurial".
         2006 Ottawa Linux Symposium, 2006.
         http://selenic.com/mercurial/wiki/index.cgi/Presentations?action=AttachFile&do=get&target=ols-mercurial-paper.pdf
         (see also http://mercurial.selenic.com/wiki/Presentations)
[TAOUP]: Eric Raymond: "The Art of Unix Programming", 2003
         http://www.faqs.org/docs/artu/
         http://www.catb.org/~esr/writings/taoup/
[Ben86]: Jon Bentley: "Programming Pearls", chapter about implementing
         and prototyping UNIX 'spell' program (from Polish translation).
-- 
Jakub Narebski
Poland
