From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 9 Nov 2014 22:47:52 -0800
Message-ID: <CAPc5daUrUZ135sbSuZn6DXmN_momR6KxNyN9cNdTbzwbD6Uu0A@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
 <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
 <xmqqtx28b6z6.fsf@gitster.dls.corp.google.com> <20141110063035.GA7677@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:48:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnilv-0006EK-44
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbaKJGsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:48:15 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54218 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbaKJGsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:48:14 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so7639752pad.39
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 22:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VIDo2mGpHoX1arMBlPEeSD6hIb5ZGwhh9EpyAuCKfjY=;
        b=MSymZo5pYyL+0HjiL0RgUSzjIrfNCrELyCPXAod7L9AkgU8trp6j0iF/LdDvDPM8CE
         KNU5jVha4j0wDW4aFeY9Sk0du+DRyvqvdP9WyIYxHlOnsuyeK5DASG8O0JTSoRCAaLPT
         QemuvRIx8huFAScBGSHiB6CYqgUv/VOUel2tzcH94eCvQ3wAbDa3AuoQZ1OFXHF9IoZc
         L3E7lT5HFzFce5/J/V5pbcwmPPcVrJvJ01/bByHhBBP/caxOJj6gTHvvtd7UKf+j3YZq
         g1x65ia1YHYzL2++Dl0Lj/TRG63EQ0ik2Hhu9iIIc8RoYW1DMqVrWH2+lPOl9xAOnTuz
         mV9A==
X-Received: by 10.69.26.38 with SMTP id iv6mr1503616pbd.154.1415602093735;
 Sun, 09 Nov 2014 22:48:13 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Sun, 9 Nov 2014 22:47:52 -0800 (PST)
In-Reply-To: <20141110063035.GA7677@peff.net>
X-Google-Sender-Auth: C55JTCvY3rs0XmNqvr62Fv2uS84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 9, 2014 at 10:30 PM, Jeff King <peff@peff.net> wrote:
>
> I know you "make test" before pushing out the results of any integration
> you do. And I recall that for a while (and maybe still?) you even did so
> on VMs of a few common platforms. OS X is notoriously irritating to run
> in a VM, but would you be interested in a network-accessible install
> that you could push to and "make test" on as part of your routine?
>
> If what Michael is offering cannot do that, I am sure I can get GitHub
> to set something up.

Even if it were network-accessible, the latency for doing an integration
cycle and pushing there and waiting for the tests to come back may
make it impractical to use it as "part of pre-pushout test".

But I would think that the project certainly would benefit if a
post-receive hook at Github did an automated test on the tip of
'pu' and bisected a breakage, if found, to pinpoint the patch
that breaks. It could even send a notice to the author of the
non-portable patch ;-).

That would be "post-pushout test", but as long as it catches new
breakages before they hit 'next', the resulting benefit to the project
would be very similar (the difference is only one integration cycle).
