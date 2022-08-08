Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DEC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 18:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiHHSHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 14:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbiHHSHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 14:07:13 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E55F8F
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 11:07:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h125so11211077oif.8
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BLOr2XFs6O5Yy8/SuxZHJBCeOZqjhMzFD8wJtbaHx0g=;
        b=E7q2I/acgmAUR6T35jj6rV7KGPECIuEPmnKzfEHLC/F6rnHcb/M/zvLD4E7tki4Jl3
         aqo5LBQIu1CU332t9FY7sFz3JoDezHcG34IM4ionCnsHq6T8FKdA2BxDFPwO7x2o9MHf
         s98CYYlDigtCwZlpkaY8j1kLA4kl8Yh5r0Ua4NRRUSRFuzgJVlj8037kgeKZODtHK8WN
         AubWEDv2Ke7qy8mPvo9tWHnwLqbXbnblVDguYA5nKUjCVljaDr8N3QFVLuyWwrSls3Hs
         BADczqH6fQjUo9Hlkt0osKW36sOfw6Wc9O8a0Eq8rScl5zbhqfn71FGpHj1j5QAcJfxU
         68vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BLOr2XFs6O5Yy8/SuxZHJBCeOZqjhMzFD8wJtbaHx0g=;
        b=7n7R+6sYCOnH3jlPTZSUj2J7YrSDpHKJL0yFjzBUd0b8QaTk379QK4MU0QnolGVXcd
         IPM0ktzm2VBOvWMn0oDpVRIO1ZQmiczoK2Vg4uDzHULjyuLpk/OoF+VH8cLej1krI4FI
         4VhYjiKt2H53lTNKF3RwDEJcCkcjXaeAHfXBgoYG8DY0sdrD/AWv9HhwLJ7RjThou+3u
         kv8WBR/TSCW10CLUpONIb4ziD9IW1+EnCTxLXzjqz/TiiE/LWVlz2ebUqiy9kzpTAdFZ
         GsyRGM6R3HpZoV5EYJSEYFOntph3coWN5TnasRfJa6RPUDz9/8bu2hB3ooxPIaxCbKds
         Cwqw==
X-Gm-Message-State: ACgBeo0kibEKKQSl234l9MWIommm2ZfFbh18gISCNQXzBc6QahQx/HN8
        QMXBHo7/KyDdkuh4Xohel2AH1WrqY84CNrs1OWQbSg==
X-Google-Smtp-Source: AA6agR5Q925DymhiMiKxCD0aXRM2ZRuQjaihAOjWb5I9uqO3Sxp7O+RF/+30NM9wsEZC/VNtb/VX6Hk9jskdE/Scj9M=
X-Received: by 2002:a05:6808:1294:b0:33a:de39:89e8 with SMTP id
 a20-20020a056808129400b0033ade3989e8mr8436337oiw.236.1659982032034; Mon, 08
 Aug 2022 11:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-7-calvinwan@google.com> <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
In-Reply-To: <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 8 Aug 2022 11:07:01 -0700
Message-ID: <CAFySSZBPoJC8je2jr4_nrrzdFG3=HuRcou6qjrJTNOzue1pvgQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Since the `info` command in cat-file --batch-command prints object info
> > for a given object, it is natural to add another command in cat-file
> > --batch-command to print object info for a given object from a remote.
>
> Is it ?:)

Haha yes this could use a little rewording

> > Add `remote-object-info` to cat-file --batch-command.
>
> I realize this bit of implementation changed in v4, i.e. it used to be
> in "fetch", and I'm happy to have it moved out of there, we don't need
> to overload it more.
>
> But I remember thinking (and perhaps commenting on-list, I can't
> remember) that the "object-info" server verb was a bit odd at the time
> that it was implemented. I understand the motivation, but surely it was
> stumbling its way towards being something more generic, i.e. being able
> to just expose cmd_cat_file() in some form.
>
> Which is one of the goals I've had in mind with working on fixing memory
> leaks in various places, i.e. once you get common commands to clean up
> after themselves it usually becomes to have a "command server".
>
> So (and I don't mind if this is longer term, just asking), is there a
> reason for why we wouldn't want to do away with object-info and this
> "cat-file talks to a remote", in favor of just having support for
> invoking arbitrary commands from a remote.
>
> Of course that set of allowed RCE commands would be zero by default, but
> if we had some way to define tha "cat-file" was allowed to be called,
> and only if you invoked:
>
>         cat-file --batch="%(objectsize)"
>
> Or whatever, but over the v2 protocol, wouldn't we basically have
> object-info in a more roundabout way?

While I do think that if we did have a set of allowed RCE commands, this
would be a good candidate to be one of those commands. I am worried
about security, maintainability, and server performance risks this change
would also carry. Figuring out which commands are secure and would
not overload the server, and then maintaining that set seems like a much
more worrisome design than having a secure git server.
