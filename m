Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA8BC7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 14:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjFAOdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjFAOdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 10:33:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF82128
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 07:33:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af177f12d1so13254671fa.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685630021; x=1688222021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCih4jyhhV70XJw3KzlfVTAavvt6OJIdNTiZ+E3ZJKY=;
        b=n/nEYuzWcsx33F906D6e/ZS5V2a1H2UeAWYb6UkXPYERZWuHi9h2XYOCaX/xpQC3Ft
         I5fYt68Mcb3ze7vNea73AT9t+7yCyzFkGng6A1JIjKkbtBivRtlH348UaXTeYVmKbOJM
         bYAOUq/yUUFNfn7WzI7Q30WYDH7S52++vx7ezyet51zHiCm7g6c5RyCy8+JfbCweIkkg
         zkFBcDJfxEmIGdmmXTPKNc6JNMt2EczqkKAY/aCmKySapfmUZXIil9eDMVVQxrRCkG8e
         pggzlqul2PoGaNqHBNHCJmbMxF5TQ+XudTForbLKmtSDLgLEoqUaUJKgZA8TXmWWeFd+
         9pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685630021; x=1688222021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCih4jyhhV70XJw3KzlfVTAavvt6OJIdNTiZ+E3ZJKY=;
        b=BYNInK8A8okp2vpd2wjmNsq00AKuMdop9E5sJ31IYgaZAKCvlhA5oX0MlqbebcxcxI
         NFEaJK95+6brBn1P9ulsQ+33S5xqW7zHyS+/dpqlqG60RRozRAg2OgbpqnEX50Qzt0lL
         mCjnEtC1i2hQrA/W28mhBFy0rX7U+hrTeFfjL9xbtFBjkqoGpjDOPfgJLfNpWCXIb2Dt
         9PnXpOuPCeOtQNbV5C6T+WZEaEAcynVExN6S1bzMUvDGOJtjNcM1ppUeTBlYmW7acfCR
         Cs08M/9h10Wo4ttXSrsY2kt1I2i1okbxoe9vUbH68Y7prrbd9Omr2BRfpMyKMVRt4BUT
         Qbrw==
X-Gm-Message-State: AC+VfDwZXbxC5mhPuaRWoq+c947AoAVNUcSWCeyuEt7cb9BBEyZ+dsDF
        sOGk4tGZrAYpcFaVNdlZbnZ11IPrUo3B1y8RWhHPSppu3Ps=
X-Google-Smtp-Source: ACHHUZ6By71TTV5xI62USe3f2rLxt2Brj2FiTjpzZG6DvoNdQHSE2ECe9oSA1y70HV7b/bVxZEma4p+m37OXg+Fhg+s=
X-Received: by 2002:a05:651c:112:b0:2ad:fef4:94f8 with SMTP id
 a18-20020a05651c011200b002adfef494f8mr5185366ljb.6.1685630021119; Thu, 01 Jun
 2023 07:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOO-Oz2ua31xDOA9hdE-mMx3qwctDHK6Tu6AKdGc1_beuJMkwA@mail.gmail.com>
In-Reply-To: <CAOO-Oz2ua31xDOA9hdE-mMx3qwctDHK6Tu6AKdGc1_beuJMkwA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Jun 2023 07:33:26 -0700
Message-ID: <CABPp-BHKR5GP2NUFWDMSw-Pnra+yGP0kYAiwu-iWgtu66p-1RQ@mail.gmail.com>
Subject: Re: Problems with 592fc5b349
To:     =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2023 at 6:47=E2=80=AFAM Alejandro R. Sede=C3=B1o <asedeno@mi=
t.edu> wrote:
>
> 592fc5b3495bf4ff17252d31109f1d9c0134684b moved backup definitions of
>
>   #define DT_
>
> from cache.h to dir.h, but did not include dir.h in cache.h despite those
> #defines being used there. Easy fix, `#include "dir.h"` in cache.h,
> which I'd submit as a patch, but then name-hash.c, which includes
> cache.h, which would now include dir.h, ends up with two definitions
> of `struct dir_entry`.
>
> Suggestions?

Oh, interesting; none of our platform testing caught this.  After a
little digging, I'm guessing you're on cygwin < 1.7?  However, I'm
still surprised you noticed, on any platform.  The only use of the
DT_* defines in cache.h is in the inline function ce_to_dtype().  The
only places ce_to_dtype() is used are in (1) unpack-trees.c (which
includes both cache.h and dir.h) and (2) builtin/ls-files.c (which
also includes both cache.h and dir.h).  So, as far as I can tell, this
can't cause compilation issues anywhere.  How did you find this?

In commits in follow-on series, I moved this inline function to a new
header, read-cache.h.  name-cache.c does not end up including that
header, so we could add a #include "dir.h" directive to read-cache.h.

An alternative fix, if you need something for v2.41.0 (am I guessing
correctly that you tried out v2.41.0 right after it's release and
that's when you found this?), would be to move the DT_ defines from
dir.h to statinfo.h (a header included by both dir.h and cache.h).  Or
perhaps another fix is to stop having two things in the codebase named
"struct dir_entry", since it's bound to cause confusion for humans if
not also be a lurking timebomb for some future code file that needs
access to both.  But I still don't understand why any suggestions are
needed for an immediate fix, since all users of ce_to_dtype() should
have the necessary headers.  Is there an issue where "inline" is
ignored, and this function is being defined & compiled for every file
that includes cache.h, and then the linker removes the duplicates or
something?
