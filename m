From: Nico Williams <nico@cryptonector.com>
Subject: Re: Amending merge commits?
Date: Tue, 29 Jul 2014 15:19:14 -0500
Message-ID: <CAK3OfOgZt55+tKv5455Jk-F=buULtftmCasbxHYcxGzppbWcfg@mail.gmail.com>
References: <CAK3OfOjr6ej5VdGU=bLmtag9cca1=ogLxVakCFTMG7b-A2uBiA@mail.gmail.com>
	<87r4147agk.fsf@osv.gnss.ru>
	<CAK3OfOhFzbUA7gZbox84W=VC+0aSuiNc-XRP_MTyYy1UeFFzZQ@mail.gmail.com>
	<DFE66A48CBC646E795B3B4A0903AB19E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergei Organov <osv@javad.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Besen, David" <david.besen@hp.com>,
	git discussion list <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 22:19:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCDrl-00016m-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaG2UTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 16:19:16 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:43625 "EHLO
	homiemail-a104.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212AbaG2UTP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 16:19:15 -0400
Received: from homiemail-a104.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a104.g.dreamhost.com (Postfix) with ESMTP id 5223220047B8C
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=nxXNa6c8mS/74rWXmV5X
	dlSjphU=; b=Seh+UJJQSPMcS5fjRfnvDElCf0mZE9mWJ6QAENBiRKjXI8q80dtr
	EJudGmM+apeir8fsB4fbeqyggGL0LwJruGgPRJO/bMJFE+dkAL+65cHMlUsKs41N
	PeOfMDd/RQSbrYZbjEFW92egoKNOPQ115IqePZNJGwB4Xx3L6j5UsDk=
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com [209.85.213.182])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a104.g.dreamhost.com (Postfix) with ESMTPSA id 34A7A20047B8A
	for <git@vger.kernel.org>; Tue, 29 Jul 2014 13:19:15 -0700 (PDT)
Received: by mail-ig0-f182.google.com with SMTP id c1so1652466igq.9
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 13:19:14 -0700 (PDT)
X-Received: by 10.50.138.11 with SMTP id qm11mr439616igb.18.1406665154705;
 Tue, 29 Jul 2014 13:19:14 -0700 (PDT)
Received: by 10.107.128.169 with HTTP; Tue, 29 Jul 2014 13:19:14 -0700 (PDT)
In-Reply-To: <DFE66A48CBC646E795B3B4A0903AB19E@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254467>

On Tue, Jul 29, 2014 at 2:29 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Nico Williams" <nico@cryptonector.com>
>> Local merge commits mean that you either didn't rebase to keep all
>> your local commits on top of the upstream, or that you have multiple
>> upstreams (the example exception I gave).
>>
>> Conversely, if you always rebase your local commits on top of the
>> upstream then you won't have merge commits to worry about.
>>
> Whilst it may not be "the Git Way", I'd expect that in many less well
> informed companies, the need to keep merge commits fom other lines of
> development would be quite a common (political ) technique where some
> preparatory branch needs to be merged in before one's feature can be
> completed (similar to all those cases on the list when folk say 'builds on
> top of xy's commit deadbeaf)

The way we did this at Sun, first with Teamware, then later with
Mercurial, was as follows:

 - "projects" kept their own clone repos of the upstream
 - engineers working on a project cloned the project repo ("project gate")
 - engineers pushed/pulled to/from the project gate
 - each project gate had a gatekeeper whose job it was to periodically
rebase onto the latest upstream
 - then engineers would rebase onto the new project gate

No "merge turds" (Sun speak) were ever allowed in any upstream,
whether a project gate or the ultimate upstream.  All commits had to
be organized according to specific rules, and squashed.  These rules
applied at the project gate and in the upstream.

 - when the project was ready for integration the gatekeeper would
rebase and squash as necessary, then push to the upstream

(I'm eliding some details.  In particular when an intermediate
upstream rebased the previous head was left available as a "snapshot"
to make the equivalent of git rebase --onto possible.)

The upshot was: all local commits were always on top of whatever the
next upstream in the chain was.  Always.  No merge commits ever.

That workflow works just fine with git.  It worked really well at Sun
(with thousands of engineers working on Solaris alone).  And it should
work well for anyone who doesn't have two or more forked upstreams to
follow.

Nico
--
