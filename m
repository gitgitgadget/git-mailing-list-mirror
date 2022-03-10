Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F481C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 04:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiCJEkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJEky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 23:40:54 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00511AA3A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 20:39:53 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso4224976pjb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 20:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B54VNb0SeA3jDB0DZV0K44UOVC1dtEN0ccn3o757G4=;
        b=PV9nGOWhotojFzAoww6HJmYu9U/Gkq6ZwZY1+o9qgC6lyTVHurYXZZjVcg0s0MJHt6
         6Yc8L8HHHXIvhmfTD8JoHpo+cG38BgNtaqsLkknA5T46pV6iggCKDqrTcPMqHkhTmHWo
         3ozwAEcpCVaGzYT8IWWqYDKYSw5okzShylVtix5gjje5X1sg7HL2zbOHy4wX23QEsn8x
         qYkUciwV60x4Xwoj5TKvEuLGCAQF5Tm56o8246Aslmzh2J7G4w/IPdKbmJ9O1u8PfHMq
         8j2kD9oL4+ji6P9PsgA7CVp5oercjzyiYf5k1zg3c9HGeKgNiel2mKeb70wTgkIE0O6M
         bzsA==
X-Gm-Message-State: AOAM530LacPW9dcvmfjXdb6Rrux+Yts0LNN7CcxoperpFMBOEKP1mEY+
        09C/WUVxH/XKCoENw7SoTpfk40f3ITxKVjKWRjrcGCZuhIo=
X-Google-Smtp-Source: ABdhPJzkcDeByqiQUqchQa8ntHeqE2ys4VLVwlDZa1++lIKlge/Ju0GeSkY7jUbOejfAQr9U6T6q8uXeRJQGSDVLZks=
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id
 21-20020a170902c21500b0014ff1c29fe3mr3138268pll.145.1646887192797; Wed, 09
 Mar 2022 20:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-4-emilyshaffer@google.com> <xmqq35jqino7.fsf@gitster.g>
In-Reply-To: <xmqq35jqino7.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Mar 2022 23:39:42 -0500
Message-ID: <CAPig+cRsbNQpg4y=KfbF6m4PDaoQ-RdKuhEoG1oeFF48i5RWuw@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] rev-parse: short-circuit superproject worktree
 when config unset
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 10:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> > +             error(_("Asked to find a superproject, but submodule.hasSuperproject == false"));
>
> s/Asked to/asked to/, probably.

This is a user-facing error message, not just a programmer-facing
message, correct? If so, then perhaps: s/==/is/
