Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D0E1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeCZReX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:34:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38305 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeCZReX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:34:23 -0400
Received: by mail-qk0-f193.google.com with SMTP id 132so20982903qkd.5
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oGSMF9/vhYKZfI2oNSR4Tm507NnQ01eDaZzpM0hZl2Y=;
        b=t60KFOyHF5eDtYBXWyM+v5DiGRS7aesW3RrMM/LiS/k5g9faw6coI8K623g7xQofTS
         4YPumdH9BgMTI0Aj8zkrDJwIfAypsrae0A1/fVbFu8QV5ABNkS/Af/deX1qiS0RqfWPw
         yMdfqsHhEJfoc2icW0Euwew492HoAU/RLTHn4Fe3uA4DYN+OuBsNXb3C21I1VSN3efWN
         GVjHd12cVrUrh9nbZp+LNH3jV2zscban7qtCBZjidMDZu1a0Bmr1FGk9DWtLFCSKcfCM
         0YqGSshtwZYeDgCWvd0zvBjMslB72o6vt1G1Msr7U9R6WWHBxQ71TF6Ig1B3hOZiTt1Y
         f1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oGSMF9/vhYKZfI2oNSR4Tm507NnQ01eDaZzpM0hZl2Y=;
        b=sxJWn+C4/ntk86YaYHMJwmHe6LwiZSLWMnBlhpNgvEnEzmrRiwsCrEGs/cnx+XfzcI
         Gof/z0iTTz9uj4Y/nNZmnPF/faHZWHS1bjGXqwF5XJlLOSuyVh8g2b0qsKIROKZU2Bxm
         bGlQbHukeN36uQbKjx4kbMkuDREfMt73/r0Z0jfKSs19kNW5evoiFnUnczLZVb6ZrwjE
         MPgKl9FuZXIuo3IyijinREBRHFeaEnptOunQqCWMqxA5n9zmN7pkkauexCT2L2AJNoJC
         XPcLUtCj5SO+F14OHMd0OMAMqAqGK2t7we9irJdKJBtIyMmajE8FB5UcRL55tKEJ7dBt
         0vDg==
X-Gm-Message-State: AElRT7HuOVmSFjb87MpLj5e1tvqPDu/KaxtTuy1Yx0bskQKQvCywB85G
        XbQF4SwsIzK3uK4qZyhQV93lk+RlSxAl/0dlICo=
X-Google-Smtp-Source: AG47ELuyb186lr4w8XbcXgNOCvczwSdW2J/g8YstBwalD97IwvllK/zKTx/fdRUf4DqoPRAIRyXgqhIIC8lZj24oFKY=
X-Received: by 10.55.3.140 with SMTP id 134mr57615703qkd.26.1522085662395;
 Mon, 26 Mar 2018 10:34:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 26 Mar 2018 10:34:21 -0700 (PDT)
In-Reply-To: <20180326170351.197793-3-jamill@microsoft.com>
References: <20180321164152.204869-1-jamill@microsoft.com> <20180326170351.197793-3-jamill@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 26 Mar 2018 13:34:21 -0400
X-Google-Sender-Auth: jWKE90pMXN7dv4xT9RRGdsj4iF8
Message-ID: <CAPig+cS83ECwXp3PuV2ex2nDOV0tZHmEqAdtUNjV_LmtEaxBhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fast-import: introduce mem_pool type
To:     Jameson Miller <jamill@microsoft.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 1:03 PM, Jameson Miller <jamill@microsoft.com> wrote:
> Introduce the mem_pool type which encapsulates all the information
> necessary to manage a pool of memory.This change moves the existing

s/memory\.This/memory. This/

> variables in fast-import used to support the global memory pool to use
> this structure.
>
> These changes allow for the multiple instances of a memory pool to
> exist and be reused outside of fast-import. In a future commit the
> mem_pool type will be moved to its own file.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
