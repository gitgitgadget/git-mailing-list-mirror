Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D6C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21CB613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 15:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhGNPlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhGNPlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 11:41:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52EC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:38:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v1so3703807edt.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AFiylxl9WBWB/h2FY09CX7KLhOs8oGgLiGMCiwytgp4=;
        b=jHXUPv8yR+KAdtWFmDbsry4DBZysPke9bRxHKVklgVCvq7v4k4LZ8SMtUNUP8LkUwb
         NHxF/tXY32SI7N7I+ViejovI8c46FKyTTe3n+EmTslINZfQ8q7A7Lg0wnQ3qJuhwY+7J
         mi76KzIsB0uGQVzg4e+43ceaeU53v0MUxyf2xTfohym4PJDfxM0vIRMZIJKnHdYUr0w4
         3UH/SmJ1Yls3CAUKOY6141sq54k8v5ctDN+6LVwh6OAJxRSCCForCdAvbTHS+s7xxQq8
         6MInsHYyZGVCipIaeuOi02wYryXIP1ZHHPDiW0OAteq0F/dG1VAUPRRwtmxvc4Ul92yf
         7QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AFiylxl9WBWB/h2FY09CX7KLhOs8oGgLiGMCiwytgp4=;
        b=uVFRKLSZnCN0iwX7ksk82eg5+axZHFa1UR/i3/99cZ0c2xspsGbyLNmwX6E6KeJgbn
         tIGzT+GQsQCcjnCo0cTKaqtywHrO2Kgmg2i3dM4XXVLAz7ddrlLQfmIeaL58X+9CtQQI
         ETPHKMiNDI0WO5zeXEFqhIK5uT/XmjJqo/cUAg3wocZB9Ore7CrI3WTxzXMfOEUHMDbh
         VUcXre5ss8I/mJeTIbbOswvwFurVBYbvjxjqEcw+6ouWrk/6RseYbIIxE5O+8BYqVFFm
         5vLC0LPun3XJjDsLUB/8CKbrPjoA+URsDePZtPoG4AuEuX+wfacx59pgXLY/bVHf1Vub
         z7nA==
X-Gm-Message-State: AOAM5332y/zpg0fyN0ECbVeFNIfP4/kpm7y1tnEbK6Eu+uQL/5McpnHy
        s7NQYlURMn8ZfaLLCBLOTQ0=
X-Google-Smtp-Source: ABdhPJwZJl4k67mgvLLtAud5YzwNcv2HjCKAPrrlvRjnIYbUJnsYi9kUCP0wKhIZja2qHRZiBtNX6Q==
X-Received: by 2002:a50:ee87:: with SMTP id f7mr14223228edr.155.1626277117956;
        Wed, 14 Jul 2021 08:38:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y17sm919811ejd.16.2021.07.14.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:38:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fabian.stelzer@campoint.net>
Cc:     git@vger.kernel.org
Subject: Re: progress test failure on fedora34
Date:   Wed, 14 Jul 2021 17:35:25 +0200
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
Message-ID: <87a6mo29dp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Fabian Stelzer wrote:

> Hi,
> The test t0500-progress-display.sh in current master fails on latest
> fedora34.
> The break was introduced with:
>
> 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
>
> Kind regards,
> Fabian

I have not been able to reproduce this, it seems the below E-Mail was
word-wrapped by your mailer, which is especially bad here since getting
to the bottom of this requires looking at the whitespace.

Is there a way you could tar that up and send it (to me personally is
fine, or some pastebin or whatever).

I am able to reproduce something that looks like this if I
s/COLUMNS=80/COLUMNS=79/g in the test-lib, but given that we set it to
80, and that the progress.c code just ends up with an
atoi(getenv("COLUMNS")), and we do our own wrapping (with no other fancy
logic) in progress.c, I'm not seeing right now how this could happen...
