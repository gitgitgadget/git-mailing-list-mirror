Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE7C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 15:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJDPKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJDPKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 11:10:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642665C359
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 08:10:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nb11so29537801ejc.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=as7EJV3yPdOr+7r/9D43VuHsrWrNSNlYGpfX43Wn9Fg=;
        b=TkqpGWOQOaNED8FjCNO43v7XWz3km+NIuSc94dGi7m4hRh+xLCPEG8dNnimfbAKiy/
         yNKrno6XmNSROKwgBa/EcNYhv6w/qnwS8zAK67Dkj4wAnmAa/DpvFd1w+NGmUEdqe0dM
         fbI8bPseXXO9c5qzgQhz+YgiPBQ+XMkvlZaDSTCtw+qHdSglEpufvTyVUtxnbUMMxMYe
         r+w2wv7AVjemzYs2H7ZWsHOA+eb55V1mI4pGYHLDD1iYd0kPq+f2v0xrtDgyQh9ahIz9
         jR5cudlxZRMdle7ZhQ8sPWSvtFzLgJjrPJt3QISfwAyQuw+FQboI0xX2bwydmBj+3qKb
         TaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=as7EJV3yPdOr+7r/9D43VuHsrWrNSNlYGpfX43Wn9Fg=;
        b=17trqhLWnvEaLAv4C+6sLfNcSFazKTGUTxdl2wA+4pgw6sYbXTY5zwvA+udQq03Z0t
         yOclpztlUIIcoUVHbcmn7eqesdHSuu+PBN1xhAIL1dfWBCTtnH9qfknGxIEoqh1hwx9j
         B8i6Hxty6Q8x2EvhBWBbP9Xp4vST0krEbF2blOC4XSWf06cSjBsacGZEk2pAalJ64qbS
         O+LLhU9yqf8GQY9p7yecaDsFF9pNDX0nmeCzXrtUNwD5PjhaVyR1df3PcsYuRUL3L+eU
         Rk0cKQFR8CDu8OYeZFbjsHtMNTin2vqdijNjZdPVEDQQU99TkWP8uwdeEn7gY5zo+vl2
         8dTw==
X-Gm-Message-State: ACrzQf1L2te11lCE9f6NRJzv8Xx5NNfeyQAvtHzOje/TywHitno489Kt
        Izw42z7GygO3MpgdQ/Pb7LamRXgeNN5Mni/e4RkSS6Gi
X-Google-Smtp-Source: AMsMyM629//qk/XHlEN3ytS6e+XLznshVZK4mT486x0AvXDXZg2wmKO7gUyJkzDUy6LPBzEqhH4kPgSOyFqLb9dpZ9I=
X-Received: by 2002:a17:907:a050:b0:78d:1bed:8903 with SMTP id
 gz16-20020a170907a05000b0078d1bed8903mr2286808ejc.735.1664896236790; Tue, 04
 Oct 2022 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <87o7ur1wi9.fsf@gmail.com>
In-Reply-To: <87o7ur1wi9.fsf@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 4 Oct 2022 08:10:25 -0700
Message-ID: <CAPx1GvfsRipG0qgDmMMoU+WCWCEyr4ayJteYWAy+EoJOoaNQXg@mail.gmail.com>
Subject: Re: Using git-update-index to add existing tree objects at other paths
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2022 at 7:43 AM Sean Allred <allred.sean@gmail.com> wrote:
> ... but the following does not work:
>
>     $ cat | git update-index --index-info
>     040000 tree TREEID1 PATH1

The index is not designed to hold tree objects (at least not at this level),
and update-index should be fed only the full path names of files, symbolic
links (mode 120000), or gitlinks (mode 160000).

Whether it's reasonable to ask for the update-index command to
understand that `040000 tree <treeid> <path>` means to insert all
the files *within* the given (existing) tree object, at the implied
constructed paths, I'll leave as an open topic here. :-) But if you
were to do this manually yourself, it should work.

Chris
