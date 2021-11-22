Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5014C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKVHuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhKVHuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:50:16 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D05DC061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:47:10 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x131so15310177pfc.12
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 23:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QgHhazSZRfWOqcFXuPj0B6wmYBgdMXU2Oc/hb3wWBR4=;
        b=KuxhZBDfH5VKYwqhhG7CU824IR9zVinDL1qVUZFw+k2cUPy5V4xSRrP6uvMFqJQfLW
         kSgKHGfoFZjYTQc4vGrvZ1FS7W68qB9X9A8V3PJGpEL+wD4MQ/W2Zo9ucViiksa6Eqif
         HmYzxSH3DNdIPFeKhHGh3JLhKVrcLGqBw4lfUff6fylFI/22UL8NSOHbUDR4Rc7Wqwce
         ZmNyknrbTElqHHMBAtBEe6SpGZrtpZuzarv16hHfGzdjuvHrP4eUyimQK7UVTohB2usA
         /AXeP1ijQnYmx9Fq9Lsr7UY4evCvXK4eGVLdYpcAupe2pm/6DVBIuGfkKTd9rH5ZAtDQ
         oSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QgHhazSZRfWOqcFXuPj0B6wmYBgdMXU2Oc/hb3wWBR4=;
        b=X0LJoBg8BOA1dka1Kebk/N7aqPPtcDnUzbIUUoG1i27sMeNvzkkoJCTQm5/4vbeMct
         rmCEirsgfmUN3UPN5safhzqwbcTVsqgBBBiu2z/DzA8K1IefuTm63GqEFYYVBpiysUPB
         ZyfH50JNsFlqXBWrTw3YXRGubKBbo3Is9APWVKSeF5bKVHzc0E6XQMVh0I3s2F1LigEQ
         a5oxrQ6ciAvfwLEgxgLegdOonS1B/+M3xLTk8ns/5Q0EVlEnPJ7vZstE3yJ9gG45uVKE
         UQ0ZlMdW7A+WMJ1dXY/uqKyg7BiuQUzCYNmnzYupUF+WfFD5ETCcGLzUZySgyUTIkiE+
         LODw==
X-Gm-Message-State: AOAM531dcq9qPmiY1QDvOsgb2ykYeILw4KOPgiqom6TnIpwDztXBupX7
        TTE2+ThTeGAIJI6Eh6Vv5K8=
X-Google-Smtp-Source: ABdhPJzo3xHsPr1vB0qX0VO7uUM1jC9WOFFpHuSs3SfcBbme46bBEKpirclG02GVdTBeiZE+pWveqw==
X-Received: by 2002:a05:6a00:b49:b0:49f:bad2:bd7c with SMTP id p9-20020a056a000b4900b0049fbad2bd7cmr83501784pfo.64.1637567229549;
        Sun, 21 Nov 2021 23:47:09 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id x9sm14687717pjq.50.2021.11.21.23.47.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 23:47:09 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     congdanhqx@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 1/1] ls-tree.c: support `--oid-only` option for "git-ls-tree" 
Date:   Mon, 22 Nov 2021 15:45:38 +0800
Message-Id: <20211122074538.87255-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g438dd9044d.dirty
In-Reply-To: <211119.86wnl42ri2.gmgdl@evledraar.gmail.com>
References: <211119.86wnl42ri2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, 19 Nov 2021 14:30:52 +0100, Ævar Arnfjörð Bjarmason wrote

> Please don't add the Reviewed-by headers yourself, either Junio
> accumulates them, or if someone explicitly mentions that you can add it
> with their name it's OK.

I think I misunderstood the meanings of the header before.
Thanks for the important tips.

> Better: "Cannot be combined with OPT."
> Better: "Cannot be combined with OPT or OPT2."
> ...
> Better to preserve the wrapping here, to stay within 79 columns.

Will apply.

> Just use:
>
>     test_commit A &&
>     test_commit B
>
> etc?
> ...
> Stray echo? Unclear why this test setup is so complex, shouldn't this just be (continued from above):
>
>     mkdir -p C &&
>     test_commit C/D.txt

> To test nested dirs?

Will apply.


> just cut -f1 instead of awk? Also don't put "git" on the LHS of a pipe,
> it might hide segfaults. Also applies to the below.
>

Will apply, and could you please describe the problem with more details?
(appreciate if there is an executable example)

Thank you.
