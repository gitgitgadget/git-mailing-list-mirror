From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 12:27:40 -0400
Message-ID: <9e4733910609140927y30ecaa42wae0ff0597b8c3842@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <450872AE.5050409@bluegap.ch>
	 <9e4733910609131438n686b6d72u4d5799533c7473d7@mail.gmail.com>
	 <4508EA78.5030001@alum.mit.edu> <20060914155003.GB9657@spearce.org>
	 <eebuih$u32$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, monotone-devel@nongnu.org,
	dev@rapidsvn.tigris.org
X-From: git-owner@vger.kernel.org Thu Sep 14 18:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNu40-0005DF-KN
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 18:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWINQ1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWINQ1m
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 12:27:42 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:8792 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750880AbWINQ1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 12:27:41 -0400
Received: by py-out-1112.google.com with SMTP id n25so3680610pyg
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 09:27:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DKaxau/RmGlo3MRxEGbP85uBs4WbnP00cqeeywEQk05TwwNW+9dh6lkBemYDU5kaKen8ZIkCdkKKF9N6KrvL/WthFSwJqaH16oo8ew9azoVPx++bI4pTq6BzZEUIlSjG+BvhmlwIW3rOkOTwyeO3+pxh6MDEDldv2dw0b5iREVU=
Received: by 10.35.95.1 with SMTP id x1mr15331897pyl;
        Thu, 14 Sep 2006 09:27:40 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 14 Sep 2006 09:27:40 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eebuih$u32$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27009>

On 9/14/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
>
> > Originally I wanted Jon Smirl to modify the cvs2svn (...)
>
> By the way, will cvs2git (modified cvs2svn) and git-fast-import publicly
> available?

It has some unresolved problems so I wasn't spreading it around everywhere.

It is based on cvs2svn from August. There has been too much change to
the current cvs2svn to merge it anymore. It is going to need
significant rewrite. But cvs2svn will all change again if it converts
to the dependency model. It is better to get a backend independent
interface build into cvs2svn.

It it not generating an accurate repo. cvs2svn is outputting tags
based on multiple revisions, git can't do that. I'm just tossing some
of the tag data that git can't handle. I base the tag on the fist
revision which is not correct.

If the repo is missing branch tags cvs2svn may turn a single missing
branch into hundreds of branches. The Mozilla repo has about 1000
extra branches because of this.

Sometime cvs2svn will partial copy from another rev to generate a new
rev. Git doesn't do this so I am tossing the copy requests. I need to
figure out how to hook into the data before cvs2svn tries to copy
things.

cvs2svn makes no attempt to detect merges so gitk will show 1,700
active branches when there are really only 10 currently active
branches in Mozilla.

That said 99.9% of Mozilla CVS is in the output git repo, but it isn't
quite right.

If you still want the code I'll send it to you.

-- 
Jon Smirl
jonsmirl@gmail.com
