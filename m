Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D9C11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FDA208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq7hZ+J3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBUFV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:21:58 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44964 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:21:58 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so842306ljj.11
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 21:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+PGVrouxO112lEMoGnTOBv7Q2Kh7D3Aj1Q79Q3YXFLc=;
        b=fq7hZ+J3UsuaxFPIZZQZU9enr8Zfi9Lqlv3yLyaQFNLRtkvTNcyTqAKrC/OSEPaE3Z
         WhHEfYoeYBwvDc56dvlPqrpJ7jnUqkeTbQtUMDxtp3PP12RRQPVFwWEDo8NAUX9OSiPW
         QijRcwQIhL/2OqWDDeHxicCyFCrZPllZ0fLPNoXw1aHBiCYowRksRs9D8YObkAvIb+LF
         dDImor5TPOxmbZKuGaSMTUFDDI7v9lba0j+3jP/xIGIdIHOrjgfp5L2m5NVn9gKXkR8g
         8Cvy2rOIfX80gh+AXS/0NUSXVswaV3gh/vEfysAcL8FmpUNS7aPlZVYbQ18aMzETy+zK
         Us9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+PGVrouxO112lEMoGnTOBv7Q2Kh7D3Aj1Q79Q3YXFLc=;
        b=CNnxFaaPF8lMcY01uQOgLxk4wgPL+MHBjGCnf057pO5E365R/IL19C9IU1054K/k+y
         mqNJsjVW0o0G+/sLFc6jMJasU/VCaP5lv5eR7sZHpeQQVhnAfjGF3I0xbqnIfbpqBT5c
         3XRtT5/ZY3RRrLAmiGEit/nMTklXk1nfEfOQvdYbkfujVAvwPCEX3mC+ePN6EDVO9f0A
         SJsdLv4yMj/j4rdt8E2K9daoUXlD+/hRsDFf0oBMknnhK8ZqtkE5WfEOCvmxO8vR8dRf
         Vl0bDHl2aPImaglALuImIM6wjb2ZSXpNGe1YS/gDRRSPK4+U+aQ37t9DpluBOp+hFOQw
         f3fg==
X-Gm-Message-State: APjAAAURLvj+TJMGiJ2KV6dCd46t1eCPAgFWhP0vfG+n3b+TCyQrKQt/
        XKOIhdEA2KT8dNOOnKQHJOzOv18sK7xY8X5pkcffDL9G/VN7oQ==
X-Google-Smtp-Source: APXvYqxufzf2H2F705J+FFd+JeMRdy9xCwRXdUqDX+MVoz4IVAEc1ULkSpg+m7aaY2IFtc0FdfmA8OZ5Z4VtLCjlLlk=
X-Received: by 2002:a2e:7609:: with SMTP id r9mr20934190ljc.238.1582262516875;
 Thu, 20 Feb 2020 21:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com> <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
 <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
In-Reply-To: <113d4221-d7bd-cf0c-ebfc-1fc08442c303@web.de>
From:   Robear Selwans <rwagih.rw@gmail.com>
Date:   Fri, 21 Feb 2020 07:21:46 +0200
Message-ID: <CALH1-XoDm26QMQDgA0zKmSMPnbDxJCOF6k2xyyeePL15APV68w@mail.gmail.com>
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize strbuf
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 8:49 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Could you perhaps include a patch that makes use of it in this series,
> to highlight its benefits?

Well to begin with, I'm actually doing this in response to this issue
[https://github.com/gitgitgadget/git/issues/398].
The issue was created because of the following mail thread, though.
[https://public-inbox.org/git/20180601200146.114919-1-sbeller@google.com/]
To be honest, I'm not entirely sure about how making these changes
would help, as my experience is still quite limited. But from what
I've read, I think the main
use-case would be using const `strbuf`s to avoid memory leaks when
dealing with config strings.
