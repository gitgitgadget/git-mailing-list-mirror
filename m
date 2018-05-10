Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175F01F406
	for <e@80x24.org>; Thu, 10 May 2018 17:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966646AbeEJRYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:24:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36109 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJRYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:24:00 -0400
Received: by mail-yb0-f193.google.com with SMTP id o14-v6so912705ybq.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5UFVWUHqQDMrjqAGJZn1lGndcFnkghOVoImeUaQ2Rko=;
        b=oYt4bnbUKBXZc8lkodkeNZgg5piRifX3nZ1NSUKRtijygA7Y5w/K0NMo1IvUkDuMvk
         0ZwQ+K6mkuGcUcibJS619V23W5/x5QdNZeyN8ISSkP4K4d+F5YPGuAham99GkDDhpKYD
         tJywf/BJLg/7tKEPCkEr4KJNoRsUuo9HgWqQcoZi8mkF9AECZejmd0iES7nsfMLu5O8S
         PJJfBcZGP8iVqngjJOpsNNhWzjJDroap/fc9SKvQ9BLMu8L9t2KAB/MtkBRyp93IKV7w
         3mQZVXdQKLVOD2ezjP49To7n+u+at+w71FDb3mQ17+jriQ4gsr8plQOdEpSQYdF3YprG
         8oTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5UFVWUHqQDMrjqAGJZn1lGndcFnkghOVoImeUaQ2Rko=;
        b=Wju8T0+cEry8WjjYXnIylvCvGGk2SgmSVDXUbLsxGy9zDGki3GgNXLzAtwQrQg8KCb
         c2vWBemhxyz/Yj6nYlsoEVVH547iSb2g2M0GsGb4L5BiDQEpG7DvyVxANKwS6Nt72nKh
         ogfNjhdWpeATAGCa46APWtLi1PLUR63zOZPEFFauBDKoM9JBQut0cmejIg1JShLQtwlr
         qCriuD1t6GMah1lbDeAegEBXURc6ECX+wY46ouymt7+hD0qcW96mz4x+3G+w4JBnDz64
         5LpVFZdkMi/WtF37cb2zrc9S2oSMU7UFV6lKROMU4LjF1ARGR9MqpCr1sblF3zvTM5BM
         b50A==
X-Gm-Message-State: ALKqPwfdqm0WAiLfZ1rte4u6GseluFlgoU+82G4plyvXPCeWQK2KVijK
        Ei4a8AwUKEm2igkX/uNtJ/NCGDeNALjExyYXMN4hZg==
X-Google-Smtp-Source: AB8JxZqhxqcwE9ImM3lh4uSxtHo5ISPBsxduSaVbM2pNMV/HAbLnJsZg0XnuoySZsr2C75E1LqjCtzyx9mgvR+9jV3M=
X-Received: by 2002:a25:dc4d:: with SMTP id y74-v6mr18384ybe.247.1525973039325;
 Thu, 10 May 2018 10:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 10:23:58
 -0700 (PDT)
In-Reply-To: <xmqqy3grizo7.fsf@gitster-ct.c.googlers.com>
References: <20180509234059.52156-1-sbeller@google.com> <xmqqy3grizo7.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 10:23:58 -0700
Message-ID: <CAGZ79ka0F9s32vxLE2TRUC4HKY=CdASVdawhSeGZ=BUu-5VWvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] object.c: free replace map in raw_object_store_clear
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, May 10, 2018 at 3:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The replace map for objects was missed to free in the object store in
>> the conversion of 174774cd519 (Merge branch 'sb/object-store-replace',
>> 2018-05-08)
>
>
> Or is this just a simple "the topic that ends at 174774cd519^2 had
> this leak that needs to be fixed by this patch; instead of rerolling
> this is an incremental, because the topic has already been merged to
> 'master' and it is too late now"?

This is the case. I wondered if I want to point to the exact commit
(which I have trouble pointing to as the whole topic has no memory
leak fixes, Closest would be d88f9fdf8b2 (replace-object: move
replace_map to object store, 2018-04-11))
or rather just point at the series. I did not think of the confusion
that might arise there.

> Looking at this patch in the context of the side branch (instead of
> in the merged result) already makes sense to me, so I am guessing it
> is the latter (i.e. not a botched merge that missed semantic
> conflicts), in which case the proposed log message is a bit too
> alarming and points readers in a wrong direction.  Shouldn't it
> point at, say, c1274495 ("replace-object: eliminate replace objects
> prepared flag", 2018-04-11) that turned the oidmap instance into a
> pointer in raw_object_store?

Ah, that is the best place to point at. Makes sense.
I'll reroll this,

Thanks,
Stefan
