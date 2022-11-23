Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EC9C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 05:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiKWFeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 00:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiKWFeD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 00:34:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6CF1D86
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 21:34:02 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id g5so6529077pjp.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 21:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H+PT9pwMofXfSjnGrOqD84X9ESWXN/zEedchnhG6B58=;
        b=kMJ3fnSj9RNiFHfg+gu9Maa8SlN+0YWrem/RSB/nWEBHIvjbZ+erDUFZ0EcxCgwPcJ
         0SvwDxMiXW8TtdX7nvlmbJS0tG/0DTSeKA3SzhPcSrEUpk4/gmjxhG0j2LrKYg1ymv4Z
         HTblZOoMEGf/heu4zceNERWUyEy2arJxF/jeQv4ZFbhjdtQXn5XTeI1IYlLbWoJfRgeJ
         mQ82Yg+I7U847drtZhs0ROcpTjVat1EJGdwoAkAXt78iso5o6kgH7i0/unPudHGR1yhA
         MFhFvKvtr9yEjF21mevSmrBxI/S2nJVZ2ABdoWHEiy9unD+UvaMUnI/PjWKGON39MTqg
         yKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+PT9pwMofXfSjnGrOqD84X9ESWXN/zEedchnhG6B58=;
        b=nambsQqr3PgV/1VTowyFB2lwaVmVA3+LHjvUKdS5nQfX06Anf8k6jTVNXxjCMKZIoH
         nRup4pS3PSZrgIQrK77QubBNOH+rELZDJLT+kB2gc8dMNpBXQt4tKW/BVJAJZ+PD41l4
         nkR/FmGRQUAi99lTCjwU2cGMwxYV2pDzp/LJgvsPetDgACK3aNzt/V5Rx/EzCZFlhz9i
         zUQscK5tM50H/u1VjoAZaVLqslbuXDOFT6YbzaPgzw8nETIgcjYPH9gwBSYIFx6/MhkC
         dIld35ebtjfEWEUWcZ5UiJ5ivF5hh4Yz0KRyX4/yqSkGtaOI0swuDfV6t5W98wiDy7T7
         W0yQ==
X-Gm-Message-State: ANoB5pnB5pzX7P3tmN7B4LSCw792gJQJ/OpkaFqB8Ygb8t+B1Qftz7Hl
        xK9GS52i6f8HO+SN65D6iDcZVfFSSwGQNFRlF5w=
X-Google-Smtp-Source: AA0mqf5wYH2jczfmf1zQki6SeLLjOnZ1IfgGTMzKp/g/HTxy3xAs+RAIdq9iMj5nzVe2u72NWeNs40b+fEBalpvZpLs=
X-Received: by 2002:a17:90b:3d90:b0:200:7cf7:3d79 with SMTP id
 pq16-20020a17090b3d9000b002007cf73d79mr33780525pjb.206.1669181641993; Tue, 22
 Nov 2022 21:34:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com> <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
In-Reply-To: <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Wed, 23 Nov 2022 14:33:50 +0900
Message-ID: <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 3:54 AM Jeff King <peff@peff.net> wrote:
> Hmm, I know I suggested using a temporary file since "cat $tmpfile"
> should be pretty safe. But it does still have problems if your tmp
> directory has spaces. Or even other metacharacters, which I think will
> be interpreted by the eval, since $@ is expanded in the outermost level
> of the shell.

Right. But the problem is not specific to emacs (it happens in vim too).
Let's fix it another time (as you noted, that's pretty unlikely, and we may
not even need to fix it).

> If we are going to use a tempfile, this logic should probably get
> stuffed into open_editor itself, like:
>
>   open_editor() {
>           editor=`git var GIT_EDITOR`
>           case "$editor" in
>           *emacs*)
>                   ...do-the-emacs-thing...
>           *)
>                   # assume anything else is vi-compatible
>                   eval "$editor -q \$1"
>           esac
>   }

Sure.
-- 
Yoichi NAKAYAMA
