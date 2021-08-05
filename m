Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A18C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA0360F14
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhHEBk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHEBk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:40:26 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDFC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:40:13 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id l20so2586919iom.4
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5WyJzFG0SwXuvr/W+xpFcqLA3cHgymloNEMiBddcpw=;
        b=eLEnLQaYpYpWBzSaGYO4M3VJWkfUouqk9sS9j0W8+NsqeVequc2ZFJvraSYo513aJL
         TpwvUtxmM63T2xz7N5JVnA16gMMxsvbWAQkOFTTBqzKHutFq21qy3hpmVwuHbei+CB4X
         x/HIPytj+xRH8hIQaOrzWIyZxv2n1QYg8zsN5SOm6kC0iMO10bjgE3nPlaMzLMgq2uw0
         I8BBSBW1+g7lYcSpEem8JzIOaIOwQOCaPS/Y71nzZKFzAjqUCaqBNl5bqw++MzlYswwc
         yzFJm8bhuldgQpaew9oLocBjh267fpX7/kt+Na9YXbrnMgKRx7D9ryYtstrpz6v834tt
         tvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5WyJzFG0SwXuvr/W+xpFcqLA3cHgymloNEMiBddcpw=;
        b=MsdzbeTZ7zxoJYhx9X36AU6cdlDg4dgKjtFEWpBxHXcgTYunSbJ0vwu2Iz7en2ohxr
         B3tvZHfovH8K/MAnTRx9oxeLVyOzi+Hmshp4VboZ7afe3NE6TiL0Gm4BW8th0WHy/hXO
         z5ErwhGH0lonQ1St6wbMX/7J66zsENp5nV3FTskwyDIa//+4gu/g+nGXkNj96jROP7Zm
         JaeB9vcEAwA4fl3GUNQBfgBdP5IIy01huYUSylYgLmFHTdKgwam6EAo34+EU3zwR/Tzg
         MvDY3BakuN6keEou7GiovxaJsAOwtO7OBF4jB+h2ZpP1cAQMVHrsBSvvjEBX3+KnHfbd
         8UFw==
X-Gm-Message-State: AOAM530c14p2lmQW8gyWfbi6noThxUtWA86MvrCS87w+r+awBtSYJ/dM
        JtYt8uPbJ7q87wLb9Py7sXkumQ==
X-Google-Smtp-Source: ABdhPJwFKTt+pbNVHBRLQE8jNr0t4Zdsp2U0vUTsxyulHYV0GX38OaeMRjLQIP03LEY+7o4KgBErgQ==
X-Received: by 2002:a05:6602:1587:: with SMTP id e7mr601137iow.112.1628127612570;
        Wed, 04 Aug 2021 18:40:12 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:dd9c:1551:d5f7:652c])
        by smtp.gmail.com with ESMTPSA id k2sm2695645ior.40.2021.08.04.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:40:12 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:40:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Cameron Steffen <cam.steffen94@gmail.com>, git@vger.kernel.org
Subject: Re: git revert --continue --no-verify
Message-ID: <YQtBezRE3l09cILa@nand.local>
References: <CAAVFnNkW6Bc4bBDeea2v-VFydvEC0dBw+QXVA0-6OnmF8km3ZA@mail.gmail.com>
 <YQmsJUe6hAMy/QGA@nand.local>
 <CAAVFnN=W27rdE1EH-joscyJEooAsDrdtPropVVaBYwhte=cPJA@mail.gmail.com>
 <YQmuT2ZYe1mzHBjI@nand.local>
 <CAAVFnNmitHeimogaGUUwWGWhve+wbF6CXcSNUonGCWAgOSKzjA@mail.gmail.com>
 <YQm+PWAtc3rixqsw@nand.local>
 <74443c64-efe9-ea47-e918-d62b8c976abc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74443c64-efe9-ea47-e918-d62b8c976abc@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 04, 2021 at 07:14:34PM +0100, Phillip Wood wrote:
> [...] I wouldn't be opposed to someone adding support for --no-verify
> (and --no-edit) to "cherry-pick/revert/rebase --continue" on the
> understanding that it only applied when committing the conflict
> resolution. There is a possible confusion for users though who might
> expect that the options passed with '--continue' applied to all the
> commits made by the command.

Yeah, that feels like we are just trying to confuse the user ;). So I
agree that I'd rather not go any further along that direction.

> do_commit() does not change the flags that it is called with - callers that
> want VERIFY_MSG will set that before they call do_commit(). do_commit() is
> there to commit simple picks without forking 'git commit'
>
> > So I suspect that this is an oversight, but perhaps somebody more
> > familiar with this code could confirm my thinking.
>
> I hope the above helps - basically the idea is "if the commit has been
> edited use VERIFY_MSG" and --continue unhelpfully uses a completely
> different code-path to the main commit picking/reverting loop.

Makes sense, thanks.

Taylor
