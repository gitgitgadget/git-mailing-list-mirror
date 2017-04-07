Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D62D20966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932940AbdDGLih (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:38:37 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33019 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbdDGLif (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:38:35 -0400
Received: by mail-oi0-f42.google.com with SMTP id b187so82790924oif.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4tfuYHAEMbquL3bWbmSMhvIRlDgpfnTTNXw8KYEmvGk=;
        b=r5cLY0R82mWMX2hHiFWSs4lAFf0HoHTUcpV1cSs7YwNg63N8+iF2L8zb0FOZ6aOyao
         41eaRJ9W9CBGsw6G/xXJwPVLVQK5aYTQ+1C8fLcDwV4t0rx/9Ty4i2ZYzddVGr7umWhZ
         ne7aFO+YGZNWCzxexDwrknV3sgZRbCpJJXzgpyu8vElM6n7fACOTFSM85oVgMJID/DXH
         dR00y1aBt1ZZihOY4NUhP//MCKiDu48JA4eEDMrdFhCxYlTasAKc+lFIk4wFtvzJttbs
         9NL9PKuRs852Uwi0m2HO2jakPtUn3YyNauKKXfg528lknWhvobaS6eqaebGx+C5YGCDE
         ceZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4tfuYHAEMbquL3bWbmSMhvIRlDgpfnTTNXw8KYEmvGk=;
        b=ZDYMp5RuIJLB5+3r+G1UdPlIpdce0BGqiweR49+T6F3jWrAx7eV94cHQxt7j0Y3Whq
         dpMdS/TPAjHbQt6thpKKaVoWgvOwpD4UOJ49ZoMzoIyVdwS1gVHEj4UaXKFknNtkFZrW
         tLdEOly1WJqWtgyWtrKiSX+L3PMvzSf4MUgBQgP2rD9PQzWm+Sc8/tRBsUH0mlm1GU14
         IxginArMPrKLe2heKzZd5aqqLV0cKsV3z5kgRRGa5kuZg1TOxSo9egTuVpn7fj82n5R0
         jGtaVGHLcHFs3hqP3vFSh3+UObtGtptF32d9YvgFBl/EjyI/SKMrPlPy3pR4wyLRkTDI
         87yQ==
X-Gm-Message-State: AFeK/H3C+sUNGogpQsYT90/5QwGd2/Nz+vH7vqPpHjNShUh8yytLkItRazovBubG7agEfvBwquf4IV3SGosDqg==
X-Received: by 10.202.104.133 with SMTP id o5mr10554129oik.146.1491565115017;
 Fri, 07 Apr 2017 04:38:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 04:38:04 -0700 (PDT)
In-Reply-To: <7e63849fdb197cd66b229a28408845908fa844a7.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <7e63849fdb197cd66b229a28408845908fa844a7.1490966385.git.mhagger@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 18:38:04 +0700
Message-ID: <CACsJy8BM1nHhbKo9ioAP2OC2UU-RMWhmJ5OsYZwWYqek++DA0Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/20] refs: record the ref_store in ref_cache, not ref_dir
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Instead of keeping a pointer to the ref_store in every ref_dir entry,
> store it once in `struct ref_cache`, and change `struct ref_dir` to
> include a pointer to its containing `ref_cache` instead. This makes it
> easier to add to the information that is accessible from a `ref_dir`
> without increasing the size of every `ref_dir` instance.
...
> @@ -526,7 +526,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
>                  * lazily):
>                  */
>                 add_entry_to_dir(get_ref_dir(refs->loose->root),
> -                                create_dir_entry(refs, "refs/", 5, 1));
> +                                create_dir_entry(refs->loose, "refs/", 5, 1));

The commit message mentions nothing about this change. Is it intended?
-- 
Duy
