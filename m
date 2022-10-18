Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2278C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiJRMFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJRMFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:05:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A184101E2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:04:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a13so20150378edj.0
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=izJeSfit+fuGgCOhdkJLu/6RsTsRZ3k2h/7COTlTBAI=;
        b=eLrCbIaoQ5TR0iI7i+1pxtFRp6wIr07uG/Fg7+oiKFZDg+I8yMb1Jj5yVUj2y1kGbz
         OvwaSyO9xMEm8Z+aESEDhnmBVOJL5HzNK6g3rc05q9HJHbx8YWbKFMKEQ4iyVozuh+uJ
         b3+BuF/Ap4Gfk6qKshoeVEhDwMhN+KViokP/QLDqFdtcodB2Npu9Vl4zVMuqLvojVaWw
         ChGWEN0Gxmpro9rZZdbm/7b4Rfb5LjGeSVPVEcGqJSNheDfzgc69fFsbllIw9y0jCIkH
         27jgQ2ByMwvxuddv8lv++W5zN/48swa8s0oQjD8IrQThzB8qo5FDY0EnxKfnhxDKbmah
         j+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izJeSfit+fuGgCOhdkJLu/6RsTsRZ3k2h/7COTlTBAI=;
        b=U4iYLauG5wLHNQ3p+xQLoLlSzXuuXb0/Ky9fXWeLZKaMyDEU6uieXPcba6shgV35up
         tEr6D3HEbdIGyT/pM2QaVFbS8GDr69rjTaFfz3Ska3SyTupUoUxm0+tmYf3YnfwrqJpj
         OffaSCVl68Fx3ap3sny9zASPHZa07FOikH1viUIf7U96496G163nXm2ijKKbVNdlzpzH
         9vF3Gm8jDJ2ofDsPuVlOkPeDuJgdF60RiV5SqwPdTA1Hd/kTjRkjNLXknCBlXMtNseHk
         jKzyOkbMGQw/FQv5AvKH6AKTbGrJGjdfP/WcB+Id1n8WtoR8cWeN3M+E/C1NtOfS6iKF
         Ki4Q==
X-Gm-Message-State: ACrzQf2IoiDdJyodzQyg1V9LrJIF0IlnGoWzvIuG3kVcyjTKne4+Pib9
        C/xQyRWXCPr45Gmyo+oO6Fw=
X-Google-Smtp-Source: AMsMyM4m3X1b020VPKR6w+YfhClFd1FAwp4TuHnQoZyNCpA+7lgpGuhcfxGLPPExDKWjsL27VH/sqQ==
X-Received: by 2002:a05:6402:406:b0:458:a47:d14c with SMTP id q6-20020a056402040600b004580a47d14cmr2283427edv.41.1666094649963;
        Tue, 18 Oct 2022 05:04:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b0078175601630sm7301792ejc.79.2022.10.18.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:04:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oklKK-005imk-0c;
        Tue, 18 Oct 2022 14:04:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 09/12] fsmonitor: implement filesystem change
 listener for Linux
Date:   Tue, 18 Oct 2022 13:59:39 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
 <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <4f9c5358475867af75acd865505884f99801ca17.1665783945.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4f9c5358475867af75acd865505884f99801ca17.1665783945.git.gitgitgadget@gmail.com>
Message-ID: <221018.86zgdtibif.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 14 2022, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
> [...]
> +			strbuf_add(&path, w->dir, strlen(w->dir));
> +			strbuf_addch(&path, '/');
> +			strbuf_add(&path, event->name,  strlen(event->name));

Don't do strbuf_add(&buf, x, strlen(x), just use strbuf_addstr(&buf, x)
instead.

The same goes for a couple of existing occurances that hit "master"
already in the just-merged fsmonitor topic, but in this case we can
change it in-flight still. Thanks!
