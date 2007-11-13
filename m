From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 17:03:16 +0100
Message-ID: <200711131703.16357.jnareb@gmail.com>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:04:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IryFc-0004CK-K4
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 17:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbXKMQD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 11:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbXKMQD2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 11:03:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:65496 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbXKMQD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 11:03:26 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1849125fkz
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=kiv0z0EKaJHr/kAkhmivSxDKKyTTEJLJmHTNlgZDi0U=;
        b=It9ee6Vknv+tXw67PRt4c6ucck4YjRDsqgQyPd/ybgKwpoZ6yh9UYjPn7Pzl2E91wofrujwJzBXIpy59HVpFcbu4rBQldJSlOovMh/ePKcIyA16mNzNc5AmRbYzUTFMLWw00WwTCliSD1zC663H4qyx/ckXGnABk3ptASDidXHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VyvnuTbhJ4DPCxZy9h8P5zO/Uq0EkELSOTYaAx96WHLtcGu5usgRfgitFGhVQ6glTJw9IqHpnQTZGlsGWJv7ZyE2iRdHyeIbyYv/F5pu75YuJUJ1kKZTaWJZpdZZZZye7rBZ7+/wY8b2bQQIXnLkWJsh9wxHuHlk105gidxjOPQ=
Received: by 10.82.138.6 with SMTP id l6mr15008173bud.1194969804697;
        Tue, 13 Nov 2007 08:03:24 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.125])
        by mx.google.com with ESMTPS id b36sm146992ika.2007.11.13.08.03.22
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Nov 2007 08:03:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87ve86889o.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64812>

Sergei Organov <osv@javad.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Sergei Organov wrote:

>>> I want to get rid of origin/pu remote tracking branch. What do I do?
>>> I RTFM git-branch. What does it suggest?
>>> 
>>> git branch -d -r origin/pu
>>> 
>>> So far so good. However, it doesn't seem to work in practice:
[...]
>>> $ git branch -d -r origin/pu
>>> Deleted remote branch origin/pu.
>>> $ git remote show origin
>>> * remote origin
>>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>>   Remote branch(es) merged with 'git pull' while on branch master
>>>     master
>>>   New remote branches (next fetch will store in remotes/origin)
>>>     pu
>>>   ^^^^^^^^^^^^^^^^^^^ What???  
>>>   Tracked remote branches
>>>     html maint man master next todo
>>
>> Check out what do you have in .git/config file, in the
>> [remote "origin"] section. Most probably (if you cloned this
>> repository using new enough git) you have wildcard refspec there,
>> which means that git would pick all new branches when
>> fetching / pulling from given repository. 
> 
> Sure, I've cloned git.git using rather recent git, so .git/config has:
> 
>       fetch = +refs/heads/*:refs/remotes/origin/*

[...] 
> Isn't "git branch -d -r" supposed to do whatever magic is required to
> get rid of the remote branch? Currently it seems like a bug introduced
> by addition of wildcards refspecs, right?

No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
the '-d' option removes branch locally. It is meant I think to remove 
tracking of branches which were dropped in remote, as I think that 
wildcard refspec does create new branches, but do not delete dropped 
branches.

So I'm not sure if it is a bug, misfeature or a feature.


Can anyone better versed in wildcard refspecs speak up, please?

-- 
Jakub Narebski
Poland
