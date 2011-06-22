From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] gitweb: Improve search code
Date: Wed, 22 Jun 2011 20:00:03 +0200
Message-ID: <201106222000.04854.jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com> <4E02220F.10800@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>, admin@repo.or.cz
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 20:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZRjA-0006BQ-O6
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 20:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab1FVSAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 14:00:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55136 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758407Ab1FVSAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 14:00:31 -0400
Received: by fxm17 with SMTP id 17so801097fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ds07+ismXrEj8kXVgyUdOwofwxlZ6LyGEd8Nt8gG8KQ=;
        b=e2P8F5oymGX7nrUSsQgV7IaibLcB41WllAWlbBUagdRerkd+hO/AeWkL7OckauQ97h
         xn5721ei1OVjRUuhUVTMsT7mtYV4+DctSpVUNZBMDYJgrpnt+9WZtuJFaEFAR7SKowrR
         L9xPLzjZU2hM7FWuNrzeSeebT6XUdcuEFfcbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LpSaB+Lwpe5V14wnSuf2q7daGoxVpD3wSaZvzP9jMiErP5LwwHd6S1sFPnVe3OpvxZ
         6ecdrJZMZI98jJvnxNFPyz+GbDDAJ2BJYzKNdFAENF9I55naA6oE6Feg+D6vCIzLDHqu
         6eLkDfqie9pYYgWFJo4Db6+zhe/b6K1OYpeu0=
Received: by 10.223.21.141 with SMTP id j13mr1193138fab.79.1308765608285;
        Wed, 22 Jun 2011 11:00:08 -0700 (PDT)
Received: from [192.168.1.15] (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id o23sm470914faa.33.2011.06.22.11.00.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 11:00:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E02220F.10800@cisco.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176249>

On Wed, 22 Jun 2011, Phil Hord wrote:
> On 06/22/2011 11:28 AM, Jakub Narebski wrote:

> > P.S. Another addition that I sometimes wanted git to have would be
                                                  ^^^

This is a typo: I actually wanted to say "gitweb" here.

Therefore this discussion is totally OFF-TOPIC now.

> > 'filename' or 'find' search: searching for file by name.
> >
> > What do you think of it?
> 
> I like it.  +1 from me.
> 
> I normally revert to 'git log --name-status | less <CR> /filename.foo',
> which is awful, of course.  I've always assumed there's a better way I
> haven't discovered yet.  But if there is, well... I haven't discovered
> it yet.
> 
> This syntax works on some files, but is limited and/or broken:
>    # Finds all commits touching the file named './foo.bar', iff
> ./foo.bar exists in the current commit.
>    git log -- foo.bar

Errr... if you use "git log foo.bar" it is true, but "git log -- foo.bar"
will find commits even if foo.bar existed only in the past... though
history simplification can make git return empty set.

> 
> I say 'broken', but maybe it's not; it feels like it is when I do this:
> 
>    # Returns zero logs
>    git log -- some-deleted-file.txt
> 
>    # Returns at least two logs
>    git log --all -- some-deleted-file.txt

     git log --full-history -- some-deleted-file.txt

For example in git.git repository:

   $ # git log --full-history --oneline -- gitweb.pl | cat
   2ad9331 v053
   185f09e v049
   ff7669a v048
   fbb592a v043
   [...]
   e0389bd v001
   ecb378f v000
   4c02e3c v000
   161332a first working version

(Don't you just love Kay Sievers commit messages ;-) ?).

> I think I understand why that happens (search optimization), but it is
> unexpected from the user's perspective.  I also suspect it will miss the
> 'pre-resurrection' commits for files which were deleted and resurrected
> in the past.
> 
> 
> What do you think of these as new 'Commit limiters' for git log:
> 
>        --name=<pattern>, --name-glob=<glob>
>            Limit the commits output to ones touching files that match the
>            specified pattern (regular expression) or glob (shell glob
>            pattern).

Why not use "git log --full-history -- '<glob>'" (i.e. remember about
shell escaping glob)?  I don't know if it works as intended in current
git or not...

-- 
Jakub Narebski
Poland
