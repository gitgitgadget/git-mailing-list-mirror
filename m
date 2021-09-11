Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633DC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D759A611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhIKQwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIKQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:52:38 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB3C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:51:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n24so6433624ion.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+Rrz8Ly2B1xOu+8KC2wv7awg7GrwP5FTvce01aIo41U=;
        b=ws46qnLoFbvapBUF/M6NqXTsbwXYxRyrKELrsvsp/dotzPpCEl55SbwVj+boPV7f6B
         gr6CKNBppR6Ao9Avr/xybzPtDWbqBvdcP7hA4cNOcggqBKPJYQDk7RQdoGingjBn3HSI
         oiUQ2cjSWR3dnZB93tY1SHYXKHcPP2M0VDba195qjp0k7PPBF8IO1mQVwLV1jCV4le/F
         IOUQzt0G8APLC+WIrEZ8TD+rHiScPpqyRxEV0HfhSXAl5awWcq393kclcij2LQjaK5I/
         I587D2fVcJDBDZSilZzA/xzmlwxH9JbjGzMpRDgtEB3mHdc68si9MABOlZdG2OPbd4j+
         26Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+Rrz8Ly2B1xOu+8KC2wv7awg7GrwP5FTvce01aIo41U=;
        b=kqu9xsmL8W+1M3wnZuNuZbbcq6g2vgWfJieK4D/xaB/MzhHKVfEGq5ut1Y6A2EUvJ4
         XgqSUlzyUwQkl97XbvomgHsdstb/hj0kthu9YRUrP+q8QSK9+k0keVLs45v/X2MYIPFC
         PEd2kjfp/5oU0E4/PWzDYe4IV7n1oJaCtTuMa+QHrj7wfMMGvWh4KQNQqiVG1gCG8VVJ
         t1MFhbHntIF5TqkuFNRW8okVjbkTtCEB5ZFGeeijJ8xCFx1sFPBPAoLx4D4xIEdTisKP
         lu+ydJg3z7diDcwxyixhKs4utUyKM/29BVUOe4fMWvDWhHSZH2JytFnoSlcHpaLdRKI0
         Bomw==
X-Gm-Message-State: AOAM532CTOKXHJ51CgfhHUewy8HVd6jdt1nSKEmctyFUrCFXrVfGgExO
        idYB1iPNj/jroPHFt3rQ7vAn9fh50yYDckD0
X-Google-Smtp-Source: ABdhPJzFyLirgFTnRL1yNRxCI6tI3ECh2XEZtxRr7pvKn5DQEeQ+n95NHrE513nM/nzXUUmvb6WnYQ==
X-Received: by 2002:a02:7813:: with SMTP id p19mr137734jac.38.1631379085423;
        Sat, 11 Sep 2021 09:51:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a25sm1100221ioq.46.2021.09.11.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 09:51:25 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:51:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YTzejKyYvqZu4v16@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
 <87sfyb8ihg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfyb8ihg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 01:19:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sat, Sep 11 2021, Ævar Arnfjörð Bjarmason wrote:
>
> > On Fri, Sep 10 2021, Taylor Blau wrote:
> >
> >> +struct midx_snapshot_ref_data {
> >> +	struct tempfile *f;
> >
> > Style/readability: Spare more than one byte for a variable name in a
> > struct, maybe file, or tmpfile?
> >
> >> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> >> +		oid_to_hex(oid));
> >
> > Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
> > "+OID\n"? Lends itself more naturally to extension, use with the likes
> > of string_list_split() etc.
>
> Actually, even better a format like:
>
>     "OID[\t+]\n"
>
> Or
>
>     "OID[\tpreferred=1]\n"

Sure, but I admit that I'm a little torn on this suggestion. I don't
want to be naive and say that we're never going to change this format
and paint ourselves into a corner.

On the other hand, changing it does seem extremely unlikely to me, and
this tab-delimited thing feels like overkill compared to how simple the
'+' format is.

So, I don't know. It's certainly easy enough to change now before we
lock it in, so I guess we should.

Thanks,
Taylor
