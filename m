Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3CC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBUV3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBUV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:29:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53E92006F
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:28:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s26so22644729edw.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38y0YWrt6umdR+u74IbWFJOOKgf2bYjuQ2Vr0LLAPVc=;
        b=cwJmetJ+JB4kyrg/8gkSLSBm6/CVHi3oCY7yGqxo9brWjlkF/ey1iwrlL2xsfdLN5I
         zKWTkSPDNP5w6003tOe14jVuhYyhsws1gF6wzEW+etLoFnBCP9dr5XaI356/Mb8J/GL1
         Eo7ms5wlaML0imJZqYvXJt12CEppLGlEm6R4bLsGwqo9d+Yq3/06kAN2YXCQvMdyI5jL
         iBxkXq0I601aaneYGYCeAzFm73BJ6+6fTl+vzfaahWhwVgSWV4UOGMDWrglsZdVCe/9Y
         OREYjQwpFFCCbdRQPo4xpvo6O5Vau7AfpfMbuyLL3CGgeXGw623l0nJI297kqWLTOHSx
         w7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38y0YWrt6umdR+u74IbWFJOOKgf2bYjuQ2Vr0LLAPVc=;
        b=f10u73jK7IAi6ND2tbBHrXs4Y+WTGV9F8nnUf68P8uluXC2MI66IbmjKFognY02bOa
         5+GlbtwFc1XJowc6qzIVFUXQseMtk8Qrl4ky7/oiVJLlynD0YTjhfuJnmMVwycWzz8Y5
         RSBEXZxzSG6XkUDvyjkef3q7GhQIVfST+1SwEfTT6RTUHjVOZ3gJTzueQvcnwOQqt9ao
         hkeZK355YAWkmoMRM7jNLvUZC6/hrlqyk9xYLZGRYQYya/HU8P3/HFEgjBO3QSp5PLWo
         QDHlWcmUlWvVl9uDQuNADlVlmRbErmgNtrQKr7001MDhP6gwVtV6qoH4cEkXHdqUBr61
         HT7g==
X-Gm-Message-State: AO0yUKUOeptbDs7N5hzmPjsCzxkP8PNfb+oqZpoPp6T8wf/5KjUG6Z/j
        nB4i9YMxlieaK/lYg/WZ1jdE78Unh+sHXd/s5H+E4GOA
X-Google-Smtp-Source: AK7set8rN9217Fdfs2+FBUvMfs0oKjE/4/dWKxREWBSpQA6iZsGmhG/uNxalx56WlfqAQBZDiJlIBRvE0zJizQBU4Nk=
X-Received: by 2002:a50:baa4:0:b0:4ac:20b:96b0 with SMTP id
 x33-20020a50baa4000000b004ac020b96b0mr2694491ede.3.1677014917426; Tue, 21 Feb
 2023 13:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20230219174631.1040-1-andy.koppe@gmail.com> <xmqqv8jwggsp.fsf@gitster.g>
In-Reply-To: <xmqqv8jwggsp.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Tue, 21 Feb 2023 21:28:25 +0000
Message-ID: <CAHWeT-bqnwUxcaGOK7XD0wmmc6BaW2x6Gqhu107vZeU=U6Rm8g@mail.gmail.com>
Subject: Re: [PATCH] log: omit tag prefix for color decoration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Feb 2023 at 21:36, Junio C Hamano wrote:
>
> Andy Koppe writes:
>
> > Omit the "tag: " prefix for tags in commit decorations when coloring is
> > enabled. The prefix isn't necessary as such when tags are distinguished
> > by color already, and omitting it saves a bit of space and visual noise.
>
> As somebody whose color perception is weaker than other people, I am
> torn about this line of changes.  Accessibiilty folks often warn us
> against designing UI that differentiates two things only by painting
> them in two different colors "to be inclusive", and the above goes
> directly against their guidelines.
>
> The only saving grace in this case is that I expect that tags are
> named very differently from topics in well managed projects, and
> users can tell withotu "tag:" prefix even in the output without
> colors, and that si why I said "I am torn", not I am not outright
> 100% negative, but still I doubt that the upside of shortening 4
> display spaces is worth going directly against inclusion advocates.

I can't argue with that, particularly when changing default behavior.

Would you welcome a patch instead that implements a new %r pretty
format placeholder alongside %d and %D that lists the refs separated
by spaces only, i.e. without parentheses, commas or tag prefixes?

               %d
                   ref names, like the --decorate option of git-log(1)

               %D
                   ref names without the " (", ")" wrapping.

               %r
                   ref names only

(Having looked at the relevant code, I think it should still be a
fairly small change.)
