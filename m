Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6E2C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 06:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiFIGBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiFIGBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 02:01:44 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FD369D1
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 23:01:42 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:48694)
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nzBEj-0002GA-5F; Thu, 09 Jun 2022 02:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:
        References; bh=7oiBGYXbOP6BjXRMiMAw3x6q697uZ6p3y5Htvu5AhhM=; b=PEZfWdSu+AiouM
        L5jhoTgSk45KG6z8NZ9vlAha3xJD9bt8ikA9Q0F+h1I22HqdEkvrdsHJ4cx6b8xIRfdBq3xAuhDpf
        +ykWntdt+jbFUbM8S6GfUhK5mqHKbMc5FqasRt+mjoNqZBG0J7MtbdXS8avR0iRUktKjgYWjougdW
        3tFCnySOvVQDvAPa0dWrbFuq4sfUHqffEd2SZFxxIq5ko4TH7atWI/td6NUiuSNkOwkcerROwWLSG
        Q8s2yX5BZke7SW9eFbXXP+OvA32CMvD5bt8mnOO/wBwQ787IMlrqiAs25uje76H+f+Z+sDnJrv2tx
        KtjrmQIYd1mP+TJvHpxA==;
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:49947)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nzBEg-000747-FG; Thu, 09 Jun 2022 02:01:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D5B827C0054;
        Thu,  9 Jun 2022 02:01:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Jun 2022 02:01:37 -0400
X-ME-Sender: <xms:wYyhYicIPadU8izq5yO58Jh7qMbKKOU5XczMysOeOqsXFNYNRP6PMg>
    <xme:wYyhYsOeOahK9bzLvv8H4HkrZbn6aXh_d249985Wgc2UPQpIix5eRTYayyNBoSRPK
    DgE4lBInS1SeQ>
X-ME-Received: <xmr:wYyhYjgjUNJ7Fy9ltbbB08VplErOqd0teBuuu0Zk0s8-bbMFcExx9nyLyb435JhguZXn8u74gFrjTkWYGMahmz0rZGr0hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtredttdertdenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhu
    rdhorhhgqeenucggtffrrghtthgvrhhnpedujedtheduvdelffejkeetgedvheelhedvue
    efhfeukeekkeehvdfggeegffevgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehthhhorhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdekieejfeekjeekgedqieefhedvleekqdhtshguhheppehgnhhurdhorhhgsehf
    rghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:wYyhYv-6Rth_i8_PR8oxH95QXBNx2z9X5e30Pb3-VNAQgRqjoBDz3Q>
    <xmx:wYyhYut8dmPSF4IFdwFfoHllXfyJroAnSDT7hII5K6Z7n3b4LeSyVg>
    <xmx:wYyhYmHuOEHgP7IsNdvV_oSwkFcM5uzUZJdtD5bYxZEN1FWnNGryIg>
    <xmx:wYyhYjWHdFJWX7sbfI9GHnVAyJyfs0_i8ZRvXtaQAXuZIyGbL1-e3g>
Feedback-ID: ib2b94485:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 02:01:36 -0400 (EDT)
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org> <YqEyh5opAaJxph2+@coredump.intra.peff.net>
User-agent: mu4e 1.7.26; emacs 29.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     Jeff King <peff@peff.net>
Cc:     Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
Date:   Thu, 09 Jun 2022 07:51:36 +0200
In-reply-to: <YqEyh5opAaJxph2+@coredump.intra.peff.net>
Message-ID: <87mtembcjl.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

Hi Jeff,

>> Still maybe someone might want to have a look at the "git show" issue
>> to double-check if the performance burden in this specific case (no
>> diff should be generated) is warranted.  But at least I can work
>> again with no coffee-break long pauses, so I'm all satisfied. :-)
>
> I suspect the issue may be quite subtle. Even you asked for
> "--no-patch", the underlying diff may still be used for other things.
> For example, simplifying away TREESAME commits. I.e., ones which did
> not change anything from their parents after applying path
> restrictions, diff-filters, etc. There may be other cases, too (e.g.,
> --follow).

I see.  In the end, my issue was solved by my git porcelain switching to
a "git log" incarnation instead of "git show".  When I "git show"
manually, it's no big deal if it takes some time for merge commits.

> [...]
>
> So probably setting diff.renamelimit correctly is not that bad a
> solution.

Does your statement imply diff.renameLimit = 10000 is an incorrect
setting?  The thing is that I mostly work with java codebases where
every file rename implies a change in file contents, too.  A large
renameLimit seems to help in correctly detecting renames/copies although
I don't have empirical data but only gut feeling.

Bye,
Tassilo
