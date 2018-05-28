Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311531F42D
	for <e@80x24.org>; Mon, 28 May 2018 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeE1StX (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 14:49:23 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:43684 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeE1StW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 14:49:22 -0400
Received: by mail-ot0-f180.google.com with SMTP id y10-v6so14379358otg.10
        for <git@vger.kernel.org>; Mon, 28 May 2018 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cr+IGaOC6FSmqjvbsjbAVpeQHPstPWS1OKHZBIPUNT8=;
        b=IGtK7GGyS65y0v8wgTp0fIhppZRp33mH7T2Ph6jUKE7PRbH1li5BFjoVbMJHhIi/Yo
         fQpcIYRYufnB7r9b7VJaGjvRxoJfoYq27DusWnnrElBIaRRW0Emmoy6W0d9WSSTscRu9
         MIB9EC/7EUnKLQF+wOkjFVReKEcHYXE22S06KZds2LPexbOwVXm33mut4GZZViI5CXiD
         Tydom90vLq7iVP4vfuCw5e11sXllOmL750FfW2KAgMGpWtzopv8J+yq+2JWWPhiPuOPL
         zMaiwVC1v0oFj94jBaDAS2bPxqiYdplzSTTJE09G6VtSe5DWxrJ1DNxtfShomTNTNCS2
         qGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cr+IGaOC6FSmqjvbsjbAVpeQHPstPWS1OKHZBIPUNT8=;
        b=qH6rU13AQCgsa1MtTT+3xvIif2eNwOieaTNJqzPBTCTqH+r6J0nj8aJTyeolCCfagp
         XJXp+nggaZky8Ko6oCh8r/YaFEiWyTpl54mzmVY5myB/yURLJqQnRTYGdYp74vX7oUGt
         8N407UhvbHsH2jpo7GdVYDQjv4OOkCnlCA3EeUcW4T7LfHoDGLlA9WY3vrFMcDbOcgUu
         CQ2L2xrcL2KTEvdHfCySz7GDxLsQky14XIbGxTSAHwjKnM12qD3E8z/GdKc8jXjWf0FU
         QT9kEAlOa2XdVbTP0ndrHf/I3bUXWdhV+KgnB06Zbo7kvDcc5VIgnrR9o3GsJZVFtjtW
         letw==
X-Gm-Message-State: ALKqPweH0PNtr4GKviW39S5duM8Fhyt1XYMVrS2M9BJMPs+9lEEn4Nf8
        Gj+rRiegglFx+Cy+buQsKNwhTQowwZ/XjeA8k14=
X-Google-Smtp-Source: ADUXVKJ+T24cXdxpB1UxKlbeujetabafPbUawHNDj/7/Zaq8TAnmjtlzqKmUgeHAdAMbH/ZIbIGdhPIMYJkQbWqnexQ=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr9742894oth.75.1527533362470;
 Mon, 28 May 2018 11:49:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Mon, 28 May 2018 11:48:51
 -0700 (PDT)
In-Reply-To: <xmqqy3g4jpck.fsf@gitster-ct.c.googlers.com>
References: <20180522194854.GA29564@inner.h.apk.li> <20180526113518.22403-1-pclouds@gmail.com>
 <xmqqy3g4jpck.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 28 May 2018 20:48:51 +0200
Message-ID: <CACsJy8B7g-J8XeWYpY9SG1p51-fBLE2-V5872uWbyBXY2aVoEA@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: reject shallow requests that would return nothing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> To avoid this, if rev-list returns nothing, we abort the clone/fetch.
>> The user could adjust their request (e.g. --shallow-since further back
>> in the past) and retry.
>
> Yeah, that makes sense.
>
>> Another possible option for this case is to fall back to a default
>> depth (like depth 1). But I don't like too much magic that way because
>> we may return something unexpected to the user.
>
> I agree that it would be a horrible fallback.  I actually am
> wondering if we should just silently return no objects without even
> telling the user there is something unexpected happening.  After
> all, the user may well be expecting with --shallow-since that is too
> recent that the fetch may not result in pulling anything new, and
> giving a "die" message, which now needs to be distinguished from
> other forms of die's like network connectivity or auth failures, is
> not all that helpful.

An empty fetch is probably ok (though I would need to double check if
anything bad would happen or git-fetch would give some helpful
suggestion). git-clone on the other hand should actually clean this up
with a good advice. I'll need to check and come back with v2 later.
--=20
Duy
