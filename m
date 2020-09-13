Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCB9C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B98321D7E
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJwDLncl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgIMPMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMPMN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 11:12:13 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F17C06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:12:13 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j3so8175372vsm.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPhF7GAnnuMWHEsJwQHw07ECbT2xMNZf8YT1MYV1HxU=;
        b=rJwDLnclcpJPXW7I7m2wstCUqDZ3WjYk8idwwiNVLqT0qjiVEE12HWUJws/bemkdT2
         PYSQk2Eppt7qKSanakgXUrLMh2CKJUufizr4d0OSBYFXnSRh/BSF9fR3SVAsthE30Z3k
         1rK5mxdM1/1rQ555UbHJ1YcTrwnPjgb0A4z1+cvk4xfWnDQR0nMVDgm6f5THDO2Q7bVu
         0wXo+n+SXnIIVLu1DdzD7UgKxCTXi6CyjNl+snK20siTikQI8DVBNzw9jC64tTVgBrsI
         2V8hW8KExrBWkjKTlcmKGfRZ/WTl5gtUJJb4ao2g6TdRU0b0h7LNBWj2/OL9YreHOKfj
         J6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPhF7GAnnuMWHEsJwQHw07ECbT2xMNZf8YT1MYV1HxU=;
        b=D6qsPl1QEGIUQ+PwnOwXE8xEF+975gncqkugGgfUhEvIa4cFNoD8RRGylFZSyNU9Oh
         pijk+Nzkv2Z5RqSgyv1dZOn1bDZLH7goYTw/QmYbTZDn01/xf+hnrmEnVsXMLt36+j6o
         +LsoIYtMsPfmHUujsmHsV8LEA9n5AMVaLoIZAiPfBS2UyQQk8/5134xeGlIecPSHh2/V
         TrFblffdZNxCZ9A/VK8Jc6EWwsdeYD1h2sG5nKAJ90YaMY1/buceXdcFnZNYL8Nby+JH
         LA6grs1GWMiVHl9Jrb2hFehcZYl1DhDDsoMH2O9xPYZsJEQTCPboe4usefyv9GfstCuE
         nW5w==
X-Gm-Message-State: AOAM532MKH8vQakbQR7OQBJl1Op1B54ggpcpoK7ZDo9BO4jDlH2HCMrA
        YaeQUs53PXin5ZbB0AD7Acm0hmFwKlSoN+KUtfvA+Sd5eQA=
X-Google-Smtp-Source: ABdhPJwf9IA6qgHKhWf3DJnrLgmWkothK05QaPfE6ydiURwsNJ9seS+fHJw9SG99wp1FeFzmia7wLadHXUz9WJlU2gc=
X-Received: by 2002:a67:7d52:: with SMTP id y79mr5367931vsc.34.1600009932377;
 Sun, 13 Sep 2020 08:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net> <20200912204824.2824106-3-sandals@crustytoothpaste.net>
In-Reply-To: <20200912204824.2824106-3-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 13 Sep 2020 17:12:00 +0200
Message-ID: <CAN0heSrQR+6SsPHFtqcjYeFe1ce5USTxkxLXZ4g2MCqbV20K6g@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: explain why reverts are not always applied on merge
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 12 Sep 2020 at 22:51, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> A common scenario is for a user to apply a change to one branch and
> cherry-pick it into another, then later revert it in the first branch.
> This results in the change being present when the two branches are
> merge, which is confusing to many users.

s/merge/&d/

> +If this is a problem for you, you can do a rebase instead, rebasing the branch
> +with the revert onto the other branch.  A rebase in this scenario will revert
> +the change, because a rebase applies each individual commit, including the
> +revert.

Should this include the usual disclaimer about only rebasing a branch if
it hasn't been published or if you (and your team) is willing and able
to handle the fallout? I dunno. This piece of text is vague enough that
the reader will have to pick up the "rebase ... onto" keywords and
figure out the details some other way (and to be clear: I think that's a
good thing). I think that should be sufficient and they'll find the
disclaimer when they look up "rebase", if they don't already know it.


Martin
