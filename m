Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE0C47096
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500DF613E9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 01:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFDBvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 21:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDBvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 21:51:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0A4C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 18:49:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u7so3846540plq.4
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jXSY+OoNXKGfcPbSW9UQq+jw1kFDcoZk8iWKYuGIync=;
        b=VCUKJTDBdIgg+IS++cHtW251v+728SRu9ZtQAYWgVj6yON7C2nLpOUXVsdRvJ/5dIE
         PFGSxnfAKcEDlizVda6hKgCksx8knX6GpGV/7tEVJB53iLsZjviN6cdkTuA0DTGLBQgU
         9BdLhums4hg++48ACxYrvvyLxaYyao0VTkXiPq6iWF3CvnhAxklcVNyrXLUthXoUdqJW
         lsR9boVWqj1aHXHxfphNG0Xe/2hXjykCGrq24JBjWFV5ZDYRRpakI9YeFhD0lLD/Pp3K
         yYLJALZtkyPTKVgbPFuZc5pmubqgD5XJSVKP5dqPI84M+7DrDQv6B5Z5nG7tI0s9pgoX
         u2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jXSY+OoNXKGfcPbSW9UQq+jw1kFDcoZk8iWKYuGIync=;
        b=oDepIXhpBtHJ6jRXLqmxq9QoJ1Z7mYjEX4CVmnQqJ6e/ouFUyVMW+TMkz6spp9/Vgg
         K5cwXIk0ZdB+pXrATkbM7kC5HY3RRt/cs37e1VBXex9z0o5KEIwnhniEOfbrRupGSK9p
         5ha9lQLj5bFkpBDMldnvVcL/RndrT7ghJGP+i5/e9Tm33wMxVu1KiHI9mBGhGpAbL6tO
         mVguoZcOuc/1+gC184m7hS+Bz+BUmSyAuP19W+mCU8XuNQqE06XvPXnKL01FBwcvKxLn
         fDj2zlL7eHbISzgHUTFAx0naGcTVg80xJ3A7gTfRqD/D8uBhcg/cRXrGdKrRl7wwZqzh
         1tYA==
X-Gm-Message-State: AOAM530kQNQ0A8ms9J6E/Jwg/oEQQ8vaH/dcN2nbYVevYBA6xATPgUb9
        dzct1XOoa2VOfOmeyGM19Bc=
X-Google-Smtp-Source: ABdhPJzOu4cyIt6dImCvFthYVk28J5f+3v178Ei1VEPee8uTEyxiN7JAl+BunUVBh9XkJv5Fp2oMBA==
X-Received: by 2002:a17:902:d643:b029:ef:62cd:eeed with SMTP id y3-20020a170902d643b02900ef62cdeeedmr1960531plh.42.1622771365958;
        Thu, 03 Jun 2021 18:49:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:b66c:839a:e48e:131c])
        by smtp.gmail.com with ESMTPSA id f139sm267383pfa.38.2021.06.03.18.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 18:49:25 -0700 (PDT)
Date:   Thu, 3 Jun 2021 18:49:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Gmail OAuth2 in git send-email
Message-ID: <YLmGo8PZDAT90hj+@google.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <YLhx7nIptHUwXfBD@google.com>
 <878s3r73g3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878s3r73g3.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> It's been a while but I set this up at some point, why would git or
> distros need to make/register a private key? Last I checked you can take
> software like git-send-email or whatever, and just register a new
> "jonathan's e-mail sending script" with Google's OAuth thingy.

Yes, that's what I do.

[...]
> That seems like a much better approach than some centralized solution,
> since as you note doing that will require some authority to manage keys
> etc, and presumably if "jonathan's e-mail sending script" inadvertently
> starts using git-send-email.perl to send spam, that would currently not
> result in ban on "ævar's e-mail sending script", but if the two were
> registered as the same application Google might overzelously ban those
> as two tenticles of the same misbehaving "app".

I agree that it wouldn't be worth "git send-email" registering for its
own API key, mostly because registering for API keys with every email
provider would be a distraction from what git send-email tries to do.

On the other hand, I would mind a perl library or a commandline tool
that git send-email calls having _its_ own API key.  That would be
helpful to other programs that want to send email as well, and it
would help users who are not as patient as we are in trudging through
the multi-step process required.  For example, it's nice that KMail,
Apple's Mail.app, and so on have their own API keys instead of every
user of those programs having to generate their own.

Of course, that's a broader topic than Git; it's not something that we
on the Git list are uniquely positioned to do ourselves.  I only
mention it in case someone in this thread wants to write it.  Then git
send-email could use such a library or point to such a tool in its
documentation.

Thanks,
Jonathan
