Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD1C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B87D2065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukHZCNwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390738AbgEMTl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390256AbgEMTl1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:41:27 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7CC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:41:27 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id 36so244624uaf.9
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMOYYmpKvlB9LxEJZXVT6kdh/fUh70RbD2j88nNEBWk=;
        b=ukHZCNwJodJ7Pp1EmMDp9WQy2A1fPCoXdUcFn3JRgqY+SX1cpzkDBjBdRqvtZ2dWW2
         8K645NshC31w9d0yoZmdK5wZEo0hka1ca/aTzP/Xc7jT6v+TDgOiCUvxZt5Rv+ow2k5Z
         GA138jYaw7rfQZiGT4YUngmta3dgwjk17Mt8u2kF5X4mw/GZkc2P/7XpuZrJn9DdM6CL
         kJP5jrWFV0nPbgdaP6tGFkAcUIoTo5WvoLV+aIZDe3QL2GF8UhPQBvjksR8k2/H3w9nZ
         nsKQnMA5EuHH5ih2k+cmejEGUb1C7d+gTA/r2HQt2WgX8D/pgwTV+ExCcq5RAZPO0K1n
         RLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMOYYmpKvlB9LxEJZXVT6kdh/fUh70RbD2j88nNEBWk=;
        b=KiwiZQK+Wek6Qb0b+9EDio42H07hvwPjS0p94JGY91JiH8ZsVHX0S1hqHbwo/hWQv9
         7ndbjDnvEVHGefXSunEUUub2jNzBgerx4d+jtQvJNNFomF5QT7DPdW2AYMmbJMiNPt7L
         zcptvc+ujXeRpG+Et4QA1o4mUe5IdCu8LMlHyXji0zslo3f7eppR0idnZulfMYzlT+0p
         +zPny56xM0oLEVPKq8VanC2b6TgtIhGKj2akGaWvO0NdfAeMMrpy6fYIK0Nj7ogwWxpI
         9sv64YgeSxuqnV6+/uGV7ycBNdZXSDbGE7w6t+PpiHlJJ+EE3lny8OBkM/S3d26XNISU
         rrgA==
X-Gm-Message-State: AOAM531Oz7sQVgz3AhVnyQztog3RoHS9xRqcKXX62xT8aXI08T0EiPwZ
        VgyQo3YKQHKL3F3btYjJenlF8ZGHKXWJZkYdatw=
X-Google-Smtp-Source: ABdhPJzrBkN4999v+FedsQroOIpIbs4Lm0OX86VBbsG0LvtYd/QtPrw+h0ASgOlIfLE/Jxty+jIHLahBm2ZDCYj5W00=
X-Received: by 2002:ab0:328:: with SMTP id 37mr1077791uat.112.1589398886648;
 Wed, 13 May 2020 12:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-12-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-12-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 13 May 2020 21:41:15 +0200
Message-ID: <CAN0heSqvy_y7tNkfs_499vfYL6iOvE6nH5s_42WOHAT-5iSgUQ@mail.gmail.com>
Subject: Re: [PATCH 11/44] send-pack: detect when the server doesn't support
 our hash
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Detect when the server doesn't support our hash algorithm and abort.

> +       if (!server_supports_hash(the_hash_algo->name, &object_format_supported))
> +               die(_("the receiving end does not support this repository's hash algorithm"));

I suppose this isn't the long-term wanted behavior? Would this be where
we would later learn to realize that "oh, crap, we need to
convert/translate on the fly"?

> @@ -428,6 +432,8 @@ int send_pack(struct send_pack_args *args,
>                 strbuf_addstr(&cap_buf, " atomic");
>         if (use_push_options)
>                 strbuf_addstr(&cap_buf, " push-options");
> +       if (object_format_supported)
> +               strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);

This isn't advertised in the log message: If we do detect support, go on
to reply with our choice of object format / hash algo name.


Martin
