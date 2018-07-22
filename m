Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195061F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeGVKQl (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:16:41 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:37776 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeGVKQl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:16:41 -0400
Received: by mail-io0-f177.google.com with SMTP id z19-v6so13215881ioh.4
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29oZo85On2K2H/iRaSPTPrhHKmNw/hblzvgn0olNXTU=;
        b=Oz4xhalXUZ1FFJn8hs/l3o5x9On/DHqJquz39SRVgjSTE9bcJQErSSWPuNwtK0JAgh
         Tj8Vmngo2CayjX/IgYU0Sx6QqFqA82QZEKwMjoLvbfl/GkKiU+NNRvwOduYPPyNOPu+h
         bTPjw1CXKONIx92oTvqJomK8rK7rjA0bxrKW5SCVDFWgUFOG0SRNYHEKXshY8gyd2a9s
         90PRYn+Jrd60E/4lzVnxGggVOXcds9CQywGzWGgTF3/7GYke7C5wgF95mCF8lBXcCahi
         RNw5YrHEugujtJyYPUhjJYzNqAH2TQfHEqy3/R1gnoX51y5NkyYaPizKr6brklVJH1sU
         Mp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29oZo85On2K2H/iRaSPTPrhHKmNw/hblzvgn0olNXTU=;
        b=l207rZYjRLhu2TFkulJipbZGrZRz3vSZNaiQUey4MuSaJPvgJJ8zdqG1khldAlVsum
         4mX9XPyMc/UCAVbPDwmBmtD3D+T29gCXRv/LzOXahDIfp8EWtL7uVoW1Q6ut326mXqd+
         3sZ5ZkOk35gIlC4vPNmbm2+FgGrpI0JRH+TSFhEqzhqTYxEsOhFbHWuQcPyCGSEtz+A6
         V4UbIQisH/o3ycg2u08w7F58wCORZddmQcWmN6C4QzoRsr/gB+m/nwMSe+wGKSKtRSqa
         dRg80e6v1Bf790fCqjI9Ghdl2SqcNC0PkCVRLFf3biVfceQZQbYxUU9iZ/FFtRe+NWUD
         5zcQ==
X-Gm-Message-State: AOUpUlEWCTLg9OKsigvHwvBCyR+QEAZuudopt1NZBQ6WVVh8jhYVI6HQ
        xwFRZzwlgdT8RGjGLwPf5BU9gTs2oUIOtEQavF8=
X-Google-Smtp-Source: AAOMgpeI5iLGq2hTr7029C87rqc7727i0dP2A6WqGMno4Zl2hLylYVvgxOaWkA6lchRejIOymT2KtlD9Fvge8VYC+60=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr6069878ioe.282.1532251237860;
 Sun, 22 Jul 2018 02:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
 <20180627223023.49659-9-bmwill@google.com>
In-Reply-To: <20180627223023.49659-9-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 11:20:12 +0200
Message-ID: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] fetch-pack: implement ref-in-want
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 12:33 AM Brandon Williams <bmwill@google.com> wrote:
> +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> +{
> +       process_section_header(reader, "wanted-refs", 0);
> +       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +               struct object_id oid;
> +               const char *end;
> +               struct ref *r = NULL;
> +
> +               if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> +                       die("expected wanted-ref, got '%s'", reader->line);

Could you do a follow and wrap all these strings in _() since this one
is already in 'next'?
-- 
Duy
