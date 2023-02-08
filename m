Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3A9C6379F
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 12:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjBHMGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 07:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjBHMGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 07:06:34 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B8C49436
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 04:06:33 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hx15so50551206ejc.11
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 04:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bcvLVIHISfNK+uzA+N8gL2x6FNhhL/ZJjP0B3AFRGd8=;
        b=OlemV6391Jz1HXwseHvFNEe2+n2VmYJtcnG4JB7CwoLHW1iTTeKr8MB6ldFT7AjbOt
         inqcVDWGVtZlS3Sim7Yin2jihxaDEKbfT9oGtzV+xAYI+Mxm1qatNAN3KaJt5kLstKVV
         5+omYzve4g5gODuvindJh88St1mWOnEXP7Kx9MPfOFKxzAHwiTi9cIwh61K2/HhUDQME
         HPxcNhxPC37DHHZYQxFpceefRd2/+KOTgfD3HFSzclh9OFJsYaMr+1eLR7KAYRoqGWo+
         ILiXzWMwixuRg7gPa5CJKxsZAdSG65zq5b/Oi/pxl74NZzK1Aax23EzLCbLw9gWTTJMl
         PWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcvLVIHISfNK+uzA+N8gL2x6FNhhL/ZJjP0B3AFRGd8=;
        b=KrNEuFmNJETwp85XQIxVK/VuwXwGSjQhkw3ZNReGkbNmSdiRZYwbzfqlEIjrKJhBDb
         nYK4NtbigUYjrw4D//Cyrg2E7tp1MlovTZdHOCAZKUlx2GnDR9HYmilrJ6+IyBSyAcbg
         g3L4pMpDM/HCpBVf6gnoby/FOlMZAEnf4KxoW7H/hsh3oov8EJ/drwCkKFEo1Au3D+QA
         /6G1GP06/I8zEodVnTRUeosjyESZBAjybc7XbvBsy+sQIVTfm/R5QrlqsVeTJgsC2ScY
         ccJMUjMAYZqtJvZYhLgdCegT4Uvf/xA1aP8C7WvpK4kcfUSLzKQUPvvFAmIxP9alQ/KK
         bafA==
X-Gm-Message-State: AO0yUKXyg5cKfYcLuVZROu5zYxZOZSGuiE+90KzyeEvXLNFlYsqUwNsj
        hRNWd7PmRfUWT6goOa7SGAH5Zy0j3UXVhjiP
X-Google-Smtp-Source: AK7set/KqahkEZgNZvcxNe7F6SNOGlhzTyg99BLswANKaLjO79TerlblFqd5MKSNplySW/XAH6ZgCw==
X-Received: by 2002:a17:906:903:b0:88c:3a48:716c with SMTP id i3-20020a170906090300b0088c3a48716cmr7426588ejd.58.1675857991787;
        Wed, 08 Feb 2023 04:06:31 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709070b0a00b0087758f5ecd1sm8170415ejl.194.2023.02.08.04.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 04:06:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPjDa-001Ixf-20;
        Wed, 08 Feb 2023 13:06:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CMakeLists.txt from contrib/buildsystems fails to build on Mac
Date:   Wed, 08 Feb 2023 12:57:35 +0100
References: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <BFC8139A-0A9A-4E84-BC0B-D6EE5F469F82@gmail.com>
Message-ID: <230208.86sffgz7i1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Ilya Kantor wrote:

> May that be because of some changes in MacOs Ventura? 
> Or is the CMakeLists.txt "dead and forgotten"? ;)
>
> P.S. The regular "make" route works.

You should just use "make", the "cmake" build method is currently in
some limbo. See my
https://lore.kernel.org/git/221227.86pmc4vrk3.gmgdl@evledraar.gmail.com/
for a recent overview/questions about it.

Since I wrote that 0949eba7fd0 (diagnose: another dup2() leak,
2022-12-06) landed on git.git's master, so we don't run it ourselves in
CI, even for Windows (which it was intended for).

As noted in previous exchanges I wouldn't mind fixing it up to work on
more platforms, but Junio wasn't enthusiastic about those patches &
dropped them.

Alternatively I think the best thing to do is to "git rm" it from
git.git, and leave it to git-for-windows. From what I understood from
Johannes he preferred that plan.

Or rather, that GFW would be fixing it up, but then I don't see why it
should be in git.git, which as your message shows just leads to
confusion about why this component is in git.git's tree.
