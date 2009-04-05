From: David Aguilar <davvid@gmail.com>
Subject: Re: git-{diff,merge} refactor round 2
Date: Sun, 5 Apr 2009 14:15:34 -0700
Message-ID: <20090405211533.GA1393@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <200904050458.17708.markus.heidelberg@web.de> <20090405033443.GA16219@gmail.com> <7vzlevv3fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	charles@hashpling.org, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sun Apr 05 23:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZiQ-0006I1-5O
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbZDEVPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753914AbZDEVPq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:15:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:39609 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbZDEVPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:15:45 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1915606rvb.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D9WmEg+zueIU+hBuhtZfXCCdu+95Nmow/Ve8V1IzPG0=;
        b=XCRS11FRN8jWYKiZngudiVacdYQ9eJa1mk3nK9DfenZY2wJ6vgVbjkisLktt+4KGDv
         EbWAE6M5vgyKak2ggkkoCY8rSmJLEUyJSFwKXRY6rFShh2KpCl7RGcDSAqFyCLvYW2Sg
         DcEDhy6i+GMSz14sqy5OdeqxgAtmBIoLPsdt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uMWkulYhoj37sUaFiTilDyyV+QAGs4L7D6qGNfMdZAQ4PGCqpFHe1ARKoX1TMN9Fxp
         5/DJ8VH03Nr1iO5tpSHY3DEiTVsuYGTS7CwaDAP4Jymmq3N1krn2dwbeOQjvihxsduVk
         amG+8aHig2hH/SN+qJflcN5WvKDPePkkp9OZs=
Received: by 10.114.125.15 with SMTP id x15mr1864608wac.217.1238966143672;
        Sun, 05 Apr 2009 14:15:43 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id f20sm4701951waf.0.2009.04.05.14.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 14:15:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzlevv3fy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115711>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> I'll try to queue all the outstanding da/difftool patches tonight, but I
> think the patches in the series are getting to the point of needing a
> fresh redoing.  Patches like "oops, these non-user scripts should have
> been named with double-dash" can and should disappear.
> 
> Currently they are:
> 
> $ git log --oneline next..da/difftool
> 736e6b6 mergetool--lib: add new merge tool TortoiseMerge
> b3ef7cc mergetool--lib: make (g)vimdiff workable under Windows
> c4d690e mergetool--lib: consolidate the last redundant bits in {diff,merge}tool
> def88c8 mergetool-lib: specialize opendiff options when in diff mode
> bd52fab mergetool-lib: refactor run_mergetool and check_unchanged
> e87266c bash completion: add git-difftool
> 04c3b54 {diff,merge}tool: rename helpers to remove them from tab-completion
> 2a83022 mergetool-lib: add diffuse as merge and diff tool
> 73c59d9 mergetool-lib: specialize xxdiff options when in diff mode
> 273e7a2 mergetool-lib: specialize kdiff3 options when in diff mode
> 99511d8 mergetool: use run_mergetool from git-mergetool-lib
> 37c48c7 difftool: use run_mergetool from git-mergetool-lib
> 4e314b5 mergetool-lib: introduce run_mergetool
> 588954e difftool: use valid_tool from git-mergetool-lib
> 8af4556 mergetool: use valid_tool from git-mergetool-lib
> 72286b5 difftool: use get_mergetool_path from git-mergetool-lib
> d03b97f mergetool: use get_mergetool_path from git-mergetool-lib
> c6afc72 Add a mergetool-lib scriptlet for holding common merge tool functions
> 6108b75 mergetool: use $( ... ) instead of `backticks`
> 73786e2 difftool: add support for a difftool.prompt config variable
> 472ff62 difftool: add a -y shortcut for --no-prompt
> de2b85d difftool: use perl built-ins when testing for msys
> 9df990e difftool: add various git-difftool tests
> 8ac77f2 difftool: add git-difftool to the list of commands

It goes back even farther...

d3b8cec difftool: move 'git-difftool' out of contrib

d3db8cec is currently sitting in 'next' and is where the
"oops, I should have used double-dash" lack of foresight
began.

I like the *result* of what's currently sitting in
da/difftool, so rewriting history is easy now that we know
exactly where we're going.

I think we have a couple of options here.  I won't be able to
get to it until sometime tonight, but I'll throw my plan out
here to get a feel for what's the better way to do it.
I think we have a couple of options.  I'm open to any of
these:

1. Base it on the current master, completely throwing away
the existing da/difftool branch.  That would include throwing
away the commit that's in next if we really want to be clean
about the history.  In the process, move Markus' mergetool
fixes for windows to the top so that they can be applied
independently if necessary.  This series would then depend
on them.

This would probably mean a merge conflict with next at some
point.


2. Base the series on next, keeping the 'move out of contrib'
patch intact.  That'll minimize conflicts but will have an
extra commit that renames difftool-helper.  I can still push
the fixes-for-windows patches up to the top so that it makes
it easier on msysgit since we already have those two patches
in the msysgit 'tortoisemerge' branch.

3. Any others?


Regardless of which it's based on, it's obvious that there'll
be some squashing going on.  Tentatively,

Will be squashed:
588954e difftool: use valid_tool from git-mergetool-lib
8af4556 mergetool: use valid_tool from git-mergetool-lib

Will be squashed:
72286b5 difftool: use get_mergetool_path from git-mergetool-lib
d03b97f mergetool: use get_mergetool_path from git-mergetool-lib
c6afc72 Add a mergetool-lib scriptlet for holding common merge tool functions

Will be squashed:
99511d8 mergetool: use run_mergetool from git-mergetool-lib
37c48c7 difftool: use run_mergetool from git-mergetool-lib
4e314b5 mergetool-lib: introduce run_mergetool

Will be squashed:
def88c8 mergetool-lib: specialize opendiff options when in diff mode
73c59d9 mergetool-lib: specialize xxdiff options when in diff mode
273e7a2 mergetool-lib: specialize kdiff3 options when in diff mode


I'll go with whatever you guys think makes the series easiest to manage.

I think my preference would be to resend the entires series
based on 'master', but I don't want to make it any harder to
manage 'next'.

Thoughts?

-- 

	David
