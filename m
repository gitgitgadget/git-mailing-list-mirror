Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5C01F461
	for <e@80x24.org>; Fri,  6 Sep 2019 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391867AbfIFNiv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 09:38:51 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:35883 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfIFNiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 09:38:51 -0400
Received: by mail-lj1-f182.google.com with SMTP id l20so6053732ljj.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=KFXs8XSP9meV7anb6pmqisWelRBoNfY869mc5QrAo6c=;
        b=kmq1j/Gb2RyDx2iUbZSLHen8injtHBFPlsvASSuk52OOpakTu5HeelcLHLWz+BDQha
         IVixtC/nWOeaQ2jCO1dOhIJjSnsfMqDgj4DBtNLNYt9x7jojTxnxVPPDRtLQd+a13LzX
         IM7adfGR57WlVwMAruzDNBueCTg83pOJfcGwh+z6iVKezL6s63h8QtMoq6T7KSoXjCiv
         X4ajNZgWsEac69f+OdqVgxyf+nX90kWo9PCfLN9+qC6OgceKNoQvdR/4F8xvHZ0lGxjj
         57gzcXaGaEAlpbWa8A0LLdtoqaX1z62lEwlZztNW/VIIhNu+StnGt6n4l/L3JanWNee4
         ocdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=KFXs8XSP9meV7anb6pmqisWelRBoNfY869mc5QrAo6c=;
        b=MJloJYLq+pjfUlF4bAesg+MHZor1dwmFA8Po6z8QFTKzxZ+HPZJZD2n/DXNDy1KKc3
         SR8704/1DB6gKiDueAHd7xEZYKx5TrXMp2ooyYJHR5bJzLICX3MGimRfYobk0CcBBv3z
         fJuUWkxQ0zSse6diAtYpbncBFJPImgQ/cdqTIsXlPpsqpgiK10UWV+3JWTh5+JKrsREJ
         /q4KeOmE2ScyObxINkaEdWiPpgfr5ft9tqsjbKwqVuLDrfJ6f/ehxMqs+F5P7FohV+OA
         qGQvG/f7w9+2u1HRmPsl5xGA5qXbGM3t4wyzKYo7wXF7QtVL0UTfqfE0/YI1ae8kOTtE
         b1FQ==
X-Gm-Message-State: APjAAAVkv/7auB3Cqg4XmZJw35szYVLmVBNX2YQgOgXklhq5yZ98qEeK
        5wHRmDXM3J+42FbIys6xFI40pILUb/qEwCSKtolp1BBN
X-Google-Smtp-Source: APXvYqy2fuj8qlhMMNSa9Lcq5Okdp4RHhL1eXTdEx2JvtAAR3GtpwxZhvTfPaFCQLvPfw+/VS9ytfw2aZzSu6j0mYQg=
X-Received: by 2002:a2e:8942:: with SMTP id b2mr5842526ljk.38.1567777128698;
 Fri, 06 Sep 2019 06:38:48 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 6 Sep 2019 08:38:36 -0500
X-Google-Sender-Auth: Q1PGC9EjF-BJ1A7y6oyJhQOOHmk
Message-ID: <CAHd499D+yjZiASCC4Kxw--dCY9hboQCzkgMFiy3PaqaN2qZC3A@mail.gmail.com>
Subject: Feature Suggestion: Conflict resolution for submodules
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've observed that when merging a branch, and there's a submodule
conflict, sometimes Git will prompt a suggested resolution like so:

```
Failed to merge submodule Core (not fast-forward)
Found a possible merge resolution for the submodule:

If this is correct simply add it to the index for example
by using:

  git update-index --cacheinfo 160000
18c7a8e26fa78075d0f840526d0b830103c6072f "Core"

which will accept this suggestion.
```

When I run `git mergetool`, I get this prompt:

```
Submodule merge conflict for 'Core':
  {local}: submodule commit 6075077b3f2f213d312edd8286ed203b5e1232e2
  {remote}: submodule commit 565999a437e64cc83554da83a1d124f54daf9257
Use (l)ocal or (r)emote, or (a)bort?
```

I think it would be great if there was a 4th option added here, that
really just served as a vanity command for the aforementioned `git
update-index` command. For example:

```
Submodule merge conflict for 'Core':
  {local}: submodule commit 6075077b3f2f213d312edd8286ed203b5e1232e2
  {remote}: submodule commit 565999a437e64cc83554da83a1d124f54daf9257
  {suggested}: submodule commit 18c7a8e26fa78075d0f840526d0b830103c6072f
Use (l)ocal or (r)emote, (s)uggested, or (a)bort?
```

Typing `s` would execute this command, basically:

```
git update-index --cacheinfo 160000
18c7a8e26fa78075d0f840526d0b830103c6072f "Core"
```

My reason for recommending this is that there's no real convenient way
to accept the suggested resolution for the submodule. The only real
feasible way to use the suggestiong is to copy & paste the whole line
in the terminal, which is clunky.

I'd love to hear from the community to see what you all think about
this idea. Thanks for reading.
