Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C28C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17E360E05
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhJNPyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNPyz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 11:54:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE26C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:52:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so20896955wrv.9
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YzYoqcXtZmSZIoz0A3zTsO1BTD2dYq/zfqz67AHNxU4=;
        b=cwvpuHkQGn8V/Jpe/PH+Hz3WLcQrMZc423Zxv0uzToCHFw5oAB7fZsfOCEFa+UoHoA
         dBWcIh9RnOMb/qzoVj0Oosk+3nUQ3vHuzCfs38K6mtsBvjCT4UA+RUwLHCC2e80lPtog
         6mNRE1dml7VSSghcJ8t0R3KbX52hhyONoZI2XAQeTw6k3ipkti5YeUyaOGBI48Eee3Un
         QDt++25w//BM7MTrIWpZK6rZkOoBzMFMom2F289dUOv9MZ972icq2a6wtfc9Bozxr7RQ
         ZpuUbArBZd090u22pxpZ4AroSB+TGdCs4MKDvEixmK1+TrT4gT8SN6B0t0YzT+VeJrav
         WQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YzYoqcXtZmSZIoz0A3zTsO1BTD2dYq/zfqz67AHNxU4=;
        b=gOU0BS84zEeU4n8QLPZUdhzJjKdvEXhKdCGrmHvBuqSl8H30e7TaDQeYoWSgeinRaO
         VciwWOLkynie1vE3PRVCxLKPzjy+BFwjZEqzND7iJf/igtfauLG7YY3mz78mt0c9Hv0N
         xUOaI99K/uw2aYS888FXEOKVye2K1bRXBpHdHtl//cFVD/YTYI3NL7EdcfbRqyBgDoyj
         ahMUKqMnxlmWpegocj0TFgZ4j48UaqgBG0CGBa95X0RJWsdSRg+IzRvwS82TpgRhmcEy
         EufhUQVo6nRdYvapEBvX2M1YVCLyBBaKAgS5VgpK3WfbZuH/fftYtip2uNnKBWyiPPkW
         WaxA==
X-Gm-Message-State: AOAM533kl04GYs0mCo2FIgPX+DxpH9NIrgbvCZJVSa2jr7aonJLL31uu
        bp93OoKvwrIbazPqpzEx/PWJ8oZqFX0v5w==
X-Google-Smtp-Source: ABdhPJz4MMyOHaXFc5iPVKrwzOQcX5+OpbmdM7+6Wh0no3Rci21Z1siMdKYumqs3AT8LO+YS9kDr4Q==
X-Received: by 2002:adf:a413:: with SMTP id d19mr7847606wra.246.1634226768239;
        Thu, 14 Oct 2021 08:52:48 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c15sm2736217wrs.19.2021.10.14.08.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:52:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Oct 2021, #03; Mon, 11)
Date:   Thu, 14 Oct 2021 17:50:51 +0200
References: <xmqqv9239k15.fsf@gitster.g> <xmqqwnmgeenz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqwnmgeenz.fsf@gitster.g>
Message-ID: <878ryvhacw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * js/retire-preserve-merges (2021-09-07) 11 commits
>>   (merged to 'next' on 2021-09-10 at f645ffd7a3)
>>  + sequencer: restrict scope of a formerly public function
>>  + rebase: remove a no-longer-used function
>>  + rebase: stop mentioning the -p option in comments
>>  + rebase: remove obsolete code comment
>>  + rebase: drop the internal `rebase--interactive` command
>>  + git-svn: drop support for `--preserve-merges`
>>  + rebase: drop support for `--preserve-merges`
>>  + pull: remove support for `--rebase=preserve`
>>  + tests: stop testing `git rebase --preserve-merges`
>>  + remote: warn about unhandled branch.<name>.rebase values
>>  + t5520: do not use `pull.rebase=preserve`
>>
>>  The "--preserve-merges" option of "git rebase" has been removed.
>>
>>  Will cook in 'next'.
>
> I am tempted to merge this down to 'master' soonish, in time for the
> next feature release that is planned to happen mid November.
>
> Opinions?

I'm all for it, and FWIW really understand the carefulness with that
topic. I.e. the actual code changes are rather straightforward and well
understood.

Any actual breakage with it is likely due to some unexpected 3rd party
workflow needing this deprecated mode still, which surely we're better
of finding out sooner than later pre-release (if such users even test
pre-releases...).
