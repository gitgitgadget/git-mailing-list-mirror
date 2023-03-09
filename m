Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF0C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 17:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCIRoB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 12:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjCIRnx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 12:43:53 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BF3D933
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 09:43:33 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n1-20020a170902968100b0019cf3c5728fso1409639plp.19
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678383812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSp+L5dIy8PcbMNqHW9TmFaQiAhG4i5YaK5S8avO2zg=;
        b=CGhrjKr2VOYerE+CUsfLd1TdVzGsGgPdGPf3Z0erqT228tYBgSqBfVEa4a7fNWxLt6
         Di5nY+qRLlpyH+rp6zidxIHyy0jfOS9udqyBwHSp0sdma0omwwSoAdm3fx8fggQDzK4J
         y07gT2H58H1ZOTuY2G74eQVvaT3HGfDSGyX39foFgOdHurrVdRvYfXvp7u9keFjL5V0F
         feYzuOqaTdAfnP9+Ojc/9eqlzOb9tbJ6auZLN8SWnYL5/CjaqExTOW2Nufu7y+r3RmwG
         8uLRxAnMWhTKZ1aWbqLP3f7CboCFoLoGeoV8kf1kZGuWXKfsg7ci6soGv0pz3q86xqcW
         GMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSp+L5dIy8PcbMNqHW9TmFaQiAhG4i5YaK5S8avO2zg=;
        b=OC6yh2TUXUfflG+KneCT8AQallXocY7JusTfb/IU4kRmwqdQIa3s8eZ8RPz9NsTvYL
         OzsLwbAjr3e+2KCK/+DGtODTlKzlFGWBU8u58Cc178oq4TYUd5wrXudRIgzfDsh0lTfH
         Rt8lVMdfIfW57hZwj0bRmi+NhEcRuC8NUFJUxmlDVAUKQtEDUHTHmb2nJ4YBNgcUG9U4
         77iYeUfYYLZDzmw/un50Ib6iFvLsJM105PsTcNSEk9qcDsoY0eShSYV9eMpnLdb2Rl2d
         0KkKzUo3mUd0qS88K1iKxBss3BIdwNXAZOflwmcJWef02waVq7ceXvEusMBBI0NHAlHm
         0RDQ==
X-Gm-Message-State: AO0yUKUVUuCFYuQLgNcxZQBqu/y2aElTKgROymUN62YKHnvjA8z4rKkg
        qc9lt5y1nQuW78+KiKqn57ztJuvexNlDEw==
X-Google-Smtp-Source: AK7set+bSzBqE9Zcrx4Xhkf9dPFquFA7QHAny6Gv5CdgiRmj+//q2qq266QwpRZaza8R81bvuRiYViATZBgfkw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:8c1d:0:b0:503:2535:44c3 with SMTP id
 m29-20020a638c1d000000b00503253544c3mr7786847pgd.4.1678383812651; Thu, 09 Mar
 2023 09:43:32 -0800 (PST)
Date:   Thu, 09 Mar 2023 09:43:24 -0800
In-Reply-To: <874jquxc67.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
 <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <87wn4tej2f.fsf@osv.gnss.ru> <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru> <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g> <87jzzqzy20.fsf@osv.gnss.ru>
 <xmqqzg8mrgc8.fsf@gitster.g> <874jquxc67.fsf@osv.gnss.ru>
Message-ID: <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb 2023,
 #01; Thu, 2))
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I already agreed long ago that to be on the safe side we shouldn't
> simply change -m nowadays, and addressed that concern by putting -m
> behavior change under configuration option in the current series. So
> what's the reason of rejection?

Before we start talking in circles again, I think the responses
elsewhere in the thread still accurately capture mine and Junio's views,
e.g.:

  https://lore.kernel.org/git/xmqqedr28wwb.fsf@gitster.g
  https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/
