Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED8C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjASXeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASXeR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:34:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AA793734
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:34:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e3so3365183wru.13
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmjzt3/xJOdH5KRYFHIyfnIebe4wTAd/HSB0A5PHDxs=;
        b=nBd0x7wUZut2uWc7UQ/6pR9AyYph81GyzxY6wqOV4lXbIrx6YBXoh8XVN05XcLtLWP
         D9xXpTupcJ9PqsbbRYIg2EdHVTwCD2E7KujitP1YzQarTLjMRig9E4q83ZqtjvOxCePe
         vbdZBqVnz7PWdOjco9+43G4nrpY0wVAEuZSUj0cObV3n4vdUs+Ov6xwpu9hJZDgL0b9t
         gjosJXziyUT9AP30bviURGbN1zUJRHM9sto78RfHdgNq0bYsCW8W8CdyqZeItcXsaMZn
         DHW3wAzUgRkq82HMQAQrmNeM7+CLnFAGdFgzVyNw1mygTtL9mlwOBBy9eS9hJiJQ0WyO
         aYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmjzt3/xJOdH5KRYFHIyfnIebe4wTAd/HSB0A5PHDxs=;
        b=mcgkEArHAozP7M/85uASQTa42HdnEvdCR99/eXdBSzzjbUg6GX+oGYp38/2XYTxuXF
         pMZNMLsOuhV1IhX8bBxjiKNnZGFvV+ynsEsGZNWdTqHiAb4YBnicecZNXk4Tc6jzWwUG
         07cIVvTbszva4Hr7kBIY5X8iopxnddEKz4xUbRIQyFcXjlZIgKcIe3zeFzOWLDqJ5zb4
         nhct+XsBnXsFzpKKK5Fa5Ged7CcVSU5joo8I+ITJ624gNsJKuIdXPqYJfo01eOywMTcj
         2wWDdpYW8xao0u2WOesLf3xBEDuDytb20G5Rgh6t/AFJEA57t5QC8sfkkcXTA1JebM7p
         b/YQ==
X-Gm-Message-State: AFqh2koEWDl4gtugnNfLIGoFn4SNo3rXYL+ka+3oGIeKeT8btLUTrLx9
        aj9fTTRzkm6NF94W1LIGJCGAxX6kE04=
X-Google-Smtp-Source: AMrXdXv+p9UiXmsrqqqvEWf6DWFR0O7dwB/TTHOCEXFjL3kkIm5Z3zGTqWsU7Bh04gbTssaZ7GHEAQ==
X-Received: by 2002:a05:6000:38a:b0:2be:4c32:a7df with SMTP id u10-20020a056000038a00b002be4c32a7dfmr2523039wrf.63.1674171254545;
        Thu, 19 Jan 2023 15:34:14 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b002a01e64f7a1sm11330525wrb.88.2023.01.19.15.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:34:14 -0800 (PST)
Subject: Re: [PATCH 3/3] branch: rename orphan branches in any worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <a47ff192-db67-dc4c-ded3-cd1e7c197726@gmail.com> <xmqqedrq1a7h.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <527f7315-be7b-7ec0-04fc-d07da7d4fefa@gmail.com>
Date:   Fri, 20 Jan 2023 00:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqedrq1a7h.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-ene-2023 13:33:06, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > +	if (!copy && !(ishead > 1) &&
> 
> Logically it might be necessary to be able to extend "is that branch
> what we have checked out, yes or no?" bool into something else that
> can be something other than 0 or 1, but as soon as you did so,
> "is_head" is no longer a Boolean "is it a HEAD, yes or no?".
> 
> Now what does that value really _mean_?  Please rename the variable
> and helper function appropriately to make it clear what is going on.

The idea is that an unborn branch needs to be a HEAD, so (head > 1)
codifies that information.

As I said in another reply in this thread, I'm going to reroll.  I hope
to make it clearer then.

Thank you.
