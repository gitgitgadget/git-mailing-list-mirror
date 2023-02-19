Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F30C05027
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 07:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBSHiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Feb 2023 02:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBSHiL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2023 02:38:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71237E383
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 23:38:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w2so2007048ybi.6
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 23:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jWzz3RExdhnH+csVkWgnC7RpWyJKhLbF+9BEkvbxMD8=;
        b=BcQ5NdPJcxjRTnF47aYd+8iVMFbAbJN9CkY4x53s4I4gKESeq3/tFEuxngwNBN2yaW
         ddj1pqBbXpWwUridIgVdppQMgkjz0Kh2WmUI1aTOZyz1WkvuUMKqw9xLl735SRZd0KEu
         C6umX4hkUV7t8DeIOB7eqHhcjDZyzMpBv65HeT+wzIg2WaaBVN0xA7GsvEJPsNu/ZdLd
         CZDt43iJqTwMG+Al7Jlgh0ioZ199PxNX2bKGvIyE88PUNk2SshpqvQOMdAZ+EBaWr3/o
         kIWvY4Ly5O2TOQdU3Qv1/n5At0okvusis43ZtaguC52qjTB5OxAcmEe4MRbeT7G5yXr3
         kafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWzz3RExdhnH+csVkWgnC7RpWyJKhLbF+9BEkvbxMD8=;
        b=VxmZ1V3w4XrpyZ8cnNrJ+nRig85ycEAnlP148ayGpr5P/ZJwAWUKBmx9MGBWIrZkBJ
         MhJeevLaCyB8rGqdINqUYlmTR+OPA0F7BPsyypyCzUCTdigCGOHTPI+q/MLOwuCAjJ0j
         SZ0SKopIUNgTtpsOrmFdiasiYmtfFzX7fx59NbqG/ROAkRo+CJVVXsBxuuVqIWPlGvuh
         V25v0t0HBUwnCeS3yWWh2C48BVDDTJbaNQI7r7Qx1+Iu4vCAbmdMPm7f/KnTqnVUGjhm
         A8gZK/vk50OTxsCqngYoJWo1jgfDBZeUjmakBe81FTGcdWTm+fsiYc3YZ0B/B3lvLkMy
         Xpcw==
X-Gm-Message-State: AO0yUKVLviXdKikmGTjUO8VeFVk3nnoPUQVp+meDd+4PpPfNDr9GHphd
        kRb0xM2jxJS12MnNz4Y+gUPOnaDjixXVlAdc9nndLBLx
X-Google-Smtp-Source: AK7set8bDlCmJm8BS8qg9OiFiFKJWemiouZOU1ec/SgB1gspSv14LTEiY8mVK/fZiHMyhlurn/+rWq54QQeRLIYz45U=
X-Received: by 2002:a05:6902:92:b0:8dd:b036:2f61 with SMTP id
 h18-20020a056902009200b008ddb0362f61mr149576ybs.2.1676792288605; Sat, 18 Feb
 2023 23:38:08 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD1k4S-J0UXiFS9mdn_TqGc2kb3iaVYUP2ektrJ+uJZMWw@mail.gmail.com>
 <20230219035724.99907-1-five231003@gmail.com>
In-Reply-To: <20230219035724.99907-1-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 19 Feb 2023 08:37:57 +0100
Message-ID: <CAP8UFD3TywqERjb7NjUXCqgherojnKcD5NDy9T_RE2Ldubd2hQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2023 at 4:57 AM Kousik Sanagavarapu
<five231003@gmail.com> wrote:
>
> On Sat, 18 Feb 2023 at 22:30, Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > I am not so sure it will be helpful for any of the GSoC project ideas
> > we propose, but feel free to work on it if you want.
>
> Well, I wanted to work on something before I started working on my application
> and found this to be fun. So even if it would not really be
> helpful for the project ideas proposed, I would still like to work on it as
> something that could go into my application.

Sure, you can mention anything you did related to the project in your
application and we will take it into account.

Thanks,
Christian.
