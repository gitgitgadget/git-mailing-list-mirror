Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76434C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 12:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiEIM5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiEIM5V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 08:57:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1B939EE
        for <git@vger.kernel.org>; Mon,  9 May 2022 05:53:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so26588935ejd.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M06dSgfrC6HcF4UFIkbQw3Jwwst8NWqfmdtSMOYAJzU=;
        b=GcRfsuNorJSDN5mF77My2psnfUCaJyHH/+bD69sDvAQaQrESxdFjKE5tljfe/7Po3B
         PjX3+SVSOw5ICuAotffSO9VX1SfnktwDZfhCA2gCZoF0hSzx0UP4pYatDr/uYXXSL27N
         MdlxXP91xFbopUYl7YlqpJIV4qIHchOnCjZUMTo2Iq+nNdWkjA5/VrXuY9bDvOyE6SNz
         3TUzZkWDaXjmh0MkmJZl30oUrVzvvsVf/fZAVxII0RawTabJ5mrX8lNg3ywRJPPLy68I
         KffezX3ReKlEz6HEASC2194p2RHHU1ctlGgqnnzbyQrzqEYPsY1m9nfT15MkUpMBh9nT
         arEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M06dSgfrC6HcF4UFIkbQw3Jwwst8NWqfmdtSMOYAJzU=;
        b=iHZwP1AspDlOTZXzP5Gxf9sNlfmgObFotxtpBSrIUr7eRj8Kn08V4fEnakkfjk03ty
         zONzzZXdAw+XKUOSEf+XwbJ4MAdOQcjvkFo9LhAd3PuA/WpiLgLQ6CrzOWJM/VAChK3J
         IxlcdebKlG6pGxiw9gSwgHS9CovEAYlgy+kJdI3ZndRFwpcQDifEGc4mfe28+wNxMgjV
         O74VXmHQktlMcDokPdwzT46L3PQDqqMB0VlBZ3/F3S/tqX68aPG3+bIeKkHwCBjHy14a
         50rzAsQPUETkhnofg8yS72zaUuastPNIF+ED2lQk5hSj4B1gfgIy9TF0e1s4VrKiS2uA
         vZ2g==
X-Gm-Message-State: AOAM531ECJffDY5lwaTjz5H4tY6SMhPQ52d8kwyhvVM+6TD1eJbdzQ2N
        ZfyLXFD3MWSfDxLfDPnawkbFrOMEryEwy/yvCfk=
X-Google-Smtp-Source: ABdhPJyTXwkoPegxPPP9UCx3Nn3EBvXdq7+hTRHgw0QEFc42cgO36wQHeTFp0Cora5L8ZzjLsZ8qLe4v174mCCus8D4=
X-Received: by 2002:a17:906:99c1:b0:6ef:d995:11ac with SMTP id
 s1-20020a17090699c100b006efd99511acmr13790193ejn.244.1652100806339; Mon, 09
 May 2022 05:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1219.git.git.1645386173.gitgitgadget@gmail.com> <CAOeUTushdpiVAADjE8NQ_-EgHpz5sHKErBjW8-8O23foVnK5cA@mail.gmail.com>
In-Reply-To: <CAOeUTushdpiVAADjE8NQ_-EgHpz5sHKErBjW8-8O23foVnK5cA@mail.gmail.com>
From:   Halil SEN <halilsen@gmail.com>
Date:   Mon, 9 May 2022 14:53:14 +0200
Message-ID: <CAOeUTutqtfHj9C=dZ-9Nn44FcY94HQYcVPid9mxD96Goo1WPZg@mail.gmail.com>
Subject: Re: [PREVIEW 0/2] gitk: include y coord in recorded sash position
To:     Halil Sen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just realized that this is the "preview" message and the Patch is here:

https://lore.kernel.org/git/pull.1219.git.git.1645386457.gitgitgadget@gmail.com/
