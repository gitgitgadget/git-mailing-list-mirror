Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B161C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiKGPEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiKGPEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:04:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F5D54
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:04:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a5so17986511edb.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ze7PjqED50GL6IbIBsJfrVq7FwsFjFmYKSix+gxbLn0=;
        b=epGBTKh08Q8R9l0dA+8faHCjsYi5ixvgwjY3vcV+kRbSBtQbnmuR8PcFRJGyU6bS6v
         n0wQGD5DHbRp4wloEOOzwJ4LuRrpQzcur/+IWhTGgi5qaXrwqUODleGxntNa3uOk10JR
         3nOOsWwn7Ro+Lm7TL4p26Q4LaQ+K//sYT0i8MMxFsVFSmrff8a8SeklF5nUSTQswNtkU
         6QkcQ9c3Gj6/ixMlRN93bqUmB/PaV3vN7N1umyNa73SR9AItxSPNEyzWtl/9625fHJZ2
         8Pkg6KrDUgB/fZVI9Bzfy79yuRMRXyhDjr3MmD6lbrn6M/FdmoknD5XhU3bFXHNjxyV4
         /1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ze7PjqED50GL6IbIBsJfrVq7FwsFjFmYKSix+gxbLn0=;
        b=vymhZXDfHdHAgkVbAXnSI2PsZjnJiAwT66kci/ffbhSxEqFR9mg/ZG4LNp5nFAfX/Q
         2zTc7Nvh9Di4HpF99XhgvQTkEag5v0z+EZHNUyzUOxKqN4lPAEok0cVAgqQ6qodaKIwu
         fVQlEAt4eaw0cjDlPohs1mK/v1eYkhNEsVVZoghe02btQ2wxNqpmuma76iy7C+WX1mCz
         oFU3ZUAR0GZA5nhwmHdADEdkcshDOZad9lFzYKrZV1VxIlJpkqQLB8cLAXC4aarBfZng
         lmjskLd07cq8BW8yNoP2t77HavGWeO05LW5ZQNX5bnsYFSC/dY2/NWtDzWIJOqzCDby1
         GuIg==
X-Gm-Message-State: ACrzQf2lxTrCSvhBLdHeMeBftlurwRSW0dheouqzHym4UjH+1m6M6Bqa
        pwmfHQP1vL6lW4D+UrzvE50qVEx8HbQ=
X-Google-Smtp-Source: AMsMyM6nJl/koIGL183bC0Q72XGqsbqdhnJzSelf2QUTxkiMzt+YiNMf+H93lfuJX93T+C0KfEEGzw==
X-Received: by 2002:aa7:d996:0:b0:461:88b8:c581 with SMTP id u22-20020aa7d996000000b0046188b8c581mr51102600eds.111.1667833458020;
        Mon, 07 Nov 2022 07:04:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o5-20020a509b05000000b00463c475684csm4392789edi.73.2022.11.07.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:04:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3fd-0008Yp-0G;
        Mon, 07 Nov 2022 16:04:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 0/3] notes.c: introduce "--blank-line" option
Date:   Mon, 07 Nov 2022 15:57:21 +0100
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <cover.1667828335.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cover.1667828335.git.dyroneteng@gmail.com>
Message-ID: <221107.86zgd2vma6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
> [...]
> * drop unreachable code in "append_edit()". =C3=86var found that some cod=
e has been
> unreachable in patch v1. I think it's because, after the commit "notes.c:=
 fixed
> tip when target and append note are both empty", for example in this patc=
h, the
> situation of "removing an existing note" should be impossible unless a BU=
G when
> trying to do append. The tests are passed, but I'm not sure I fully under=
stand
> the original design.

I suggested squashing that BUG() in 3/3 into 2/3, but reading this again
I think it should come first.

I.e. this seems to me like the code in cd067d3bf4e (Builtin-ify
git-notes, 2010-02-13) might have just been blindly carried forward to
both "create" and "edit" in 52694cdabbf (builtin/notes: split
create_note() to clarify add vs. remove logic, 2014-11-12).

But it would be good to have confirmation, e.g. if you check out
52694cdabbf and remove that "Removing note" branch from add() does it
fail tests at the time, but not in the case of append_edit()?

