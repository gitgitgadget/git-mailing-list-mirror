Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8003C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3012246B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 10:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgLWKHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 05:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgLWKHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 05:07:42 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9DC061793
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 02:07:01 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id j59so3502118uad.5
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kfh4Z8OBR2B/HRxvmY7PT5Jo90/uROxKtl6Bj1dJ4Vs=;
        b=R/cfiLkaIvzTkhNsM2RBDohNY3yDd7lR1if0kgjX17GvSRK0gl1Qtqm75FZm3QqCOW
         fPDnErkaRzS/GjNXhLhoEBLjNL2qrlsEViDqDQPJ5eNK3tTY3gDXCypnpdKoF3EURQqh
         3DODlalD8BbJrJlm+dwbxA3HhyViJeWUwC22CupCdfsuwVn3m2i8f4tXcMOB2+zvEhuu
         BH6samNTM1t7vzH8PKODOgOfRmDLDFdIVKzTFE2otCCQOQ/UNwKTn2CbuV7e1B9E5+r8
         VLLVixe5HuwNjzfz66SfXw9ms6xf0P7zwAqj11NsXA9RiL74P8tw7M6VzJ06wCKn75F5
         deJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kfh4Z8OBR2B/HRxvmY7PT5Jo90/uROxKtl6Bj1dJ4Vs=;
        b=gogdNCgx4oby+nBoouPNOxS9WfAZSnOWeqWstpAoBZUJuoPGljBva//HDFbbPEHMPf
         SNInkyTtGFd3ETqnfFJ9EFGaNrV+83LE1ls7NxF+aGiHSQk/bKJw+KOVZVqsjlqZX1Jw
         +Y4n2ruJG1DFMZxWxtrdPi/g4yBx/yAiTdNaLzp73kyIaFwRFQvympgyKzshdXmjz3Zj
         SCgbw6azAwFVhS/uAiCFC5lSCLxz5SrTMuEkkNYeowsJP93ENnndoLCjWRUE1CvX2vOO
         nvo8q7QYJb8gh1VeYCKqvrHbiOlfBgsW/tu860hJMeOFmg4ckhkduHvdIC0asmXRGfYr
         v1Dw==
X-Gm-Message-State: AOAM532qU61VTOl9mwyZ36PecV38YDAh3/LUIlAePIf0Ke0278+vztb9
        7QAj5j1saiPr4/gXcNoN7xGGLVXiYpIbySXCdVL4dmYW90M=
X-Google-Smtp-Source: ABdhPJzv2sMTzMfYomWjqWrx7H72LTJnZIM5+nLvSU9T9F8iVZa7v1UEmO29DyStzdiBbgQKFZ5/2eXIoktB6GEJ0l8=
X-Received: by 2002:ab0:3b59:: with SMTP id o25mr18608180uaw.62.1608718020842;
 Wed, 23 Dec 2020 02:07:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608585497.git.martin.agren@gmail.com> <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
 <xmqqsg7xfoj9.fsf@gitster.c.googlers.com> <CAPig+cRmatC0Q22XBBx-ouzNSn5uiarTes1tSehGZuBWucSt1g@mail.gmail.com>
In-Reply-To: <CAPig+cRmatC0Q22XBBx-ouzNSn5uiarTes1tSehGZuBWucSt1g@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 23 Dec 2020 11:06:48 +0100
Message-ID: <CAN0heSrWjpdcPN7v9kS-A43TQ5RW_8kW9x_S7c70vUW5cX-fUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gc: fix handling of crontab magic markers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 Dec 2020 at 04:51, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Tue, Dec 22, 2020 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> > > +test_expect_success 'stop preserves surrounding schedule' '
> > > +     echo "Crucial information!" >>cron.txt &&
> > > +     GIT_TEST_CRONTAB=3D"test-tool crontab cron.txt" git maintenance=
 stop &&
> >
> > 31345d55 (maintenance: extract platform-specific scheduling,
> > 2020-11-24) in ds/maintenance-part-4 needs to adjust this
> > exported variable for the tests to pass in 'seen'
> >
> > Is it just the matter of replacing it with
> >         GIT_TEST_MAINT_SCHEDULER=3D"crontab:test-tool crontab ..."
> > or is there more to it?

Oh, I never realized this could be a problem. My merge with seen had a
textual conflict, but nothing difficult, and the tests passed, so I
didn't even stop to think if there was more to it. I clearly didn't
notice the environment variable changed both name and value.

> Yes, renaming GIT_TEST_CRONTAB to GIT_TEST_MAINT_SCHEDULER and
> prepending "crontab:" to the value should be sufficient (per the
> proposal by [1] and realization by [2]).
>
> [1]: https://lore.kernel.org/git/X6+iJNYEbpQjHCb0@flurp.local/
> [2]: https://lore.kernel.org/git/4807342b0019be29bb369ed3403a485f0ce9c15d=
.1605647598.git.gitgitgadget@gmail.com/

Thanks Junio and Eric for helping out.

Martin
