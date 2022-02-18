Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA3FC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiBRTtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:49:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbiBRTtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:49:07 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01115202049
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:48:49 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p14so17268169ejf.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TVPt54MKxW5o2vKqFm5KzyMnAVzWkjeZVFdXsfGq6j8=;
        b=mB+I45HpNr+0kc0gx1cwsV5QKhN1mmW/nE9oMU1Un5PcA0GjR0App8T3ynBL8isjqh
         Sn+mYKTeHZRAYEQ7Y5v/pKE4wY2CIed6GEl2ZcCewxBymibZuvQTf3x7NGHN3RIMcAP6
         NmiQbNK/wk9wl+zaS1O9w0zxZ9XvihibNUD0k+ruoGSkxalRZN3YM8o9KtR1ZcV5tWhg
         yG4MSIQdqw74Rv2OhrYB8SNHgnrk16kmDnwih5o8cOu06usmHBryPLxCZIi6n/EU95Qm
         0/rvvzF5NsmfHUp60Tzeqxb8i8ugUskGBeOtt9MExs9DxJN3DmDQWPdUDIJVq7GN0Mbu
         keGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TVPt54MKxW5o2vKqFm5KzyMnAVzWkjeZVFdXsfGq6j8=;
        b=Hms9a2yn6JthhWAhYEgP9plm96/tIXImagAzWkP3oK9RRtj6HkuBkuXK0GmkHFqUDn
         /U0AmwBU/pGgNieCysqmsC8k0KrTqd89sgg+Ya+ydY6IfWP2mVFcYdHFqeXgV3ri0Xc+
         +EwnvmcNs+25AlX1kc6+MdAzLjIrC6VLdTD/NygYrISyNuxLpnZO1JtUdclAtpDysk68
         N/6ZZaRH7qCxheWPi6evPY1c2veFVk6vJDesewkZYCFgymoCfVd0wODPBVwaYNJGjAFV
         LBKzcjmd7Ti9CyLoyEKXeiYV5kslEWWttU7PSGYwWGALtWVnWBLQL5QmFl82n9P8pvF1
         tIyw==
X-Gm-Message-State: AOAM530dJwewojf9WHovoINqNIFXObgWLzmd1Dpq6uWVGXHdEiyLFQfz
        9YiRXjFwjOv1L9k71l0mfsc=
X-Google-Smtp-Source: ABdhPJyJyVLg7bnN1Sp7P8bSKLzyC+ojy9aKDpTFBuMyNNz0i1m2at3D38BWK8s3jw29hI/wAxKjIQ==
X-Received: by 2002:a17:906:65d0:b0:6ce:29b2:bdbe with SMTP id z16-20020a17090665d000b006ce29b2bdbemr7374879ejn.572.1645213728380;
        Fri, 18 Feb 2022 11:48:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 26sm2531521eja.183.2022.02.18.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:48:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL9FG-004NEQ-Tn;
        Fri, 18 Feb 2022 20:48:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] reflog: libify delete reflog function and helpers
Date:   Fri, 18 Feb 2022 20:48:08 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <9e17ece8d8956c7fd41b7be2f5c0475b1f9af6ec.1645209647.git.gitgitgadget@gmail.com>
 <220218.86wnhsgf5n.gmgdl@evledraar.gmail.com>
 <Yg/1205sTdqE2mC5@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yg/1205sTdqE2mC5@nand.local>
Message-ID: <220218.86bkz4gdlt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Taylor Blau wrote:

> On Fri, Feb 18, 2022 at 08:10:07PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > +int reflog_delete(const char *rev, int flags, int verbose)
>> > +{
>> > +	struct cmd_reflog_expire_cb cmd =3D { 0 };
>> > +	int status =3D 0;
>> > +	reflog_expiry_should_prune_fn *should_prune_fn =3D should_expire_ref=
log_ent;
>> > +	const char *spec =3D strstr(rev, "@{");
>> > +	char *ep, *ref;
>> > +	int recno;
>> > +	struct expire_reflog_policy_cb cb =3D {
>> > +		.dry_run =3D !!(flags & EXPIRE_REFLOGS_DRY_RUN),
>> > +	};
>> > +
>> > +	if (verbose)
>> > +		should_prune_fn =3D should_expire_reflog_ent_verbose;
>> > +
>> > +	if (!spec) {
>> > +		status |=3D error(_("not a reflog: %s"), rev);
>> > +	}
>> > +
>> > +	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
>> > +		status |=3D error(_("no reflog for '%s'"), rev);
>> > +	}
>>
>> For these let's follow our usual style of not having braces for
>> single-line if's.
>>
>> Buuuut in this case doing so will make the diff move detection less
>> useful for 1..2.
>>
>> So probably best to leave it, or do some post-cleanup at the end maybe.
>
> Hmm. I don't think the diff detection mechanism would have an
> opportunity to kick in here, since the code is added in one patch and
> then removed in another. I think I may be missing what you're trying to
> say here ;).
>
> In any case, I don't think it's a huge deal if we can't accurately
> colorize this with `--color-moved`, so I'd probably just as soon clean
> up the style nits in this patch.

Yes, this should really be read in combination with my comment on 2/3 to
squash that commit into 1/3 to take full advantage of that, sorry.
