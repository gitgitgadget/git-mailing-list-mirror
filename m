From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 09:53:54 -0500
Message-ID: <CAMP44s0DjCunjHHEs1SZoR502Uyk7LdGeBDz4nxqgG0GmdEDng@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
	<CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
	<CALkWK0nOywB5BtHnKZQ_+wsJNp82zk7-YJw_S15quqH+iU=jWg@mail.gmail.com>
	<CAMP44s2vsD2uwFoL5_79m05gtqyKLN9wHX8Yrhtn0kT4LVULxQ@mail.gmail.com>
	<CALkWK0m+_AbCd305dU5p5bxwuPPCBKJH7a3e6rHgxxnySMz0pQ@mail.gmail.com>
	<CAMP44s1eB+bvg7vnG5S3SBACHTrkpCqJNX-Q2tzEVdvzFWvkcA@mail.gmail.com>
	<CALkWK0nBUHHkqOQannMu5Kjs00Fro8KBbiocfsT4Uf74jO9FgA@mail.gmail.com>
	<CAMP44s2HPXnudioSSj0O_r2PbmbAqcyTORJNhRL_a=NWu_niBw@mail.gmail.com>
	<CALkWK0my3kET2hdZre57NiNxiENoZ+XVLYjU-XMs+Xoche9QoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 16:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UczZB-0005mp-4q
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 16:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252Ab3EPOx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 10:53:57 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:53197 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab3EPOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 10:53:56 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so840790lbh.41
        for <git@vger.kernel.org>; Thu, 16 May 2013 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9sUoPp8ksEjhIlCjm5Ha5Jpgi2ECcJPRqG/XuPK+zmg=;
        b=qPZLZnxgwMRa1f+3Eb48y6vxeKyuHS5KwZGIWpB9W44eo7Qzg1SE4gWy7Kp7cQwviF
         BYLjxiqpkRCejPz0ehK4FKycvZbBG7tEG/lPahBVB2EFxvabPJ9iLu3spAHFboVR9rq3
         Iqnidn8QqkR/flr7Cgl4j9wMRsuvkapOq1GOVHVGNy/bqqwnq/aLbCE6egaXslaEcAMX
         4LluOXSfKh+73WtuQ9CiYdwIpJAxC4ERXP5I/0ohbEd3cmBwNIFUaXkZ+Z3dDWYM6Js5
         gi+B8q30Jql5LGk1M5MexV3D0yZxfit+PxkRCeT0w9vi6pgpd/3GSOx+bH9MGrRk+NGG
         epIA==
X-Received: by 10.152.120.4 with SMTP id ky4mr20683775lab.5.1368716034937;
 Thu, 16 May 2013 07:53:54 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 07:53:54 -0700 (PDT)
In-Reply-To: <CALkWK0my3kET2hdZre57NiNxiENoZ+XVLYjU-XMs+Xoche9QoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224570>

On Thu, May 16, 2013 at 8:52 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Does branch.<name>.merge overrides remote.<name>.fetch? No. They
>> complement each other.
>
> I often wonder if you are reading what you're responding to:

And I wonder if you care if what you say is actually true.

> remote.<name>.fetch is operated on by fetch, while branch.<name>.merge
> is operated on by merge; they are really orthogonal.

You keep saying they are orthogonal, but they are not. Read
remote.c::branch_get().

And try this:

[remote "origin"]
	url = git@github.com:felipec/git.git
	# fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master

Can you merge? No. Can you do master@{u}? No. Several other things don't work.

>> The same that 'git pull' does when both branch.<name>.merge and
>> remote.<name>.fetch are set.
>
> Are you reading this?
>
> git pull _fetches_ from remote.<name>.fetch and _merges_ from
> branch.<name>.merge.  What is "the same" in git push terms?  It's a
> simple question; which ref does push update: the one specified by
> remote.<name>.push or branch.<name>.push?

[remote]
	pushdefault = origin
[remote "origin"]
	push = refs/head/*:refs/heads/for/*
[branch "master"]
	pushremote = github
	push = refs/heads/new-master
[branch "next"]
	pushremote = origin
	push = refs/heads/new-next

% git checkout master && git push

Where should it go? github/new-master. Obviously.

% git checkout next && git push

Where should it go? origin/new-next. Obviously.

% git checkout main && git push

Where should it go? origin/for/maint. Obviously.

I don't see what the big deal is.

>> Of course it would work. Does @{u} stop working when remote.<name>.fetch is set?
>
> It doesn't work when _only_ remote.<name>.fetch is set: you need
> branch.<name>.merge to determine @{u}, just like you would need
> branch.<name>.push to determine @{d}.

So? The answer is no.

>> It is a downstream branch.
>
> Which commit does git show @{d} show you?  There is no ref called
> refs/for/master.

The same commit 'git show @{-10000}' shows you. The fact it doesn't
resolve to a commit doesn't mean @{-100} is not the nth-hundredth
previous checkout.

-- 
Felipe Contreras
