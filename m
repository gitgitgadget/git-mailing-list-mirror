Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6408B1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfADAUa (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 19:20:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42275 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADAU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 19:20:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so35161323wrx.9
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 16:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqTZrFQbIh/4/fqN68GFPT7pmmHFMiHC4k1iiqbkWVM=;
        b=dribAFZyWpqOCkSslWseTFH7WBwJsiZ7NtId8XE0f2uXclOr+3xIGZ1KAd9DHl9eFv
         Lplq2XNv8e4CpFnmzrvuiHdiXFrxZhgS2wteaiLwzseSOqT9lQMSWNfg1eAeTHGoh649
         uY/k+uCgVhtH5aqnGxy+NGAP+iLQfDDUBj+CFAeDgz303N/JT3/7+fRKe9ttHYAy5KW0
         X71u+RiWemWwSMlayMXuQ7my6eu5ViVgaIy7aWc8tw5mQb9aRuyi1fG9VcZ9CG+g1Rm8
         RmAGPL3TMysxJVWl6vVECh+gOaWKbUwdlBFB89qrj675e2nZlQSsOMI+KG9gk7/WtpZq
         cwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqTZrFQbIh/4/fqN68GFPT7pmmHFMiHC4k1iiqbkWVM=;
        b=de+Gkgc9RHjMWZUTHC9i0pfzB/HWNWsiw0sVSfjAddU8Y666d/WKMTnoDc9viKlP7N
         a2ozQ63odNHC4BYvWM36b08BKeJHHZGPr5NOfBoGSw2L/t+s0DNlUL8dCMN3yX/YqKWb
         xjTwRmGXoqrQGtMW51N9SMKSdp6j6vhrbpG4YoZaHC5lJtC4ucpc7e2m30w8Vct9OA8F
         P1gho+v1BEaLIgTWiExCYzo5CcCcZa2GQfsJTbGLwqBEMLy+yvdwuBKLnk/bQbKMl45Q
         IxrdHSEcKV6Nn6V6bdd1ZmrnLxBbnDA65X4vE5dL2hoiAd8B9ITBiA+9KgkcbnEYV/Xr
         Kt1A==
X-Gm-Message-State: AJcUukeT6FxZNcfNGIW3UqdV+kpG5asv9yMY+E4jlCmEzCciRY9dzCyP
        5a4clb3akMu5gbL2U/86LrX7uElbA6hV1gu6tWSlaw==
X-Google-Smtp-Source: ALg8bN4ApsDhHA9XTMvNJBkVDwSKL2XUS3YEJYUlRcQwS8tIxRYECZlClx7tJJau8wrfceno4qLGrThW1RrhADVGKmo=
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr46412226wrr.285.1546561227877;
 Thu, 03 Jan 2019 16:20:27 -0800 (PST)
MIME-Version: 1.0
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
 <20181229211915.161686-1-masayasuzuki@google.com> <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Thu, 3 Jan 2019 16:20:16 -0800
Message-ID: <CAJB1erU0utjKGtv3LBFT6SEEKCfFRuxGvDtpkKeS3GSC1S89JA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Accept error packets in any context
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 3:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> > This makes it possible for servers to send an error message back to clients in
> > an arbitrary situation.
> >
> > The first patch was originally sent in [1]. This version includes some fix.
> >
> > The second patch was originally sent in [2]. Later, this was cherry-picked in
> > [3]. In the discussion in [3], we agreed that this error packet handling should
> > be done only against the Git pack protocol handling code. With this agreement,
> > the patch series sent in [3] is abandoned (according to [4]). This is a patch
> > series based on that agreement on limiting the error packet handling.
>
> In short, are you shooting js/smart-http-detect-remote-error topic
> down and replacing it with this one?
>
> As that topic is not yet in 'next', I am perfectly fine doing that.
> I just want to make sure that is what you meant, as my reading of
> [4] was a bit fuzzy.

Sorry, I think I referenced a wrong email. [4] was meant to be
https://public-inbox.org/git/20181219233005.GI37614@google.com/. I
think he wants to have
https://public-inbox.org/git/20181116084725.GA31603@sigill.intra.peff.net/,
https://public-inbox.org/git/20181116084838.GB31603@sigill.intra.peff.net/,
and https://public-inbox.org/git/20181116084951.GC31603@sigill.intra.peff.net/
for js/smart-http-detect-remote-error.
