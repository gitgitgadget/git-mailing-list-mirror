Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E2C433E2
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0A321897
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auExvkb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFQVbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQVbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 17:31:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BACC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 14:31:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y20so3553475wmi.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zkP/HsRH1xmDGuXamOMt8MCijGYUTwh634F20aMKaF8=;
        b=auExvkb+W3J6R8Wf3uNF2dV2R33ahKBU76ia5KbuY0CruOUs7oFF8Lgd86PrQaey49
         aeP+aKs2AwiYLVAQfG9fZDCrwraZqR5JfiHxQmmJn/jIKsHv+MN2OQsP4UOXC7EPRyd4
         Op5Nobl71Zne2Jbj1tGnakpapjTovMBK8BlkRqq42HWwZpkukCBh8ZnJHQt7qMozCLVn
         T0lJAvdf3xG0Fz5KUr6SzZwtUAWXn/rYzFFCG0G91SwKsaE6qNKMZUOyHYDzBKYBvQvZ
         u/39JJkqEXImLETPoo95CO6iReiGj/vBzr0l4tetZPlsWWQ/x41YJX8963MN0pwhH0FX
         50SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zkP/HsRH1xmDGuXamOMt8MCijGYUTwh634F20aMKaF8=;
        b=sqGj1fABk+DxqrJxv6F7ENwx8zjdkza7fReJ9QFw9wD9EUQsCO3ABRP0WwXcEOXYts
         +0+wX/LZCoQyWHRAxEquzsWp4tZWVDnccvwIPNGvyJgucUhVUdsnop/NaCpqF4nw11d+
         DnEAoXpQet0wkE9FxNuZl2UfV9QkmeYWDY7l4dHO0E3Ht8K6HWTVnvqlQmUWdNmmlwTH
         7luCZUVTBxu6wWQxA0COheIOOqNeNg42fQ/APcay1OgBUAUXF+ggrZqPAAlpwrfyiUA4
         B7IJXB3XZC79Ts5x7mJLw1i9yC1VzR+X907HejVbqFkwJRpLsy7ocLWe81iNdyGGUqot
         pY2g==
X-Gm-Message-State: AOAM532hVaKLmCjs66uAAcVVGQ6GKlrVGRK4iT/TlJQbZI3Es62fh2p6
        alyc0uEbZITsXNd3rhoUjkh7KF4S
X-Google-Smtp-Source: ABdhPJw19MLlsUe3YJzQRL8EEJok2xQgfjftqnwg8P5UGl9OQXtjOJ38T1mkqHUpZsOuhH7Rt0HdgQ==
X-Received: by 2002:a1c:541d:: with SMTP id i29mr641878wmb.73.1592429480932;
        Wed, 17 Jun 2020 14:31:20 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-44-79.w92-156.abo.wanadoo.fr. [92.156.149.79])
        by smtp.gmail.com with ESMTPSA id j5sm929587wrq.39.2020.06.17.14.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:31:20 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Son Luong Ngoc <sluongng@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200615152715.GD2898@szeder.dev> <20200615215020.GE2898@szeder.dev>
 <20200616070645.GF2898@szeder.dev> <xmqq1rmdv4q9.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <b1da563c-6191-963e-6829-d30a15233d29@gmail.com>
Date:   Wed, 17 Jun 2020 23:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rmdv4q9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 17/06/2020 à 22:04, Junio C Hamano a écrit :
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> On Mon, Jun 15, 2020 at 11:50:20PM +0200, SZEDER Gábor wrote:
>>> On Mon, Jun 15, 2020 at 05:27:15PM +0200, SZEDER Gábor wrote:
>>>>       - Should we even allow 'splitIndex.sharedIndexExpire=now'?
> 
> Good analysis.  The most conservative might end up to be to disable
> splitindex altogether but perhaps we can first set a reasonable
> minimum to the expiration to say 10min?
> 

I tried to understand what write_locked_index() and its callees does,
and I think there is an issue regarding how split-index files are handled:

 1. The new "main" index is written in a temporary file.  This temporary
file is either renamed to "index" if the COMMIT_LOCK flag is set, or
left as-is (cf. do_write_locked_index()).

 2. The split-index files are removed if they are too old, without
checking if the COMMIT_LOCK flag is set (cf. write_shared_index()).

This could lead to a situation where a split-index file is removed
because it is deemed too old, but the main index is left as-is, still
pointing to this file.  I am afraid that this can be an issue, even when
`splitIndex.sharedIndexExpire' is set to a "sane" value (which could
obviously be exacerbated by `now').

Alban

