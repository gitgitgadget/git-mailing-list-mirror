Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B4FE75428
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbjJCHCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjJCHCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 03:02:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA6359C
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 00:01:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so5829131fa.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 00:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696316465; x=1696921265; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPOPUJjYiGM7uGCKZ3fc+QYXEtUvbiMzTLdQ7JrVaiM=;
        b=V6RQQHR8jVWfRC1lSS7r1vehM8w/YgeXzQQRc0nnGWgG4n7nue1xJq4KVxddcYXBRc
         rRZqxxr3HxJqUI+xltAL4nm26Yu86ywSJhmmaP/HWTeoV66j22Q4NbBu5RHyfiiGEpHE
         l0sq3SLv6m5qQoZxhry+KovIGpaV8RhapjOQktnSTc4/CpqRIzPVS12Avt7/c0kr5SY0
         rbVnpKFLND1li0vvnShzY3tPKo5N0MTtNqGtthon9hCxcoy62SL4BZjWEeZzH/jya9jU
         uxHbsxJyrtJSTwMEunkU5okKWCkYdDxxNVe5Epxg/7ecn9nqyRafTuJr/dvukCZUCymn
         HgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696316465; x=1696921265;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPOPUJjYiGM7uGCKZ3fc+QYXEtUvbiMzTLdQ7JrVaiM=;
        b=GxMLvBxugoCbh7nSqNwhOPJFEBSnfdmik9YJbT3rzWSEy1G7+Q8W+/08Ye/MAINPQF
         hJtddwYA1oAuGt/M4eyl24ccwxPFxNPPFKPMb+ulCS2E6t11D8HCv2O9eVdATHkIwBhO
         oBxrn+0PITPwzlp4Rx2POD5OaY/036a0k3M+aGPYv1koyWG7tgVCvl/vkUH1xP0q8Mxd
         6tZxAy0qgWDzlon1/NZhEB65hnFAuHq+9aXZZeTPFLNp1eFWYJJBxEWxkuYGi/fCG6dv
         DhT+VjCWCWCQt4gXvpYngghsjdtVcKVrRm7UhM10eT7ApFpWgFp5qjWYk7tnHtEE+Lkc
         7y0A==
X-Gm-Message-State: AOJu0Yybc/qdMaiGTZ7l5vJkjo3MDWUz/ABZ+bSlSWe5OEdbHexlYxM9
        bqzAHQGgOT1sduDG181in5SdzP8VCjw=
X-Google-Smtp-Source: AGHT+IGd5hRNOSyA1Pvlq0As92pPU96tCCM/B7Oj/9qzVG3WxbZmNlYuJvFHWKo1CbjUNrW9EGt4PQ==
X-Received: by 2002:a2e:93d7:0:b0:2b9:4413:864e with SMTP id p23-20020a2e93d7000000b002b94413864emr10308037ljh.53.1696316465270;
        Tue, 03 Oct 2023 00:01:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e8544000000b002b6da7e01d3sm116272ljj.31.2023.10.03.00.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:01:04 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
References: <xmqqedic35u4.fsf@gitster.g>
Date:   Tue, 03 Oct 2023 10:01:02 +0300
In-Reply-To: <xmqqedic35u4.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        02 Oct 2023 17:30:43 -0700")
Message-ID: <871qecgpg1.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> * so/diff-merges-d (2023-09-11) 2 commits
>  - diff-merges: introduce '-d' option
>  - diff-merges: improve --diff-merges documentation
>
>  Teach a new "-d" option that shows the patch against the first
>  parent for merge commits (which is "--diff-merges=first-parent -p").

Which happens to naturally mean "show diff for all commits" for the
user.

>
>  Letting a less useful combination of options squat on short-and-sweet
>  "-d" feels dubious. source:
>  <20230909125446.142715-1-sorganov@gmail.com>

I believe I've addressed this in details in my reply here:
<87o7hok8dx.fsf@osv.gnss.ru>, and got no further objections from you
since then, so I figure I'd ask to finally let the patch in.

To summarize my position here, "-d" meaning "show me *d*iff for all
commits", as implemented in the patch, is very mnemonic, has natural
semantics for "-d" in the context of "git log", and is straight to the
point. Therefore it is indeed short-and-sweet compared to the only
alternative proposed: "follow first parent only while traversing history
and show me diffs for all commits", that would indeed need a different
short-cut, if any.

Thanks,
-- Sergey Organov
