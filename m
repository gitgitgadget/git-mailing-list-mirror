Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69472EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 17:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjFMRQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFMRQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 13:16:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B00170E
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:16:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-653bbc6e2fdso3209665b3a.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686676597; x=1689268597;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQOWREUedGPRmyAhH4/NmnVZzL9mF88hFx4XwHBeEfg=;
        b=nklWcoMMpLrO/aKE0QJ9K2LDJ0gdtwzsNsHvwOqxZK1qPm0wY1WdZgKSYfvR2ltLhj
         x5N+KcUwcn7ncjlGoMyOVDDffZG63oxadxHdykuJemKifQXkmpoVWCbRYAAEGO14hWaK
         egmFaqsL7vBZ5jXCHEoEDLnDCxlFvXGFuvJp36GKF2zXEYLdr1qv/WZyH4BXUgmmOfho
         QClbHQ82Eh1ve9WWOv0ZmbqQvkDWTqZNkNOkDThrDknLyEEYzWQCrkByNBVi+fnl7b8t
         PEcf45clS3BvOxO73ULEDv5ILOla1A6vSemXzAXwIKIsfxB1wd+fzHqmc+vPfHKkzKmS
         Hy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676597; x=1689268597;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQOWREUedGPRmyAhH4/NmnVZzL9mF88hFx4XwHBeEfg=;
        b=kZq12P2e5BJ9YPjtCNke9HmQ+gTPbPQEmPvTPZT36v1MokKi4d7c09lzaJlxktDPEt
         +pY7SNEB1Hyg7CA1eKKcsAc5r+KSfDO3BRMuwRNKQTlKIjzinWC8KvdZ03/ri4DT/IP8
         NMwih/4fFRaTd55rsk7YNcx8fv7Pq+hNIK0ezfCdLQNlesah6y1ItnHEGAX1B73iSaxo
         2tP47EAPcV7OG3VbKFSrnHK6TMdIsUoGRzUlGUFQxD9aFJprbO5Bu++tgUSL9jvW7Ah6
         Pz/IBcjH9nSNHbCl8UirzVXXBfqR68sCEnQjzTh+3wJ+84TsgILWq2QCiDW+JcN5Cq6r
         0ECA==
X-Gm-Message-State: AC+VfDwiDx5vpNwiOhKMQo+woP3ams0AQugcOZGiS5EEt791SiOq5+CG
        oUnNu/kXzR4IzOqaXxpuAunkhD6Bx0a90HIMkewA
X-Google-Smtp-Source: ACHHUZ4PQE1uKpFMh/YqWrR+Z7Z7Qsn89DAsoEw8/QvDKxOv+k0BMHQ7sF77lsb0r2biKhpfUXkvKq5Wi6txDk5R4XJq
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:5e39:4d58:c992:1db0])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:88c6:0:b0:64f:b286:af7a with
 SMTP id k6-20020aa788c6000000b0064fb286af7amr3599537pff.1.1686676597186; Tue,
 13 Jun 2023 10:16:37 -0700 (PDT)
Date:   Tue, 13 Jun 2023 10:16:33 -0700
In-Reply-To: <xmqqa5x48j0j.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613171634.15985-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/4] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Perhaps an addition to Documentation/CodingGuidelines is in order?
> 
>  Documentation/CodingGuidelines | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index 9d5c27807a..78bc60665d 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -188,6 +188,15 @@ For shell scripts specifically (not exhaustive):
>     hopefully nobody starts using "local" before they are reimplemented
>     in C ;-)
>  
> + - In 'printf' format string, do not use hexadecimals, as they are not
> +   portable.  Write 
> +
> +     CENT=$(printf "\302\242")
> +
> +   not
> +
> +     CENT=$(printf "\xc2\xa2")

I've checked with "dash" and this applies to any quoted string, not just
when passed to printf. I'll prepare a patch describing this.
