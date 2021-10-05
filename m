Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A342FC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E83E613D5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhJEUq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhJEUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:46:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D48C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 13:44:35 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l13so434662qtv.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZaQTdFtpnproSXvl5Agmi1//3Mf0JWyHAz7HMZdxt/k=;
        b=LOEC77/ryckPvoxwJZ7zJbxxpC7zxuv8/C+J8Ug1UFFfXXN/jMvD3zETQqw42RP5Cm
         UELCPo6hMeYzYThKQSNG6pWBaZ99S4cOphTZp3+Z3genZtt6+2cecRYPClhSsutUa2j9
         9QBQFROjixVbxu2xlbkNHy4hAOCr2/CRvlVDsy45l4GnQg2QOL/r3RNkhoK0R3WHqFPr
         WURWHNlplejcGybKi6UMGIk7K6wlhhlGSvNLyDPDkmCVhakEPEPIO8x9t5wyUtnScbXj
         VYfjKcfmcJHLpSh9TQ35eRS7pac3OgI2xAY3gz1DUvkA0zTnaEBYwoaummhOtfPPfsNg
         EHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZaQTdFtpnproSXvl5Agmi1//3Mf0JWyHAz7HMZdxt/k=;
        b=zhYudad8iNovH3v6qt/pwmwzlNlXVPARgie4r8J1ECl8P/b/9TFbXsYMVstq/XFeB8
         b5OvZAfvhXy9dxNbcccnMguIZdssEel3mZlmOAz9UIA8RxVZPa8en1hOL1DSAaDUONDk
         F4BL0rPjBYVBGWHw1gBdxtHO9vAsdpmmQS7ys4cZaf06kAT9AL1brAFXNR0YawmkZy9k
         pNXoae5zju7PRv5uOdW4JePakWSzqhI6Xvwe6S1hsvHLv+Ssnfo0StmnPXRq0Kll2ZQ2
         AyZvSaFHBnzUS1fKpY+R0tklFbMTDB0ceZ3DiI+VdPwOM0sT1f/CXLCmfpzPV1vKwZ7L
         1vDw==
X-Gm-Message-State: AOAM532Tk/cASS5RLzyyp7NZqsby7e8lKfhKW3dQY4TMZ/cOwVAwKVHd
        +WeOlS1gw+PBJN48qMH/+9TwsemCUHlilOk=
X-Google-Smtp-Source: ABdhPJxqGVsv34+iM2Lr7wlAmARpb46Uz8CYkQDLZRyUK96scxyMGZaAefoQ63oB5t2dJHhOmmyH4A==
X-Received: by 2002:ac8:7948:: with SMTP id r8mr22818344qtt.360.1633466674931;
        Tue, 05 Oct 2021 13:44:34 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id j184sm10421208qkd.74.2021.10.05.13.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 13:44:34 -0700 (PDT)
Message-ID: <8b9fe3f8-f0e3-4567-b20b-17c92bd1a5c5@github.com>
Date:   Tue, 5 Oct 2021 16:44:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 0/7] Sparse Index: integrate with reset
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <878rz7lbm6.fsf@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <878rz7lbm6.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 05 2021, Victoria Dye via GitGitGadget wrote:
> 
>> The p2000 tests demonstrate an overall ~70% execution time reduction across
>> all tested usages of git reset using a sparse index:
> 
> [...]
> 
>> Test                                               before   after       
>> ------------------------------------------------------------------------
>> 2000.22: git reset (full-v3)                       0.48     0.51 +6.3% 
>> 2000.23: git reset (full-v4)                       0.47     0.50 +6.4% 
>> 2000.24: git reset (sparse-v3)                     0.93     0.30 -67.7%
>> 2000.25: git reset (sparse-v4)                     0.94     0.29 -69.1%
>> 2000.26: git reset --hard (full-v3)                0.69     0.68 -1.4% 
>> 2000.27: git reset --hard (full-v4)                0.75     0.68 -9.3% 
>> 2000.28: git reset --hard (sparse-v3)              1.29     0.34 -73.6%
>> 2000.29: git reset --hard (sparse-v4)              1.31     0.34 -74.0%
>> 2000.30: git reset -- does-not-exist (full-v3)     0.54     0.51 -5.6% 
>> 2000.31: git reset -- does-not-exist (full-v4)     0.54     0.52 -3.7% 
>> 2000.32: git reset -- does-not-exist (sparse-v3)   1.02     0.31 -69.6%
>> 2000.33: git reset -- does-not-exist (sparse-v4)   1.07     0.30 -72.0%
> 
> This series looks like it really improves some cases, but at the cost of
> that -70% improvement we've got a ~5% regression in 7/7 for the full-v3
> --does-not-exist cases. As noted in your 7/7 (which improves all other
> cases):
> 
>     (full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
>     (full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
> 

New performance numbers at the end - I think I have an explanation for this.

> Which b.t.w. I had to read a couple of times before realizig that its
> quoted:
>     
>     Test          before            after
>     ------------------------------------------------------
>     (full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
>     (full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
>     (sparse-v3)   0.76(0.43+0.69)   0.44(0.08+0.67) -42.1%
>     (sparse-v4)   0.71(0.40+0.65)   0.41(0.09+0.65) -42.3%
> 
> Is just the does-not-exist part of this bigger table, are the other
> cases all ~0% changed, or ...?
>     

These numbers were for the `git reset -- does-not-exist` case only. If I end
up needing to send a V3, though, I'll probably remove the performance
numbers from 7/7 altogether - looking at them now, they make the commit
message somewhat cluttered. That said, performance numbers *are* helpful for
reviews on the mailing list, so I'd keep the information in the cover
letter at the very least.

> Anyway, until 7/7 the v3 had been sped up, but a ~10% increase landed us
> at ~+6%, and full-v4 had been ~0% but got ~6% worse?
> 
> Is there a way we can get those improvements in performance without
> regressing on the full-* cases?
> 
> Also, these tests only check sparse performance, but isn't some of the
> code being modified here general enough to not be used exclusively by
> the sparse mode, full checkout cone or not?
> 
> It looks fairly easy to extend p2000-sparse-operations.sh to run the
> same tests but just pretend that it's running in a "full" mode without
> actually setting up anyting sparse-specific (the meat of those tests
> just runs "git status" etc. How does that look with this series?
> 

I updated `p2000` locally to do this but the setup was substantially slower
for the full checkout, to the point that it was infeasible to run the
complete test for all relevant commits. Looking at the changes in this
series, nothing appears to affect the full checkout case differently than
the sparse checkout/full index case, so I'm fairly confident there won't be
a regression specific to full checkouts.

> Since only the CL and 7/7 quote numbers from p2000, and 7/7 is at least
> a partial regression, it would be nice to have perf numbers on each
> commit (if only as a one-off for ML consumption). Are there any more
> improvements followed by regressions followed by improvements as we go
> along? Would be useful to know...
> 

I don't think any of the apparent slowdowns seen in these results represent
real regressions. After re-running the performance tests, I saw variability
of up to ~20% execution time across changes with commands that should see no
effect on their execution time (e.g. sparse-v* from 1/7 to 4/7).
Additionally, I saw different increases & decreases each time for each
end-to-end run of the tests. The most reliable, noticeable changes across
the test executions were:

1. When each variant of `git reset` was integrated with sparse index, a
   65-75% execution time reduction in relevant sparse-v* tests.
2. `git reset -- does-not-exist` slower than `git reset` in 6/7,
   then matching its speed after 7/7.
3. As of 7/7, full-v* to sparse-v* showing a 50% execution time reduction.

My guess is that the variability comes from general "uncontrolled" factors
when running the tests (e.g., background processes on my system). The good
news is, when the tests are re-run with more trials (and the recent bugfix
to `t/perf/perf-lib.sh` [1]), the execution times look a lot less worrisome 
(apologies for the table width, but I'd like to err on the side of providing
more complete information):

Test                                               base              [1/7]                    [4/7]                    [5/7]                    [6/7]                    [7/7]            
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2000.22: git reset (full-v3)                       0.44(0.16+0.19)   0.44(0.17+0.18) +0.0%    0.44(0.17+0.19) +0.0%    0.45(0.17+0.18) +2.3%    0.44(0.17+0.19) +0.0%    0.45(0.17+0.18) +2.3% 
2000.23: git reset (full-v4)                       0.43(0.16+0.18)   0.43(0.16+0.19) +0.0%    0.45(0.17+0.18) +4.7%    0.44(0.17+0.18) +2.3%    0.44(0.17+0.18) +2.3%    0.44(0.18+0.18) +2.3% 
2000.24: git reset (sparse-v3)                     0.82(0.54+0.19)   0.84(0.56+0.19) +2.4%    0.81(0.54+0.19) -1.2%    0.88(0.60+0.19) +7.3%    0.27(0.03+0.45) -67.1%   0.27(0.03+0.47) -67.1%
2000.25: git reset (sparse-v4)                     0.82(0.55+0.18)   0.82(0.53+0.20) +0.0%    0.83(0.55+0.19) +1.2%    0.82(0.54+0.19) +0.0%    0.27(0.03+0.50) -67.1%   0.27(0.03+0.48) -67.1%
2000.26: git reset --hard (full-v3)                0.71(0.38+0.24)   0.69(0.37+0.23) -2.8%    0.70(0.37+0.24) -1.4%    0.78(0.41+0.27) +9.9%    0.71(0.38+0.25) +0.0%    0.70(0.37+0.23) -1.4% 
2000.27: git reset --hard (full-v4)                0.71(0.38+0.23)   0.77(0.42+0.25) +8.5%    0.76(0.41+0.26) +7.0%    0.72(0.40+0.24) +1.4%    0.68(0.37+0.23) -4.2%    0.67(0.36+0.22) -5.6%
2000.28: git reset --hard (sparse-v3)              1.29(0.93+0.26)   1.33(0.95+0.27) +3.1%    1.11(0.76+0.25) -14.0%   0.38(0.05+0.25) -70.5%   0.36(0.04+0.22) -72.1%   0.34(0.04+0.21) -73.6%
2000.29: git reset --hard (sparse-v4)              1.17(0.84+0.24)   1.10(0.79+0.23) -6.0%    1.01(0.69+0.24) -13.7%   0.42(0.05+0.26) -64.1%   0.39(0.05+0.25) -66.7%   0.38(0.05+0.23) -67.5%
2000.30: git reset -- does-not-exist (full-v3)     0.50(0.19+0.20)   0.50(0.19+0.20) +0.0%    0.53(0.21+0.22) +6.0%    0.47(0.18+0.19) -6.0%    0.45(0.18+0.18) -10.0%   0.45(0.18+0.19) -10.0%
2000.31: git reset -- does-not-exist (full-v4)     0.45(0.18+0.18)   0.46(0.18+0.19) +2.2%    0.47(0.19+0.19) +4.4%    0.45(0.18+0.19) +0.0%    0.45(0.18+0.18) +0.0%    0.45(0.18+0.18) +0.0% 
2000.32: git reset -- does-not-exist (sparse-v3)   1.01(0.70+0.21)   0.91(0.62+0.20) -9.9%    0.93(0.64+0.20) -7.9%    0.89(0.61+0.20) -11.9%   0.48(0.23+0.46) -52.5%   0.27(0.03+0.49) -73.3%
2000.33: git reset -- does-not-exist (sparse-v4)   0.99(0.67+0.21)   1.02(0.70+0.22) +3.0%    1.04(0.70+0.22) +5.1%    0.83(0.55+0.19) -16.2%   0.48(0.24+0.48) -51.5%   0.27(0.03+0.49) -72.7%

Note that some commits in this series are not included because they don't
touch any code used by `git reset`.

[1] https://lore.kernel.org/git/pull.1051.git.1633386543759.gitgitgadget@gmail.com/
