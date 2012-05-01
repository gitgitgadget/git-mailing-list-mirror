From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 11:03:57 -0700
Message-ID: <4FA0258D.4000908@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Ted Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 01 20:04:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHQk-0002GG-5f
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460Ab2EASD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 14:03:59 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:27634 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758427Ab2EASD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 14:03:58 -0400
X-IronPort-AV: E=Sophos;i="4.75,512,1330934400"; 
   d="scan'208";a="13245021"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 01 May 2012 11:03:58 -0700
Received: from fuji.noir.com ([10.100.2.1])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q41I3vmL012609;
	Tue, 1 May 2012 11:03:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120501111415.GD5769@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196719>

On 5/1/12 04:14 , Ted Ts'o wrote:
> On Tue, May 01, 2012 at 09:14:24AM +0530, Sitaram Chamarty wrote:
>> Does Hg do this?  That would explain why my (admittedly half-hearted)
>> attempts to learn it have failed -- whatever tutorial I used must have
>> been written with the idea that hydra branches are intuitive and
>> logical and sane, but did not express the concept as clearly and
>> succinctly as you did.
>
> What Hg does is it requires that all terminal commits (commits that do
> not have children) must be named by a branch pointer.

No more so than git does.  It's entirely possible to have commits that 
have no branch pointer pointing to them.

> So when you
> pull in some changes from Hg, there may be a non-terminal commit, but
> before the hg pull finishes, it will create a merge commit which
> merges the current branch pointer and the newly pulled in commits, so
> that when you are done, the branch pointer points at the new merge
> commit, and the requirement that there be no non-named terminal
> commits is maintained.

Not so.  What happens is that any commit to a non-terminal commit simply 
succeeds and creates an additional childless commit.  If the new commit 
had a branch pointer, then it continues to have that branch pointer, 
even if another commit already has that branch pointer.  There are just 
multiple childless commits with that branch pointer.

Any merges are initiated manually.  But merging any other childless 
commits is the default for "hg merge".  (And merge commits have two 
parents).

The only merges that are done automatically are the same ones that git 
does on a pull.  These are sort of degenerate merges in the sense that 
they exist entirely in the source code repository graph, there are no 
lexical or file content collisions.

In hg, I can have revision 1 checked out, you can push, (or I can pull), 
revisions 2, 3, and 4 into my repository, and my next update will merge 
2, 3, and 4 into my current working directory, much like with 
subversion.  In git, your push is refused and I can only fetch if I'm 
also willing to merge at that very moment.

> Git differs in that you can have a child commit which is not pointed
> to by a branch pointer, and which is referred to only by commit-id.

Hg can do this too.

> These child commits can disappear on you, when you do a garbage
> collection; but it allows you to have multiple child commits hanging
> off of a single parent commit, and you can do diffs, cherry picks,
> etc.  But they *do* have a unique name --- the commit id, which is a
> SHA1 hash of the contents of the diff.

Same with hg, except that they are persistent and don't disappear on 
garbage collection.

--rich
