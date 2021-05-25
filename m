Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99EDC47084
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A931D61409
	for <git@archiver.kernel.org>; Tue, 25 May 2021 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEYJ3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhEYJ3p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 05:29:45 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577CC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 02:28:14 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h11so27542476ili.9
        for <git@vger.kernel.org>; Tue, 25 May 2021 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ug9BO+2qj8hKfeTbiGfv+IeYW0QzmO3D4E73UVcT1E4=;
        b=FCaN+fWArPxS5xNdt2PXUVYxR0sBYekP8X+QAmYZ4xjHJmDQlA9g+LH4vOKUyCIljX
         OCBi6uArPr5iPstud5/VGGKtY4W2UIurxdwmdrqKUofwGVRRKulTjk15goJyxjzot8+5
         Dbfgp4OHGPdfW42ZkcFV+T24ppJaTlmNcE5YEV5APUSC2kN4UU1+IZRfZAA5wLMJ/gK0
         dMuuXcz8JAKvyYQDYmlxGx7wsLwUamU9Rjt5dlzHCkD2eQhAWVwNFWhhVb9hf4xicu/v
         tLpwHRa2QjDK6mTwx822JxmjOFn5DTlHEeDR9Rn6JPXmLpouAtl9BEIljdGacm/pv3QT
         Q/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ug9BO+2qj8hKfeTbiGfv+IeYW0QzmO3D4E73UVcT1E4=;
        b=D+247oeSzT112a8oeKu+mtDmmfQUbvXLeUybPDOWwGUK0Zna2OyYu9zKBMNVE6MVEe
         wyoUqQ9JMd3yqWysHtDHasV53FmIeT41xzDkU4pLDk/gdI4+4jjHmfHYBEF3WOzonxTT
         UlDws9p5oMNtjI0len9GuoRAQnyswrIr38BHyUFq/DZwi7qXUxxfFaCbdD8WQ9wY0MCK
         uRc/WXw+6/Agj14CwsAIQeVAqVM5JzjQncSwFr8pXAVvzLkrVMNEDy90vXGHfKwjMzuN
         6XbCXkoe5nwGLS2ooy5DA+mvO/X4FsdJ5WD/Tnqno9Ebuca9BltAAJoQu5WHzN80Zgao
         nzqA==
X-Gm-Message-State: AOAM530vdQCvvXPGSGbqtPrfq8CW1XY+P+8zP2dbqLyvu3wlM5/TlfTb
        biQGJUe1HEu657RMbVA2Ptt0rYeNst4ws2Sk/IA=
X-Google-Smtp-Source: ABdhPJwEd1snoh3W6WKW0tlBq6xl4A3xXDKaLPUWjdN2FLKZZrG3RYyNCN5QW67fLlumKpD9dkOKhiJzl0Mf0FjnTV0=
X-Received: by 2002:a92:d24d:: with SMTP id v13mr21019219ilg.174.1621934894172;
 Tue, 25 May 2021 02:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <19413cfdb1ea50de401ab958b954a550b6514688.1621763612.git.gitgitgadget@gmail.com>
 <xmqqfsybh0bn.fsf@gitster.g> <xmqqa6ojgy9h.fsf@gitster.g>
In-Reply-To: <xmqqa6ojgy9h.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 25 May 2021 17:28:03 +0800
Message-ID: <CAOLTT8TaJm=9mQNXMGxt-bME-ynOpv4CKZvZw+yo9zNueH_VPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] [GSOC] ref-filter: support %(contents) for blob, tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> To extend on this point a bit (even though this is not all that
> urgent during the prerelease freeze), conceptually, the %(content)
> field is understood in the larger picture like this:
>
> +--- (the whole thing) ----------------------------------------------+
> |                                                                    |
> | +--- "header" ---------------------------------------------------+ |
> | | tree 678c03dca0a26afd746e8c8bb9e4aadc8bf479b1                  | |
> | | parent 378c7c6ad48c4ccddf9b534616a0e86f28440bd3                | |
> | | author Junio C Hamano <gitster@pobox.com> 1621675665 +0900     | |
> | | committer Junio C Hamano <gitster@pobox.com> 1621675741 +0900  | |
> | +----------------------------------------------------------------+ |
> |                                                                    |
> | +--- "contents" -------------------------------------------------+ |
> | |                                                                | |
> | | +--- "subject" ----------------------------------------------+ | |
> | | | Git 2.32-rc1                                               | | |
> | | +------------------------------------------------------------+ | |
> | |                                                                | |
> | | +--- "body" -------------------------------------------------+ | |
> | | | Signed-off-by: Junio C Hamano <gitster@pobox.com>          | | |
> | | +------------------------------------------------------------+ | |
> | |                                                                | |
> | +----------------------------------------------------------------+ |
> |                                                                    |
> +--------------------------------------------------------------------+
>

Thank you for providing such a complete view. This also means
that the "raw" of contents and tag will contain two parts: "header"
and "contents". But for blobs and trees, they don=E2=80=99t have these thin=
gs.

> Even though %(header), when it is invented, would make perfect sense
> for commits and tags, it will never make sense for trees and blobs.
> Which means "contents", which is "the whole thing except for the
> header part", would not, either.
>

Although we don=E2=80=99t have a %(header), but in fact we already have fra=
gments
of "%(numparent)", "%(parent)" %(tree)" (see grab_commit_values()) and
"%(tag)"," %(type)","%(object)" (see grab_tag_values()), but they are not
obtained through the "header" part of the raw object buffer.

> There is no %(placeholder) to ask for "the whole thing", and that is
> what you want to use for cat-file --batch if I am not mistaken, and
> adding one would be a good idea.  There is no %(header) yet, either,
> but if somebody needs it for their scripts, it is clear where it fits
> in the picture.
>

So I don't know if adding %(header) will cause duplication of functions.

Thanks!
--
ZheNing Hu
