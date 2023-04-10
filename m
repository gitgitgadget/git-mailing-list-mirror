Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5FAC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 17:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDJRHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjDJRHe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 13:07:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41E210C
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:07:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e11so7121137lfc.10
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681146448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcAXhQqG4TMl+ebTMae+AF6hSJQsRlP4KvRY4sj0NlU=;
        b=mFaxWMSZWk1X+jePZbHDfu2pcnLQ8MJyOIWSFKbfPr3qbK6/mIZhGYDFLDgXugZkTM
         oY1T5/k3O+iUaU5Ei5oAf36yVSYC22iui6WYtnHLp6NNP3lrQ1FFhqTUjOcIdeMYU5VJ
         uwCFGdVJMLHOVpZmaJBtvSKVCqhKnoJvEoYBBI0p6JUe3pmZddk7IFbDdT2e92qlULsO
         gyRqDfyTly3mXCNbrWfWTK7EotVUMf3zken913tRzOtfh9Fv96mBYxJdu6io99vfKGET
         qNWzxWbDOqLq2Bkqo8HQbgRpq8+eb473XT9p4k7oOZhATqk8k+8XWYfq9qcAP11Ee0Wj
         j8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcAXhQqG4TMl+ebTMae+AF6hSJQsRlP4KvRY4sj0NlU=;
        b=pylWU3DXKiiumRn1b7BjdTXQ7s6kXeT2zIzmuo9hFTe8zQuXIdykcuaaXR3UuuoTsB
         Jml3WV15+Z3gqyUm3XfaAZnloiEY3orNAV9aVP7lxWc3Nrsso3FogIa4nHQd0Wcwb0ON
         vxoSWjG29a8N55e8rhAyBvESdXWPVqM3vaikfVA0843JZsPvR6sRZu3n+OhsblzqxWeZ
         iRZKjvtY7nnaiqTxsyRU/kNmtE8RA/01WiC6geXR62RxMOF2r4VUtSJm2Aby0QxvCYy1
         G0J3NeOTc93t5sRXxUwAETEipSnrOAiPP4om0NsfV/nXWSJ6/WpJaOx/B4UOi7XFRpFR
         uMYQ==
X-Gm-Message-State: AAQBX9ehkS4OrtpWnI549VH+oweSOlh8GDDxYEQkRXDdvIIh7LEzhI12
        ZObATnQl9jviasxsuO7YmegqrW8O10gwf2bqS/QollqgUtOQJA==
X-Google-Smtp-Source: AKy350b4WGWNw2D+sJQTYw6FADuu00rkSJgZrE2Zl1E6N6YIIMoekvxjAeTDAGL/KUCCygqgwrAtdhfOq5TrP8MgqTs=
X-Received: by 2002:a19:c501:0:b0:4ec:7967:9e93 with SMTP id
 w1-20020a19c501000000b004ec79679e93mr2627355lfe.0.1681146448505; Mon, 10 Apr
 2023 10:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKazavxTXwcZFtL2XyU3MpaUR=snWY8w8Lwpco+mkbqm2nWE=w@mail.gmail.com>
 <5b99135f-c1d4-434b-b508-35f5d66dd2bb@app.fastmail.com> <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
In-Reply-To: <b5316855-971d-4b7b-89cd-e81ececc5124@app.fastmail.com>
From:   Rohit Ner <rohitner1@gmail.com>
Date:   Mon, 10 Apr 2023 22:37:15 +0530
Message-ID: <CAKazavzS112w3wsxnA-2ibWH3xGrE_w7Av+VZg-DfgfH0aK72A@mail.gmail.com>
Subject: Re: git log causing hang while browsing upstream linux
To:     Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have not given the command more than 10 seconds, shouldn't the
intended behaviour be to render the visible subgraph first?

On Wed, Apr 5, 2023 at 2:21=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, Apr 4, 2023, at 22:27, Kristoffer Haugsbakk wrote:
> > FWIW: on my machine:
>
> So my point is: have you given the command a half a minute or so to
> output the initial lines? Certain `log` invocations can take a long time
> on repositories with rich histories.
>
> --
> Kristoffer Haugsbakk
