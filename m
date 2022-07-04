Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A590C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 16:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiGDQfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiGDQf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 12:35:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC35654D
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 09:35:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m2so8962691plx.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDHBx2gPpf2NSBDJ0FhCLTC7bEtEpxr47dyA5V+f1Fw=;
        b=FhJ8XLwhb+3f17CU0QXotZul2R8JswOo7cTMc9qr7MRa+u0JAD0gqf0O9/4Y90E827
         XVPJ4qbprqg/RX7y9iJqQrpmQLmYJig/HPNGKQlZpYjtVpl7vPRhJJ19mLNa95uSLL5W
         EPEIiRZl5/LRXNX6DsSLi83+LebNF8bkRdvK+leG/M8KqwyHo8ATx1AxAKw84cx0ez/J
         Twzg5aK/rQu7xFAljOhNOFJmSYi7fdUzl0Lp77Bknq8yQyF8SIZI/J377qAf2JiZwPTo
         dNVd8pQ7SB+0Nvlo1s8iq8vDlAbau9r0PAjuWclUtPs4d/SqcnE28lMXvvQJWu+VJIfS
         8LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDHBx2gPpf2NSBDJ0FhCLTC7bEtEpxr47dyA5V+f1Fw=;
        b=V8IUSU6jR3NjYJWzjucPag7R07wZLQX5V8Gdrqi0Rs+9ohg9r7qDHRE6MQ9Xpm2A6f
         e7lOUj72a3Lb8aKhruFlTRKc4M7rSG8OIukj/LGPqlVksnRMOCb/7kxwwO5gk7Syb9dA
         kgb2Dan8EDtAeeN+0K6P+gc+7Rdd5AQk5A9Ky239GYi4wSD9Xoa4POJ3R+L7NAo0+Ocu
         IPA8/Q/T9adA5sN4PLALdWfc35PBQevUEo8cMZSgFsG1mOJ4AoZ4NEj+tgfeGMeU0ZZr
         JqJbHtaO2398e5J+c6DtH1LKCR5+x4LnAjsa9iwaMVwWCuichCLQjzo4yww8QOP3A5BR
         iyvQ==
X-Gm-Message-State: AJIora9iGHJQoTlGS464vL32tNTmIPeRS/UfqzyhdbEvPb1Bgouewmz3
        ZEGMKPHchdqZlUecWEqdbE8Cq0xIonc=
X-Google-Smtp-Source: AGRyM1sguzE4WCDDhQ5N6o0RL2BSJmt/uaDFyVCG1LBrqcC+KTWmz7TsVQ1bI8SRJdMKXC77mwKi1w==
X-Received: by 2002:a17:902:ab8a:b0:16a:4521:a7b7 with SMTP id f10-20020a170902ab8a00b0016a4521a7b7mr37080505plr.57.1656952526822;
        Mon, 04 Jul 2022 09:35:26 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.65])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b0015edc07dcf3sm21408722plp.21.2022.07.04.09.35.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Jul 2022 09:35:26 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Date:   Mon,  4 Jul 2022 22:05:06 +0530
Message-Id: <20220704163506.76162-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Oops, I forgot to edit the PR cover letter!

I am adding it here. Sorry for that :P

Changes since v2:

 * Log messages related issues are fixed.
 * `pack.writeBitmapLookupTable` is now by default disabled.
 * Documentations are improved.
 * `xor_row` is used instead of `xor_pos` in triplets.
 * In `pack-bitmap-write.c`, `off_t *` is used for `offsets` array
   (Instead of `uint64_t *`).
 * `struct bitmap_lookup_table_triplet` is introduced and functions
   Like `triplet_get_offset()` and `triplet_get_xor_pos()` are removed.
 * `table_size` is getting subtracted from `index_end` irrespective of
   the value of `GIT_TEST_READ_COMMIT_TABLE`.
 * xor stack filling loop will stop iterating if a xor bitmap is already
   stored/parsed.
 * The stack will now store `bitmap_lookup_table_xor_item` items
   Of plain xor_row.
 * bitmap related test files are reformatted to allow repeating of tests
   with bitmap extension enabled.
 * comments are added.

Thanks :)
