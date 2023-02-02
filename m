Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA12C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjBBUsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjBBUr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:47:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AAF1F91E
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:47:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id lu11so9646151ejb.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDX57KqkGXkCbM6IQ9rwx4xcxzwqrUG+msYwxGXJkQo=;
        b=et+csyvYYuWl1DgOZ+KcykW8fT1JbLaZszKRHpbuSOdo6Vt70z4W6lBukzaWOrlnRN
         vUkai3nv9RUXW423+ORGGz57dq3CJnymqXmlE9XHE3tWMwaUqtImVl4gTA37UWDtvVFS
         LWHnpiFuvNYkcUykkXVSzvsYcD+HHmS9dwdSTg3WXQ5/FfpCM4WWT1p2WNvFuP6VQ92O
         KiCsuTG54K0oo9jUVnK9n2lDCPgITe60ORIhKbHZQv9YWvvgBESLDJzJ+ymT9YIj+dnu
         8w+OQzXZPOiTdnwbN/9mTO/b+ARWDiy7OZbz1UFcmZtQ65Sh1DpUi6XZ44JnRvyBlNy3
         PvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDX57KqkGXkCbM6IQ9rwx4xcxzwqrUG+msYwxGXJkQo=;
        b=EqF0aC6+PUYs8F7+iuZgCbW50cXSiA4++w1CFn+S/YOBT2i0+R1O6ZlcQGMIIUfEBj
         /633j/Ccgg3o8p105Cwe27vxuyTykHSDXFHjKLioJMLIddLXwIcVwKUr38IDEd2kKQt9
         lwypSjqQCKfm97RENG3WyBqa/dzwJf/Pw6Q9AvlwPMzTzowfv0dwdx63aj0KBu6h52+R
         H/8tdsdfnmgZyeRx+e4OcQ6t9NbQW+/9LmAQOerqdj0rjWehBrghWOJlTA7WnDqvneI6
         /sza2Gdi3ctJiOxQfZ/HlmCX7QCyScKK0mRktfl7LYM0HQ92Wvm9a54en5+H8v1N0jIY
         NoEA==
X-Gm-Message-State: AO0yUKV82ojCwEMFEZxfrr6Qz6/JK+nyDYa2gkUaFgKdq9U1wQbWcu9c
        xk6VfCNiYZ19yG4rCHk6Vq9lj9k/j3l9erpIAoleal/ne30=
X-Google-Smtp-Source: AK7set8BcLSqaOzVkkGUmfLgDkWiMgnWBYKAU9JkASIQtqk3kg1EJvR+3R1Asw9l17KT57KnwJeqqFZQZMGQQwVyH0Q=
X-Received: by 2002:a17:906:5048:b0:88a:47d7:3c3a with SMTP id
 e8-20020a170906504800b0088a47d73c3amr2421661ejk.182.1675370860181; Thu, 02
 Feb 2023 12:47:40 -0800 (PST)
MIME-Version: 1.0
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com> <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
In-Reply-To: <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Thu, 2 Feb 2023 15:47:28 -0500
Message-ID: <CALnO6CA3LL2TbMyvVsgeNgGHr9tGq4-FYR0-RMyJJiMvV3P91w@mail.gmail.com>
Subject: Re: grep: fix multibyte regex handling under macOS (1819ad327b7a1f19540a819813b70a0e8a7f798f)
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 1, 2023 at 6:03 PM Jeff King <peff@peff.net> wrote:
> So the regex engine is complaining that it is getting bytes with high
> bits set, but that are not part of a multi-byte character. I.e., it is
> not happy to do bytewise matching, but really wants valid UTF8 in the
> expression.

I did manage to find that the call to regcomp in diff.c's
init_diff_words_data (line 2212 in v2.39.1) is what crashes; I could
not step into it with gdb, however.

Further, the following C program compiles without warnings (except for
the unused main parameters):
```
#include <regex.h>
#include <assert.h>
#include <stddef.h>
#include <stdio.h>

int main(int argc, char **argv) {
    regex_t re;
    int ret = regcomp(&re, "[\xc0-\xff][\x80-\xbf]+", REG_EXTENDED |
REG_NEWLINE);
    /* assert(ret != 0); */
    size_t errbuf_size = regerror(ret, &re, NULL, 0);
    char errbuf[errbuf_size];
    regerror(ret, &re, errbuf, errbuf_size);
    printf("%s\n", errbuf);
}
```

```
# CFLAGS='-Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes
-Wold-style-definition -Wshadow -Wpointer-arith -Wcast-qual -pedantic
-std=c11'
# cc $CFLAGS regtest.c -o regtest && ./regtest
*** unknown regexp error code ***
```
(the assertion fails because regcomp succeeds!)

So I can neither find out what's to blame nor what to fix. Here are
the linked libraries on macOS (IIUC):
```
# otool -L regtest
regtest:
/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current
version 1311.0.0)
# otool -L ./git-diff # from v2.39.1 source build today
./git-diff:
/System/Library/Frameworks/CoreServices.framework/Versions/A/CoreServices
(compatibility version 1.0.0, current version 1141.1.0)
/usr/lib/libz.1.dylib (compatibility version 1.0.0, current version 1.2.11)
/usr/lib/libiconv.2.dylib (compatibility version 7.0.0, current version 7.0.0)
/usr/local/opt/gettext/lib/libintl.8.dylib (compatibility version
12.0.0, current version 12.0.0)
/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current
version 1311.0.0)
/System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
(compatibility version 150.0.0, current version 1856.105.0)
```

-- 
D. Ben Knoble
