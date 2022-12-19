Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539FC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 09:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiLSJqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 04:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiLSJqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 04:46:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF46A183
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:46:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z92so12085887ede.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pooDHaUqMnK7yz+djwzbNvdBIJOfWUyxX6ibMTZdY5o=;
        b=dTHZ47O+XgAiyAzWm37bB3BVVsdAO6hh5skHsR8vAbguW5AL9iege5e+FkMBClsmtk
         YB2nmU7IsSFAVqIR0OuztzmqJernFtVN8R7i9Lu6LZtgRkreURrOX3q4BtCHXfOG3ow+
         VCkbA/kdIIIsmqJsnuh0eeGoQdvoQHvs/XkkNzvgJW8mAps5ZhybQYZ6C+tZ+begv8gx
         B05z5OgT6mJV7MeVrqBKrEVFOsLn4rwROmPaRoEjLoWKh5pZ+ZvqO/p3VO8Ggt2EiZtB
         WGxeX8VCtqfaX3OKztY8jAl6eW71Ebm9lsxN4L9vmz75Ed/GmGRGYeYoZWjKIpRmspxf
         Cagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pooDHaUqMnK7yz+djwzbNvdBIJOfWUyxX6ibMTZdY5o=;
        b=OS2sjGcTi6aRM0daMKQwsjjHom9kgy6E28fc5UMuvW5hSxsuq0Ie9j3wPdvxhuCxnC
         FNp5AFr+7xqo3HMHYVUWJ0uf3SElcZok58gkzbE+mlUIRiVqm67Mwhtu/c7BxiUvtnCM
         GRnlBtybYeREoPuuFKVmyETMUoQ2eJOUbw5AZjq+5QjSUZ76c682eecaL5P2MFNjD3pq
         nBCR4DCO/a2DAZOYKprPZSySuYaao1uM9f67PoO3SpVyNtebhPYBLQ2g0ypvOzwvtUXb
         RbQ/e+MXOB6htxZhkXDvzzqD7/UY1PhpR0Q6iJPEtvXoUtMz4EVE2SJkCpCFxw6QC0O9
         GDNA==
X-Gm-Message-State: AFqh2kq0SWvIlcYzYNMa6vzNmnx4jC986RyoQjSg/kfkk10iOUmfdjif
        qUMQR6sY+/nKO1/khQ2Dfn7Iv++GVws=
X-Google-Smtp-Source: AMrXdXt11itga683XfNUTJnKHtVwoJCkvoaYu/GW7ac8p0FuhKYREWLPPd+gLspqlN88GVIOF3wy2A==
X-Received: by 2002:a05:6402:1f0d:b0:479:400a:d943 with SMTP id b13-20020a0564021f0d00b00479400ad943mr4486773edb.28.1671443176130;
        Mon, 19 Dec 2022 01:46:16 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id cw14-20020a056402228e00b0046b6bc19439sm4145066edb.47.2022.12.19.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:46:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Cit-006VG1-0b;
        Mon, 19 Dec 2022 10:46:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
Date:   Mon, 19 Dec 2022 10:45:10 +0100
References: <20221216093552.3171319-1-karthik.188@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221216093552.3171319-1-karthik.188@gmail.com>
Message-ID: <221219.86359b20bc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 16 2022, Karthik Nayak wrote:

> v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
> v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
>
> Given a pathname, git-check-attr(1) will list the attributes which apply to that
> pathname by reading all relevant gitattributes files. Currently there is no way
> to specify a revision to read the gitattributes from.
>
> This is specifically useful in bare repositories wherein the gitattributes are
> only present in the git working tree but not available directly on the
> filesystem.
>
> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
> allows us to read gitattributes from the specified revision.
>
> Changes since version 2:
> - Changes to the commit message [1/2] to use more specific terms and to
>   be more descriptive.
> - Moved the flag's position in the documentation to be before the unbound
>   list of non-options.

Aside from the UX concerns with this series, this segfaults with it, but
not on "master":
	
	./git check-attr diff git-send-email.perl foo.perl git-send-email.perl
	AddressSanitizer:DEADLYSIGNAL
	=================================================================
	==1828755==ERROR: AddressSanitizer: SEGV on unknown address (pc 0x0000008ee4a8 bp 0x7fffe4cef820 sp 0x7fffe4cef800 T0)
	==1828755==The signal is caused by a READ memory access.
	==1828755==Hint: this fault was caused by a dereference of a high value address (see register values below).  Disassemble the provided pc to learn which register was used.
	    #0 0x8ee4a8 in hasheq_algop hash.h:236
	    #1 0x8ee632 in oideq hash.h:253
	    #2 0x8ee657 in is_null_oid hash.h:258
	    #3 0x8f79e2 in do_oid_object_info_extended object-file.c:1550
	    #4 0x8f8206 in oid_object_info_extended object-file.c:1640
	    #5 0x8f860c in read_object object-file.c:1672
	    #6 0x8f8a8a in read_object_file_extended object-file.c:1715
	    #7 0x8f01ef in repo_read_object_file object-store.h:253
	    #8 0x8f8e37 in read_object_with_reference object-file.c:1756
	    #9 0xafb411 in get_tree_entry tree-walk.c:612
	    #10 0x6d1975 in read_attr_from_blob attr.c:776
	    #11 0x6d1b80 in read_attr attr.c:826
	    #12 0x6d1f35 in bootstrap_attr_stack attr.c:912
	    #13 0x6d2173 in prepare_attr_stack attr.c:948
	    #14 0x6d3285 in collect_some_attrs attr.c:1143
	    #15 0x6d33e1 in git_check_attr attr.c:1157
	    #16 0x453581 in check_attr builtin/check-attr.c:72
	    #17 0x453f1f in cmd_check_attr builtin/check-attr.c:190
	    #18 0x40b63d in run_builtin git.c:466
	    #19 0x40bf7f in handle_builtin git.c:721
	    #20 0x40c686 in run_argv git.c:788
	    #21 0x40d42f in cmd_main git.c:926
	    #22 0x6885b5 in main common-main.c:57
	    #23 0x7f96725a8189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
	    #24 0x7f96725a8244 in __libc_start_main_impl ../csu/libc-start.c:381
	    #25 0x407230 in _start (git+0x407230)
	
	AddressSanitizer can not provide additional info.
	SUMMARY: AddressSanitizer: SEGV hash.h:236 in hasheq_algop
	==1828755==ABORTING
	Aborted

If the tests are still passing for you (I didn't check) then we probably
have a bad test blind spot with kthat we should start by addressing
before adding the new feature.
