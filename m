From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Sat, 20 Jan 2007 20:16:15 +0100
Message-ID: <200701202016.16333.jnareb@gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com> <200701191040.17476.jnareb@gmail.com> <20070120131716.GA4684@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 20:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Lgk-00065q-6f
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 20:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXATTPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbXATTPj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 14:15:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:32404 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXATTPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 14:15:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so728743uga
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 11:15:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ByNqNnbXfTUh9OJ+3ZwOISjnp1kPlnUP7wa3DUZNmKjXK2fJz28q0FtkLmA8Kva+4FpB0R0wSE9KDLBPGs5ssdBAsqa18frQVbU8q6a1fZKWHpLpLTjL085hJNkJgyKqp0GBHkbZUjfYokZtJ4dInWDyaO/KkplOSn5vrWQzVMs=
Received: by 10.67.117.18 with SMTP id u18mr5003028ugm.1169320536778;
        Sat, 20 Jan 2007 11:15:36 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id l33sm3647774ugc.2007.01.20.11.15.36;
        Sat, 20 Jan 2007 11:15:36 -0800 (PST)
To: Yann Dirson <ydirson@altern.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20070120131716.GA4684@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37281>

Yann Dirson wrote:
> On Fri, Jan 19, 2007 at 10:40:16AM +0100, Jakub Narebski wrote:

>> First, "stg rebase" when on some git branch might mean rebase StGIT
>> stack to head of current branch (because there were some git commits
>> on top of this branch). So it would be "stg rebase [--onto <target>]";
>> it would be command without non-option arg, but this arg would be
>> optional.
> 
> I'm not sure I understand.  Since the "current StGIT stack" is the one
> pointed to by HEAD, how do you specify, when HEAD points to the target
> branch, which stack to rebase ?

Well, I haven't thought this through. I was thinking about situation
where there are no applied patches, and some commits were done without
StGIT (pure git), i.e. we had

                  ..1...2...3  <-- unapplied (deck) [ branch ]
                 /
    a---b---c---d   <-- HEAD [ branch ]

There were some git commits (for example fetch, or cherry-pick, or ...)


                  ..1...2...3  <-- unapplied (deck) [ branch ]
                 /
    a---b---c---d---e---f   <-- HEAD [ branch ]

And after "stg rebase" I want to have:


                          ..1...2...3  <-- unapplied (deck) [ branch ]
                         /
    a---b---c---d---e---f   <-- HEAD [ branch ]


I'm not sure how should the above work with applied patches
(non-empty stack), i.e. with the following:

                          ..3...4...5  <-- unapplied (deck) [ branch ]
                         /
    a---b---c---d-.-1-.-2   <-- HEAD [ branch ]
                  \--v--/

                  (stack)  

Or for example git branch got rebased, and I want to move also deck
(unapplied patches), because "git rebase" don't move them... unless
this is not needed. Probably it is not needed.

-- 
Jakub Narebski
Poland
