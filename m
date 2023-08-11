Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658BEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjHKSQX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Aug 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjHKSQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:16:22 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED33D30DC
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:16:20 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a412653352so1886697b6e.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777780; x=1692382580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt0SC/gv4CTX6sqswPVzU4wkNw6cHZA/s0uP0nfCImw=;
        b=CQHXQMfeywvhabTcieU3WlRw6ACMW/Lr1BZgZTB1LS3GIRaywBLEFA5TSMjSD8sNng
         yMpORkuET+m2Q59IQQxuz7JRfSzSUQd0p9xAAEwi4Dh6elZHGdRctdENHgFBxtEnNMVl
         SX2JaHBVYJGKfT6PuzAUxdEHpMLzCOv4368zkIJuPTVsXP6CX38ee2HJBVfajC40dLFA
         dY1XuWvTndKEYLBUNaERb5DFRee36RGGCZzND7e/3dl4Wnmzjlw1+Iigl+ONusdzm51M
         SE5mUu0SZYuZ6Bmi7U34dUmj8yrbPhLt19WYx1SIfzNdDgvEgmNq8cispGSNMKiKh/qF
         M1gg==
X-Gm-Message-State: AOJu0YyLH5ruqN8KKD7PYPhXiqPFjyrWIP15W11vA6TocZwUpyqBxLnJ
        uoUwntoTSemBqN+HXdYBYSqCFZzx3BXr3UsEvek=
X-Google-Smtp-Source: AGHT+IFaGsT9cuMEYg/w7Q8uBL+8TiGDYO04dCL4w9crZnRxm1HW0smnVRoRUoreCqCM649X/llaNrFR6aFVdt6xemI=
X-Received: by 2002:a05:6808:19a7:b0:3a7:7bd3:7a7d with SMTP id
 bj39-20020a05680819a700b003a77bd37a7dmr3921196oib.23.1691777780198; Fri, 11
 Aug 2023 11:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de> <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com> <xmqqsf8ptsqf.fsf@gitster.g> <xmqq5y5ltqwd.fsf_-_@gitster.g>
In-Reply-To: <xmqq5y5ltqwd.fsf_-_@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Aug 2023 14:16:09 -0400
Message-ID: <CAPig+cS7XVZNOrV4POFqOmYDvALF6_SAxs0PhvgZWe66M3TR2Q@mail.gmail.com>
Subject: Re: Re* [PATCH v3 2/2] doc: revert: add discussion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver <linusa@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 2:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH 3/2] revert: force explaining overly complex revert chain
>
> Once we revert reverts of revert and reach "Reapply "Reapply "..."",
> it becomes too unweirdly to read a reversion of such a comit.

s/unweirdly/unwieldy/
s/comit/commit/

> We instruct the user to explain why the reversion is done in their
> own words when using the revert.reference mode, and the instruction
> applies equally for such an overly complex revert chain.  The
> rationale for such a sequence of events should be recorded to help
> future developers.
>
> Building on top of the recent Oswald's work to turn "revert revert"
> into "reapply", let's turn the reference mode automatically on in
> such a case.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
