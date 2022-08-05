Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033FBC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 08:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiHEIH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiHEIH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 04:07:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9C74DD1
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 01:07:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q19so1608216pfg.8
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qLWnbfwvPSUQoTcJ+3gtAOao7QOuRneb+RAy4K7i+DI=;
        b=OxeFXsUPzcPcImlZBFpeWIpXj2/sFsL51hiyz7xX9da8jfeqi8ZygrCiQohXQtwnQR
         VGFRNjmudox0G/O26UVFURjCV/40nG4H+gLfujwNlUjJRHx1xGyNoHVwISzqXX9OJk9n
         v6abuuhjMRcyDk5C13dUcyv8AdvVPSPkuf/DGFzWxON6e1s2Pk9YxSVOxjBG29JvEoJE
         FMGzT6/62lOuW5+ZwsbftF6Gzx3iPitaRXhsldUC3NFMQmEjOC6UxmnFE/Z8DASQSgUF
         fmpEBIBmkBp13bA/x8vtc/zCzwVBone/fLDpMnQ6kbd4D+CSZLQHNrsAtNnA2qxPLvrd
         sE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLWnbfwvPSUQoTcJ+3gtAOao7QOuRneb+RAy4K7i+DI=;
        b=Yfqwv+c1ku6yIYLGNVvrAf+Y6sEK6UHiXGR6P+5vYFi4hXcNbgyyAUTXaLIoj32dlk
         T+BC0Q4R5rm+XpL1kQIJ21FpFiQ27lFtEn15JfYg2eEGskpsOMxeZ5t+GaNW9NsEBg3a
         MXkThXzVSkN+M6BStAPjpd1wmdOxyPBJeCcKuOgF1Hp8YTOd2/6Xa8hR0l9sap6cN5wF
         E6Xf9m89/D3lTKN6p05sdIfBrQ3BX21C6rX3XmhcZvR084kRSAeGmfXh2wqJKRw0ME+5
         fk/xiephFwQkLFNvPDpixIfNOgKCeN4efFaUntw8DcuLFaJ1bWG+T0PIXRKlXO6DAjHf
         48Ng==
X-Gm-Message-State: ACgBeo3oNhw/2zNkgS9teQly5qjJsW/6LNtdje2e0DzZnquNSp0DZkQN
        U08DpxZT3qR4nAH3eOTid1WwuEguaMo63w==
X-Google-Smtp-Source: AA6agR6L4AHilFntajJLtmrWH1UOrz+TXegBRBtFvNBZeFAav7nQzME+c92obwZxiK8HPTALLnI5Vg==
X-Received: by 2002:a63:1913:0:b0:41d:10af:1b23 with SMTP id z19-20020a631913000000b0041d10af1b23mr676778pgl.485.1659686875606;
        Fri, 05 Aug 2022 01:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0016d6c939332sm2275428plh.279.2022.08.05.01.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:07:55 -0700 (PDT)
Message-ID: <d31d7ea2-4b7e-feb3-9d67-066520e0d053@gmail.com>
Date:   Fri, 5 Aug 2022 16:07:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/4] rm: expand the index only when necessary
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220803045118.1243087-4-shaoxuan.yuan02@gmail.com>
 <475e8617-2adf-c75a-b697-d239dc4830b8@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <475e8617-2adf-c75a-b697-d239dc4830b8@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/3/2022 10:40 PM, Derrick Stolee wrote:
 > On 8/3/2022 12:51 AM, Shaoxuan Yuan wrote:
 >> Originally, rm a pathspec that is out-of-cone in a sparse-index
 >> environment, Git dies with "pathspec '<x>' did not match any files",
 >> mainly because it does not expand the index so nothing is matched.
 >
 > This paragraph appears to be assuming that we've stopped expanding the
 > sparse index already. It might be worthwhile to rewrite this to say
 > "Before integrating 'git rm' with the sparse index, we need to..." or
 > something like that.

I have absolutely no idea why I wrote this paragraph this way, maybe
I was zoning out composing it. Will fix.

 >> Remove the `ensure_full_index()` method so `git-rm` does not always
 >> expand the index when the expansion is unnecessary, i.e. when
 >> <pathspec> does not have any possibilities to match anything outside
 >> of sparse-checkout definition.
 >>
 >> Expand the index when the <pathspec> needs an expanded index, i.e. the
 >> <pathspec> contains wildcard that may need a full-index or the
 >> <pathspec> is simply outside of sparse-checkout definition.
 >>
 >> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
 >> ---
 >>  builtin/rm.c | 5 +++--
 >>  1 file changed, 3 insertions(+), 2 deletions(-)
 >>
 >> diff --git a/builtin/rm.c b/builtin/rm.c
 >> index 84a935a16e..58ed924f0d 100644
 >> --- a/builtin/rm.c
 >> +++ b/builtin/rm.c
 >> @@ -296,8 +296,9 @@ int cmd_rm(int argc, const char **argv, const 
char *prefix)
 >>
 >>      seen = xcalloc(pathspec.nr, 1);
 >>
 >> -    /* TODO: audit for interaction with sparse-index. */
 >> -    ensure_full_index(&the_index);
 >> +    if (pathspec_needs_expanded_index(&the_index, &pathspec))
 >> +        ensure_full_index(&the_index);
 >> +
 >>      for (i = 0; i < active_nr; i++) {
 >>          const struct cache_entry *ce = active_cache[i];
 >
 > Looking back on the tests in patch 1, I don't see any tests that really
 > emphasize the kinds of pathspecs that could not ever integrate with the
 > sparse index. They are all of the form "folder1/*" or similar, making it
 > be something that could be seen as a prefix match. Such a pattern _could_
 > be integrated carefully with the sparse index.
 >
 > Instead, something like `git rm "*/a"` would be much harder to integrate
 > with the sparse index. Could we add a test (in this patch) that checks
 > that kind of case. That would also help justify this as its own patch and
 > not squashed with patch 4.

Makes sense. Will fix.

--
Thanks,
Shaoxuan

