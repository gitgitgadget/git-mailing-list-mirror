Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D4C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD8760ED5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKAUY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:24:57 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701FC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 13:22:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id n15so4249255qkp.12
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XKYwYIGZwg8PV40HcGh9nupJ42mZTYLzNOttvjw1nEQ=;
        b=QtZtkWAyIwR5drylX+3yXWhC9CnaEEqQbEzA/nIGOFaV5G5dUJFQqWxPJ2RIvakod6
         Mxdze9Ink5JUQfWKAvM3nnrQxsYFl5B6vsjPxrd99Z0CxJHutWcaHamVYwy28hO2T0Cy
         hxBaxpBIVEPGKr/mEVxDq5vqQEEE1kTeBHemQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XKYwYIGZwg8PV40HcGh9nupJ42mZTYLzNOttvjw1nEQ=;
        b=EcKd/NErWA4RqSj427PBqm5Hqu1t6Wz+Kw8xcuo/ARa0A/tRe8jPXyZ1GsAFhRjORu
         5j8Vk3OAtr4iPkCmSshXkKGLjo+p9z9PiZ0pqiclnP8/yNo26wGbFr0cVOW3XLIrKmbn
         ZN9t/1Un8FkF4cmJ8wPbt5MdMndis8TKkKNoWYc89VYOr5w8wAccD4W7rjecc/CRUWgO
         /LqjFz0j/CDa0WKR+GNTHD87jJ7EcXgYXNNHMTYh3rTmVo71Sk6z2GkbFWhVculfjn0G
         lsPPCy4fK3Gpus390qY7Ezmndvzhsw98SFx2rXMVzoBAaDBi87kU0K6vFpOdBfJ6DKni
         KVHA==
X-Gm-Message-State: AOAM533l0GZ8NxIPYL1EsIBH9Rj5Uoq+Lz8Q0LFca2O9dDYHzbNpUfKs
        YkwIj0KF117FXVEsI8K22h8kbg==
X-Google-Smtp-Source: ABdhPJwn5EbIODE1g1oUL2kfmkVLa6++BFG5679+QoOvH609tsPQcKEFuDv4WlMLdRcz33i2OxFmVg==
X-Received: by 2002:a05:620a:204c:: with SMTP id d12mr17637323qka.80.1635798142858;
        Mon, 01 Nov 2021 13:22:22 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id i6sm4042682qkn.14.2021.11.01.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 13:22:22 -0700 (PDT)
Date:   Mon, 1 Nov 2021 16:22:20 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, users@linux.kernel.org,
        tools@linux.kernel.org, git@vger.kernel.org
Subject: Re: b4: unicode control characters -- warn or remove?
Message-ID: <20211101202220.dlcebvckeoz6c26k@meerkat.local>
References: <20211101175020.5r4cwmy4qppi7dis@meerkat.local>
 <20211101190905.M853114@dcvr>
 <211101.86bl333als.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211101.86bl333als.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 01, 2021 at 09:02:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> It checks whitespace because that's something that's commonly a source
> of patch corruption. I'm not adverse to adding this to core.whitespace,
> but trying to catch malicious injected code seems like a rather big
> expansion of its scope, particularly since:
> 
>     "[...]sending patches for docs actually written in RTL languages[...]"
> 
> Or just code? People write comment and even in their native languages,
> and not all projects are as anglo-centric as those hosted on kernel.org.

My comment about docs was purely within the scope of the Linux kernel.

I think the following would be a sane check:

1. are there unicode control characters (CCs) present?
2. are there other characters from RTL languages present in the same line?

if both 1 && 2 are true, this is a legitimate use of Unicode CCs. If only 1 is
true, then it's likely worth a warning.

Maybe even relax #2 to just check for unicode characters above a certain
barrier where RTL languages live. I think everyone will agree that if there
are unicode CCs and no other unicode characters in that same line, it's likely
not a legitimate use of control characters.

-K
