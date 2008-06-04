From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 04 Jun 2008 01:05:07 -0700 (PDT)
Message-ID: <m3mym1zkus.fsf@localhost.localdomain>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	<7vmym1zny4.fsf@gitster.siamese.dyndns.org>
	<18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3o0U-0008U4-PI
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYFDIFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbYFDIFN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:05:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:40627 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbYFDIFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:05:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1260492fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=4LpDYhfEFJ3cjz1rZPbIlzdaSDnXGbIl3hdK5fq6Zp8=;
        b=f9CR23XY99OGWXrGHP81eQ1Jkt5wg4CWnUiQdNErCp44clJgkbVA/6n99K29sbCiqmZOuhB9Rt/Otn1Tm3sTs7HtTrQHPsDyIqfU7sH8gWXgbb4M8KeLoI2jCU/RvV6WhrlgIOFXvFtCtJsMrrbMjA9vVUY3OpXgkcg1f/jDW/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=bt54NHLYD3H6fy0SYR5FOkbx/CjykJttBGMgslSFrf14aEauds2CAC5BaiHEWwqHz4LT0eaOo5k4JKKO1zUh6rbF3h9GE/F3qZCqESx2JqzD1alZjuUPG2t9MECREVh/svvae3zu82ucWzC/PfRzAkUWnfIfGlOblwX9obTZHFA=
Received: by 10.86.98.10 with SMTP id v10mr486073fgb.46.1212566709179;
        Wed, 04 Jun 2008 01:05:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.199])
        by mx.google.com with ESMTPS id l12sm1196489fgb.6.2008.06.04.01.05.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 01:05:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54851nI002067;
	Wed, 4 Jun 2008 10:05:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5484xX7002064;
	Wed, 4 Jun 2008 10:04:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83757>

David <wizzardx@gmail.com> writes:

[Please don't remove quote attributions]

>>> for C in $(git log --reverse <commit1>..<commit2> --pretty=format:%H);
>>> do git-cherry-pick $C; done
>>>
>>> Is there an easier syntax for doing this?
>>
>> rebase --onto?
>>
> 
> Thanks, I checked the manuals further, and it looks like this will
> (mostly) do what I need.
> 
> What's still missing is multiple cherry pick ;-)
> 
> In other words, is there a simple way to *copy* a large number of
> commits from one branch to another, without rebasing?

 # make temporary branch to not move to-be-copied during rebase
  $ git checkout -b tmp-rebase to-be-copied
 # copy commits; results are in just created temporary branch
  $ git rebase --onto branch copy-from tmp-rebase
 # check if everything is all right and rename temporary branch
 # to final name
  $ git branch -M tmp-rebase branch

That said, cherry-picking multiple commits is often requested feature.
I guess that git-sequencer GSoC 2008 project would help in having it
finally implemented.  BTW. why can't you use topic branches and
merging?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
