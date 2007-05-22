From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Tue, 22 May 2007 13:27:08 +0100
Message-ID: <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue May 22 14:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTSS-000479-2O
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbXEVM1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 08:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591AbXEVM1N
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:27:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:46185 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044AbXEVM1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:27:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so262275uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 05:27:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NdUJAI8D50bWFaFlQZIs7jYBRh4j4AkjvSUjPJCC5yLtPtChOrMiPeplwkd0+5PqeXpwhEHviMrqGSy0u6XwjtyGM/r0ozAMUnryEwwyOstqEIZ1QsGahOOlKWqAwi3q4LWwKTv0qbV98eSE1Is2xLYvmuMeXrB7vOJ9GdA6koQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fjlx1HNiFzCL73Ye00sEvTd/UpCcMTxVFmMtS3MWrBdSLTwJ5FFRjje2QPd/kx072X46HpMLDPxG2BMTzsixWqsLwLdEtNXz9wzobWC+whwrboPzTFvR045x/ip9N0mJ5DJzp179jgUjEOX8MbBYuuarXbUQyyifGZIwE8pOTRU=
Received: by 10.78.156.6 with SMTP id d6mr1411096hue.1179836828219;
        Tue, 22 May 2007 05:27:08 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 22 May 2007 05:27:08 -0700 (PDT)
In-Reply-To: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48098>

On 15/05/07, Yann Dirson <ydirson@altern.org> wrote:
> The patch@branch syntax is annoying, at least for bash-completion
> purposes: we don't want to provide all possible completions accross
> all branches, yet we'd like to get completion for foreign patches.
>
> Another place where I feel it is bad is when using the full
> "patch@branch//top" syntax: the MSB is in the middle, and the LSB is
> on the right.

I agree that the current syntax is bad.

> Both issues would be solved by switching to a MSB ordering, with a way
> to distinguish branchnames when given.  Something similar to pathnames
> would fit well - eg. [/branchname/]patchname[//top].  However, I'm not
> sure using slashes would be a good choice, precisely because of the
> similarity with real pathnames.  But we don't have so many separator
> chars that are not special in one way or another, and would require
> quoting them to avoid more user confusion.

We had a discussion some time ago about using slashes for the //top or
//bottom syntax and we ended up using two slashes. We could do the
same to delimitate the branch from the patch - branch//patch//top. The
branch or patch can have (single) slashes in their name.

We couldn't use ":" at that time as it was used for the 'diff -r x:y'
command. I later switched to the git ".." format (when git eventually
defined it). As Karl said, branch:patch@top is another way, unless we
later decide to add another level, the repository, and would like to
have a uniform syntax (maybe always use ":" instead of "//"). We could
run commands like:

  stg pick ../../path/to/linux-repo//branch//patch

I don't think using "#" is feasible as bash ignores everything after
it unless you use quotes or escape.

Another nice thing to have is a way to get older versions of a patch
via patchlogs. This should probably follow the current git notation,
i.e. patch^^^ or patch~N.

-- 
Catalin
