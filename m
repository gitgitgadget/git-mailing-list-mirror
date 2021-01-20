Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B2C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D50023142
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 07:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbhATHLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 02:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhATHLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 02:11:07 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D8C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 23:10:27 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w124so24092200oia.6
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDhGxT5q9/bD56OvQSf6+nLLSlngHBez2Lb1JQJWvHA=;
        b=vTZ523KKIWiBxwJw51U9pFLm5ynQ/1v0QuAazmeVqx5KS4HzPi7yhFJ1JkA4p/B1s4
         p/7zf0BAthMA3nUXewlz1o92SO8Gtb7KouAI/zmXFScbitOPF7LuWYRprQq/5H5ZxNU9
         PXKuKvE02TyOxVwhpb0dHZLdOQiGbcdqOHzTMAVYuKKEjbEH4H5SnpBoILU860MTVUI9
         rX9x/2OaoaGSta3FpuYFn0xG3Pp4DhtsvZObkL8z8/X2vo+ywTOXDNhhrOy+RLiwYD49
         GchdHHA1hyZ+23otFOj34K3zGvQWfKaiIhfny+pKLShPjq44Su92Xz0V3Cx2Ld3mMdvu
         BhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDhGxT5q9/bD56OvQSf6+nLLSlngHBez2Lb1JQJWvHA=;
        b=dY9SB/TMS1LSvJwd+CAtV0D1PpMqhU4AEK2m0GGm33Wa1pFySxo6rQ+ilSefS6eIMF
         tbbMJxDuN+j8A5SQDTfa3p5NRSpFGK6W27o7T0g9/YkxdCzMUdT2laTQ1aQK8rZU7miF
         M86V5i3fLE0R5EXhOYNN3iTWRHnnrspMzjnICDTm62PE8/6yrwFxKFqaN4hMxRrfT1VW
         CxsTCcAPEjWbR9VED3ZKXeGRi44IdJ3DESuOvFn5bOgnlFg2TCZ8W+I7tuGkj1qj723l
         g6aI3HWovX+szN5r8WxKMHcTW5R2HHZAa79Ek/NnROcLtpvmvQnt5UlRD6c3qQbcyJGh
         n/gA==
X-Gm-Message-State: AOAM5316oa4urtJccdiKRvMiluagoDsZP6MIaGvGML+syXUFG6ffFSIj
        8iDINyEpiSPLMI4BkIeKcKJ6b37q4XyrhVUEq+ArbOez/OFkqA==
X-Google-Smtp-Source: ABdhPJyR30M0XIWhxeDnMaSPcMVOeZ8TeCNW9q+h1BPiE32oFD5VgKVShQqhFA2dSBj2QEovEVHQ+d9/yqpLRZLUrxo=
X-Received: by 2002:a54:479a:: with SMTP id o26mr2094226oic.48.1611126626494;
 Tue, 19 Jan 2021 23:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-10-charvi077@gmail.com>
 <8fd2b72c-d1d0-98be-e6a5-fb7dc699d5d5@xiplink.com> <CAPSFM5euGE_bUDPgdzx4-q5zYtkDymHdJP9rw-YkVVVzpOKWkw@mail.gmail.com>
 <a9bc4d25-f2ec-6a8f-4969-7704f12d667b@xiplink.com>
In-Reply-To: <a9bc4d25-f2ec-6a8f-4969-7704f12d667b@xiplink.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 20 Jan 2021 12:40:15 +0530
Message-ID: <CAPSFM5e8pKQ-HLuhONsChrkLb7Q6LxV7YbrF0RJx6TKOOy=rJQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] doc/git-rebase: add documentation for fixup
 [-C|-c] options
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Jan 2021 at 03:35, Marc Branchaud <marcnarc@xiplink.com> wrote:

[...]
> I'm also under the impression that the "fixup -C/-c" commit's patch is
> still incorporated into the folded commit.  Is that right?
>

yes, it's still incorporated into the folded commit, as it just adds
options to the `fixup` command to replace or edit the commit message.

> So I think the documentation could be improved.  Assuming that a "fixup
> -C/-c" commit's patch is incorporated just like with plain "fixup",
> something like:
>
> The suggested commit message for the folded commit is the concatenation
> of the first commit's message with those identified by "squash"
> commands, omitting the messages of commits identified by "fixup"
> commands, `unless` "fixup -c" is used.  In that case the suggested
> commit message is `only` the message of the "fixup -c" commit, and an
> editor is opened allowing you to edit the message.  The contents (patch)
> of the "fixup -c" commit are still incorporated into the folded commit.
>   If there is more than one "fixup -c" commit, the message from the last
> last one is used.  You can also use "fixup -C" to get the same behavior
> as "fixup -c" except without opening an editor.
>

I agree, this is now more clear and explains for more than one `fixup
[-C|-c]` or `squash` command also. Thanks for the suggestions, I will
change this in the next revision.

Thanks and Regards,
Charvi
