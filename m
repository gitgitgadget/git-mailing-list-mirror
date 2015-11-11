From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Wed, 11 Nov 2015 15:34:27 -0800
Message-ID: <CAGZ79kYiPb-GJ37Zq-2ULpLD8Lh_3qAxa0W+u6+5fMrX6YzJdw@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-9-git-send-email-sbeller@google.com>
	<56426DD1.6090904@web.de>
	<CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
	<56439D1E.8080102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZweuP-0004UU-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 00:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbbKKXe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 18:34:28 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33269 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbKKXe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 18:34:27 -0500
Received: by ykdv3 with SMTP id v3so76805130ykd.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 15:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JUpbwNOm/fWw4p3KGVDQ4+xIE/L+NzURDDH6ibeiIB8=;
        b=nRUgssApKQaMYbVMZeIEslNLKg6x9MYWO45E7rxKQf8EzouygI09KlLMKrZQocldih
         7M0TdBTJlyctAptsKvN2mmUufagloHwiSwfTDnaVfx0dqrCFOcC7VyZ7iYmJlUHuhnWL
         SQJwOah+HXNqNDraOHIfI/84FfoiEfCYwut8Us/Bs/TtPsFIz7ekJCmqJl+cSYy2q5RX
         JsgL+ay6CbjH4ekTiHCyhjUtJYWjMSzEDHlSHlIv/8/N+tdTbxs13BYuVBU6ClgWQJNM
         Qh0KKAKkeS4T8gVrhvwSwwmlipRp+rs2NRraZNQ9r08ZKMcuWKZmuwHOq7/6nsGKNLGJ
         3akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JUpbwNOm/fWw4p3KGVDQ4+xIE/L+NzURDDH6ibeiIB8=;
        b=EXqQpA8fhTT3zUoqNfTYyMwuBh3c0p1WRG7ZzzTangemOzleFLBJtVHQ4JnN9qS2ob
         42/NGl1P2ufQIuumG9DO1HnIOkefuBAx3+A752zellPUc3kk3FM7QrQmbRQHXUBiHdUx
         K4ierPBZ+/AzXuqBX/+pzfKcYyan8xL2a6yyYueFXez+8hKcTHgHx/j9Tohx6oKBcz+s
         kMZAHc0tgkart36gh5yT1Ci7znVqVbXiX/rYs1UlCBnrKvYNt9Wjcw8uF5SQNQpSbIg7
         ElTHaMaB3ShYOQQ1kRAcKMKndiB5C1tNsH6LWdmgxLpDxBscSo1/yn0seroEvEC+uIQw
         gXIg==
X-Gm-Message-State: ALoCoQnfmoZNEYlmn8ufILkSgZMm/d7pRM1rXTVI67DrWEIHZ24uS6qQhrNbcQoa+zMQ4dstaU19
X-Received: by 10.13.210.4 with SMTP id u4mr13017619ywd.68.1447284867154; Wed,
 11 Nov 2015 15:34:27 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 15:34:27 -0800 (PST)
In-Reply-To: <56439D1E.8080102@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281207>

On Wed, Nov 11, 2015 at 11:55 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> TL;DR: checkout is serial, network-related stuff only will be using
>> submodule.jobs
>
>
> My point being: isn't "jobs" a bit too generic for a config option that
> is only relevant for network-related stuff? Maybe "submodule.fetchJobs"
> or similar would be better, as you are already thinking about adding
> other parallelisms with different constraints later?

Actually I don't think that far ahead.

(I assume network to be the bottleneck for clone/fetch operations)
All I want is a saturated network all the time, and as the native git protocol
doesn't provide that (tcp startup takes time until full band witdth is reached,
local operations both on client and server) I added the parallel stuff
to 'smear' different submodule network traffics along the timeline,
such that we have a better approximation of an always fully saturated link
for the whole operation. So in the long term future, we maybe want to
reuse an http/ssh session for a different submodule, possibly interleaving
the different submodules on the wire to make it even faster. Though that
may not be helping much.

So we're back at bike shedding about the name. submodule.fetchJobs
sounds like it only applies to fetching, do you think it's sufficient for clone
as well?

Once upon a time, Junio used  'submodule.fetchParallel' or  'submodule.paralle'
in a discussion[1] for the distinction of the local and networked things.
[1] Discussing "[PATCH] Add fetch.recurseSubmoduleParallelism config option"

How about submodules.parallelNetwork for the networking part and
submodules.parallelLocal for the local part? (I don't implement parallelLocal in
the next few weeks I'd estimate).
