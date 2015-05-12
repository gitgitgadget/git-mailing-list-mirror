From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Tue, 12 May 2015 11:21:57 +0200
Message-ID: <CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 11:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ys6O6-0007cX-PM
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 11:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbbELJWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 05:22:01 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35411 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbbELJV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 05:21:59 -0400
Received: by wgbhc8 with SMTP id hc8so1641119wgb.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h/5EElYtvEq6tz7IpjdKpY0Lol76x18xHHo5fjkqYo8=;
        b=yZImcndw+D+3M2Hk6fzgv2/aWZ9C6kfIo0DSV8MVXmIsKDEK6GTCw9V90hh2zSUEfi
         llO9Z0XHwG00cC1JB6PsLB5ABuXkJOzUP9jX/xWUuWylPHFIjKgBC5mu0a2ze7GwOjWJ
         X4/iba2tQaA/MZ3dCINdAH/vUeiHLxUxwyUCuKB/dSRQMeHu6UMJKVIIWqXAaE93FXBq
         ynfwLN5/BR/QLvLUpiAi3YSdt+i445O+pV2NYgRI4SBIHdXfjlQVQYQRhJlu/kXPnmIW
         C+bG9kZUekZskALt8HRekWI4uU7wjXJvpQFw68zFWG2AgryW6Lr88jRTsllnL3+iiSlP
         YKXA==
X-Received: by 10.181.13.198 with SMTP id fa6mr28499298wid.41.1431422517834;
 Tue, 12 May 2015 02:21:57 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 12 May 2015 02:21:57 -0700 (PDT)
In-Reply-To: <xmqqfv73f420.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268849>

On Mon, May 11, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, May 11, 2015 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
>>>> line from bisect.c:show_diff_tree), but that is mostly my personal
>>>> opinion.
>>>
>>> Yeah, I think that is sensible. It may even be OK to just give a
>>> "log --oneline".
>>
>> Or maybe we could let the user configure the diff options or even the
>> command used when the first bad commit is found?
>
> That is a separate discussion.  I do not mind but I doubt many
> people would use it (I was tempted to say "doubt anybody would", but
> then was reminded how many people use Git, and toned it down), as
> long as we have a good default.  And I thought that this discussion
> was about coming up with a good-enough default.
>
> To be bluntly honest, I think the current one is sufficient as a
> good-enough default.  The first thing I would do after seeing that
> message is to either "git checkout <commit-object-name>" or "git
> show <commit-object-name>", and the current full 40-hex output gives
> me an easier mouse-double-click target than the proposed abbreviated
> one, so in that sense the original proposal may even be a usability
> regression.

Yeah, it might also be a regression if some users have scripts that
depend on the current behavior. That's why with a config option,
people annoyed by the current behavior can get exactly what they want,
and it makes it possible to more safely change the default to
something more user friendly the next time we change the major version
number.

> It is tempting to say that the output can be eliminated by always
> checking out the first-bad-commit (i.e. only when the last answer
> that led to the first-bad decision was "good", do a "git checkout"
> of that bad commit), but in a project where a branch switching is
> not instantaneous, that might be problematic (unless the first step
> the user would have done is to check it out anyway, of course).

Yeah, and speaking of regressions, elimiting the output might be a
more serious regression.

Best,
Christian.
