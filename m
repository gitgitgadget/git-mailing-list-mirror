Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B2C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FCA610C7
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 11:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhGSKo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhGSKo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 06:44:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7600C061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 03:36:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id h9so20331756oih.4
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VRu07v9qSOT2g3xuTyVHBX0jVs8lYmPU/6hLd2azIeI=;
        b=gdNjevcLo3iZBPgtccerYEG/aqlNVstJ0hy033WSIm5rLCZKBaLY/G+kxGOatLUDcU
         jD2IZSTWCIo7oQfYxyB9e8OlQVgrVuVhb9RZqzj7TtJ7JMsBNXQ1/+kNoZF4BF/HJD7o
         kCGZWijjuLE9pxZ6PM9mTAEKiAhTLQ9rpFMahsGvrnjZYBDN480+USIKYww03MPOKhHr
         QrNh4gPOucSGRv567Zo/uqzerGPXn3Mb9L1lvTPkFjgqwMBtARmcUYmTb950vfj68SFo
         zYNfscdbXwN/zISH/ng9nXM8eosx08voPdsGpZUGLpLUoGgtmTGaN/24kYB23qJ9ODED
         R7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VRu07v9qSOT2g3xuTyVHBX0jVs8lYmPU/6hLd2azIeI=;
        b=XMfx3YLWbbpINR+0q+oX4hi2EdUl/J1UYIpsmhlO5HvVqUxvWk8MqEngQ4dOZraeCl
         KIaVZgfWzZDfdRLKyk0+xKN3xcxbeZAtSAir9iFLDcarB1LGB9muJJfiYU4HvPWY/x0/
         ip6hZoTw+KqP6sHcrKEhzTVRAOez2MBl50O77aS2a5Sfqh2Ip6KTSaI9IDvYjlzSA0pQ
         1uCn0vGVtw6Cmz6tbXXxVCu17dXwvBgR7TwXC1gB2Z/y0AIm4pKQujMM/+UZbLBkUwf0
         uFNM966KiJXojdH3n2znjT5CZBAQsDKuGmzGPF3yfnV6OD/bm1hz0WqH5MH8lAijpiUO
         YIrg==
X-Gm-Message-State: AOAM530Bl+Pkn1G3DVQ2yIzulds7IC30jsxCqK6Ux0TAVxAC3pRAEX+x
        Nmtp0HnD2XiyAYe7Ky1dacM=
X-Google-Smtp-Source: ABdhPJw0I0KhjECTN3ISLuqyMFjFZVZmklMfbW0+3nMdPXCgOlx2iscLUnkVPupsnvxSchOU+thoAg==
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr22049017oiw.147.1626693937419;
        Mon, 19 Jul 2021 04:25:37 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id n20sm3514143otj.11.2021.07.19.04.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 04:25:37 -0700 (PDT)
Date:   Mon, 19 Jul 2021 06:25:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Message-ID: <60f5612fd4d2b_13dbe9208ab@natae.notmuch>
In-Reply-To: <YPVaVvcamOB0RZV+@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <60f52f7a52671_1e0a42083b@natae.notmuch>
 <YPU5NyoDrQquWOYo@coredump.intra.peff.net>
 <60f5573312036_13ce8720841@natae.notmuch>
 <YPVaVvcamOB0RZV+@ncase>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Mon, Jul 19, 2021 at 05:42:59AM -0500, Felipe Contreras wrote:
> > Jeff King wrote:
> > > On Mon, Jul 19, 2021 at 02:53:30AM -0500, Felipe Contreras wrote:
> > > 
> > > > Patrick Steinhardt wrote:
> > > > > On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> > > > > [snip]
> > > > > > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> > > > > >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > > > > > 
> > > > > >  Test update.
> > > > > > 
> > > > > >  What's the status of this one?
> > > > > 
> > > > > From my point of view this is ready, but it's still missing reviews so
> > > > > far. The lack of interest seems to indicate that nobody has hit the
> > > > > issue so far, and I wonder why that is. Am I the only one who sets
> > > > > TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> > > > > tests?
> > > > 
> > > > No, I do the same, and this other fix for TEST_OUTPUT_DIRECTORY is being
> > > > ignored even harder:
> > > > 
> > > > https://lore.kernel.org/git/20210707030709.3134859-1-felipe.contreras@gmail.com/
> > > 
> > > Note that the linked patch will break Patrick's, because we would no
> > > longer set TEST_OUTPUT_DIRECTORY in GIT-BUILD-OPTIONS.
> > 
> > Is Patrick's patch specific to GIT-BUILD-OPTIONS? Or can
> > TEST_OUTPUT_DIRECTORY be taken from the environment?
> > 
> > Either way I think the priority should be to make the standard tests
> > work with TEST_OUTPUT_DIRECTORY.
> 
> Right now, TEST_OUTPUT_DIRECTORY as defined in config.mak will be
> written into GIT-BUILD-OPTIONS, which then gets sourced by test-lib.sh
> automatically. So even if you execute tests directly and not via the
> Makefile, it'll still pick up the correct output directory you've
> specified in your config.mak.

Yeah, I know, but right now if you do that t0000-basic.sh fails because
_run_sub_test_lib_test_common sets TEST_OUTPUT_DIRECTORY on the
environment, and that gets overriden when GIT-BUILD-OPTIONS is sourced.

> It would likely be possible to take it from the environment, but that
> makes the calling interface much more fragile given that you'll have
> to remember to always set the envvar.

Indeed, unless you set that in your ~/.profile, as I did.

-- 
Felipe Contreras
