Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBBA1F462
	for <e@80x24.org>; Wed, 22 May 2019 23:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfEVXmY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 19:42:24 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46435 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfEVXmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 19:42:23 -0400
Received: by mail-ed1-f47.google.com with SMTP id f37so6245737edb.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RMp1XQAGEzaRMPw4ChM2AyOIxqgQbM7RvOKKLT+7u8M=;
        b=N7mVzxyuDxYz6XEUX4XX5ZfNA0hKJhCQJDWFDxcdUT2GYrFeeOheC6EmWhzdmEihui
         f7FNyufj4N2Jeh2jgs8U8HIPIirH93wBccnWEtdlgIlx4f5Sc6IxuCeMqOC23v5Ujjmk
         T/DouyTEh1xnMvhlNdpxyopMPfX7krZR4rWIaENJxHSPI9aduEJVHqT2pattTevI6xpR
         YuIdMPz3TbaUQnoYFTr1EJhAAyvpX1PymLYL3X0cEzY8HPzIphvqPTV+FCWlwBQFpxkt
         9crWsnQhBeQP8FpkCdDG6fvgXWESjfJwbU6THeuwUKlASsZEQgYl317J/13rGc4SYd1y
         7HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RMp1XQAGEzaRMPw4ChM2AyOIxqgQbM7RvOKKLT+7u8M=;
        b=mTSPXdkH7ZhdyXpRhECmSA7axrsPUspKw387HzZ0jmdh0C0iKKMSgwDqAIzx1g1VQb
         lNp0KzZIsqxMFNAdlhNmqCDjJfT3Q/xY4ioAxiPqrHeCNIoeLqdpEaul/rtKcTciGyHn
         RTd0Udmw6S3CKiSBpw+OLOPku/aT0sj92GpM0AQKbk14Iq2S450GzLtvfBBUnCeXm0xw
         zEQwyWMX5g7qbYX3Afk9HcjjfLZWLMxGa/M3joqMQNGufG4M1mHL/aUoDrOBMM+LsP/1
         QD5BrVzTjyXKkDLa6U27dmJ11BPuxq0oYZt0rzOu8mA2B0+hO05LuklLTJViwTeetkH8
         p+OQ==
X-Gm-Message-State: APjAAAW3YWz5nzIoZ6iRv4G5QxyQ9KyyH1q0ftSyMyD/9BMwWL9TW1Sb
        fTrZ3aZ6RkJCasijFcS21j1abahb5howti1zhobBwSnW
X-Google-Smtp-Source: APXvYqzulrJivtSkLd7AGYPiQVO28wmUFs5nNl6zdFyimjPZygdh2x0bpocW7dtCkG/1TA5CEVEDpJEnrSUsOxAOA0w=
X-Received: by 2002:a50:a5ed:: with SMTP id b42mr91462755edc.178.1558568541639;
 Wed, 22 May 2019 16:42:21 -0700 (PDT)
MIME-Version: 1.0
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 22 May 2019 16:42:10 -0700
Message-ID: <CA+P7+xrXz7-TgV4ufVkXqjgi8X1UD=pQJC3s2JA5fH-sEEnENA@mail.gmail.com>
Subject: git describe/contains for submodule commits
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've had a few times where I was curious of when a submodule got set
to a specific commit.

I noticed that git describe has "blob" support, which outputs something like

<commit>:/path/to/file

using the revision walking machinery.

I'm curious if anyone knows if that sort of revision walk could be
expected to find the first treeish that had a submodule commit instead
of a blob.

I'm not that familiar with the revision walking, so I was hoping to
get some pointers of whre to look before I began implementing.

Ultimately, I'd like to have some sort of command like:

  git submodule contains <submodule> <commit id>

and have it try to figure out the most recent commit htat has a
submodule change for which the submodule is a child of the specified
submodule commit.

I can sort of reverse engineer this through git log, but it's slow and
tedious, so I was hoping to be able to implement it into a revision
walk that did this.

Once I know the commit that introduces the submodule change, I could
feed that to git describe --contains to find the tag/version which
included the change easily enough.

Thanks,
Jake
