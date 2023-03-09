Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CDAC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCITId (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjCITI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 14:08:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE01A38E9D
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 11:08:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a2514d5000000b00a3637aea9e1so3255363ybu.17
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 11:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678388898;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnjUcqFt/xxEliy4KqvKI533IXZbpgd5UMFTq5tYpnM=;
        b=M3TrWhsE4EtMkHgeWVn2bXYA04J/BYvosmrnyfVKEgu6eTbeCoBFd5RU/pw6IA4Sg9
         IYIbEyeBuAZwxQr3zjfbN8j8VbTh8IgRhiTyut1DOv/YUMcXq8ugYFAWVDErR1BTgX0L
         MPS7hGnrrAv/2hV1REKYmKLrO3IHmG+lJ3eMu6hIWNTeL9Z8vaYSqUVEKXpJBqb8r4vz
         9mmx1KiNDvHWVWO0EO5RJFfFeupeZPCzLgPUD1qCALQYrMogarvO6Zgko69xGYVLafEg
         szUUjhBvisM8mtrvPutXq8PH5imNPPTkEkqGhz/gEwt/FMHrH5bIITZ32yUWuns73Dc2
         AGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388898;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZnjUcqFt/xxEliy4KqvKI533IXZbpgd5UMFTq5tYpnM=;
        b=QgbuN/fIf/uWlHFYtPixa94uRanZh3QsZxb/8VRGuM3EcAQitzOWC/7eL7eQCeFi0J
         8upxnK3KZ1Dv4yjJAilGJ8aP+YcQ8EXoaTgl05/bOgtvaOx6GLkD2s/d9sIYlTR+U/bt
         Jo5MYBmc6Z/liWil94JhLUr1DkGOirudALm1SV5ij+WLFzGyRJqV/zBKznXekfFCtcHZ
         GypHEHpQBINl9OB1tevbBJtryMQ/FQCdAFAZVdMinJAF/OBFdm9ltIS1L20xN/qEyUEG
         sQMt1BGzVw3jtkss1eekfZyUpeumUD3G1qaYht2T9WBJJxRRQxBxINacDTIqp6Z8lSF0
         LbHA==
X-Gm-Message-State: AO0yUKVv/fqEexd1cs1R6D49pxx/iQ2f3M9Oblrqt4zzr8xdbA38gDXX
        wliTZSleLirM6ktdu945x8DVuLfnC4YVtA==
X-Google-Smtp-Source: AK7set/xKS2ShSWLQS3mOW7JaLz3uXOPOdrxIzCJT4JdJcr4ZC+mJdLDZOprdFtz9yvdvBR2J4Mhqzoa3QGoLQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:2f0c:0:b0:b27:70e1:4649 with SMTP id
 v12-20020a252f0c000000b00b2770e14649mr2241957ybv.6.1678388898058; Thu, 09 Mar
 2023 11:08:18 -0800 (PST)
Date:   Thu, 09 Mar 2023 11:08:16 -0800
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com> <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
Message-ID: <kl6l8rg5hhen.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v7 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?=" <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This series fixes numerous segfaults in config API users, because they
> didn't expect *_get_multi() to hand them a string_list with a NULL in
> it given config like "[a] key" (note, no "=3D"'s).
>
> A larger general overview at v1[1], but note the API changes in
> v2[2]. Changes since v6[3]:
>
>  * Glen pointed out that ejecting a commit in v6 orphaned a
>    corresponding forward-reference in a commit message, fix that.

Thanks for your patience with the rerolls :) I only spotted a minor
comment issue [1] (which I think was what originally motivated v5?).
IMO this will be mergeable once we reorder that comment.

1. https://lore.kernel.org/git/kl6ledpxhi3t.fsf@chooglen-macbookpro.roam.co=
rp.google.com/
