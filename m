Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C9C433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E7206CA
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392728AbhAZOVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405602AbhAZOTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 09:19:40 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085C4C0611C2
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 06:19:00 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so33804924iog.6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1VYH4skTy1FfTCHEFNAF5PoN8kx2j3G9/fk6d3nDwsA=;
        b=JUzPMhcN4oWbgGgYH1zsTVs2WJpwnVpNkaQELQff/1KNj1NrJXx8Rm5q+uHKBdoUIP
         jVF/MNseoNBhHiegzmQNPUABG8aXLo0zWY7UjsxnbyUs9tgOa4/Bg9Bwc85gKrshrpuc
         iNVu4OxBkw31QjM+9+3aUFq4JX+yYKj5il3BTrYl53d7bhQ9J3pccOSixuPaNNJEmLpx
         x0gpeBK0PpGKWuRNyM3Utrp87y1KR8kCEMMZnTb8YW02V7NXX/JhTO/5UIZcYqbqLlSN
         kGIYhfu8IuZ6XdVLMjTotPDHdM+8CFDYURGALEUImabyZfnsYbCwjV2lSBtdOuxvkCTQ
         /WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1VYH4skTy1FfTCHEFNAF5PoN8kx2j3G9/fk6d3nDwsA=;
        b=lO/YGGqcnwi8yhzuo5BOqBEi6dmUlu9iuViHE066ju6RSk8RMhN0AN/OTfaGLRdZYs
         Y/JcIfYzPeWAo7+a3wU6755NPxmW8+BrHLvFleoUlYNc9P8naeMUec9z2iu4FDH+Jtk2
         GiA3fZ554V7hlrbFmsIfZWCRhHCiCtaBHwHMBHCtHeF9J5JiWHlM+qc7mJtqioRRMgih
         JVvfNPCfYHuC7q//o7vhn2gIWTGeE6U3jiGUs6daLWGV4FdEnjY7sj0+sX60K5pr7cnF
         ZIeO5877+o1QFbC30WsqiPE8/YOKxSLQnXn/Hg34SN8vIz2SybXhHKjz6qjpd6ibpwVi
         tfXg==
X-Gm-Message-State: AOAM533WdZOqQTOHryFb6E7y9KLqpAt0rvBZXEsjAPYCatT1LX6kSSj+
        AoWRJx7ilr5FT6nn7EbV+jEoBRQeHRFbOQXmzv4=
X-Google-Smtp-Source: ABdhPJzVNch2wLTCHlKhqX0vYLG797WP56ijANpzqTGaeW229AQThAvr/9kFIDeuRF1cx/oAqkeTDv+F8X6wl2tVsAM=
X-Received: by 2002:a05:6e02:1d02:: with SMTP id i2mr4877465ila.30.1611670739331;
 Tue, 26 Jan 2021 06:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20210123154056.48234-1-mirucam@gmail.com> <xmqq8s8gwjaq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s8gwjaq.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 26 Jan 2021 15:18:48 +0100
Message-ID: <CAN7CjDAsRcLSZPjtJxcjyunSErer8DWKqnMcNNo2rxad7xA+Cw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Finish converting git bisect to C part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El mar, 26 ene 2021 a las 2:58, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > These patches correspond to a third part of patch series
> > of Outreachy project "Finish converting `git bisect` from shell to C"
> > started by Pranit Bauva and Tanushree Tumane
> > (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> > continued by me.
> >
> > This third part is formed by reimplementations of some `git bisect`
> > subcommands and removal of some temporary subcommands.
> >
> > These patch series emails were generated from:
> > https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v2.
>
> Unfortunately, with this series in the 'seen' branch, the CI jobs
> seem to fail.

With the last patch series sent:

https://public-inbox.org/git/20210125191710.45161-1-mirucam@gmail.com/
(branch: https://gitlab.com/mirucam/git/commits/git-bisect-work-part3_v3)

all tests pass (executed with: prove -j5 --shuffle t[0-9]*.sh):
--------
All tests successful.
Files=3D916, Tests=3D22661, 1628 wallclock secs ( 7.93 usr  3.16 sys +
1106.15 cusr 1387.58 csys =3D 2504.82 CPU)
Result: PASS
----------
>
> cf.
> https://github.com/git/git/runs/1766239699?check_suite_focus=3Dtrue#step:=
5:814

I have seen that is "t3415-rebase-autosquash.sh" the test that fails in CI =
jobs.

I have also executed it independently with no errors:
./t3415-rebase-autosquash.sh
ok 1 - setup
ok 2 - auto fixup (option)
ok 3 - auto fixup (config)
ok 4 - auto squash (option)
ok 5 - auto squash (config)
ok 6 - misspelled auto squash
ok 7 - auto squash that matches 2 commits
ok 8 - auto squash that matches a commit after the squash
ok 9 - auto squash that matches a sha1
ok 10 - auto squash that matches longer sha1
ok 11 - use commit --fixup
ok 12 - use commit --squash
ok 13 - fixup! fixup!
ok 14 - fixup! squash!
ok 15 - squash! squash!
ok 16 - squash! fixup!
ok 17 - autosquash with custom inst format
ok 18 - autosquash with empty custom instructionFormat
ok 19 - autosquash with multiple empty patches
ok 20 - extra spaces after fixup!
ok 21 - wrapped original subject
ok 22 - abort last squash
ok 23 - fixup a fixup
# passed all 23 test(s)
1..23

If I am missing something or I should do any other test please tell me,
thank you,
Miriam.
