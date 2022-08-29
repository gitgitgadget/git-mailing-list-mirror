Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19808ECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 13:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH2Nci (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2Ncg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 09:32:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312DBF58B
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661779945;
        bh=+mOEwinYjTgqX0OPgYEeIOOjB0MqQ0yrxISiPhURGto=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gr059eraDMPmsmuEZaFFzSQHrCwx84q8R3XtUUdG24FKzfYldJUj/N1ZHsGrFd84K
         zXvl6Xs1RwJsr+IvA8fRqtd1A+q+L2aeHy36eCap8mqtpq7EbfmrxBttcz6oC2VowL
         Rt5/3+jUp/iiKa8qgKvd1nxIhNZGNk5CBi8zl+3o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1pG4ZB0Xoi-00uKlz; Mon, 29
 Aug 2022 15:32:25 +0200
Date:   Mon, 29 Aug 2022 15:32:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 3/4] add -p: handle `diff-so-fancy`'s hunk headers
 better
In-Reply-To: <xmqq5yibqxs0.fsf@gitster.g>
Message-ID: <0q0psp09-8993-96r6-3r90-q4s368p98510@tzk.qr>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>        <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661376112.git.gitgitgadget@gmail.com> <xmqq5yibqxs0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KSs4aMkpc10D6OayDx9ABi9a26qjb6TAblf51TemTfgY0dpQ4GX
 wFx2Y2kTnX8aGDHtrzRWMF8LZUdGGUzbnQavWrdorJTpO8uwd58dgWIY0cmfbdY3TDNiLDe
 i4LPY45Lrb6N/2toEflejR3cufNOSXLv2b96BAx9GLH1h/a0FEdZ3FVOWBa8bpJU+DwrO0G
 cdIuT3Dgi46bwcQt/L3eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEIUsZFbg6g=:Rfm1F6GHuUVGceeo7hTcU5
 a5a0uMoMWTzIOSj5PtKuwsClb2xWyg0TaBak2wJYARjxxgHKTWRPIjnZdkOb0kNiie1jxHaHR
 US1ga8gYpXvUs66fV362xPlFnwTrRAky1plGMB+d5r1eBuPMXPSkDk5bi1ltnTCu0ZNqmO6h7
 5zEmua/9FuVDrTh1OGbNgHIM/oi2naQNZkhupusPNlphJCcmewXeXFa/fqRGlSg5UMsVGdgXU
 xYYquoC0oykKcSFpcIe2v+qr3c8CxcAb6GLAsOXU2tcD0cw56HAOXr+0xorpdTI/pq/1f9OxZ
 HfE2fvDPqv+LoKBkVELYcTNT9YvXn6cS01F3Ls4hFod1JPOORqueOz4Qm8ahtgrn6egsqL9S9
 XJThN+AMeGNzmvRDavwgFvGvhlZaXCXu5Eg85zejsn8GfMuHAUNz0wQtEaXLFQyilhWFX22ym
 JrAv7vXG8nMmgOhKnylQZetEtm4fyElYzEZCmbcb1eNrNZgenE4W8osvDyIU11o1t3E5jFQ1Y
 ukWs8wl/HvdNFksaIBVg+Tlq/So+fxC+OjNY/DHM7ZCIUAltp8mNxXdeJgeecdMuyrBBIYjJj
 yPQhmGHBru9V/9itaq9mVTr2RutpPa/BffJlvFhpjV/xCULQexgiaNePuzWwbQTGaBKnFsi+H
 FfohYR1wbCw8uLneI/vh+b2kh+s7kyYypPQRoQGW4GXwNWwfeka9Rw1kCHQr7wEmlndG3vb6C
 63HURotSAjg69B3IC024RDHdFXbAwyWRI1balZ7qkdvd5wQEj86vJGtj3L0aJJcTa78qhK42D
 tpPbi6wfVRtkUxWUSeeBwjApLbibxnXri2BBLhLNyoFZnknm6Ck1SgAvzOwNTAFn2q8tBsUDK
 u12mGmnZ3h2wRrgwmAJYX3rvY1qHiQHXpvKx1Yw3cGNGRNmeCpEgxmFAhg+fNOK1W8yArRVK0
 +JlczI6Fm0hVG0g8cTdx/bfXtmKkZi0nSb/PyQdgDPCMZzJW67rhatfJ/ymn8SSfU/LIf5660
 GzdmqL06KLCkujk4jLt0/ZBnRy/xPO8I2iKxbW3UszZZ1bOnGZ5YCc2AqJKY4F2suiE3Y9IDU
 uaCLVeJ9MhpfyQ5oHNuanP8DPChVY7QZu/QtyjfeSJgmxa6uPjtS9+vvQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >  	else
> >  		/* could not parse colored hunk header, showing nothing */
> > -		header->colored_extra_start =3D hunk->colored_start;
> > +		header->colored_extra_start =3D line - s->colored.buf;
>
> This is the only thing that corresponds to the proposed log message.
> The comment that says "showing nothing" is no longer correct, and
> needs to be updated.

Correct.

> Everything else in this patch is about adding an extra space
> depending on what is in the "funcname" part.

... because that logic was not relevant before this commit.

> The code does not know or care if it is an attempt to do diff-so-fancy's
> headers better by doing something we didn't do to the normal header we
> managed to have parsed; rather the extra space thing is done
> unconditionally and does not know or care if extra_start is truly after
> " @@" or a place in the line the new code computed.
>
> So the following three hunks either need to be made into a separate
> patch, or deserves to be explained in a new paragraph in the
> proposed log message.

I've opted to split the changes out into their own patch because it
improves the reviewability of the patch series.

> >  	header->colored_extra_end =3D hunk->colored_start;
> >
> >  	return 0;
> > @@ -649,6 +650,7 @@ static void render_hunk(struct add_p_state *s, str=
uct hunk *hunk,
> >  		size_t len;
> >  		unsigned long old_offset =3D header->old_offset;
> >  		unsigned long new_offset =3D header->new_offset;
> > +		int needs_extra_space =3D 0;
> >
> >  		if (!colored) {
> >  			p =3D s->plain.buf + header->extra_start;
> > @@ -658,6 +660,8 @@ static void render_hunk(struct add_p_state *s, str=
uct hunk *hunk,
> >  			p =3D s->colored.buf + header->colored_extra_start;
> >  			len =3D header->colored_extra_end
> >  				- header->colored_extra_start;
> > +			if (utf8_strnwidth(p, len, 1 /* skip ANSI */) > 0)
> > +				needs_extra_space =3D 1;

Let me add a review of my own: This hunk is incorrect ;-)

Here is why: in the _regular_ case, i.e. when we have a colored hunk
header like `@@ -936 +936 @@ wow()`, we manage to parse the line range,
and then record the offset of the extra part that starts afterwards.

This extra part is non-empty, therefore we add an extra space.

But that part already starts with a space, so now we end up with two
spaces.

A fix for this will be part of the next iteration.

Ciao,
Dscho

> >  		}
> >
> >  		if (s->mode->is_reverse)
> > @@ -673,6 +677,8 @@ static void render_hunk(struct add_p_state *s, str=
uct hunk *hunk,
> >  			strbuf_addf(out, ",%lu", header->new_count);
> >  		strbuf_addstr(out, " @@");
> >
> > +		if (needs_extra_space)
> > +			strbuf_addch(out, ' ');
> >  		if (len)
> >  			strbuf_add(out, p, len);
> >  		else if (colored)
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 7e3c1de71f5..9deb7a87f1e 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -772,7 +772,8 @@ test_expect_success 'gracefully fail to parse colo=
red hunk header' '
> >  	echo content >test &&
> >  	test_config interactive.diffFilter "sed s/@@/XX/g" &&
> >  	printf y >y &&
> > -	force_color git add -p <y
> > +	force_color git add -p >output 2>&1 <y &&
> > +	grep XX output
> >  '
>
> It is good to make sure that XX that was munged appears in the
> output.  This however does not check anything about the
> needs-extra-space logic.  It should.  If the extra-space logic is
> moved to a separate patch, then this step can have the above test,
> but then the separate patch needs to update it to check the
> additional logic.
>
> Other than that, looking very good.
>
