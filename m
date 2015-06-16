From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 13:23:31 -0400
Message-ID: <CAHcr6Hbajyx5RV10rv2PWEa9ZyzyxA7jCx=auKxpnv3xjSjq7Q@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212827.GC25757@peff.net>
	<CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
	<20150616171005.GB18667@peff.net>
	<CAHcr6HYA=gpMTaJ5WOOmtEp+J4wBMz9D59fbByzsdBkPRf4CZQ@mail.gmail.com>
	<20150616171849.GD18667@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4uaI-0006TC-Lr
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883AbbFPRXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:23:35 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35761 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbFPRXd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:23:33 -0400
Received: by wiga1 with SMTP id a1so115439563wig.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ke0okD0kmWf/6od8yfiXDomttig1NXmBSKEe9IH1g74=;
        b=ixQcdOmSWP3f8DxXX49XsPnHmNvt4K3AN0a6lqoJYj+8TjBZtuldTV6E8VWsxt2cub
         Lms4xj4VUZa0Wu++yCMcHVI++01T17MJD6ouHUzHAonp9jm4/iq9lczKDPw5D+/O4kwv
         oFClDhIzTviFzJP7IxZwFRHxA5izXAbZG5sLFlcaAzVt3DrcsBckwWqt7SwOgLTWA8Jh
         i3ColWfNf+HWgD97z1fR4UgsMLRczudStRbMVG2f9tBWtXBLnZH2I3WL3EGCpafWqCqR
         PJB1agvy5jy/BH7cHH1O5WGQIUNZfD9wg6D63gZgbktdkgQus2GTe1EBjLdV71OEYFrB
         n0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ke0okD0kmWf/6od8yfiXDomttig1NXmBSKEe9IH1g74=;
        b=Z5PUkNkZSpxKvvviVaAgqt0SWw9P1m+hdRhuncY0Ew8kfSqf6WMWPq3u6gWObz6jz3
         sKL8jTsuEWkIq7pGZrOA9ix6j13YjleMxYWrrCYJp8prXkrBGK28teJYqPebKaNzINdd
         3l3yFPGCpfz3IOkKP+BIEZOLBY/SRFJRsfNvPE75wa298Hcu4WHJV9HtPQcupMvUBDsi
         H/feBtUuvxMBZKp11Li48sJZRd5LzbznFX0zEDNXVz4ahzwtaE3kpvfWb1GYsU8q5nn5
         0qggWAEbq2fbu1VmACLU1VmAWvYbTg3Y/WfUCRWD67Kn/imp4GpOT+9w851R2m1e8qcV
         yi/Q==
X-Gm-Message-State: ALoCoQnryCKHmUHqOS6N6sUcerTA8Ao3PDjbhmU3fpUy88YsgDEV/yGd+IUU7f94UAVvvVKJRvWz
X-Received: by 10.180.86.198 with SMTP id r6mr45909085wiz.70.1434475411987;
 Tue, 16 Jun 2015 10:23:31 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Tue, 16 Jun 2015 10:23:31 -0700 (PDT)
In-Reply-To: <20150616171849.GD18667@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271783>

On Tue, Jun 16, 2015 at 1:18 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 16, 2015 at 01:14:03PM -0400, Augie Fackler wrote:
>
>> Yeah, not having it for the push side is a slight bummer, but in
>> general I haven't had problems debugging git clients pushing bogus
>> data in the same way that I've had problems with weirdness in new
>> server features.
>
> Being in charge of a large git server farm, I think I have the opposite
> problem. :)

I've got plenty of servers too, but we haven't typically seen
push-time problems. Maybe we're lucky, and now that I've said
something and tempted Murphy I'll suffer torment. :)

>
>> > Here's a rough cut at the "trace stdin" idea I mentioned earlier (which
>> > is essentially an internal "tee"). You can collect the incoming pack
>> > like:
>>
>> Neat, but not sure I like the extra overhead of having to grab the
>> full trace and then reconstruct some arguments to be able to diagnose
>> the pack. Having the verbatim pack just land on disk is really handy,
>> because then any existing tools one has cooked up (my team has a few
>> weird one-off ones by now) just work without extra fussing or looking
>> up steps to reconstruct the whole file.
>
> I guess there is really room for both. Just because you _can_ accomplish
> the same thing with both does not mean we cannot have two ways to do it
> (an easy way, and a harder, more flexible way).

*nod* that might make the most sense - given that we both seem to have
use cases in mind for verbatim packs on pulls, that seems like a good
thing to have easy to deploy.

(It still seems to me more likely to write custom servers than
clients, but then again custom VCS servers has been my life for a
while, so I likely have a weird perspective on things.)

>
> -Peff
