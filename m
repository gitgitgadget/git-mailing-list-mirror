Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D374C6FA82
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 22:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiISWKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 18:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiISWKA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 18:10:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13223BC7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 15:09:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d82so916609pfd.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dB5eyVmmARfSiY/NmswvBpUcW7KT07kupMdvgUodco0=;
        b=T+npASf/6vlCe42g08KOJznpUwmW+bOOqvpIe4iBTaTRMRENLwBlnsHJk0jdNYBkhD
         p0exfLh6e4ViAGdmrrgGjZVmWTy+msUIHG7QG9y9JHW9a+/VXWs7GsODLqymB6f1FCo9
         9zNkoz8I0oF2KqEfh1rJPGnsi/TohNYwHl7ef68w/NvFeGfbA9pFS2IkvMaNa8ueeMvK
         FPQ9rxgNVuE3mNo81N14bNP0KQcFsaNnu0NEZ0u16+jbQ//59v+GVgRMpanKSaH+sHFR
         fmtAdMOZGxc6kCGEXFF0KMohzQLOHbKV6Ey5Yzfyw2LYAiJPBb2Z0m2FK3vPwnP680d/
         ojgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dB5eyVmmARfSiY/NmswvBpUcW7KT07kupMdvgUodco0=;
        b=YtWnJ6Pk7x3bguBXuMN6uhAewmTdZAqH8fWx37wRDvjtU64UxxLWJ4AuraFLkRWPxP
         q+ccG/viA9yW9ZYxciE29xm9a5HF/joZgy2HNp58QeynDrOKVC3DagX9w9FKJAFBlAQs
         w9pek6tW0yk+gWqc5K93RcRzyIowklYd0SKbJWMdgJe40Ic5H2JCmT+f2S/T/zVWdhXs
         Eo+pjHAGmN3Fwgjt6WudDFOQdojK/OEa2Sq6iMTvx1/Hfk3xtaZ1tcAEHay5lXQPEpGd
         RRaX9R/ifOQBx5oPkAowdpqhTd7uAfNBU+SUcrv0OtXpye1IuaUuKsjYzYtOl0eKoZ4k
         /7Bg==
X-Gm-Message-State: ACrzQf3VupxbVG/e2Lu6HyEwvVejy4OLpPNu8yV6v8iDDGhBUW7fYqA4
        5XSbMjJX1OwHpXx+221zAWeS5GK3HayV
X-Google-Smtp-Source: AMsMyM5BxO5Fy9n+AdqeIXq1PoKAJ824BgoL0Qw4oU4lqokKVhL0V4NJqbsvN1x7XUPshL8mU1U19Q==
X-Received: by 2002:a65:6e0d:0:b0:42d:707c:94ee with SMTP id bd13-20020a656e0d000000b0042d707c94eemr17121972pgb.260.1663625399137;
        Mon, 19 Sep 2022 15:09:59 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090abf8200b00202d1745014sm7173213pjs.31.2022.09.19.15.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 15:09:58 -0700 (PDT)
Message-ID: <b1c44436-92d1-067c-fb0a-be4049f3031b@github.com>
Date:   Mon, 19 Sep 2022 15:09:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 07/34] doc SYNOPSIS & -h: fix incorrect alternates syntax
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <patch-07.34-a070c97f29b-20220902T092734Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <patch-07.34-a070c97f29b-20220902T092734Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> Fix the incorrect "[-o | --option <argument>]" syntax, which should be
> "[(-o | --option) <argument>]", we were previously claiming that only
> the long option accepted the "<argument>", which isn't what we meant.
> 
> Unlike a preceding commit where this was fixed for commands which had

nit: if you're referring to patch 10 [1], it wouldn't be a "preceding"
commit. Otherwise, I'm not sure which commit you're referring to?

In any case, I'd personally prefer that this patch is combined with patch 10
anyway, since both fix the same underlying issue (just in different places).
Neither patch is particularly large, and it would be nice to make (and
review!) all of the "fix alternates syntax" changes at once.

[1] https://lore.kernel.org/git/patch-10.34-965f6b3b3cb-20220902T092734Z-avarab@gmail.com/

> inconsistent "-h" and *.txt, for "stash" it's been with us in both the
> "-h" and *.txt since bd514cada4b (stash: introduce 'git stash store',
> 2013-06-15).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
