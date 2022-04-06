Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B71AC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiDFMwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDFMwD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:52:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64B1460A3D
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:59:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot30so2776110ejb.12
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=qJNYOByCrFdj9JT8Cq64iv411BnbdLu6WQ0sH95scFQ=;
        b=W+tPApOEwJHvkOysX1XO0vSrPHuT/t1wUmW82/d3wx8DWG8Nl6xcoUc4JE36b3vj0w
         TB8Fh/unPai9kWsQlF+s4tAbWNGXdohGurgry7IDsq6OUNmFMYHNfROuoLLZLj42RMG9
         L211kHsjwegbzN4m3qSIFjPhJduZbKZmq3ULXAivBgL7124a11PUVkvj4PdR2W7MJ0BU
         VCxtAqMOblWaJJVsY9NMhiV/Phr2MCteIiRRnzqMI2QR3K0wqU+5NRnLSofbb/fi4whj
         tFT4WlUVeQXx2tFuS0GwdxREPCKdWL0p0uYbbzcQMuC4LCTNSuoawuvuVS7Bc/ydtYeB
         CUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=qJNYOByCrFdj9JT8Cq64iv411BnbdLu6WQ0sH95scFQ=;
        b=3nbGB/uvyh+rms6KQL4frPqc1PUt3BcLJNVJEG9r05RPckUvNKGY4dRzF1u9xgvB0r
         sQyMUeV/DE4PHwPlByGdP4sf2kEHNRBlL1dJst7dOmOg6i6l6JM6XqTKWeycebybbghx
         JxYwemUBpZTFQ1GVGxf8IT4la3rwg1evWnE7K7ydimA1GCGkxnXgI2L7UWE71ot5qCkg
         jCcuDF3tX97o+TvGIG1rs0pyTu9dK6f39t0U93V/MfZNtmxn5beOngMBHdtz3ZG4K0Z9
         pj4b8THacktgUqjAkRZGiME5YWxP8UusfYFx/kP+CsOVUM8IpDLLrMKcF9sS1SPLdZwD
         jodw==
X-Gm-Message-State: AOAM532/SpWNbSHNPzf247eH8iv/ZmbFFYT2vm32GQYHCKkfx9IY3iHS
        b3wrSFH1xlBYe8ECcMV3h4D/s/z86TdhQw==
X-Google-Smtp-Source: ABdhPJxuXeEPc5/Z3rkL0Gdxir/s+zCgH7ew8r3n6Iog6Ih1L8ziRj9OKbRwjecWcBe2LLkoBfTOOw==
X-Received: by 2002:a17:906:2bcb:b0:6e7:f655:3b96 with SMTP id n11-20020a1709062bcb00b006e7f6553b96mr7105069ejg.175.1649235550477;
        Wed, 06 Apr 2022 01:59:10 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd31-20020a170907629f00b006dff863d41asm6399076ejc.156.2022.04.06.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:59:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc1VN-000adp-GD;
        Wed, 06 Apr 2022 10:59:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Garrit Franke <garrit@slashdev.space>
Subject: gf/shorthand-version-and-help (was: What's cooking in git.git (Apr
 2022, #01; Mon, 4))
Date:   Wed, 06 Apr 2022 10:56:02 +0200
References: <xmqqilropo3z.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilropo3z.fsf@gitster.g>
Message-ID: <220406.86o81eegf6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 04 2022, Junio C Hamano wrote:

> * gf/shorthand-version-and-help (2022-03-31) 1 commit
>  - cli: add -v and -h shorthands
>
>  "git -v" and "git -h" are now understood as "git --version" and
>  "git --help".
>
>  Will merge to 'next'?
>  source: <20220331212709.36036-1-garrit@slashdev.space>

I've reviewed it and it looks good to me, and per my reply in the thread
I don't think we need to worry about squatting on a potential top-level
--verbose short flag.
