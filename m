Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A5C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C07218AC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 20:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UY/kvMXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgBFU47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:56:59 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37170 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 15:56:59 -0500
Received: by mail-pl1-f182.google.com with SMTP id c23so51792plz.4
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 12:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1xBI70Ip3d0toIfcJC0Bnm6cmVhFNFP4twcuyS9Igk=;
        b=UY/kvMXojoIlsQjz23JMdPwpAgx4afYE/s1awMN/pxzcMGwLd9UjM0w6uJ2XopkbxS
         GaXPWSTwE0dmuY8xhhiPYSCvmFzp67xeAnoJ+tu30e4R3EN1OpZi35jLiP25U1OeBOST
         0xpzc/UfwRTP9JS7fzH2NyFoBBufCKpfsE9Ht/sMuj16EyOeE48BTEW3Z65uwxJqK4gP
         JmKoC/mijrjPtGcZSWtJ4j8KUedi5JiFTDQ8/WcthR05tZeUfNFVHOXAzdLOdN7rMaDD
         cb9kA75/32RUcxrEJTrOgZQoBYI5J1qMhcL+Jclw4nUDRNX6WfOjAn7RX9Rly2Xq3khz
         Ko+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1xBI70Ip3d0toIfcJC0Bnm6cmVhFNFP4twcuyS9Igk=;
        b=q2D8lS3jOiYwbx3ujY+583VU4oNG3OG5tk1T4Xpx5Q+XLdogMREZdT8rEI9aPtab8P
         j3EHGZmgA9BQ/RXnn8P4prh0Y5o9/JIg8ecPdG9w1EeiE8CKsInmGS66vJNn7gb/UYvD
         Jos0NSlrpKO4lEzobMdCO2MxpHBYtAiKDmH2VY5N6BlRvDlFpsKw+kp9hv97/1jnEWcm
         7OWSbK3eCJSrKvecCjEof7w4ociJuqiGZkpbp5dHKjNFdDoR33K+gTGNQtdNqCyqr4qV
         3kbEIVvZwdgjX4cwmTgn7VuDuJRuJ0k5RtGsmRG17zAb3RkR1MKJ2yQTmbCuH4lb04f6
         1p4A==
X-Gm-Message-State: APjAAAUb0/z+EBICvl2xONiXnyk2JV3TsPOTlfPeyPRnarHHLYOBFvc8
        ujTQ027DgyBoybR9gmcH8liUsQqUHiPwejieWfYtkQ==
X-Google-Smtp-Source: APXvYqyiFw2PB6SkE3c+dAqQMqIKFSHwMdGMmmsYU0+OgeVnrEFu4zju16+tgunoY2HiHyGSKIeA6leHEyYkFnfkauA=
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr6593550pjq.108.1581022618695;
 Thu, 06 Feb 2020 12:56:58 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnesfw74.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 21:56:47 +0100
Message-ID: <CAN0heSpxhoAqSvN_TJHPntSagx3oA4s7iUebHcsYML8NSYwfUA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #01; Wed, 5)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Feb 2020 at 00:36, Junio C Hamano <gitster@pobox.com> wrote:
> [Stalled]

> * ma/config-bool-valex (2019-11-14) 8 commits
>  - builtin/config: die if "value_regex" doesn't canonicalize as boolean
>  - builtin/config: warn if "value_regex" doesn't canonicalize as boolean
>  - builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
>  - builtin/config: canonicalize "value_regex" with `--type=bool`
>  - builtin/config: collect "value_regexp" data in a struct
>  - builtin/config: extract `handle_value_regex()` from `get_value()`
>  - t1300: modernize part of script
>  - config: make `git_parse_maybe_bool_text()` public
>
>  "git config" can be told to affect the existing entries that
>  "match" the given value via its value_regex argument.  It learned
>  to normalize the value set in the configuration and the value given
>  from the command line before computing they "match", e.g. "true" in
>  the configuration file can now match with "yes" given from the
>  command line.
>
>  Needs a bit more work?
>  cf. <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>

Definitely needs more work; definitely stalled. I keep getting back to
this only to realize that I'm not quite sure in which direction to pull
it. Please feel free to discard this whenever it gets in your way, or
long before that.


Martin
