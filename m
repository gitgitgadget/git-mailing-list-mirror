Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD48C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6465561157
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhI0Jcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhI0Jcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 05:32:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8EAC061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:31:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x20so5865759wrg.10
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cArKBSQgDiyH+uGUey0WZLcqPhz9A8STtZzrjWUgtwE=;
        b=JLCceBw+zK4WHedpAd3LaoBnn2UXNX4SEe/4J8Cr1Xmpf98sN2otaU5GCmE9dpO2bs
         hAeD7RHLw6uOUPVMAbApElYHW8Qk7aC7GEwbMut7ql338bLQVKb9VrannBSh9OWzesrl
         sJ8mBf5/udThKPpyOV4KcnVVvtHnJQjnopCrXAEu538rX9HVQoydf7dWwHp5zM3wrfkB
         0Q0+LnyU8ul3agSz7+WAPOYUIgkelLrt6YvIIWpQ0j/l23a4+F0/gEXMxEggnf8R/PXG
         9flmRsuiYGZUx6YkoOSmsfILv5D/FQR4dkEX0xYoiTk0ULfwGRFBCxMLpIGsFXF/tgrP
         MavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cArKBSQgDiyH+uGUey0WZLcqPhz9A8STtZzrjWUgtwE=;
        b=klkJYHjUOJ/kX//D3ArV7ABw2DmsHalx8ibYUia0ZnU7D0Ztj0ufjrMbO/3V8/ME3d
         T7+M0++gD8G6+yhXGrpy9OKl7PY0VL6jK1wQf5i4PVws0MMuqNaXymAsprp02J1uC98M
         iU3+E3r3aUGXZ3EIskHCrBxhkBgFEGU5XWfq5AVzOLz7ofYWxqG+sYas484g82UhBpFB
         FsSJS5M+QpII+tibeFqJaqk4YStcDuYc+b8gxj+bmXLHGfpDGxFvyOCKZx1dx9hG5qYW
         REIg4vEHc0hbP0BxQyeEnN8xaoAYlMThbZg8WWrNsohQAOrB3kSOPwDQmTb9GgTvJ+0E
         jMgQ==
X-Gm-Message-State: AOAM533fTs28g5AVFGLGvl6lccsfKYHm72e5o6NWo+SkZRz94UXNPpZt
        ZcWgG4dvZEhjrJw2V0Zgl3k=
X-Google-Smtp-Source: ABdhPJy4ofsWQCFBRl9qodBzV6/MGB8dKJmYq+ygO2Q0FfBt52Y0vTpxPuV3KtYYVlhqFrMwOW3vnQ==
X-Received: by 2002:a1c:48c:: with SMTP id 134mr13646551wme.137.1632735061913;
        Mon, 27 Sep 2021 02:31:01 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id g22sm18867970wmp.39.2021.09.27.02.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:31:01 -0700 (PDT)
Message-ID: <8d2ccf02-09ad-3876-9c9f-2dd79f9221bc@gmail.com>
Date:   Mon, 27 Sep 2021 10:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/8] Makefile: generate a hook-list.h, prep for
 config-based-hooks
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/09/2021 20:03, Ævar Arnfjörð Bjarmason wrote:
> This series is an incremental restart of the now-ejected
> es/config-based-hooks and ab/config-based-hooks-base topics. See [1]
> for a summary of the plan and progression.
> 
> In v2 the "sed" invocation that generates the new hook-list.h has been
> changed to be portable under POSIX. See the thread starting at
> https://lore.kernel.org/git/92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com/;
> 
> The portability issue is AFAICT theoretical in that any "sed" command
> I've tried accepts the old version (I tried the large list of OS's
> listed in [2]), but better safe than sorry.
> 
> Other changes:
> 
>   * I noticed that the run-command.h inclusion in transport.c become
>     redundant, I removed that and validated the other ones that have
>     the new hook.h, they all still need run-command.h.
> 
>   * A whitespace change in v1 in a change to the Makefile makes the
>     diff for 8/8 easier to read.
> 
> 1. http://lore.kernel.org/git/cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com
> 2. https://lore.kernel.org/git/87fstt3gzd.fsf@evledraar.gmail.com/
 > [...]
> 8:  80aae4d5c13 ! 8:  7420267ce09 hook-list.h: add a generated list of hooks, like config-list.h
>      @@ Makefile: XDIFF_LIB = xdiff/lib.a
>        generated-hdrs: $(GENERATED_H)
>        
>       @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>      + 		$(filter %.o,$^) $(LIBS)
>        
>        help.sp help.s help.o: command-list.h
>      ++hook.sp hook.s hook.o: hook-list.h
>        
>       -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
>      -+hook.sp hook.s hook.o: hook-list.h
>      -+
>       +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX

This is billed as a whitespace change above but this line has actually 
changed since the last version - was that intentional?

>        builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
>        	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
>      @@ generate-hooklist.sh (new)
>       +static const char *hook_name_list[] = {
>       +EOF
>       +
>      -+sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>      ++sed -n \
>      ++	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
>      ++	-e 'x' \
>       +	<Documentation/githooks.txt |
>       +	LC_ALL=C sort
>       +

The sed change looks good

Thanks

Phillip
