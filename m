From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Mon, 8 Sep 2008 21:05:28 -0400
Message-ID: <e06498070809081805l46ff295du69d8c9a2cc0ef59a@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <m38wu5p9q4.fsf@localhost.localdomain>
	 <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
	 <200809062101.28672.jnareb@gmail.com>
	 <5d46db230809072045u7ade2d62i514aac49149a463d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 03:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcrgv-0006vx-Ba
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 03:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbYIIBFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 21:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbYIIBFb
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 21:05:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:5361 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbYIIBFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 21:05:30 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1822884wri.5
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=azTL/AIEsrzj1TzKy7w7LhRB7u4ihqIZg2qjJsXf/zs=;
        b=II5+jBqaAZNxZAbxZ5gGj+OSXl66UcgBTmGSi45F9w0T51uXIFQXW9hCSWd/UKlltR
         bLTzYB5+bVAIzH7TUhOXErgy1pgO89IKPpX+awolsrJGdGLg9XcMHYVsxXl8EDAxRYfS
         vKSsgOEy9D4SEU/nm6gfFtuDgdAEdU37rk8cY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UQmNLnryIYOft/DF3/ER7qsEKRCQU1aFMjY56hRdDIUFlSsHUx01WsGVPKWlFWAdOS
         U/rMUkWJ8Xft1fKgl+XhyZQvLUQChyLemRZT6gg7di3j5pV2/WcQG/MponuVPj4+nR+b
         2xv8CD9iOfjDCnrU/R+bfHO9+qwOqRxipaebY=
Received: by 10.90.31.8 with SMTP id e8mr20050452age.98.1220922328709;
        Mon, 08 Sep 2008 18:05:28 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Mon, 8 Sep 2008 18:05:28 -0700 (PDT)
In-Reply-To: <5d46db230809072045u7ade2d62i514aac49149a463d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95325>

On Sun, Sep 7, 2008 at 11:45 PM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
>>> To my knowledge, Pyrite does not support plugins.
>
> Depends on what you mean by plugins.  There is a way to load what I call
> extensions that you can use to add commands or modify the way existing
> commands operate.  It is crude at the moment but it works.  I have a
> proof of concept extension/plugin that adds different ways of specifying
> revisions.  I assume you mean something similar.

That pretty well describes what I mean by a plugin system.  Does your
system allow anything other than commands to be overridden?  Do your
commands ever call other commands, and if so, will the overridden
method be called in that case?

Yap's plugin system is pretty nice (IMHO), but it was designed almost
exclusively as a means to an end: the svn plugin.  With the svn
plugin, "yap clone" will accept an SVN url as readily as a git URL,
and the result it what you would expect if you had a git URL:  a
full-history git clone of the svn repository with all branches and
tags.  Obviously, the svn clone would be much slower than the
equivalent git command, but that's the price one pays in interacting
with svn.  However, this "yap" repo can then be cloned, and all the
svn meta-information will be present in the new repository.  This
means that the new repository can immediately be used for pushing
commits back to the original svn repository without any additional
configuration.  Additionally, you can use an svn revision anywhere a
git committish can be used.

In a yap "yap-svn" clone, "svn" appears as just another remote.  "yap
push svn foo" does the expected thing.  Likewise for fetching and
updating.  In theory a similarly parallel interface could be provided
to other SCMs.  Facilitating users who track SVN repositories with git
was one of the majors goals of the yap project, and I encourage users
who do so to give yap a try.

> I am currently not doing much work on the command line interface since
> people seemed to object to my ideas.  Instead I am focusing on the gui
> instead.  Since you say you are not going to keep the command lines
> compatible, what do you intend to do differently?

The command-line interface has been my primary focus, as that is what
I and my co-workers usually use.  The interface that yap has now is
intended to be more orthogonal and "safer" than the standard git
porcelain.  By "safer" I mean that yap will not perform an operation
that cannot be readily reversed without explicit confirmation (an "-f"
flag, for instance).  For example, the closest equivalent to "git
reset --hard" in yap is "yap point."  yap point fails if there are any
uncommitted changes (staged or unstaged), or if it would create
"dangling commits" that can no longer be referenced by a ref (unless
"-f" is given).  On the orthogonal side, "yap" provides
commit/uncommit as a pair, as well as stage/unstage.  They are small
things, but small things can make a big improvement in user experience
(especially if it keeps you from killing uncommitted changes you had
forgotten about).
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
