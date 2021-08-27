Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65407C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F54260FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 07:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhH0H6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhH0H6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 03:58:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280FC061757
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:58:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m4so3471550pll.0
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xox4q2LFSoBHnKFQND4FhirGchYxCrn6Vu5FjyixcOs=;
        b=uNR2Jjbp8cJwfLk1XxfcwhlvWey/KvgzC3wH0utDB5uRvqPhN6QWV9wQoQZgExxyG2
         HQ9zXz+Ie0RglPcLKNMZ7WrCgRT+7bdJAS81TwdEFsaK6ZrM8ZtFv0ddiYWJjASEIMlA
         kRhzH8pHa1DRtpkiXBgsLa9Djn4rbK1b0vwnSCDsT/mRC+pAxegRHHxCjKQmLx3Mqjga
         Zdyxl1qW+/TOR8nLdOWIbLw+CG4kII37DLi1ISXg9PL9v7dov2hn+M36zh5Lh3MYSLe1
         oAUfpL2qCR95LDBSO7FB0qbvpBFwFj7TO3Ba9ujNHZzlMZnlm/iIDubwAGjOJ5Wpn6Yw
         8qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xox4q2LFSoBHnKFQND4FhirGchYxCrn6Vu5FjyixcOs=;
        b=l/gVmqlXQQKLXirhO7gbDxWc+lbFjFHkSqIPV5Nw2mIocqPnigyCLFmNjk6PKxEOU6
         WrS+xH2Od5kCRZb3lXaUzGi5nZdcG/91vODL+2M2ojWJvJVGfVIJa8YJ1aw1NaHG8vxA
         9hMOcDR4PtuuVcJGNXK2d8uQu8ydp3ph3KdLLnDGoQL57cyTWZG+D2Ys8s4MtD+/0/EP
         tpfNA3LnvvBZ7OUE8Z39DeO8xsF9FtVLNbj34fp0hWWyHJuxGXxaD7TZ2HhgjVT+offm
         Psu5C/1bVopKudhAlN3UQbZoXKOhLiALQDHDUqQz8NhI7bam++pWtj+wG+Bg3BmNr9gM
         pbnA==
X-Gm-Message-State: AOAM532o3Y8gb4WQQNpxX6YUfICu/L3rtjsTcyrRSkdtQwwCXmX14u57
        s+4x8G7QuHUdkr/fZLjcalD1bLS9k2Y=
X-Google-Smtp-Source: ABdhPJzmSCvFBsHgs2DBvz+yXv+z5JXkO8Y3oyugEto4m0kQqMY83wGOfE3iOsOIBimf5fbOoAt8/A==
X-Received: by 2002:a17:90a:4a05:: with SMTP id e5mr7352029pjh.58.1630051080238;
        Fri, 27 Aug 2021 00:58:00 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id b3sm5443410pfi.179.2021.08.27.00.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:58:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] make: add install-stripped target
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210826113824.50078-1-bagasdotme@gmail.com>
 <20210826113824.50078-2-bagasdotme@gmail.com> <xmqq8s0odl5l.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b2005b0f-9181-526b-ebf5-58fca44299b5@gmail.com>
Date:   Fri, 27 Aug 2021 14:57:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s0odl5l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/08/21 03.08, Junio C Hamano wrote:
> It also depends on "strip" not to break handlinks to the same
> binary.  "git" is linked to many built-in command binary like
> "git-cat-file" and "git-remote-$curl" for various protocols are
> installed by creating links to "git-remote-http".  It seems that the
> "strip" command from GNU binutils package strips such a binary
> in-place, but I do not think there is no fundamental reason to
> believe that everybody else's "strip" would behave that way.
> 

Maybe hardlinks?

> I would have expected that 'install-stripped' and 'install' targets
> would run the same recipe, and when $(install_bindir_programs) are
> installed in $(bindir) using $(INSTALL), we would optionally pass
> the '--strip' option to the $(INSTALL) program when the recipe is
> run for the install-stripped target.  All the tricky symlinking,
> hardlinking and copying happens only on the result of that step, and
> the strip step should happen before that, I would think.
> 

Did you mean copying recipe of 'install' to 'install-stripped' and the 
latter s/$(INSTALL)/$(INSTALL -s --strip-program="$(STRIP)"/)?

-- 
An old man doll... just what I always wanted! - Clara
