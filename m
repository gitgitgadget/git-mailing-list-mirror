Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED37C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbiCCQO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiCCQO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:14:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE802106CA8
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:13:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w4so4740340edc.7
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G7vS2Nvz5mG8b8Xp207bBYEkpj4JzbgRWqB/UqPYWRE=;
        b=F2yrvN6FyDAV5nT9mxfk/5e+TRtQ4/Q2YyEKYwkPXPVJVr34voGO3MqBlExvjkrnXg
         TNeEs2Dgw1e7VgbnMfQDV5fnA/3w3JWzhO53lrc1Pser64ESJCURG0dOl5IIYQ7dxF9U
         WBwGiMfLteCrCUlhHsqmGr5bBwMaDXWFSjfjL19wFEVfcJfjxVh+kAIf5VnnieGn7WUh
         ZPk+moE77HXc2MvZeKLzqFolJi6LgyVym3ExCTPywoRxIZjlhqrsXnwVj+RZUML0lbuR
         aW13IK2wwjsxUsvkuC7QwrMf7TvBADbbA8xyqbJR2QNrJM6abSU6yj7GQPWsY1IfXQsT
         bj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G7vS2Nvz5mG8b8Xp207bBYEkpj4JzbgRWqB/UqPYWRE=;
        b=pHEZ4GR3xd2gPr/q6jye3aBgunq3M70DZ0xwvUrWYXzgUvE5spH1jWmRChqgxo3zgy
         T95wJK5p6SboDiy8TU3G8jCKXYym4uFJhZTCMy5CIO9N/e4bKTdu+1RiaLfH6IeCTwzk
         32qzvpyjIuV2hP8f8Xt+1rTlqXrQEHRLe9iVF/6s7tQr1wORGSrtXJWbO6F6/ZzmUl79
         61w62U44dIUViFLF859Nfah1Y68mFSttjCW8b9rU4R8cLChZWIhWCHjmiGy84e6lszTb
         TssHbKh3/coCT2i/reZFrLHQN/rMjE7p2uZjWffbhNbgE785gIUrAlMa9Q4Zd3hRhah/
         HQzQ==
X-Gm-Message-State: AOAM531xr1fqXHlNYQ05fo6SlfENSnvKhUtlFNYpMlcLBpZjE5FuGFzP
        xrW+VCbih0DdOoa5KDJCdE0=
X-Google-Smtp-Source: ABdhPJxbuR7F6XFYhV9tXQLmnFsgvnPh7au5eYzQqYMAblCC+pI4DuXrzjmwhTlRic3msgqgVeWffQ==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr4518376edt.62.1646324020415;
        Thu, 03 Mar 2022 08:13:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm829395ejm.103.2022.03.03.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:13:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPo5D-000d6e-8f;
        Thu, 03 Mar 2022 17:13:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: ab/object-file-api-updates (was: What's cooking in git.git (Feb
 2022, #08; Mon, 28))
Date:   Thu, 03 Mar 2022 17:11:46 +0100
References: <xmqqmti9ssah.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqmti9ssah.fsf@gitster.g>
Message-ID: <220303.86v8wv2evg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Junio C Hamano wrote:

> * ab/object-file-api-updates (2022-02-25) 12 commits
>  - object-file API: pass an enum to read_object_with_reference()
>  - object-file.c: add a literal version of write_object_file_prepare()
>  - object-file API: have hash_object_file() take "enum object_type"
>  - object API: rename hash_object_file_literally() to write_*()
>  - object-file API: split up and simplify check_object_signature()
>  - object API users + docs: check <0, not !0 with check_object_signature()
>  - object API docs: move check_object_signature() docs to cache.h
>  - object API: correct "buf" v.s. "map" mismatch in *.c and *.h
>  - object-file API: have write_object_file() take "enum object_type"
>  - object-file API: add a format_object_header() function
>  - object-file API: return "void", not "int" from hash_object_file()
>  - object-file.c: split up declaration of unrelated variables
>
>  Object-file API shuffling.
>
>  Needs review.
>  source: <cover-v3-00.12-00000000000-20220204T234435Z-avarab@gmail.com>

Jiang Xin (whose git-unpack-objects series at [1] depends on this) has
looked this over & acked it at [2].

1. https://lore.kernel.org/git/cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com/
2. https://lore.kernel.org/git/CANYiYbFZN=mvcxRT4Cf4Gzao89KR2UjMJXnJM63S2zAtbD32Jg@mail.gmail.com/
