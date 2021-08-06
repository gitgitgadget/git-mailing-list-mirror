Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFDCC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6181A61163
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245030AbhHFUke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhHFUke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:40:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3190EC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 13:40:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ca5so18425031pjb.5
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9uIhqhtUxB/2RpKQoM4aILqXEFoH5zJn3S2s5hCeWEU=;
        b=TH/Br3xCUOXk9MKWXmWk7G+aF75UpVqZIBLN4GxEj1pC8YomSFhFcsA4V5pgyEqwPC
         mfmIBvybIIPPyuEaM/ATFQD8aEybQKYXI7e7NLZCz9EYla16QhhyFzEuFcLqjWqbmnfJ
         dvYjW9/o6HWxaUa6O5/9UqMbWcpdygQMu+VBh394PN50iLLwNiGjhqKhBepFaLnnoOZf
         asn6bw7lY6wnZhCIlYOgVUaTK7PzGR6wch7WzUFZ/QhL6GbkVSdoBNKcGl8HS6W8FvG8
         oz3Lq1uscewfbc/JbUpzDdXA545Kglj55Ifjwv6/+BOwkKG89ZVDF/wLdjII9pqt1dht
         jjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9uIhqhtUxB/2RpKQoM4aILqXEFoH5zJn3S2s5hCeWEU=;
        b=Jwj/59AdL6hQ4zoMmRZ38b2quPIFaUx9TXSvrZXCZ4j9cA8xDAw4cPXaqW/Q/IQTU3
         JVr16hOxR142RLLEuYMY0ihRb6mWUB9zlwnJfzuJ6QX3gzzYAD/fFBZ9fqdDa5Phyn3U
         a3SOFnng7sHtEc6XEQdNUKpqhylZ3F93jtahgjbRmJhcDsvzkPg/YzFkqhOjIqDfX4X5
         sEEusbgm7yP+7/dkRG5zKStPU/8gjiQ/knW5tJYt6LVF8oof8tbqXj4p/VhIJVhojuzC
         BEVUBag1REO++BA7qnDnzjqcsrAG1FYSqr6m1Q4GDa0dLQXapAzLyooveo4CL3PYsERL
         I/9A==
X-Gm-Message-State: AOAM532saJWjgNj9P1KY2Qyd2u+oV0e4+YRpdbB8VIOnMl1X2vFfWNwJ
        98YJ6xaR49pVJFdWghB3Ci0=
X-Google-Smtp-Source: ABdhPJx9CG72ADElRi5Y5vRzRx1nVUkNesbWiZvCFX7mNsnj7wpOytsBpYQzQvEgpX7wcRog+I8h+w==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr4252354pjx.111.1628282416744;
        Fri, 06 Aug 2021 13:40:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7578:9c9b:8fe8:cece])
        by smtp.gmail.com with ESMTPSA id i5sm13513437pjk.47.2021.08.06.13.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:40:16 -0700 (PDT)
Date:   Fri, 6 Aug 2021 13:40:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 00/13] Add bundle-uri: resumably clones, static
 "dumb" CDN etc.
Message-ID: <YQ2eLRjMRnVpdGVZ@google.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <YQ1JW8hHmG8B/oE3@google.com>
 <87h7g2zd8f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7g2zd8f.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Or perhaps not, but they're my currently my best effort to explain the
> differences between the two and how they interact. So I think it's best
> to point to those instead of coming up with something in this reply,
> which'll inevitably be an incomplete rewrite of much of that.
>
> In short, there are use-cases that packfile-uri is inherently unsuitable
> for, or rather changing the packfile-uri feature to support them would
> pretty much make it indistinguishable from this bundle-uri mechanism,
> which I think would just add more confusion to the protocol.

Hm.  I was hoping you might say more about those use cases --- e.g. is
there a concrete installation that wants to take advantage of this?
By focusing on the real-world example, we'd get a better shared
understanding of the underlying constraints.

After all, both are ways to reduce the bandwidth of a clone or other
large fetch operation by offloading the bulk of content to static
serving.

Thanks,
Jonathan
