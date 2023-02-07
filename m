Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FEFC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 04:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBGEGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 23:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBGEGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 23:06:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE209778
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 20:06:02 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 96-20020a17090a09e900b00230aa6151c8so3321504pjo.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 20:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0W4l+dXVqwXnrP9qVKDSuXoA1frBg2nlVWp4NhoXgY=;
        b=T/iN84Q6zAB4SesmNA1GIxg7W8I3AgNI5cVJikgzm0OYS53Vb3JinbGowJcqPzeoxH
         chUvN1RcZnEX5PA2TZH1c9/BELyWcWTjT2M8VQMurCP8IFZv1zj7TNOCJFS1fBQkoN1g
         kTi11BG3QUerHhy4A7L8UHQtUCxuStz342fbKqeSgn5nBWT0xZVcH0/bLSeJCWfMsJ/o
         w2Jkdqx4ilp7Qn1Hm08kLBme/nGH8TgnK3/0JZdp/ELTu8kxaDYYyygUwPd77/0Rymjc
         aBUv4uZopZ8Ey61wY2u3wFlOT6H394oIMSScaZzbimEO415eg8qp0yvF+KeO0X+PM3gH
         Tj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0W4l+dXVqwXnrP9qVKDSuXoA1frBg2nlVWp4NhoXgY=;
        b=d4Dw9tsq1oEe3nDvuPybzoeT7eYTIfP7Ubme81tomxHLEYE7IuYvjcyQb+zPrvzeC4
         DONRzhFN4Bd1bf8r5tR8F3wAB3njRzAAJ8kNo1VJU+T1isWlfo+rbulPdwzy69Blt4Sq
         c2gPrNzdpIdzlKGOVKGz34ACJcbHDTLedw3lGzI8O6Lm0Puww6kreYw2Y4SCxZ46Q9z/
         ewyI6FNUBLFsnjpbThyDL1oXprQ9A/8tUcSb7eqbIWlDvZEfKV7NVLHa8IfZ4kRz218i
         TGMQVchWOj4uHJjFUbY/BnoVOt99luNcUZDcWuw2EJLHwU3LKU7yLx2Oi/UBMR7I7/8c
         p5IQ==
X-Gm-Message-State: AO0yUKUwty/MVmVw59dHWAeAyeh9RFb1oPWmnNeXr29tCMjBtnjRzxLi
        sNaKT0ExCeFdGQk2Gu7P9palQSaKgo5s4w==
X-Google-Smtp-Source: AK7set90ttKV/j1mBgRqDMHFcClcm/4P6CnaFyOtlb2+PcJJAHPHZE4lmiDogOAzsPdYJ6ykN8Vk9p+017adKQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:b04a:0:b0:4e9:f903:301a with SMTP id
 z10-20020a63b04a000000b004e9f903301amr226734pgo.103.1675742762238; Mon, 06
 Feb 2023 20:06:02 -0800 (PST)
Date:   Tue, 07 Feb 2023 12:06:00 +0800
In-Reply-To: <871qn5pyez.fsf@osv.gnss.ru>
Mime-Version: 1.0
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
Message-ID: <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: so/diff-merges-more (was Re: What's cooking in git.git (Feb 2023,
 #01; Thu, 2))
From:   Glen Choo <chooglen@google.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
>> * so/diff-merges-more (2022-12-18) 5 commits
>>  - diff-merges: improve --diff-merges documentation
>>  - diff-merges: issue warning on lone '-m' option
>>  - diff-merges: support list of values for --diff-merges
>>  - diff-merges: implement log.diffMerges-m-imply-p config
>>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>>
>>  Assorted updates to "--diff-merges=X" option.
>>
>>  May want to discard.  Breaking compatibility does not seem worth it.
>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>
> Hi Junio,
>
> This does not break any compatibility, as far as me and I believe
> reviewers of these series are aware.

My 2 cents (which maybe lines up with what Junio meant) is that this
series doesn't break compatibility on its own, but IMO the approach
doesn't make sense unless we also intend to flip the default somewhere
down the line. "log.diffMerges-m-imply-p" is a really specific config
option, and it needs to justify its addition with an outsized benefit.

I don't think it meets that bar, the only use cases I can think of are:

- Before we change the default, setting "log.diffMerges-m-imply-p=true"
  gives the 'nicer' behavior. But if the user had the permissions and
  knowledge to do so, they could just pass "-p" instead for correctness.

  If the goal is to reduce typing, then we could add a different CLI
  flag that would behave like "-m -p", or we could teach "git diff" to
  accept proper single-character flags. Either of these options would be
  more discoverable and cleaner.

- After we change the default, setting "log.diffMerges-m-imply-p=false"
  gives the old behavior, which might be needed if the user is running
  scripts written in for an older version of Git. I would find this
  compelling, but as Junio mentioned [1], breaking compatibility doesn't
  seem worth it, so this point is moot. On the other hand, neither of
  the alternative approaches break compatibility, so they're superior in
  this regard too.

- The only legitimate use case I think of is something like a script
  that uses "-m" assuming that it implied "-p", AND the user has no
  ability to modify the script. Then the user's only recourse is to set
  a config. But this is so exotic that I don't think this is a good
  enough reason to have the config.

I wouldn't mind seeing a version of these patches without
"log.diffMerges-m-imply-p=false" , but in its current form, I agree with
Junio that this isn't worth it.

[1] https://lore.kernel.org/git/xmqqbko1xv86.fsf@gitster.g/
