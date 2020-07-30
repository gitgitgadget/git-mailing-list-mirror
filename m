Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F43C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F6F206F5
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgG3TK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:10:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgG3TK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 15:10:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 9so6621294wmj.5
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 12:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHp9IvKTHV6XLiocg4OU7npo22W4GaP5TRKWzXiPRLY=;
        b=sip92I7QYB1yKEUK4RlCa8gDOGKQwGZ+xQF4dZ7MH4E1Kr8WuGU7xTufAM79MohHbB
         6xhiJncRL/Hd+Yy7pH0Xeh0NJxzQFmlzdp3PqmUmAJag14S54A2AnN2aIigoIdLKAzQ+
         myv7oZcZgcfyhjD7R16M8jwrnWSMNrAvp0NMWG9FZ7cE+zf0ZV+cbo4PXCubDhrLOW7+
         4axFkRLAYYcpxFV9k95tf+QyRu7e92YG0xVyYePdJs1HnJtxJuGUeURTQmoQV9/m/5CC
         GvYOqVUQV1/O3r4GmVHuvey/tfg0OsTrOv7lKHxJqF1pQwDMlnB+aX5tDnnDoCqglJXW
         8Lew==
X-Gm-Message-State: AOAM532oijNVzD4Hp9wwEi/q4kPmOZLYq32PIN49IJ57RW8NGuwNqjt5
        tghVaAo5pfpHtQNGDY+U49TRqo81wXCw6FKEtxoj07KOTBw=
X-Google-Smtp-Source: ABdhPJwpznQSHpymhlHafji6eHfu/fbjEbCa68b87+YAAD15R3KJeYoZ8Bjhs5z23hUUMPl8MdhmYiwwk9S+Z7LoH+M=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr582552wmc.130.1596136256320;
 Thu, 30 Jul 2020 12:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5za596uo.fsf@gitster.c.googlers.com> <20200730180237.1392480-1-gitster@pobox.com>
 <20200730180237.1392480-2-gitster@pobox.com>
In-Reply-To: <20200730180237.1392480-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 30 Jul 2020 15:10:45 -0400
Message-ID: <CAPig+cS=icR6PGBObChLQf5+OKbNPDvvZ62n7Y9jGnifoSUdkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "fmt-merge-msg: stop treating `master` specially"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

/On Thu, Jul 30, 2020 at 2:03 PM Junio C Hamano <gitster@pobox.com> wrote:
> This reverts commit 489947cee5095b168cbac111ff7bd1eadbbd90dd, which
> stopped treating merges into the 'master' branch any specially when

s/any specially/specially/
...or...
s/any specially/as special/

> preparing the default merge message.  As the goal was not to have
> any single branch designated as special, it solved it by leaving the
> "into <branchname>" at the end of the title of the default merge
> message for any and all branches.  An obvious and easy alternative
> to treat everybody equally could have been to remove it for every
> branch, but that involves loss of information.
>
> We'll introduce a new mechanism to let end-users specify merges into
> which branches would omit the "into <branchname>" from the title of
> the default merge message, and make the mechanism, when unconfigured,
> treat the traditional 'master' special again, so all the changes to
> the tests we made earlier will become unnecessary, as these tests
> will be run with out configuring the said new mechanism.

s/with out/without/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
