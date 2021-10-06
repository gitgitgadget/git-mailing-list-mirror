Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C32C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 05:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4B16117A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 05:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJFFHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhJFFG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 01:06:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C3C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 22:05:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m21so1356597pgu.13
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bOQhC9NIl9xMrm/rDYq95PykODPXWipV9FWk2/oRxM=;
        b=G4xp4i2oUXJT5tktVSQEgWQWJHjVFijSr+G/WrjuB6WolJe5xTIw1KLdiNqb+HuJXt
         4mKrcayGtCpde05PinJNsSP1YiokEf+A1tAnOPuqbpT8bgzc0bzXT8Fv504ofBwaeBCn
         q38hyLj+kcR1Ce6JezJxGLXV+Ut/crEVQl9UGPNfDUtOlTwDf22d1+YSqLevYtFXewhN
         MOXbLHxklJ9RFNcRg2AS7ztnGJS0Q34/590jeetKA7D1MuMUoJMHWpw4AoiAEu/IQGmv
         Y+rjvKPZeGZgafhHEyq4q7rYYkaRJ0KONjH4GUbkP/rswQOAtNAXmVyyjGxm2d0hePJ0
         Ls7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bOQhC9NIl9xMrm/rDYq95PykODPXWipV9FWk2/oRxM=;
        b=W7PsIPXYrSoX1yNAkdO2CrJaAE1T89kWoPjnIHeZ0rKjn4HmNm42UcnomBHw8tksEL
         j7CLGQd8/wzbP1utoXLUQHnpqMugYrdoakG34E5L2E4Kpv8243I6gmLCl+2oQTRuSTNa
         1GoXpDVCp2NLkOubB9vpzw5wiZObRMoui574Vt9UYQ8tPRADXsYz2+g5cBRcEItlyHtT
         c2GZjWyeX9FKcAfqHIBfLjK+/7V6h7VCgG+HxQJXF4VyzIOhGcJDxtToGUU30QA4oyEB
         tuvw2WHuQDNYs8hCpzpIXYooR/YQiG9gqIC06JQ4G3AHJSPbqM0LHuqh9chTRyrxGGEb
         jq/Q==
X-Gm-Message-State: AOAM532EOixGPHhv3DtAi09s6EdvEXQrApbkcg7yEkMgQXp4F0MOPo9y
        MdhJq/iH2mX2eXNu5AJpkAo8V3i2gCT7qw==
X-Google-Smtp-Source: ABdhPJxjG7VCWDO2t1+i1yO3lpqtXRi14Rgvg4srFaugogzukfstBoVn0dZmfQZkTy2fp2oE27xPDQ==
X-Received: by 2002:a63:d34f:: with SMTP id u15mr18584636pgi.200.1633496707172;
        Tue, 05 Oct 2021 22:05:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id 21sm3389654pjg.57.2021.10.05.22.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:05:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] Documentation/git-status: mention how to detect
 copies
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     newren@gmail.com, git@vger.kernel.org
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
 <20211004190050.921109-4-aclopte@gmail.com>
 <31f46980-7e40-46c0-87b7-f5ea7034af2b@gmail.com>
 <20211005194224.qcblxih5rlehzo4d@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <88adcdf1-7b10-c834-84ad-52fe273c0ced@gmail.com>
Date:   Wed, 6 Oct 2021 12:05:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211005194224.qcblxih5rlehzo4d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/21 02.42, Johannes Altmanninger wrote:
> I wasn't sure whether to add backticks to status.renames because we are
> already inconsistent in this file (search for "config option").
> Anyway I agree that backticks look better here (makes it bold in the man page).
> 
> Maybe we should automate this? We can write a test that makes sure that we
> always use backticks around config keys, at least for new changes.
> 
> ---
> 
> I didn't add backticks to "copies" to be consistent with this part before the context
> 
> 	Ignore changes to submodules when looking for changes. <when> can be
> 	either "none", "untracked", "dirty" or "all", which is the default.
> 

I think for consistency, we can go with automated style changes that use 
backticks to monospace:
     - file name and paths
     - daemons/services
     - configuration names and values
     - file content (use ```...``` block unless inline)
     - command-line
     - keyboard keys (dunno?)
     - any other inline text that needs to be written exactly

I have seen many times articles that say `Run "foo bar" (no quotes)` 
when they mean `Run `foo bar``.

For the exception you mentioned above it can be monospaced as part of 
automated change above.

-- 
An old man doll... just what I always wanted! - Clara
