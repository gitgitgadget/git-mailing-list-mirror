Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F9C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 14:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiC2ODy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiC2ODw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 10:03:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF9255A8E
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:02:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bi12so35425172ejb.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3BnJzt7hf6/VR42qn2kVOKBHf8F/H74WpNB0xzvsCH8=;
        b=Hioaktg1x4DKkdrveV2Bb87n2+H+rK06K2xc5RP0iIMp5GUoT7+x4KbTYM0ODbjhut
         8+q0iAta3SkfQhVmrgeFvPXiH9+pH631E4Bsox33Or7JSOeNIa8+8/2w9sIjlWF+QCgk
         rb0DyOEFBIid18aYKRuxfL+Tzq7ABegZqrjI5S2EesML4w9Ex6y1iGzJOMYbec5348QJ
         /opX0mf3wtYfj7hemF7D9e4JEnrWOW8B1tgBJWeieWhOCereMn8O92eesrfoiAq2Ch1K
         o2Mu+0n35E+FZTh6lNiDmVCt9yXRDtAjAetpR6lbrfcOqfbz4RJlBCoyHBUK5gWynUpA
         /alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3BnJzt7hf6/VR42qn2kVOKBHf8F/H74WpNB0xzvsCH8=;
        b=Vc/nfl1oa+SRnr9AvYkn1j/TyM9Urtp8dpZFT5t7UKP9ybEXCj8esPv+scc+0lAL/Z
         4TNcGsdHMm3+ArQqhaFxD931MqyzbG07wYO2d3XNJMkLQUbtnAelUUuxjqrTgBmm3nck
         QJrtTJa3sSpYuV9dV1o2/nhPrjEMUxNBYykbLT9+2llkLyVst1rwfwvrAk6z4zGUzWHx
         H9l4Lq9dQz3BnWxQhdiDngUCJd0S5EsmnbkwJkcAMcEJYJdxe/8H0mfw5p6hFcIgHf6+
         dI8eRN173+L+3minFHEoNWeFDXq7+o21+hlNoRh/IuTPVZg813BfRl+Mn1zfobbxxgq9
         sL+w==
X-Gm-Message-State: AOAM532XsM2y/+Sf7EbneZJupfRXe9kkTL/1ATiA44TtRxvH/9L2TRvE
        T2eWfumHMYBNCz5GmrdCn0/6k3fXiyjtjw==
X-Google-Smtp-Source: ABdhPJz+hfR6mgt32hD3HjTpYvoihf07fOSh/osmdD5dm9XgQKsT8qA9/PvmK7x88S1dd3pzaznrRw==
X-Received: by 2002:a17:907:9506:b0:6da:b4cd:515b with SMTP id ew6-20020a170907950600b006dab4cd515bmr34910050ejc.602.1648562524784;
        Tue, 29 Mar 2022 07:02:04 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm7109077ejc.134.2022.03.29.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:02:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZCQ7-003fp2-Lv;
        Tue, 29 Mar 2022 16:02:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: fr/vimdiff-layout (was: What's cooking in git.git (Mar 2022, #06;
 Mon, 28))
Date:   Tue, 29 Mar 2022 15:59:44 +0200
References: <xmqqo81pxzt4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.11
In-reply-to: <xmqqo81pxzt4.fsf@gitster.g>
Message-ID: <220329.864k3g3lic.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Junio C Hamano wrote:

> * fr/vimdiff-layout (2022-03-23) 3 commits
>  - vimdiff: integrate layout tests in the unit tests framework ('t' folder)
>  - vimdiff: add tool documentation
>  - vimdiff: new implementation with layout support
>
>  Reimplement "vimdiff[123]" mergetool drivers with a more generic
>  layout mechanism.
>
>  Will merge to 'next'?
>  source: <20220319091141.4911-1-greenfoo@u92.eu>

I have no opinion on the topic itself (haven't looked in detail, and I
don't use vim), but FWIW I've gotthis patch to fix the 2x new warnings
on "make check-doc" it triggered:
https://lore.kernel.org/git/patch-1.1-4a5d219dfe7-20220327T131751Z-avarab@gmail.com/

It has a trivial conflict (to that same check!) with my 3e05ff3e147 (CI:
have "static-analysis" run "check-builtins", not "documentation",
2022-03-25) in seen, but perhaps worth picking up...
