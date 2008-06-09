From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How does git store branchpoints?
Date: Mon, 09 Jun 2008 08:07:17 -0700 (PDT)
Message-ID: <m3hcc2wso1.fsf@localhost.localdomain>
References: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5iyo-0005Db-Jy
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983AbYFIPHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 11:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbYFIPHX
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:07:23 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:59882 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbYFIPHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:07:21 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1558918mue.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Ftc8yBEBHQAWStX8vshT3X/BF0ik7RKQzxj2UOQBXps=;
        b=nUBshi9ILDZLuUtUwdgfptA3hJVtiRa9OZZ9URH3FRm4UsCwlDuNS/yjw9eZg0Jdb/
         Fg/AolJQsHtjpudHrGBeygwCJ2rygb+SoHaEQKa2L3b1LZyqqujo7B2eMHOywabyury3
         6innatRhOleDdOPdNkZY7CObL/UY4a97OdrGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=kkdCtc47TYTAUXuie/PL0Zdri4NQoMk6h+C1W/CHcEMIVr1ciAS5Czk38PHXKyJ24Z
         EXg1GchHotv9OwcEChEXcjNVyCBDOFsTWZeI9pmlp2h3A3TrCeFdBcC7Ir6k1OsoTJki
         4zCnLk0OdS3EKMnEQHG89cwffwJ1YHEIDeuWc=
Received: by 10.103.207.18 with SMTP id j18mr2487460muq.21.1213024038405;
        Mon, 09 Jun 2008 08:07:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.230])
        by mx.google.com with ESMTPS id s10sm17018337mue.16.2008.06.09.08.07.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 08:07:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m59FAOWt017153;
	Mon, 9 Jun 2008 17:10:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m59FAMBA017150;
	Mon, 9 Jun 2008 17:10:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84390>

davetron5000 <davetron5000@gmail.com> writes:

> Following up this:
> 
> http://groups.google.com/group/git-version-control/browse_thread/thread/aa34d04120d0c361#
> 
> I'm trying to learn/examine the .git directory to see what Git thinks.
> 
> What I'm trying to determine is how Git knows the parent of a
> particular commit, how I can change it, and how that affects merging.

The parent (or parents in the case of merge commit) are stored in the
commit object itself.  You cannot change them short of rewriting
history, or telling git locally via .git/info/grafts file how it should
modify history (see "Repository Layout" documentation for more info
about grafts).
 
> My problem is that I have two branches, and a merge between the two
> produces conflicts in files that are unchanged on one branch.  Since
> my branches are linked to SVN branches, I'm thinking that Git is not
> properly clear on their shared history.
> 
> Any ideas where to look?

Use some kind of history viewer, be it gitk, qgit, giggle, tig,
git-show-branch (a bit cryptic), git log --graph (not yet released),
or similar tool.

> .git/info/refs has some strange data in it:
> 
> 5a3e01a8327c6139e9311b01548baf4a8876b5e3    refs/heads/local-FOO
> 71560b15ad6a2a7542556dfdf2d6c763625d5db4    refs/heads/local-trunk
> efb2ff2ac363600a2aaae60718bc76b6c3db4228    refs/remotes/FOO
> 
> The SHA-1 for refs/heads/local-FOO (branch created via git checkout -b
> local-FOO FOO) doesn't show in gitk --all, but a git log of that shows
> it to be a somewhat old commit (not the head, nor the branch point).

.git/info/refs is auxiliary information for "dumb" protocols, i.e.
for fetching via HTTP etc.  It is updated using git-update-server-info,
usually in the bare public repositories run from post-update hook
(in non-bare you would want to add it also to post-commit).

What you should look at is "git show-refs" or "git ls-remote ."
output, or "git for-each-ref" output.

> The SHA-1 for local-trunk is a similarly old commit
> 
> The SHA-1 for refs/remotes/FOO is the commit right before the SHA-1
> for refs/heads/local-FOO in my git log.

That said, if you have two divergent branches 'FOO' and 'trunk',
for example with the following history

   a<---b<---c<---d<---e  <--- trunk
             ^
              \---1<---2  <--- FOO

you can derive from parent info where history diverged.

You can ask git to find branch point using "git merge-base trunk FOO",
which should return 'c' (actually, sha-1 of this commit).

HTH.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
