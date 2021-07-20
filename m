Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DCAC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E792610C7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGTQSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhGTQSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:18:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44EC0613DB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:59:00 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y6so19710481ilj.13
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8ci4DOhVRkmpnZsUD0zzx+yI6JvCF6P7fIfJsfLzTAU=;
        b=kmVLxJCb0bRdj+cqZc9wq/9e9xxnkTG2yzcypRqffsww+k4yn2v2i2bMCBHfaNlYTq
         vpTILVSOpWMsyzbUHCH4BeIKheziuATmh79i6ZqKm9iRvwaLn2cpMl3Sk9T8UtaVugTU
         D+odPwai00pv4zfMbqaMrSd1/dzkB4s+SX/tDhMaMSRrjEsuqUe4ZIRJIFfKahfuAMET
         ivVa/n4IKWUws/Zf0VlbIJbMMujW2zdrIlhwWl//AfWlzEyvK+rgbgITmNJun5FkwDzJ
         SO4C9bDT3eChSWdbtLQGHCQrgl2ZyJK4FIzPuKCTtSvF20Hsd7QcQxB49k/+HxMUp/p8
         1Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ci4DOhVRkmpnZsUD0zzx+yI6JvCF6P7fIfJsfLzTAU=;
        b=dVyBR4qMqofgEv6YGR81ykV80mgGwHxONgDueXiF6xAkTxijdmXnoSs4C1h2ZEa8R1
         MnBdd5B6kQr858SyZwoEhFSfk8cKX3sBzkv5O9ygxlMKbYQ2DgJ6Y/ueyaMH9qpfPQ3P
         p3+cdt6nZLxEtK6AHpUtlSmVLGYB1aQyrVD675/LCAleOy/tYJ7Wx5bgIhauVNmkxgwU
         wV+K37PLFtnk2+JF9BAcda1XhvRFaTWiNZCaltU76InkEAgo53lKxgLtLtkHDsd+vIq0
         trdG1i+mct+Ol8fTaLMZecK8MhY4qBpfI/DoMg80kgcNNk0YaRaPJ3uHJ15C5vmoBGCp
         4L8g==
X-Gm-Message-State: AOAM531AXVzciPArSNOwOqth3HtTYM7ZkkikD1d7qSIsscfJqJboHzpz
        cMG3asQn6HhvZ1qfZIcsgflA/Q==
X-Google-Smtp-Source: ABdhPJxD66gE7OpqHkjCubGmMLoSha1eEtEWEWPdipf6JVMhlZ6/MbnF87t772piyJFFMAVJtAlu6g==
X-Received: by 2002:a92:c883:: with SMTP id w3mr21772836ilo.76.1626800339658;
        Tue, 20 Jul 2021 09:58:59 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id w21sm12283822iol.52.2021.07.20.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:58:59 -0700 (PDT)
Date:   Tue, 20 Jul 2021 12:58:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: fix segfault in --stdin-packs option
Message-ID: <YPcA0oxJgedIf57K@nand.local>
References: <cover-0.2-00000000000-20210621T145819Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210709T101014Z-avarab@gmail.com>
 <patch-2.2-c7315f2b378-20210709T101015Z-avarab@gmail.com>
 <YPXvQXOcdKdCzcFb@nand.local>
 <87zguhum6y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zguhum6y.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 01:55:31PM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jul 19 2021, Taylor Blau wrote:
> > On Fri, Jul 09, 2021 at 12:13:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> +test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage' '
> >> +	cat >in <<-EOF &&
> >> +	$(git -C pack-object-stdin rev-parse one)
> >> +	$(git -C pack-object-stdin rev-parse two)
> >> +	EOF
> >
> > I see that you left my suggestion to inline this here-doc with the
> > actual 'pack-objects' invocation below alone, which is fine. I think
> > that it does help the readability, too, since it separates the input
> > from the command its being fed to.
>
> Yeah, per CL:
>
>     I didn't end up moving away from the "<in" pattern. I prefer it
>     because it makes manual inspection easier, and the tests above this
>     one used it consistently, so I left it in place.

Ah, my apologies for reading right past it. Thanks!

> >> +	# That we get "two" and not "one" has to do with OID
> >> +	# ordering. It happens to be the same here under SHA-1 and
> >> +	# SHA-256. See commentary in pack-objects.c
> >> +	cat >err.expect <<-EOF &&
> >> +	fatal: could not find pack '"'"'$(git -C pack-object-stdin rev-parse two)'"'"'
> >> +	EOF
> >
> > On the other hand, crafting this err.expect with one of the object's
> > full OID still sits funny with me. I appreciate you checking that this
> > is the correct object to test with in SHA-1 and SHA-256 mode, but isn't
> > the point that we shouldn't be relying on which object comes out?
> >
> > I think that dropping this down to just something like:
> >
> >     grep 'could not find' err.actual
> >
> > would be an improvement since it avoids the finicky shell quoting,
> > hardens this test in the event of a future change in hashing algorithm,
> > and brings the test more in line with the spirit of the patch itself
> > (which is to report some of its input, not necessarily the first one
> > given).
>
> If we've got another hash transition (unlikely, at least near-ish term)
> we can just look at this test again.
>
> More plausibly it's a common pattern in our test suite that greps like
> that elide actual problems, e.g. a loop printing the error N times, that
> seems more likely in this case.

I understand the reasoning, but I'm not quite sure that I buy that that
is a likely defect here. Of course, that doesn't mean that stricter
tests aren't good for nothing, but it's a tradeoff.

> Do you mind if it's just left as it is?

No, I don't mind, but I do think that changing the test to be looser
would be an improvement. Of course, there are lots of unlikely/rare
things that could cause this test to break (like picking a different
hashing algorithm), but I think fundamentally this test disagrees in
spirit with the code.

I.e., it seems odd to me that the code says "well, we have to sort this
list before we can produce an error, so the error won't necessarily
correspond to your first line of input" but the test says "we should
check that exactly such-and-such an object is included in the error".

Obviously that is far from the worst outcome in the world, but it does
seem a little odd to me. In any case, I don't feel particularly strongly
about it, and (as I said much earlier in the thread) this probably is
all academic anyway, since I would expect the vast majority of uses of
'--stdin-packs' are from 'git repack --geometric' anyway.

Thanks,
Taylor
