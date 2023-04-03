Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF8C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 21:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjDCVS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjDCVS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 17:18:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B5F3A97
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 14:18:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ml21so6548064pjb.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680556732;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bsIWaWp+sMMgUjPQWPm2uRs3BtjdlBNdS3Vu9Ytcgo=;
        b=mlpHQxJZaXS1F4XcJgVapppQbkLb7PhFEpDnGPewMSDw3zEiRxV0wC0/U1rK1RTd6R
         wRHG144Kmk0Gyh1yMQ2gDUXGNurbzT4uW2qY8/H+TxsmVj9KdQR2j2yC7ZlUNgbiw7Wi
         11q2ahAQZTKsMUJY/OgxMSQT2tqtyO4WwkHVV3+4ID626vZFfKAsQsddqbC0BOk2X+mA
         paRPZy7AqPOv+w+xG90nV9RtdLeJqETXZUrHlBmauc0diGuxXxyOIuXPAS5OhLRjrw7b
         kMWg5k8nhu5fTzADc6Zc+Z/e2ZXRKVBZo2dDFvbdjzBtEMXajZlg1UsKCrVNMEMZRyth
         Satg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680556732;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bsIWaWp+sMMgUjPQWPm2uRs3BtjdlBNdS3Vu9Ytcgo=;
        b=b1XxyiwcXGw7p1CWIVFFRicq1/44QwX//67hvq4HltYAEzzjsbxxHKFlGKlZFFU99r
         YPBIJMofyI2XbB/gdEydHmFyk6HJVzCcOMFK6BxmsnUxvA3k5SWTLGa9EG2OueEjKg0l
         QZgMefXWHcYh6QJqz5dMyVWdIz3uxiVB9bcmPXDDB4eEhehmDgjq/35y8fVm0IGlToMB
         wMtWnNrG/J9+MlrFYSQCurATGdxRwtaldn+zuuLuudNIWWn11e0LJQ6za2986OqimTWR
         eRsJ5mccKM5omNGUJjf4Ro8CGSzs334T+pNTj26GOkS3lduBFEkLQ/AIHbZ745JYJKjD
         a08Q==
X-Gm-Message-State: AAQBX9cOW/FrD3t+c/COnxxDYTHFb/HWr0r0a/TsoDBmQfpufXGn2nLT
        xiIjWZXTq131wKdYsimQCD8=
X-Google-Smtp-Source: AKy350bbAOPaHcNysYtLjNtQYaah9gI8zYHFCfeRPpjSX8tNnha8v/JTvsdksxnzMwBztVV/Ezn1Rg==
X-Received: by 2002:a17:902:f20c:b0:1a2:88c5:d337 with SMTP id m12-20020a170902f20c00b001a288c5d337mr432388plc.22.1680556731818;
        Mon, 03 Apr 2023 14:18:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902740300b001a19f2f81a3sm7026090pll.175.2023.04.03.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:18:51 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/3] doc: interpret-trailers: =?utf-8?Q?don?=
 =?utf-8?Q?=E2=80=99t?= use deprecated
 config
References: <20230331181229.15255-1-code@khaugsbakk.name>
        <cover.1680548650.git.code@khaugsbakk.name>
        <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
Date:   Mon, 03 Apr 2023 14:18:51 -0700
In-Reply-To: <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
        (Kristoffer Haugsbakk's message of "Mon, 3 Apr 2023 21:22:00 +0200")
Message-ID: <xmqqbkk44qbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> [2]: “At the same time, in order to allow `git interpret-trailers` to
>    better simulate the behavior of `git command -s`,
>    'trailer.<token>.cmd' will not automatically execute.”

This may be a question more for Zhening than for you, but is the
above a typo for "git commit -s", not "command"?

> +$ git config trailer.see.cmd "glog-ref"
> +$ cat msg.txt | git interpret-trailers --trailer=see

This is inherited from the original, but it is a poor practice to
run "cat" on a single file and pipe the result to another command.
Just redirect from the file into the downstream command instead,
i.e.

    $ git interpret-trailers <empty-msg.txt

Perhaps we should do that as a preliminary clean-up before these
updates?
