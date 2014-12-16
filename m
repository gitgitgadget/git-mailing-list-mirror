From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 12:36:15 -0800
Message-ID: <CAGZ79ka5o1fx_-rQfbrSngJOeD4wTSQm=ZfeeU-LAkxREKA9ew@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
	<xmqqk31r9w2w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0yr6-0002ou-Az
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbaLPUgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:36:17 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59464 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaLPUgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:36:16 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so13670744iec.36
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4DOMiJHgXTCJc/hqU13JpPVxdtI+r5IZK+5Gji7KHlQ=;
        b=G4Wdir0KtdKSsNYRO3Kg3tNyDjwgIViZW4fTWRun5AhJxlBWvIywXugcMLm+1qzeOJ
         +bSPR/gX5GVG41H45cB006Axs61ceIpnmEXykSSdyFMZBZZM79ppQJCbL0OjWjVkm2DI
         UipYAYo9gzuO56tbDgE7Mvd60rKAyaNcJyCRrhSLPie3IboklhXZsRKy4JwPnkp4oYdX
         XTGZHWyE4o3iDpmPe8Kxy6UfZbzEy1f75piQ0pdsM9mMrjcs55FwZKLaONIXd1W0fCGQ
         qhZv8MoeEUTLC5QKL+nTk7omGhX6U7EMsQFFe86dals8M4IiV97Cles4lWUtXhMJExir
         PlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4DOMiJHgXTCJc/hqU13JpPVxdtI+r5IZK+5Gji7KHlQ=;
        b=C1eICGiOfUZdinDytm4Do1KMox1DtLzmbGkz9ft3De1gTM/bML0JgkIR4ZBTfISWxp
         7R4gSwFEGPnkS9Xx2Pd6CpH5sGc2ULtA8zmPnoJKBMSWe6lROad+7G13PSsXLHbIYlq7
         Nc9TMdR+lUotcveZSW+OAFwR98PCiEjbah6kesJapWc2AH0e9PTgAPaF5tAqKDvkzARq
         K0M3WcANOwZQBkjkI1xiO87rqTe5wk6GBxo1nMTwg/SWU2lx8VPLIRL99I4sZ8Z8OU60
         GsMq7nyH9N0XAGOI0KMj1cWSxERp4U9BQRRT5vvnkPbZYdqfiCG+ZVXO3VhxkUbzEiL1
         U7fA==
X-Gm-Message-State: ALoCoQmDMoI/M2APe+QfwhbnYsOWMKpQbP+80JoJQxa5v7/qjKvsbRjKmqJLy6f3C/lMdSgTcI4W
X-Received: by 10.107.25.74 with SMTP id 71mr29458328ioz.70.1418762175197;
 Tue, 16 Dec 2014 12:36:15 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 16 Dec 2014 12:36:15 -0800 (PST)
In-Reply-To: <xmqqk31r9w2w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261468>

On Tue, Dec 16, 2014 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     > What's the value of this test?  Isn't it a non-fast-forward check
>>     > you already tested in the previous one?
>>
>>     I messed up there. Originally I wanted to test the 2 different
>>     stages of rejection. A non-fast-forward check is done locally and
>>     we don't even try pushing. But I also want to test if we locally
>>     thing all is good, but the server refuses a ref to update.
>
> It is tricky to arrange a test to fail a fast-forward check on the
> receiver side, because the local test is done by reading from the
> other side, not relying on your remote tracking branches.  The usual
> flow is:
>
>     pusher says to the receiver "I want to push"
>
>     receiver says to the pusher "Here are the tips of my refs"
>
>     pusher thinks: "Ah, I was about to update their master branch
>                 with this commit, but what they have is (1) not
>                 known to me so by definition I cannot fast-forward,
>                 or (2) known to me and I can definitely tell I am
>                 not fast-forwarding it, so I'd locally fail this
>                 push".
>
> You need to invent a way to successfully race with an ongoing push.
> After receiver gives the tips of its refs (all of which are
> ancestors of what is going to be pushed) but before the pusher
> finishes the "thinking" above, you would somehow update the refs at
> the receiver so that the push will not fast-forward.
>
> Such a raced flow would look like:
>
>     pusher says to the receiver "I want to push"
>
>     receiver says to the pusher "Here are the tips of my refs"
>
>     pusher thinks: "OK, everything I'll send will fast-forward"
>     pusher thinks: "Let's start generating a packfile"
>
>     you intervene and update receiver's 'master' at this point.
>
>     pusher send a pack and tells the receiver "I want to update your
>                 master from OLD to NEW".
>
>     receiver thinks: "Huh, that OLD is not where my 'master' is"
>
>     recevier says to the pusher "No fast-forward".
>
> But I do not think it is practical to run such a test.
>
> Rejecting on the receiver's end using pre-receive or update hook
> should be testable and should be tested.
>
> Thanks.
>

Yes, that was my understanding as well. I just messed up mentally.

Now that the update hook test is in place, we do have tests from the local
and the remote side rejecting, so it should be fine now.
