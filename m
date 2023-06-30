Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC0CEB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 14:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF3ORh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3ORg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 10:17:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0AE2D78
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 07:17:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5776312eaddso4202397b3.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688134654; x=1690726654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=APChx2IzQ18E8XfEVjiqbqMYNh2lK+UK3L7tgq+V/aE=;
        b=LL4NaEl6xHh0cmop5BYEQOZvExypV1xrCq0lgjfl5FpHBtmrM405y/dRdc/Gjm6I0C
         X/Sveen8rSsYMD4qNkuFjH1ECAIBZ2a1qkBr3PQ28qiOUxfTCofFVfWBKwJEvFZ3j0Nq
         tlBocS2pF3QkmpBvrjNxMtuvBtwyOkTTzt+Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688134654; x=1690726654;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APChx2IzQ18E8XfEVjiqbqMYNh2lK+UK3L7tgq+V/aE=;
        b=gjKBWfp/OXwTIVh8hmfA86rZ8cFfycR0BiAaHYXB35hjLMo8zRm0aOgQkKJRt6XNPp
         nxuLDCz7kkvXuNwbsMPg2gzaOi4B9/Q5Eb7RXRHiu8CHx0vKK0mL8r6njmE6hv9dkzLs
         B/fkV/uPAUl/VytXXZBeBtn8A9h627VP29QPsjjd4gagnrzTEIwVYFI/rxvSJXKFK6cV
         oSBL/aQPB84vcUd8GZ3dvyBMqXVs+Y9dgsSFUc+Fp11wdX8R1tCt9UGiq/fA+0Fkso0R
         E7KBtLfT2iWn0glZcNutqOQVB0DwSLMeTH2XvCErsyJRlc+umqN+HkpQXPKGTRp5eLDA
         dHwA==
X-Gm-Message-State: ABy/qLbl6p6VNVYvYQM65zxj+3OttoNdg3A+XlodxV3alxwd5ZnZloo0
        W/0JQh8eYu4y8BibR10WpCR/fg==
X-Google-Smtp-Source: APBJJlF5RocGMKq1yj/NKsTy/qpPk4L5Hk00s12Qyiw44wO8d5Obsf6N9jMlW4eT0wSTZ9Up1+yI7A==
X-Received: by 2002:a0d:e385:0:b0:576:b999:3d75 with SMTP id m127-20020a0de385000000b00576b9993d75mr3073719ywe.14.1688134653991;
        Fri, 30 Jun 2023 07:17:33 -0700 (PDT)
Received: from nitro.local ([209.226.106.132])
        by smtp.gmail.com with ESMTPSA id w29-20020ac84d1d000000b004032d9209a0sm2143404qtv.50.2023.06.30.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:17:33 -0700 (PDT)
Date:   Fri, 30 Jun 2023 10:17:24 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ruben Ticehurst-James <rs_ticehurstjames@apple.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com
Subject: Re: "git commit -m" bug
Message-ID: <20230630-staid-welcome-howl-da79f0@meerkat>
References: <5C7CF0D9-4C6F-4207-BA4B-8AC9B472BD75@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C7CF0D9-4C6F-4207-BA4B-8AC9B472BD75@apple.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2023 at 02:30:55PM +0100, 'Ruben Ticehurst-James' via Git Security wrote:
> Hello I am reporting a (potential) bug in git: 
> 
> when I use triple exclamation marks in a commit message (for an example):
> 
> git commit -m “WORKING!!! WOOOO” (command above was git add .)
> 
> or 
> 
> git commit -m "Checking !!! Git” (command above was ls)
> 
> It will instead copy over the last command I used. The two above commands produce this output: 

This is done by your shell (bash). For example, try this:

echo "hello"
echo "hello!!"

-K
