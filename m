Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7186E1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 06:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBHGwP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 01:52:15 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43819 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfBHGwP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 01:52:15 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so1495693vsc.10
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 22:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVsecSTNekG/sMKXPHL8oWk5u4ZTzzdKz5WY840xfOU=;
        b=R0nPLlI3Z4ZhOk+pvy8thQAflQ/UusS4decZIU2M9LCxzDRl89p+0W+TEI/Ijv8d/z
         GPCaggwbANcAJip8NAPAwGoohBBksVEmzcDhcCGWhTl0T1xPexF4FzYkPm6RURy1iXDj
         3SaguOSywjv0IJN2HQ2v0syaOzlbsPs62OILk8CpigmMsGthXl0BGZIv4nZBnYk0PrVr
         6e37SW9cUR2RkfIAdX3OPDgN6xK4rXOkU9dPzBeW941A1zOH4Kp9DenrOBmRogqjQ5SR
         Fh3CMJivJL/aRL78Hng0QpT66kQrN6n6ZbL/w6hJYxlbMu9feqSOiSpAStFqZ3gjJwBa
         yfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVsecSTNekG/sMKXPHL8oWk5u4ZTzzdKz5WY840xfOU=;
        b=aZNdHPgqWAXBJdc8R/Ux68nLUHrBO4mhucJQEeR5m5l15g7jXzSeLLnKZVpG5u9nPd
         qE4cfKt/rIoSOoPv77sJfniqZ/ewEN6mmcrBp2tvdFxNaEySgYwmQLKMtQC4JNP3PyZx
         w18wPLfmPXycNoeUKe0CpuFY3OLGnKW9IT20yzCfnhmG04UX/VWTHxCqX51Pehc1hYmO
         UCrnOnEouYra8wNajZ6tmFWvU9wuwZkOuYVQNWWFaKrVEgvykPwRzTxtcwvrm+9u+d2C
         5gbS40wyc/A4aqYq2iZyXfDzBLnNsRlHJ4VxaNVc0jR9mjVx8u5a7eD1pqZWK3uVT2cY
         4z6g==
X-Gm-Message-State: AHQUAubIWcDH2EUl+PUHlL6NZNXWU3LOaH7RFuYTahxKyWkYTbTGW3lt
        kLpMB8ysTZqPYu4tSQ9KSyWpdTBvvckbiN4R2QQ=
X-Google-Smtp-Source: AHgI3Ib5ndIcxMwPWEqBu7IPX32QfCMUfluW2byyvKvArUlHKA2nr9F/1fazab5fNcGZqySdr//z1tivwSm2vslcsIo=
X-Received: by 2002:a67:fbd2:: with SMTP id o18mr3234093vsr.117.1549608733876;
 Thu, 07 Feb 2019 22:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20190204200754.16413-1-newren@gmail.com> <20190208011247.21021-1-newren@gmail.com>
 <20190208011247.21021-2-newren@gmail.com> <xmqq8syrlyj5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8syrlyj5.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 22:52:03 -0800
Message-ID: <CABPp-BECeDCKpcM6DExxbPrn41k_VVqVik=z8WWU53eoFNM0jA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] log,diff-tree: add --combined-all-paths option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 8:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > +For `-c` and `--cc`, only the destination or final path is shown even
> > +if the file was renamed on any side of history.  With
> > +`--combined-all-paths`, the name of the path in each parent is shown
> > +followed by the name of the path in the merge commit.
> > +
> > +Examples for `-c` and `-cc` without `--combined-all-paths`:
>
> s/-cc/--cc/

Thanks for catching that.  I was going to go fixup and resubmit, and
drop patch 2 while at it, but it looks like you've already squashed
this fix in to commit d76ce4f73 that you've pushed out to pu.  Do you
want to just drop patch two from that series and call it good?
