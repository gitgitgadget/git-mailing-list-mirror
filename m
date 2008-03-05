From: "C. E. Ball" <ceball@users.sourceforge.net>
Subject: Re: Interrupted git-svn dcommit, now I get segmentation faults
Date: Wed, 5 Mar 2008 17:00:44 +0800
Message-ID: <4e2a3a120803050100qc2902e3j6b2861f69b0d187f@mail.gmail.com>
References: <loom.20080221T062522-821@post.gmane.org>
	 <47BDD096.7040606@vilain.net>
	 <4e2a3a120802220113q4df473c0xcaad4760aea7f49b@mail.gmail.com>
	 <4e2a3a120802220120s36fcdd31i9d0a18800d0a0349@mail.gmail.com>
	 <47BF907E.2090904@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 10:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpVB-0001ze-GN
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 10:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbYCEJAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 04:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbYCEJAt
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 04:00:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:32879 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYCEJAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 04:00:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1548016fga.17
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Xl+G89atSAugCiRsKjVJaB1GZRUcOIV8696v2DHg5JE=;
        b=QbTfrIi+DA+SrvBb71Xd9J/IMLiq4sj2ZArKGbcnwnmcr4aQkVRnXh1uQCxQJnOGEhi3WHrIZfiCDeYJKjW5ZH0pT5KroOVmBIfhnYJjnrfwF9d62Zb4aVbcna1VoWzLaQrdWpEb/9v4cLPYIS2Ulz0RPgzGXBKoufnnMamiw5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=k4OfzmBNLOfHXlW6pyPRjQKFLYK4hxeqowAjvhL0d3clWF8eEBVqOJ0/ut4ROc/yzq717flDZVzGNAcIJSQF08WL7/OTxPF0az7K3ePPwYriSiPeqjvERAeMy6PB58PG/+I7PO4/ZdzZfA7673BAkbwW1S1NPs7J/AOwN10VnRs=
Received: by 10.86.89.4 with SMTP id m4mr2671616fgb.14.1204707644861;
        Wed, 05 Mar 2008 01:00:44 -0800 (PST)
Received: by 10.86.79.1 with HTTP; Wed, 5 Mar 2008 01:00:44 -0800 (PST)
In-Reply-To: <47BF907E.2090904@vilain.net>
Content-Disposition: inline
X-Google-Sender-Auth: 7cb95f80c47174fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76198>

On Sat, Feb 23, 2008 at 11:18 AM, Sam Vilain <sam@vilain.net> wrote:
>
> C. E. Ball wrote:
>  > On Fri, Feb 22, 2008 at 5:13 PM, C. E. Ball
>  > <ceball@users.sourceforge.net> wrote:
>  >>>  If you get stuff like that you can move the git-svn state out of the
>  >>  >  way, and re-run git-svn fetch; it will rebuild the metadata.
>  >>  >
>  >>  >   $ mv .git/svn .git/svn.bad
>  >>  >   $ git-svn fetch
>  >>  >
>  >>  >  Not a fix I know, but might work for you ;)
>  >>
>  >>  Thank you very much, that did work for me!
>  >
>  > Please ignore my previous email - I was in the wrong place on my
>  > filesystem! Sorry about that.
>  >
>  > After following your suggestion on my broken repository, I still get
>  > the same error (a segmentation fault just after the commit is
>  > successfully sent to svn) when I 'git-svn dommit'.
>  >
>  > Any other suggestions?
>
>  Well this is where the fun starts.  Make sure you're on a new version of
>  git - latest stable or built from "master" if possible.  Start perl (or
>  even debugperl if you have one built with debug symbols) with gdb, and
>  get it to run git-svn and use "bt" to get a backtrace when you get the
>  fault.
>
>   $ gdb /usr/bin/debugperl
>   ...
>   > run ~/bin/git-svn dcommit
>   ...
>   --- SEGV ---
>   > bt
>
>  That's the default place to start looking for clues.  Otherwise it's a
>  pretty much open-ended problem ... you would have to figure out (perhaps
>  using the perl debugger, perhaps using test cases) what triggers it,
>  what's not passing the correct thing to the SVN API, whether it's a
>  version-specific SVN bug, etc.  It's certainly not very common which
>  makes me suspect the SVN::Core bindings and/or the stack beneath that
>  part of it.  The SVN API is ... fragile, and the codebase is bulky and
>  poorly thought out.  So, you get weird behaviour like the exception
>  handler has to die() or you get a segfault, etc.
>
>  If that seems too daunting, perhaps just respond with the versions of
>  everything you are using (eg perl -MSVN::Core -le 'print
>  $SVN::Core::VERSION', git --version etc) find out if it's specific to
>  the repository you're committing to, or (if you can) your system, etc,
>  and perhaps someone else will have a better clue.

Thanks very much for taking the time to help with this. After
beginning to follow your suggestions, I decided it was too difficult
for me to debug the problem, so I started again with a new repository!

I have no problems at all now. I've been using git (and git-svn) for
about two weeks now, and I'm really impressed. Previously I had tried
to work with this particular svn repository using bzr and its svn
plugin, but found it to be too slow (maybe because of some large
binary files, but I'm not sure). Apart from being fast, git also
doesn't seem to get in my way when I'm working.

Chris
