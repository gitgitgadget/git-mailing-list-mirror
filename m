Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6909C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 18:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBASGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBASGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 13:06:45 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBA1E2BD
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 10:06:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h9so10663982plf.9
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpeu1Jo0wEzy7/tIdVYi9DWaIvEciEvEfm+Lcq+av+Q=;
        b=LDl/hfyC3XR/sy1ysPtv+wndhT2cwqcQWrLKBkZZewvWDrrA8Q9Hc+5OMi3/lrvGs7
         Njp/l1DkwUgMhtz5vzEDIN6KX8ZQbpI1KbRNKerjqpdWi+vfhpFs/hCqTu8QuWGh0amp
         gcZdCCOZ39TcQRThSUA/iP0RtvqUpR4NIxKyNcsRtghM/08SmToI6VUtkXohA6dYLSNw
         7LlZSFbYOGN/+22oMo2O1VcINCJyHHQz7X/mjxZuW5z/AyfzGlpOIk9DDXHPPcQiCUZM
         6x1sTzy0FfkPDZunda/Cjo9VaVf2O1qLTz0pmF9UkBf5AwbfUiVAXkDhfPhx5EYKt22D
         WnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hpeu1Jo0wEzy7/tIdVYi9DWaIvEciEvEfm+Lcq+av+Q=;
        b=pqi9jEgZOBwDVsTDiHrCB5JnJ4qumryz045HZJQ0Wg8Nr9+ZMjF1Js88CML0br5MJH
         0SuWJS36MsLjKs+8WFPRdsb3xYGuM3HBvd1eDKhMyHBn1y2DuIDzoxRzvaPs3Tq0wnOK
         GgrJVA4rZoKVb+9HTMFCwVscQfBUcy1D/+wRAFSzc9OO9iwSxL/b21YwMFpY+jSM32qi
         eOpNh59vgYt9cnnNVUMC37+r0FH3t8tjFvMMZfqRccKntUZBdoxDHR7g5l1mC7fogFfz
         Ud/MVbcPu68gaDx4+RgNlK0ZxZy1fyiwDnhPIbEa+Yi3doTGWi75SHJ4mCYFIWRlfgYT
         i+oQ==
X-Gm-Message-State: AO0yUKUhMVlYpxskjv4VhwCSio80QiFPGU1+J9fnpqC2Pe3ETUYcBk6S
        coxLedpQEIL2pymvMBmA2W0=
X-Google-Smtp-Source: AK7set+Y9RnJtjMmFt4R8nrTSCp3Fm6ivG7+T1J3yYsadW8CBfdRqvqqpZoDHo70Iymhyt0ylcGiJQ==
X-Received: by 2002:a17:903:2785:b0:198:adc4:2297 with SMTP id jw5-20020a170903278500b00198adc42297mr1762511plb.18.1675274802494;
        Wed, 01 Feb 2023 10:06:42 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id je14-20020a170903264e00b0019655211783sm10614243plb.306.2023.02.01.10.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:06:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] Makefile: not use mismatched curl_config to check
 version
References: <20230201113133.10195-1-worldhello.net@gmail.com>
Date:   Wed, 01 Feb 2023 10:06:41 -0800
In-Reply-To: <20230201113133.10195-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 1 Feb 2023 19:31:32 +0800")
Message-ID: <xmqqa61x1cr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> We may install different versions of curl, E.g.:
>
>  * A system default curl, which version is below 7.34.0, is installed
>    in "/usr", and the "curl_config" program is located in "/usr/bin/".
>
>  * A higher version of curl is installed in "/opt/git/embedded/", and
>    the "curl_config" program is located in "/opt/git/embedded/bin/".
> ...
> diff --git a/Makefile b/Makefile
> index 45bd6ac9c3..f4eaf22523 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1597,6 +1597,7 @@ else
>  		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
>  		CURL_CFLAGS = -I$(CURLDIR)/include
>  		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
> +		CURL_CONFIG := $(CURLDIR)/bin/$(CURL_CONFIG)
>  	else
>  		CURL_CFLAGS =
>  		CURL_LIBCURL =

The above is inside "ifdef CURLDIR/else/endif".  Is the assumption
here that any and all installation of cURL that needs CURLDIR
specified should have CURL_CONFIG binary under $(CURLDIR)/bin?

What does this patch do to folks who know the exact location of the
curl-config binary and have been using CURL_CONFIG from the command
line or in config.mak to point at it?  Doesn't the above break their
working set-up?

For that matter, if you do want to use a specific curl-config binary,
can't you use the existing mechanism to set CURL_CONFIG to the path,
which was invented for this exact purpose?

I am not opposed to make it more convenient but I am worried about
breaking people's working set-up with this change.

