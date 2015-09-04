From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: enhance Git-GUI's Checkout Branch screen
Date: Fri, 04 Sep 2015 15:16:27 -0700
Message-ID: <xmqq37ytg79g.fsf@gitster.mtv.corp.google.com>
References: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
	<20150904044224.GA20164@gmail.com>
	<CALsXy+2N++xDXiiX2q1p43Sk7hW1Uh7oeQQO25Fp23H21JJpxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	IT Dev2 <john.kobinski@uniteddrugs.com>,
	SysAdmin <sysadmin@uniteddrugs.com>
To: John Medema <john.medema@uniteddrugs.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:16:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzHu-0000uN-EH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760260AbbIDWQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:16:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32855 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760143AbbIDWQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:16:29 -0400
Received: by pacex6 with SMTP id ex6so36014773pac.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AyHgsH1GNoCFjRxR4lhlMaeLIaWFKHYxSXs1NOQBsOo=;
        b=B9h2B74rsDcOzq7ptBAzKlloR1GjpAywuMV+d4FS7dgNrG1sF5cGTV5bt5owJVWHOu
         lXtId1MJQQQ992DudA7oSXf/BkJ8+L7vgOoHnKghD2GKMe6ogq/9uHDa+p8kXKE+f/iY
         SbArzWYqWBUgUWT24yHliWrRgUTHi9HQ2NfvsktjWkTcC7lQxu6ZfHKR8V48YLQKcL1R
         2Y3YMuwmpg1Rji26GGp56lbDzbKRz/HzAZyWV+nZi8hCQkvLDcRUkcMdGKxkEqT2ujD6
         EyWQzkZM5R3PnUax0h2QLJd5b5UWgOSz97Su6iZJUR39BRoH8yteIr9GDFbuShLINk3Y
         HxMg==
X-Received: by 10.66.219.163 with SMTP id pp3mr13276286pac.8.1441404988909;
        Fri, 04 Sep 2015 15:16:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id uv5sm3645221pbc.12.2015.09.04.15.16.28
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 15:16:28 -0700 (PDT)
In-Reply-To: <CALsXy+2N++xDXiiX2q1p43Sk7hW1Uh7oeQQO25Fp23H21JJpxg@mail.gmail.com>
	(John Medema's message of "Fri, 4 Sep 2015 11:40:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277341>

John Medema <john.medema@uniteddrugs.com> writes:

> Option D has the downside that it changes the behavior of more code
> (cmdline and gui), which is why I didn't suggest it before.  It also
> has the downside of making the branch list longer.  But that's the
> nature of cloning; if I copy a full directory of files to a new
> directory I expect to get a full set of files.

You shouldn't be too literal with the word "clone".  The reason
people "clone" a project often is to work on their own thing, which
may be based only on a handful of branches the upstream publishes.

So I do necessarily buy "But that's the nature" argument myself.

Not doing your option D has another benefit, other than "smaller
number of branches" you mentioned, and it is more important one in
practice.  Once you start your own development with your own set of
branches, you want to see the names of _your_ branches in your
repository, not mixed with 47 other uninteresting branches your
upstream has for its purpose.  Whey you are working on fixing
something for the maintenance track of the upstream, you do want to
see your 'fix-that-thing' local branch forked from 'maint' branch of
the upstream, and you may or may not also want to see a copy of
'maint' branch in your local branch namespace, but you certainly do
not want to see 'master', 'next', 'pu' and all the topic branches
the upstream uses to build and advance these branches ahead of
'maint' that you are currently focusing on.

In fact, with ancient versions of Git, you got copies of all
branches your upstream has as your local branches.  This turned to
be unusable and was corrected at around v1.5.0 release---this was
done primarily so that we can have a sane remote-tracking, but
uncluttering the local branch space was also a reason why we
transitioned to the current "separate remote" layout.
