Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AECC6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 23:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBXXgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXXgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 18:36:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069CE3430F
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:36:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cad819c7so15267757b3.6
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 15:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJ+LoMOE0bOqp3e/LaG7CI3QpcP9zVqoqTqoEg8tqVA=;
        b=ddEuBOpAlaGYZ+ejSVVhw0x0xetYJvUjNWbRwILsyeQdPu1RHIaZb/Rtp7xKDwAiep
         WngUYq3AW8aKpl8hv1qvrYxA9EpyGZv7jKxBrsXiTePylu5/lCd4WA1q9pk1zprq2MHr
         fTYc0D+Tkw9hLGjSWNzOI/ZOZ+JA3vZUG7a4+dTrFUjVnrDnXsxMLQ0EuP8Y8yT4b54b
         mBt6UJXJfPpCQ/8+EOMRouQI42uHnuWEp+G3NlHaFWXddH90JM7e3hZ5x4qIwSO9gJki
         uIA/h8DEGXtueaqkyvHXKTm5MxA+sGJn+Eojl4LdGPOY60NjyEWEBF6yHpQux+Ue3y+M
         s2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ+LoMOE0bOqp3e/LaG7CI3QpcP9zVqoqTqoEg8tqVA=;
        b=Rh3z+5kocOsyyLyB4+Uw0vDq+2WLXo5e6uKoL/ymljdak3TEqqRKiWbBykzXhM+BVu
         Hfq43Cr/dxOnLTHoK7JXkrHDSB+710Zlmzt64cmmiXRKJwKzE8iXil3u3xn7faN16NQT
         rxtiPsNekLwo8BkGRw19aFiOevyrOW+V7IHB+gwNprnt2IYp5/d3Ricfk65jQIgL3gha
         8ELqPHCclkAluFKKXC/+wYZtK0U/vmeLkcyFnq0JDO8hVXWSA8WCcj3z/MQAh+S/WXJa
         CC+4+gfvzWPcfjhAc+trCM9wTluRhFTLEKhBQq7RSK+ov+aqFFQSOVH0yEXVV1LTHaAo
         M0pw==
X-Gm-Message-State: AO0yUKVv/QoMWsiJ8Dn2EZL1vnb+Seb4VMK89uyE+Ppf1Z0nVb8DmJgK
        pHUHsAy2bXxMNXw4hhlRmE/6UQcUN0Ut/pFSCus7
X-Google-Smtp-Source: AK7set9zo4o2pD7GZD6PGO0V+Q8aCC9lHOqDG5pCdQyZCb+AhVtPlVoO93pPmDP5dhy2OXVKDucnO/6cLZwAx72lRJgf
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:60fb:bc56:6979:1f96])
 (user=jonathantanmy job=sendgmr) by 2002:a81:3e19:0:b0:535:1677:8d4a with
 SMTP id l25-20020a813e19000000b0053516778d4amr5828268ywa.4.1677281770269;
 Fri, 24 Feb 2023 15:36:10 -0800 (PST)
Date:   Fri, 24 Feb 2023 15:36:07 -0800
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224233607.2040752-1-jonathantanmy@google.com>
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> I wrote this patch series about a year and a half ago, but never submitted
> it. I rebased and updated it due to [0].

[snip]

> [0] Search for "Extremely yes" in
> https://lore.kernel.org/git/CAJoAoZm+TkCL0Jpg_qFgKottxbtiG2QOiY0qGrz3-uQy+=waPg@mail.gmail.com/

I left some minor comments, but otherwise, this looks good. I do share
the desire to avoid unnecessary refactoring churn, but demarcation
of private and public fields does make code much clearer and can
potentially avoid a whole class of bugs, so I would be happy if this
patch set was merged in.
