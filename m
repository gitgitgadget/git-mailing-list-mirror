Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866F6C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiK1Piv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiK1Pit (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 10:38:49 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AB621A8
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:38:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p12so10512211plq.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nkdut+knK/ehy+a6AzXryaZ4cwlMRgnK49ObAp8+o4=;
        b=ik+ecywpa5fdMnRGdqY53cZArqn9YeI2tT5evKUyTEMDjrcL+gyDqpAn4HmjvzTvoN
         QpOtxhXo8XA9+gTNQmNM2UD9ulaQgV6mDqlDXRvatCMlBIwDquZRm6YgMeqUQiVLAxOK
         9lUqVe+m1C0n9vYP1Vk5K/dPdEztsZOegk3QkCMEn15igIgt3uxF4z9EozQZ2NSus3Tc
         k7LiJMJdaS8qyiYo8cDWTp9ScGxxoDBKQIr95VdNhF8Uay3cS6c9e1M/pAqTGb4VSwt1
         Hm6+C0lPOBfkDnMPH2aIZQAW4fvvaWcntSkYMyjpnUnXHIlBxuhpL79IanZZsMRJM2lz
         1ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nkdut+knK/ehy+a6AzXryaZ4cwlMRgnK49ObAp8+o4=;
        b=fNvSKqKT/sQ7bYHk3vVXMyiKxTb1lC4Q1ySJsxoaGa+oIKjRRYhEANCofx5l0ByGxU
         tPrh5xnxtiM1b1U6iDOaMaqLBJZVzN+g1a6K1rpx0KpaSo1+qzzc6p69hlWTCH3B/sHw
         vguMoRR9Pe0ROoNZJyduZs7tmHGr1UM9ovleXMdArZH4xnzXc33P0W5+SVVVUpKcme/M
         iF09cfhjdFJJV2cPpKUZ0dkTSfbpgBgoCMML8NEFMdMRLIUjuS0l+GlcCY7NtfB26WKm
         DG2927Y4aXhxlN0dOIdNP+GPVAoGdacJov4c/1m96xD4TR5dfwGVJjyl91qNwhgJfVxI
         Pk6Q==
X-Gm-Message-State: ANoB5pmhdipILpWwcWqk6P0jLpqhph7wuY33hhbDWx45eJzH/WECNf+z
        hVuSPmZWkPoI37ZXjtpZav2KIvcdesLgzABmgC3CxRuZop8=
X-Google-Smtp-Source: AA0mqf78NxB3XR1IOf7G9gZOE/02hA6ocf3S+UBrLKj+vt4HQbF4k6l/CO/Aprldzq3de1BQOJkcYvGksaGAj1A4w1k=
X-Received: by 2002:a17:90a:bd86:b0:213:8cf1:4d9d with SMTP id
 z6-20020a17090abd8600b002138cf14d9dmr55738803pjr.5.1669649928273; Mon, 28 Nov
 2022 07:38:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com> <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com> <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
 <221126.86h6ymmvyc.gmgdl@evledraar.gmail.com> <Y4RC3NZsiy5gXPoJ@coredump.intra.peff.net>
 <221128.86cz97mjdj.gmgdl@evledraar.gmail.com>
In-Reply-To: <221128.86cz97mjdj.gmgdl@evledraar.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Tue, 29 Nov 2022 00:38:36 +0900
Message-ID: <CAF5D8-ub3_R=tWZ7NKOg7azVqAsK+DXe_XWgh4gYbCWXQfm-wQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 8:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I think getting rid of the tempfile isn't worth it, or worth worrying
> about, what I was pointing out is that the implementation as it stands
> works notably differently than if you invoked M-x grep itself.
>
> I.e. it doesn't do highlighting, and (I didn't note this before) if it
> takes a while we'll "hang", if we had emacs itself invoke the "git grep"
> we'd stream out grep results as they came in.

In PATCH v8, we stopped imitating the grep function and
changed it to call the grep function.

About the first problem,
I still don't understand what you mean by highlighting problem.
On my environment, the "*grep*" buffer is colored
(i.e. filnemame:line_number part on each line is colored).

About the second problem,
If the "hang" is until writing to tempfile is completed, it is unavoidable
as long as tempfile is used.
If the "hang" is no response from Emacs when "cat tempfile" takes a
long time, we can reduce the duration by detecting a change in
(point-max) and exiting the loop.

--
Yoichi NAKAYAMA
