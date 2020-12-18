Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0A6C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC30E2311F
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgLRCt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 21:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgLRCtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 21:49:55 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B11C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:49:15 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id x13so646912oto.8
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 18:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LxS28tAzSjTvExTSmBJ1gef1imE207RF9M4CIrOp7nA=;
        b=KlkZT0j0qV9ilaViLecLMUKf/6UwP8vH7FCyu3o/9Q4b8ts2mGPsXCno7TkMvjHxpg
         45aXkefPbjM/oDdcDQ9iwB1lnw/680Ki1NDAMDzFZ2jsWWgyIiJmdYd34SwNpcJSFc1B
         xWWhEU7X/d3y0i/zLamRW3xnuBP4ZC4jtVB1rj6jikNYMkwSC8HXaYB1BI3du8Fk4VJv
         AMsFtWSRG2bp1o1pAuGnAe9p6Bo+TztgJRInRpqKUjdP943z+dx+qMPWczfJZ68Fni7q
         dTC619wY39s+xKWlMZabBHZIqOo1sxoKP+58prYhyqXjRrHotCCuq+RrMYZTJ5ffHO6p
         Fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LxS28tAzSjTvExTSmBJ1gef1imE207RF9M4CIrOp7nA=;
        b=fLI+PufsjUBbrFqAWwGsC1XnPDND+mCNHcpq4OjIy/voF9palep15+05qp6J4n7fiT
         hRnPKs0dlHm2uPFkYGIcS4MDq4zBtZGVv43htgKNdh0f6b6QX+SSHzMTx/APySAgBHSH
         92AG+jUi86vUsFRVKm210P2+WsaveicyXr6UVBxJ0sjXUmeFrAJNg8/NAGzMS9SKjTom
         Gl5xroOUPGHl2z2QQpLKj4mVmt3HJVAgQEGt04A8cSnGYdF8j6AIQaTVtIDIdpAkaM1h
         j5A2VBM1lR+FcykmjevgbmDjZ75OIjT+Ecx9ZtKCZZ0CGkggD+PLeyugWkZ2/892+djd
         S+nw==
X-Gm-Message-State: AOAM532Yi0JvTbwcK1BkyvVxxp8zrbwqdb4hxl1eAlIHgnIiMB0CBQkw
        fEhgKp76zbzeLC6fpYvtl10=
X-Google-Smtp-Source: ABdhPJwVbCx3T0qnCaxj4gJZ5q8KnAIxn89TuZLfBFBuiBuG/0UWj1V7Vtf+/xxzNSvuIeedJ3GoFw==
X-Received: by 2002:a05:6830:30a8:: with SMTP id g8mr1374433ots.291.1608259754982;
        Thu, 17 Dec 2020 18:49:14 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g200sm1509166oib.19.2020.12.17.18.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:49:14 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:49:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fdc18a91c402_f2faf20837@natae.notmuch>
In-Reply-To: <20201218023534.GA117762@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Thu, Dec 17, 2020 at 08:05:33PM -0600, Felipe Contreras wrote:
> > > Would you mind switching the autoMerge option to be per-tool rather than
> > > under the main mergetool config section?
> > 
> > As I said; I don't see the point.
> 
> I know you've said that. But I would prefer that, and Junio requested
> that, and other people may prefer that as well. Since it's not too much
> trouble to make the option per-tool with a global fallback, and since
> Junio already provided example code to do that, do you mind adding it
> anyway even though you don't see the point?

It's not about the level of effort; it's about doing what makes sense.

And no person is the sole arbiter of truth, in this list, or anywhere.
People have managed to change Junio's mind.

You said you would provide a list of tools that would be affected. Do you
have the list of tools who would want this flag off regardless of user
preference?

Cheers.

-- 
Felipe Contreras
