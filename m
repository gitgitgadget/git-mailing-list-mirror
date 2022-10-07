Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFDC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJGV7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJGV7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:59:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721812791E
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:59:12 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g13so3197441ile.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMBXUgZ78AGkGspMoWjYnQUyMIOKV/q2bVgxOkXM+1k=;
        b=izknp1k08FWiP8nLg5gkMI+XHksecLhw4GPCV1JVen82jcmIn8O/jcL5zq4VjoDzWu
         D4b6EsTWRNU0HCDzXbbp8q/CZePgRn47/kCEPCmXK3n/QHHlipPVM4piU68XU9tcZBI9
         EfHjRagvD7aDOCzHtAOTsbxoa+5W9i113Ybj1+TEm++UI2YX4PKqUCHMvVGydGCEDMAE
         RQYG33wBCNgWS4kVpMRfdd1Qq1YEEBfoEq0zR9W50k/wQuxrWZnW+8eCAKxGT7cfQ9Uj
         Id92Lh7bgDB5Rv42Pjagh/I41i6D398knaabmhWXWfSADvKLbaStjL7KV3tYViYlcMCe
         petQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMBXUgZ78AGkGspMoWjYnQUyMIOKV/q2bVgxOkXM+1k=;
        b=6eo02B2CJuczO2cKyOWYE+UT3cJluQVwvolkvhW/gq4PIidlWn2o9JxQvsdmty71Lu
         YsHNFbZoYW14x33heSY720cFywdUYS7yKYRhrpLdzq3OOEuUcfyg4HeifSN5Sh9/56o5
         loqJKlUusCl/k9F5Ahuvs2jb0UV06vCoVB5bHc5JEyWKuB8R8JuP6nYEB8xVOXnNmRC2
         aNbnQujqT6zEZ5WlxJDff3RCVEhfqxaGruHyBogMoXqnWN6k1YiOIrpOdiIr8dMz6SZY
         kHcDWRjw50xQANigbexTkzf3hdwXaR1w3PzuYuEkOlPcB5P55tHAymHdUD126Oe2i7wS
         WUKA==
X-Gm-Message-State: ACrzQf0bmQQtT4Dv7l6DksYXA8t9A0VYk2PNioC09h5eIxCOF/vLUrAo
        SkxzYFy3pSzKGSjXmKRnXpVGng==
X-Google-Smtp-Source: AMsMyM42IfiHpmw85nY+f4hI9/STtNb3ThMr5EyglrQGijGiyY4XV6/48lQw1eQj8oCeDnPj799wdg==
X-Received: by 2002:a05:6e02:20cd:b0:2f9:b5d4:94b8 with SMTP id 13-20020a056e0220cd00b002f9b5d494b8mr3604879ilq.144.1665179951837;
        Fri, 07 Oct 2022 14:59:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f4-20020a022404000000b0036369fd1838sm1297278jaa.73.2022.10.07.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 14:59:11 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:59:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Y0ChLlG+iOI3li6L@nand.local>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
 <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
 <Yz93RjrJ00A5QvNe.jacob@initialcommit.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz93RjrJ00A5QvNe.jacob@initialcommit.io>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 05:48:06PM -0700, Jacob Stopak wrote:
> > The date thing I think can be done with --date; I just sent a sketch in
> > another part of the thread.
>
> Peff - I applied your --date sketch onto Taylor's patch and it worked
> first try.

Yeah; I think that allowing the `--date` argument (similar to how `git
log` treats an option by the same name) is sensible, albeit slightly
less flexible than the proposed `%(authordate:format=%Y-%m)`.

For what it's worth, I don't have anything against the latter (other
than that it is slightly redundant in many cases with `--date`), but it
does seem easier and more worthwhile to repurpose `--date` here instead.

Thanks,
Taylor
