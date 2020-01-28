Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF0C33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B12467B
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go9H4dAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA1ESD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:18:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46166 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1ESD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 23:18:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so13190807edi.13
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 20:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNZOblgpAIxObktJLqBXuxnUlbI0o4wEenbtGAmqj4A=;
        b=go9H4dAH7QNm0x+yOWSeVGh0oxWhKbgpK4K3ldphvQEKFGOioCFtV55ZbXZCShpeN5
         GRPoZ89wwdn336Or/B+bbr2ieXjdlfR5+rXXclZdzBpfWfKMNKifhcA4Lp/CAW/ZOPrS
         t1H/ogc2Ki8ilCFRB2rbhuVopEAi2EQwb+gZVOIYBoHONSk1PSmEcWxV7eGHEbbSnLHn
         R7QetnTpg0mi06NG1DNLS82if2IXAOHwVuXPWK6ySJyZTiF1lYgDA0tWkjk6Hys/QiPc
         EjuhZ9w2ACI9PY/CIMdBEn3fahmKC5PPMpIkXjEvb7PjhpETuFEx9XCT8ZnVdoRp9OEu
         8hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNZOblgpAIxObktJLqBXuxnUlbI0o4wEenbtGAmqj4A=;
        b=L5IpqnCoumFL+c1t0QP1hRqqvV/24C+4aIxetTtnVd4r3IXQ39UM0xLxVQjODioP8U
         JFTW/kx+cbPgKTDXlK281XKFDGAESC+EFuWckZ2uWZLSlkMC/O1Jjh/cHGKfOtmmF9bF
         aUnrVmjwAjRDa5+OtSngxwgNzVYSLy69rlo0GHxqVmrZTPNwGXiH8RkXjfMwiQF5CXW/
         2WZ6mGVB7B4/yIWI2Bg53W8hFG9Xq/3p04ge0vJJQG9F/ubx9zbfEcrRvUinA5KWhXfl
         U7xYPZ/Ec4Nb0cO5rCF+XUrKcGeIW3ZV8kxajj3PmYykkaMGi3KWG5dT3Ft11j/Rq/7a
         X8UQ==
X-Gm-Message-State: APjAAAWg7WRSn+NVDk072PV19U41KAIjMMRdLP+QA7CJviLMroqo7AEb
        NNKwIJFoSZlvoAI39T3XEEmtXOp2kJWMVhZgOX3D8g==
X-Google-Smtp-Source: APXvYqw9MYR6HgoCxCg0Z+fvfz3BAWbp0Mh+FVVR1YsSOCWnrQsUSymtMoWrkOfL9xxsSbJ5iNiLXsKPe1993XKPfd0=
X-Received: by 2002:a17:906:7c5a:: with SMTP id g26mr1419640ejp.249.1580185081087;
 Mon, 27 Jan 2020 20:18:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
 <pull.537.v2.git.1580091855792.gitgitgadget@gmail.com> <b494114d-02ef-599f-4fa0-d7614974a130@kdbg.org>
In-Reply-To: <b494114d-02ef-599f-4fa0-d7614974a130@kdbg.org>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 28 Jan 2020 17:17:49 +1300
Message-ID: <CACg5j24TNczbZZ3u0UR_MYQgeWk8HRY-cxc3N8HX=v-Tx0vi3A@mail.gmail.com>
Subject: Re: [PATCH v2] git: update documentation for --git-dir
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 7:29 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Does this render well? Judging by the precedent set by the descriptions
> of -C and -c options earlier in this file, continuation paragraphs
> should not be indented and separated by a line with just a plus sign
> instead of an empty line.

It doesn't render well, thanks for pointing it out, will send an
updated version.

Thanks,
Heba
