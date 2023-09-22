Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08FCD4847
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjIVSX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVSX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:23:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB8CA9
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:23:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-570096f51acso2510283a12.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695407001; x=1696011801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLBBDxMHPLgWorz71vVKgB/vRcWiaW+LdiCU04HF18=;
        b=gSutgPgk6iPmbpY7RaSFojwYaawasDlRlzoHxJiYWs0/llFL6y7iBX+59D36dEvpA7
         9cTKGVw1afEMULKNcscb/6fCbtdvSqCCatDtZt0FLFBLwPgevD+3uyVeE1n4BJXypABI
         /I7u5w+mKnSTNxa6/fwBaTr14NKm2YHcSKV11F2f3gIYpMoeOZBeS++8YpjSJMgs+zSE
         CiZvoBGQpkrOsx5aDevplAi3OFgQu6T5iCEpXnN6XB0nURp7VmrlJdFIfpXFV9Y1PAni
         cE08BUj6mboED7dhdTPNwTdHbiZ1pNLp+kE2u5TObFJSsvBS2zXZ+TlFIPoTgM+3Y7Hg
         pagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407001; x=1696011801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLBBDxMHPLgWorz71vVKgB/vRcWiaW+LdiCU04HF18=;
        b=RKKMhOhwQHUKQNsaxH/zsB1T7bYMXZ5jOnpQmDCXwe0vCFzCwcMAyzzPVBWUGjSHU2
         0m+MGgiQG4FlMU2qMa4YM8QPm+gWNvDSOe3VMwY5xmaWOAGdDaMQJ6t+16sSdLJn4q6f
         kSI4+XskTBtt4Fu5Rpbockh3D9EQ+3V1V4YEhI93mLp43e9EPUwuT6xtSdqZftzHIxVJ
         /zN4R45FHRlzUkxlGqw0keQsnEv3CPoP6AnxzISCux3+iRGC2apBsYCX4x8buVfpvuiu
         FVhjkGa0FgzpcbUXnz9xP5ZMSEdmfTT5pSlWd+DivkRcYzdOiPLqKIvetDAUKqgH1S0s
         JGnQ==
X-Gm-Message-State: AOJu0YxLCdwupiI0mj44djABp3LoboPOKLgVpSug6O1m9mipb7JV6M2u
        cyb9rg9NvPlqvpXH4n+9oJCR1yvDWEY=
X-Google-Smtp-Source: AGHT+IFq1ilIZdCsrFxd1NohTPRSmHR/gK7tDHCaZETKa8/IzlEgXvmxTdZZhfnJuOD6flSFMiEZ/XJEAf4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:1c51:0:b0:565:e585:cb56 with SMTP id
 c17-20020a631c51000000b00565e585cb56mr59549pgm.2.1695407001344; Fri, 22 Sep
 2023 11:23:21 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:23:16 -0700
In-Reply-To: <xmqq1qf1la0q.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <52958c3557c34992df59e9c10f098f457526702c.1694240177.git.gitgitgadget@gmail.com>
 <xmqqr0n4v8ul.fsf@gitster.g> <owlyzg1pjx2f.fsf@fine.c.googlers.com> <xmqq1qf1la0q.fsf@gitster.g>
Message-ID: <owly8r8yt6cr.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 5/6] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> It gets tempting to initialize a variable to the default and arrange
>>> the rest of the system so that the variable set to the default
>>> triggers the default activity.  Such an obvious solution however
>>> cannot be used when (1) being left unspecified to use the default
>>> value and (2) explicitly set by the user to a value that happens to
>>> be the same as the default have to behave differently.  I am not
>>> sure if that applies to the trailers system, though.
>>>
>>> Thanks.
>>
>> I get the feeling that you wrote the "Such an obvious ... differently"
>> sentence after writing the last sentence in that paragraph, because when
>> you say
>>
>>     I am not
>>     sure if that applies to the trailers system, though.
>>
>> I read the "that" (emphasis added) in there as referring to the solution
>> described in the first sentence, and not the conditions (1) and (2) you
>> enumerated. IOW, you are OK with this patch.
>
> "that" refers to "the reason not to use such an obvious solution".
> I do not know if trailer subsystem wants to treat "left unspecified"
> and "set to the value that happens to be the same as the default" in
> a different way.  If it does want to do so, then I do not see a
> strong reason not to use the "obvious solution".

Currently we set the defaults (these take effect absent any
configuration or CLI options) in trailer.c like this:

    static void ensure_configured(void)
    {
            if (configured)
                    return;

            /* Default config must be setup first */
            default_conf_info.where = WHERE_END;
            default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
            default_conf_info.if_missing = MISSING_ADD;
            git_config(git_trailer_default_config, NULL);
            git_config(git_trailer_config, NULL);
            configured = 1;
    }

So technically we already sort of do the "obvious solution". And then
these get overriden by configuration (if any), and finally any CLI
options that are passed in (e.g., "--where after"). The reason why I
prefer the *_UNSPECIFIED style in this patch for these enums though is
because of this (and other similar functions) in trailer.c:

    int trailer_set_where(enum trailer_where *item, const char *value)
    {
            if (!value)
                    *item = WHERE_DEFAULT;
            else if (!strcasecmp("after", value))
                    *item = WHERE_AFTER;
            else if (!strcasecmp("before", value))
                    *item = WHERE_BEFORE;
            else if (!strcasecmp("end", value))
                    *item = WHERE_END;
            else if (!strcasecmp("start", value))
                    *item = WHERE_START;
            else
                    return -1;
            return 0;
    }

and this function is used as a callback to the "--where" flag, such that
the WHERE_DEFAULT gets chosen if "--no-where" is where. I prefer the
WHERE_UNSPECIFIED as in this patch because the WHERE_DEFAULT is
ambiguous on its own (i.e., WHERE_DEFAULT could mean that we either use
the default value WHERE_END in default_conf_info, or it could mean that
we fall back to the configuration variables (where it could be something
else)).
