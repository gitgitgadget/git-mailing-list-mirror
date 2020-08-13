Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3663C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB70420829
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 16:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq94NWwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMQhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHMQhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 12:37:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24FC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 09:37:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so4822382qtn.9
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wk32CUzIH/j4s2dtzxSIi4LEj0qi4Na4zT7fMghQ0nc=;
        b=aq94NWwIe/MF/VPAGfncrVd4jbzLD7bQxv4zUg3aLBaVqdMM25UzyEx3n6oB3Av1Xi
         gaBIT2rY52ukm/1OgMAbFIY+jMGZ7tUD1DDMq71H8UgQtsQf8klQl2k75DMWB6XOP+TY
         YPgsM2KlJoBvg3YZYCqWqPhDoIWS3z6LuWAUPca3jaxOB6UI9GdmBdYD/D7WGXxa5tnQ
         iRT1NDemgrD+5KGkrAcDn0wrhJhXHnh3BrEffj5LIasi80XKqYSElABhK0bW5GfXHvI9
         hW3rDM5m5QIP+MJVXT5u+EdFeAhAdVwX/xyajrPgCzlfMVU/bPb5sLwJ/QReNYeobPWp
         u0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wk32CUzIH/j4s2dtzxSIi4LEj0qi4Na4zT7fMghQ0nc=;
        b=kyy0KhUnrLofMywQoS2I+FBUnTU0cqWpPEaHsaIeVzjwTI+eB/My5GQBy6zC3nF6nM
         gGxG7FXnyFbljghQnPChDYKxbrcdza+8MLA+YHTiefbi5aqPz3LRP0dMnhjQ8nU4W3gI
         TiwL7BCBLDCCgaLKP3Ke1atL3MAIhGMXkC4NQKmr0r/iqqcxn7fFZgZCrbbXl4gi0psA
         fxKD/wIvebhzGP7ynt8KqaKtWStSgglEXivxSN39WpvhnBIzPQZdLgZZ+MR9/m0WiQlB
         3IkowwWLu8eUBjczrYpdfLB9q8rIut+oy9I5TbMnH3G0N42aMFrmaKeeotEP2vm/83Cb
         hFbQ==
X-Gm-Message-State: AOAM532kBSSm3QiEh+/0ZxfNUmCOLlpTVM376Denmd7xydGirUDcx+97
        n1Sw0/rGuZrEZw7BvMCxR3T/QjO9Ky0=
X-Google-Smtp-Source: ABdhPJypNl3r8B+W2omIwai3zY2mg4CIoiXtgSpADa9q4/9J0hRdACfJLe3rlbfwI7AHFJ7a3b4wOg==
X-Received: by 2002:ac8:50a:: with SMTP id u10mr6130518qtg.175.1597336662069;
        Thu, 13 Aug 2020 09:37:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id r188sm5769085qkb.122.2020.08.13.09.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 09:37:41 -0700 (PDT)
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145719.GA891370@coredump.intra.peff.net>
 <20200813150428.GA2244@syl.lan>
 <20200813150828.GA891963@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8b7889a-ea1b-702c-acd4-1eb79e445197@gmail.com>
Date:   Thu, 13 Aug 2020 12:37:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200813150828.GA891963@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 11:08 AM, Jeff King wrote:
> On Thu, Aug 13, 2020 at 11:04:28AM -0400, Taylor Blau wrote:
> 
>> On Thu, Aug 13, 2020 at 10:57:19AM -0400, Jeff King wrote:
>>> Over the years some more programs have become builtins, but nobody
>>> updated this MSVC-specific section of the file (which specifically says
>>> that it should not include builtins). Let's bring it up to date.
>>>
>>> Signed-off-by: Jeff King <peff@peff.net>
>>> ---
>>> Given that nobody has mentioned this, it makes me wonder if anybody is
>>> even using this part of the Makefile at all these days. Or maybe having
>>> extra lines here isn't a problem (though it's also missing some entries,
>>> like one for git-bugreport).
>>
>> If having extra entries didn't cause a problem, I would suspect that it
>> was just that. But that missing entries *also* doesn't cause a problem,
>> I'd suspect that this section of the Makefile just isn't being used.
>>
>> Of course, I'm not using it since I'm not on Windows, but maybe dscho or
>> Stolee would know if there are legitimate uses. Of course, if there
>> aren't, I'm favor of getting rid of this section entirely.
> 
> I cc'd Jeff Hostetler, who added it. :)
> 
> I'm also pretty not-knowledgeable about Windows, but I think that
> anybody using MSVC would do so through Visual Studio these days. And
> that's being covered with recent cmake stuff. Or maybe I'm just
> clueless. We'll see.

We create PDBs for our microsoft/git installers, such as in this
recent build: [1]

[1] https://dev.azure.com/gvfs/ci/_build/results?buildId=18994&view=artifacts&type=publishedArtifacts

Unzipping, I see PDBs for the git-* files listed in this command,
minus the ones that don't exist. So if this line is what creates
the PDBs, then it is not erroring out when trying to create the
PDBs for commands that don't exist.

Thanks,
-Stolee

