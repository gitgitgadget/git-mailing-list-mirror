Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EEC47080
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22391613CC
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 01:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhFBBTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 21:19:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB5C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 18:17:56 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q10so835029qkc.5
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yI6IARJVEYs7nKUwEPqe/2WhI0/9YGRb2CnAKxJow3c=;
        b=R/dWznpAFG5L6YvZHmBY/w02DE8tkNHjniumJi8+8gsAmfQG9sjxlFbjuFl3IVjg3G
         nqbLD1Qb2iBD9KelSgGFyp/eIVZSKJIrReG+vhqg7OMiw/FfLUaJ7DbutcM2WcgIwWKL
         4/Pl1qYpTHZKWbvcX/4jTPzLsR8yRa7SE8kHWEEZfn7Ln0JLrsS3DoCbrFaVhOHyHC5f
         D2IVcgwMTAfIxPA8qMjQfw/5ZJd+dhwI1nsEbHkupPX25rqIzDuH7l7e1ngBy9I0OXYt
         zxc85+1rXbKhlwF+FW49Wl0LRgZIza4j5JGQbYISHFUPyj7mm1kv427nZfKNA9CG7iZG
         95uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yI6IARJVEYs7nKUwEPqe/2WhI0/9YGRb2CnAKxJow3c=;
        b=SdVRl+ccOOOYTbLzmsAdxoVBiL/gB/ur03/jVY5e3fiNtSbo4VTTjIaNkrSInGJ6vR
         sZl95k5k105DCx73moMfSAqj/Lm+V0OPR7Rj+AjOvg2IA+NxU93vAqnKwYMIgOCr04Hq
         oBYenans12y9oXdeNVcXwd8Ua9Og3js5WGTaxc0fQj5R4SILi9jqKGMO5ygBnc0fkHyA
         UKU2o2IszfbfOKErd96dHHa9IjLedEWslt95xPMkz0HDjM7dwwiT9as+ru7e8+yVnYbx
         p2EQimaDyk1efFJOCIin60nx7rcSI55eh8H01xdFlBKVA0f2/Z9gaexakMUgyv4ytA6b
         r8tw==
X-Gm-Message-State: AOAM5327lzcqYLAMPnHWi32TstoWd63bJnDgjoOrAlnYuqGfN5edgvJG
        djJYmImtWZ5RHQyr/jbYT+xN5QlWB7GwwA==
X-Google-Smtp-Source: ABdhPJzorCEGcAIA/nxzUwGTQ3CMgTHqiEbNefASk1VRYnhurcQgJSPAELPbPID9kuRGc7WyLY757g==
X-Received: by 2002:a05:620a:568:: with SMTP id p8mr5149677qkp.187.1622596675689;
        Tue, 01 Jun 2021 18:17:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:35fd:75aa:3890:f004? ([2600:1700:e72:80a0:35fd:75aa:3890:f004])
        by smtp.gmail.com with ESMTPSA id d136sm2408419qkg.9.2021.06.01.18.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 18:17:55 -0700 (PDT)
Subject: Re: [PATCH] config doc: indent descriptions of feature.* variables
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com
References: <20210602001132.459705-1-rybak.a.v@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <057126a2-81c4-41cf-e41a-52a24a0c9a52@gmail.com>
Date:   Tue, 1 Jun 2021 21:17:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602001132.459705-1-rybak.a.v@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2021 8:11 PM, Andrei Rybak wrote:
> Config variables feature.experimental and feature.manyFiles are grouped
> together under "feature.*".  However, this is not easily visible when
> scanning the help page of git-config.
>
> Indent the descriptions of individual feature.* config variables to help
> the reader distinguish this group of variables.

I'm not sure how these extra tabs help in the rendered text, or in
the formatted HTML output for the git-scm.com web page. I do believe
that we would want to re-wrap the paragraphs to ensure we are not using
too many characters per line.

Is there precedence for a simple tabbing like this? I was able to find
a similar grouping for advice.* in Documentation/config/advice.txt, but
it uses a different kind of grouping. Perhaps reorganize the file to use
that strategy instead?

Or, perhaps just point me to an existing use of this pattern.

Thanks,
-Stolee
