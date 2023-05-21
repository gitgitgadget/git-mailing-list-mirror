Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BD9C77B73
	for <git@archiver.kernel.org>; Sun, 21 May 2023 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjEUMX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 May 2023 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUMX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2023 08:23:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7376FB0
        for <git@vger.kernel.org>; Sun, 21 May 2023 05:23:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5842611e87.3
        for <git@vger.kernel.org>; Sun, 21 May 2023 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684671805; x=1687263805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlVhRDOpD1cKRJBZIWLSquLdxgnDVDqhh1F9QVFy5i4=;
        b=MuSHD9w47Fs77wrGW3+or38WVrZHuGIldJCYqEzH1ZQuIBMdGyWDAyqdGo8sgopltJ
         /apaOA78dCzWZJ0RGTSV8rItYyj8tginh02YNCAoAwTFIgZ8IQREBaqv0yO5gr/9Yko2
         yQc+vG8Audq3g3Xs0rZVTUwDU6Kla4W4p86LQwgvjejHR1u/fC2KcqRy9NtW6oyodqKt
         3nbJM4R+3Zt4VdT5I6EF+mnRfbJ+EOC6ChKqub8H4Qe/518Xa02waCGF3DBSYnv4UWgo
         c+rC7uvqUNErGQgM9MtjyuHaBirdwtcUfXBjBKzrlipU1rjyqTuwYBZx5IiD6ee2XXNC
         6dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684671805; x=1687263805;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlVhRDOpD1cKRJBZIWLSquLdxgnDVDqhh1F9QVFy5i4=;
        b=RImeQFoIG/xu4NiKnJhgCbk8XlrJPhK8PjgVuR344pZ8x2X5VI26StlBr+Btyt3nhf
         JYvhZ6ZFyGkOcYVxccJybjUZV9HrPlIllPbysFcLiPSkTCudJLWc10g2clmX/75msnE7
         j7Km09X7SasJ7yUuwV4+Gn71p0uR9q+mnHI67D89xvqETXvrBWZarCMX8NVTrh7THbax
         teD9ezUtnoNNUULs68/1WwP3ztTYXhZrlabB0SotTzOl2t7+Uh3L1oZDoZSOJ7AKmgfE
         E29aGPj5SaK+RwyJlUClmH+IPbwRyyZ7ldwmGSSnDxmLM8Vi0Izpt13gvc5Kxgigo7Rf
         Uyxw==
X-Gm-Message-State: AC+VfDxCAPZGqR+rVH2dAkcbOaucbfJXUYtpw+L3zSCgLPkXu1UIX6gj
        yKj2PJLPEpSqMkbpr4BuZTERPiL1fm0=
X-Google-Smtp-Source: ACHHUZ7MgMCCCKJIc62nChPuf3CFM884xQQ7Pt+Xjx4k3p+eln3D4ud9+5e0WZfh1cTP7W4fIxzNkA==
X-Received: by 2002:ac2:5dcc:0:b0:4f2:520e:f865 with SMTP id x12-20020ac25dcc000000b004f2520ef865mr2540372lfq.16.1684671805013;
        Sun, 21 May 2023 05:23:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a5-20020a19f805000000b004f2b6a203aasm601191lff.224.2023.05.21.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 05:23:24 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Minnie Shi <minnie.shi@gmail.com>, git@vger.kernel.org
Subject: Re: I think there is error in merge documents - current branch
References: <CAOQx3AYx+sSD4REfTdQ0muY2zRgzE2nR7RgG7cxNgXvwzYzixg@mail.gmail.com>
        <xmqq353qk59y.fsf@gitster.g>
Date:   Sun, 21 May 2023 15:23:23 +0300
In-Reply-To: <xmqq353qk59y.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        21 May 2023 07:27:21 +0900")
Message-ID: <87zg5xq3es.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Minnie Shi <minnie.shi@gmail.com> writes:
>
>> in summary the sentence should be read as
>>
>> Before the operation, ORIG_HEAD is set to the tip of the current branch (H).
>> instead of
>> Before the operation, ORIG_HEAD is set to the tip of the current branch (C).
>
> Not C but G (i.e. the tip _before_ the history is updated).
>
> I notice that we overuse "current" there.  One is to refer to the
> most recent commit on a branch, the other is to refer to the branch
> that is checked out.  For the former, we say "the tip" in the other
> sentence, and it probably will make it less ambiguous if used that
> phrase.
>
>     Then "`git merge topic`" will replay the changes made on the
>     `topic` branch since it diverged from `master` (i.e., `E`) until
>     the commit at the tip of the `topic` (`C`) on top of `master`,
>     and record the result
>     in a new commit along with the names of the two parent commits and
>     a log message from the user describing the changes. Before the operation,
>     `ORIG_HEAD` is set to the tip of the current branch (`G`).
>
> My reading also hiccupped with "replay"; the first sentence to
> explain the command says "incorporate the changes", and that may be
> a less confusing expression; "replay" somehow makes me imagine that
> the changes are cherry-picked one by one---it may be only me, so I
> left it as-is in the suggestion above.

For me "apply changes" or even "apply cumulative changes" works much
better than "replay changes" in this context, especially provided we
will apparently have "git replay" soon.

Thanks,
-- Sergey Organov
