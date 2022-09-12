Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A31ECAAD3
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 00:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiILAcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 20:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiILAce (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 20:32:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B325286
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 17:32:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso6632559pjm.5
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=AudKRzChWmFmUQYPjGZQ3/cI5a42BZnbwGe9rflVuaw=;
        b=ilbFugTmLo9FB/iR/4WkoiTS0tRd5rsmG6CagZK3VZkMIf3kVHlxdhJ56UANp8l6zI
         zT/9Ammb1fuH9WigFFEasiXwP3OrPBOr+7DVGReQjFQp6wt1N2CF2Rbf7ucHqDtOP43w
         /wrwgI4m2oLoykbnpl4G6MkaaGfUGm5kuhCzT+5reukqS9pjvWe8TNtlp2FIb67vYhtN
         3dYG2IpbqNdZ7+9YShhupitutcoBjwdo6qr33GBH6IXsKbTqyZz3mImyorKAvt4stTuk
         his9qowXtlMcNalp9HrdMaCOU2CQO/bwVu/icB72mjj7V/M7IlLE9ALfh2R9Q4K3tmCX
         bBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=AudKRzChWmFmUQYPjGZQ3/cI5a42BZnbwGe9rflVuaw=;
        b=hiCH5wow20yi3Yxtekj1gSZ3oSZN+f1mmp6L0s3oa3Lh5gItVu6io5QBnH9phJMp7i
         ux2S+M+sNOu8ZVyaniKyxPHIsqKy5tdvAxSwkdhcFtBdhdqqsQn1CcKIi7okoepCPlqC
         GOt4mQGAtnoe9hivyMESwrb//K1elqVmx5sJTp1EQX1auLXi7/jyRr4SQKOWGukyfH+4
         TCVZAl2cc0kmBwThGNP+7gMKBezTeuC22Qz4wu4ABM18Iwvjeokg7rgyuVaAXkcbUzEe
         8VZF0BGQ44/sUTWlKg2zSh+7gT0nwqfrczYonX1iu87RjwW/3EiOAhaSqKDq5lpoFE7w
         kg4A==
X-Gm-Message-State: ACgBeo2uvru7Q0T1TXrcZ2CQTp/EqQ0CDUWewB2GnZGgmS3/4i3mOGrb
        MlRLwdo9/9c15tkkkKY+aoz/z3Cc6mM=
X-Google-Smtp-Source: AA6agR5sePoIgP0vCJYcPFzdWgBn1kMyHc6AY2znyj7O1h+jOF5n4ww84JZsBFmAtzkJCYoOyeLRGQ==
X-Received: by 2002:a17:902:bf43:b0:176:e6a5:6024 with SMTP id u3-20020a170902bf4300b00176e6a56024mr24223499pls.145.1662942752440;
        Sun, 11 Sep 2022 17:32:32 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902eb8b00b001781a7c28bcsm3707548plg.237.2022.09.11.17.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:32:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2022, #02; Fri, 9)
References: <xmqq5yhwi1vw.fsf@gitster.g>
        <Yx1tnBRXJdkFQYEX@coredump.intra.peff.net>
Date:   Sun, 11 Sep 2022 17:32:31 -0700
In-Reply-To: <Yx1tnBRXJdkFQYEX@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 11 Sep 2022 01:09:48 -0400")
Message-ID: <xmqqo7vlh1pc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 09, 2022 at 04:06:27PM -0700, Junio C Hamano wrote:
>
>> [Cooking]
>> 
>> * ab/unused-annotation (2022-09-01) 2 commits
>>   (merged to 'next' on 2022-09-08 at dfc6123c6b)
>>  + git-compat-util.h: use "deprecated" for UNUSED variables
>>  + git-compat-util.h: use "UNUSED", not "UNUSED(var)"
>>  (this branch uses jk/unused-annotation.)
>> 
>>  Undoes 'jk/unused-annotation' topic and redoes it to work around
>>  Coccinelle rules misfiring false positives in unrelated codepaths.
>> 
>>  Will merge to 'master'.
>>  source: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>
>
> I just want to double-check that the plan is to merge this to master as
> noted above. I had thought you would revert jk/unused-annotation and
> that I'd just re-roll it. I'm perfectly happy with either, but just
> didn't want to add more confusion by posting that re-roll. ;)

Sorry for making a confusing move.  The thing is, the first patch in
this two-patch series builds on top of your "UNUSED(var)" thing.
Its patch text depends on "UNUSED(var)" being there, and it explains
why we ended up using the "var UNUSED" syntax over "UNUSED(var)".
It of course is the right thing to do because "UNUSED(var)" was
already in 'next' when it was written.

We could rewrite it to pretend as if "UNUSED(var)" never happened;
we prefer to keep experiments that turned out to be dead end and we
are unlikely to revisit out of our history.  But I think it makes
sense in this case to leave a record in our history that we consider
that "UNUSED(var)" is a superiour implementation that we would have
used and the only reason why we do not use it for now is Coccinelle.

So, 'next' has the merge of 'jk/unused-annotation' reverted, but when
'ab/unused-annotation' was merged, the revert was reverted ;-).
When it graduates to 'master', it will pull 'jk/unused-annotation'
along with it and keeps "UNUSED(var)" in our history, but at its
tip, what we end up using will be "var UNUSED".
