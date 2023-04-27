Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908E4C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbjD0OH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjD0OHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 10:07:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E846AE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 07:07:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-959a626b622so822726666b.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682604437; x=1685196437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxZwOYjtXIJbljHwUruiPnQh8yt1nENLk7+Vzjbego4=;
        b=h4mq/AXZw2WwOmlnaQKZ/OT3y7PidGUo3fv3QvpcTLHNNxJ7GbTt7UNzObmZEDxV1K
         TJrug3WFCXwMc+wn0j7KDjUvZ6zUXc1Ijcc8/x4tU/wxN4apbg+DprTFx3trgheERYaG
         26GCoSMHTzAQ4knZqxOcqwdvPxcz5J7YgC0Y+Ex6V81cwZFFycMqNdDdI8nMdlhK+Lao
         u3aJaCbD3Z7SHKNFz4pkpsZTB2vJuvTfK+5IDpK3KU/30q+d3ozLiTkPUUOdeGMonQpz
         48Eju67qESBHLKouKVBOoQfsSaY1Vl9tMVCMLK9xocFLz6SiETcofrgdN1HEQxtkKuAn
         freA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604437; x=1685196437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxZwOYjtXIJbljHwUruiPnQh8yt1nENLk7+Vzjbego4=;
        b=JErBWW6tlbOr9o1p1kwzcJWtfX903Sol70aniL8BEBUktvb+G37Re/9hUdbc9E2bPz
         FFtz1gue7OkEobwwwr6etwcJkrGYvD23arTizcZbSRw3H0sS5xXks/DsSBqMkuL9wnB2
         AMfYSkdfolFQENXatiAs4O0hXv1n1zJRX6ZIXFuaqHQhhaoUrCs3/O2Hsh3LcvRVkkR3
         BpYxJZpH5ylyRlXh881V7sySV8E/pifddBYkz+1hrDr3hQf8CM3AS+nrryy/bMm5ZGfE
         KxqDmfzEu+D9vf0P9emPxIDAAq65riZAJoPjkmZxqUKiqMIeo0jj6eMF4Di8QTbIqyp7
         08Zg==
X-Gm-Message-State: AC+VfDwU2Cxn+sGOshT+1s2PSG5svzMHszC7QahZG2mOlxi+JLQaQzSx
        /E4pdCygLCIAR0xpHb9//KVQ4bwCxptWk5fuXh0=
X-Google-Smtp-Source: ACHHUZ5OpxazBmdUdr/0n9lgYVn6IWcXeOZAYFaE8GtkbFb9okm4b/vLn8fcVJpsUvZnFqM47MmgMsFLLXRZXKwlK/U=
X-Received: by 2002:a17:906:7945:b0:94e:d688:c36d with SMTP id
 l5-20020a170906794500b0094ed688c36dmr2009456ejo.38.1682604436662; Thu, 27 Apr
 2023 07:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1470.git.git.1679109928556.gitgitgadget@gmail.com>
 <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com> <CAP8UFD1YG-NnHbG4kBmh7L=O3wVnYKHCd94xD6Up_+AwK1ABPQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1YG-NnHbG4kBmh7L=O3wVnYKHCd94xD6Up_+AwK1ABPQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Apr 2023 16:07:05 +0200
Message-ID: <CAP8UFD3pqk1LrdA=FuRbfT+xHs4iBa6SxwmHUa1R7mXH5MmH-A@mail.gmail.com>
Subject: Re: [PATCH v2] attr: teach "--attr-source=<tree>" global option to "git"
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 4:02=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:

> >      -    Add an environment variable GIT_ATTR_SOURCE that is set when
> >      -    --attr-source is passed in, so that subprocesses use the same=
 value for
> >      -    the attributes source tree.
> >      +    Additionally, add an environment variable GIT_ATTR_SOURCE tha=
t is set
> >      +    when --attr-source is passed in, so that subprocesses use the=
 same value
> >      +    for the attributes source tree.
> >
> >      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >           Signed-off-by: John Cai <johncai86@gmail.com>
>
> If the patch is from Junio, I think you should keep his Signed-off-by. If=
 you

I wanted to say that if you take ownership of the patch as Junio
suggested, I think it should be Ok either way.
