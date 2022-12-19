Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098BC001B2
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiLSUmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 15:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLSUmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 15:42:11 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DF7635E
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 12:42:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so9881984wrx.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOEhIgF9NtnW08k3+o4uvOZzsNG3mbadugO4b/77Xcc=;
        b=RZq9AONsaDamXJ7duIq9gd+AHrJ//yzakzqkl6QKLeBfcPt5Wri+pD2tLqeSf/ZiXw
         dGTChG+T5VpwFlXz5xo9T1H7GkzUud0aNWxEBGCaOjfHGPCtNsSvEwR3MGKcOtS+xSG1
         74S+YetEsmzx8OX4sZzWNfnELXVVRaoQnt49j/eSXIriNzkTE8IcmldfgAhJhg06KH9M
         niwdyH8koTgE9RV43KSjlbLfpFEszf3Ky5ukB5FeO4UWAd/rYdj/rSNfLwmoiaeF+dMC
         abuPFukAQfVYKEjACd3r9xoMsCfberCvlQpGFampub6d6CrynpNbZo1hbFMpA+ULDLRM
         ovBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOEhIgF9NtnW08k3+o4uvOZzsNG3mbadugO4b/77Xcc=;
        b=VbFJj/1BRFyzvfqe37DEUlJAO+O6Gzzc7vRBSCXRPUmlHAV/E7y+ZVXouElRXq+D2/
         8VExAv35sdoB66wB2BWMMGi2FBFdeKiPP4I/478jomLfy2DaYxqwhum0vOBAFA+dbYYk
         fPd8RBPRoCB9UGPT0XruCsQZyjdbyQxgL08FaNGPZbp3uJN7cczmwWaBey5sIwWceXaF
         lonv7QA2VJN6A/bbrUPrRqcEXQk5NHlYpm6VY8tfHWVbR3z6Edyi8o893ZmDvcS3FN8d
         HR0lnoQodrjqJpsWk0CsmoeXujrf2inSwuhazECLQE6oGDnL/0iIy+aFKnrvUsMFiB7C
         s7XQ==
X-Gm-Message-State: ANoB5pm4Y/LjJOtJSWCrFXogZsr/6xOcTnO0NtxZkslTaajePVeXGgAi
        +HE+/kqyngFkRrLaf1v8i4g=
X-Google-Smtp-Source: AA0mqf5BePzmWiZhJzqHQMPzBz9P/C08XfHBKtxDanqBbAH1NTXnLKwqxCts/AVBdREdO5wjjm3JCA==
X-Received: by 2002:adf:ee11:0:b0:242:331b:cc81 with SMTP id y17-20020adfee11000000b00242331bcc81mr25437456wrn.11.1671482529454;
        Mon, 19 Dec 2022 12:42:09 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0024245e543absm10591766wrq.88.2022.12.19.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 12:42:09 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a6efeaa9-0995-1d1e-a557-e320fbfe5d2b@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 20:42:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] remove USE_THE_INDEX_COMPATIBILITY_MACROS
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
 <11545cde-9ce2-acf4-7c08-1b49d2dbefa2@dunelm.org.uk>
 <221219.86cz8fzara.gmgdl@evledraar.gmail.com>
In-Reply-To: <221219.86cz8fzara.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/12/2022 15:11, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 19 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 15/12/2022 09:58, Ævar Arnfjörð Bjarmason wrote:
>>> My recent now-landed topic[1] to remove most use of
>>> "USE_THE_INDEX_COMPATIBILITY_MACROS" was merged in 041df69edd3 (Merge
>>> branch 'ab/fewer-the-index-macros', 2022-11-28).
>>> It left out use of the macros that would have conflicted with
>>> in-flight changes, but as those topics have landed we can now complete
>>> the migration.
>>> As before this is almost entirely a matter of applying the existing
>>> "pending" coccinelle rules, the exceptions being 1/6, and the *.h
>>> changes where we remove the macro definitions (the macro users being
>>> edited by coccinelle).
>>> The 4-5/6 then handle some edge cases we had left (but the code
>>> change
>>> itself is done by coccinelle).
>>
>> I've only given these patches a quick scan, but I think they look
>> good. None of the callers that are converted here are in library code
>> so using the_index makes perfect sense.
> 
> Thanks for the review.
> 
> That's correct, although even if that were the case that wouldn't be an
> issue with this migration, as we'd have been using "the_index" before,
> just indirectly through a macro.

Indeed, I'm just not convinced that it is worth removing the macro in 
library code without changing to take a struct istate (I don't see the 
existence of the macro itself as a problem as I think it is just a 
symptom of the real problem) but I seem to be in the minority on that point.

Best Wishes

Phillip

> That wasn't the case here, but I do I have another similar migration for
> migrating "the_repository" wrappers.
> 
> In those cases there's surely instances where e.g. we really should be
> using a "r" argument instead, but I've opted to leave that question out,
> as it would make the coccinelle rules involved & diffs much harder to
> deal with.
> 
> And because in the end the result is the same if viewed with "cc -E",
> i.e. these are just the macro shims we've been meaning to stop using for
> a while.
> 
