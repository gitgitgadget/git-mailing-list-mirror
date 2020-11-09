Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10ABC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A18206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRId7RoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgKIVBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:00:59 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C74C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 13:00:58 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w145so11751157oie.9
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9/EmHm/ONRTg103YgT4N1nZHH+ThGutsFDxSf6jww6U=;
        b=oRId7RoG6t3PDEPiprSKQnPnXbLf7qtoLJmUem37TF2Ix48spdXIxHD87qjAEHBUK3
         oUOP5YjfcoACdAA7Ip1L1TwzK437KviNkEfyVk5FxENe1hFY55mRkpd3U7teqlJ0L/sZ
         Te8XiYpu8kxRvgD7Edtx0BoQqPBEoRs3TK6i3STpDWjjb2T7fuJjPjTAHc678lEJ9O3C
         x2gevrXYT2MRKZm4yNK44AH8l4ZNO8y7MwhvrQOrA4YvQWi6hFFsezzZwJ2Jk9ehqNXK
         lN9zroB5u+xiUZA0MYHMrx1UpINlAT58/8ydYW7RcJMvgARdDQqxEzK+TLlTOhwS+rk3
         dCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/EmHm/ONRTg103YgT4N1nZHH+ThGutsFDxSf6jww6U=;
        b=DfkoixqUOI4reDJjwoVX+jvpqih/LESo3/eeotETnAeZhWhkS6BJmk+8wT0odVV22u
         9A40++3n3u7m2ivWO529w0KNhGR08T7LjOZ0bx2xJhH5KpWoEt72EyFMbf2TxBWYfIfF
         fwUTOy4t4CdnRTBwWlsQYEuTXjkjuJ+/mMS4D3iW+Q+51ylKS9ihrN3cJL914s7uIbIk
         QUvfcd3swWC7uBQEAKB82QLzk/lOvzVi35cE07CjIrVihymPP48tSO8aDO8Cp2ALgCb7
         cB6Ifs2S1j+dHsJx+LwJk1hXq2z4C6yCDgoFx5+Pk0ivdD7OLfyOyMfm4zV0knXQ4Vm9
         a8KA==
X-Gm-Message-State: AOAM530qDTEeHVHQWcbBdAagy4gNGFcFwhKHcjq0qGExsr57NkoV+bUo
        c+K7jfEIDBFVeewvH+sfsts=
X-Google-Smtp-Source: ABdhPJxYGjHlcWw2bZDFiHbtd/pD6uqSb8VJ0kN03RX4qm4PwC+J4eh910W4KadSDHGsaHn4R3IPCQ==
X-Received: by 2002:a05:6808:56a:: with SMTP id j10mr691925oig.121.1604955657658;
        Mon, 09 Nov 2020 13:00:57 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:d10d:26c3:9580:8dbb])
        by smtp.gmail.com with ESMTPSA id p128sm2637818ooa.14.2020.11.09.13.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 13:00:56 -0800 (PST)
Subject: Re: [PATCH 4/4] Doc: push with --base
To:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Cc:     peff@peff.net, jrnieder@gmail.com, git@vger.kernel.org,
        newren@gmail.com
References: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
 <20201109195630.2511149-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d72de441-e7f4-347d-e37a-e8e530855821@gmail.com>
Date:   Mon, 9 Nov 2020 16:00:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109195630.2511149-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/20 2:56 PM, Jonathan Tan wrote:
>> People expect that a single repository at their hosting sites can be
>> used as the central meeting point for the project, just like CVS/SVN
>> servers were in older world.  "git push" would need to accept that
>> reality and start common ancestor discovery eventually.
> 
> Thanks for your reply (and everyone else's). I was thinking that a more
> rudimentary form of the feature would suffice, since I wasn't expecting
> much more need in the future, but looks like this isn't the case. I'll
> be thinking of a more comprehensive idea.

I think this "half round negotiation" idea you have has merit, and can
get us 95% of the benefit that a multi-round negotiation would bring
without those extra steps.

My concerns with the current series is that it isn't fully ready for
even that case. In my mind, a protocol change like this would need:

1. A top-to-bottom implementation that allows a user to opt-in to
   this new behavior with a config setting.

2. A demonstration of situations where this algorithm out-performs
   the existing algorithm (i.e. client is far behind server, but
   topic is a small change based on something in server's history)

3. A clear way to handle odd cases, such as multiple merge-bases.
   This leads to a change in how you are sending the data.

Perhaps this "send multiple OIDs in a payload" is already half-way to
implementing a full negotiation, and we might as well go all the way
in the writing. I expect that sending all maximal merge-bases will be
sufficient for the vast majority of cases, and so any multi-round
negotiation process will almost always end after the client sends that
data.

Looking forward to your next version.

Thanks,
-Stolee
