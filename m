From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: shorten "push.default is unset" warning message
Date: Tue, 23 Feb 2016 20:47:12 +0100
Message-ID: <vpqd1rngqf3.fsf@anie.imag.fr>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
	<xmqqtwkz1c4b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 20:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYIvh-0000Ml-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 20:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbcBWTrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 14:47:25 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49261 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbcBWTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 14:47:24 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJlA4x031634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 20:47:10 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NJlChP014303;
	Tue, 23 Feb 2016 20:47:12 +0100
In-Reply-To: <xmqqtwkz1c4b.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:05:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Feb 2016 20:47:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NJlA4x031634
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456861631.91809@43CcNAY25UzIZ0MjEd7pCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287105>

Junio C Hamano <gitster@pobox.com> writes:

> The punchline of that question is:
>
>     I can obviously set it to one of the values mentioned, but what do
>     they mean? What's the difference between simple and matching?
>
> It tells us that "See 'git help config'" is not such an effective
> message to help such a user.

[ The teacher inside me speaks ]

Don't underestimate the ability to ignore any pointer to the doc from
many users.

In many case, when a student comes to me scared about an error or
warning message, I just ask the student to read the message to me. If
it's in english, I sometimes have to add "so, what does this mean in
French", and in many cases it's sufficient.

>> Shorten the warning and mention only the way to remove the warning
>> without changing the behavior. Keep a pointer to the documentation so
>> that people willing to learn can still find the alternative behaviors
>> easily.
>
> While I admit that I usually am the most cautious one when dealing
> with any change, I am not sure if this rephrasing helps very much.
> As we saw, the sentence you kept, "See 'git help config'", is not
> effective in helping those stackoverflow users.

Right. But assuming someone who reads the complete message, I found that
keeping only the first lines without a pointer to the doc make the text
kind of mysterious:

  warning: push.default is unset; its default value has changed in Git 2.0 from
  'matching' to 'simple'. To squelch this message and adopt the new behavior, use:
  
    git config --global push.default simple

Alone, this really looks like a magic formula like "I'm showing you this
warning just to bug you, but you can get rid of it with ...".

> If most people are happy with "simple" (and certainly that was the
> assumption and hope behind the transtion we made at 2.0), we may be
> better off removing the warning altogether.

To me, this is the plan. I have no strong objection in removing it
completely, but I think it makes sense to keep a lightweight one for a
while: if people use different machines with different Git versions
(especially if they ever use a version in the interval 2.0 to 2.3 which
claims to use simple but actually do not), then these people may
appreciate an incentive to set push.default.

OTOH, if they use different Git versions, they will eventually get the
message.

> After all, push.default configuration is hardly the only case where
> there are other ways to use Git that may match the user's situation
> better, and we do not advertise "Oh by the way you can do things
> differently, study the manual" for any of them with a warning
> message like this.  Those who want to do different things know to
> seek settings to tweak.

I completely agree with this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
