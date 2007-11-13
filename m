From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 20:17:31 +0100
Message-ID: <200711132017.31352.jnareb@gmail.com>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <87lk9282nr.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1Gw-0007rb-Jy
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbXKMTRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757311AbXKMTRi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:17:38 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:34967 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457AbXKMTRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:17:37 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1913539fkz
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=6rVzC4kGtElvy1XR4TUqtiIeiL05V/YllZMY4ph62+A=;
        b=a8Z44091ED1L7wF15KzdiMX3qCIcwrQn2C3msw0GOV0LrJFNCf2nGBmPXPofzQoExE9bwwrYDLcrJVcz2Dfpf1xR3Towz0Y74LaH3/W7NsdhDh3v/3uToulR+YEp51M7faeZ/mTapyVrugZ/i2aJxWOGGDIVlSqVQEm3GCQoZHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PVGSDzDxbN4L1maQLRg/+FTIot/G4OVmVssQ1Jh3ubytcttsiiKcoOjuVci50dXgWCvBWqQpreHS3gkZoQuuUMDSQL1hEe/1cIaE3njcHEDYb7IkDDBfQu0Am26hVDFndeqAgoe8Uo1CKUpAF5CqELQk9F86UBwo3tPhU1SnXYU=
Received: by 10.82.112.3 with SMTP id k3mr12192544buc.1194981453997;
        Tue, 13 Nov 2007 11:17:33 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.248.6])
        by mx.google.com with ESMTPS id c24sm8975678ika.2007.11.13.11.17.31
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2007 11:17:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87lk9282nr.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64833>

Sergei Organov wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Sergei Organov <osv@javad.com> wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>> Sergei Organov wrote:
>>>>
>>>>> I want to get rid of origin/pu remote tracking branch. What do I do?
>>>>> I RTFM git-branch. What does it suggest?
>>>>> 
>>>>> git branch -d -r origin/pu
>>>>> 
>>>>> So far so good. However, it doesn't seem to work in practice:

[...] 
>>>       fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> [...] 
>>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>>> get rid of the remote branch? Currently it seems like a bug introduced
>>> by addition of wildcards refspecs, right?
>>
>> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
>> the '-d' option removes branch locally. It is meant I think to remove 
>> tracking of branches which were dropped in remote, as I think that 
>> wildcard refspec does create new branches, but do not delete dropped 
>> branches.
> 
> Isn't it 'git remote prune <name>' that is meant to remove tracking of
> branches which were dropped in remote?
> 
> Anyway, description of '-r' in man git-branch:
> 
> -r::
> 	List or delete (if used with -d) the remote-tracking branches.
> 
> Suggests it should be deleted. What's a point to delete it if it will be
> re-created on next fetch anyway?

Once more, with feeling.

By default now git creates on clone the configuration which essentially
says to fetch (get) all "proper" branches the remote has. (By "proper"
I mean branches residing under 'refs/heads/'). That is what the wildcard
spec above says.

Now when the remote repository dropped some branch (branch was deleted
on remote), te corresponding local tracking branch (in
'refs/remotes/origin') does not get deleted.

You can delete _all_ "stale" tracking branches, which means deleting
all tracking branches for which corresponding tracked branches were
deleted on remote. Or you can delete _one_ specified tracking branch
using "git branch -r -d".

Note that you told git to delete tracking branch, not to stop tracking
all branches in remote (as in above wildcard regexp), or stop tracking
some branch (the configuration earlier version of git created on clone,
without wildcard pathspec). So when you ask git to fetch from remote
again, it happily re-creates deleted branch. Note also that git *cannot*
distinguish (yet) between newly created branch on remote, and branch
which tracking branch you have deleted, either by accident or on purpose.

As to documentation: <tongue in cheek> if you cannot distinguish
between tracking branch and tracked branch then it is your damn fault
;-PPPP </tongue in cheek>


Analogy: if you delete file in working area (git branch -d -r), and
checkout again (git fetch), the file will be resurected.

>> So I'm not sure if it is a bug, misfeature or a feature.
>>
>> Can anyone better versed in wildcard refspecs speak up, please?
> 
> Yes, please!

I'm most interested if "fetch = !refs/heads/branch" or 
"fetch = -refs/heads/branch" works as a way to specify exclusions
from refspec.


P.S. Solution would be to use git-remote or ls-remote and some magic
to generate full list of refspecs instead of wildcard refspec.

P.P.S. We used to have similar problem with the introduction of
wildcard refspec, namely: which branch from all fetched to merge :-)
-- 
Jakub Narebski
Poland
