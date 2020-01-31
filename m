Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B2C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A4A20705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3+We7Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaVUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:20:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33506 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgAaVUR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:20:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so3249456plb.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SuW6wYRy53tRfTLjDk+SzLwIvI0kwEk3ZDmwxOQdg7M=;
        b=T3+We7SxRDI2T2CjPhBBgoO/JtIjv6TLKjIGurU8VtXe9ooJUOg0DmM5ZB+3ocz9y4
         ZwpHpwOLEko6FslyucX5BS3JXnF91+S19XR8G81RkEX2pMBcrvPN8rQUkMJ4w0HOgEGS
         eKVuSCwJOPXFcQ8nzwcVYME9YJhPkqRkocvt6VWutn9fa8gsQWPWgItSza3dMhRYHZop
         +A4np6bHI58fY41N8QwKA/0OcVtQ408yHSQVe/trn8db7ejAXU7glUCnIbyuDUrgIV0U
         e2mmZxYfZL3VV0BmNEnkP/ASZpQV8oxBHpZLGsFxA12dGcrRQ1ToxN1CfGr1bdpzuBRN
         zuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuW6wYRy53tRfTLjDk+SzLwIvI0kwEk3ZDmwxOQdg7M=;
        b=FAcAAgrtacgbbe0iL3698KRiDVRvlzC2R2WFm1DfrYsNUa8qIbFsmpPkWbdYBgoP2D
         0mhsCcsi9DNWuNMF5QA8siW2iCsL3zw97MK3mB7Y3fcuQ+jw8p1fXHXC8MS288h8+uDx
         T5ky4F6ezLNfvZtlNTF5iR6yrlhiIAovapZmcwwacLH1ZoKXP0wlbgfcE5YLA+AHlV+q
         Zfnip3f+L4vvguXfrzd5zNCTuFmLKTRtzySC4B0mp1RBc6o2yeZaIswGLRsOe8gxfG0o
         +hITkL+Isoy2sb/J4NIXDV8kaOJ5elcPUu/GAAdgygyPUknch+VCqgpQj6NrdtcbKsGd
         sExg==
X-Gm-Message-State: APjAAAUHmLquFovAT/Tj5hH/G0iWU1+fXpZ/7yzGQ6YEWlpwUM7AYDM0
        i6uUHFL+73g3daT1X3YhfruRPko4s4VPcuGCIA4=
X-Google-Smtp-Source: APXvYqybLPcsofxrx8eLHmoqYWbXnSGeX5AOE08NEcsiMy5m16bXU6zJZgw6OGkdiHz+v7h5SvNfoRrKgU6VrIWZwmw=
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr12170858plq.79.1580505616904;
 Fri, 31 Jan 2020 13:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-10-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-10-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 31 Jan 2020 22:20:05 +0100
Message-ID: <CAN0heSo2ujJr_Mi5xPv86NneLoXT3DM3dnRmTACs2VQERBq76Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on docs
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> Add a new step to the build to generate a safelist of git-config
> variables which are appropriate to include in the output of
> git-bugreport. New variables can be added to the safelist by annotating
> their documentation in Documentation/config with the
> "bugreport" macro, which is recognized by AsciiDoc and
> AsciiDoctor.

"which is recognized by" sounds like it's built-in. Maybe "with a new
no-op 'bugreport' macro" or something like that.

> -sendemail.signedoffcc (deprecated)::
> +sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
>         Deprecated alias for `sendemail.signedoffbycc`.
>
> -sendemail.smtpBatchSize::
> +sendemail.smtpBatchSize bugreport:include[x] ::
>         Number of messages to be sent per connection, after that a relogin
>         will happen.  If the value is 0 or undefined, send all messages in
>         one connection.
>         See also the `--batch-size` option of linkgit:git-send-email[1].

Do we really need to list includes *and* excludes? I could see the point
of adding an exclude here and there to signal that "this might look
innocent enough, but trust me, we really need to exclude this" in order
to avoid future commits to more or less accidentally over-include.
Should we add some internal documentation and/or a remark in the commit
message about this? As an example, is "sendemail.signedofcc" sensitive
enough that we need to explicitly exclude it? If someone wants to come
along and include it, they don't just need to argue for an inclusion,
but also for lifting the exclusion. Hmm?

Martin
