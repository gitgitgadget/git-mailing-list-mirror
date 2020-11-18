Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0FC63697
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB442076C
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9c75yIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgKRJnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKRJnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 04:43:31 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75065C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:43:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so2340800wml.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/yllqZxJ0DpdZrZnKa2rW8DddMDxXymOzeNmkbc+tQc=;
        b=r9c75yIjfKXz4nRc3VYR+Aj9D4k/bwz3FJ4hYwUOGyC5pyaxyqnBVGHCpE9MGq4BiC
         EoDvAIdXLgjQ6TuXIJ7menlLzgaIhBMXZZJCYBT2sS2cp32PJdVZZ6MQO/WS0z+gIZAY
         B0IMvy7Sqh0qzca1zKv1nPPv7c3/H+eKe1YWh2j/cfZhvYaExnCOxqxtNETkBA0o1uIe
         gtleY31Z0CTQ4VcE1O50wQFAkqQrUkp46Sq0wnU2UDCBbucrVM75rwG0VC6UXMmGR7Sb
         hfs6JxiSNRvq0ZoF2a22SaRMYxv6L0vtTFVL/ZgZxCEzNfKkVN2XymSr4xCThxz3jLpm
         VDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/yllqZxJ0DpdZrZnKa2rW8DddMDxXymOzeNmkbc+tQc=;
        b=Ky3iOvXQst2wjJs07Pbmwh1++CPE/1BjFliHHBDpuoVh9ODU++P55Thaqrh4VeOtNS
         IEL/Pw5rtwPBoHOQEjs/gccLekZ5DndLmzdUf0oN6tFhSf9SajByq1+SpUpFiuAC2zRn
         HLC6oBo5B6vB3ew+IxykxiNAqjxjRetsFOeBmoJt5VH6cLLSCYNZPDvPEG0kcJPr0kr/
         2+meFq/AntUiuKK8sRZ6t5rALl7eQJCmi6ljV6oydSDe8bEqtnRpeXKIlGQAxW6uvPLV
         exyhWR8ibaDTOR3aaA65L/Bx8K42BOKvfG5FnGXTLVsbRVMJc4NyRTxhm53KfET4RxgS
         V0Yg==
X-Gm-Message-State: AOAM532Y+AGLZvOXVsz74P0IHEwExfJsBXR6DW8ZO7iZYKiDU/5uAkAQ
        yS8ZRa+t/wtiH9h2aWYosG8vGuYq7GFCX5bKlbRR4l1EU6n2wA==
X-Google-Smtp-Source: ABdhPJx/RSjsgrsOP/O0io6JVnUPR1XJDZWuV89n8D4xgwzCfQl22JM+2tflLAIe2eUs+EsrH4o1j8IneJL+YsppChM=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr3043341wmc.55.1605692610192;
 Wed, 18 Nov 2020 01:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20201118091219.3341585-1-felipe.contreras@gmail.com> <87wnyjdnb3.fsf@evledraar.gmail.com>
In-Reply-To: <87wnyjdnb3.fsf@evledraar.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 03:43:19 -0600
Message-ID: <CAMP44s1i+defrfkCprTAOqyJSCAUMsqWe3Fyv+Y2TeAyiAdg8g@mail.gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 3:30 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> I haven't taken much time to re-think through the patch/implications of
> this, but I remember running into this and going through some pre-patch
> investigation at some point.
>
> It's really annoying in some cases that "clone" isn't creating the same
> state as "remote". IIRC I was doing some heuristics to figure out the
> remote branch name etc.
>
> Isn't this something we can just change without an option? There were a
> bunch of cases in clone/fetch that were different for no different
> reasons, IIRC I patched one or two of those in the past. But I haven't
> gone through the history of the feature and checked if it was
> intentional.

Apparently remote/HEAD is supposed to be set manually, which is why
there is "git remote add -m master", and "git remote set-head origin
master".

Personally I don't see any point in that.

I think if no remote/HEAD is set (manually), it should be set
automatically on the first "git fetch", and that should mirror the
behavior of "git clone". This would be the equivalent of
"fetch.updatehead =3D missing", which in my opinion should be the
default.

This configuration was suggested by Jeff King, see:

https://lore.kernel.org/git/20201118020618.GE650959@coredump.intra.peff.net=
/

Personally I don't need a configuration, I would be happy if
"fetch.updatehead =3D missing" was the default.

Cheers.

--=20
Felipe Contreras
