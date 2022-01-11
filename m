Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90FC433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbiAKQmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiAKQmG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 11:42:06 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C3C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:42:06 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d3so15010288ilr.10
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qghi6aQ3eBb6PSO3cXDZeIm4+dAlhqXyaPULXjrQuEI=;
        b=F/cdh275dIaH2fj5UCIWqeKh3QLx/0WAPXOqmqM2lb9GN0bcyCE9l2XX7KsguVJrVR
         k/sSSfnJQysjkr3+Cv2UbV8SObGAVvWcqDzNSOhPyGXYaQavWaOfaIM0Pj0HMhXsRMn8
         YZ7eKrGBZPumTJ/KiTJ6tL1t3Wxg69BkWxrptqEDQwldBTcrPAR2hRIts7+kdc81R28x
         cnK26HhX9+mZ6dE4MJ29HffZdC5uFvjz24D1K7au3qGhwEQsWQeZPKZpzpImuJsQRlWc
         Bc8NlPDSKcT9DBK/ZxMIkMXRD5jsWQEDUEVxOx0O7aDwtw/c5qdYV6t2ILvMRtF8nvuU
         c/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qghi6aQ3eBb6PSO3cXDZeIm4+dAlhqXyaPULXjrQuEI=;
        b=ZpTSvvAimQ7xnSP5f2moqSMwMphp4tNOM7VnUQWoT2DrAj63klS9ygZO1SUuZ8YFs5
         G7u6nxJkZZuyfRt6yqkaaekgPQP6RK4yZaiT+22o4VAnAGUFbH9o2zPhN2USLyHZvWz3
         zDQkPAtS8gQl6i8I+Aipc8wOquwo3GznCbkpbnmj46LFQymZ7WZZKY+KHTzwJ6IW3rvQ
         MFUgmT31cpg9AozDGZ4cPZk0p43GJDY2ciTeneEQ62Ii34lEEWX1tejhRhmMnWEinXPe
         rrnZARW9jqashTojDQRS1hADdH6F5Gx9obt3qO/b/vGoigC2qu+PYHtLxCzJ6KAg7i4r
         LoTA==
X-Gm-Message-State: AOAM532yWySNkV36fYZI1ou9D3AfQMJvQzlvrJSuUlelNCUAjarrM0aY
        JGIhhuzHBISrvuatMLZuF7T32Q==
X-Google-Smtp-Source: ABdhPJwzBiUBI9k0qskCJoTOi6Vv2K+d8BkViKNNB6dQWdBRoaqdhE+F35c0erDWOCDBjJVRpCvBTg==
X-Received: by 2002:a05:6e02:1114:: with SMTP id u20mr2880472ilk.33.1641919325378;
        Tue, 11 Jan 2022 08:42:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9sm5845588ilb.7.2022.01.11.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:42:04 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:42:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Message-ID: <Yd2zXOrf+4qX8VLD@nand.local>
References: <cover.1641440700.git.dyroneteng@gmail.com>
 <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 07:00:59PM +0100, Ævar Arnfjörð Bjarmason wrote:
> On Thu, Jan 06 2022, Teng Long wrote:
> > The original rule was introduced by commit:
> >
> >     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220be0d6ac
>
> Let's refer to commits like this:
>
>     28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other, 2019-01-25)

I find it helpful to have an alias like:

    $ git config alias.ll
    !git always --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short

in my $HOME/.gitconfig so that I can easily format commits in the
standard way.

I think that this alias came from Peff, but I can't remember.

Thanks,
Taylor
