From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 17:52:23 -0800
Message-ID: <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <20071218222032.GH2875@steel.home>
	 <Pine.LNX.4.64.0712182239500.23902@racer.site>
	 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 02:52:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4o77-00080I-Uw
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 02:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbXLSBw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 20:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbXLSBw0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 20:52:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:41514 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbXLSBwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 20:52:25 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1494116nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 17:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pwFdiUujfi0tdMzeQRXTfI40eWo2R77XQFx89mlf9is=;
        b=khN+OSS2QBs37nSHIrHd5+9v2PjPeGpNArFSlirD+DTbBeBIaeT3VF3HPXBJXfTbo9KiXAsPK/BPV149H0RX7m9aRARQvbHN3wIZyLPFLWccxgHc8SyW/yi7XDYN4+Od/OyIXFNIBn128uamZS9AkjwHjTyW+SLQAap+RoUjjVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4vyjvOPkrbdEXwCoD09vwmn9RSERnUVHE/LXTIYW89qaTgESC7Ha+7WKlbccNWcOuqTxJ8Ymfm+/zW2lNITVGAqIvKqJ6cpCT5orahB8acF0xnuLM5+t9lrVuKx4zexhHRR9EgmfwrkulXIKJMUP3C9mjjuqkW4PM0QJEVTiYk=
Received: by 10.78.83.15 with SMTP id g15mr2519755hub.6.1198029143734;
        Tue, 18 Dec 2007 17:52:23 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 17:52:23 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68853>

On Dec 18, 2007 5:16 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 18 Dec 2007, Dana How wrote:
> > The cases we are talking about are all subtrees of the working tree.
> > There is a useful cwd suffix.
>
> No.
>
> The cases we're talking of are *not* subtrees of the working tree.
>
> The SHA1 of a commit may well be a totally disjoint tree. Try it in the
> git repository with something like

Agreed,  but note you wrote *may*.

I'd like to move some stuff currently in a p4 repository into git.
The directory structure within the repo is 13 levels deep;
I didn't design it nor can I change it.

For the majority of the cases of interest to me git already accepts
relative paths.  However,  one thing people do often in p4 (or any SCM)
is look at (or compare, etc) specific revisions.  Unfortunately,  these are
not part of branches or commits,  they are just file-specific revisions
(don't get me started on p4 "branches").  The equivalent in git is
to use a commit name (or a tag) and then name the file.  The
basic commit:file syntax doesn't accept relative paths.  I am not
specifically hung up on the commit:./path syntax;  I just want some
notation that will get those 13 directories from $cwd instead of
making me type them again.  Yes,  sometimes that might not make
sense to request.

There was some mention of bash/zsh completions  Unfortunately,
much of our CAD environment is not configured in bash/zsh,
so although I use bash for some scripting,
it's not the default for command-line,  and won't be used by
others I need to drag along with me...

> In fact, you can very well think of the commit/tree as a "drive letter".
> It really does go into another namespace entirely. It's just that often
> that namespace does bear some relationship to the currently checked out
> branch. But that's just an "often", it's not at all a given.
>
> > Don't you think that
> >   git <op> commit:./file.c
> > could occasionally be more convenient than
> >   git <op> commit:very/long/and/boring/path/equal/to/cwd/file.c
>
> It's not about "convenience". It's about *sanity* and good design. And the
> fact is, that "commit:path" format really has nothing to do with the CWD
> in the general case.

Yes I frequently get to be one of the people here pushing for
(and sometimes losing the case for) "good design".
But I will never be able to successfully argue for retyping 13 directories
already in the cwd because it's the "good" or "sane" thing to do.

Given that the root of the current working tree,  the commit, the cwd,
and the path (suffix) given on the command line are all known precisely,
it does not seem dangerous to come up with an exact rule to combine them
which is only triggered by some specific syntax.

This does not need to work in bare repositories.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

(Junio removed from cc: at his request)
