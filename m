Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE6EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiGSQJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiGSQJf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:09:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD248EB5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:09:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l14so9007101qtv.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TaQwj9wukx6wQeItVGYwcOXU3rwarocDgLIfpAp1ZLk=;
        b=JamcTOoOqmwBM+BI9ooZG3/8e+Upah692u6arkjIms1TuizWN3OOYW/wNCyX4yrL3k
         h3nJ/w4MAVedSjAMrBxVyswWUl2YyVYHcMi0n3mRyLLcftV5P9vKP0OBMbIj10LNvgek
         UQ1NtAOLgqUtwpO5kYJ4MZoYmIa+9Okiv6AYhdFLKFg0bPfgYPZwSeOfcJ/tuwUPnEag
         XrtMO2X/vsv9t/YlWjYfc9TiAkJo4z2v3PvTyIdFMVQVPkHLRimHhSTjUi+ulVLDMfO5
         iRGhwxaWqu2O9JOAO5YhLcIbPbroGCqxyp43yvxQWLELR9eU4+NkX5Xvqjdj/5C9FlB+
         czlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TaQwj9wukx6wQeItVGYwcOXU3rwarocDgLIfpAp1ZLk=;
        b=gssIza+h/k+Z7jmZFlnse4Ox6rAu5u2yKpi5SUTyOvC/P/lPLrx/Po8Dq2uyWslW7j
         /ff6d84SaCO6cBQNLbjUPMKaWTKJsVmSif/m+NlebCAhrZboCE+ttUrLLKI45u0E79D7
         JvE+Jlh/Y4YeTHwSUQLuyIxYXZT5R3vfbB7itypCh5l9wdGhtGjfvOwu4Ru9rvIc2zA1
         RJuI02sv0PYfi/VxinncCXKvuR9WuHZ3yQULW6fG00nWENEeF/0mKy8ilmfyo3KHsYEX
         n8PHcWx34eFgXajm9nGKDdTHSr7W2YZbs2sAMu6JrwSuGig74DdrFXY0WRBhXDL3NTQP
         NdhQ==
X-Gm-Message-State: AJIora/oL8sdcv7JfPd0t4r+f5RLfkXaiRElt2LA7B3E9gInS1J7Di8Z
        MeHRahlxbqnM2EUfWGY7/DwX
X-Google-Smtp-Source: AGRyM1uctHVmK9yeVFH5zb5be0eVZIe1ie0Soovon4ytZ5R281qQ4MRuGEpocOt2+/virytwF/dnrw==
X-Received: by 2002:a05:622a:1709:b0:31e:aef7:71f with SMTP id h9-20020a05622a170900b0031eaef7071fmr25117053qtk.27.1658246973601;
        Tue, 19 Jul 2022 09:09:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b006af4a816963sm15350155qkb.133.2022.07.19.09.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:09:33 -0700 (PDT)
Message-ID: <eec844fd-53be-960f-c806-5b97e8705229@github.com>
Date:   Tue, 19 Jul 2022 12:09:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 12/12] sequencer: notify user of --update-refs activity
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <d5cd4b49e46bc2c186c6e89333360a975700c99a.1657631226.git.gitgitgadget@gmail.com>
 <CABPp-BE++xWxWg5bJy9xj1i2QvFyGf+mKQvObdujNoPFU6M-Wg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BE++xWxWg5bJy9xj1i2QvFyGf+mKQvObdujNoPFU6M-Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2022 6:09 PM, Elijah Newren wrote:
> On Tue, Jul 12, 2022 at 6:07 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When the user runs 'git rebase -i --update-refs', the end message still
>> says only
>>
>>   Successfully rebased and updated <HEAD-ref>.
>>
>> Update the sequencer to collect the successful (and unsuccessful) ref
>> updates due to the --update-refs option, so the end message now says
>>
>>   Successfully rebased and updated <HEAD-ref>.
>>   Updated the following refs with --update-refs:
>>         refs/heads/first
>>         refs/heads/third
> 
> This seems good.
> 
>>   Failed to update the following refs with --update-refs:
>>         refs/heads/second
> 
> This is good, but I think it could be improved.  Could we also include
> the commit to which rebase would have updated the branch to?  That
> would allow the user to manually update it if they want, or at least
> see a range-diff between what we would have updated it to and what it
> now has.  Without that information, the user might have difficulty
> correcting that branch.

Would you mind if I left this as something for #leftoverbits? I
expect that a follow-up series will be necessary once we have more
user feedback. This isn't the only item delayed until after more
feedback.

Thanks,
-Stolee
