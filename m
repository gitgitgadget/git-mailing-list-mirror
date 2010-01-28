From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 16:18:58 -0600
Message-ID: <b4087cc51001281418m3f19d765rd9aab03a339f15a4@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> 
	<b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> 
	<69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:19:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nachy-0002Xn-SE
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 23:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab0A1WTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754043Ab0A1WTU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 17:19:20 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58279 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab0A1WTT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 17:19:19 -0500
Received: by ewy19 with SMTP id 19so1290273ewy.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 14:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=SQyayPbTBbcGuw1aBPXsm+H2bcviX0kkB8ecszcJEi8=;
        b=EpI4e4nHy+gRsBZZUpTktsMOtt9NwtOBlBmau5OzsAWsYwx9kPqYhshe8ZJ8zq727s
         vEyu8h1UWA8bS64rBYsncxwcT3o1pm4l3h0oxm673Ie3tcxy9jxFyQx0fm/XubSSErGe
         dcYhQYZNTJPZzbJPjoZZxd0dt5sbltix7vvVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cgZGHBWtlZyq1zIVFClV3/MYB1BHpoYXCeLFhOJmWUbP9SpYOL7fhxX/okzg8cLu5H
         t6ZTERCP8Tjg8MOUZPi8mDvtEG6pY2hE/2BLvGE7gL/8PNjDEJsCANAF2oBiLmPQ+fA/
         68EzrOa/8P32CcPmc8zWBYz9+WnYZmgXTj5d8=
Received: by 10.213.109.70 with SMTP id i6mr8217911ebp.16.1264717158096; Thu, 
	28 Jan 2010 14:19:18 -0800 (PST)
In-Reply-To: <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138279>

On Thu, Jan 28, 2010 at 3:17 PM, Mike Linck
<mgl@absolute-performance.com> wrote:
> On Thu, Jan 28, 2010 at 1:03 PM, Michael Witten <mfwitten@gmail.com> wrote:
>> On Thu, Jan 28, 2010 at 12:44 PM, Mike Linck
>> <mgl@absolute-performance.com> wrote:
>>> ...
>>> It seems that after a topic or bug branch is merged back into its
>>> parent, especially if it was fast forwarded, it becomes hard to
>>> determine what changes were made in it, to resolve the problem that it
>>> was created to address.
>>> ...
>>> I understand that there are mechanism kind of available to address
>>> this problem.  If we (all developers in my company) remember always to
>>> rebase -i before they merge their topic branches back in, then it
>>> could be squashed making it easier to identify and cherry pick onto
>>> other branches...
>>
>> For now, you should probably rely on graphical tools like gitk in
>> order to visualize the various branches. There's also `git log
>
> Well, even gitk can't show me the information I'm looking for if the
> parent branch ended up fast-forwarding to include the changes made in
> the topic branch....

As Jens Lehmann pointed out, use something like:

    git checkout master
    git pull --no-ff . topic

>> --graph'. You could also just keep your branches around for reference
>> and use `git merge-base' as necessary.
>>
> ...
> it seems that a branch is only useful for merging once and unless the
> branch was squashed in the process of mergin, good luck identifying
> your change set for a particular topic.
> ...

I would think that you'd only care about the contiguous commits
between merges anyway.

> I just looked at merge-base.  It doesn't seem to address the problem.
> I grabbed an old topic branch from our repo which I knew was created
> from master and at some point merged back into master via
> fast-forward.  I checked it out, I called "git merge base topic-id
> master", hoping that it would "output a commit which is reachable from
> both A and B through the parent relationship."  Instead it seems to
> have modified the topic branch by fast forwarding it to the include
> all the changes up to the tip of master.  Clearly not what I'm looking
> for.

You incorrectly used `git merge' rather than `git merge-base'.

This is kind of off the top of my head. Try something like this:

    merged_commit_0=$(git merge-base master topic-id)
    merged_commit_1=$(git merge-base master ${merged_commit_0}^)

I think that should give you the range of commits between the last 2
merges (for at least simple cases). Then:

    git log $merged_commit_1^..$merged_commit_0

or

    gitk $merged_commit_1..$merged_commit_0

to see them.

You could, I suppose, keep looping until you find the oldest
merge-base that is still in the topic-id branch. To do so, the
following information may be of use:

    http://marc.info/?l=git&m=126457707700573&w=2

Anyway, it's probably best to use Nicolas Pitre's suggestion to use
tags to mark commits yourself, but the above might be useful if you
haven't.
