Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A0C47088
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiK3Snc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiK3SnV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:43:21 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17573720C
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:43:20 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e189so12938265iof.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=/95G2XBbobp3+t2JrqtSxpUn9lUX/UbKdYD0XyHz9tU=;
        b=Tv07B9lHwnh5GmZJqjcnabySmEaQonCRtOoCx/T0Uij15HllQHPKl929EdwAQDe3Bi
         4nEoW+GmNnOV/P8DVRITRVtLV89N1gmSZ+huDyzopjlAXlw3YCuTkC4SOMGTBlQsKX2y
         MtFVduCgBjlrQkC50ai5/zJ63i/k3czbE1Tbqao8ioi+aS7p6Loajya89Gdy2AMy4Qla
         x8cOPLRGwILqwp99CIdidrHt/sAltWDaxjElU0hqoC7AHZ0C2WoEzujkottDISts2Ds/
         sUPYIDck32Njmd0DIyNkNEfLg8oJl695PTGGhwdV/e7nwxUXZcGiTfAQCJNcUyed7bEy
         wPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/95G2XBbobp3+t2JrqtSxpUn9lUX/UbKdYD0XyHz9tU=;
        b=TGg6Q0kGQS0yu+fYV6KaTMqhhyPTbG6A87ciK/6plRkCJ8Xpa+d9e3nyh8+5qZKF17
         63TTTtHo5FGYNEN50W/8MNW/XqTX2WMVoUDak6Qa7VNaBFsjhBnYuJTz6OA8+1tt8As1
         /gSXx1wi9fwWld5uvHXVhGvYLflMwzvXI7wYjy2hup2q1fOjnVRdg3cdTPhhA94umXVZ
         hwySAwjZPTE1geOytGW1ZFt3BFV053GtkMkua0AgxzliKccJ+QXjQR2VC8JJCCFQq8zN
         44o1yoM/DFpyfTXoLtE39b9D2PVt7tMR7nbdKy4Dq6+rjYRG769hCX5I4NeFBEB/1nUp
         2hpA==
X-Gm-Message-State: ANoB5pkW9VBgOBVwiLHNq8Luan1aB/G0MPRNgRUGQ0lzqcULvaXFAOFe
        mLXV6oBSFodIBJfalV5O5rk=
X-Google-Smtp-Source: AA0mqf6OBJOlilFx05NTnvSudaGV05zmYmaurLxNDufLMIAq0eBoQbKY9Zu3AKjQHjIHPEACemKBVw==
X-Received: by 2002:a05:6602:200c:b0:6de:90a6:6b04 with SMTP id y12-20020a056602200c00b006de90a66b04mr27940407iod.101.1669833799676;
        Wed, 30 Nov 2022 10:43:19 -0800 (PST)
Received: from stargate ([2620:72:0:a40:27db:8b2:b1b5:493b])
        by smtp.gmail.com with ESMTPSA id x59-20020a0294c1000000b0037612be6830sm805267jah.140.2022.11.30.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:43:18 -0800 (PST)
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
 <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2
 file format
Date:   Wed, 30 Nov 2022 12:37:21 -0600
In-reply-to: <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
Message-ID: <87cz94xozi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Han-Wen Nienhuys <hanwen@google.com> writes:
> To be honest, I don't understand why symrefs are such a generic
> concept; I've only ever seen them used for HEAD.

I've been only lurking in this thread (and loosely following along,
even!) but I do want to call out that I have recently considered perhaps
abusing symrefs to point to normal feature branches. In our workflow, we
have documentation records identified by a numeric ID -- the code
changes corresponding to that documentation (testing instructions, etc.)
use formulaic branch names like `feature/123456`.

It is sometimes beneficial for two or more of these documentation
records to perform their work on the same code branch. There are myriad
reasons for this, some better than others, but I want to avoid getting
mired in whether or not this is a good idea. It does happen and is
sometimes even the best way to do it.

In these scenarios, I've considered having `feature/2` be a symref to
`feature/1` so that both features can always 'know' what to call their
branch for operations like checkout. I've done this on a smaller scale
in the past to great effect.

Nothing is set in stone here for us, but I did want to call this out as
a potential real-world use case.

--
Sean Allred
