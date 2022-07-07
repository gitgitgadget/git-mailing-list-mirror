Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D344FC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 09:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiGGJPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 05:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiGGJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 05:15:43 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797372B1A3
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 02:15:42 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n74so1816601yba.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXEuqnRNqP0jkxwgC+2RohROC/AxnfaaoKYF+wQNJkw=;
        b=J/lnGnuuEQMbbVV/GQicBrSjE6rx2XbMWS9kw3+hQxpcm9ejShuh3rN8zNE2L/8CTP
         pm7H91kehPy/pXeuiJ79O1Nqu77xLHGw9tRmsOJYYTaCNexEe4+E6WkxJb+2P3zgrZyC
         61ces+zXJdxFPWod2o4TliYYZ/kwn4rrXW5ZgI3mM51m/aP7HPPAjEP60emOH2KJuwia
         8UZZbgmFELd0Sxkw8k/uhd1BejiyMo0eqx0eRGHoUJ5tw9M7v0tiVSR9rg22MV3uVCaa
         YLmEFKMZZ7s2EQ/nekvUQKOHCIgNoV71i4kSe92L2LjGZ8dXDX6fKu6Ayg59l55GDRRl
         XJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXEuqnRNqP0jkxwgC+2RohROC/AxnfaaoKYF+wQNJkw=;
        b=uIg95NhDTffwyjIV6Kfi+GBmz1GSriSbo1LYSwjkMngf+KxjA/19guURWFxITI+O8G
         XEfoa/jkOkfHddQTdD6QnnFxFzUylC54W2UvONKQG793fmJWO4l8cXxAhhWa92DTGiLB
         zLcgaYYZzIltwr5cNvCwPs+u32IXW4ITD+vqoN7GgT37YsPKFtV6m8lEGQdJUa4EunGx
         JJrXwHUgGAul4BzkdUDYukSmjYZgYTDZM5CyH9/HEFIMTtug6GT4VbwtaoR5IqE5q9TY
         QbF32RDwtdYhXhlZ0Rp/vmW7BG8ewjFGraQgsNY9rARLwzuuqDwjnkLtIfm5S6lDA7Yv
         2wFQ==
X-Gm-Message-State: AJIora9a4ka86H73e8j0ga71I8kFPUIxRd54Qh7bgyBHLMIHEuUxBT05
        wXhu58MwvQs+mzDKG2K55sCXlCyhH6YrdO2KCCKZQLPwRtM=
X-Google-Smtp-Source: AGRyM1vAhZ8W/NMNHrQeeDVPrhr9rfzNm9G4x++MuIYi+wSwK9diz4NnfjRTh/h0HtJowpnySKSsDlqtvA2BcehbldY=
X-Received: by 2002:a05:6902:114c:b0:66e:a56a:1783 with SMTP id
 p12-20020a056902114c00b0066ea56a1783mr5969449ybu.13.1657185341553; Thu, 07
 Jul 2022 02:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-4-siddharthasthana31@gmail.com> <61074b4c-c48f-da89-5d03-b280b9c4fedf@gmail.com>
 <CAP8UFD2tYzoKSr7HnQ+LbCE+YWoNqo3qPQrbr7ZWAMnDt+ajCg@mail.gmail.com> <xmqqletddegb.fsf@gitster.g>
In-Reply-To: <xmqqletddegb.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Jul 2022 11:15:30 +0200
Message-ID: <CAP8UFD3ohjS0p02SKwqKWBK1=sVuC9+iDT4at2R9ktCUXme9rA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Siddharth Asthana <siddharthasthana31@gmail.com>,
        git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 11:33 PM Junio C Hamano <gitster@pobox.com> wrote:

> Independent of what this "The output from 'cat-file commit' is
> tweaked" feature, I wonder if we want a command that can be used as
> a filter.  Just like "git name-rev --stdin" reads a stream of text,
> finds commit-looking references in it, and annotates them, the
> command (e.g. "git mailmap") would find ident-looking strings and
> replaces with the mapped results, or something.

Yeah, that might be useful. Especially one issue is that trailers like
"Reviewed-by: ...", "Helped-by: ..." are interesting for statistics
and replacing their content with mapped results could help improve the
stats.

Related to this, I wonder if `git interpret-trailers` should have a
simple way to map trailer content.
