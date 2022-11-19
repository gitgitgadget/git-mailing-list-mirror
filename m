Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E9C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 23:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiKSX7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiKSX7S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 18:59:18 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679A11583E
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:59:17 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id b11so7538553pjp.2
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrM5fvMHxVbxF1Qe6oSv9OkTIvIUiRurhBvFRH58MpQ=;
        b=ICOmYm5+oYnVwB33Ny82jb/ZZ4EPn069itXwn+l292liHp9yEUeMZsPPomVuEj6W7p
         kDgm2ytcs+G+3AU7hCPN1qkC1QiFJvZxw8ghTB2vY3WQdG833aBP3D3mRNBhB0appuCt
         h2noe6z9nIw7C+H2MokEKgxq4JwCjjgoCLzuO3OHtsWQGAFx+i2W+gjjcQoTPA64TATO
         YVkNhs/qcLc7y5FrNfeAi9Y0uSUKE47M8yNONAM7ijJE2skpPa2vaLqDXUEH2dRNtsXH
         cWFRE/Wc15sSp8jwMzCjfgLLAlv1TxGe2h3Z3H4EZ6vMoRpxzzENOfl/jemrjDUnxJO0
         VVIg==
X-Gm-Message-State: ANoB5pnuZZl2HSlC3X9t9Jh7xR30sIBq4fConKSH5FHruN3ijlge1rBZ
        W9RaAnPE8F2WCeqmcHI/5D9ELvnZQnLSbcvUT+vgK2ai
X-Google-Smtp-Source: AA0mqf6rx4ETzcnkc9HTVrUgKvFMCwWKFA7bCWOswEisGUUl00IkiwgAeiQ3Oi+r7zQJ63KpTll3SCZ13HHHEQrjENw=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr5675971plo.12.1668902356778; Sat, 19
 Nov 2022 15:59:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
 <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
 <CAPig+cSMoAoVW_NTidyN0rgTTY-FaQ49CAFQZhPyaYBsYu-RfA@mail.gmail.com> <CAF5D8-ujg3Tp2s2+eGMgZfXXcZEyRKreAj=EkG0KiMniKjoKBQ@mail.gmail.com>
In-Reply-To: <CAF5D8-ujg3Tp2s2+eGMgZfXXcZEyRKreAj=EkG0KiMniKjoKBQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 19 Nov 2022 18:59:05 -0500
Message-ID: <CAPig+cR6+H2gqZbnj9FHzZRefwTjYme94kNeQ9qmVi-wLYZ6fw@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-jump: invoke emacsclient
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2022 at 6:44 PM Yoichi Nakayama
<yoichi.nakayama@gmail.com> wrote:
> On Sun, Nov 20, 2022 at 12:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Would it make sense to expand this to support the VISUAL and EDITOR
> > environment variables too? For instance, since I want to use Emacs for
> > all my editing needs, I have EDITOR set to reference emacsclient. So,
> > if GIT_EDITOR is unset, then check VISUAL, and if that is unset, check
> > EDITOR.
>
> "git var GIT_EDITOR" does respect VISUAL and EDITOR environment variables.
> See git-var(1) reference manual.

Excellent.

> > Also, on macOS, I need to set EDITOR (or GIT_EDITOR or VISUAL) to the
> > full path of emacsclient, but the regex used here is too tight to
> > recognize that. Perhaps loosening it to just 'emacsclient' would be a
> > good idea (as it seems unlikely to falsely match any other editor)?
>
> It is a good idea. Thanks!

Thanks.
