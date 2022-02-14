Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72879C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiBNR1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:27:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBNR1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:27:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA029A1AC
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:27:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p9so16053830ejd.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gd0E9h3QBzonrqbrdpXlm2WPw38qbV+FAZdIIUpeIR8=;
        b=nZ/WsX2u2jLZKKh4p6LgE1krxioOZDvCVn9T7qwWipQplxT0XjJziYtARRIEKaI/PQ
         SGV1CnSFtovV8KSAeTchXW4FDTYRe0/mgohloJOGwbC7y/Fi4fASdYBjfy3rCKH7vV6D
         1rcOWmUUG7XhXErqDvU06EkZZgUNI5c5mrpKBJtWO/Yontu43Z/kT6nwcOny+0p+Gwxg
         fq7iUyCcwAZmaERP1rQCtGSBW67+S4vG9JJkdZ2XASLxLaK6c9XumD/OCtCT5eaVPXBp
         oCNICMxiSSWe1oSGHfkZ4x9zEtSvqsJXROG8U6+qrI89HBECBFR/Aed3YSzdFeVfa4hU
         Z8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gd0E9h3QBzonrqbrdpXlm2WPw38qbV+FAZdIIUpeIR8=;
        b=hkH65CEJxWSI/4tbXxdEIE2AD1RWAHuG2hhRk5AVS09Hp6lrTHd0hChg68sdtVqGSq
         /yXAkVisZ44InLkSbEJKCDwyHgcXbyrxmYQ57emYBuV8sGC4yetox32sKyW5k3OQKIn+
         Ppq+fXv1uylgxJGFu63vUqdTUA1mAXCIUNtg0+OMpeaab7+FFwcIXUwYF/5DEVwa1LyD
         ujM8VQhDI6xgPz7PcnpWTv0wkKtCHdHHMCoDhA1bG8/a0lrzWJ60zGOw+X36PosnI+jN
         /yadrXQ1twhJ+ExwwpKjowRE7qTUJrsKsKQ1x1KG+4uk1NhmNeq7LW7vG1jP3hgxBAyR
         1eQQ==
X-Gm-Message-State: AOAM531AZzQvsBLc2qr+fyH1jz43l8iTHrqAlfrbf7qkmdme8ACFAzes
        iaLfocTM1IaNjY9ETgfWIU2k65AWfd0=
X-Google-Smtp-Source: ABdhPJycIIS9yDWfIVGjtRNOuEzHvfNks3KHg3OZWWgurA0lzgPpPSoKeBQ1lO0EaoNPofvHncQuXw==
X-Received: by 2002:a17:906:9b87:: with SMTP id dd7mr526518ejc.552.1644859622207;
        Mon, 14 Feb 2022 09:27:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l19sm2741156edb.87.2022.02.14.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:27:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nJf7t-001b6G-9p;
        Mon, 14 Feb 2022 18:27:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/5] date.[ch] API: split from cache.h, add API docs,
 stop leaking memory
Date:   Mon, 14 Feb 2022 18:25:58 +0100
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
Message-ID: <220214.86czjpxst6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 05 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Fix memory leaks in the date.[ch] API, in preparation for larger
> changes to make the revision walking API stop leaking memory.
>
> This is a trivial re-roll to v1, to fix an issue that "make hdr-check"
> spotted. For v1 see:
> https://lore.kernel.org/git/cover-0.5-00000000000-20220202T195651Z-avarab=
@gmail.com/

Junio: I think this series may have fallen between the cracks. Any
chance you're willing to pick this up? I'm keen to submit the larger
revision.[ch] leak fixes in this cycle, and this is one of the few
remaining dependencies for that.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>   cache.h: remove always unused show_date_human() declaration
>   date API: create a date.h, split from cache.h
>   date API: provide and use a DATE_MODE_INIT
>   date API: add basic API docs
>   date API: add and use a date_mode_release()
>
>  archive-zip.c         |  1 +
>  builtin/am.c          |  1 +
>  builtin/commit.c      |  1 +
>  builtin/fast-import.c |  1 +
>  builtin/show-branch.c |  1 +
>  builtin/tag.c         |  1 +
>  cache.h               | 50 -----------------------------
>  config.c              |  1 +
>  date.c                |  9 ++++--
>  date.h                | 73 +++++++++++++++++++++++++++++++++++++++++++
>  http-backend.c        |  1 +
>  ident.c               |  1 +
>  object-name.c         |  1 +
>  pretty.h              | 10 ++++++
>  ref-filter.c          |  3 +-
>  reflog-walk.h         |  1 +
>  refs.c                |  1 +
>  strbuf.c              |  1 +
>  t/helper/test-date.c  |  5 ++-
>  t/t0006-date.sh       |  2 ++
>  20 files changed, 111 insertions(+), 54 deletions(-)
>  create mode 100644 date.h
>
> Range-diff against v1:
> 1:  fb21bd7b2c5 =3D 1:  fb21bd7b2c5 cache.h: remove always unused show_da=
te_human() declaration
> 2:  7de62956db4 ! 2:  96c904d0b9a date API: create a date.h, split from c=
ache.h
>     @@ pretty.h: int format_set_trailers_options(struct process_trailer_o=
ptions *opts,
>      +
>       #endif /* PRETTY_H */
>=20=20=20=20=20=20
>     + ## reflog-walk.h ##
>     +@@
>     +=20
>     + struct commit;
>     + struct reflog_walk_info;
>     ++struct date_mode;
>     +=20
>     + void init_reflog_walk(struct reflog_walk_info **info);
>     + int add_reflog_for_walk(struct reflog_walk_info *info,
>     +
>       ## refs.c ##
>      @@
>       #include "strvec.h"
> 3:  2d5210f9421 =3D 3:  9ef003a83bd date API: provide and use a DATE_MODE=
_INIT
> 4:  aab2ae9cc72 =3D 4:  3f70b1aa4c5 date API: add basic API docs
> 5:  b67e23549ed =3D 5:  60dbadacb16 date API: add and use a date_mode_rel=
ease()

