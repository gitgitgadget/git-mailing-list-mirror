Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F1C00144
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 06:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbiHDGZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDGZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 02:25:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBA23BCA
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 23:25:39 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b16so16552388edd.4
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=cckRCBnjfz432c/agNiRIuHd0b16/aEk49YIOBRoBxc=;
        b=C/aGz5cAAVNs/1Gcg4iNYwCc+HxC9OEKGFCjquEbiry2M8KkBcwYg7IJhRVpEMuE5s
         wApBpL/Tqvhjy70gH6aqkoFDFdbVrtxd2GVsbSLpGKfprdyOHj9NJ5JsCAHSCZ5XE+z5
         5/UBtk7crmt03d9y3e/3uuDHRvBicUaZ8fPqzSVEUv34XryozV2nN2QzwRJYFEAuTDBn
         aFHetjbypi2uzFkNiMlpgmyBVJQLWAaH1DB+XQ1GuXoXGkpyrGQX9Mc0XfoaeRZ6qo/t
         zzF7SGQ309RRebJkK7QldgqDf4IOUkeJ3nu9JZ61XZM051sOckiHSYLsfrNisSL8ggvH
         FxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cckRCBnjfz432c/agNiRIuHd0b16/aEk49YIOBRoBxc=;
        b=4UfjkijOI7TsI443tDQZrUaSjfrlHuaiwuTnj0IADZb+ZHMQDexs998kHM5iKqktcl
         TrFay55mL73ZjtQE81QhhT+89ZJ00V3RP7NDaht7djtzShwuwt180Wfgx8RbL/t4dBX5
         iGjUmFimDjL+h4bHIO2VSQopo/hknK1hBcia/AMUWJuyAM5JNpibyMJlPBRX8NaMYjxo
         rErZ43EWhId48WeViPS3UyDcGCs3VYwU96G4oKVbkYnOvPMIzm5LxnG5ZVNjGeTRaQTc
         7uJnwVrHsL96qrMn08ma1YblVOML7itsZgbt96u2k5xl5MbjyjfkyQvdT9lzOfsPhel1
         eDtQ==
X-Gm-Message-State: ACgBeo1ZWvTNcB1TlWhU/fUHEYUpwhUYUr2W8KRKioKgcO7SKUV2uUMX
        v5YJYuawZwrexvoqyNDZmaqo/6l97pg=
X-Google-Smtp-Source: AA6agR4VAEbuQJ0lnVdyELAIxYhj1uQBmM3PbuqPrpN+IxGbewerUO0I6bD/BsWTyYTlbPnM65cafg==
X-Received: by 2002:a50:fb13:0:b0:43c:ef2b:d29 with SMTP id d19-20020a50fb13000000b0043cef2b0d29mr472958edq.378.1659594337803;
        Wed, 03 Aug 2022 23:25:37 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090632d500b0072af102e65csm7945741ejk.152.2022.08.03.23.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 23:25:36 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJUIa-009dar-0q;
        Thu, 04 Aug 2022 08:25:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 05/10] scalar-diagnose: move functionality to common
 location
Date:   Thu, 04 Aug 2022 08:24:25 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <3a0cb33c6583b591b1bbb51a3886f18023813d5b.1659577543.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3a0cb33c6583b591b1bbb51a3886f18023813d5b.1659577543.git.gitgitgadget@gmail.com>
Message-ID: <220804.864jysfrtr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
> [...]
> diff --git a/diagnose.h b/diagnose.h
> new file mode 100644
> index 00000000000..e86e8a3c962
> --- /dev/null
> +++ b/diagnose.h
> @@ -0,0 +1,9 @@
> +#ifndef DIAGNOSE_H
> +#define DIAGNOSE_H
> +
> +#include "cache.h"

We don't need cache.h here, just ...

> +#include "strbuf.h"

...this, also a matter of preference, but we could also just skip the
includes here and use a forward decl (as is common in other headers):

	struct strbuf;

> +
> +int create_diagnostics_archive(struct strbuf *zip_path);
> +
> +#endif /* DIAGNOSE_H */

