Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DECFC433E8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE63C20714
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 05:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr7rxEoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGXFPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGXFPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 01:15:34 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3AC0619D3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 22:15:34 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id h18so2569795uao.6
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6idW5og3jRRdgzwpWes7KDNblsUj/3hE7I2nFb4GvpE=;
        b=Cr7rxEojkwQkIn4Ot9KRBSV8ns9YjxcmWy1qstJlj7WxfBh9xNWvi1LJ5s8w0gVyfv
         Jk95bhQb9JkGCkcQPoJj+g3bV1WkDWDb9+WMhoEMOTD4xV4dh61wrE46t6x4ZuO/U65k
         Z4eGvnWBczWZT9tTF2yNrELUX/58eQ7lC98e/oSu6T28jK9ejFNHZhmQaJfR0SOrFlQG
         H5wnbVUDo20Xw6pudpKGsbf39KVXiXnqk83/RhdtJ4eQmVV1kBVXVh889aVe6zqDYxW8
         ywovgKBIQeZ9cm6PYxkZA116TiEjx8n6f2QgrtwIWSy2qXVJ94NZn7xk4OyyJgBhEwsE
         kRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6idW5og3jRRdgzwpWes7KDNblsUj/3hE7I2nFb4GvpE=;
        b=doOzyirSNEXyeTMG65qP33WMbAsKmUJxtHKS2gzuUz26Ic+1t31fWbtlbdSj32JwFX
         RyKbqpbimMu+UGMV/OpY6NSHKP67RTxUulAZ41QoaAyrKlPl7+FqCeQJquobNNJu3CqL
         HclQ0M+tAi7/ar+796HboRNsOxHDJidXvssXqLYIDuSZ2BDCP/nUkWnM3P25GAPL1rXd
         xpiTLJLsgttWYgcuE9RsuN4iHrrh0YylUcleYKrJ00rmqfpeBwcLMAzDfvIHw1GQd1Ym
         +IQOp4SV274EJuiwDYrgMi2kr5AILyt5JNe/zxaTDrsKCzb9B6DxWcqLcbKayCOaaVWB
         6KbA==
X-Gm-Message-State: AOAM531QpXOWJ3hmB3e9Qk7agf4tK5vnX5bU5Im7pQgHaUBf5LXH6sKC
        T5zjUnRhfNKGQPkJj2zKvU0LufZ373uzR6U1K6s=
X-Google-Smtp-Source: ABdhPJxFO1siYhPffZBSaTCO44iE1eervFE6pChcBFWyELWRpr7Umw/Dr1+55MTdHSrEi5yqcD5I2ASP1TS+56Wl0XU=
X-Received: by 2002:ab0:76d2:: with SMTP id w18mr6479477uaq.27.1595567733624;
 Thu, 23 Jul 2020 22:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org> <874kpzmhis.fsf@osv.gnss.ru>
 <xmqqwo2v45hq.fsf@gitster.c.googlers.com> <87tuxzl00h.fsf@osv.gnss.ru>
 <20200723182648.GC3975154@coredump.intra.peff.net> <87blk6yrlc.fsf@osv.gnss.ru>
 <xmqqimedq5c8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimedq5c8.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Jul 2020 22:15:23 -0700
Message-ID: <CA+P7+xpPDu900dao08wfYtZ2pqU89D9vmwQPuFT-z5S5b-DXNA@mail.gmail.com>
Subject: Re: Improving merge of tricky conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> If your merge used the merge (as opposed to diff3) style, and seeing
> that the resulting conflict is not easy to review and you wish you
> used diff3 style instead, it is way too late for any option to "git
> merge" to help you.
>
> But having an option to "git checkout" lets you move forward from
> that state, so it also makes 100% more sense than an option to "git
> merge".
>

Perhaps the issue is just that it's not discoverable easily because
it's a different command.
