Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678E4C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 06:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbiDNGxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiDNGxc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 02:53:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0248315
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:51:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y65so4447762iof.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w0D1tDKAcfZR1kH6rHX6XdCeli2N78Cb+aVqif4yLNs=;
        b=aaHwmQJVcqJlK+AWZ/34Zj5ialuEDYOksgjMCPNKHEVMgzOV3BgW+k5Lmj1WlFruoz
         26SJe72X931S07aAK4Sx606HhEp8X30JyXwHauhu9DxUHcrT+sWWI1PvUjRYYtUAJgc5
         hlG4OGMhNgsFggfI7u4DkUBwdX8WLfJbQpCc3vTa4UhHPi8gIsKJbWUR+nPzaqxV+Uox
         auM2FXeAt2iukldRInsUn0I7tyfoe4z1/SnWBqbz4uY9sx6R3Xl6X4+VqGbUZOIFKIGk
         RuQp/S1wEPxrbyEc93/ZP8rIouMCBwmNybX0Du62WWnuASdbTHmlhz3X9POLX7GDG32n
         lUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w0D1tDKAcfZR1kH6rHX6XdCeli2N78Cb+aVqif4yLNs=;
        b=SgePqLvrhqYHa10osu69NZHTw8XY1pQZ5q1D5ilPKA58sTLtiZ5HDqLXhiFciFNzEe
         SJPx4cBq8jkUVpHtAqt0Jfn4rfEW9bOaq8blAan5IBqGANvDabvtDV9gARKEtmm/nUWV
         sUcEb1jo3VkaMkiCJwnhzrLom/oTlqUFPlhhA3Y/S902Js+b4VuHXuXSBOlEaRGSX0xR
         w9eBB5kfjO3pAto+5U8O5vrw/2wA8XtaZARzvItwj7jqQFNk9afuHGyQHsxY0SfuyzEe
         pLuAE/+Z+i/XH2lZ/OrIRO/CgCIoYuepX+81OQGdfwF6oRLWLrln2iANQTfytayi87Mz
         7UHA==
X-Gm-Message-State: AOAM5319dxMWHvdc8X0P8sLb6dSOZX3bPMpLb7RP/O/+Gr9gKDjwPCuX
        OxLQx2g+WaVQGvlBNVlvPew=
X-Google-Smtp-Source: ABdhPJz8til8r06ipP4yGQjyRHi2k30NOALAsrKnVqtjC101iKLOB1RC8EjaelMBw/9ogsa2b3ceUw==
X-Received: by 2002:a05:6638:16d1:b0:326:398d:63b with SMTP id g17-20020a05663816d100b00326398d063bmr629137jat.58.1649919068724;
        Wed, 13 Apr 2022 23:51:08 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id m7-20020a056e02158700b002c61541edd7sm702208ilu.3.2022.04.13.23.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 23:51:08 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <46b7dcdd-0c08-54ed-b8aa-22cf10d21e2f@sunshineco.com>
Date:   Thu, 14 Apr 2022 02:51:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 17/29] CI: split up and reduce
 "ci/test-documentation.sh"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-17.29-8837bfa5433-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <patch-v3-17.29-8837bfa5433-20220413T194847Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/22 3:51 PM, Ævar Arnfjörð Bjarmason wrote:
> Change the "ci/test-documentation.sh" script to run the bash-specific
> parts in as one command in the CI job itself, and to run the two "make
> doc" commands at the top-level.
> 
> It'll now be obvious from the title of the step if if we failed in the
> asciidoc or asciidoctor step.

s/if if/if/

> Since the "check_unignored_build_artifacts()" function is now only
> used in "ci/check-unignored-build-artifacts.sh" move that function
> there.
> 
> The recipe for the job in ".github/workflows/main.yml" is now a bit
> verbose because it's effectively the same job twice, with a "make
> clean" in-between. It would be better for the verbosity to run it via
> a matrix as done in the alternate approach in [1] does, but then we'd
> sacrifice overall CPU time for the brevity. It might still be worth
> doing, but let's go for this simpler approach for now.
> 
> 1. https://lore.kernel.org/git/patch-v2-6.6-7c423c8283d-20211120T030848Z-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

