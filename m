Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A349C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 14:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDSO1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjDSO1e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 10:27:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F5BB9C
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 07:26:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so39601a12.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681914414; x=1684506414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBTaRGg0CDmwEX53JWos4QD/NDI04XBHXGC08If4P+M=;
        b=fDs69xpxfnrrifk87U3PO5748GTAzZbBexkVTnmDBjAEzBBIG6+PPiQuj1rpQiPz0g
         HuaRAo0I1B4g7xPFthr5+2oaB7BR70w5Vj2jA2N5lbznDEGgQYguzclXdrjuQydZosZz
         DiI5UOUlqkxaNamh/uscTI3MM7RhZD/7jX+uMQ+O0RLFaseA5xWUngUar2DSxPSX7Mpr
         0hHJLh7NOV8/2mkUlhTLgYy1xYkkpvukt6bxaHC7WuahQDU2als0sNu92p3oG/KSGnCL
         Id9syriPqg+aAwdHsG8n33nvRpbY65XeOlSduw/91mQPVME5Ts+CXPEgYjy552LhKeyV
         JwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914414; x=1684506414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBTaRGg0CDmwEX53JWos4QD/NDI04XBHXGC08If4P+M=;
        b=UHNfxq1TxunV2zPg+NbPSMkVheJLRQj7SU4BB2N/kU4m7dyvepijfj6nOWNO3RC3ac
         EwQ4E7+j33rKqTo0AutSJnRw6Du2GzuWkcRWaKJMffzFsYW4URW2ktdPt9C+uTZEW0Sh
         +PozYOmpAbvA+5hnI4FMyGsKG5Vydw+uvyMF4aPWVG9aEcYZ9rBSpFGkGbhs3CT6dPZD
         eUpVFnkofkBv3eEA+XcjuiAQaarPXe2wb/9vGnQJDz6w42/IcWBXNeJkuGbUb9nLHic6
         c1T02/mQaUpQMiGl0/o+TRaSApldJn5DstKjTEwqX6vbbk1wZbW8/2tYVc51k9dRgCcv
         QcOw==
X-Gm-Message-State: AAQBX9fCX7wx8SXJCnCnijlPLaMqqvkYbxPfdm4etsDJSzxxDPICYk0/
        S4N9JwdKGQTzNawxIxnLkRENReT4hs55dQkVTKI=
X-Google-Smtp-Source: AKy350ZJNsYDHnON26poCH5oKCpZ4/YPvS1QZ7H02vozFBUmTaexibQVAs7cnf1Spw+gzUCO2pqlYYMZjjLTyTn26UI=
X-Received: by 2002:aa7:c582:0:b0:506:bdc:49c6 with SMTP id
 g2-20020aa7c582000000b005060bdc49c6mr5765434edq.23.1681914413814; Wed, 19 Apr
 2023 07:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com> <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
 <xmqqk03jcwxz.fsf@gitster.g> <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
 <xmqq7cuamjmu.fsf@gitster.g> <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
In-Reply-To: <67a2d12c-6250-c4ee-dd26-fd8ecc71b8bc@gmx.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 19 Apr 2023 07:26:42 -0700
Message-ID: <CAPx1GvcsxFbdUBZayzAU0U1MNMUN2NqaBLfZ6C1M=SykWQ_CHg@mail.gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Samuel Ferencik <sferencik@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: I'm going to mix two things here (maybe not the best idea)
and change the order.

On Wed, Apr 19, 2023 at 5:28=E2=80=AFAM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> This is probably the most valuable feedback in this entire thread: What i=
s
> the problem we're trying to solve here?
>
> The original report (which this patch tries to address) asks for a way to
> have a user-wide ("global") Git configuration that can be shared across
> machines and that allows for adapting to the various environments. The
> rationale is motivated well e.g. in
> https://medium.com/doing-things-right/platform-specific-gitconfigs-and-th=
e-wonderful-includeif-7376cd44994d
> where platform-specific credential managers, editors, diff highlighters
> that work only in certain setups, and work vs personal environments are
> mentioned.

Why not allow use of environment variables?  Perhaps a simple:

git config include.env.USER_VAR

and/or:

git config include.ifexists.env.DIR

(feel free to invent better names!) or similar.  The user can then

export DIR=3Dwhatever

in some outside-of-Git setup.

On a separate note:

> ... This feature is meant for Git users, who I
> must assume based on my experience would expect the value to be
> case-insensitive. I.e. they would expect both `linux` and `Linux` to
> match.

I'm not at all sure about this: we already see a lot of confusion
from people who don't understand why, if Git is case-sensitive
about branch names (which it is), Git isn't case-sensitive about
branch names *sometimes* on Windows and macOS.

(In any case, using an env var sidesteps this question.)

Chris
