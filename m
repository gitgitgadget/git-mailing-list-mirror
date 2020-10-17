Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B774C433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 09:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962562137B
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HahDl2f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJRJo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 05:44:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:43729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgJRJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603014269;
        bh=0PlmLhofzGlqI8j/EnbDlDO3smHNYEJeKhPztDaUEd4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HahDl2f5z+rsc/Pzj5DG6aSPJsxcGjTuHrlSUbCankbiH73iU2Lb6YiYUWevbrz+F
         dNLW9BymTJinNMGkCYFgMkyVbqIb5bZdE320U0y9xCAmjoFtC9nx4RbJ8CykraiAF+
         y3UlLyntE3mhaZN/dt9T07KnL+LrIbjvQAKNji8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.212.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1kOYb80tbf-017B4D; Sun, 18
 Oct 2020 11:44:29 +0200
Date:   Sat, 17 Oct 2020 04:34:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] t5500.43: make the check a bit more robust
In-Reply-To: <20201013185515.GA2994107@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2010170429200.56@tvgsbejvaqbjf.bet>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com> <20201013185515.GA2994107@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pfvvKvIR4Fd7VUqjeExXf1Jxf1tPSNFoB1QJSYT3hwNuGS5bu5m
 qvK51o0Bx6mKoZmnFS+tv28o2KgQh9rjhlRfWdCLTYE/Yn+bs+P6eH9aQS+DPgaZiTwbFpw
 7I72uScUWyvc/rEmminsF37HnD/n/8YOdEjbFhPreqsJqDsxriaBQz8cDFUaA1RWBMYXBYw
 G/T9dgf9AZr5cgoOXZ4pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YnjLqql1+qk=:a+EbNbF4FY3K3xCZYUcxcc
 SUeyNi9Km4un4KSvnDfs6WGDMKoqxvHlCZWf2fJCqGpe1d+xR8U1A4Is+3GuunXbMFQbCebtn
 LV9QOktYV6NhKjUZSXdA/TCx0AUXWN4g4Pc0D5BDVr18gwfs3lpzOZ/lO3rFTXjg7fd85UOuT
 4a8FFtdYSd6nR8xRNAv5Rdt6Iu9BHp2gbLC17JeyZaST6XSwoV0ExrB84L5zLroyko+lHotHS
 IRKszNIktj27ZYBjdyDDfkbUX4uKJ2o2tv0egAnvMlNZiC17yD8fcnxFvvnx1cgaQwUpzN0Na
 0F4UFq1PZkVIePC7qX3yWDR2OwE+rxOyfcg3VzRW+3b1Ns2/fcu8ZoInbxdqV4bIt4/BR1/kZ
 iQECQVpgmvWKHZUTOFkkv5pAO1cULhwdB+hDTB6PlD4vb+Ia+bNobJOGl8KDO0y+gzlqZoiHh
 6hx85ZS0u6359X1v9nlnx1sd7HhzRFMVg4e+3riBbCZiW4KGgTs89NchSVvjHV/BPFUlzmfuq
 kpt5oaF8ppCTHAl05jkVyQS3pnnTA9adt4kUzoAAI99AHyCvz3qT+1x0Era1/TEpjvHeVy/gw
 tDPfBOaItq2C9NnDOTyv7O2wcFYYDxvW1S17JkWPxY4lZL/TotJhPRZO0qfk3EjVKYxwYu8f/
 YCt+CnU0NA0zt2bhRk9FhI/NPm7RxMND8uqJDfV5W3sJnwoHZJl3wDstGP0TW4pXnoYu+CaY+
 2yqXr9wQwYfj4IroVFFAxGPDnvNxRm5533ciZax6R1u7K8U/opcySbareIIklUi/DHh2OMM0L
 fhTtXicNzNuQ8UeKtYaXLP84tQ/vr7H25aq8wpGzdlr30lOZACTiWpr2L+MLI/X8EqXDhU6MP
 ma0WfxXl+ULySn5AkXzJYSsvjGNjBYC4NMrCfvO1M=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 13 Oct 2020, Jeff King wrote:

> On Tue, Oct 13, 2020 at 02:45:23PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > Note: we have code in `demultiplex_sideband()` _specifically_ to stitc=
h
> > back together lines that were delivered in separate sideband packets.
> > However, this stitching fails when a primary packet is delivered in
> > between the two sideband packets: since a primary packet was received,
> > `demultiplex_sideband()` has to return that (and cannot wait for other
> > sideband packets, and therefore has to flush any incomplete line it
> > received).
>
> This sounds like a bug. We should accumulate multiple sideband 2
> packets, even across data packets. And I think we _used_ to do that. The
> original recv_sideband() looked roughly like this:
>
> 	while (!retval) {
> 		 packet_read();
> 		 band =3D buf[0] & 0xff;
> 		 switch (band) {
> 		 case 3:
> 		   ...stuff data into outbuf...
> 		   retval =3D SIDEBAND_ERROR_REMOTE;
> 		   break;
> 		 case 2:
> 		   ...print full lines, stuff remainder into outbuf...
> 		   break; /* note, does _not_ set retval */
> 		 case 1:
> 		   write_or_die(out, buf + 1, len);
> 		   break; /* likewise, does not set retval */
> 		 default:
> 		   ...complain about broken sideband...
> 		   retval =3D SIDEBAND_PROTOCOL_ERROR;
> 		}
> 	}
> 	if (outbuf.len)
> 		...print outbuf...
>
> So we would keep looping until we see EOF, sideband 3, or a protocol
> error. But notably we would not break out of the loop on bands 1 or 2,
> and we do not flush band 2 until we break out of the loop.
>
> But then in fbd76cd450 (sideband: reverse its dependency on pkt-line,
> 2019-01-16), the function became demultiplex_sideband(). The loop went
> away, and we pump only a single packet on each call. When we see
> sideband 2, we do an early return. But on sideband 1, we continue to the
> cleanup: label, which flushes the scratch buffer.
>
> I think we need to return from there without hitting that cleanup label,
> like this:
>
> diff --git a/sideband.c b/sideband.c
> index 0a60662fa6..a5405b9aaa 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -190,7 +190,7 @@ int demultiplex_sideband(const char *me, char *buf, =
int len,
>  		return 0;
>  	case 1:
>  		*sideband_type =3D SIDEBAND_PRIMARY;
> -		break;
> +		return 1;
>  	default:
>  		strbuf_addf(scratch, "%s%s: protocol error: bad band #%d",
>  			    scratch->len ? "\n" : "", me, band);
>
> Does that make the problem go away for you?

Yes. But it took a substantial amount of time for myself to convince
myself that this oneliner is actually correct.

>
> >     Work around flakiness in t5500.43
> >
> >     It seems that this test became flaky only recently, although I hav=
e to
> >     admit that I have no idea why: the involved code does not seem to =
have
> >     changed recently at all. It should have been fixed by
> >     https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@g=
oogle.com/
> >     , but apparently wasn't completely fixed, despite what I said in t=
hat
> >     thread.
>
> I think this is a real bug, and we shouldn't be changing the tests to
> accommodate. Users may actually see the broken lines, and our tests are
> telling us that.
>
> I suspect it's uncommon in practice because it requires the server side
> also splitting the line across two packets. And while the server-side
> upload-pack might get a partial write from a child pack-objects or
> whatever, that should only happen if:
>
>   - the pipe buffer fills up. Which is hard to do since our messages
>     tend to be very small. So perhaps it implies a very tiny pipe
>     buffer, and/or slow scheduling of the receiving side to actually
>     clean it out.
>
>   - the writer is fully buffering its stderr writes instead of sending
>     them a line at a time
>
> The latter seems a more likely candidate for switching from gcc to
> Visual C (which presumably has a different libc / CRT).  I think the
> client should be handling this more robustly, but it may be worth
> digging into the buffering issue if it means progress may not be
> delivered in quite as timely a way as we expect it to be.

FWIW I _think_ the issue at hand is that newer MSVC runtimes deliver
`stderr` byte-by-byte. While that is totally allowed, it is different from
how things seem to be done on Linux/Unix/Darwin.

In my tests, I frequently saw the first two or four characters of that
"Total 3" line be delivered in its own sideband packet, hence the
breakage.

Thank you for keeping me honest. I would much rather have avoided spending
several hours on this investigation, but in the end, it is something that
is better made correct than left incorrect.

Having said that it is neither a very new bug nor does it seem to matter
on Linux/macOS (and not even in Git for Windows because it is built using
mingw-w64-gcc, which uses an older MSVC runtime, which apparently does not
share that issue with newer versions), therefore I plan on sending off v2
only after v2.29.0 was published.

Ciao,
Dscho
