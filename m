Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12BDC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiHIWNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHIWNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 18:13:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB76C41D1A
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660083007;
        bh=I68Xcv4cs8pCurdIUzuIMUXf7Mk2OK7pgLazYIQ087g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XKvM59T/h8kl4fFIU5FePBRUwTPGW1tevm4pNh4W6mWmMbkCPp0QRQRN1x+3ghxwX
         CyY04ky7CB7zgVM8DVWKSpTbdmhRdgMHZR+KaWuTQ+oQe0521DaFv4w8VMMo//3Bje
         ieZ64wm4QetPA2xQxcu02yOWXUjHNdiWCzW3IYis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1nqxjj3aKX-00V5R1; Wed, 10
 Aug 2022 00:10:06 +0200
Date:   Wed, 10 Aug 2022 00:10:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as
 non-blocking
In-Reply-To: <YvJbXJyaKz5QPYdz@coredump.intra.peff.net>
Message-ID: <4o5p308o-9r66-2853-qon0-r1464p2o83qn@tzk.qr>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net> <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g> <YunxHOa2sJeEpJxd@coredump.intra.peff.net> <q341oso8-1ps6-65n6-s394-n8q433q79nr2@tzk.qr>
 <YvJbXJyaKz5QPYdz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-990681964-1660083009=:206"
X-Provags-ID: V03:K1:8OQSLgFx7RazHwmFQQ4k2QOjWEp9B0YA4mpyFhB4rDsuHqht3dC
 Wk7nOT2YpmIStlwOFlUhBbqQkxMKYjIcEhf2+ySK7oB6d6eNNNziKJTq63Jwt1FnJFYIToq
 36SwpTy9FLLfYZF84D0FSKrFTXIfGNdiOWC68k0NOQQ/DKR6cvRuM5qXA/6LaOUdrpTf1km
 UEd0AfCOST8cF03CoPNHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yl6fQ4xGELk=:NF+lqxPgmtFXAqy7ihh+OW
 2d93LKnAkdoGnugI9+K7MMbl1vEf9BZzXy0t8HSUkFewSss3CIFi1oBWBqdir4txt/njDLAxY
 sivRiOrvCzUfM5fuAEkh4N3JXWInhVjSQ+rGiuPJRi3tlbMGTr8kV/PwFX9ITaAC0uqHEIQJe
 VZBjdJgD1rH7dPc1Dq4q07zJrOROb2suvYKgO7InCFwc43dDjX+/WC5sXmefp7W7NdtDAoPO6
 /bl/2BxjziKrW2uTif5EUpeo5ZhomUZwDmYmQ0mJD37kTe86qfk45e6bOsPah28BBDUx5QvVN
 VXgchvh1HjPlnePezed9EaPH9FLbVlwHikbxPbkEupgmB8tFveZW6wvb3QggJ0y4taf09mWTh
 LJCUN5yB6zbnZ3g2PLsnHIcMRUKNt2lQWUtcr1dKLTJUTmcV4o+ll4uiMuvDgmnrR2PDdR5Yl
 evGaVSYSaJG6t/1t+QwROIKOTyg9aVGb74bYfemTxa/dtjWUJVEoxBCqtK5jUDw229tAzluRC
 iUKnoT8IBGWbn038zamuidYKtCWz7AKL986FFn9vUgVVUzAxn7kgy+RztFQ283wKSXfG9DtE0
 jSkccutKIrLJ/INUZbdTl+KYXHAB9O2ViuGdK7utfPXrTcH2no6RQCdhzbY9ztINTAegpAgcZ
 S1aLwPq1WA1mJbqHK9Ix0jYbVnyMndvaV0yxmOMgO389jxPXCY7/hB5PAYZrmATutKuBNSFhv
 SGzFH8IBXTf2e0Zvpz3lB2H6qxxC0asGFgvTBPNDO5ojqmPMN4dV03itOy/LD9c2eW1K6yuX+
 sPzLKS46712a6aqoQsZxFcNfmFmA6+c+RnRsAq5lwdMeef3nYmlKrwoNZhDPY6zrJ5aqF7Gvw
 0DoM+N7fH+sWA+Mma9NoCFCXfxC+RYB+hrgs+q5hwZI298KwTwXBfzbfD0cz/uQGuKAspYm5v
 15A1zaunXwK46fmFF1A+TOt+DWz6UhjgXT0RdQQcEMyIyBcLwjfCOButlFqfWApNfGHWbGeXg
 7TmEfbi2NWN6XKX0A9LmYN3PIyk6tTeZSC7t6aQ0XQOgDmcf4YwhGDq7l2DFb7axTRR3N7F3b
 lFYHU5FLX7UPVKycRG4yhj8TnalGUKb6wuML35wO8jcH6jHWKS2MHGC3w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-990681964-1660083009=:206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Tue, 9 Aug 2022, Jeff King wrote:

> On Mon, Aug 08, 2022 at 02:59:49PM +0200, Johannes Schindelin wrote:
>
> > On Tue, 2 Aug 2022, Jeff King wrote:
> >
> > > diff --git a/run-command.c b/run-command.c
> > > index 14f17830f5..ed99503b22 100644
> > > --- a/run-command.c
> > > +++ b/run-command.c
> > > @@ -1438,6 +1439,15 @@ int pipe_command(struct child_process *cmd,
> > >  		return -1;
> > >
> > >  	if (in) {
> > > +		if (enable_nonblock(cmd->in) < 0) {
> > > +			error_errno("unable to make pipe non-blocking");
> >
> > It might be a bit heavy-handed to error out in this case, as it usuall=
y
> > does not cause problems. At least that's what the fact suggests to me =
that
> > I personally never encountered the dead-lock myself, and neither do I
> > recall anybody piping more than two megabytes through `git checkout -p=
`.

Ugh, I think that my reasoning was flawed, as I somehow based it on the
assumption that `enable_nonblock()` would return -1 on platforms without
O_NONBLOCK. Even if I had read that you fall back to returning 0 on those
platforms.

And only when reading your reply did it occur to me that this was a thinko
on my part.

So I would like to retract my assessment that it is heavy-handed to error
out in this case. It would have been if we had errored out on platforms
without O_NONBLOCK support, but we don't.

Sorry for the noise,
Dscho

>
> That thought crossed my mind, as well, but I'm hesitant to leave a known
> bug in place that can cause a deadlock. It would be one thing if we
> could muddle through without nonblock in a slower way, but I don't think
> we can easily detect this situation after the fact.
>
> So maybe some options are:
>
>   - don't bother with O_NONBLOCK unless the size of the input is over N
>     bytes. The trouble there is that it's not clear what N should be.
>     It's fcntl(F_GETPIPE_SZ) on Linux, but that's not portable. We could
>     possibly come up with a conservative value if we had a ballpark for
>     pipe size on Windows. It feels a bit hacky, though.
>
>   - we could actually guess at a deadlock by putting a timeout on the
>     poll(). That would also catch hanging or slow filter processes. I
>     really hate putting clock-based limits on things, though, as it
>     means the tool behaves differently under load. And keep in mind this
>     is deep in the pipe_command() code. It happens to only trigger for
>     diff filters now, but it may be used in other spots (in fact it
>     already is, and it's only the size of current gpg payloads/responses
>     that means it doesn't happen to trigger).
>
> Stepping back, though, I think we should consider why we'd see an error
> here. I wouldn't expect it to ever fail on a system where O_NONBLOCK was
> supported. If we want to make it a silent noop on some platforms, then
> we can stick that into the enable_nonblock() function (which is what I
> did, but as Ren=C3=A9 showed, that is probably not a good enough solutio=
n).
>
> -Peff
>

--8323328-990681964-1660083009=:206--
