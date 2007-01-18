From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Thu, 18 Jan 2007 09:05:47 +0000
Message-ID: <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	 <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	 <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
	 <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
	 <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	 <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	 <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 18 10:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7TDV-000345-AA
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 10:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXARJFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 04:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbXARJFu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 04:05:50 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:18278 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbXARJFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 04:05:49 -0500
Received: by nz-out-0506.google.com with SMTP id s1so87409nze
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 01:05:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3kCXivWe8MNiXT1faZDceJmldsrA5RRq2i7qH7GCRGP7uhh/loqo11kZ02GtSjQFycunaBONCg8elAWeCW/aEP6ykVpm1ljXPP86BCfH0fxocrD037ezniaE1yneZmvl+fvITziPZ02mxZR2XatiLSN7kJjZUXiOPzs4huJrWw=
Received: by 10.64.180.4 with SMTP id c4mr468516qbf.1169111147700;
        Thu, 18 Jan 2007 01:05:47 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Thu, 18 Jan 2007 01:05:47 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37069>

On 16/01/07, Yann Dirson <ydirson@altern.org> wrote:
> My example is quite similar to the one given by Guilhem: I had a git
> branch coming from git-cvsimport, and my stgit stack forked atop that
> branch.  At some point git-cvsimport fucked something, and I
> regenerated a new mirror branch using it in a fresh repo.  Then I
> wanted to rebase my stack on that new branch.

As Jakub said, I would also call this command 'rebase' instead of
'pull --to', even if we duplicate a bit of code. It would make the
implementation even simpler as you won't break other people's
workflows using git-pull or cg-pull. The main feature of the 'pull'
command is to fetch the latest changes from a remote repository and
merge (fast-forward) them into current base.

> > But you want to replace the call to 'git pull' with 'git fetch'. I
> > think this is fine with my workflow but some people might actually
> > rely on calling 'git pull' (or cg-pull).
>
> Right, it may be possible (and I'd be interested in seeing such a
> workflow).  Maybe we could keep support for git-pull as an
> alternative.

As I said, I use this myself on an exported branch.

> This could be done, eg. by letting the user use "pullcmd=git-pull" and
> introduce a new option like "fastforward=<bool>" triggering the
> fast-forward needed after git-fetch, with the default being "true",
> and the current behaviour being obtained by changing it to "false".

But isn't this too complicated when all you need is a 'rebase'-like command?

> That would not add too much complexity, while setting the default to
> what I believe to match the most common workflows, and allow anyone
> relying on the current behaviour to get it back.

The problem is that I may use different workflows in the same
repository (but on different branches). Any new config options would
have to be per branch.

-- 
Catalin
