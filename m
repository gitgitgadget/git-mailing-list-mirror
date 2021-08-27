Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCFC4320A
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8055560F6C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbhH0HB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhH0HBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:01:44 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC3C061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:00:55 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id ay16so241972vkb.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UU+5CAC+/dMFRRoHbUvm6M8lLGl2jDmQs0CVW2CRtLo=;
        b=sWFdz8qLTnifjQZ2WvdIMnyjoIYcmNlfSWMQvVR2nDSsmOfmtJbNvI6gDsfvmRH2+l
         NQsPPAVzrjqGyrWyk2pfDzTSGBpHPyKHXKhtAsLDNI9RMdXiI+YlDg6UXQQx3mKdu4hi
         tscCy4OVq/iSE0pCxq2vYK9TfbjXh6YgLbSsN/9rb6gjE/PqG7SJvZvy1YMo42fVNg/D
         8DgmT5X5GzASKYalZCpZeaTQeV41HEM4cp6li6P+kNOEsAU1vT7B6FZU0vQyxZJPhA63
         fp0a0/Rt2ywtVmvKmZCPybMcVDwkVUnjmZJjWgTFJGxsICA5r52jpeSgxl+gi0RElrNP
         peeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UU+5CAC+/dMFRRoHbUvm6M8lLGl2jDmQs0CVW2CRtLo=;
        b=LW9yGWFkevZv5v1zVZuVVuMgpuud8IjI0hOt3ZiRfWzXnW2w6sJKrCLW2e322ZBk7N
         BwuV+rSFR6GN80xL/dPxkw60xnEd4i3VwPJnJoPBah2auP+NBvZzdTovNZKVu6A7RFKz
         oOjy4HKwTVLGfEQLZW2zYGkJK3l62rDad764eDkDONtuTmvJ1t8w2j54bmZKGgnSUSZU
         rrSQmzQk5R/1ZceCM8u7wFO7o6MNG6ouuouo3u16XbftdLSZzdbIbnpYWGks/hJeZX9J
         C1IAn6/XPj7vxLYeEmoQe+w0zNasmuLZ0nm8zQ1ilfUnP1ssZ3LAyjpdUQtKjxaiyrM3
         7CSQ==
X-Gm-Message-State: AOAM530+v/xFlIR3Y/EpCHlBLc936hE4SUe2VG2FD6D8X10iV9iAjwea
        Tm/cKF2eeLBskNwMgiQb+1ykmiRbTWCTciZ53nQ=
X-Google-Smtp-Source: ABdhPJyh+MfCSuO/61VGX+nU4Ia+HIenDLqJ50EbglF9UwCM9EoM2zYzRqdgyXl6uRuUKGmoDgU+jbN8ov2OScLeHXI=
X-Received: by 2002:a05:6122:181c:: with SMTP id ay28mr5503724vkb.15.1630047654940;
 Fri, 27 Aug 2021 00:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwno7bgeo.fsf@gitster.g> <patch-1.1-f7d9c8af0c-20210827T055608Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-f7d9c8af0c-20210827T055608Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 27 Aug 2021 00:00:44 -0700
Message-ID: <CAPUEspj4AbB+8O80vQ7etOwn3XMs3Gnc-cBc8=WaCDg6+zruQg@mail.gmail.com>
Subject: Re: [RFC PATCH] reftable: fixup for broken __FUNCTION__ use
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 11:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The use of the __FUNCTION__ macro is non-standard

and is also problematic because it is a "magic" variable[1] instead of
a string literal.

FWIW, __func__ has also the same problem but it is part of C99; I
still like Junio's solution
better than my own that was using those.

[1] https://gcc.gnu.org/onlinedocs/gcc/Function-Names.html
