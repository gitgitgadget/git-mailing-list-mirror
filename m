Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23CC38142
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 02:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjATCwF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 21:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjATCwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 21:52:04 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C19C12A
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 18:52:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3681396pjl.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 18:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiXkFmnVCENlRebW/jxbn8LHd7wZcaVvQjdNjsVEokY=;
        b=HytrsK1ZuVW2sItPG44W7VXmitCMNga+RvhstsBqEQywPIdtcZVqD03iYt+mwv+9vg
         LSkfE+KirvjRVs1Q8yf181OpswHGXmKcDCzz+vXQm0CuzDXlUW74T1CjpzkkVLZAc/pK
         GOqcYDEid+Yq6lVlGyyaM0qZ4U5CynSXrYMUcPWXvr09n/9KBfREBYO3/+WEYeJ/gldQ
         wGhtytenE3n09jSC+McP5VYq+10EI1xR8aA05Up2yPbCFg3XJtfRofbdFP2xLZ3Zpont
         CgZoh7sDr2UplsiPbcpV6PfqAxFtg9VAlAfdUIGwiWkp7qHeGqUTrJ7h2L5siVHu+LRR
         4ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiXkFmnVCENlRebW/jxbn8LHd7wZcaVvQjdNjsVEokY=;
        b=h23SFJ1XsY7CpMhLtG1wpjUcCfgHkBrMb57gHOhbxpJUSwQlQAsp8LajgSWelCBgbK
         2is/6JnFGv85alWcsK3p+Cy4W87JQeHHnbT2B75QHGs57iQw6B3Fg5bj3zn755p7mMfl
         y+MUjklO+hyP9Gni3twYk5ldlppRI9hHa+wRt7aSYsgfyTmiSr+3AeFWlPcg2apUX5i+
         PjmCT8tTKB9TRN2rgbvu75BpSW1vxbvvZ57h1/rriRy4jzkgm6dmWvcrPI4b/S3m31o7
         T5SQzrlJyrX6/tlpnt9eIxBaOmJtEpltmtXd0KVgM/CiRfbMwPJ2aLGWf/vvkLUB0nNQ
         cAVw==
X-Gm-Message-State: AFqh2krV5VaYpWpLbLa9sZbM1WugiXj/wR/rKbNExV78WnM9ndcOjLF5
        VJG5eBfvGxvoMQEnmhHAXRc=
X-Google-Smtp-Source: AMrXdXt/mfQz+S6H+hJJ37tfBDNuZGEetZGiaGMq0wn8+KTktrtlJ7GFZKyleLtio9Yw8+Pcf2Y+FA==
X-Received: by 2002:a17:902:8a98:b0:194:9c0d:9732 with SMTP id p24-20020a1709028a9800b001949c0d9732mr13583242plo.46.1674183122664;
        Thu, 19 Jan 2023 18:52:02 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm3626527plg.134.2023.01.19.18.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:52:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <jeffhostetler@github.com>
Cc:     git@vger.kernel.org
Subject: [CI]: Is t7527 known to be flakey?
Date:   Thu, 19 Jan 2023 18:52:01 -0800
Message-ID: <xmqqtu0lzzn2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The said test failed its linux-musl job in its first attempt, but
re-running the failed job passed.

    https://github.com/git/git/actions/runs/3963948890/jobs/6792356234
    (seen@e096683 attempt #1 linux-musl)

    https://github.com/git/git/actions/runs/3963948890/jobs/6792850313
    (seen@e096683 attempt #2 linux-musl)

