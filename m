Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA3EB64DD
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjF2TnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjF2TnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:43:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE072707
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:42:58 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b2c66d713so896303a12.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688067778; x=1690659778;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lhwKnkby9//OVk2oMIPgN9BKN8yKLCH7NTYhjo74TA=;
        b=le7CKkFTjENUSFWPP0Z2pzVanwUhFamI1wnQ4m38PmKjOYzY71bnz4tdR5J2IJBbWB
         VAO+8W4F5ebNpdLYjdJE94weyHvzj5xPvP5YrONyuKk+gsoZ1yyolP7xOrJSXJvyQbFM
         mx4/R579+5UaZAJgQQgJtMCJLZrgtD2P3hzlOaHwJ+wlTndGcK+THLBXXAUmvxU42pc3
         WpJ/IE3nMGr2r1YgJ2cf+GcVcuFb3Y+k160G2q2EoER44ICYgMK4TVU+tAE4jV7czt6H
         PC9Eb10TR//B8B4W4KWrgQykAW00v/TgiRZGQcV7zMWUhi2XjjzU4KgK3FHv/E6LuKut
         +X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688067778; x=1690659778;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lhwKnkby9//OVk2oMIPgN9BKN8yKLCH7NTYhjo74TA=;
        b=f90flDmlL16rJu9MmslSV2dZSD9aOm6Qv+jiJ1X3TSUjBbnJ+6a9XtQ7Qx6uvxfnQI
         +ejkbxbXwRNJ5rDHbNJGOQnk/96jlkeNRLGcwP5f3WBfzufUr3x7uy4ErsgLC4NppGdL
         Qe1rafD9fPAErZbF6XCD51f+r6Hstamrneo6T61CcCqfM+94W8quXn5PseKYzm9R7xRE
         8fCmmtmHp2rHj3zIFykLTnL3sotArCdF0r8xaPFCTJBAHLOpoVV4ZTMFC0d0zFE084Ap
         jQwYJta5lL6aanW658O5LqROlmJHR5pecQmjQ2yn7XGYOqUUR7pJSsF/6LxYThGOvpsL
         DL/Q==
X-Gm-Message-State: ABy/qLZGchCA6ABYmTgA0NvZiOz29WUaDXvmXbjiAwSL9S0WU+8wtRvp
        5khtTtouJXzaAaufW+hFr/lkvuxLv38=
X-Google-Smtp-Source: APBJJlH3YffasI38cI0IjiKcVwIvde9nZQ7IaYCe/NSAne4yrFy6pxVc9Znwu/MlgfRzXL7nWWnLuyugDyM=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:ce56:0:b0:557:9cc7:bc79 with SMTP id
 r22-20020a63ce56000000b005579cc7bc79mr26014pgi.7.1688067778272; Thu, 29 Jun
 2023 12:42:58 -0700 (PDT)
Date:   Thu, 29 Jun 2023 12:42:56 -0700
In-Reply-To: <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com> <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Message-ID: <owlybkgy837j.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Linus Arver <linusa@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Josh Steadmon <steadmon@google.com> writes:

> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions).Describe what we hope to accomplish by

I see a minor typo (no space before the word "Describe").

> +=3D=3D=3D Comparison
> +
> +[format=3D"csv",options=3D"header",width=3D"75%"]
> +|=3D=3D=3D=3D=3D
> +Framework,"TAP support","Diagnostic output","Parallel execution","Vendor=
able / ubiquitous","Maintainable / extensible","Major platform support","La=
zy test planning","Runtime- skippable tests","Scheduling / re-running",Mock=
s,"Signal & exception handling","Coverage reports"
> +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.c=
om/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[li=
me-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-=
background]#True#,?,?,[red-background]#False#,?,?
> +https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#Tr=
ue#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-backgrou=
nd]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
> +https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-b=
ackground]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[li=
me-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#Fals=
e#,?,?
> +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[re=
d-background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#=
,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-backgro=
und]#False#,?,?
> +https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#=
Partial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow=
-background]#Partial#,?,?,[red-background]#False#,?,?
> +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?=
,?,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]=
#False#,?,?
> +https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,=
?,?,?,?,?,?,?,?
> +https://nemequ.github.io/munit/[=C2=B5nit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-bac=
kground]#True#,?,?
> +https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-b=
ackground]#True#,?,?
> +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
> +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#Tr=
ue#,?,?,?,?,?,?,?,?,?,?,?
> +|=3D=3D=3D=3D=3D

This table is a little hard to read. Do you have your patch on GitHub or
somewhere else where this table is rendered with HTML?

It would help to explain each of the answers that are filled in
with the word "Partial", to better understand why it is the case. I
suspect this might get a little verbose, in which case I suggest just
giving each framework its own heading.

The column names here are slightly different from the headings used
under "Desired features"; I suggest making them the same.

Also, how about grouping some of these together? For example "Diagnostic
output" and "Coverage reports" feel like they could be grouped under
"Output formats". Here's one way to group these:

    1. Output formats

    TAP support
    Diagnostic output
    Coverage reports

    2. Cost of adoption

    Vendorable / ubiquitous
    Maintainable / extensible
    Major platform support

    3. Performance flexibility

    Parallel execution
    Lazy test planning
    Runtime-skippable tests
    Scheduling / re-running

    4. Developer experience

    Mocks
    Signal & exception handling

I can think of some other metrics to add to the comparison, namely:

    1. Age (how old is the framework)
    2. Size in KLOC (thousands of lines of code)
    3. Adoption rate (which notable C projects already use this framework?)
    4. Project health (how active are its developers?)

I think for 3 and 4, we could probably mine some data out of GitHub
itself.

Lastly it would be helpful if we can mark some of these categories as
must-haves. For example would lack of "Major platform support" alone
disqualify a test framework? This would help fill in the empty bits in
the comparison table because we could skip looking too deeply into a
framework if it fails to meet a must-have requirement.

Thanks,
Linus
