From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 01:49:54 +0530
Message-ID: <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
References: <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com> <20130410200548.GC24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 22:20:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ1VY-0002xw-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936228Ab3DJUUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 16:20:36 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:47886 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935153Ab3DJUUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 16:20:35 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so256092iaf.32
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NvEEyux5JFYBlDQpCTWQ9kcagRBGrZSlQRe7sGpbBGg=;
        b=t/a8CgX0AiLgIY1IOWf6gIfk3vG7mhO0DfbW996t4wtYeO2CZ9H0cNXp0YUx3K59zV
         tM45oZniaoE3haqnHJ8VdzXh9VQd0U2kE+CbN6ixtLA63lFE/NxcU56Chpyl4yGuiQ7L
         sgh+m/ZFxc6i8K692SmAmmQJbdUJTUr2hZ6WZifkklwRheidACyiEIGBTTBBKlot+wB4
         JxeFn/rKl/DmlgMfjGKT27KWFGnZ2EVdkRa0/IiMEK/ZuXUZV+vdHV9clYMEGzZOdFfX
         pw5cjyvNqNAwVVdYRCqe/1rf38+lXGwC8/NGY00Z/caWBwLiTxjLf3KN5RZ5WvtAK7pt
         jzMA==
X-Received: by 10.43.9.68 with SMTP id ov4mr2199540icb.22.1365625234874; Wed,
 10 Apr 2013 13:20:34 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 13:19:54 -0700 (PDT)
In-Reply-To: <20130410200548.GC24177@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220751>

Jeff King wrote:
> On Thu, Apr 11, 2013 at 01:23:57AM +0530, Ramkumar Ramachandra wrote:
>
>> Ramkumar Ramachandra wrote:
>> > git push -- master next; pushes to my current branch's
>> > branch.<name>.pushremote?  Isn't that a disaster?
>>
>> Actually, branch.<name>.pushremote already breaks the current design
>> in a way, as Junio pointed out in a different email: a push.default
>> set to anything except "current" is already nonsensical.  Why should
>> "matching" branches be pushed to the remote that my current branch
>> specifies?  That might well have their own branch.<name>.pushremote
>> configured, which should be respected.
>
> I'm not sure that it should be respected. "master" is short for
> "refs/heads/master:refs/heads/master", and does not mean "push master to
> where I have it configured to go" at all.  That may be what the user
> means, but changing how "git push" works is going to create
> inconsistency with other cases.

Yes, I know "master" refers to the refspec in the above, not the ref
(ie. branch).  Hence branch configuration should have nothing to do
with this.  That's just the way things currently are: doesn't mean
that it's perfect; and I'm just throwing ideas around.

>> We should fix this now.  I think the fault lies in the rather old
>> design of push.default.  Do you have any suggestions as what would
>> make sense here?  Ultimately, I think a git push; needs to pick
>> remotes for each refspec separately.  The orthogonal design is
>> definitely not right in my opinion.
>
> Right, the example above might include multiple remotes if pushremote is
> respected. Or it might not come up with an answer at all for a tag.
> If you do:
>
>   git push -- v1.2.3 master
>
> where does v1.2.3 go? To remote.pushdefault? That seems simple and
> consistent, as there is no ref-specific pushremote defined.

remote.pushdefault indeed.

> But I'd
> guess that the user probably _wanted_ it to go to
> branch.master.pushremote.

Huh, why?  Simply because he specified master alongside it?  How can
we infer what you said in a consistent system?
