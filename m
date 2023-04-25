Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA854C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbjDYTwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjDYTwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 15:52:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B761BE
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:52:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b992ed878ebso19855128276.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682452351; x=1685044351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eScgC8SZpuKVn91ONFO6gr3GGlfZ6MQiE6CbLakQ4g4=;
        b=PoxKvjmd+XjiwvN97LKQXWNwxjFyBwgxQGRvaH1i8pky/Q/LJu5APRuD5yY7OpeXmn
         IgIe7+BEmwPRcUlVSW1IFKPuNKZqTE4J3VCjKHyGKslOhK9OWuwJhNmTajSfZXGFgVO7
         tggneTctNmHepul5Y9wKFKhg+t3FC82MZ3W8I6zXpc2zCE0/lqfJUDc/okpo8ybMY0u6
         YgHpb5X4iqie04vKHN5oUHqn0D80nHEUe497PNjjuZk4prqym7fJUR5lnRjWewmV8Wf/
         eBjM3sk5eUJfTeu7o4rIey2TUvjoKpHC6Ba/rul/G/eDhWp3lv6j5UP5c9aUv4SEqzdS
         Sl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682452351; x=1685044351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eScgC8SZpuKVn91ONFO6gr3GGlfZ6MQiE6CbLakQ4g4=;
        b=Dr0lwui1l318gNj+tsshLJfRKqLLO1hCC7F/dWV6yw0YJ5+ttW08QMAwBW79q2Ws7Q
         2GzFERFQvSnKuK1GmlwT3DiJtVfgz0KC7e/dvVc/hiyshli8Tl5iYiTI0sgzo5nOo6sS
         CINpggsVO8s1NMp3rvnqItRI71/0ijvl0C3wJKothEJtc3uXgyBOGvpu2PxQRSUFJfS7
         Mmif7/1F4QNZQOHJ7jAl+9uRq6dOrbXjLKzxqUdWhMlvWypkD5ijnjL10pBeX3ZH3uMm
         jH8mGlFcrTQcGYb9GztAPLH9TRf8zfeo5TMqothhO0dduUpt71LTSw4f6oTW5jjLyeM0
         I6mQ==
X-Gm-Message-State: AC+VfDzE22++PkK56zH7zBnYaeJgbI/Vnxrp0EX5wRPsJWGRVgJZtT5i
        JF6zSq+liSKNv+8J3LD1Pjgm
X-Google-Smtp-Source: ACHHUZ4GwiqP6hO/WC5Zu7BIXIswNFGkc5Jzx7xcug+ri4Hm06scCIC1H1oeg12/Lx6gAPLSwn7Exg==
X-Received: by 2002:a25:d258:0:b0:b92:6110:dd9b with SMTP id j85-20020a25d258000000b00b926110dd9bmr36616ybg.20.1682452351655;
        Tue, 25 Apr 2023 12:52:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9117:8293:39bd:7100? ([2600:1700:e72:80a0:9117:8293:39bd:7100])
        by smtp.gmail.com with ESMTPSA id 124-20020a251482000000b00b9550fcb12fsm3610763ybu.64.2023.04.25.12.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 12:52:31 -0700 (PDT)
Message-ID: <5943de3d-3dad-c600-c6d6-3c10c2851071@github.com>
Date:   Tue, 25 Apr 2023 15:52:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <cover.1682380788.git.me@ttaylorr.com>
 <xmqqy1mfzvpq.fsf@gitster.g>
 <1a09d246-5750-7d98-08f7-bad6d3dee3c9@github.com>
 <ZEgikbdP8M2sDMlM@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZEgikbdP8M2sDMlM@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2023 2:57 PM, Taylor Blau wrote:
> On Tue, Apr 25, 2023 at 02:30:01PM -0400, Derrick Stolee wrote:
>> It would be interesting if we used the initial commit walk to the
>> boundary as a predictor of whether bitmaps would be good, or if
>> we should use the tree-parsing walk instead.
> 
> I think that this is tough, too. When making a prediction, it would be
> good if we could avoid walking down to the nearest bitmap, since by that
> point, you might as well have used bitmaps (if you found one before
> reaching the root(s) of history).

This isn't quite as cut-and-dry, because walking commits is much
faster than walking trees. I agree that we shouldn't walk too far
to avoid wasting time, but somehow we'd want to think about the
distance between the commits we want to cover and the bitmap(s)
we found in their history.

>> But perhaps this series gets the bitmap walk "close enough" in
>> the typical case that it's better to use bitmaps in the chance that
>> we have accidentally hit a case where we'd normally need to walk a
>> lot of trees.
> 
> Yeah, that is definitely part of this series's goal. Another framing is,
> for configurations that are using bitmaps everywhere, this should reduce
> the number of cases where using bitmaps is *significantly* slower than
> not.

It's a good opportunity to re-think if we should be using bitmaps in
these contexts at all, or if there is a simpler thing to do by
disabling them when 'haves' exist. I don't think that's the right
thing to do in all cases, but the experiments you've demonstrated here
seem to point in that direction.

Thanks,
-Stolee
