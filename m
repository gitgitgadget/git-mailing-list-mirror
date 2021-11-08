Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9126C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8346134F
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhKHWqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 17:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhKHWqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 17:46:24 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528FC061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 14:43:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso1565095plg.23
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W1wDZTdJJQsRhxlNCevohVhOCkqOy+dOcqPUfQesakU=;
        b=pVPb2bEjbgDDvylFjvipKoXaDUQv6YnSV9AQcfgPISs40ZvsqLlnV6zUFT3Zmozgce
         mhnthZNAojKlIIu07yslCbmEGW2+S5HFzpK75O/m0En2vc6dQo41QA3QIml7Fb40o729
         vbA3+OTSs4wTSFX1P4Cj6lTHOucwL1scvcIfY2z6DCVPYwZtDnrXMvBcJ0/K7NUU/XEP
         an4fD8A9qwf5RL6S9vLljhLrSgwaVlRYeppG0SWB1rH9i/lHOFYAUe4wWXAloMMVGo2y
         JKsmkufnnvKAmj9gpcPE4wg9CUIMqs1fgTt9NGGO75vT3eWErEP/v0XzguweQ07+FHn1
         FtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W1wDZTdJJQsRhxlNCevohVhOCkqOy+dOcqPUfQesakU=;
        b=sClNkBVDb1os7wRPjpJ+WNnRx7LD3Ecl4LDTsYzvLAqoPNyIglWwb6UBfVqyXEnBd0
         k8R4b1Rg8O5UNVJAD3IwbI6xhW8Pl/93AOmh7Z1thPx/+2pkNNE1Nu3z7iANqPY9CUse
         +6OCpC+NW7fSftYGu9+t0cAAsXkl6MvrOGHUoLjsSdHC6T6e/NdW+3JwVkuvAHckUllB
         p8Yj0t+9YxTVxkw2/gQplm7SFmsJVRZIaYdHL4GWporP6Gw2eiLgaaCZUkRKmpMNYp/T
         APWX6onr6A3m7Pp5ZKR2RDXmtJl9Xpn2LWGQLEwzONXEOGrZxV6Hc/lbMzTkiirJC2PP
         TWZg==
X-Gm-Message-State: AOAM531unD6eAXRhdDrN7kXlndTZ5ixdromNkgGyDvs/NEvO4XIPhNcQ
        dvIc9lZm6Qp3Qqr92zccMtxaKrHPKZ9rUAmmX/tr
X-Google-Smtp-Source: ABdhPJyY+/e/PmZii3N7JhUWb1bQriNkElqo/nft6iNmE4H0OitIjTH591L2ZtlfASn0u0QopegIUZkOiXynI8LXDt7r
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1d97:0:b0:494:717f:23e8 with
 SMTP id d145-20020a621d97000000b00494717f23e8mr34292093pfd.42.1636411419594;
 Mon, 08 Nov 2021 14:43:39 -0800 (PST)
Date:   Mon,  8 Nov 2021 14:43:35 -0800
In-Reply-To: <xmqqbl37li0o.fsf@gitster.g>
Message-Id: <20211108224335.569596-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqbl37li0o.fsf@gitster.g>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: Re: [PATCH v5 1/2] fetch-pack: redact packfile urls in traces
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     ifrade@google.com, gitgitgadget@gmail.com, git@vger.kernel.org,
        avarab@gmail.com, sunshine@sunshineco.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK.  If the <hash> is given by this side (as opposed to "you started
> to talk to a remote, and it turns out that you are still talking
> SHA-1 but the other side talks SHA-256 and their <hash> size that is
> 64 does not match your 40" case), then checking against
> the_hash_algo->hexsz should be sufficient.  The original suggestion
> was tried both because I didn't know where <hash> originates, and we
> would want to redact even in such a hash type mismatch case.
> 
> Thanks.  Will take a look at the updated one.

This is when reading from the remote, so <hash> comes from the other
side. I don't think that the remote sending the wrong hash size (and
then needing to redact) is a big concern, but there is definitely no
harm in checking for both (and commenting that these are the SHA-1 and
SHA-256 hash sizes).
