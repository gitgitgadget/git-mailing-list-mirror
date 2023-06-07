Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76531C77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbjFGNeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjFGNeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 09:34:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7881993
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 06:34:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56ca07b34b1so1578667b3.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686144842; x=1688736842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ipY2nq/WDB+wSclv/IzMZnWTqmu4fhJl7uem6qhmcA=;
        b=CNx3mvkIEaqM9ZRFl0uZ9WKOvHa8f2UtAjpH6IKpKnCwkpl17h10o1lQ3JSAvAT4ZY
         6jVlFHT28AqtH1GFqFuCGUcnyIHHdIYaQJ25gC23OqU7j8h/4Sb28FBMpnCwz3m+6otP
         tt0D+OJGNNTFWRxfWQmKZXrjSq/anjoIyJPvkG5bMQ9u4mxmmSZkGOOWUlOGe5U1zhPw
         SyrHeV+iJRgUmgI0CvsUID/jIDbm/Y0Mx7SDVD3r+cp7lhuGHPTzz0Zt/NuLjXgimYx1
         uO6VP8wSHPWQnJ5izhkVzGebxXOHWPTfLvi7DDXjcj5ejtmCEU+NDfBeMAzVEZ/psL9E
         kjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144842; x=1688736842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ipY2nq/WDB+wSclv/IzMZnWTqmu4fhJl7uem6qhmcA=;
        b=fXjpD9K712eoO0NYnAgwm1h9ODDoLe58pK5o1p9PxwqZzDBnwogNwOTuMphfuAne9z
         zLhIfH8+ZpAntBTCEztEHgnZfKISKBixDsgncBABAvoVia0lFvBBOf5v1tTWVHmLDwvk
         iiZQZlnUBH5HKC71l8CM/bltB/Log3QHmgVTnv1H+mBEhwl1jI9QOfV87KqW4TFJTnTk
         zidouvkjZTZ6jV04Hu8Pgc7VCJEkdRdiyz8ULuCRTf5z9gdwke1uZXeOj2+eQf/fFhbE
         Ca7FFi7AZ8/1OMoKrTqTFW9Tu15OphjWvQjnq1tF84hKN4n7ukFckH6NnQ1g85ugN6Fr
         6PLg==
X-Gm-Message-State: AC+VfDzx5WDhVbM0vGc8wmuWOFurvKRvldtd9F481PftN9NSG1peDz4S
        IpmqUYVztvK5ZjjSkWqI94cY
X-Google-Smtp-Source: ACHHUZ6O6W+Wax8AL+hTGyNzPAgs+Ds2i7GDZNXEHZ+IXiFQC2SB2Z3P9Rv/bM6QwEMYiuHsPATbbA==
X-Received: by 2002:a0d:e0c1:0:b0:565:eee0:6ad7 with SMTP id j184-20020a0de0c1000000b00565eee06ad7mr7146222ywe.32.1686144842263;
        Wed, 07 Jun 2023 06:34:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ec69:1775:6713:a647? ([2600:1700:e72:80a0:ec69:1775:6713:a647])
        by smtp.gmail.com with ESMTPSA id w9-20020a0dd409000000b00569e7cbcd56sm1224260ywd.69.2023.06.07.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:34:01 -0700 (PDT)
Message-ID: <4b0e8026-4372-67ea-356c-b8073a6da20e@github.com>
Date:   Wed, 7 Jun 2023 09:33:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] add: check color.ui for interactive add
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
 <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
 <a76a91a0-cefe-807f-f1f6-4a277d724630@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a76a91a0-cefe-807f-f1f6-4a277d724630@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2023 7:09 AM, Phillip Wood wrote:
> On 06/06/2023 15:20, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>>       -+    *** Commands ***
>>       -+      1: [s]tatus      2: [u]pdate      3: [r]evert      4: [a]dd untracked
>>       -+      5: [p]atch      6: [d]iff      7: [q]uit      8: [h]elp
>>       -+    What now> status        - show paths with changes
>>       -+    update        - add working tree state to the staged set of changes
>>       -+    revert        - revert staged set of changes back to the HEAD version
>>       -+    patch         - pick hunks and update selectively
>>       -+    diff          - view diff between HEAD and index
>>       -+    add untracked - add contents of untracked files to the staged set of changes
>>       -+    *** Commands ***
>>       -+      1: [s]tatus      2: [u]pdate      3: [r]evert      4: [a]dd untracked
>>       -+      5: [p]atch      6: [d]iff      7: [q]uit      8: [h]elp
>>       -+    What now> Bye.
>>       -+    EOF
>>       -+    test_cmp expect actual
>>       ++    test_cmp actual.raw actual
>>        +'
> 
> I know Junio suggested this change, but I'm in two minds as to whether
> it is a good idea. The reason is that we're no-longer testing that we
> add "[]" around the text that would have been highlighted if color was
> enabled. That is with --color we print "1: status" with the "s" highlighted
> rather than "1: [s]tatus". So while the revised patch tests there is no
> color in the output, it does not test that we print the output correctly
> in that case.

This is a good point, and something that I somewhat expected to find as
an example check in the rest of the test script. I think the color would
be disabled if we didn't do force_color, even before this fix.

However, I'll double-check that by adding a separate test for just that
bit of the UI, keeping this color.ui=false test focused on the color side
of things.

Thanks,
-Stolee
