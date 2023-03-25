Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8812AC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 11:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCYLIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 07:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYLIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 07:08:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64FFF1A
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 04:08:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so4080344wrz.7
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679742488;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcfOcqyB213RdR7DQHGdGszCKJ9jjd+10IDMm/GgUEM=;
        b=DREfKxEh1wiE4spKoIIbGgybh2FcSx2i9uATec36AZNqaTEbHQxf1ht02pYscDODp8
         xxVY9Gfc8Jpbr/JZzXE1sgY7o4V8Foe6X2EtE0dY9yT8IR1BXIVCs65wu9ANkONWPw2t
         Jo9A9gg7kXp2ZudAmWFTL8X4wWC7Z/uXJ62A+qJh5SmeJ1Vev6rGgEgSPugzrRdh4YZd
         yo7CiyKm4Oj28I7etH76hJyd3J3H9WZHuoPdeTjyb+sP6KNj/Qi1UMutQElYpmMjW5b9
         4HImGgVlT7O+pe82P+2qoj2gVtUA3PvH9rH/U5KN5MJHZR/jdLVt3Htds9pW9xIjkaDy
         Fv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742488;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcfOcqyB213RdR7DQHGdGszCKJ9jjd+10IDMm/GgUEM=;
        b=1XHv+Io+bMChympAAz1OIUmjIknIr+bWumz93UbouuThPpSMJ+EblS187CIw5vmyg9
         znrRCg5A8F9gOPDPM48zcNiClU0a3cROHDcPhp62UP8+0U7bQdf/onw6H7jGsAten/Zv
         yPgaJpwRxB65izD8yYtw7zzBDvP53C1PIuHjJYuJZb3kVuhYutHMyBsXkS5K6lSY2Rpv
         1qyLo7GzehzRr2VCDr9FIy8Lfckb0UXNPX/CbwdADvyoCflh8RvEiTiOEZ/TglAyKMWS
         isYF71RGNqBbKTQ6lbSOph8qCvCc1HfeVFNZiGBnMQLrohZ5JHLjlObXjd321UhUiIb0
         hlLQ==
X-Gm-Message-State: AAQBX9fqOmHehrOiNAQVYs0cV8JeTPN0nKEzaNgQ+TkrWWjWMIoN4jWU
        raIdKHYOb2Hol9+N3fTijeZ+3DX0+Qo=
X-Google-Smtp-Source: AKy350YJeS9xHUEmGUTA6fx/HH/uBm0qUEqL0NiNJNCUK/MnKcYOw+0vufFy0/09ixKBob4N4V681w==
X-Received: by 2002:adf:f687:0:b0:2ce:aa8b:4590 with SMTP id v7-20020adff687000000b002ceaa8b4590mr5567955wrp.9.1679742487881;
        Sat, 25 Mar 2023 04:08:07 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c290b00b003ee20b4b2dasm7508838wmd.46.2023.03.25.04.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:08:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f72b3820-124c-3e2c-30e2-ca3f46b74dc0@dunelm.org.uk>
Date:   Sat, 25 Mar 2023 11:08:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/8] sequencer refactoring
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> This is a preparatory series for the separately posted 'rebase --rewind' patch,
> but I think it has value in itself.

I had a hard time applying these patches. In the end I had success with 
checking out next, applying 
https://lore.kernel.org/git/20230323162234.995514-1-oswald.buddenhagen@gmx.de 
and then applying this series. It is very helpful to detail the base 
commit in the cover letter. A series like this should normally be based 
on master see Documentation/SubmittingPatches.

Having applied the patches I'm unable to compile them with DEVELOPER=1 
(see Documentation/CodingGuidelines)

In file included from log-tree.c:20:
sequencer.h:7:6: error: ISO C forbids forward references to ‘enum’ types 
[-Werror=pedantic]
     7 | enum rebase_action;
       |      ^~~~~~~~~~~~~
sequencer.h:140:34: error: ISO C forbids forward references to ‘enum’ 
types [-Werror=pedantic]
   140 |                             enum rebase_action action);
       |                                  ^~~~~~~~~~~~~
sequencer.h:196:26: error: ISO C forbids forward references to ‘enum’ 
types [-Werror=pedantic]
   196 |                     enum rebase_action action);
       |                          ^~~~~~~~~~~~~

In file included from ./cache.h:12,
                  from ./builtin.h:6,
                  from builtin/rebase.c:8:
builtin/rebase.c: In function ‘cmd_rebase’:
builtin/rebase.c:1246:95: error: left-hand operand of comma expression 
has no effect [-Werror=unused-value]
  1246 | 
(BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(action_names) == ACTION_LAST),
       | 
                               ^
./trace2.h:158:69: note: in definition of macro ‘trace2_cmd_mode’
   158 | #define trace2_cmd_mode(sv) trace2_cmd_mode_fl(__FILE__, 
__LINE__, (sv))
       | 
     ^~

sequencer.c: In function ‘todo_list_rearrange_squash’:
sequencer.c:6346:23: error: operation on ‘items’ may be undefined 
[-Werror=sequence-point]
  6346 |                 items = ALLOC_ARRAY(items, todo_list->nr);


Best Wishes

Phillip

> 
> Oswald Buddenhagen (8):
>    rebase: simplify code related to imply_merge()
>    rebase: move parse_opt_keep_empty() down
>    sequencer: pass around rebase action explicitly
>    sequencer: create enum for edit_todo_list() return value
>    rebase: preserve interactive todo file on checkout failure
>    sequencer: simplify allocation of result array in
>      todo_list_rearrange_squash()
>    sequencer: pass `onto` to complete_action() as object-id
>    rebase: improve resumption from incorrect initial todo list
> 
>   builtin/rebase.c              |  63 +++++++--------
>   builtin/revert.c              |   3 +-
>   rebase-interactive.c          |  36 ++++-----
>   rebase-interactive.h          |  27 ++++++-
>   sequencer.c                   | 139 +++++++++++++++++++---------------
>   sequencer.h                   |  15 ++--
>   t/t3404-rebase-interactive.sh |  34 ++++++++-
>   7 files changed, 196 insertions(+), 121 deletions(-)
> 
