Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D48C433FE
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 03:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKYDqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYDqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 22:46:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944582A727
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:46:46 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h193so2916803pgc.10
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7nYRHkAT+cfBVTh3dxRqSOZs5vMlHtCbsGhPgbKF+w=;
        b=WmZWjyAV3qruQsI1wSv1icpMpDdLGqi77xYDnB611hD2LV14fI/on7CDEj+seGFgzq
         ChsllLOHxUtI24IPHMQX8jGKpXC5l7pR7NpnmOvtB4yjlaqr4r/Wkcu3yZAV1glVecA4
         cukYLNgeWyz3IGYMElmlJ6pAg5U382HQLeNGu97id1EmmYipa2UGiBpTE2nvvN9WDkGi
         swVuRs8LWlTqY3py3i5RvggYNH93OBinHwaf8wvgCBItwxT6lgjrMozFU7LuEnkbDWBT
         AmeGTXzoha0zU1bQ8snodusXz/BU3XviC5PdYQz2U8Iy7ebd/HB584v5mESFqpUzWcGo
         Qhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7nYRHkAT+cfBVTh3dxRqSOZs5vMlHtCbsGhPgbKF+w=;
        b=0INrgAJUM1awSzg21pDZsTHOoTdhCMjp+6TfJnLZn3uErR+HUHTc7s8I64dHu11O0n
         SxQs1q4CP5cOTm/Qab/g9ttVfsty7CI+p3LD2zhZ7IlOfPe2e49zZct2GJcm9UhT5uAE
         HW+PXCHfPQm5bUmXWawlLdUGWaPBGiFVhIfD0Jzy6Q8BqD/SgoqFJKlMe/MdJHdcR7Fv
         lf4N3xRKowQ93qC0fT7vctNZBaSphI1KQVBDq3yFJ2WjUu9B/hUPSuBvmtD0jX3RFujK
         UOZIecRl8tueh9Pom06vyfcKztBeobcohqvWKlEiBy2UfuS53//2nnO0CMbq32YdGH09
         YW3A==
X-Gm-Message-State: ANoB5pnpTeL3JBvwQjcMQcNKIPZGcAMpZNNu6cX1SMslIEhbxoyFkaSP
        2SDzDwvlu5XPB6oTE7+PWKuBx0lHdEDNLo9mGUw=
X-Google-Smtp-Source: AA0mqf46pacTIx6UQDMLa4S6JRsFyGi8kQ13rN4HJjrwBgo5+Dz0dwO/L6kjhaVn0yZdqNpMs0JUD1FHcL3Oqsfic/o=
X-Received: by 2002:aa7:93b4:0:b0:56d:1fdc:9d37 with SMTP id
 x20-20020aa793b4000000b0056d1fdc9d37mr16795705pff.77.1669348005881; Thu, 24
 Nov 2022 19:46:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com> <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net> <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
 <Y37EPdUkBhsSPmRD@coredump.intra.peff.net> <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
 <Y3+b80Vb2/6lKQ40@coredump.intra.peff.net>
In-Reply-To: <Y3+b80Vb2/6lKQ40@coredump.intra.peff.net>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Fri, 25 Nov 2022 12:46:34 +0900
Message-ID: <CAF5D8-ufUcCfQYMTTRwD07p7+37OBC4zkiWmAa5n1P5pL9EtOQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2022 at 1:29 AM Jeff King <peff@peff.net> wrote:
> Those are the three tricks I sent in the earlier email (though looking
> at it again, I think the single-quote bits need to come first, so their
> backslashes are then quoted to protect against emacs evaluation).
>
> It's all quite confusing, which is why I am OK with just skipping it for
> now. ;) The nice thing, though, is that doing the quoting right means
> it's safe to get rid of the "cat", which solves your race problems in a
> more direct and robust way.

Thank you for taking the time to explain the details. I don't fully
understand it yet, but I know it's hard to deal with properly.

In PATCH v7, I made it the same level as the vim version (although it
is not strictly at the same level because there is a Emacs Lisp processing).
I skip futher treatment of temporary file paths.

Regards,
-- 
Yoichi NAKAYAMA
