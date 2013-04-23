From: Johan Herland <johan@herland.net>
Subject: Re: git fetch refs and tags
Date: Tue, 23 Apr 2013 14:16:18 +0200
Message-ID: <CALKQrgf2UxC3h2ApJ-ug=B-Pg_gxf_4=FV1MSmfdt9S2Ut5YFA@mail.gmail.com>
References: <1366714421.2899.10.camel@lws-weitzel>
	<CALKQrge2vHqA1HitpdJKYQu0KY5+XkFdrN_Gg254gW_ih57o=Q@mail.gmail.com>
	<1366717552.2899.17.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: J.Weitzel@phytec.de
X-From: git-owner@vger.kernel.org Tue Apr 23 14:16:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc9B-0006Sg-9d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab3DWMQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:16:29 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:62831 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab3DWMQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 08:16:28 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUc92-000CoY-OF
	for git@vger.kernel.org; Tue, 23 Apr 2013 14:16:26 +0200
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UUc8z-000NCM-UH
	for git@vger.kernel.org; Tue, 23 Apr 2013 14:16:24 +0200
Received: by mail-oa0-f46.google.com with SMTP id k3so486361oag.19
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 05:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MIC6sm2uUyBpq1KbsG9oYwhNH+lu2RZgvGPSqYqEIJs=;
        b=YtmBABGCfqt/7nOpH9s3xPZXoyiZLNhH6cc0GAV7PpaBzYBkO6XRLNBeF1d3m5Noq5
         IX6kPCwwZVaqlhy7qtPW8YctqGDVZLu+cW4A2MeErAbM3GQ+GNEsaqw4THXNG/tV3TeC
         o8GSZ1K8frqqeyc4d+NbqwhF5kKkzYxujbr6JOXZiSNfrq4O1AHq06ofK0v3bFE6c/MW
         CmD21Gkv7462tN4gMKICGOwoO8IzEfXZFtWdm1t1zUDeCiEouz3o5z2F1JTHezMml/C/
         pCFmzt2/QyRvkk8CEN6Xss2s80oSeKHxfzJ4nLke4jFEcx9Ov+z6nbPgmsvHAadOzHiC
         ghyw==
X-Received: by 10.60.29.37 with SMTP id g5mr12227029oeh.140.1366719378443;
 Tue, 23 Apr 2013 05:16:18 -0700 (PDT)
Received: by 10.182.210.233 with HTTP; Tue, 23 Apr 2013 05:16:18 -0700 (PDT)
In-Reply-To: <1366717552.2899.17.camel@lws-weitzel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222154>

On Tue, Apr 23, 2013 at 1:45 PM, Jan Weitzel <J.Weitzel@phytec.de> wrote:
> Am Dienstag, den 23.04.2013, 13:25 +0200 schrieb Johan Herland:
>> On Tue, Apr 23, 2013 at 12:53 PM, Jan Weitzel <J.Weitzel@phytec.de> wrote:
>> > Hello,
>> > I have the following problem: I have 2 bare git repositories one has
>> > several branches and tags.
>> > If I try this in the second repository:
>> > git fetch -f ../main.git refs/heads/master:refs/heads/master
>> > I'm getting also tags from other branches, if I have an old object from
>> > one of the other branches.
>> > I would expect to have only tags pointing to master ref. (Although the
>> > man pages points to the behaviour regarding dangling objects). Is there
>> > a way to avoid this? I only find --no-tags which results in having no
>> > tags at all. Or need I git purge to remove the old objects first?
>> > My goal is to fetch only specific branches and the related tags.
>>
>> AFAIK, Git should only auto-follow tags that are reachable from the
>> branches you fetch (in this case master). Are you saying that you get
>> tags pointing to other history that is NOT reachable from the master
>> branch? (i.e. are you getting tags for which "git merge-base $tag
>> master" is not equal to "git rev-parse $tag")?
>>
> exactly. I reproduced it by coping a object from an other branch to the
> locale repository. This results in fetching the not reachable tags.
>
>> Re-reading the man page, I do see the following:
>>
>> "if the repository has objects that are pointed by remote tags that it
>> does not yet have, then fetch those missing tags. If the other end has
>> tags that point at branches you are not interested in, you will not
>> get them."
>>
>> This can be interpreted as saying that even unreachable objects in
>> your local repo that are pointed to by some remote tag will cause that
>> tag to be fetched, and in effect resuscitate the
>> previously-unreachable object. If this is indeed how it works, I would
>> be tempted to label this a bug in the auto-following behavior, as it's
>> probably not what most people would expect. In that case, yes, you
>
> Yes my first understanding of auto-following behaviour was wrong ;)
>
>> should be able to get your desired behavior by first purging all
>> unreachable objects. Something like "git gc --prune=now" should do the
>> job.
>
> Because I run this by scripts is there a way without porcelain commands?
> I saw even git prune is one.

git prune is not sufficient, since it only removes _unpacked_ and
unreachable objects. You first need to create a new pack that does not
contain unreachable objects (git rebase -a -d), but before that you
also need to expire reflogs (git reflog expire ...) and you should
also prune packed refs (git pack-refs --prune ...).

In short there are a number of commands you need to run, and in the
right order and with the right options, but "git gc --prune=now" is
basically just a wrapper around these that Does The Right Thing(tm). I
would just use that instead.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
