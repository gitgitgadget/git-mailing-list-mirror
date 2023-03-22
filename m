Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3012C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 23:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCVXSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 19:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCVXSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 19:18:00 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E984F96D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:17:59 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d22-20020a63d716000000b00502e3fb8ff3so5126723pgg.10
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 16:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679527078;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaSPUnI0RdXl6TE4ZDxjsplSf4yOc8MCrUxsNBnq6/s=;
        b=cL04acbXukUsl7tBp7A9j6/mp6Hgn7pO0ZtCg+U5jHqz2h1JZdBnLve4vHGw9CcxVI
         7ztGHZ/C50jUMbGLhwo9fXkhBv4fkpikx2N5pVHsoDvk+kCqxSeArEb7ho1KqyAyR7Hk
         Z+77gRLNRe4rh4cB/o7syU0aMkbKNLARWc4u8blhi2l3CWgAyRZXoNKYcRYuTzw1coRm
         3yyVSCv5G5n4UW+tr+tccZSHfKdI1GR8Wc7fF/WPlDA8AVpuMJeIohlgqxmPd7pW1ZQJ
         1e0C0wjKUzCVXZpliizbQ3PBiJeCXmR8V4WeyDHK3eu98qfp5CnrkwRcKpT9MWFAOpB+
         cbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679527078;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oaSPUnI0RdXl6TE4ZDxjsplSf4yOc8MCrUxsNBnq6/s=;
        b=xEk2Fu+yfqfCo/GtxtQhtavwsmq64ptFLf3zyh8pewRMLfkbfEHnJtAgqndlS4lsp/
         sTWOyMYAJuoSRMiAzyO8TDGHh6vkVAcrw6E7/4oM9eGcqkMgF6JvKU1RyIOlN64ZQ4+S
         kqOaTWvscvJLRHZaFOzqst4dudVcMAEeryP0ogN7ht3TZYwLZ6KKlqmJ6hAHv0BT2c5L
         7tMzEBDn3o1HnMYM+5HGats5k0WWOnSWcScGmpER+gNaj4Z6HkwPibgS7T6nkRUQrMV8
         HGq/tSAqfxeBAJgH+/MSrfzbrmy4hH/vMpxWKsjGot5U3zA3hxMcWH9AgZHHXUZWEd8j
         S09w==
X-Gm-Message-State: AAQBX9fineXna1qQ/mwb5rt+pAmDfxdu1fv3vWkLYsDmwxO5mbjRcCoJ
        Pn+c++dRi0OGNekGa8OP7woTdI+I5YMcYA==
X-Google-Smtp-Source: AKy350ZrAhyFagVOKCjj0Nobbraxlm7OmLukSdMd7EFlhZWN+zd7pAoewAEmtxPiD4Im7H7nTvr4iiHCUIzyKw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:e888:b0:19a:5953:e85c with SMTP
 id w8-20020a170902e88800b0019a5953e85cmr1883030plg.1.1679527078556; Wed, 22
 Mar 2023 16:17:58 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:17:56 -0700
In-Reply-To: <patch-05.17-36eae891341-20230317T152724Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-05.17-36eae891341-20230317T152724Z-avarab@gmail.com>
Message-ID: <kl6lbkkke5p7.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 05/17] cocci: apply the "cache.h" part of "the_repository.pending"
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> Apply the part of "the_repository.pending.cocci" pertaining to
> "cache.h".

Like Elijah, I skimmed most of these "apply cocci" patches, since the
code correctness would be enfoced by the compiler anyway.

For reasonableness, I checked that each patch did the following...

>  cache.h                                       | 15 ------

Remove the macros/function definitions from the header file being
touched.

>  contrib/coccinelle/the_repository.cocci       | 44 ++++++++++++++++

Add the relevant lines to contrib/coccinelle/the_repository.cocci

>  .../coccinelle/the_repository.pending.cocci   | 37 --------------

Remove the relevant lines from
contrib/coccinelle/the_repository.pending.cocci.

And all the patches did this, so the patch organization looks good :)
