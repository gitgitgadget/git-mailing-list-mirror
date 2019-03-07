Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EF120248
	for <e@80x24.org>; Thu,  7 Mar 2019 07:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCGHsD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 02:48:03 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44966 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCGHsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 02:48:02 -0500
Received: by mail-io1-f68.google.com with SMTP id y13so12632523iop.11
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 23:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAcVYzwCJwX7GNskUqabpKRbDbgUM4YnVAtOG1vyXQ4=;
        b=kpAULAaTiIX4tQRpFoUhj4d6zksx7SwBPOMjLIFJEArTph+vfskpQ13BVguQENr10r
         LqHU9kYiXD1DSS6iLYrJpydSrDRzeDLIA2n7cbNhngcFUiDE2ZSVXDQRxdJ2KKjYfVbo
         DBnLwslxC8qtlL+2OUFC5BTnc1I07MXsuXNO9aDLkl+Tw9eC9INEZSRDmSz/jPaMJjSi
         nuJW/kW4/J/4aD3nd5umLnN0+l/JzZ2/g8ScJt3zdfey1bDZMiSR/jIQSldNOw/IIvqS
         DxAXHWH/+jjTGt3ibxa5sQrUGqRSghGaUeQtucPPjDPsPUJ5vgOehT7qE1irp8n+KpoA
         rrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAcVYzwCJwX7GNskUqabpKRbDbgUM4YnVAtOG1vyXQ4=;
        b=MzTustc61qPUaG++H580VhwHeU8Gmmyv+Tavkigbr3144iXBwSt/VlaVtNU6clMA2O
         Dg0rGk1scXDHW0zofDaGTTvzXAiVdTj1V9QSzauRRDID0o4uHe68y3zDoq6PvJDe+ZvC
         Gfa5KcAFP1fh9urmE5FSSz/mDCJvXkg3qwxEPA7ug03UNp9UIbqHewpngZjU0f+/ZYVA
         uq47L62BCt91gGa46N9BP6rzHtRT7vLkc+ard2kS7pgnUQ8IpuKoBgtZ9B5UBb6qLqTb
         +rq10qsKsvJHDDcSbLeOhnwniMG02n4c7vcynrzNQvUa8010KtCsfHIYHcGWIyEImdo4
         GxBw==
X-Gm-Message-State: APjAAAWoTVv51NnCEX8Z/LKULQQfFVH+gw1e4WfYaxGZlKNW9iDI2aCy
        cQ8bpfp3B0SByhWw5AF72tNEXenGdlTT3vIxgnA=
X-Google-Smtp-Source: APXvYqzdeRyF2xZuelOWw2CKusmMktD992NEheXuAr8kPQ/kEIBGgYWz1dsVHAb5Wb7C4tD8buQZ/14ipCWnCLWggk4=
X-Received: by 2002:a5e:8416:: with SMTP id h22mr5775465ioj.118.1551944881817;
 Wed, 06 Mar 2019 23:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20190305154951.4407-1-brandon1024.br@gmail.com> <xmqqy35rpp13.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy35rpp13.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Mar 2019 14:47:34 +0700
Message-ID: <CACsJy8DUGxUOko5fk5LLWKo_pmxAF=4NJxobNvGqWjTFWFNFiA@mail.gmail.com>
Subject: Re: [PATCH v4] commit-tree: utilize parse-options api
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Richardson <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 6:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> The change to this main function looks quite straight-forward.  I am
> kind of surprised that a very low hanging fruit like this had survived
> without getting hit by parseopt a lot earlier ;-)

There are more (I guess we tag #leftovers nowadays?)

git grep 'strcmp.*\"--[a-z]' builtin/

(with some false positives)
-- 
Duy
